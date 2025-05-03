h = findall(0, 'type', 'figure');
close(h);clc;clear;close all;
%% Set up GUI
fig = uifigure("Name","GUI");
panel = uipanel(fig,'Position',[100 150 250 200]);
ddAmplitude = uidropdown(fig,"Items",["Amplitude","1", "0.33", "0.11", "0.037"]);
ddPitch = uidropdown(fig,"Position",[210,100,100,22],"Items",["Pitch","0.7", "0.9", "1.1", "1.3"]);
ddSound = uidropdown(fig,"Position",[320,100,100,22],"Items",["Sound","1","2","3"]);
ddGender = uidropdown(fig,"Position",[430,100,100,22],"Items",["Gender","Male","Female"]);
button = uibutton(fig,"push","Text","Play","Position",[100 50 100 30]);

% Create plot to show audio waveform
ax = uiaxes(panel);
ax.XLabel.String = "Time (s)";
ax.YLabel.String = "Amplitude";
ax.Title.String = "Audio Waveform";
ax.XLim = [0 2];
ax.YLim = [-0.8 0.8];

% Assign callback function
button.ButtonPushedFcn = @(button,evt) callback(button,evt,ax,ddAmplitude,ddPitch,ddSound,ddGender);

%% Callback
function callback(src,~,ax,ddAmplitude,ddPitch,ddSound,ddGender)

% Audio parameters
gender = ddGender.Value;
amplitude = str2double(ddAmplitude.Value);
pitch = str2double(ddPitch.Value);
soundID = ddSound.Value;

% Import pain sound
if gender == "Male"
    [s,F] = audioread("Pain_Sounds/painsoundmale" + soundID + ".wav");
else
    [s,F] = audioread("Pain_Sounds/painsoundfemale" + soundID + ".wav");
end

% Plot the altered pain sound
s = s*amplitude;
F = F*pitch;
t = (0:length(s)-1)/F; % Create time vector
plot(ax,t, s);

sound(s,F); % Play pain sound
fprintf("Gender: %s, Sound ID: %s, Amplitude: %f, Pitch: %f\n",gender,soundID,amplitude,pitch);
end