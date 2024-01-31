
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
eeg_data_interval = eegDataT(39, 360/Ts:370/Ts);
% 
% % Compute the power spectrum for the specified EEG data
figure(1)
pspectrum(eeg_data_interval);

% 

global amplitude_parameter;
amplitude_parameter = 10; % Initial value

choice = questdlg("Which of group of channels do you want to display?", ...
    'Channel choice', ...
    "1-30", "31-61", "all", "1-30");
if isempty(choice)
    error('The window was closed beforer it was expected.')
elseif strcmp(choice,'1-30')
    plot_m(time_vector(1:278528),eegDataT(1:30,:),channelNameArray(1:30));
elseif strcmp(choice,'31-61')
    plot_m(time_vector(1:278528),eegDataT(31:61,:),channelNameArray(31:61));
elseif strcmp(choice,'all')
    plot_m(time_vector(1:278528),eegDataT(1:61,:),channelNameArray(1:61));
end

function plot_m(x,y,channelNameArray)
    plot_multichan(x,y,channelNameArray)

    % Set the KeyPressFcn for your figure
    set(gcf, 'KeyPressFcn', @keypress_callback);

    % Define the keypress_callback as a nested function
    function keypress_callback(src, event)
        switch event.Key
            case {'add', 'equal'}
                global amplitude_parameter;
                amplitude_parameter = amplitude_parameter * 2;
                plot_multichan(x,y,channelNameArray);
            case {'subtract', 'hyphen'} % Minus key (numpad and regular)
                global amplitude_parameter;
                amplitude_parameter = amplitude_parameter / 2;
                plot_multichan(x,y,channelNameArray);
            case 'uparrow'
                ay = findobj(src, 'Type', 'axes');
                currentYLim = get(ay, 'YLim');
                shiftAmount = diff(currentYLim) * 0.1;  % Example: shift by 10% of the current x-axis range
                set(ay, 'YLim', currentYLim + shiftAmount);
            case 'downarrow'
                ay = findobj(src, 'Type', 'axes');
                currentYLim = get(ay, 'YLim');
                shiftAmount = diff(currentYLim) * 0.1;  % Example: shift by 10% of the current x-axis range
                set(ay, 'YLim', currentYLim - shiftAmount);
            case 'rightarrow'
                % Move right function
                ax = findobj(src, 'Type', 'axes');
                currentXLim = get(ax, 'XLim');
                shiftAmount = diff(currentXLim) * 0.1;  % Example: shift by 10% of the current x-axis range
                set(ax, 'XLim', currentXLim + shiftAmount);
            case 'leftarrow'
                ax = findobj(src, 'Type', 'axes');
                currentXLim = get(ax, 'XLim');
                shiftAmount = diff(currentXLim) * 0.1;  % Example: shift by 10% of the current x-axis range
                set(ax, 'XLim', currentXLim - shiftAmount);
            case 'escape'
            % Code to close the figure when the escape key is pressed
            close(src);
        end
    end

end
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