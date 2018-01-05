function [sym_mat,G_MST] = core_algo(adj_mat,epsilon,source)
n = length(adj_mat(:,1));
%flagV = zeros(n,1);%store visted or not
start_pt = source;
%flagV(start_pt) = 1;%set initial point visited
%fprintf('Starting point is selected as %d\n',start_pt);
UnvisitedV = 1:n;
sym_mat = zeros(n);
%counter = 0;

VisitedV = start_pt;
UnvisitedV(start_pt) = [];
dist_mat = adj_mat;

dist_mat(dist_mat==0) = Inf;
adj_mat(adj_mat==0) = Inf;
for i = 1:n
    dist_mat(i,i) = 0;
    adj_mat(i,i) = 0;
end

while length(VisitedV)~= n || ~isempty(UnvisitedV)
    %VisitedV = find(flagV);
    %UnvisitedV = find(~flagV);
    min_val = Inf;
    next_pt_inx = 0;
    for j = 1:length(VisitedV)
        for k = 1:length(UnvisitedV)
            %...Update shortest path to source
            alt = dist_mat(source,VisitedV(j)) + adj_mat(VisitedV(j),UnvisitedV(k));
            if alt < dist_mat(source,UnvisitedV(k))
                dist_mat(source,UnvisitedV(k)) = alt;
                dist_mat(UnvisitedV(k),source) = alt; 
            end
            %...mixture of two algorithms
            tmp = adj_mat(VisitedV(j),UnvisitedV(k)) + epsilon*dist_mat(source,VisitedV(j));
            
                        
            %if length(UnvisitedV) < next_pt_inx
            %    fprintf('who are you!!!\n');
            %end
            
            if min_val > tmp && tmp ~= 0
                min_val = tmp;
                tmp_star_pt = VisitedV(j);
                tmp_end_pt = UnvisitedV(k);
                next_pt_inx = k;
            %elseif length(UnvisitedV) == 1
            %    next_pt_inx = k;
            end

        end
    end
    try 
        UnvisitedV(next_pt_inx) = [];
    catch
        warning('ERrror in deletion\n.');
    end
    VisitedV = [VisitedV,tmp_end_pt];
    sym_mat(tmp_star_pt,tmp_end_pt) = dist_mat(tmp_star_pt,tmp_end_pt);
    sym_mat(tmp_end_pt,tmp_star_pt) = sym_mat(tmp_star_pt,tmp_end_pt);
    %counter = counter + 1;
end
G_MST = graph(sym_mat);
end

