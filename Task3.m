matrix = [6 -1 4; 
          7 2 4;
          3 2 4;];
[length, ~] = size(matrix); 

for i = 1:2:length-1
    [max_v, max_i] = max(matrix(i, :)); 
    [min_v, min_i] = min(matrix(i + 1, :)); 
    
    matrix(i, max_i) = min_v; 
    matrix(i + 1, min_i) = max_v; 
end

disp(matrix);
