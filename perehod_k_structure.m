function [param_treils ] = perehod_k_structure( param_treils,k)
      
    
     mas=zeros(2^(k),k);
for i=0:1:2^(k)-1
    a=de2bi(i);
    mas(i+1,1:1:length(a))=a;
end
oo=1;
for i=1:2^k
    mas1(i,:)=[param_treils.last_bit_rebra_begin(mod(oo,4),1),mas(i,:)];
    oo=oo+2;
    
    param_treils.path(bi2de(mas1(i,:))+1,:)=param_treils.path_begin(i,:);
    param_treils.metric(bi2de(mas1(i,:))+1,1)=param_treils.metric_begin(i,1);
    param_treils.last_bit_rebra(bi2de(mas1(i,:))+1,1)=param_treils.last_bit_rebra_new_begin(i,1);
    
end
 param_treils = rmfield(param_treils, 'path_begin');
 param_treils= rmfield(param_treils, 'path_new_begin');
 param_treils = rmfield(param_treils, 'metric_new_begin ');
 param_treils = rmfield(param_treils, 'metric_begin  ');
 param_treils = rmfield(param_treils, 'last_bit_rebra_begin ');
 param_treils = rmfield(param_treils, 'last_bit_rebra_new_begin  ');


end

