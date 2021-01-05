function [ param_treils ] = trof_vit( k,sost_metk,exit_chanel,conditional_prob,param_treils,y )
  ii=0;  
for i=0:1:2^(k+1)-1%иду по пред состояним
            
      if i==(2^(k))
                ii=0; %счетчик для путей и метрик
             
      end
    
    
    %% вычисление предыдущих состояний , путем сдвига влево, или умножения на два тек состояния ребра
              pred_sost_1=i*2;
        pred_sost_2=i*2+1;

        a=sost_metk(pred_sost_1+1,2:end);% смотрим в таблице соответствия состоянии-меток ребер нужное нам 
        a1=sost_metk(pred_sost_2+1,2:end);
        

            %% вычисление метрики на ребре

            rebro1=mod(a+exit_chanel,2);
            rebro2=mod(a1+exit_chanel,2);

            %% подсчет метрики на ребре, сылаемся на таблицу условных вероятностей берем от туда нужный нам,...
        %первый 
     
            rebro1=[0,rebro1];
            p_e1=conditional_prob(bi2de(rebro1(1,1:k))+1,2);
            p_e2=conditional_prob(bi2de(rebro1(1,2:3))+1,2);
            m1=log2(p_e1)+log2(p_e2);%метрика ребра 1
 
     
     
            rebro2=[1,rebro2];
            p_e1=conditional_prob(bi2de(rebro2(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro2(1,2:3))+1,2);
            m2=log2(p_e1)+log2(p_e2);%метрика ребра 2
    
     

              %% определение передаваемого бита и предыдущего состояния
              bit_pred_1=bitand(pred_sost_1,2^(k+1))/(2^(k+1));%предполагаю что +l-величина связности
              pred_sost_1=bitand(pred_sost_1,2^(k+1)-1);%чтобы в массиве путей ссылаться на 0-к так как в начале у нас пред сост это 0-2^k-1,

              bit_pred_2=bitand(pred_sost_2,2^(k+1))/(2^(k+1));
                  pred_sost_2=bitand(pred_sost_2,2^(k+1)-1);

              metrica_nakop_1=param_treils.metric(pred_sost_1+1,1)+m1;% метрика первого предыдущего ребра
              metrica_nakop_2=param_treils.metric(pred_sost_2+1,1)+m2;% метрика второго предыдущего ребра
            
            %% выбор максимума метрик
            c=max(metrica_nakop_2,metrica_nakop_1);
         
                 %% пересохранение пути
        
               if c==metrica_nakop_1
                       

                             param_treils.path_new(ii+1+rebro1(1,end),:)= param_treils.path(pred_sost_1+1,:);%так как тут i было и менялось 1 каждый так а теперь 2
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

