dat = load('demo_data.mat');

t = dat.data(:,1);
y = dat.data(:,2:14);

quad_plotcom(t,y);