function [vlst,leaf_nodes] = depth_first_search(adj_mat,source)
%...Note: this code is only applicable for MSTs.
N = length(adj_mat(1,:));
tmp_source  = source;
%adj_mat(adj_mat == 0) = Inf;
ordered_lst = [];
ordered_lst = [ordered_lst;source];
counter = zeros(1,N);
counter(tmp_source) = 1;
num_unvisited = N-1;
leaf_nodes = [];
if source + 1>N
   next_pt_indi = source -1;
else
   next_pt_indi = source + 1; 
end

while next_pt_indi~=source || num_unvisited ~= 0
[next_indx] = find(adj_mat(tmp_source,:));% node ID of next adjcent nodes

if length(next_indx) == 1 
%next_point = orig_lst(min_val);
next_point = next_indx;

if counter(next_indx) == 0
   num_unvisited = num_unvisited -1; 
else
   leaf_nodes = [leaf_nodes;tmp_source];% leaf node is discovered...
end
else
    if ~isempty(find(counter(next_indx), 1)) %some nodes are visited... 
        if isempty(find(~counter(next_indx), 1))
            % no unvisited nodes...
            first_indx = zeros(1,length(next_indx));
            for i = 1:length(next_indx)
                first_indx(i) = find(ordered_lst == next_indx(i), 1 );% location where it first appreas.
            end
            [~,first_min_indx] = min(first_indx);
            next_point = next_indx(first_min_indx);% move to the parent node
        else
            unvisited_nodes = next_indx(counter(next_indx) == 0);
            [~,min_indx_tmp] = min(adj_mat(tmp_source,unvisited_nodes));
            next_point = unvisited_nodes(min_indx_tmp); 
            num_unvisited = num_unvisited -1; 
        end
    else 
        [~,min_indx_tmp] = min(adj_mat(tmp_source,next_indx));
        next_point = next_indx(min_indx_tmp); 
        num_unvisited = num_unvisited -1; 
    end
end
tmp_source = next_point;
next_pt_indi = next_point;
ordered_lst = [ordered_lst;next_point];% concatenate next point.
counter(next_point) = counter(next_point) + 1;
end
%ordered_lst = [ordered_lst;source];
vlst = ordered_lst;
end