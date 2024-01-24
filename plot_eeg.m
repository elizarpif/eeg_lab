
data = load("EEG4.mat");

eegData = data.EEG;
channelNameArray = data.channelNameArray;

eegDataT = eegData.';

plot_multichan(1:278528,eegDataT(:,:),channelNameArray);

% % Assuming your data is in the 'data' variable
% 
% % Define the range of rows to plot (1st row to 20th row)
% start_row = 1;
% end_row = 20;
% 
% % Extract the data within the specified rows
% data_to_plot = eegData(start_row:end_row, :);
% 
% % Create a time vector for x-axis (assuming time points)
% time = 1:(end_row - start_row + 1);
% 
% % Calculate the vertical offsets for each channel
% num_channels = size(data_to_plot, 2);
% vertical_offsets = linspace(0, 1, num_channels);
% 
% % Create a matrix of y-coordinates for each channel
% y_coords = repmat(vertical_offsets, numel(time), 1);
% 
% % Add the y-coordinates to the data to create separation between channels
% data_with_offsets = data_to_plot + y_coords;
% 
% % Plot the multichannel EEG data
% figure;
% plot(time, data_with_offsets);
% 
% % Add labels and title
% xlabel('Time');
% ylabel('Channel Data');
% title('Multichannel EEG Data from Row 1 to Row 20');
% grid on;
% 
% % Adjust y-axis labels to show channel numbers if needed
% set(gca, 'YTick', vertical_offsets);
% set(gca, 'YTickLabel', 1:num_channels);
% 
% % Adjust y-axis limits if necessary
% ylim([0, max(vertical_offsets) + 1]);