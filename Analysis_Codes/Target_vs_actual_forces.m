%{
This script was used to understand the relation between the target forces and the
maximum forces the participants actually apply. We perform a one-way ANOVA
analysis to determine if there is a significant difference between the means of each
force threshold group. This was done with data obtained for male and female
pain sounds. This analysis was done with data from all participants.

Trials per force threshold: 
3 pain sounds * 4 pitches * 4 amplitudes * 20 participants = 960 trials
per force value and one gender 

Total trials:
3 pain sounds * 4 pitches * 4 amplitudes *4 force thresholds * 20
participants * 2 genders = 7680 trials 
%}
%%
clc;clear;close all;
%% Initialize

% Subject and trail number
numSamples = 960;
numSubjects = 20;
gender = "Male";
%gender = "Female";
numTrials = 192;

% Pre-allocate buffers
bufferMaxForce = zeros(numTrials,1);
buffTrialForce = zeros(numTrials,1);
actualForce5N = [];
actualForce10N = [];
actualForce15N = [];
actualForce20N = [];
%% Main loop

for i = 1:numSubjects

    expData = readtable("../Raw_Experiment_Data/" + "S" + string(i) + "\" + gender + "\S"+ string(i) +" Exp T192.txt");
    forceThresh = table2array(expData(:,2));

    for j=1:numTrials

        % Force data
        forceData = readtable("../Raw_Experiment_Data/" + "S" + string(i) + "\" + gender +"\T" + string(j) + " S" + ...
            string(i) + ".txt");

        forceData = table2array(forceData(:,2));

        % Max force
        maxForce = max(forceData);

        % Force thresh for trial
        forceThreshTrial = forceThresh(j,1);

        if forceThreshTrial == 5
            actualForce5N = [actualForce5N;maxForce];
        elseif forceThreshTrial == 10
            actualForce10N = [actualForce10N;maxForce];
        elseif forceThreshTrial == 15
            actualForce15N = [actualForce15N;maxForce];
        elseif forceThreshTrial == 20
            actualForce20N = [actualForce20N;maxForce];
        end
    end
end
%% Plot data

targetForces = [5,10,15,20];
total = [actualForce5N;actualForce10N;actualForce15N;actualForce20N];
labels = {'5','10','15','20'};
markerColor = [0.9290 0.6940 0.1250];
groupInx = [1.*ones(1,numSamples),2.*ones(1,numSamples),3.*ones(1,numSamples),4.*ones(1,numSamples)];

% Box plot colours
c =  [0 0.4470 0.7410;...
    0.8500 0.3250 0.0980;...
    0.9290 0.6940 0.1250;...
    0.4660 0.6740 0.1880];

% Show boxplot
hold on;
daviolinplot(total,'groups',groupInx,'box',1,'boxcolors','same','scatter',2,'jitter',1,'xtlabels', labels,'boxspacing',1, ...
    'scattersize',8,'scattercolors','same','outliers',0,'colors',c);

box on;
xlabel("Target Force (N)");
ylabel("Actual Force (N)");
title(gender + " Pain Sounds");
xlim([0.6 4.3])
ylim([-20 270])

%% ANOVA
total = [actualForce5N actualForce10N actualForce15N actualForce20N];
pValue = anova1(total,[],"off");

dim = [0.15 0.6 0.3 0.3];
str = "One-way ANOVA, p=" + string(pValue);
annotation('textbox',dim,'String',str,'FitBoxToText','on','EdgeColor','w');