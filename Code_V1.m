clear all
close all
clc

load('HenryKohn2022_distractororientation.mat');

for pop = 1:8
%% Draw Raster Plot

figure;

imagesc(v1population(pop).spikecounts)
colorbar; 

xlabel('Trial');
ylabel('Neuron');
title('Raster Plot');

%% Draw Firing Rate Plot

num_trials = size(v1population(pop).spikecounts, 2);
num_neurons = size(v1population(pop).spikecounts, 1);

figure;
hold on;
duration = 0.25; % Duration of each stimulus presentation (in seconds)

for i = 1:num_neurons
    firing_rates = v1population(pop).spikecounts(i, :) / duration;
    plot(firing_rates, 'b');
end

xlabel('Trial');
ylabel('Firing Rate (spikes/s)');
title('Firing Rate Plot');
hold off;

%% Calculate Fano factor and Coefficient of Variation

num_neurons = size(v1population(pop).spikecounts, 1);
num_trials = size(v1population(pop).spikecounts, 2);
duration = 0.25; % Duration of each stimulus presentation (in seconds)

fano_factors = zeros(1, num_neurons);
cvs = zeros(1, num_neurons);

for i = 1:num_neurons
    spike_counts = v1population(pop).spikecounts(i, :);
    
    % Calculate Fano factor
    fano_factors(i) = var(spike_counts) / mean(spike_counts);
    
    % Calculate Coefficient of Variation (CV)
    firing_rates = spike_counts / duration;
    cvs(i) = std(firing_rates) / mean(firing_rates);
end

% Display results
figure;
subplot(2,1,1);
bar(fano_factors);
title('Fano Factor for Each Neuron');
xlabel('Neuron');
ylabel('Fano Factor');

subplot(2,1,2);
bar(cvs);
title('Coefficient of Variation for Each Neuron');
xlabel('Neuron');
ylabel('CV');

%% Calculate mean Fano factor and CV

mean_fano = mean(fano_factors);
mean_cv = mean(cvs);

disp('--------------------------------')
fprintf('Mean Fano Factor: %.4f\n', mean_fano);
fprintf('Mean Coefficient of Variation: %.4f\n', mean_cv);
end