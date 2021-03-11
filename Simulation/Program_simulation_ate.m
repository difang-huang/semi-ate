clear; close all

%% Simulation Study With ATE

%% Table 5 with ATE of dimension d = 2 and d = 6

NN = [400 800 1600];
for j = 1:2
    for i = 1:length(NN)
        for k = 2:6
            N = NN(i);
            Runsimulation5a(10000, N, k, j, 4);
        end
    end
end

NN = [400 800 1600];
for j = 1:2
    for i = 1:length(NN)
        for k = 2:6
            N = NN(i);
            Runsimulation5b(10000, N, k, j, 4);
        end
    end
end


%% Table 6 with ATE of dimension d = 2 with misspecification on identification condition

NN = [400 800 1600];
for j = 1:2
    for i = 1:length(NN)
        for k = 2:6
            N = NN(i);
            Runsimulation6a(10000, N, k, j, 4);
        end
    end
end

NN = [400 800 1600];
for j = 3:4
    for i = 1:length(NN)
        for k = 2:6
            N = NN(i);
            Runsimulation6b(10000, N, k, j, 4);
        end
    end
end

 