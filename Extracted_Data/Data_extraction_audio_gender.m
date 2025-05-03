% READ THE FOLLOWING TEXT PLEASE!
% The data extraced from the raw data is only for trials which the
% particpants agreed with the pain sounds they heard.
% We store the corresponding pitch, amplitude, target force and maximum
% palpation force applied by the particpants.
% In this script the data is seperated based on male and female pain sounds
% played during the experiment, extracted data is across all trials and
% particpants.

%%
clc;clear;close all;
%% Read Data

% Subject and trail number
numSubjects = 20;
%gender = "Male";
gender = "Female";
numTrials = 192;
totalTrials = numTrials * numSubjects;

% Pre-allocate buffers
bufferMaxForce = zeros(numTrials,1);
buffTrialForce = zeros(numTrials,1);

% buffers for maximum force the participants applied for target forces
actualForce5N = [];
actualForce10N = [];
actualForce15N = [];
actualForce20N = [];

% buffers for amplitudes and pitch at target force
amplitude5N = [];
amplitude10N = [];
amplitude15N = [];
amplitude20N = [];
pitch5N = [];
pitch10N = [];
pitch15N = [];
pitch20N = [];
painSounds5N= [];
painSounds10N= [];
painSounds15N= [];
painSounds20N= [];
%% Main loop

disp("Extracting "+ gender +" pain sound data...")

for j = 1:numSubjects

    % read experiment data of each participant
    expData = readtable("../S" + string(j) + "\" + gender + "\S"+ string(j) +" Exp T192.txt");
    forceThresh = table2array(expData(:,2));
    painSounds = table2array(expData(:,3));
    amplitude = table2array(expData(:,4));
    pitch = table2array(expData(:,5));
    choices = table2array(expData(:,6));

    for k=1:numTrials

        % read amplitude and pitch of agreed combination
        if choices(k) == "a" || choices(k) == "b"

            % force data
            forceData = readtable("../S" + string(j) + "\" + gender +"\T" + string(k) + " S" + ...
                string(j) + ".txt");

            forceData = table2array(forceData(:,2));

            % each trial amplitude,pitch and pain sound
            trialAmplitude = amplitude(k);
            trialPitch = pitch(k);
            trialPS = painSounds(k);

            % maximum force
            maxForce = max(forceData);

            % force threshold for trial
            forceThreshTrial = forceThresh(k,1);

            % store values according to target force levels
            if forceThreshTrial == 5
                actualForce5N = [actualForce5N;maxForce];
                amplitude5N = [amplitude5N;trialAmplitude];
                pitch5N = [pitch5N;trialPitch];
                painSounds5N= [painSounds5N;trialPS];
            elseif forceThreshTrial == 10
                actualForce10N = [actualForce10N;maxForce];
                amplitude10N = [amplitude10N;trialAmplitude];
                pitch10N = [pitch10N;trialPitch];
                painSounds10N= [painSounds10N;trialPS];
            elseif forceThreshTrial == 15
                actualForce15N = [actualForce15N;maxForce];
                amplitude15N = [amplitude15N;trialAmplitude];
                pitch15N = [pitch15N;trialPitch];
                painSounds15N= [painSounds15N;trialPS];
            elseif forceThreshTrial == 20
                actualForce20N = [actualForce20N;maxForce];
                amplitude20N = [amplitude20N;trialAmplitude];
                pitch20N = [pitch20N;trialPitch];
                painSounds20N= [painSounds20N;trialPS];
            end
        end
    end
end

disp("Extraction complete.")
%% Store and save extracted data (run this block for male pain sound only)

% store actual palpation force maximum values across all trials
dataMPS.actForce5N = actualForce5N;
dataMPS.actForce10N = actualForce10N;
dataMPS.actForce15N = actualForce15N;
dataMPS.actForce20N = actualForce20N;

% store amplitude values across all trials
dataMPS.ampForce5N = amplitude5N;
dataMPS.ampForce10N = amplitude10N;
dataMPS.ampForce15N = amplitude15N;
dataMPS.ampForce20N = amplitude20N;

% store pitch values across all trials
dataMPS.pitchForce5N = pitch5N;
dataMPS.pitchForce10N = pitch10N;
dataMPS.pitchForce15N = pitch15N;
dataMPS.pitchForce20N = pitch20N;

% store pain sound ID across all trials
dataMPS.painSound5N = painSounds5N;
dataMPS.painSound10N = painSounds10N;
dataMPS.painSound15N = painSounds15N;
dataMPS.painSound20N = painSounds20N;

save("extDataMPS.mat","dataMPS")
disp("Saved "+ gender +" pain sound data.")

%% Store and save extracted data (run this block for female pain sound only)

% store actual palpation force maximum values across all trials
dataFPS.actForce5N = actualForce5N;
dataFPS.actForce10N = actualForce10N;
dataFPS.actForce15N = actualForce15N;
dataFPS.actForce20N = actualForce20N;

% store amplitude values across all trials
dataFPS.ampForce5N = amplitude5N;
dataFPS.ampForce10N = amplitude10N;
dataFPS.ampForce15N = amplitude15N;
dataFPS.ampForce20N = amplitude20N;

% store pitch values across all trials
dataFPS.pitchForce5N = pitch5N;
dataFPS.pitchForce10N = pitch10N;
dataFPS.pitchForce15N = pitch15N;
dataFPS.pitchForce20N = pitch20N;

% store pain sound ID across all trials
dataFPS.painSound5N = painSounds5N;
dataFPS.painSound10N = painSounds10N;
dataFPS.painSound15N = painSounds15N;
dataFPS.painSound20N = painSounds20N;

save("extDataFPS.mat","dataFPS")
disp("Saved "+ gender +" pain sound data.")