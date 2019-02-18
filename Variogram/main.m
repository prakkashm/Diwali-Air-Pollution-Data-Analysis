cd 'F:/Logs/S_5 (M-2018)/Honors/Evaluation - 2/Work/Variogram Codes (Matlab)'

%{
data = xlsread('../data1.xlsx')
plot(data(:,1),data(:,2),'.')

xq = data(:,1);                                           % Random X-Coordinates
yq = data(:,2);                                           % Random Y-Coordinates
[pind,xcoord,ycoord] = selectdata('selectionmode','lasso')
selected_gold_grade = data(pind,3)
%}
%figure(1)
%plot(xq, yq, '.', 'col', 'b')
%hold on
%plot(xcoord, ycoord, '.', 'col', 'g')
%hold off

%{
CM = jet(6);
%figure(1)
for i=15:15:90
    [lv, gv] = variogram(xcoord, ycoord, selected_gold_grade, 153, 0, 3, 90, i, 1000000)
    %[lh, gh] = variogram(xcoord, ycoord, selected_gold_grade, 153, 0, 3, 0, 45, 1000000)
    plot(lv, gv, 'color', CM((i/15),:))
    if(i==15)
        hold on
    end
end;

legend({'15°'; '30°'; '45°'; '60°'; '75°'; '90°'})
%plot(lh, gh, 'col', 'r')
hold off
%}

%[lvariogram, gvariogram] = variogram(xcoord, ycoord, selected_gold_grade, 153, 0, 3, 90, 45, 1000000)
%plot(lvariogram, gvariogram)

var = xlsread('../df.xlsx')
min=+inf
%{
for c0=0:0.001:0.06
    for sill=0.05:0.001:0.1
        for a=50:5:300
%}
for c0=0:0.005:0.1
    for sill=0:0.005:0.15
        for a=50:5:300
            idealvariogram = myvarifit(c0, sill, a, 1, var(:, 1))
            tmp = (idealvariogram' - var(:, 2)).^2
            rmse = sqrt(nanmean(tmp(1:133,:)))
            if(rmse < min)
                min = rmse
                bestpar = [c0; sill; a]                      % 0, 0.074, 50
            end;    
        end;
    end;
end;

idealvariogram = myvarifit(bestpar(1), bestpar(2), bestpar(3), 1, var(:, 1))
plot(var(:, 1), var(:, 2), 'x')
hold on
plot(var(:, 1), idealvariogram, 'col', 'r')
hold off



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{

%{
data2 = xlsread('../data3.xlsx')
%plot(data2(:,2),data2(:,1),'.')
for i=0.001:0.001:0.04
    tmp = data2(:,[1:3])
    tmp(any(isnan(tmp), 2), :) = [];
    [lvariogram, gvariogram] = myvariogram(tmp(:,1), tmp(:,2), tmp(:,3), .45/i, 0, i, 90, 45, 1000000)
    var = [lvariogram; gvariogram]'
    ind = isnan(var(:,2))
    var(ind,:) = []
    figure(1)
    plot(var(:,1), var(:,2), 'x')
    title(i)
    pause(3)
end;
hold off;
%}

var = xlsread('../df.xlsx')
min=+inf
for c0=0:50:1200
    for sill=500:50:1500
        for a=0.1:0.001:0.25
            idealvariogram = myvarifit(c0, sill, a, 1, var(:, 1))
            tmp = (idealvariogram' - var(:, 2)).^2
            rmse = sqrt(nanmean(tmp))
            if(rmse < min)
                min = rmse
                bestpar = [c0; sill; a]             % 0, 1100, 0.135
            end;    
        end;
    end;
end;

%bestpar = [0; 1100; 0.135]
idealvariogram = myvarifit(bestpar(1), bestpar(2), bestpar(3), 1, var(:, 1))
plot(var(:, 1), var(:, 2), 'x')
hold on
plot(var(:, 1), idealvariogram, 'col', 'r')
%ylim([0 300])
hold off
%}
