%function [X width height] = read_images(path_fn)
function X = test_read_images(path_fn, j, crop)
  % get files for a given path
  folder = list_files(path_fn);
  % initialize the empty return values
  X=[];
  %width=0;
  %height=0;
  
  % for each file...
  for i=1:length(folder)
    subject = folder{i};
    % ... get files in this subdir
    images = list_files([path_fn, filesep, subject]);
    % ... ignore a file or empty folder
    if(length(images) == 0)
      continue; 
    end
    % ... for each image
    %for j=1:length(images)
    %agora pega só 1
      % ... get the absolute path
      filename = [path_fn, filesep, subject, filesep, images{j}];
      % ... read the image
      
      %T = double(imread(filename));
      T = imread(filename);
      T = T(crop:end-crop,crop:end-crop);
      % ... get the image information
      
      %[height width] = size(T);
      
      X(:,:,i) = T;
      % ... append the corresponding class to the class vector
    %end
    
  end % ... for-each folder.
end


%a = X(:,:,1);
%a = uint8(a);
%imshow(a)
