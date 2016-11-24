%% Reading of the dataset
% select the usefull features
% identify the format of the selected features
% store block of the data into .mat files


fid = fopen('Crimes_-_2001_to_present.csv');

C_headers = textscan(fid,[repmat('%s',[1,22])],1,'delimiter',',');
format1 = '%*d %*s %s %*q %*s %*s %*q  %*q  %*s %*s %*s %*d %*d %d %*s %d %d %d %*s %s %s %*q';

extract = @(C, k) cellfun(@(c)c(k), C,'UniformOutput',false);

Data_chunks = 'A':'Z';

%i = 1;
%while ~feof(fid)

for i = 1:4
    disp(Data_chunks(i))    
    
    if i == 1
        header = 1;
    else
        header = 0;
    end   
    
    C_data = textscan(fid,format1,700000,'headerlines',header,'delimiter',',');
    eval(['C_data_' Data_chunks(i) ' = C_data;']); 
    
    save(strcat('datafile_',Data_chunks(i),'.mat'),strcat('C_data_',Data_chunks(i))');  
end

fclose(fid);
%%

data_splits = [C_data_A;C_data_B;C_data_C;C_data_D];
temp = [];

    for i = 2001:2016
        temp = [];
        for j = 1:4
            temp = vertcat(temp,sort_year(data_splits(j,:),i)); 
        end
        
        merged_temp = cell_array_merging(temp);
        eval(['C_data_' num2str(i) ' = merged_temp;']);
        save(strcat('datafile_',num2str(i),'.mat'),strcat('C_data_',num2str(i))'); 
    end    
    
 
%%



%%