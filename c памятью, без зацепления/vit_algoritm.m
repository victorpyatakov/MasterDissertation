function [ metric,path,b1 ] = vit_algoritm( k,L,sost_metk,exit_chanel,metric,path,takt,r,metric_new,path_new,conditional_prob )
  if takt >L
    
      
      [metric_max, index]=sortrows(metric);%сортирует по возратанию
       
      q=index(end);
      b1=path(q,1);%выбираем бит который соотвествует входному
      path(:,1:end-1)=path(:,2:end);%сдвиг влево всех путей
      
        y=L;
  else
      y=takt;
      b1=1;
  end
      
      r1=r;
for i=0:1:2^k-1
    
    %% вычисление предыдущих состояний , путем сдвига влево, или умножения на два тек состояния ребра
    pred_sost_1=i*2;
    pred_sost_2=i*2+1;
    
    a=sost_metk(pred_sost_1+1,2:end);% смотрим в таблице соответствия состоянии-меток ребер нужное нам 
    a1=sost_metk(pred_sost_2+1,2:end);
    
    %% вычисление метрики на ребре
    rebro1=mod(a+exit_chanel,2);
    rebro2=mod(a1+exit_chanel,2);
    
     
    p_e1=conditional_prob(bi2de(rebro1(1,1))+1,1);
    p_e2=conditional_prob(bi2de(rebro1(1,2))+1,1);
    m1=log2(p_e1)+log2(p_e2);%метрика ребра 1
    
      
    p_e1=conditional_prob(bi2de(rebro2(1,1))+1,1);
    p_e2=conditional_prob(bi2de(rebro2(1,2))+1,1);
    m2=log2(p_e1)+log2(p_e2);%метрика ребра 2

      %% определение передаваемого бита и предыдущего состояния
      bit_pred_1=bitand(pred_sost_1,2^k)/(2^k);
      pred_sost_1=bitand(pred_sost_1,2^k-1);%чтобы в массиве путей ссылаться на 0-к так как в начале у нас пред сост это 0-2^k-1,
      
      bit_pred_2=bitand(pred_sost_2,2^k)/(2^k);
          pred_sost_2=bitand(pred_sost_2,2^k-1);
          
%       [ pred_sost_1,bit_pred_1 ] = pred_sostoyanie( k,pred_sost_1 );
     
      
      metrica_nakop_1=metric(pred_sost_1+1,1)+m1;% метрика первого предыдущего ребра
      metrica_nakop_2=metric(pred_sost_2+1,1)+m2;% метрика второго предыдущего ребра

    %% выбор максимума метрик
    c=max(metrica_nakop_2,metrica_nakop_1);
         %% пересохранение пути
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



