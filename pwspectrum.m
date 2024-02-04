
data = load("EEG4.mat");

eegData = data.EEG;
channelNameArray = data.channelNameArray;

eegDataT = eegData.';

% 
% [pxx,w]=periodogram(eegDataT(1,:));
% 
% figure;
% plot(w,10*log10(pxx))
% 

% for i=16:20
%     figure;
%     periodogram(eegDataT(i,:))
% end

% sampling frequency
Fs = (50/0.195221)*2; 
total_duration = length(eegDataT(1,:))/Fs;
Ts = 1/Fs; 
time_vector = 0:Ts:total_duration;

% total_duration / Ts = all_time_poitns

% Extract the EEG data for the specified time interval
eeg_data_interval = eegDataT(1, 100/Ts:120/Ts);

% Compute the power spectrum for the specified EEG data
figure(1)
periodogram(eeg_data_interval);

figure(2)
pspectrum(eeg_data_interval);