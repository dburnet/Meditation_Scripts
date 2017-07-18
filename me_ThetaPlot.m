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
function AIS = me_ThetaPlot(filename)
file.name = filename;
if regexp(filename,'set$')
    EEG2 = pop_loadset(filename);
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

% PLOT
filelength = size(EEG2);
filelengthsecs = ((filelength(1))/128);
timeRange = 1:filelengthsecs;
% set(0,'DefaultFigureVisible','off');  % all subsequent figures "off"
for counter = 2:15
    if counter == 2
        channel = 2;
%         a2tr = eeg.alpha(:,channel)./eeg.theta(:,channel);
       figure;
%              plot(eeg.alpha(1:81655,1), a2tr(1:81655), 'k');
        plot(eeg.theta(timeRange,1), 'k');
        legend('theta power');
        xlabel('Sample Number (Start of FFT; 32 sample steps)')
        ylabel('Theta Power');
        cleanname = regexprep(file.name, '\.edf|\.set$','');
        figtit  = strsplit(cleanname, {'-','_'});
        TS = sprintf('%s %s %s' ,figtit{1},figtit{2},num2str(1));
        title(TS);
        savefig(TS);
    else
        channel =  channel+1;
        a2tr = eeg.alpha(:,channel)./eeg.theta(:,channel);
        figure;
       plot(eeg.theta(timeRange,1), 'k');
        legend('theta power');
        xlabel('Sample Number (Start of FFT; 32 sample steps)')
        ylabel('Theta Power');
        cleanname = regexprep(file.name, '\.edf|\.set$','');
        figtit  = strsplit(cleanname, {'-','_'});
        TS = sprintf('%s %s %s %s' ,'theta',figtit{1},figtit{2},num2str(1));
        title(TS);
%         savefig(TS);
%         plot(eeg.alpha(timeRange,1), a2tr(timeRange), 'k');
%         legend('alpha to theta ratio');
%         xlabel('Sample Number (Start of FFT; 32 sample steps)')
%         ylabel('Ratio (Alpha to Theta)')
%         cleanname = regexprep(file.name, '\.edf|\.set$','');
%         figtit = strsplit(cleanname, {'-','_'});
%         TS = sprintf('%s %s %s',figtit{1},figtit{2},num2str(counter-1));
%         title(TS);
%         savefig(TS);
    end
end


