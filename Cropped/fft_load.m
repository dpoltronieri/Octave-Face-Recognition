function [X Y Z T U V] = fft_load(path_fn, face, crop)
X = 1;% read_images(path_fn, crop);
Y = test_read_images(path_fn,face, crop);
Z = learn_read_images(path_fn,face, crop);
T = 1;% mass_fft(X);
U = mass_fft(Y);
V = mass_fft(Z);
end
