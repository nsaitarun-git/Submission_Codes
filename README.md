# Auditory–Tactile Congruence for Synthesis of Adaptive Pain Expressions in RoboPatients

## About the Study

This repository contains the experiment codes and raw data for a study conducted to evaluate perceptual congruence between palpation and the corresponding auditory output. We conducted this study with 7680 trials across 20 participants, where they evaluated pain intensity through sound. We provide the codes used for analysis in this repository as well.

## Programming Languages 

- **MATLAB**: We used MATLAB for conducting the experiments and for recording the experiment data. Additionally, we performed some of our analysis with MATLAB.
- **Python**: We used Python for performing some of our analysis.

## Prerequisites
### MATLAB Toolboxes and Packages
- [Data Acquisition Toolbox](https://uk.mathworks.com/products/data-acquisition.html)
- [NI-DAQmx Support from Data Acquisition Toolbox](https://uk.mathworks.com/hardware-support/nidaqmx.html)
- [DSP System Toolbox](https://uk.mathworks.com/products/dsp-system.html)
- [Statistics and Machine Learning Toolbox](https://uk.mathworks.com/products/statistics.html)

## GUI for Playing Pain Sounds 
We provide a MATLAB script for playing the pain sounds used in this study. The GUI can be used to easily change the audio properties of the pain sounds. Use the GUI to select specific pain sounds, amplitude, pitch, and gender (male or female). The waveform of the generated pain sound is also shown. All the available options were used as parameters during the study. Run the ```Play_Pain_Sounds_GUI.m``` MATLAB script for the GUI.   

![Image](https://github.com/user-attachments/assets/e52e4c75-8b60-40e9-b3d7-4952aeb0d9d6)

## Generate Pain Expressions
We provide a simple MATLAB script to generate pain expressions for white male and female, which were used to display pain expressions on MorphFace. Run the ```Show_Pain_Expressions.m``` MATLAB script to generate pain expressions.

![Pain_expressions-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/0ef343fb-f6a5-44f6-8030-0403c1dbd89b)
