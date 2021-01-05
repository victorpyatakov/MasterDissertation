function [ metric,path,b1 ] = vit_algoritm( k,L,sost_metk,exit_chanel,metric,path,takt,r,metric_new,path_new,conditional_prob )
  if takt >L
    
      
      [metric_max, index]=sortrows(metric);%��������� �� ����������
       
      q=index(end);
      b1=path(q,1);%�������� ��� ������� ������������ ��������
      path(:,1:end-1)=path(:,2:end);%����� ����� ���� �����
      
        y=L;
  else
      y=takt;
      b1=1;
  end
      
      r1=r;
for i=0:1:2^k-1
    
    %% ���������� ���������� ��������� , ����� ������ �����, ��� ��������� �� ��� ��� ��������� �����
    pred_sost_1=i*2;
    pred_sost_2=i*2+1;
    
    a=sost_metk(pred_sost_1+1,2:end);% ������� � ������� ������������ ���������-����� ����� ������ ��� 
    a1=sost_metk(pred_sost_2+1,2:end);
    
    %% ���������� ������� �� �����
    rebro1=mod(a+exit_chanel,2);
    rebro2=mod(a1+exit_chanel,2);
    
     
    p_e1=conditional_prob(bi2de(rebro1(1,1))+1,1);
    p_e2=conditional_prob(bi2de(rebro1(1,2))+1,1);
    m1=log2(p_e1)+log2(p_e2);%������� ����� 1
    
      
    p_e1=conditional_prob(bi2de(rebro2(1,1))+1,1);
    p_e2=conditional_prob(bi2de(rebro2(1,2))+1,1);
    m2=log2(p_e1)+log2(p_e2);%������� ����� 2

      %% ����������� ������������� ���� � ����������� ���������
      bit_pred_1=bitand(pred_sost_1,2^k)/(2^k);
      pred_sost_1=bitand(pred_sost_1,2^k-1);%����� � ������� ����� ��������� �� 0-� ��� ��� � ������ � ��� ���� ���� ��� 0-2^k-1,
      
      bit_pred_2=bitand(pred_sost_2,2^k)/(2^k);
          pred_sost_2=bitand(pred_sost_2,2^k-1);
          
%       [ pred_sost_1,bit_pred_1 ] = pred_sostoyanie( k,pred_sost_1 );
     
      
      metrica_nakop_1=metric(pred_sost_1+1,1)+m1;% ������� ������� ����������� �����
      metrica_nakop_2=metric(pred_sost_2+1,1)+m2;% ������� ������� ����������� �����

    %% ����� ��������� ������
    c=max(metrica_nakop_2,metrica_nakop_1);
         %% �������������� ����
    if c==metrica_nakop_1
   
        
        path_new(i+1,:)=path(pred_sost_1+1,:);
        path_new(i+1,y)=bit_pred_1;
        
    else
        path_new(i+1,:)=path(pred_sost_2+1,:);
          path_new(i+1,y)=bit_pred_2;
          
    end
    
    metric_new(i+1)=c;
       
    
end 
      
  metric=metric_new;
   path=path_new;  
end



