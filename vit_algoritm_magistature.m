function [ param_treils,b1 ] = vit_algoritm_magistature( k,L,sost_metk,sost_metk_bigin,exit_chanel,takt,conditional_prob,param_treils )
  
  if takt >L
    
      
      [metric_max, index]=sortrows(param_treils.metric);%��������� �� ����������
       
      q=index(end);
      b1=param_treils.path(q,1);%�������� ��� ������� ������������ ��������
      param_treils.path(:,1:end-1)=param_treils.path(:,2:end);%����� ����� ���� �����
      
        y=L;
  else
      y=takt;
      b1=1;
  end
   
 if takt==1 % ��� 1: ������ ������
     
    param_treils = begin_vit(k,sost_metk_bigin,exit_chanel,conditional_prob,param_treils,y);
     
       param_treils  = perehod_k_structure( param_treils,k);
%  elseif takt==2 % ��� 2: ���������� �������
% 
%     param_treils = second_vit(k,sost_metk_bigin,exit_chanel,conditional_prob,param_treils,y);
%       
%     param_treils  = perehod_k_structure( param_treils,k);

 else % ��� 3: ������ ���������
   
%      param_treils  = third_vit( k,sost_metk,exit_chanel,conditional_prob,param_treils,y );
        param_treils  = trof_vit( k,sost_metk,exit_chanel,conditional_prob,param_treils,y );   
 end
 
 
 
 
 
 
 
 
 
% % % %  
% % % %   for i=0:2:2^(k+2)-2%��� �� ���� ���������
% % % % 
% % % %               if i>(2^(k+1))-1
% % % %                 ii=i-7; %������� ��� ����� � ������
% % % %               else
% % % %                 ii=i;
% % % %               end
% % % % 
% % % %             %% ���������� ���������� ��������� , ����� ������ �����, ��� ��������� �� ��� ��� ��������� �����
% % % %             pred_sost_1=mod(i*2,2^(k+2));
% % % %             pred_sost_2=mod(i*2+1,2^(k+2));
% % % %             pred_sost_3=mod(i*2+2,2^(k+2));
% % % %             pred_sost_4=mod(i*2+3,2^(k+2));
% % % % 
% % % %             a=sost_metk(pred_sost_1+1,2:end);% ������� � ������� ������������ ���������-����� ����� ������ ��� 
% % % %             a1=sost_metk(pred_sost_2+1,2:end);
% % % %             a2=sost_metk(pred_sost_3+1,2:end);% ������� � ������� ������������ ���������-����� ����� ������ ��� 
% % % %             a3=sost_metk(pred_sost_4+1,2:end);
% % % % 
% % % %             %% ���������� ������� �� �����
% % % % 
% % % %             rebro1=mod(a+exit_chanel,2);
% % % %             rebro2=mod(a1+exit_chanel,2);
% % % %             rebro3=mod(a2+exit_chanel,2);
% % % %             rebro4=mod(a3+exit_chanel,2);
% % % % 
% % % %             %% ������� ������� �� �����, �������� �� ������� �������� ������������ ����� �� ���� ������ ���,...
% % % %         %������ 
% % % %         % if i<2^(k+1)
% % % %             rebro1=[0,rebro1];
% % % %             p_e1=conditional_prob(bi2de(rebro1(1,1:2))+1,2);
% % % %             p_e2=conditional_prob(bi2de(rebro1(1,2:3))+1,2);
% % % %             m1=log2(p_e1)+log2(p_e2);%������� ����� 1
% % % % 
% % % %               rebro2=[1,rebro2];
% % % %             p_e1=conditional_prob(bi2de(rebro2(1,1:2))+1,2);
% % % %             p_e2=conditional_prob(bi2de(rebro2(1,2:3))+1,2);
% % % %             m2=log2(p_e1)+log2(p_e2);%������� ����� 2
% % % % 
% % % %               rebro3=[0,rebro3];
% % % %             p_e1=conditional_prob(bi2de(rebro3(1,1:2))+1,2);
% % % %             p_e2=conditional_prob(bi2de(rebro3(1,2:3))+1,2);
% % % %             m3=log2(p_e1)+log2(p_e2);%������� ����� 3
% % % % 
% % % %               rebro4=[1,rebro4];
% % % %             p_e1=conditional_prob(bi2de(rebro4(1,1:2))+1,2);
% % % %             p_e2=conditional_prob(bi2de(rebro4(1,2:3))+1,2);
% % % %             m4=log2(p_e1)+log2(p_e2);%������� ����� 4
% % % %         %     
% % % %         % else
% % % %         %     
% % % %         %    rebro1=[1,rebro1];
% % % %         %     p_e1=conditional_prob(bi2de(rebro1(1,1:2))+1,2);
% % % %         %     p_e2=conditional_prob(bi2de(rebro1(1,2:3))+1,2);
% % % %         %     m1=log2(p_e1)+log2(p_e2);%������� ����� 1
% % % %         %     
% % % %         %       rebro2=[1,rebro2];
% % % %         %     p_e1=conditional_prob(bi2de(rebro2(1,1:2))+1,2);
% % % %         %     p_e2=conditional_prob(bi2de(rebro2(1,2:3))+1,2);
% % % %         %     m2=log2(p_e1)+log2(p_e2);%������� ����� 2
% % % %         %     
% % % %         %       rebro3=[1,rebro3];
% % % %         %     p_e1=conditional_prob(bi2de(rebro3(1,1:2))+1,2);
% % % %         %     p_e2=conditional_prob(bi2de(rebro3(1,2:3))+1,2);
% % % %         %     m3=log2(p_e1)+log2(p_e2);%������� ����� 3
% % % %         % 
% % % %         %       rebro4=[1,rebro4];
% % % %         %     p_e1=conditional_prob(bi2de(rebro4(1,1:2))+1,2);
% % % %         %     p_e2=conditional_prob(bi2de(rebro4(1,2:3))+1,2);
% % % %         %     m4=log2(p_e1)+log2(p_e2);%������� ����� 4
% % % %         % end
% % % % 
% % % %               %% ����������� ������������� ���� � ����������� ���������
% % % %               bit_pred_1=bitand(pred_sost_1,2^(k+1))/(2^(k+1));%����������� ��� +l-�������� ���������
% % % %               pred_sost_1=bitand(pred_sost_1,2^(k+1)-1);%����� � ������� ����� ��������� �� 0-� ��� ��� � ������ � ��� ���� ���� ��� 0-2^k-1,
% % % % 
% % % %               bit_pred_2=bitand(pred_sost_2,2^(k+1))/(2^(k+1));
% % % %                   pred_sost_2=bitand(pred_sost_2,2^(k+1)-1);
% % % % 
% % % %                        bit_pred_3=bitand(pred_sost_3,2^(k+1))/(2^(k+1));
% % % %                   pred_sost_3=bitand(pred_sost_3,2^(k+1)-1);
% % % % 
% % % %                        bit_pred_4=bitand(pred_sost_4,2^(k+1))/(2^(k+1));
% % % %                   pred_sost_4=bitand(pred_sost_4,2^(k+1)-1);
% % % % 
% % % % 
% % % %         %       [ pred_sost_1,bit_pred_1 ] = pred_sostoyanie( k,pred_sost_1 );
% % % % 
% % % % 
% % % %               metrica_nakop_1=metric(pred_sost_1+1,1)+m1;% ������� ������� ����������� �����
% % % %               metrica_nakop_2=metric(pred_sost_2+1,1)+m2;% ������� ������� ����������� �����
% % % %               metrica_nakop_3=metric(pred_sost_3+1,1)+m3;% ������� ������� ����������� �����
% % % %               metrica_nakop_4=metric(pred_sost_4+1,1)+m4;% ������� ������� ����������� �����
% % % % 
% % % %             %% ����� ��������� ������
% % % %             c=max(metrica_nakop_2,metrica_nakop_1);
% % % %             c1=max(metrica_nakop_3,metrica_nakop_4);
% % % %                  %% �������������� ����
% % % %         %          if c>c1
% % % %         %                     if c==metrica_nakop_1
% % % %         %    
% % % %         % 
% % % %         %                     path_new(ii+1,:)=path(pred_sost_1+1,:);%��� ��� ��� i ���� � �������� 1 ������ ��� � ������ 2
% % % %         %                     path_new(ii+1,y)=bit_pred_1;
% % % %         % 
% % % %         %                     else 
% % % %         %                             path_new(ii+1,:)=path(pred_sost_2+1,:);
% % % %         %                               path_new(ii+1,y)=bit_pred_2;
% % % %         %                     end
% % % %         %          else
% % % %         %           
% % % %         %                    if c1==metrica_nakop_3
% % % %         %                     path_new(ii+1,:)=path(pred_sost_3+1,:);
% % % %         %                       path_new(ii+1,y)=bit_pred_3;
% % % %         % 
% % % %         %                    else
% % % %         %                     path_new(ii+1,:)=path(pred_sost_4+1,:);
% % % %         %                       path_new(ii+1,y)=bit_pred_4;
% % % %         % 
% % % %         %                   end
% % % %         %         end
% % % %         %     if c>c1
% % % %         %       metric_new(ii+1)=c;
% % % %         %     else
% % % %         %       metric_new(ii+1)=c1;  
% % % %         %     end
% % % %                if c>c1
% % % %                             if c==metrica_nakop_1
% % % % 
% % % % 
% % % %                             path_new(ii+1,:)=path(pred_sost_1+1,:);%��� ��� ��� i ���� � �������� 1 ������ ��� � ������ 2
% % % %                             path_new(ii+1,y)=bit_pred_1;
% % % % 
% % % %                             else 
% % % %                                     path_new(ii+1,:)=path(pred_sost_2+1,:);
% % % %                                       path_new(ii+1,y)=bit_pred_2;
% % % %                             end
% % % %                  else
% % % % 
% % % %                            if c1==metrica_nakop_3
% % % %                             path_new(ii+1,:)=path(pred_sost_3+1,:);
% % % %                               path_new(ii+1,y)=bit_pred_3;
% % % % 
% % % %                            else
% % % %                             path_new(ii+1,:)=path(pred_sost_4+1,:);
% % % %                               path_new(ii+1,y)=bit_pred_4;
% % % % 
% % % %                           end
% % % %                 end
% % % %             if c>c1
% % % %               metric_new(ii+1)=c;
% % % %             else
% % % %               metric_new(ii+1)=c1;  
% % % %             end
% % % % 
% % % % 
% % % %         end 
% % % % 
% % % %           metric=metric_new;
% % % %            path=path_new;
end



