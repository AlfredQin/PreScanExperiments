function PlotHistogram(filename)
% =========================================================================
% Analysis of noise and drift on the TIS sensor for: Range, Azimuth and 
% Elevation
%
% Author:   Erik Vermeer
% Company:  TNO Automotive, Helmond, the Netherlands.
% Date:     30 november 2006
%
% Update: Floris Leneman, 11 June 2007  - Change to function
%                                       - Rearranging without for-loop
%                                       - Drawnow to speed up displaying plot
%
% This demo plot tool is based on the simulation Experiment_3D_Scan_cs.mdl
% of TNO Automotive.
%
% Default TIS settings: #Beams              = 3
%                       Sweep rate [Hz]     = 20
%                       Beam Type           = Pencil
%                       FoV in Azimuth [deg]= 45
%                       Range [m]           = 50
%
% Default Box settings: Range Beam1 [m]     = 9.5 @ -45 deg
%                       Range Beam2 [m]     = 9.5 @   0 deg
%                       Range Beam3 [m]     = 9.5 @  45 deg
% =========================================================================

%clear all
close all
clc

% correlation calculation gives most of the time divisions by zero,
% therefore suppress warning message, and restore afterwards
s = warning('off','MATLAB:divideByZero');

% =====================================================
% Load the specific .mat file for a specific simulation
%
% Reference.mat
% NoiseSigmaRange.mat
% NoiseSigmaAzimuth.mat
% NoiseSigmaElevation.mat
% NoiseSigmaElevation.mat
% DriftSigmaAzimuth.mat
% DriftUniAzimuth.mat
% =====================================================

disp('Loading data ...')
BeamsData = load(filename);


% Settings
HistBox = 11;       % The number of boxes in the histogram plot
NumBeams = 3;


% Derived settings
NumSweeps = floor(size(BeamsData.ans,2)/NumBeams);



%===============================
% Plot the Histograms
%===============================


% Make a near full screen figure using normalized units
hf = figure('Units','normalized','Position',[0.01 0.05 1-0.02 1-0.15])


%round data
BeamsData.ans = round(1000*BeamsData.ans)/1000;

% Arrange the measurement data for each beams
NumSamples = NumSweeps*NumBeams; %ensure same vector sizes

Beam1.RangeData = BeamsData.ans(3,1:3:NumSamples);
Beam2.RangeData = BeamsData.ans(3,2:3:NumSamples);
Beam3.RangeData = BeamsData.ans(3,3:3:NumSamples);

Beam1.AziData = BeamsData.ans(4,1:3:NumSamples);
Beam2.AziData = BeamsData.ans(4,2:3:NumSamples);
Beam3.AziData = BeamsData.ans(4,3:3:NumSamples);

Beam1.ElevData = BeamsData.ans(5,1:3:NumSamples);
Beam2.ElevData = BeamsData.ans(5,2:3:NumSamples);
Beam3.ElevData = BeamsData.ans(5,3:3:NumSamples);

% ======================================================================
% Plot the Histogram boxes for Beam 1
% ======================================================================

subplot('Position',[0.1 0.7 0.25 0.125]), hist(Beam1.RangeData,HistBox),...
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('Range [m]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam1.RangeData))/100;
    stdev = round(100*std(Beam1.RangeData))/100;
    annotation111 = annotation(...
     'textbox',...
     'Position',[0.1 0.825 0.2 0],...
     'String',{['Ref = 9.5'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');
 
subplot('Position',[0.4 0.7 0.25 0.125]), hist(Beam1.AziData,HistBox)
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('\theta [deg]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam1.AziData))/100;
    stdev = round(100*std(Beam1.AziData))/100;
    annotation2 = annotation(...
     'textbox',...
     'Position',[0.4 0.825 0.2 0],...
     'String',{['Ref = -45'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');
 
subplot('Position',[0.7 0.7 0.25 0.125]), hist(Beam1.ElevData,HistBox)
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('\phi [deg]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam1.ElevData))/100;
    stdev = round(100*std(Beam1.ElevData))/100;
    annotation3 = annotation(...
     'textbox',...
     'Position',[0.7 0.825 0.2 0],...
     'String',{['Ref = 0'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');
 
     
% ======================================================================= 
% Plot the Histogram boxes for Beam 2
% =======================================================================

subplot('Position',[0.1 0.5 0.25 0.125]), hist(Beam2.RangeData,HistBox),...
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('Range [m]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam2.RangeData))/100;
    stdev = round(100*std(Beam2.RangeData))/100;
    annotation111 = annotation(...
     'textbox',...
     'Position',[0.1 0.625 0.2 0],...
     'String',{['Ref = 9.5'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');
 
subplot('Position',[0.4 0.5 0.25 0.125]), hist(Beam2.AziData,HistBox)
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('\theta [deg]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam2.AziData))/100;
    stdev = round(100*std(Beam2.AziData))/100;
    annotation2 = annotation(...
     'textbox',...
     'Position',[0.4 0.625 0.2 0],...
     'String',{['Ref = 0'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');
 
subplot('Position',[0.7 0.5 0.25 0.125]), hist(Beam2.ElevData,HistBox)
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('\phi [deg]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam2.ElevData))/100;
    stdev = round(100*std(Beam2.ElevData))/100;
    annotation3 = annotation(...
     'textbox',...
     'Position',[0.7 0.625 0.2 0],...
     'String',{['Ref = 0'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');

 
% ========================================================================
% Plot the Histogram boxes for Beam 3
% ========================================================================

subplot('Position',[0.1 0.3 0.25 0.125]), hist(Beam3.RangeData,HistBox),...
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('Range [m]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam3.RangeData))/100;
    stdev = round(100*std(Beam3.RangeData))/100;
    annotation111 = annotation(...
     'textbox',...
     'Position',[0.1 0.425 0.2 0],...
     'String',{['Ref = 9.5'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');
 
subplot('Position',[0.4 0.3 0.25 0.125]), hist(Beam3.AziData,HistBox)
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('\theta [deg]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam3.AziData))/100;
    stdev = round(100*std(Beam3.AziData))/100;
    annotation2 = annotation(...
     'textbox',...
     'Position',[0.4 0.425 0.2 0],...
     'String',{['Ref = 45'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');
 
subplot('Position',[0.7 0.3 0.25 0.125]), hist(Beam3.ElevData,HistBox)
    set(findobj(gca,'Type','patch'),'FaceColor','r')
    title('Histogram')
    xlabel('\phi [deg]')
    % Calculate the mean (mu) and the standard deviation (stdev)
    mu  = round(100*mean(Beam3.ElevData))/100;
    stdev = round(100*std(Beam3.ElevData))/100;
    annotation3 = annotation(...
     'textbox',...
     'Position',[0.7 0.425 0.2 0],...
     'String',{['Ref = 0'],['\mu = ',num2str(mu)],...
     ['\sigma = ',num2str(stdev)]},...
     'LineStyle','none',...
     'FitHeightToText','on');


 
% =========================================================================
% Calculate and plot the auto- and cross- correlation functions
% =========================================================================

disp('Calculating Correlation...')
% Arrange the data of each beam for the total simulation data
RangeCorr(:,1) = Beam1.RangeData;
RangeCorr(:,2) = Beam2.RangeData;
RangeCorr(:,3) = Beam3.RangeData;

% Calculate correlation function matrix (auto and cross correlation)
[r.RangeCorr,p.RangeCorr] = corrcoef(RangeCorr);

% Arrange the data of each beam for the total simulation data
AziCorr(:,1) = Beam1.AziData;
AziCorr(:,2) = Beam2.AziData;
AziCorr(:,3) = Beam3.AziData;

% Calculate correlation function matrix (auto and cross correlation)
[r.AziCorr,p.AziCorr] = corrcoef(AziCorr);

% Arrange the data of each beam for the total simulation data
ElevCorr(:,1) = Beam1.ElevData;
ElevCorr(:,2) = Beam2.ElevData;
ElevCorr(:,3) = Beam3.ElevData;

% Calculate correlation function matrix (auto and cross correlation)
[r.ElevCorr,p.ElevCorr] = corrcoef(ElevCorr); 


% Plot the Correlation Matrix for the Range
disp('Plotting figure ...')

for jj = 1:3
    for mm = 1:3
        Corr=round(100*(r.RangeCorr(mm,jj)))/100;
        annotation(...
            'textbox',...
            'Position',[0.125+0.05*mm 0.1725-0.025*jj 0.05 0.05],...
            'String',{num2str(Corr)},...
            'LineStyle','none',...
            'FitHeightToText','on');
    end
        annotation(...
            'textbox',...
            'Position',[0.1 0.1725-0.025*jj 0.05 0.05],...
            'String',{['Beam ',num2str(jj)]},...
            'LineStyle','none',...
            'FitHeightToText','on');
        annotation(...
            'textbox',...
            'Position',[0.125+0.05*jj 0.1725 0.05 0.05],...
            'String',{['Beam ',num2str(jj)]},...
            'LineStyle','none',...
            'FitHeightToText','on');
end


% Plot the Correlation Matrix for the Azimuth angle

for jj = 1:3
    for mm = 1:3
        Corr=round(100*(r.AziCorr(mm,jj)))/100;
        annotation(...
            'textbox',...
            'Position',[0.425+0.05*mm 0.1725-0.025*jj 0.05 0.05],...
            'String',{num2str(Corr)},...
            'LineStyle','none',...
            'FitHeightToText','on');
    end
        annotation(...
            'textbox',...
            'Position',[0.4 0.1725-0.025*jj 0.05 0.05],...
            'String',{['Beam ',num2str(jj)]},...
            'LineStyle','none',...
            'FitHeightToText','on');
        annotation(...
            'textbox',...
            'Position',[0.425+0.05*jj 0.1725 0.05 0.05],...
            'String',{['Beam ',num2str(jj)]},...
            'LineStyle','none',...
            'FitHeightToText','on');
end


% Plot the Correlation Matrix for the Elevation angle

for jj = 1:3
    for mm = 1:3
        Corr=round(100*(r.ElevCorr(mm,jj)))/100;
        annotation(...
            'textbox',...
            'Position',[0.725+0.05*mm 0.1725-0.025*jj 0.05 0.05],...
            'String',{num2str(Corr)},...
            'LineStyle','none',...
            'FitHeightToText','on');
    end
        annotation(...
            'textbox',...
            'Position',[0.7 0.1725-0.025*jj 0.05 0.05],...
            'String',{['Beam ',num2str(jj)]},...
            'LineStyle','none',...
            'FitHeightToText','on');
        annotation(...
            'textbox',...
            'Position',[0.725+0.05*jj 0.1725 0.05 0.05],...
            'String',{['Beam ',num2str(jj)]},...
            'LineStyle','none',...
            'FitHeightToText','on');
end



% =========================================================================
% Add texboxes for of the simulation settings
% =========================================================================

annotation(...
  'textbox',...
  'Position',[0.89 0.0 0.1 0.03],...
  'FontSize',10,...
  'LineStyle','none',...
  'String',{['Nr. of samples: ', num2str(NumSweeps)]},...
  'FitHeightToText','on');

annotation(...
  'textbox',...
  'Position',[0.2 0.7 0.1 0.2],...
  'FontSize',16,...
  'FontWeight','bold',...
  'LineStyle','none',...
  'String',{['R']},...
  'FitHeightToText','on');


annotation(...
  'textbox',...
  'Position',[0.5 0.7 0.1 0.2],...
  'FontSize',16,...
  'FontWeight','bold',...
  'LineStyle','none',...
  'String',{['\theta']},...
  'FitHeightToText','on');


annotation(...
  'textbox',...
  'Position',[0.8 0.7 0.1 0.2],...
  'FontSize',16,...
  'FontWeight','bold',...
  'LineStyle','none',...
  'String',{['\phi']},...
  'FitHeightToText','on');



% =================================================================
% Indicate beam numders and Correlation in the figure
% =================================================================

annotation(...
  'textbox',...
  'Position',[0 0.675 0.05 0.1],...
  'FontSize',10,...
  'FontWeight','bold',...
  'LineStyle','none',...
  'String',{'Beam 1'},...
  'FitHeightToText','on');

annotation(...
  'textbox',...
  'Position',[0 0.475 0.05 0.1],...
  'FontSize',10,...
  'FontWeight','bold',...
  'LineStyle','none',...
  'String',{'Beam 2'},...
  'FitHeightToText','on');

annotation(...
  'textbox',...
  'Position',[0 0.275 0.05 0.1],...
  'FontSize',10,...
  'FontWeight','bold',...
  'LineStyle','none',...
  'String',{'Beam 3'},...
  'FitHeightToText','on');

annotation(...
  'textbox',...
  'Position',[0 0.125 0.05 0.1],...
  'LineStyle','none',...
  'FontSize',10,...
  'FontWeight','bold',...
  'String',{['Corr.']},...
  'FitHeightToText','on');


% =========================================================================
% Create and plot the division lines in the figure
% =========================================================================

annotation('line',[0 1],[0.85 0.85]);
annotation('line',[0 1],[0.65 0.65]);
annotation('line',[0 1],[0.45 0.45]);
annotation('line',[0 1],[0.25 0.25]);
annotation('line',[0.37 0.37],[1 0]);
annotation('line',[0.67 0.67],[1 0]);
annotation('line',[0.07 0.07],[1 0]);

% flush drawing commands to speed up drawing
drawnow

warning(s);


%saveas(hf,[filename '.png']);
