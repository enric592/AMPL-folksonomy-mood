 M = csvimport('../CSV/acousticbrainz-2015-01-lastfm-tags.csv'); %Importing CSV database.
%{
'acousticbrainz-2015-01-lastfm-tags.csv' Contains tags scraped from Last.fm
 according to the track.getTopTags method.
Each row contains the MBID of a recording in the first column followed by 
pairs of data. The first item in a pair is a tag, and the second item is 
its count in that recording (see their documentation). These counts are 
normalised per recording, that is, a count of 100 means that it is the most
common tag in that recording, not that it has been tagged with this tag 100 times.
 %}
 
 N = 1000; % Number of desired instances for each class.
 
 %% For each class, we want to get the first N instances where the class tag is more relevant.
 happyDatabase = pickNInstancesOfKeyword(M,N,'happy'); 
 sadDatabase = pickNInstancesOfKeyword(M,N,'sad');
 
 %% Preparing the .csv file to upload to AcousticBrainz
 % csv file containing two columns, where the first column is a musicbrainz 
 % id, and the second column is the name of your class.
 
 db = cat(1,happyDatabase(:,1:2),sadDatabase(:,1:2));
 cell2csv('../CSV/dataset.csv',db);