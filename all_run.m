clear all;clc;close all;
N = 40;
scale = 20;
epsilon0 = 0;
epsilon1 = 1;
epsilon2 = 50;

source = 2;
flag = 0;

%...adj matrix generation
[loc_mat,adj_mat,G] = adj_mat_gen(N,scale,flag);
x_axis_vec = loc_mat(1,:);
y_axis_vec = loc_mat(2,:);

%...plot results
plot(G,'XData',x_axis_vec,'YData',y_axis_vec,'EdgeLabel',G.Edges.Weight);
legend('Original Graph');
[T,pred] = minspantree(G);
TR = shortestpathtree(G,source);
figure;
%p1 = plot(T,'XData',x_axis_vec,'YData',y_axis_vec,'EdgeLabel',G.Edges.Weight);
plot(T,'XData',x_axis_vec,'YData',y_axis_vec);
legend('MST Graph');
figure; 
%p2 = plot(TR,'XData',x_axis_vec,'YData',y_axis_vec,'EdgeLabel',G.Edges.Weight);
plot(TR,'XData',x_axis_vec,'YData',y_axis_vec);
legend('SPT Graph');
%highlight(p1,T)
%highlight(p2,TR,'EdgeColor','r')

%...mixture of prim's and dijstra's algorithm 
[dist_mat,mixed_graph] = core_algo(adj_mat,epsilon1,source);
figure; plot(mixed_graph,'XData',x_axis_vec,'YData',y_axis_vec,'EdgeLabel',mixed_graph.Edges.Weight);
fprintf('Total weight of hybird graph with epsilon %d is %d\n',epsilon1,sum(sum(dist_mat))/2);
%fprintf('Max Radius of hybird tree with epsilon %d is %d\n',epsilon1,max(dist_mat(source,:)));
fprintf('Max Radius of hybird graph with epsilon %d is %d\n',epsilon1,compute_radius(dist_mat,source));
legend('hybird Graph: Suo; Fnu');

[dist_mat,mixed_graph] = core_algo(adj_mat,epsilon0,source);
figure; plot(mixed_graph,'XData',x_axis_vec,'YData',y_axis_vec,'EdgeLabel',mixed_graph.Edges.Weight);
fprintf('Total weight of hybird tree with epsilon %d is %d\n',epsilon0,sum(sum(dist_mat))/2);
%fprintf('Max Radius of MST with epsilon %d is %d\n',epsilon0,max(dist_mat(source,:)));
fprintf('Max Radius of hybird graph with epsilon %d is %d\n',epsilon0,compute_radius(dist_mat,source));
legend('hybird Graph: Suo; Fnu');

%Bounded radius method...
[bounded_radi_mat,G_MST_bound] = bounded_radius(adj_mat,epsilon2,source);
figure; plot(G_MST_bound,'XData',x_axis_vec,'YData',y_axis_vec,'EdgeLabel',G_MST_bound.Edges.Weight);
fprintf('Total weight of hybird graph with epsilon %d is %d\n',epsilon2, sum(sum(bounded_radi_mat))/2);
%fprintf('Max Radius of MST with epsilon %d is %d\n',epsilon2,max(bounded_radi_mat(source,:)));
fprintf('Max Radius of hybird graph with epsilon %d is %d\n',epsilon2,compute_radius(bounded_radi_mat,source));
legend('Bounded Radius Graph: Suo; Fnu');