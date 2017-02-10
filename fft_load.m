function [X Y Z T U V] = fft_load(path_fn, face)
X = 1;% read_images(path_fn);
Y = test_read_images(path_fn,face);
Z = learn_read_images(path_fn,face);
T = 1;% mass_fft(X);
U = mass_fft(Y);
V = mass_fft(Z);
end
