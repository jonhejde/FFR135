%% Parameters
N = 120;
p = [12,24,48,70,100,120];
trials = 10^5;
W_diag_zero  = false
error = zeros(1,length(p))
for i = 1:length(p)
    
    for j = 1:trials
        rand_pattern = round(randi([1,2],N,p(i))-1.5);%Change to somethig else
        W = zeros(N);
        for k = 1:size(rand_pattern,2)
            W = W + rand_pattern(:,k)*rand_pattern(:,k)';
        end
        W = W.*(1/N);
        if W_diag_zero
            W = W - diag(diag(W));
        end
        rand_p = randi([1,p(i)]);
        rand_N = randi([1,N]);
        z = W(rand_N,:)*rand_pattern(:,rand_p);
        S = sign(z);
        if S == 0
            S = 1;
        end
        if S ~= rand_pattern(rand_N,rand_p)
            error(i) = error(i) + 1;
        end
            
    end
end