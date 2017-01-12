% wrapper function -DHB 10/4


function me_ForLoopScoreBlock(files, outfile)
%good as of 12/13/16 produces csv with all necessary info

% ge_tapBlockImport(files, outfile)
%
% Imports a block of files in the required format for Dom Parrott's "TAP" 
% experiments. Uses the ge_parrottImport.m function to resolve markers and
% pre-process data. Uses a dir() object as input! (Will break on a list or
% some other format.
%
% MDT
% 2016.06.13
% Version 0.8.3

    fid = fopen(outfile,'w');
    fprintf(fid, '%6s, %12s, %18s, %24s, %30s, %36s, %42s, %48s, %54s, %60s, %66s,%72s, %78s,%84s, %90s, %96s, %102s\r\n\, ','Filename,SubjectNumber,SessionNumber,5.1F3/4,5.1FC5/6,5.2F3/4,5.2FC5/6,5.3F3/4,5.3FC5/6,5.4F3/4,5.4FC5/6,5.5F3/4,5.5FC5/6,5.6F3/4,5.6FC5/6,5.7F3/4,5.7FC5/6,5.8F3/4,5.8FC5/6,' );

    for file = files'
        file.name
        % Subject and condition data:
        cleanname = regexprep(file.name, '\.edf|\.set$','');
        namelist  = strsplit(cleanname, {'-','_'});
        subnum    = namelist{1};
%         handorder  = namelist{3};
        sessionnumber  = regexprep(namelist{2}, '^Session|^session', '');
        % Data analysis to get AIS's:

        x = me_ForLoopScore(file.name);
        % Write the "obvious" data to the file
        fprintf(fid, '\n%s,%s,%s,',file.name,subnum,sessionnumber);
        for counter = 1:length(x)
            fprintf(fid, '%f,%f,', x{counter});
        end
        nasthings = 8 - length(x);
        for counter = 1:nasthings
            fprintf(fid, 'NaN,NaN,');
        end 
%         fprintf(fid, '\n');
    end
    fclose(fid);
    fclose('all');     % Testing to fix the matlab open file bug!
    
end

