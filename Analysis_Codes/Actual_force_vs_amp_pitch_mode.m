%{
This script was used to understand the relation between the mode pitch and amplitude 
values with respect to the target force the participants had to reach. This
analysis was done for male and female pain sounds. We used the extracted
data for only the trials which the participants strongly agreed and agreed with 
combination of the audio they heard. This analysis was done with data from all participants.
%}
%%
clc; clear; close all;
%% Read extracted data
load("../Extracted_Data/extDataMPS.mat")
%% Sort data Male Pain Sounds
targetForces = [5,10,15,20];

amp5N = dataMPS.ampForce5N;
amp10N = dataMPS.ampForce10N;
amp15N = dataMPS.ampForce15N;
amp20N = dataMPS.ampForce20N;

pitch5N = dataMPS.pitchForce5N;
pitch10N = dataMPS.pitchForce10N;
pitch15N = dataMPS.pitchForce15N;
pitch20N = dataMPS.pitchForce20N;

%% Find meadian values

modeAmp5N = mode(amp5N);
modePitch5N = mode(pitch5N);

modeAmp10N = mode(amp10N);
modePitch10N = mode(pitch10N);

modeAmp15N = mode(amp15N);
modePitch15N = mode(pitch15N);

modeAmp20N = mode(amp20N);
modePitch20N = mode(pitch20N);

modeAmp = [modeAmp5N,modeAmp10N,modeAmp15N,modeAmp20N];
modePitch = [modePitch5N,modePitch10N,modePitch15N,modePitch20N];
%% Mode male pain sounds

subplot(2,1,1)
plot(targetForces,modeAmp,"Marker","o");
xlabel("Target Force (N)")
ylabel("Mode Amplitude")
ylim([0.01 max(modeAmp)+0.1])

yyaxis right;
plot(targetForces,modePitch,"Marker","o");
ylabel("Mode Pitch")
ylim([0.8 max(modePitch)+0.1])
title("Male Pain Sounds")
%% Read extracted data
load("../Extracted_Data/extDataFPS.mat")
%% Sort data female Pain Sounds

amp5N = dataFPS.ampForce5N;
amp10N = dataFPS.ampForce10N;
amp15N = dataFPS.ampForce15N;
amp20N = dataFPS.ampForce20N;

pitch5N = dataFPS.pitchForce5N;
pitch10N = dataFPS.pitchForce10N;
pitch15N = dataFPS.pitchForce15N;
pitch20N = dataFPS.pitchForce20N;
%% Find meadian values

modeAmp5N = mode(amp5N);
modePitch5N = mode(pitch5N);

modeAmp10N = mode(amp10N);
modePitch10N = mode(pitch10N);

modeAmp15N = mode(amp15N);
modePitch15N = mode(pitch15N);

modeAmp20N = mode(amp20N);
modePitch20N = mode(pitch20N);

modeAmp = [modeAmp5N,modeAmp10N,modeAmp15N,modeAmp20N];
modePitch = [modePitch5N,modePitch10N,modePitch15N,modePitch20N];

%% Mode female pain sounds

subplot(2,1,2)
plot(targetForces,modeAmp,"Marker","o");
xlabel("Target Force (N)")
ylabel("Mode Amplitude")
ylim([0.01 max(modeAmp)+0.1])

yyaxis right;
plot(targetForces,modePitch,"Marker","o");
ylabel("Mode Pitch")
ylim([0.8 max(modePitch)+0.1])
title("Female Pain Sounds")