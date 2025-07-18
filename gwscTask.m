

%1, 9, 16
cd('C:\Users\w10127315\OneDrive - The University of Southern Mississippi\Documents\GWSC_tasks\Hameed_3\PrecipAndTemp\precip_anom_2000-2020\tp\')
files = dir('*.tif') ;   % you are in the folder of files 
N = length(files);

LatitudeLimits = [-90, 90];
LongitudeLimits = [-180.125, 180.375];
lat = LatitudeLimits(1):0.25:LatitudeLimits(2);
lon = LongitudeLimits(1):0.25:LongitudeLimits(2);
latKenya = [-5.094380, 4.403514];
lonKenya = [33.832761, 41.869588];

lon(lon < lonKenya(1) | lon > lonKenya(2)) = NaN; % Study site
lat(lat < latKenya(1) | lat > latKenya(2)) = NaN;

[LON, LAT] = meshgrid(lon(1:end-1), lat(1:end-1));

for i = 1:N
    AllFileNames = string(files(i).name);
    [A,R] = readgeoraster(AllFileNames);
    A1 = A(~isnan(LAT));
    meanPrecip(i) = mean(A1);
end
figure
pcolor(LON, LAT, A)
shading flat
colormap jet
colorbar
clim([min(A(:)), max(A(:))])


cd('C:\Users\w10127315\OneDrive - The University of Southern Mississippi\Documents\GWSC_tasks\Hameed_3\PrecipAndTemp\t2m\')
files = dir('*.tif') ;   % you are in the folder of files 
N = length(files);

LatitudeLimits = [-90, 90];
LongitudeLimits = [-180.125, 180.375];
lat = LatitudeLimits(1):0.25:LatitudeLimits(2);
lon = LongitudeLimits(1):0.25:LongitudeLimits(2);
latKenya = [-5.094380, 4.403514];
lonKenya = [33.832761, 41.869588];

lon(lon < lonKenya(1) | lon > lonKenya(2)) = NaN; % Study site
lat(lat < latKenya(1) | lat > latKenya(2)) = NaN;

[LON, LAT] = meshgrid(lon(1:end-1), lat(1:end-1));

for i = 1:N
    AllFileNames = string(files(i).name);
    [A,R] = readgeoraster(AllFileNames);
    A1 = A(~isnan(LAT));
    meanTemp(i) = mean(A1);
end

figure
pcolor(LON, LAT, A)
shading flat
colormap jet
colorbar
clim([min(A(:)), max(A(:))])

x_lab = 1:12:length(meanTemp);

figure
yyaxis left
plot(meanTemp,'LineWidth', 1.5)
ylabel('Temperature (\circC)','FontSize',15)
xlabel('Month (2000 - 2020)','FontSize',15)
ylim([-1.2 1.2])
yyaxis right
plot(meanPrecip,'LineWidth', 1.5)
ylabel('Rainfall (mm)','FontSize',15)
title('Monthly Anomaly (Kenya)','FontSize',16)
xlim([1, length(meanTemp)])
xticks(1:length(meanTemp)); xticklabels(x_lab)
% xlim([1, length(meanTemp)])
%%
% Example data: 12 months
P_anom = meanPrecip(1:12);  % Precip anomaly [mm]
T_anom = meanTemp(1:12);    % Temp anomaly [°C]

% Weight factor: effect of temperature on moisture stress
alpha = 2;

% Compute proxy water balance anomaly
D = P_anom - alpha * T_anom;

% Normalize to Z-score (i.e., approximate SPEI)
D_mean = mean(D);
D_std = std(D);
SPEI_approx = (D - D_mean) / D_std;

% Plot
months = 1:12;
figure;
subplot(311)
plot(months, SPEI_approx, '-o');
xlim([1,12])
ylim([-2, 2.5])
xlabel('Month');
ylabel('Approximate SPEI');
title('SPEI Drought Index (2000)');
grid on;

% Example data: 12 months
P_anom = meanPrecip(97:108);  % Precip anomaly [mm]
T_anom = meanTemp(97:108);    % Temp anomaly [°C]

% Weight factor: effect of temperature on moisture stress
alpha = 2;

% Compute proxy water balance anomaly
D = P_anom - alpha * T_anom;

% Normalize to Z-score (i.e., approximate SPEI)
D_mean = mean(D);
D_std = std(D);
SPEI_approx = (D - D_mean) / D_std;

% Plot
months = 1:12;
subplot(312)
plot(months, SPEI_approx, '-o');
xlim([1,12])
ylim([-2, 2.5])
xlabel('Month');
ylabel('Approximate SPEI');
title('SPEI Drought Index (2008)');
grid on;

P_anom = meanPrecip(181:192);  % Precip anomaly [mm]
T_anom = meanTemp(181:192);    % Temp anomaly [°C]

% Weight factor: effect of temperature on moisture stress
alpha = 2;

% Compute proxy water balance anomaly
D = P_anom - alpha * T_anom;

% Normalize to Z-score (i.e., approximate SPEI)
D_mean = mean(D);
D_std = std(D);
SPEI_approx = (D - D_mean) / D_std;

% Plot
months = 1:12;
subplot(313)
plot(months, SPEI_approx, '-o');
xlim([1,12])
ylim([-2, 2.5])
xlabel('Month');
ylabel('Approximate SPEI');
title('SPEI Drought Index (2015)');
grid on;

