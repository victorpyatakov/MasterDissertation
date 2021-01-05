function [ sost_metk ] = sostoyanie_metok_reber( k,n,g )
%% массив состоянии- меток ребер в дес виде
%% массив всех переходов
 mas=zeros(2^(k+1),k+1);
for i=0:1:2^(k+1)-1
    a=de2bi(i);
    mas(i+1,1:1:length(a))=a;
end
 mas1 = fliplr(mas);%зеркально отраженная версия массива так как метки ребер правильные

% f=1;
% for i=1:4:2^(k+2)-1
%     mass(i,:)=[mas1(f,:),0];
%     mass(i+1,:)=[mas1(f+1,:),0];
%     mass(i+2,:)=[mas1(f,:),1];
%     mass(i+3,:)=[mas1(f+1,:),1];
%     f=f+2;
% end


rebro=zeros(2^(k+1),n);
%% все возможные метки ребер
for i=1:1:2^(k+1)
   for j=1:1:n
   
    rebro(i,j)=mod(sum(mas(i,:)&g(j,:)),2);
    
   end
end

rebro1=rebro(1:2:end,:);
rebro2=rebro(2:2:end,:);
rebro=[rebro1;rebro2];
%%

%%
%sost_metk=zeros(2^(k+1),n+1);
sost_metk=zeros(2^(k+2),n+1);

v=1;
for i=1:1:2^(k+2)
    
    sost_metk(i,1)=i-1;
    sost_metk(i,2:1:end)=rebro(v,1:end);
    if mod(i,2)==0
        v=v+1;
    end
    
end



end

