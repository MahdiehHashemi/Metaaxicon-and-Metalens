clc
clear all
close all
% -----------------------------------------
epsl=1;
refindex=sqrt(epsl);
lambda=3e8/(430e12*refindex);
a=0.01;
k=2*pi/lambda;
x0=120e-8;
z=0;
ki=z./(k*x0.^2);
d=360e-9;
f=10.5*lambda;
% -----------------------------------------

AMPLITUDE='amp.txt';
at=importdata(AMPLITUDE);
am=at.data(1:1:11870,4);

PHASE='pha.txt';
pt=importdata(PHASE);
ph=pt.data(1:1:11870,4);

lenght=at.data(1:1:11870,3);
aa=at.data(1:1:11870,1);
bb=at.data(1:1:11870,2);
[m,n]=size(lenght);
k=1;
for i=1:m
    if lenght(i)==0
        phasee(k,1)=aa(i);
        phasee(k,2)=bb(i);
        phasee(k,3)=ph(i);
        ampp(k,1)=aa(i);
        ampp(k,2)=bb(i);
        ampp(k,3)=am(i);
        k=k+1;
    end 
end
alphamatrix=reshape(phasee(:,1),68,81); %81 phi*68 ri
rimatrix=reshape(phasee(:,2),68,81);
phaseMatrix=reshape(phasee(:,3),68,81);
ampn=ampp(:,3);
ampMatrix=reshape(ampn,68,81); 
%-------------------------------------
alpha_ri_amp_ph=zeros(68,81,4);
alpha_ri_amp_ph(:,:,1)=alphamatrix;
alpha_ri_amp_ph(:,:,2)=rimatrix;
alpha_ri_amp_ph(:,:,3)=ampMatrix;
alpha_ri_amp_ph(:,:,4)=phaseMatrix;
maxamp=max(max(alpha_ri_amp_ph(:,:,3)));
%-------------------------------
a1=0;b1=0;a2=0;b2=0;a3=0;b3=0;a4=0;b4=0;a5=0;b5=0;a6=0;b6=0;b7=0;b8=0;b9=0;b10=0;
for i=1:68
    for j=1:81
                b1=b1+1;
                alphafinal(b1,1)=alpha_ri_amp_ph(i,j,1);
                rifinal(b1,1)=alpha_ri_amp_ph(i,j,2);
                alpharifinal=[alphafinal rifinal];
                ampfinal(b1,1)=alpha_ri_amp_ph(i,j,3)./maxamp;
                phasefinal(b1,1)=alpha_ri_amp_ph(i,j,4);
                
       end
end
      
A=[a1 a2 a3 a4 a5 a6];
B=[b1 b2 b3 b4 b5 b6 b7 b8 b9 b10];
        
 %-----------------------Janus
w=0;
k3=1;
amplitude_limit=0;
phase_limit=0;
alphasize=zeros(41,41);
risize=zeros(41,41);
for m=1:41
    for n=1:41
        x(m,n)=(m-41/2)*d;
        y(m,n)=(n-41/2)*d;
        if abs(x(m,n))<13*d && abs(y(m,n))<13*d
        phAX(m,n)=1*exp(1i*(2*pi/lambda).*sqrt(x(m,n).^2+y(m,n).^2).*sin(atan((41./2*d)./f)));
        else 
        phAX(m,n)=1*exp(1i*(2*pi/lambda)*(sqrt(f^2+x(m,n).^2+y(m,n).^2)-f));
        end
        wave(m,n)=phAX(m,n);
        phia(m,n)=angle(wave(m,n))*180/pi;
        ampa(m,n)=abs(wave(m,n));
     
        for l1=1:b1            
            amp_difa(m,n,l1)=abs(ampfinal(l1)-ampa(m,n));
            phid_difa(m,n,l1)=abs(phasefinal(l1)-phia(m,n));
        
            
        end
%         for i2=1:b1
%                 if  (phid_difa(i2,m)<=phase_limit+3)    && (amp_difa(i2,m)<=amplitude_limit+0.05)
%                     alphasizea(m,1)=alphafinal(i2,1);
%                     risizea(m,1)=rifinal(i2,1);
%                     phisa(m,1)=phasefinal(i2,1);
%                     ampsa(m,1)= ampfinal(i2,1);
%                 
%                 end
%         end
        for i3=1:b1
                if  (phid_difa(m,n,i3)<=phase_limit+3)    && (amp_difa(m,n,i3)<=amplitude_limit+0.01)
                    alphasizeaf(m,n,1)=alphafinal(i3,1);
                    risizeaf(m,n,1)=rifinal(i3,1);
                    phisaf(m,n,1)=phasefinal(i3,1);
                    ampsaf(m,n,1)= ampfinal(i3,1);
                elseif (phid_difa(m,n,i3)<=phase_limit+5)    && (amp_difa(m,n,i3)<=amplitude_limit+0.04)
                    alphasizeaf(m,n,1)=alphafinal(i3,1);
                    risizeaf(m,n,1)=rifinal(i3,1);
                    phisaf(m,n,1)=phasefinal(i3,1);
                    ampsaf(m,n,1)= ampfinal(i3,1);
                elseif (phid_difa(m,n,i3)<=phase_limit+6.9)    && (amp_difa(m,n,i3)<=amplitude_limit+.058)
                    alphasizeaf(m,n,1)=alphafinal(i3,1);
                    risizeaf(m,n,1)=rifinal(i3,1);
                    phisaf(m,n,1)=phasefinal(i3,1);
                    ampsaf(m,n,1)= ampfinal(i3,1);
                
                end
        end
    end
end
for k4=1:1681
    if alphasizeaf(k4)==0 %|| alphasizea(k4)==0
        w=w+1;
    end
end
%%%%%%%%%%%%%%%%%% Just for Plot
% for mm=1:396
% xp(mm)=(mm-4*99/2)*d/4;
% s1p(mm)=(xp(mm)+.35e-5)/x0;
% s2p(mm)=-(xp(mm)-.35e-5)/x0;
% ph1p(mm)=airy(s1p(mm)-(ki./2).^2+1i*a*ki).*exp(a*s1p(mm)-(a*ki.^2./2)-1i*(ki.^3/12)+1i*(a^2.*ki./2)+1i*(s1p(mm).*ki/2));
% ph2p(mm)=airy(s2p(mm)-(ki./2).^2+1i*a*ki).*exp(a*s2p(mm)-(a*ki.^2./2)-1i*(ki.^3/12)+1i*(a^2.*ki./2)+1i*(s2p(mm).*ki/2));
% phfp(mm)=1*exp(1i*(2*pi/lambda)*(sqrt(f^2+xp(mm).^2)-f));
% waveap(mm)=(ph1p(mm)+ph2p(mm));
% wavep(mm)=(ph1p(mm)+ph2p(mm)).*phfp(mm);
% phiap(mm)=angle(waveap(mm))*180/pi;
% phip(mm)=angle(wavep(mm))*180/pi;
% phifp(mm)=angle(phfp(mm))*180/pi;
% amppp(mm)=abs(wavep(mm));
% end
% %plot(xp*1e6,amppp/max(amppp))
% plot(xp*1e6,phip)
% hold on

%%%%%%%%%%%%%%%%%%%%%%%
%zzabsize=[alphasizeaf risizeaf];
%phisa=reshape(phisa,99,1);
%phisaf=reshape(phisaf,99,1);
 
% for counter=1:99
% xpp(counter)=(counter-99/2)*d*1e6;
% plot(xpp(counter),phisaf(counter),'*r')
% % plot(counter,ampa(counter)/max(ampa),'or',counter,abs(ampsaf(counter)),'*k')
% % plot(counter,phia(counter),'or',counter,abs(phif(counter)-phisaf(counter)),'*k')
% % plot(counter,phiaf(counter),'or', counter,phia(counter),'*k')
%    hold on
% end
alphasizeaf=reshape(alphasizeaf,1681,1);
fid = fopen('D:\axicon\Axicon,Lens10\alphas.txt','wt');
 for ii = 1:size(alphasizeaf,1)
     fprintf(fid,'%g\t',alphasizeaf(ii,:));
     fprintf(fid,'\n');
 end
fclose(fid);
risizeaf=reshape(risizeaf,1681,1);
 fid = fopen('D:\axicon\Axicon,Lens10\ris.txt','wt');
 for ii = 1:size(risizeaf,1)
     fprintf(fid,'%g\t',risizeaf(ii,:));
     fprintf(fid,'\n');
 end
fclose(fid)
    