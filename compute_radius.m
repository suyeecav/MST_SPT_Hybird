function radius =  compute_radius(adj_mat,source)
%N = length(adj_mat(1,:));    

[v_lst,leaf_nodes] = depth_first_search(adj_mat,source);
%v_lst = dfsearch(G,source);
radius_vec = zeros(length(leaf_nodes),1);
for i = 1:length(leaf_nodes)
    leaf_node = leaf_nodes(i);
    tmp = 0;
    leaf_indx = ((find(v_lst == leaf_node)));
    oper_lst = v_lst(1:leaf_indx);
    counter = 1;
    while length(unique(oper_lst)) ~= length(oper_lst)
         co_indx = find(oper_lst == oper_lst(counter));
         if length(co_indx) > 1
            oper_lst(min(co_indx)+1:max(co_indx)) = [];
            counter = 1;
         else
            counter = counter + 1;
         end
    end
    candi_lst = oper_lst;
    for k = 2:length(candi_lst)
        tmp = tmp + adj_mat(oper_lst(k-1),oper_lst(k));
    end
    radius_vec(i) = tmp;
end

radius = max(radius_vec);
%while counter~=N
%    [max_val,max_indx] = max(adj_mat(tmp_source,:));
%    adj_mat(tmp_source, max_indx) = 0;
%    adj_mat(max_indx, tmp_source) = 0;
%    radius = radius + max_val;
%    tmp_source = max_indx; 
%    counter = counter + 1;
%end
end
