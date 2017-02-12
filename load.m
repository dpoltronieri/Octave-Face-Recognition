function [X Y Z] = load(path_fn, face)
X = read_images(path_fn);
Y = test_read_images(path_fn,face);
Z = learn_read_images(path_fn,face);
end
