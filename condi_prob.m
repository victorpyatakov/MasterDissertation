function con = condi_prob(a)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 fid = fopen(a, 'rb');  % �������� ����� �� ������ 
if fid == -1 
    error('File is not opened'); 
end 
  
B=0;                % ������������� ���������� 
cnt=1;              % ������������� �������� 
while ~feof(fid)    % ����, ���� �� ��������� ����� ����� 
    [V,N] = fread(fid, 1, 'double');  %���������� ������ 
% �������� double (V �������� �������� 
% ��������, N � ����� ��������� ���������) 
    if N > 0        % ���� ������� ��� �������� �������, �� 
        B(cnt)=V;   % ��������� ������-������ �� �������� V 
        cnt=cnt+1;  % ����������� ������� �� 1 
    end 
end 
% disp(B);            % ����������� ���������� �� ����� 
fclose(fid);        % �������� �����

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

