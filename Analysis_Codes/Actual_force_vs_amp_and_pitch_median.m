%{
This script was used to understand the relation between the median pitch and amplitude 
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

medianAmp5N = median(amp5N);
medianPitch5N = median(pitch5N);

medianAmp10N = median(amp10N);
medianPitch10N = median(pitch10N);

medianAmp15N = median(amp15N);
medianPitch15N = median(pitch15N);

medianAmp20N = median(amp20N);
medianPitch20N = median(pitch20N);

medianAmp = [medianAmp5N,medianAmp10N,medianAmp15N,medianAmp20N];
medianPitch = [medianPitch5N,medianPitch10N,medianPitch15N,medianPitch20N];
%% Median male pain sounds

subplot(2,1,1)
plot(targetForces,medianAmp,"Marker","o");
xlabel("Target Force (N)")
ylabel("Median Amplitude")
ylim([0.01 max(medianAmp)+0.1])

yyaxis right;
plot(targetForces,medianPitch,"Marker","o");
ylabel("Median Pitch")
ylim([0.8 max(medianPitch)+0.1])
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

medianAmp5N = median(amp5N);
medianPitch5N = median(pitch5N);

medianAmp10N = median(amp10N);
medianPitch10N = median(pitch10N);

medianAmp15N = median(amp15N);
medianPitch15N = median(pitch15N);

medianAmp20N = median(amp20N);
medianPitch20N = median(pitch20N);

medianAmp = [medianAmp5N,medianAmp10N,medianAmp15N,medianAmp20N];
medianPitch = [medianPitch5N,medianPitch10N,medianPitch15N,medianPitch20N];

%% Median female pain sounds

subplot(2,1,2)
plot(targetForces,medianAmp,"Marker","o");
xlabel("Target Force (N)")
ylabel("Median Amplitude")
ylim([0.01 max(medianAmp)+0.1])

yyaxis right;
plot(targetForces,medianPitch,"Marker","o");
ylabel("Median Pitch")
ylim([0.8 max(medianPitch)+0.1])
title("Female Pain Sounds")