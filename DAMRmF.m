%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Citation:
% S. Memiş and U. Erkan, 2021. Different Adaptive Modified Riesz Mean 
% Filter For High-Density Salt-and-Pepper Noise Removal in Grayscale Images,
% European Journal of Science and Technology, (23), 359-367. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abbreviation of Journal Title: Eur. J. Sci. Technol.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://doi.org/10.31590/ejosat.873312
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://www.researchgate.net/profile/Samet_Memis2
% https://www.researchgate.net/profile/Ugur_Erkan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Demo: 
% clc;
% clear all;
% io=imread("lena.tif");
% Noise_Image=imnoise(io,'salt & pepper',0.8);
% Denoised_Image=DAMRmF(Noise_Image);
% psnr_results=psnr(io,Denoised_Image);
% ssim_results=ssim(io,Denoised_Image);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X=DAMRmF(A)
A=double(A);
 for p=5:-1:1  
  pA=padarray(A,[p p],'symmetric');
  pB=(pA~=0 & pA~=255);
  [m,n]=size(pB);
  for i=1+p:m-p
    for j=1+p:n-p       
       if (pB(i,j)==0)
            for k=1:p   
                if ((0<median(median(pA(i-k:i+k,j-k:j+k)))) & (median(median(pA(i-k:i+k,j-k:j+k)))<255) & (pA(i,j)==0| pA(i,j)==255))               
                    Wk=pA(i-k:i+k,j-k:j+k);
                    A(i-p,j-p)=MRmean(Wk);
                    break;
                end
            end
       end
    end 
  end   
 end
  X=uint8(A);
end
function MR=MRmean(W1)
[n,~]=size(W1);
k=(n-1)/2;                          
uk=0;
qk=0;                            
 for s=1:n
  for t=1:n
   if(W1(s,t)~=0 && W1(s,t)~=255)
    pw=(1/(1+((k+1-s)^2+(k+1-t)^2))^2);
    uk=uk+pw*W1(s,t);
    qk=qk+pw;
   end
  end
 end                                                       
MR=uk/qk;
end
