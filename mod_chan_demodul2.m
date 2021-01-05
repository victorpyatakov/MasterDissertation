function [ r0,r1,x,y ] = mod_chan_demodul2( a,x,y,p,SNR )
% theta_sluch=rand*2*pi;% СЛУЧ ФАЗА 
persistent p1 p2 A3 
if nargin==5
    p1=p;
    p2=sqrt(1-p*p);
    A3=sqrt(SNR);
end
      nc0= randn;
  
      nc1= randn;
  
         ns0= randn;
     
            ns1= randn;
            %%
            x_pred=x;%пред х
            y_pred=y;%пред y
            
%            p=0.95;%параметр ро
      
           
           x=p1*x_pred+p2*randn;
           y=p1*y_pred+p2*randn;
           
%         H=sqrt(x*x+y*y);%мю
        
        
        %%

%    if a==0
%      
%         r0=(H*A3*cos(theta_sluch)+nc0)^2+ (H*A3*sin(theta_sluch)+ns0)^2;
%         r1=(nc1^2)+(ns1^2);
%    else
%          r1=(H*A3*cos(theta_sluch)+nc1)^2+(H*A3*sin(theta_sluch)+ns1)^2;
%          r0=(nc0^2)+(ns0^2);
%    end
   
   if a==0
     
        r0=(A3*x+nc0)^2+(A3*y+ns0)^2;
        r1=(nc1^2)+(ns1^2);
   else
         r1=(A3*x+nc1)^2+(A3*y+ns1)^2;
         r0=(nc0^2)+(ns0^2);
   end

end

