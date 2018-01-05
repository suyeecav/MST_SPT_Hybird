function [bounded_radi_mat,G_MST_bound] = bounded_radius(adj_mat,epsilon,source)
[MST_mat,G_MST] = core_algo(adj_mat,0,source); % MST generation
%v_order = dfsearch(G_MST,source);
%...!!!!Above statement is standard matlab code, the function below is my
%code... Please help check if this code is correct. 

v_order = depth_first_search(adj_mat,source);
R = max(max(adj_mat));
A = 0;
E_prime_mat = MST_mat;

for i = 2:length(v_order)
    A = A + adj_mat(v_order(i-1),v_order(i));
    if A > epsilon*R
       E_prime_mat(source,v_order(i)) = adj_mat(source,v_order(i)); 
       E_prime_mat(v_order(i),source) = adj_mat(source,v_order(i));
       A = 0;
    end
end
[bounded_radi_mat,G_MST_bound] = core_algo(E_prime_mat,1,source); % SPT generation
end