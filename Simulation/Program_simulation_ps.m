clear; close all

%% Simulation Study With PS (The Whole Simulation Takes About Two Weeks)

%% Table 1 with dimension d = 2 (PS simulation)

NN = [400 800 1600];
for j = 1:2
    for i = 1:length(NN)
        for k = 2:6
            N = NN(i);
            Runsimulation1(10000, N, k, j, 4);
        end
    end
end


%% Table 2 with misspecification on the identification condition

NN = [400 800 1600];
for j = 1:2
    for i = 1:length(NN)
         for k = 2:6
            N = NN(i);
            Runsimulation2(10000, N, k, j, 4)
         end
    end
end


%% Table 3 with dimension d = 6 (PS simulation)

NN = [400 800 1600];
for j = 1:2
    for i = 1:length(NN)
        for k = 2:6
            N = NN(i);
            Runsimulation3(10000, N, k, j, 4);
        end
    end
end


%% Table 4 with misspecification and dimension d = 6 (PS simulation)

NN = [400 800 1600];

for j = 1:2
    for i = 1:length(NN)
        for k = 4:6
            N = NN(i);
            Runsimulation4(10000, N, k, j, 4)
        end
    end
end



  

