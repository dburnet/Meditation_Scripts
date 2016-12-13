%this is to analysis Turner-Masuda meditation data, cleaned, it will
%produce two plots one of alpha power and theta power another of alpha asym
%score. It will produce one graph per subject per session. It needs to save
%the graphs so they can be opened later. 

function AIS = me_Analysis(filename)

if regexp(filename, 'csv$')
     M = csvread(filename, 0, 1);
 elseif regexp(filename, 'xlsx$')
     M = xlsread(filename,0,1);
 else 
     error('me_restingAsym: File type unknown');
 end 
% M = csvread(filename,',',0,1)%this reads in the file without the subnumb or the file name, change if that changes
%here each row needs to be assigned to a different variable
dimensions = size(M);
    for i = 1:dimensions(1)
        figure;
        plot(M(i,3:2:end), 'r--o')
        hold on
        plot(M(i,4:2:end), 'b--o')
        axis([1,9,-1,1])
        xlabel('Time by 5 minute increments')
        ylabel('Alpha Score')
        TS = sprintf('Subject %d Session %d',M(i,1),M(i,2))
        title(TS)
        figtit = regexprep(TS,' ','_')
        savefig(figtit)
    end
    
    
end






%take the column of the first five minutes and plot 




% fid = fopen(outfile, 'w');
% for file = files'
%     file.name
%     cleanname = regexprep(file.name, '\.edf|\.set$','');
%     namelist  = strsplit(cleanname, '-|_');
%     subnum    = namelist{1};
%     
