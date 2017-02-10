function X = mass_fft(Z)
[h,w,s] = size(Z);
X=[];

for i = 1:s
	K = fft2(Z(:,:,i));
	X(:,:,i) = (real(K)+imag(K))/2;
end

end
