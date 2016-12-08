%for half between markers compute the alpha imbalance this feeds into
%BlockChop 
function AIS = ge_meditationChopsizetest(filename)

    lowerBound  = 2;
    upperBound  = 41;
    eegChannels = 1:14;
 
    if regexp(filename,'set$')
        EEG2 = pop_loadset(filename);
   elseif regexp(filename,'edf$')
        EEG2 = pop_biosig(filename);
    else
        error('ge_handContraction: File type unknown');
    end
    
    EEG_only = pop_select(EEG2, 'channel', eegChannels);
    EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);
   
    recordinglength = ceil(size(EEG_only.data))
    sessionlength = (recordinglength(2)/128)/60
    
 for counter = 1:recordinglength(2)
     a(1) = (1+38399)
     a(2) = a(1)+38399 
     
%      blob(2) = (blob + min(38399,recordinglength(2)))
 end 
%  for counter = 1:9   
%     blob.Fs = 128;
%     blob.data = fivemin';
%     blob   = alphaImbalance(blob);
%  end
 
%    if ( b > a)
%        tenmin  = EEG_only.data(:,a:b);
%        blob2.Fs = 128;
%        blob2.data = tenmin';
%        AIS{2}   = alphaImbalance(blob2);
%    else 
%        ('file too small, less than 10 minutes');
%    end
%    if (c > b)
%        fifteenmin   = EEG_only.data(:,b:c);
%         blob3.Fs = 128;
%         blob3.data = fifteenmin';
%         AIS{3}   = alphaImbalance(blob3);
%    else 
%        ('file too small, less than 15 minutes')
%    end
%    if (d > c)
%         twentymin  = EEG_only.data(:,c:d);
%         blob4.Fs = 128;
%         blob4.data = twentymin';
%         AIS{4}   = alphaImbalance(blob4);
%     else
%       ('file too small, less than 20 minutes')
%    end     
%     if (e > d)
%         twentyfivemin  = EEG_only.data(:,d:e);
%         blob4.Fs = 128;
%         blob4.data = twentyfivemin';
%         AIS{5}   = alphaImbalance(blob4);
%     else
%       ('file too small, less than 25 minutes')
%     end     
%      if (f > e)
%         thirtymin  = EEG_only.data(:,e:f);
%         blob4.Fs = 128;
%         blob4.data = thirtymin';
%         AIS{6}   = alphaImbalance(blob4);
%     else
%       ('file too small, less than 30 minutes')
%    end     
%        if (g > f)
%         thirtyfivemin  = EEG_only.data(:,f:g);
%         blob4.Fs = 128;
%         blob4.data = thirtyfivemin';
%         AIS{7}   = alphaImbalance(blob4);
%     else
%       ('file too small, less than 35 minutes')
%    end     
%      
%    if (h > g)
%         fourtymin  = EEG_only.data(:,g:h);
%         blob4.Fs = 128;
%         blob4.data = fourtymin';
%         AIS{8}   = alphaImbalance(blob4);
%     else
%       ('file too small, less than 40 minutes')
%    end     
%         if (recordinglength(2) > h)
%         fourtyfivemin  = EEG_only.data(:,h:recordinglength(2));
%         blob4.Fs = 128;
%         blob4.data = fourtyfivemin';
%         AIS{9}   = alphaImbalance(blob4);
%     else
%       ('file too small, less than 45 minutes')
%    end     
       
     
     
end