%for half between markers compute the alpha imbalance this feeds into
%BlockChop 
function AIS = ge_meditationChop(filename)

    lowerBound  = 2;
    upperBound  = 41;
    eegChannels = 3:16;
 
    if regexp(filename,'set$')
        EEG2 = pop_loadset(filename);
   elseif regexp(filename,'edf$')
        EEG2 = pop_biosig(filename);
    else
        error('ge_handContraction: File type unknown');
    end
    
    EEG_only = pop_select(EEG2, 'channel', eegChannels);
    EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);
   
    size(EEG2)
    
    m = 2;
    ss      = ge_getSampleBounds(EEG2, m);
%     b       = (ss(1)+76800);
%     y       = (b+76800);
%     z       = (y+76800); 
%     m       = (z +76800);
%     
%     first   = EEG_only.data(:,ss(1):b);
%     second  = EEG_only.data(:,b:y);
%     third   = EEG_only.data(:,y:z);
%     fourth  = EEG_only.data(:,z:ss(2));
%     
%     blob1.Fs = 128;
%     blob1.data = first'; 
%     blob2.Fs = 128;
%     blob2.data = second';
%     blob3.Fs = 128;
%     blob3.data = third';
%     blob4.Fs = 128;
%     blob4.data = fourth';
%     
     AIS{1}   = ss; 
%      AIS{2}   = alphaImbalance(blob1);
%      AIS{3}   = alphaImbalance(blob2);
%      AIS{4}   = alphaImbalance(blob3);
%      AIS{5}   = alphaImbalance(blob4);
     
     
end