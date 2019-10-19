function Codee=SCMA_coding(X,codebook,i)

  if X(i)==-1.000000000000000 - 1.000000000000000i
      Codee=codebook(:,1);
  elseif X(i)==-1.000000000000000 + 1.000000000000000i
      Codee=codebook(:,2);
  elseif X(i)== 1.000000000000000 - 1.000000000000000i
      Codee=codebook(:,3);
  elseif X(i)== 1.000000000000000 + 1.000000000000000i
      Codee=codebook(:,4);
  end

end