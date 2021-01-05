function [ c,reg ] = ConvEncoder( b,reg,g,n )
reg(2:end)=reg(1:end-1);
reg(1)=b;
  for i=1:1:n
    c(i)=mod(sum(reg&g(i,:)),2);
  end
end

