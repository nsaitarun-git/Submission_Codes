%% Clear all
clear;clc;close all;
%% Loading all 2D face images

[IM_WM_1,IM_WW_1] = loadImages;

%% Scaling, rotation of faces

[RI_WM1,RI_WW1,targetSize,ang,alpha] = rotateImages(IM_WM_1,IM_WW_1);

%% Load Prompt Images

[RI_palpate,RI_ready,RI_select,RI_calibrate] = loadPromptImages(targetSize,ang,alpha);

%% Initialise NI-USB-6211 DAQ

s = initaliseDAQ;

%% Minimum calibration

% call back function to minimum force calibration
s.ScansAvailableFcn = @(src,evt) minimum_calibration(src, evt);
start(s, "Duration", seconds(2))

while s.Running
    pause(0.5);
end
stop(s);

%% Load pain sounds

[s_1,Fs_1] = audioread('painsoundfemale1.wav');
[s_2,Fs_2] = audioread('painsoundfemale2.wav');
[s_3,Fs_3] = audioread('painsoundfemale3.wav');

%% familiarization trials

[RI,mu,subject_no,y_pain] = famTrials(RI_WW1);
%% run this to familirize with audio (play sounds)
sound(s_2 * (1/81), Fs_2); % pain level 1
%%
sound(s_1/5, Fs_1*1.0); % pain level 2
%%
sound(s_1, Fs_1*1.4); % pain level 3

%% Audio and force matrix

%number of trials
no_trials = 6;

% force values
threshold_vocal_pain = [5 10 15 20];

%parameters for plot
force_lim = threshold_vocal_pain(:,end);
x_ticks = [0 threshold_vocal_pain];

%% Counters

Trial_ID = [];
Amp_T = [];
Pitch_T = [];
trial_no = 0;

counter = 0;
v = 0;
force_counter_pilot = 0;
save_trial = 1;
save_trial_init = 2;

for i = 1:3
    save_trial_counts(i) = save_trial_init;
    save_trial_init = save_trial_init + 2;
end

%% Variables to change between breaks

%subject number
subject_no = 20;
%% Main program

close all;

for h = 1:no_trials

    force_counter_pilot = force_counter_pilot + 1;

    %assign pain sound and pain sound ID
    if h == 1 || h == 2
        pain_sound = s_1;
        pain_sound_pitch = Fs_1;
        pain_sound_label = "1";
    elseif h == 3 || h == 4
        pain_sound = s_2;
        pain_sound_pitch = Fs_2;
        pain_sound_label = "2";
    elseif h == 5 || h == 6
        pain_sound = s_3;
        pain_sound_pitch = Fs_3;
        pain_sound_label = "3";

        if h == 5
            force_counter_pilot = h - 4;
        end

        if h == 6
            force_counter_pilot = h - 4;
        end

    end

    %keep amp and pitch vars for callback fcn to work
    %amplitude '1' for pilot trials
    amplitude = 1;

    %pitch '1' for pilot trials
    pitch = 1;

    % palpation thereshold
    rand_pain_threshold = threshold_vocal_pain(force_counter_pilot);

    count = 0;
    stop_command = 0;

    X = 0; % clear search run raw data
    L = 0; % clear locate run raw data
    trial_no = trial_no + 1;

    close all;


    %set figure properties
    figure(1)
    set(gcf, 'MenuBar', 'None')
    set(gcf,'color','k');
    %set(gcf,'position',[1000 0 1920 1080])
    set(gcf,'position',[1 1 1920 1080])

    subplot(10,10,3:7);
    b_main = [0,0];
    c_main = [1,1];
    h1 = plot(b_main,c_main, 'color', 'g','LineWidth', 15);
    hold on;
    subplot(10,10,3:7);
    b_thresh = [(rand_pain_threshold - 0.1),rand_pain_threshold];
    c_thresh = [1,1];
    h4 = plot(b_thresh,c_thresh, 'color', 'g','LineWidth', 15);
    ylim([0 2])
    set(gca,'Color','k')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    xlim([0 100])
    subplot(10,10,11:90);
    h2 = imshow(RI_palpate);
    subplot(10,10,93:97);
    b_main = [0,0];
    c_main = [1,1];
    h3 = plot(b_main,c_main, 'color', 'g','LineWidth', 15);
    ylim([0 2])
    set(gca,'Color','k')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    xlim([0 100])
    %pause(2);

    % Main loop begins here

    %-----------------------------------------------------------------------------------------------
    capture.bufferSize = 30000; % raw data buffer size for search phase
    calibration.value = ref_l;
    flag_sound = 0;

    % call back function to main data recording function
    s.ScansAvailableFcn = @(src,evt) WithAudioCallback(src, evt,capture,calibration,RI,RI_palpate,y_pain,h1,h2,h3,h4,force_lim,pain_sound, pain_sound_pitch,x_ticks, rand_pain_threshold, amplitude, pitch, flag_sound);
    s.ScansAvailableFcnCount = 200; % 50 data window size (in this case 200ms as Fs = 250Hz)

    subplot(10,10,3:7);
    b_temp = [0, 0];
    set(h1,'XData', b_temp);
    set(gca,'Color','k')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    xlim([0 100])
    subplot(10,10,11:90);
    set(h2,'CData', RI_palpate);
    subplot(10,10,93:97);
    b_temp = [0, 0];
    set(h3,'XData', b_temp);
    set(gca,'Color','k')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    xlim([0 100])

    % search run starts with a beep
    sound(sin(1:3000));

    % data acquisition starts
    start(s,"Duration", seconds(3)) % search run time limit

    while s.Running
        pause(0.5);
    end

    %data acquisition stops
    stop(s);

    pause(0.1);

    %show select
    subplot(10,10,3:7);
    b_temp = [0, 0];
    set(h1,'XData', b_temp);
    set(gca,'Color','k')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    xlim([0 100])
    subplot(10,10,11:90);
    set(h2,'CData', RI_select);
    subplot(10,10,93:97);
    b_temp = [0, 0];
    set(h3,'XData', b_temp);
    set(gca,'Color','k')
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    xlim([0 100])

    %get keyboard input
    z(h) = getkey();

    %close all figures
    close all;

    %Plotting the values for initial inspection

    %ploting data during search run
    movAvg_force = dsp.MovingAverage(2);
    palpation_force = movAvg_force(X(:,2));

    % display force plot if neccessary

    % fig_3 = figure(3);
    % set(fig_3,'WindowStyle','modal');
    % set(fig_3,'WindowState','fullscreen');
    % set(gcf,'position',[0  0  1920  1080])
    % set(gcf, 'MenuBar', 'None')
    % sgtitle(['                                              trial', num2str(h)])
    %
    % plot(palpation_force,'LineWidth',2);
    % xlabel('Sample No');
    % ylabel('Palpation Force (N)');
    % title('Palpation Force');
    % ylim([0 80]);
    % grid on;
    %
    % pause(2);

    % write output to a text file (raw data)
    output_data = X;

    dir_path = ['./Raw_data_', date ,'/S',int2str(subject_no),'/Female_Pilot'];
    file_name = sprintf('T%s S%s.txt',int2str(h),int2str(subject_no));
    mkdir(dir_path);
    out = fullfile(dir_path,file_name);
    fileID = fopen(out,'w');
    fprintf(fileID,'%12s   %12s\r\n','Time','Palpation Force');
    fprintf(fileID,'%12.4f %12.2f\r\n',output_data');
    fclose(fileID);

    %write experiment variables

    Trial_ID (h,:) = string(h);
    Amp_T(h,:) = string(amplitude);
    Pitch_T(h,:) = string(pitch);
    Force_T(h,:) = string(rand_pain_threshold) ; %rand_pain_threshold
    choice(h,:)= string(char(z(1,h)));
    pain_sound_labels(h,:) = pain_sound_label;

    clear WithAudioCallback;

    if (h == no_trials )

        % Save data
        disp("Saving Data...");

        Exp_data = [Trial_ID,Force_T,pain_sound_labels, Amp_T, Pitch_T,choice];

        dir_path = ['./Raw_data_', date ,'/S',int2str(subject_no),'/Female_Pilot'];
        file_name = sprintf('S%s Exp T%s.txt',int2str(subject_no),int2str(h));
        mkdir(dir_path);
        out = fullfile(dir_path,file_name);
        fileID = fopen(out,'w');
        fprintf(fileID,'%12s %12s %12s %12s %12s %12s\r\n','Trial_No', 'F_Thresh','Pain_Sound','Amp','Pitch','Choice');
        fprintf(fileID,'%12s %12s %12s %12s %12s %12s\r\n',Exp_data.');
        fclose(fileID);

        disp("Data Saved");
    else
        pause(1);
    end

    X = [];

end

