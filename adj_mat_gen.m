function [loc_mat,adj_mat,G] = adj_mat_gen(N,scale,flag)
x_axis_vec = 10-randi(20,1,N);%...x,y axis are in [-10,10].
y_axis_vec = 10-randi(20,1,N);
loc_mat = [x_axis_vec;y_axis_vec];
adj_mat = zeros(N);

if flag == 1
d = floor(scale*rand(N,1)); % The diagonal values
t = triu(bsxfun(@min,d,d.').*rand(N),1); % The upper trianglar random values
adj_mat = floor(diag(d)+t+t.')+1; % Put them together in a symmetric matrix

for i = 1:N
    adj_mat(i,i) = 0;
    if sum(adj_mat(i,:)) == 0
        j = randi(N);
        while j == i
            j = randi(N);%gaurantees not to take j equal to i
        end
        adj_mat(i,j) = 1;
        adj_mat(j,i) = 1;
    end
end


%z_axis_vec = 10-20*randi(10,1,N);
else 
    for i = 1:N
        for j = 1:N
            adj_mat(i,j) = norm([loc_mat(1,i)-loc_mat(1,j),loc_mat(2,i)-loc_mat(2,j)],2);
        end
    end
end


G = graph(adj_mat);
end

