clear all
close all
clc

%% Load data
Res1 = load('HenryKohn2022_distractororientation.mat');

%% Task

% Parameters
target_contrast = Res1.v1population(1).parameters(1,1); % Use first element if it's an array
target_ori = Res1.v1population(1).parameters(2,1);
distractor_contrast = Res1.v1population(1).parameters(3,1);
distractor1_ori = Res1.v1population(1).parameters(4,1);
distractor2_ori = Res1.v1population(1).parameters(5,1);
distractor3_ori = Res1.v1population(1).parameters(6,1);
distractor4_ori = Res1.v1population(1).parameters(7,1);

% Create a new figure
figure;
hold on;
axis equal;
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);

% Display target
r = 0.2;
x = 0;
y = 0;
[xx, yy] = meshgrid(linspace(-r,r,100));
grating = sin(2*pi*10*(xx.*cos(target_ori) + yy.*sin(target_ori)));
grating = grating .* target_contrast;
grating(xx.^2 + yy.^2 > r^2) = NaN;
surf(xx+x, yy+y, zeros(size(xx)), grating, 'EdgeColor', 'none');

% Display distractors
r_dist = 0.15;
angles = [0, 90, 180, 270] * pi/180;
dist_oris = [distractor1_ori, distractor2_ori, distractor3_ori, distractor4_ori];

for i = 1:4
    x_dist = cos(angles(i));
    y_dist = sin(angles(i));
    [xx, yy] = meshgrid(linspace(-r_dist,r_dist,100));
    grating = sin(2*pi*10*(xx.*cos(dist_oris(i)) + yy.*sin(dist_oris(i))));
    grating = grating .* distractor_contrast;
    grating(xx.^2 + yy.^2 > r_dist^2) = NaN;
    surf(xx+x_dist, yy+y_dist, zeros(size(xx)), grating, 'EdgeColor', 'none');
end

colormap gray;
title('Task Display');
axis off;
hold off;