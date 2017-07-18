function AIS = me_WholeSessionScore(filename)

%     lowerBound  = 2;
%     upperBound  = 41;
%     eegChannels = 1:14;

    %EEG2 = pop_biosig('test.edf');
    %EEG2     = pop_loadset(filename);
    
    if regexp(filename,'set$')
        EEG2 = pop_loadset(filename);
%     elseif regexp(filename,'edf$')
%         EEG2 = pop_biosig(filename);
    else
        error('ge_handContraction: File type unknown');
    end
    
%     EEG_only = pop_select(EEG2, 'channel', eegChannels);
%     %EEG_only = pop_reref(EEG_only, [6 9], 'keepref', 'on');    % avg reference!
%     EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);
%     
%     for m = 3:5
%         ss      = ge_getSampleBounds(EEG2, m);
%         data{m} = EEG_only.data(:,ss(1):ss(2));
%     end

    EEG2.Fs = 128;

   AIS   = sepa_alphaAsymmetry(EEG2);
end