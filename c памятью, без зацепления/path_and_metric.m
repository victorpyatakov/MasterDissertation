function [ path,path_new,metric,metric_new ] = path_and_metric( k,L )
%% массив путей 2 мерный массив где каждая строка обозначает ее путь-состояние,L длинна прохода
path=ones(2^k,L)*5;
path_new=ones(2^k,L)*5;
%% массив метрик в начальный момент времени хранится 0 на первом состоянии на остальных -бесконечность

metric=zeros(2^k,1);
metric_new=zeros(2^k,1);

for i=1:1:2^k
    if i==1
        metric(i,1)=0;
    else
        metric(i,1)=-1*inf;
    end
end

end

