function picked = pickNInstancesOfKeyword (M,N, keyword)
% For each class, we want to get the first N instances in M where the class
% tag 'keyword' is more relevant.
 
%% LOOKING FOR KEYWORD POSITIONS
  indices = find(strcmpi(keyword,M)); % Search the keyword in all the cells.
  j = double(idivide(int32(indices),size(M,1))+1); % Get column list
  i  =  mod(indices,size(M,1));   % Get row list
  % i and j contain indices to access each 'happy' keyword. 
  % eg. M(i(1),j(1) = 'keyword'.

%% CONSTRUCTING A REDUCED DATABASE WITH INSTANCES CONTAINING OUR KEYWORD
 keywordCells = cell(length(i),3); % Initialize  new table
 k=1;
 n=1;
while k <= length(i)
     idx = find(strcmpi(M{i(k),1},keywordCells), 1); % Checking for duplicated ids
     if (isempty(idx)) % If current id is not present in new table
        keywordCells(n,1) =  M(i(k),1); % 1st column: musicbrainz id
        keywordCells(n,2) =  M(i(k),j(k)); % 2nd column: keyword value
        keywordCells{n,3} =  cellfun(@str2num,M(i(k),j(k)+1)); % 3rd column: keyword count
        n=n+1;
     end
     k=k+1;
end

%% PICKING THE MOST RELEVANT Ninstances
Y = sortcell(keywordCells,3); % Order rows  by considering keyword count.
fY = flipud(Y); % As sortcell orders increasing, we flip to get it decreasing

if (N>size(fY,1)) % If we are asking for more instances than exist with keyword
    N=size(fY,1); % We consider N as the total number of instances with keyword.
end
picked = fY(1:N,:); % Our subset will be the N first instances in our ordered dataset.

end
