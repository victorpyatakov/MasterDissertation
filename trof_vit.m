function [ param_treils ] = trof_vit( k,sost_metk,exit_chanel,conditional_prob,param_treils,y )
  ii=0;  
for i=0:1:2^(k+1)-1%��� �� ���� ���������
            
      if i==(2^(k))
                ii=0; %������� ��� ����� � ������
             
      end
    
    
    %% ���������� ���������� ��������� , ����� ������ �����, ��� ��������� �� ��� ��� ��������� �����
              pred_sost_1=i*2;
        pred_sost_2=i*2+1;

        a=sost_metk(pred_sost_1+1,2:end);% ������� � ������� ������������ ���������-����� ����� ������ ��� 
        a1=sost_metk(pred_sost_2+1,2:end);
        

            %% ���������� ������� �� �����

            rebro1=mod(a+exit_chanel,2);
            rebro2=mod(a1+exit_chanel,2);

            %% ������� ������� �� �����, �������� �� ������� �������� ������������ ����� �� ���� ������ ���,...
        %������ 
     
            rebro1=[0,rebro1];
            p_e1=conditional_prob(bi2de(rebro1(1,1:k))+1,2);
            p_e2=conditional_prob(bi2de(rebro1(1,2:3))+1,2);
            m1=log2(p_e1)+log2(p_e2);%������� ����� 1
 
     
     
            rebro2=[1,rebro2];
            p_e1=conditional_prob(bi2de(rebro2(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro2(1,2:3))+1,2);
            m2=log2(p_e1)+log2(p_e2);%������� ����� 2
    
     

              %% ����������� ������������� ���� � ����������� ���������
              bit_pred_1=bitand(pred_sost_1,2^(k+1))/(2^(k+1));%����������� ��� +l-�������� ���������
              pred_sost_1=bitand(pred_sost_1,2^(k+1)-1);%����� � ������� ����� ��������� �� 0-� ��� ��� � ������ � ��� ���� ���� ��� 0-2^k-1,

              bit_pred_2=bitand(pred_sost_2,2^(k+1))/(2^(k+1));
                  pred_sost_2=bitand(pred_sost_2,2^(k+1)-1);

              metrica_nakop_1=param_treils.metric(pred_sost_1+1,1)+m1;% ������� ������� ����������� �����
              metrica_nakop_2=param_treils.metric(pred_sost_2+1,1)+m2;% ������� ������� ����������� �����
            
            %% ����� ��������� ������
            c=max(metrica_nakop_2,metrica_nakop_1);
         
                 %% �������������� ����
        
               if c==metrica_nakop_1
                       

                             param_treils.path_new(ii+1+rebro1(1,end),:)= param_treils.path(pred_sost_1+1,:);%��� ��� ��� i ���� � �������� 1 ������ ��� � ������ 2
                             param_treils.path_new(ii+1+rebro1(1,end),y)=bit_pred_1;
                            
%                              param_treils.last_bit_rebra_new(ii+1,1)=rebro1(1,end);%%%%
                             
                          else 
                                
                             param_treils.path_new(ii+1+rebro1(1,end),:)=param_treils.path(pred_sost_2+1,:);
                             param_treils.path_new(ii+1+rebro1(1,end),y)=bit_pred_2;
                            
%                                  param_treils.last_bit_rebra_new(ii+1,1)=rebro2(1,end);%%%%
                          
                end

        
                
                     

                            param_treils.metric_new(ii+1+rebro1(1,end))=c;
                              
                         


ii=ii+2;
end
          param_treils.metric=param_treils.metric_new;
           param_treils.path=param_treils.path_new;  
%            param_treils.last_bit_rebra=param_treils.last_bit_rebra_new;
end

