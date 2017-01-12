function AIS = ge_meditation(filename)

    lowerBound  = 2;
    upperBound  = 41;
    eegChannels = 3:16;

    %EEG2 = pop_biosig('test.edf');
    %EEG2     = pop_loadset(filename);
    
    if regexp(filename,'set$')
        EEG2 = pop_loadset(filename);
    elseif regexp(filename,'edf$')
        EEG2 = pop_biosig(filename);
    else
        error('ge_meditation: File type unknown');
    end
    
    EEG_only = pop_select(EEG2, 'channel', eegChannels);
    EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);
    
    for m = 2
        ss      = ge_getSampleBounds(EEG2, m);
        data{m} = EEG_only.data(:,:);
    end

    blob.Fs = 128;

    for ii = 2
        blob.data = data{ii}';
        AIS{ii}   = alphaImbalance(blob);
    end
end