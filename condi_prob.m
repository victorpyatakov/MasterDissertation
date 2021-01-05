function con = condi_prob(a)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 fid = fopen(a, 'rb');  % открытие файла на чтение 
if fid == -1 
    error('File is not opened'); 
end 
  
B=0;                % инициализаци€ переменной 
cnt=1;              % инициализаци€ счетчика 
while ~feof(fid)    % цикл, пока не достигнут конец файла 
    [V,N] = fread(fid, 1, 'double');  %считывание одного 
% значени€ double (V содержит значение 
% элемента, N Ц число считанных элементов) 
    if N > 0        % если элемент был прочитан успешно, то 
        B(cnt)=V;   % формируем вектор-строку из значений V 
        cnt=cnt+1;  % увеличиваем счетчик на 1 
    end 
end 
% disp(B);            % отображение результата на экран 
fclose(fid);        % закрытие файла

con=zeros(4,2,11);
 x=1;
 for i=1:11
     for j=1:2
         for k=1:4
             con(k,j,i)=B(1,x);
             x=x+1;
         end
     end
 end
 

end

