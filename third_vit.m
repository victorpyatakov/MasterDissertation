function [ param_treils ] = third_vit( k,sost_metk,exit_chanel,conditional_prob,param_treils,y )
    
for i=0:1:2^(k+2)-2%иду по пред состояним

              if i>(2^(k+1))-1
                ii=i-7; %счетчик для путей и метрик
              else
                ii=i;
              end
              
    if i<2^(k+1)-1
            %% вычисление предыдущих состояний , путем сдвига влево, или умножения на два тек состояния ребра
            pred_sost_1=mod(i*2,2^(k+2));
            pred_sost_2=mod(i*2+1,2^(k+2));
            pred_sost_3=mod(i*2+2,2^(k+2));
            pred_sost_4=mod(i*2+3,2^(k+2));

            a=sost_metk(pred_sost_1+1,2:end);% смотрим в таблице соответствия состоянии-меток ребер нужное нам 
            a1=sost_metk(pred_sost_2+1,2:end);
            a2=sost_metk(pred_sost_3+1,2:end);% смотрим в таблице соответствия состоянии-меток ребер нужное нам 
            a3=sost_metk(pred_sost_4+1,2:end);

            %% вычисление метрики на ребре

            rebro1=mod(a+exit_chanel,2);
            rebro2=mod(a1+exit_chanel,2);
            rebro3=mod(a2+exit_chanel,2);
            rebro4=mod(a3+exit_chanel,2);

            %% подсчет метрики на ребре, сылаемся на таблицу условных вероятностей берем от туда нужный нам,...
        %первый 
     if param_treils.last_bit_rebra(mod(pred_sost_1,8)+1,1)==0
            rebro1=[0,rebro1];
            p_e1=conditional_prob(bi2de(rebro1(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro1(1,2:3))+1,2);
            m1=log2(p_e1)+log2(p_e2);%метрика ребра 1
     else 
         m1=-inf;
     end
     
     if param_treils.last_bit_rebra(mod(pred_sost_2,8)+1,1)==0
              rebro2=[0,rebro2];
            p_e1=conditional_prob(bi2de(rebro2(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro2(1,2:3))+1,2);
            m2=log2(p_e1)+log2(p_e2);%метрика ребра 2
     else
         m2=-inf;
     end
     
     if param_treils.last_bit_rebra(mod(pred_sost_3,8)+1,1)==0
              rebro3=[0,rebro3];
            p_e1=conditional_prob(bi2de(rebro3(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro3(1,2:3))+1,2);
            m3=log2(p_e1)+log2(p_e2);%метрика ребра 3
     else
         m3=-inf;
     end
     
     if param_treils.last_bit_rebra(mod(pred_sost_4,8)+1,1)==0
              rebro4=[0,rebro4];
            p_e1=conditional_prob(bi2de(rebro4(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro4(1,2:3))+1,2);
            m4=log2(p_e1)+log2(p_e2);%метрика ребра 4
     else
         m4=-inf;
     end
              %% определение передаваемого бита и предыдущего состояния
              bit_pred_1=bitand(pred_sost_1,2^(k+1))/(2^(k+1));%предполагаю что +l-величина связности
              pred_sost_1=bitand(pred_sost_1,2^(k+1)-1);%чтобы в массиве путей ссылаться на 0-к так как в начале у нас пред сост это 0-2^k-1,

              bit_pred_2=bitand(pred_sost_2,2^(k+1))/(2^(k+1));
                  pred_sost_2=bitand(pred_sost_2,2^(k+1)-1);

                       bit_pred_3=bitand(pred_sost_3,2^(k+1))/(2^(k+1));
                  pred_sost_3=bitand(pred_sost_3,2^(k+1)-1);

                       bit_pred_4=bitand(pred_sost_4,2^(k+1))/(2^(k+1));
                  pred_sost_4=bitand(pred_sost_4,2^(k+1)-1);



              metrica_nakop_1=param_treils.metric(pred_sost_1+1,1)+m1;% метрика первого предыдущего ребра
              metrica_nakop_2=param_treils.metric(pred_sost_2+1,1)+m2;% метрика второго предыдущего ребра
              metrica_nakop_3=param_treils.metric(pred_sost_3+1,1)+m3;% метрика первого предыдущего ребра
              metrica_nakop_4=param_treils.metric(pred_sost_4+1,1)+m4;% метрика второго предыдущего ребра

            %% выбор максимума метрик
            c=max(metrica_nakop_2,metrica_nakop_1);
            c1=max(metrica_nakop_3,metrica_nakop_4);
                 %% пересохранение пути
        
               if c>c1
                          if c==metrica_nakop_1


                             param_treils.path_new(ii+1,:)= param_treils.path(pred_sost_1+1,:);%так как тут i было и менялось 1 каждый так а теперь 2
                             param_treils.path_new(ii+1,y)=bit_pred_1;
                             if c==-inf
                                 param_treils.last_bit_rebra_new(ii+1,1)=5;
                             else
                             param_treils.last_bit_rebra_new(ii+1,1)=rebro1(1,end);%%%%
                             end
                          else 
                                
                             param_treils.path_new(ii+1,:)=param_treils.path(pred_sost_2+1,:);
                             param_treils.path_new(ii+1,y)=bit_pred_2;
                             if c==-inf
                                 param_treils.last_bit_rebra_new(ii+1,1)=5;
                             else
                                 param_treils.last_bit_rebra_new(ii+1,1)=rebro2(1,end);%%%%
                             end
                          end
                 else

                          if c1==metrica_nakop_3
                              
                             param_treils.path_new(ii+1,:)=param_treils.path(pred_sost_3+1,:);
                             param_treils.path_new(ii+1,y)=bit_pred_3;
                             if c1==-inf
                                 param_treils.last_bit_rebra_new(ii+1,1)=5;
                             else
                                 param_treils.last_bit_rebra_new(ii+1,1)=rebro3(1,end);%%%%
                             end
                          else
                               
                            param_treils.path_new(ii+1,:)= param_treils.path(pred_sost_4+1,:);
                            param_treils.path_new(ii+1,y)=bit_pred_4;
                            if c1==-inf
                                 param_treils.last_bit_rebra_new(ii+1,1)=5;
                            else
                                 param_treils.last_bit_rebra_new(ii+1,1)=rebro4(1,end);%%%%
                            end
                          end
               end
                
                         if c>c1

                            param_treils.metric_new(ii+1)=c;
                              
                         else

                            param_treils.metric_new(ii+1)=c1;  

                         end

else
     %% вычисление предыдущих состояний , путем сдвига влево, или умножения на два тек состояния ребра
            pred_sost_1=mod(i*2,2^(k+2));
            pred_sost_2=mod(i*2+1,2^(k+2));
            pred_sost_3=mod(i*2+2,2^(k+2));
            pred_sost_4=mod(i*2+3,2^(k+2));

            a=sost_metk(pred_sost_1+1,2:end);% смотрим в таблице соответствия состоянии-меток ребер нужное нам 
            a1=sost_metk(pred_sost_2+1,2:end);
            a2=sost_metk(pred_sost_3+1,2:end);% смотрим в таблице соответствия состоянии-меток ребер нужное нам 
            a3=sost_metk(pred_sost_4+1,2:end);

            %% вычисление метрики на ребре

            rebro1=mod(a+exit_chanel,2);
            rebro2=mod(a1+exit_chanel,2);
            rebro3=mod(a2+exit_chanel,2);
            rebro4=mod(a3+exit_chanel,2);

            %% подсчет метрики на ребре, сылаемся на таблицу условных вероятностей берем от туда нужный нам,...
        %первый 
     if param_treils.last_bit_rebra(mod(pred_sost_1,8)+1,1)==1
            rebro1=[1,rebro1];
            p_e1=conditional_prob(bi2de(rebro1(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro1(1,2:3))+1,2);
            m1=log2(p_e1)+log2(p_e2);%метрика ребра 1
     else 
         m1=-inf;
     end
     
     if param_treils.last_bit_rebra(mod(pred_sost_2,8)+1,1)==1
              rebro2=[1,rebro2];
            p_e1=conditional_prob(bi2de(rebro2(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro2(1,2:3))+1,2);
            m2=log2(p_e1)+log2(p_e2);%метрика ребра 2
     else
         m2=-inf;
     end
     
     if param_treils.last_bit_rebra(mod(pred_sost_3,8)+1,1)==1
              rebro3=[1,rebro3];
            p_e1=conditional_prob(bi2de(rebro3(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro3(1,2:3))+1,2);
            m3=log2(p_e1)+log2(p_e2);%метрика ребра 3
     else
         m3=-inf;
     end
     
     if param_treils.last_bit_rebra(mod(pred_sost_4,8)+1,1)==1
              rebro4=[1,rebro4];
            p_e1=conditional_prob(bi2de(rebro4(1,1:2))+1,2);
            p_e2=conditional_prob(bi2de(rebro4(1,2:3))+1,2);
            m4=log2(p_e1)+log2(p_e2);%метрика ребра 4
     else
         m4=-inf;
     end
              %% определение передаваемого бита и предыдущего состояния
              bit_pred_1=bitand(pred_sost_1,2^(k+1))/(2^(k+1));%предполагаю что +l-величина связности
              pred_sost_1=bitand(pred_sost_1,2^(k+1)-1);%чтобы в массиве путей ссылаться на 0-к так как в начале у нас пред сост это 0-2^k-1,

              bit_pred_2=bitand(pred_sost_2,2^(k+1))/(2^(k+1));
                  pred_sost_2=bitand(pred_sost_2,2^(k+1)-1);

                       bit_pred_3=bitand(pred_sost_3,2^(k+1))/(2^(k+1));
                  pred_sost_3=bitand(pred_sost_3,2^(k+1)-1);

                       bit_pred_4=bitand(pred_sost_4,2^(k+1))/(2^(k+1));
                  pred_sost_4=bitand(pred_sost_4,2^(k+1)-1);



              metrica_nakop_1=param_treils.metric(pred_sost_1+1,1)+m1;% метрика первого предыдущего ребра
              metrica_nakop_2=param_treils.metric(pred_sost_2+1,1)+m2;% метрика второго предыдущего ребра
              metrica_nakop_3=param_treils.metric(pred_sost_3+1,1)+m3;% метрика первого предыдущего ребра
              metrica_nakop_4=param_treils.metric(pred_sost_4+1,1)+m4;% метрика второго предыдущего ребра

            %% выбор максимума метрик
            c=max(metrica_nakop_2,metrica_nakop_1);
            c1=max(metrica_nakop_3,metrica_nakop_4);
                 %% пересохранение пути
        
               if c>c1
                          if c==metrica_nakop_1


                             param_treils.path_new(ii+1,:)= param_treils.path(pred_sost_1+1,:);%так как тут i было и менялось 1 каждый так а теперь 2
                             param_treils.path_new(ii+1,y)=bit_pred_1;
                             if c==-inf
                                 param_treils.last_bit_rebra_new(ii+1,1)=5;
                             else
                                param_treils.last_bit_rebra_new(ii+1,1)=rebro1(1,end);%%%%
                             end
                          else 
                                
                             param_treils.path_new(ii+1,:)=param_treils.path(pred_sost_2+1,:);
                             param_treils.path_new(ii+1,y)=bit_pred_2;
                             if c==-inf
                                 param_treils.last_bit_rebra_new(ii+1,1)=5;
                             else
                                 param_treils.last_bit_rebra_new(ii+1,1)=rebro2(1,end);%%%%
                             end
                          end
                 else

                          if c1==metrica_nakop_3
                              
                             param_treils.path_new(ii+1,:)=param_treils.path(pred_sost_3+1,:);
                             param_treils.path_new(ii+1,y)=bit_pred_3;
                             if c1==-inf
                                 param_treils.last_bit_rebra_new(ii+1,1)=5;
                             else
                                 param_treils.last_bit_rebra_new(ii+1,1)=rebro3(1,end);%%%%
                             end
                          else
                               
                            param_treils.path_new(ii+1,:)= param_treils.path(pred_sost_4+1,:);
                            param_treils.path_new(ii+1,y)=bit_pred_4;
                            if c1==-inf
                                 param_treils.last_bit_rebra_new(ii+1,1)=5;
                            else
                                 param_treils.last_bit_rebra_new(ii+1,1)=rebro4(1,end);%%%%
                            end
                          end
               end
                
                         if c>c1

                            param_treils.metric_new(ii+1)=c;
                              
                         else

                            param_treils.metric_new(ii+1)=c1;  

                         end
     end 
end
          param_treils.metric=param_treils.metric_new;
           param_treils.path=param_treils.path_new;  
           param_treils.last_bit_rebra=param_treils.last_bit_rebra_new;
end

