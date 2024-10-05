data = load("EEG3.mat");

eegData = data.EEG;
channelNameArray = data.channelNameArray;

eegDataT = eegData.';

% sampling frequency
Fs = (50/0.195221)*2;
total_duration = length(eegDataT(1,:))/Fs;
Ts = 1/Fs;
time_vector = 0:Ts:total_duration;

global amplitude_parameter;
amplitude_parameter = 10; % Initial value

% visualise the data
plot_and_keypress(time_vector(1:length(eegData)),eegDataT(:,:),channelNameArray(:));


function plot_and_keypress(x,y,channelNameArray)

plot_multichan(x,y,channelNameArray)

% Set the KeyPressFcn for your figure
set(gcf, 'KeyPressFcn', @keypress_callback);

% Define the keypress_callback as a nested function
    function keypress_callback(src, event)
        if ismember('shift', event.Modifier)
            switch event.Key

                case {'add', 'equal'}
                    % Zoom in by Y
                    ax = findobj(src, 'Type', 'axes');
                    currentYLim = get(ax, 'YLim');
                    set(ax, 'YLim', currentYLim .* 0.95); % Example: zoom in by 20%

                case {'subtract', 'hyphen'}
                    % Zoom out by Y
                    ax = findobj(src, 'Type', 'axes');
                    currentYLim = get(ax, 'YLim');
                    set(ax, 'YLim', currentYLim ./ 0.95); % Example: zoom out by 20%

                case 'rightarrow'
                    % Move right big step
                    ax = findobj(src, 'Type', 'axes');
                    currentXLim = get(ax, 'XLim');
                    shiftAmount = diff(currentXLim) * 0.8;  % Example: shift by 80% of the current x-axis range
                    set(ax, 'XLim', currentXLim + shiftAmount);

                case 'leftarrow'
                    % Move left big step
                    ax = findobj(src, 'Type', 'axes');
                    currentXLim = get(ax, 'XLim');
                    shiftAmount = diff(currentXLim) * 0.8;  % Example: shift by 80% of the current x-axis range
                    set(ax, 'XLim', currentXLim - shiftAmount);
            end
        elseif ismember('control', event.Modifier)
            switch event.Key
                case {'add', 'equal'}
                    % Zoom in by X
                    ax = findobj(src, 'Type', 'axes');
                    currentXLim = get(ax, 'XLim');
                    midpoint = mean(currentXLim);
                    updatedX = (currentXLim - midpoint) * 0.9 + midpoint;

                    set(ax, 'XLim', updatedX);

                case {'subtract', 'hyphen'}
                    % Zoom out by X
                    ax = findobj(src, 'Type', 'axes');
                    currentXLim = get(ax, 'XLim');
                    midpoint = mean(currentXLim);
                    updatedX = (currentXLim - midpoint) * 1.1 + midpoint;

                    set(ax, 'XLim', updatedX);
            end
        else
            switch event.Key
                case {'add', 'equal'}
                    % Zoom in by Y
                    global amplitude_parameter;
                    amplitude_parameter = amplitude_parameter * 1.5;

                    ax = findobj(src, 'Type', 'axes');
                    ay = findobj(src, 'Type', 'axes');

                    currentXLim = get(ax, 'XLim');
                    currentYLim = get(ay, 'YLim');

                    plot_multichan(x,y,channelNameArray);

                    set(ax, 'XLim', currentXLim, 'YLim', currentYLim/1.5);

                case {'subtract', 'hyphen'} % Minus key (numpad and regular)
                    % Zoom in by Y
                    global amplitude_parameter;
                    amplitude_parameter = amplitude_parameter / 1.5;

                    ax = findobj(src, 'Type', 'axes');
                    ay = findobj(src, 'Type', 'axes');

                    currentXLim = get(ax, 'XLim');
                    currentYLim = get(ay, 'YLim');

                    plot_multichan(x,y,channelNameArray);

                    set(ax, 'XLim', currentXLim, 'YLim', currentYLim*1.5);

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
                    close(src);
            end
        end
    end

end
