function [ path,path_new,metric,metric_new ] = path_and_metric_struct( k,L )
%% ������ ����� 2 ������ ������ ��� ������ ������ ���������� �� ����-���������,L ������ �������
path=ones(2^(k+1),L)*5;
path_new=ones(2^(k+1),L)*5;
%% ������ ������ � ��������� ������ ������� �������� 0 �� ������ ��������� �� ��������� -�������������

metric=zeros(2^(k+1),1);
metric_new=zeros(2^(k+1),1);

for i=1:1:2^(k+1)
    if i==1
        metric(i,1)=0;
    else
        metric(i,1)=-1*inf;
    end
end

end

