%function [X width height] = read_images(path_fn)
function X = learn_read_images(path_fn, exclude)
	% get files for a given path
	folder = list_files(path_fn);
	% initialize the empty return values
	X=[];
	count = 1;
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
		for j=1:length(images)
		if(j!=exclude)
			% ... get the absolute path
			filename = [path_fn, filesep, subject, filesep, images{j}];
			% ... read the image

			%T = double(imread(filename));
			T = imread(filename);
			% ... get the image information

			%[height width] = size(T);

			X(:,:,count) = T;
			count += 1;
			% ... append the corresponding class to the class vector
		end
		end

	end % ... for-each folder.
end


%a = X(:,:,1);
%a = uint8(a);
%imshow(a)
