%{
This script was used to understand the relation between the target forces and the
maximum forces the participants actually apply. We perform a one-way ANOVA
analysis to determine if there is a significant difference between the means of each
force threshold group. This was done with data obtained for male and female
pain sounds and the actual gender of the participants (four combinations). This 
analysis was done with data from all participants.

Total trials per participant and pain sound gender:
3 pain sounds * 4 pitches * 4 amplitudes *4 force thresholds = 192 trials
%}
%%
clc;clear;close all;
%% Initialize

% Subject and trail number
numSubjects = 10; % even number of male and female participants
gender = "Female"; % pain sound gender
partGender = 0; % set to '0' for male and '1' for female (participant gender)
numTrials = 192;

% Participant numbers sorted by genders
maleSubjects = [2,3,4,9,10,11,14,15,18,19];
femaleSubjects = [1,5,6,7,8,12,13,16,17,20];
%% Pre-allocate buffers
bufferMaxForce = zeros(numTrials,1);
buffTrialForce = zeros(numTrials,1);
actualForce5N = [];
actualForce10N = [];
actualForce15N = [];
actualForce20N = [];
%% Main loop

for i = 1:numSubjects

    % Select subject numbers based on participant gender
    if partGender == 0
        subjectNum = maleSubjects(i);
    elseif partGender == 1
        subjectNum = femaleSubjects(i);
    end

    expData = readtable("../Raw_Experiment_Data/" + "S" + string(subjectNum) + "\" + gender + "\S"+ string(subjectNum) +" Exp T192.txt");
    forceThresh = table2array(expData(:,2));

    for j=1:numTrials

        % Force data
        forceData = readtable("../Raw_Experiment_Data/" + "S" + string(subjectNum) + "\" + gender +"\T" + string(j) + " S" + ...
            string(subjectNum) + ".txt");

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
%% Plot

numSamples = 480;
targetForces = [5,10,15,20];
total = [actualForce5N;actualForce10N;actualForce15N;actualForce20N];
labels = {'5','10','15','20'};
markerColor = [0.9290 0.6940 0.1250];
groupInx = [1.*ones(1,numSamples),2.*ones(1,numSamples),3.*ones(1,numSamples),4.*ones(1,numSamples)];

c =  [0 0.4470 0.7410;...
    00.8500 0.3250 0.0980;...
    0.9290 0.6940 0.1250;...
    0.4660 0.6740 0.1880];

% Show violin plot
hold on;
daviolinplot(total,'groups',groupInx,'box',1,'boxcolors','same','scatter',2,'jitter',1,'xtlabels', labels,'boxspacing',1, ...
    'scattersize',8,'scattercolors','same','outliers',0,'colors',c);

box on;
xlabel("Target Force (N)");
ylabel("Actual Force (N)");
xlim([0.6 4.3])
ylim([-20 270])

% Show title
if partGender == 0
    title("Male Participants on " + gender + " Pain Sounds");
else
    title("Female Participants on " + gender + " Pain Sounds");
end

%% One-way ANOVA test

total = [actualForce5N actualForce10N actualForce15N actualForce20N];
pValue = anova1(total,[],'off');

dim = [0.15 0.6 0.3 0.3];
str = "One-way ANOVA, p=" + string(pValue);
annotation('textbox',dim,'String',str,'FitBoxToText','on','EdgeColor','w');