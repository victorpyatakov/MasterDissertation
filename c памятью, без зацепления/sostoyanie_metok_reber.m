function [ sost_metk ] = sostoyanie_metok_reber( k,n,g )
%% массив состоянии- меток ребер в дес виде
%% массив всех переходов
 mas=zeros(2^(k+1),k+1);
for i=0:1:2^(k+1)-1
    a=de2bi(i);
    mas(i+1,1:1:length(a))=a;
end
mas1 = fliplr(mas);%зеркально отраженная версия массива так как метки ребер правильные

rebro=zeros(2^(k+1),n);
%% все возможные метки ребер
for i=1:1:2^(k+1)
   for j=1:1:n
   
    rebro(i,j)=mod(sum(mas1(i,:)&g(j,:)),2);
    
   end
end

sost_metk=zeros(2^(k+1),n+1);


for i=1:1:2^(k+1)
    
    sost_metk(i,1)=i-1;
    sost_metk(i,2:1:end)=rebro(i,1:end);
    
    
end

end

