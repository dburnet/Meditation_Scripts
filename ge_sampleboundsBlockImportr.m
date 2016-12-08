function ge_sampleboundsBlockImportr(files, outfile)
 

fid = fopen(outfile,'w');
    for file = files'
        file.name
        % Subject and condition data:
        cleanname = regexprep(file.name, '\.edf|\.set$','');
        namelist  = strsplit(cleanname, '-');
        subnum    = namelist{1};
        handorder  = namelist{3};
        sessionnumber  = regexprep(namelist{2}, '^S', '');
        % Data analysis to get AIS's:
        x = ge_getSampleBounds(file.name);


        fprintf(fid, '%s,%s,%s,%s,', subnum, sessionnumber, handorder, file.name);
        fprintf(fid, '%f,%f,%f,%f,%f,%f,%f,', x{1});
                 end
    fclose(fid);
    fclose('all');     % Testing to fix the matlab open file bug!
end