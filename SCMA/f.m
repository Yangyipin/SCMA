function [data]=f(signum,Xmode_r,fab,c,codebook1,codebook2,codebook3,codebook4,codebook5,codebook6)
  %�˺��������������ı��� �������f1�ز���m1�йص�F��������ֵ
  %signum��ʾ�������ݵĵڼ������ݣ�Xmode_r��ʾ��������ݣ�fab��ʾ�ڼ������ز���c��ʾ�ڼ����û��Ӷ����������ں�������ĺ�����codem��ʾ�뱾�еڼ�������
  if c==1
      ab=1;
    for m1=1:4
    for m2=1:4
    for m3=1:4
        f1(ab)=-(abs(Xmode_r(signum)-codebook2(1,m1)-codebook3(1,m2)-codebook5(1,m3))).^2;
        f2(ab)=-(abs(Xmode_r(signum+64)-codebook1(2,m1)-codebook3(2,m2)-codebook6(2,m3))).^2;
        f3(ab)=-(abs(Xmode_r(signum+128)-codebook2(3,m1)-codebook4(3,m2)-codebook6(3,m3))).^2;
        f4(ab)=-(abs(Xmode_r(signum+192)-codebook1(4,m1)-codebook4(4,m2)-codebook5(4,m3))).^2;
        ab=ab+1;
    end
    end
    end
       else if c==2
               ab=1;
             for m2=1:4
             for m1=1:4
             for m3=1:4
                 f1(ab)=-(abs(Xmode_r(signum)-codebook2(1,m1)-codebook3(1,m2)-codebook5(1,m3))).^2;
                 f2(ab)=-(abs(Xmode_r(signum+64)-codebook1(2,m1)-codebook3(2,m2)-codebook6(2,m3))).^2;
                 f3(ab)=-(abs(Xmode_r(signum+128)-codebook2(3,m1)-codebook4(3,m2)-codebook6(3,m3))).^2;
                 f4(ab)=-(abs(Xmode_r(signum+192)-codebook1(4,m1)-codebook4(4,m2)-codebook5(4,m3))).^2;
                     ab=ab+1;
             end
             end
             end
                else if c==3
                        ab=1;
                     for m3=1:4
                     for m1=1:4
                     for m2=1:4
                            f1(ab)=-(abs(Xmode_r(signum)-codebook2(1,m1)-codebook3(1,m2)-codebook5(1,m3))).^2;
                            f2(ab)=-(abs(Xmode_r(signum+64)-codebook1(2,m1)-codebook3(2,m2)-codebook6(2,m3))).^2;
                            f3(ab)=-(abs(Xmode_r(signum+128)-codebook2(3,m1)-codebook4(3,m2)-codebook6(3,m3))).^2;
                            f4(ab)=-(abs(Xmode_r(signum+192)-codebook1(4,m1)-codebook4(4,m2)-codebook5(4,m3))).^2;
                                ab=ab+1;
                     end
                     end
                     end
                    end
           end
  end
     
   
    %ѡ��ڼ������ز�
  if fab==1
      data=exp(f1);
  else if fab==2
          data=exp(f2);
      else if fab==3
              data=exp(f3);
          else if fab==4
                 data=exp(f4);
              end
          end
      end
  end
end
              
          
            
        