regions = {
    'Chuy Region', 42.8256, 74.6210;
    'Osh Region', 40.5283, 72.7985;
    'Talas Region', 42.5183, 72.2420;
    'Naryn Region', 41.4287, 75.9910;
    'Issyk-Kul Region', 42.4708, 77.1576;
    'Batken Region', 39.9366, 70.9994;
    'Jalal-Abad Region', 41.0335, 72.9489
};

events = [
    43.0, 75.0, 8.5, datenum('01-01-2024', 'dd-mm-yyyy');  % Чуйская область
    42.7, 74.8, 6.0, datenum('02-01-2010', 'dd-mm-yyyy'); 
    42.9, 74.6, 7.2, datenum('03-01-1973', 'dd-mm-yyyy'); 
    
    40.5, 73.0, 5.5, datenum('01-01-2014', 'dd-mm-yyyy');  % Ошская область
    40.3, 72.9, 6.1, datenum('02-01-2010', 'dd-mm-yyyy'); 
    40.7, 72.8, 7.4, datenum('03-01-2020', 'dd-mm-yyyy');
    
    42.4, 72.3, 8.0, datenum('01-01-1997', 'dd-mm-yyyy');  % Таласская область
    42.5, 72.2, 6.5, datenum('02-01-1970', 'dd-mm-yyyy');
    42.6, 72.4, 7.1, datenum('03-01-2004', 'dd-mm-yyyy');
    
    41.5, 76.0, 9.0, datenum('01-01-2024', 'dd-mm-yyyy');  % Нарынская область
    41.4, 75.9, 7.8, datenum('02-01-2000', 'dd-mm-yyyy'); 
    41.6, 76.1, 8.4, datenum('03-01-1970', 'dd-mm-yyyy');
    
    42.5, 77.0, 5.0, datenum('01-01-2015', 'dd-mm-yyyy');  % Иссык-Кульская область
    42.4, 77.1, 6.2, datenum('02-01-2018', 'dd-mm-yyyy'); 
    42.6, 77.2, 7.0, datenum('03-01-2020', 'dd-mm-yyyy');
    
    40.0, 71.0, 8.5, datenum('01-01-2020', 'dd-mm-yyyy');  % Баткенская область
    39.9, 71.1, 7.5, datenum('02-01-2022', 'dd-mm-yyyy'); 
    40.1, 71.2, 6.8, datenum('03-01-2024', 'dd-mm-yyyy');
    
    41.0, 73.0, 6.5, datenum('01-01-2014', 'dd-mm-yyyy');  % Джалал-Абадская область
    41.1, 72.9, 7.0, datenum('02-01-2016', 'dd-mm-yyyy'); 
    40.9, 73.1, 8.2, datenum('03-01-2018', 'dd-mm-yyyy');
];

region_events = cell(size(regions, 1), 1);

min_date = datenum('01-01-1970', 'dd-mm-yyyy');
max_date = datenum('31-12-2024', 'dd-mm-yyyy');

for i = 1:size(events, 1)
    event_coords = events(i, 1:2); 
    region_coords = cell2mat(regions(:, 2:3));  
    distances = pdist2(region_coords, event_coords);  
    [~, region_idx] = min(distances); 
    
  
    region_events{region_idx} = [region_events{region_idx}; events(i, :)];
end


for i = 1:size(regions, 1)
    if ~isempty(region_events{i})
        sorted_data = sortrows(region_events{i}, 4);
        

        figure('Name', ['Graph for region: ' regions{i, 1}], ...
               'NumberTitle', 'off', 'Position', [100, 100, 900, 600]);
        
        plot(sorted_data(:,4), sorted_data(:,3), '-o', 'LineWidth', 1.5);
        datetick('x', 'yyyy', 'keepticks', 'keeplimits');
        
        xlim([min_date max_date]); 
        ylim([0 10]); 
        grid on; 
        

        ax = gca;
        set(ax, 'XTickMode', 'auto'); 
        xticks = get(ax, 'XTick');
        xticks = linspace(min_date, max_date, 15); 
        set(ax, 'XTick', xticks); 
        set(ax, 'XTickLabel', datestr(xticks, 'yyyy')); 

        title(['Region: ' regions{i, 1}]);
        xlabel('Date');
        ylabel('Magnitude');
    end
end
