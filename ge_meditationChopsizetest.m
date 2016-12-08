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
  
 
    a       = (1 + min(38399,recordinglength(2)))
    b       = (min((a+38399),recordinglength(2)))
    c       = (min((b+38399),recordinglength(2))) 
    d       = (min((c+38399),recordinglength(2))) 
    e       = (min((d+38399),recordinglength(2)))
    f       = (min((e+38399),recordinglength(2)))
    g       = (min((f+38399),recordinglength(2)))
    h       = (min((g+38399),recordinglength(2)))
  
    Timepoints = [a b c d e f g h] 
    

  figure;
  title('798');
  subplot(5,2,1)
    fivemin   = EEG_only.data(:,1:a);
    blob1.Fs = 128;
    blob1.data = fivemin';
    tempvar = alphaImbalance(blob1);
    AIS{1}   = tempvar(3:4);
%     figure;
    bar(AIS{1});
    subplot(5,2,1)
    title('First Five Minutes');
    xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
    ylabel('Alpha Score');
    hold on
    if ( b > a)
       tenmin  = EEG_only.data(:,a:b);
       blob2.Fs = 128;
       blob2.data = tenmin';
       AIS{2}   = alphaImbalance(blob2);
%        figure;
       bar(AIS{2});
       subplot(5,2,2)
       title('Second Five Minutes');
       xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
       ylabel('Alpha Score');
       hold on
   else 
       ('file too small, less than 10 minutes');
   end
   if (c > b)
       fifteenmin   = EEG_only.data(:,b:c);
        blob3.Fs = 128;
        blob3.data = fifteenmin';
        AIS{3}   = alphaImbalance(blob3);
%         figure;
        bar(AIS{3});
        subplot(5,2,3)
        title('Third Five Minutes');
        xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
        ylabel('Alpha Score');
        hold on
   else 
       ('file too small, less than 15 minutes')
   end
   if (d > c)
        twentymin  = EEG_only.data(:,c:d);
        blob4.Fs = 128;
        blob4.data = twentymin';
        AIS{4}   = alphaImbalance(blob4);
%         figure;
        bar(AIS{4});
        subplot(5,2,4)
        title('Fourth Five Minutes');
        xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
        ylabel('Alpha Score');
        hold on
   else
      ('file too small, less than 20 minutes')
   end     
    if (e > d)
        twentyfivemin  = EEG_only.data(:,d:e);
        blob4.Fs = 128;
        blob4.data = twentyfivemin';
        AIS{5}   = alphaImbalance(blob4);
%         figure;
        bar(AIS{5});
        subplot(5,2,5)
        title('Fifth Five Minutes');
        xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
        ylabel('Alpha Score');
        hold on
    else
      ('file too small, less than 25 minutes')
    end     
     if (f > e)
        thirtymin  = EEG_only.data(:,e:f);
        blob4.Fs = 128;
        blob4.data = thirtymin';
        AIS{6}   = alphaImbalance(blob4);
%         figure;
        bar(AIS{6});
        subplot(5,2,6)
        title('Sixth Five Minutes');
        xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
        ylabel('Alpha Score');
        hold on
     else
        
      ('file too small, less than 30 minutes')
   end     
       if (g > f)
        thirtyfivemin  = EEG_only.data(:,f:g);
        blob4.Fs = 128;
        blob4.data = thirtyfivemin';
        AIS{7}   = alphaImbalance(blob4);
%         figure;
        bar(AIS{7});
        subplot(5,2,7)
        title('Seventh Five Minutes');
        xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
        ylabel('Alpha Score');
        ylim([-.5 .5])
%         hold on
    else
      ('file too small, less than 35 minutes')
   end     
     
   if (h > g)
        fourtymin  = EEG_only.data(:,g:h);
        blob4.Fs = 128;
        blob4.data = fourtymin';
        AIS{8}   = alphaImbalance(blob4);
%         figure;
        bar(AIS{8});
        subplot(5,2,8)
        title('Eigth Five Minutes');
        xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
        ylabel('Alpha Score');
%         hold on    
   else
      ('file too small, less than 40 minutes')
   end     
        if (recordinglength(2) > h)
        fourtyfivemin  = EEG_only.data(:,h:recordinglength(2));
        blob4.Fs = 128;
        blob4.data = fourtyfivemin';
        AIS{9}   = alphaImbalance(blob4);
%         figure;
        bar(AIS{9});
        subplot(5,2,9)
        title('Ninth Five Minutes');
        xlabel('AF3/4,  F7/8,   F3/4,   FC5/6,  T7/8,   P7/8,   O1/2');
        ylabel('Alpha Score');
        hold on        
    else
      ('file too small, less than 45 minutes')
        end
         
end