map = imread('map.jpg'); 
pix_height = size(map, 1);
pix_width = size(map, 2);

min_lat = 39.5; max_lat = 43.5;
min_lon = 69.0; max_lon = 80.0;

num_nodes = 6;
lat_space = linspace(min_lat, max_lat, num_nodes);
lon_space = linspace(min_lon, max_lon, num_nodes);

radius_deg = hypot(diff(lat_space(1:2)), diff(lon_space(1:2))) / 2;

events = [
    43.0, 75.0, 8.5, datenum('01-01-2024', 'dd-mm-yyyy');
    42.7, 74.8, 6.0, datenum('02-01-2010', 'dd-mm-yyyy'); 
    42.9, 74.6, 7.2, datenum('03-01-1973', 'dd-mm-yyyy'); 
    
    83.0, 40.0, 8.5, datenum('01-01-2024', 'dd-mm-yyyy');
    22.7, 74.8, 6.0, datenum('02-01-2010', 'dd-mm-yyyy'); 

];

for i = 1:size(events, 1)
    ex = round(pix_width * (events(i, 2) - min_lon) / (max_lon - min_lon));
    ey = round(pix_height * (1 - (events(i, 1) - min_lat) / (max_lat - min_lat)));

    figure('Name', ['Event at Lat: ' num2str(events(i, 1)) ', Lon: ' num2str(events(i, 2))], ...
           'NumberTitle', 'off', 'Position', [100, 100, 900, 600]);
    
    subplot(1, 2, 1);
    imshow(map);
    hold on;
    axis on;

    plot(ex, ey, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
    viscircles([ex, ey], radius_deg * pix_width / (max_lon - min_lon), 'EdgeColor', 'r', 'LineWidth', 1.5);

    magnitude = [];
    event_times = [];
    for k = 1:size(events, 1)
        if pdist2([events(k, 1), events(k, 2)], [events(i, 1), events(i, 2)]) <= radius_deg
            magnitude = [magnitude; events(k, 3)];
            event_times = [event_times; events(k, 4)];
        end
    end
    
    subplot(1, 2, 2);
    norm_magnitude = (magnitude - min(magnitude)) / (max(magnitude) - min(magnitude));
    color_map = [linspace(0, 1, 256)', linspace(1, 0, 256)', zeros(256, 1)];
    colors = color_map(round(norm_magnitude * 255) + 1, :);
    
    scatter(event_times, magnitude, 100, colors, 'filled');
    datetick('x', 'yyyy');
    xlabel('Date');
    ylabel('Magnitude');
    grid on;
    
    pause(1);
end
