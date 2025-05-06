%{
This script was used to calculate a percentage of the participants who 
selected strongly agree + agree and strongly disagree + disagree. This help
us understand the distribution in participant opinions. This analysis was
done with data from all participants.

Total trials:
3 pain sounds * 4 pitches * 4 amplitudes *4 force thresholds * 20
participants * 2 genders = 7680 trials 

Total trials per participant and pain sound gender:
3 pain sounds * 4 pitches * 4 amplitudes *4 force thresholds = 192 trials
%}
%%
clc;clear;close all;
%% Initialise
agreeCount = 0;
disAgreeCount = 0;
trials = 192;
numSubjects = 20;
totalTrials = 7680;
%% Read data

for n=1:2
    gender = "Male";
    for i=1:numSubjects
        data = readtable("../Raw_Experiment_Data/" + "S" + string(i) + "\"+ gender + "\S" + string (i) +" Exp T192.txt");
        choices = table2array(data(:,6));

        for trial = 1:trials
            choice = choices(trial,1);

            if choice == "a" || choice == "b"
                agreeCount = agreeCount + 1;
            elseif choice == "c" || choice == "d"
                disAgreeCount = disAgreeCount + 1;
            end
        end
    end
    gender = "Female";
end

agreeProb = (agreeCount / totalTrials) * 100;
disagreeProb = 100-agreeProb;
fprintf("Agreed Response Percentage: %f\n",agreeProb);

%% Plot data

figure;
hold on;
bar(1,agreeProb)
bar(2,disagreeProb)
xlim([0 3])
xticks([1 2])
xticklabels(["      Agree + \newline Strongly Agree","      Disagree + \newline Strongly Disagree"])
text(0.9,agreeProb+2,string(round(agreeProb,4)))
text(1.9,disagreeProb+2,string(round(disagreeProb,4)))
ylabel("Percentage  (%)")
title("Total Response Percentage")