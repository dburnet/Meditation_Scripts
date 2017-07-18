% Script for extracting power in each frequency range from EEG data block
% with rows being the time course and columns being the electrode axis.
% Have not checked to see if this works yet.
%
% From: https://emotiv.com/forum/forum4/topic18214/messages/
%   Posted by: GMAC Administrator @ emotiv
%
% Assumes: 128 Hz Sampling Freq; matrix has EEG data only; no data
% corrections!
%
% MDTeeglab
% 2016.01.18
function AIS = me_AlphaThetaRatioAllSessions(filename)
file.name = filename;
if regexp(filename,'set$')
    EEG2 = pop_loadset(filename);
    %     elseif regexp(filename,'edf$')
    %         EEG2 = pop_biosig(filename);
else
    error('ge_handContraction: File type unknown');
end
EEG2 = EEG2.data';
fftlength  = 256;                      % make the window for sample length fftlength
hanning    = [1:fftlength]';
hanning_in = 2*pi*(hanning - (fftlength+1)/2)/(fftlength+1); % rescaled x-axis to match sample length
hanning    = (sin(hanning_in)./hanning_in).^2;               % sinc^2
hanning    = repmat(hanning, 1, 14);   % match to number of channels

f = [128/fftlength:128/fftlength:128]; % frequency index for the spectral array

thetaIndex    = find(f>=4 & f<8);
alphaIndex    = find(f>=8 & f<12);
lowBetaIndex  = find(f>=12 & f<16);
highBetaIndex = find(f>=16 & f<25);
gammaIndex    = find(f>=25 & f<40);
totIndex      = find(f>=4 & f<=40);
outdata       = [];

eeg.theta    = [];
eeg.alpha    = [];
eeg.lowBeta  = [];
eeg.highBeta = [];
eeg.gamma    = [];
eeg.tot      = [];
eeg.totmed   = [];

% Main loop!

for k = fftlength:32:size(EEG2,1)                            % step through every quarter second starting at first possible sample
    spectrum     = fft(EEG2(k-fftlength+1:k,:) .* hanning);  % apply window to HP filtered data
    spectrum     = sqrt(spectrum .* conj(spectrum));             % get magnitude
    eeg.theta    = [eeg.theta; k sum(spectrum(thetaIndex,:))];   % append total spectral power in band, including sample index k
    eeg.alpha    = [eeg.alpha; k sum(spectrum(alphaIndex,:))];
    eeg.lowBeta  = [eeg.lowBeta; k sum(spectrum(lowBetaIndex,:))];
    eeg.highBeta = [eeg.highBeta; k sum(spectrum(highBetaIndex,:))];
    eeg.gamma    = [eeg.gamma; k sum(spectrum(gammaIndex,:))];
    eeg.tot      = [eeg.tot; k sum(spectrum(totIndex,:))];
end
filelength = size(EEG2);
filelengthsecs = ((filelength(1))/128);
timeRange = 1:filelengthsecs;
% PLOT
electrode1 = eeg.alpha(:,2)./eeg.theta(:,2);
electrode2 = eeg.alpha(:,3)./eeg.theta(:,3);
electrode3 = eeg.alpha(:,4)./eeg.theta(:,4);
electrode4 = eeg.alpha(:,5)./eeg.theta(:,5);
electrode5 = eeg.alpha(:,6)./eeg.theta(:,6);
electrode6 = eeg.alpha(:,7)./eeg.theta(:,7);
electrode7 = eeg.alpha(:,8)./eeg.theta(:,8);
electrode8 = eeg.alpha(:,9)./eeg.theta(:,9);
electrode9 = eeg.alpha(:,10)./eeg.theta(:,10);
electrode10 = eeg.alpha(:,11)./eeg.theta(:,11);
electrode11 = eeg.alpha(:,12)./eeg.theta(:,12);
electrode12 = eeg.alpha(:,13)./eeg.theta(:,13);
electrode13 = eeg.alpha(:,14)./eeg.theta(:,14);
electrode14 = eeg.alpha(:,15)./eeg.theta(:,15);


plot(eeg.alpha(timeRange,1), electrode1(timeRange), '-k');
hold on
plot(eeg.alpha(timeRange,1), electrode2(timeRange), '-r');
hold on
plot(eeg.alpha(timeRange,1), electrode3(timeRange), '-g');
hold on
plot(eeg.alpha(timeRange,1), electrode4(timeRange), '-c');
hold on
plot(eeg.alpha(timeRange,1), electrode5(timeRange), '-b');
hold on
plot(eeg.alpha(timeRange,1), electrode6(timeRange), '-m');
hold on
plot(eeg.alpha(timeRange,1), electrode7(timeRange), '-w');
hold on
% plot(eeg.alpha(timeRange,1), electrode14(timeRange), '-b);
% hold on 
plot(eeg.alpha(timeRange,1), electrode13(timeRange), '-k');
hold on
plot(eeg.alpha(timeRange,1), electrode12(timeRange), '-r');
hold on
plot(eeg.alpha(timeRange,1), electrode11(timeRange), '-g');
hold on
plot(eeg.alpha(timeRange,1), electrode10(timeRange), '-c');
hold on
plot(eeg.alpha(timeRange,1), electrode9(timeRange), '-b');
hold on
plot(eeg.alpha(timeRange,1), electrode8(timeRange), '-m');
hold on
plot(eeg.alpha(timeRange,1), electrode14(timeRange), '-w');
hold on

legend('alpha to theta ratio');
%         axis([1,10,1,6])
xlabel('Sample Number (Start of FFT; 32 sample steps)')
ylabel('Ratio (Alpha to Theta)')
cleanname = regexprep(file.name, '\.edf|\.set$','');
figtit = strsplit(cleanname, {'-','_'});
TS = sprintf('%s %s %s',figtit{1},figtit{2},'allelectrodes');
title(TS);
savefig(TS);
close all
clear plot

end


