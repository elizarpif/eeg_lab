function keypress_callback(src, event)
    % src: handle to the figure
    % event: structure with the event data, here it contains the key pressed

    % Retrieve the key pressed
    key = event.Key;

    switch key
        case {'add', 'equal'} % Plus key (numpad and regular)
            zoomIn(src);
        case {'subtract', 'hyphen'} % Minus key (numpad and regular)
            zoomOut(src);
        case 'uparrow'
            % Code to execute when the up arrow key is pressed
            moveUp(src);
        case 'downarrow'
            % Code to execute when the down arrow key is pressed
            moveDown(src);
        case 'rightarrow'
            % Code to execute when the down arrow key is pressed
            moveRight(src);
        case 'leftarrow'
            % Code to execute when the down arrow key is pressed
            moveLeft(src);
        case 'escape'
            % Code to close the figure when the escape key is pressed
            close(src);
        % Add more cases for other keys as needed
    end
end

function zoomIn(figHandle)
    % Zoom in function - you can customize this
    ax = findobj(figHandle, 'Type', 'axes');
    currentYLim = get(ax, 'YLim');
    set(ax, 'YLim', currentYLim .* 0.8); % Example: zoom in by 20%
end

function zoomOut(figHandle)
    % Zoom out function - you can customize this
    ax = findobj(figHandle, 'Type', 'axes');
    currentYLim = get(ax, 'YLim');
    set(ax, 'YLim', currentYLim ./ 0.8); % Example: zoom out by 20%
end


function moveLeft(figHandle)
    % Move left function
    ax = findobj(figHandle, 'Type', 'axes');
    currentXLim = get(ax, 'XLim');
    shiftAmount = diff(currentXLim) * 0.1;  % Example: shift by 10% of the current x-axis range
    set(ax, 'XLim', currentXLim - shiftAmount);
end

function moveRight(figHandle)
    % Move right function
    ax = findobj(figHandle, 'Type', 'axes');
    currentXLim = get(ax, 'XLim');
    shiftAmount = diff(currentXLim) * 0.1;  % Example: shift by 10% of the current x-axis range
    set(ax, 'XLim', currentXLim + shiftAmount);
end



function moveUp(figHandle)
    % Move up function
    ay = findobj(figHandle, 'Type', 'axes');
    currentYLim = get(ay, 'YLim');
    shiftAmount = diff(currentYLim) * 0.1;  % Example: shift by 10% of the current x-axis range
    set(ay, 'YLim', currentYLim + shiftAmount);
end

function moveDown(figHandle)
    % Move down function
    ay = findobj(figHandle, 'Type', 'axes');
    currentYLim = get(ay, 'YLim');
    shiftAmount = diff(currentYLim) * 0.1;  % Example: shift by 10% of the current x-axis range
    set(ay, 'YLim', currentYLim - shiftAmount);
end