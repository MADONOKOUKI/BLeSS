  function [outCT] =mslPoolingMetric(img1, img2,metInd,poolInd)     

  % Metric selectiob
  switch metInd
      case 1  %srsim      
          [outCT] =SR_SIM(img1, img2);
      case 2 %fsim
          [outCT,~ ] = FeatureSIM(img1, img2);
      case 3 %fsimc
          [~, outCT] = FeatureSIM(img1, img2);
      case 4
          [SR_map1,SR_map2,GM_map1,GM_map2,Sal_map1,Sal_map2,PC1,PC2,I1,I2,Q1,Q2] =mslMetrics(img1, img2);          
      otherwise  
  end 

% BILLS assistance  
  switch poolInd
      case 1
          C1 = 0.40; %fixed
          C2 = 225; 
          alpha = 0.50;%fixed
          GBVSSimMatrix = (2 * SR_map1 .* SR_map2 + C1) ./ (SR_map1.^2 + SR_map2.^2 + C1);
          gradientSimMatrix = (2*GM_map1.*GM_map2 + C2) ./(GM_map1.^2 + GM_map2.^2 + C2);
          weight = max(SR_map1.*(Sal_map1), SR_map2.*(Sal_map2));          
          Sal_SIM_Map=(2*Sal_map1.*Sal_map2+C1)./(Sal_map1.^2+Sal_map2.^2+C1);                    
          SimMatrix = GBVSSimMatrix .* (gradientSimMatrix .^ alpha) .* weight.*Sal_SIM_Map.^(alpha);
          outCT = sum(sum(SimMatrix)) / sum(weight(:));   
      case 2          
          T1 = 0.85;  %fixed
          T2 = 160; %fixed
          T0=0.4;
          PCSimMatrix = (2 * PC1 .* PC2 + T1) ./ (PC1.^2 + PC2.^2 + T1);
          gradientSimMatrix = (2*GM_map1.*GM_map2 + T2) ./(GM_map1.^2 + GM_map2.^2 + T2);
          PCm = max(PC1.*Sal_map1, PC2.*Sal_map2);
          Sal_SIM_Map=(2*Sal_map1.*Sal_map2+T0)./(Sal_map1.^2+Sal_map2.^2+T0);         
          SimMatrix = gradientSimMatrix .* PCSimMatrix .* PCm.*(Sal_SIM_Map);
          outCT = sum(sum(SimMatrix)) / sum(sum(PCm));
      case 3
          T1 = 0.85;  %fixed
          T2 = 160; %fixed
          T0=0.4;
          Sal_SIM_Map=(2*Sal_map1.*Sal_map2+T0)./(Sal_map1.^2+Sal_map2.^2+T0);         
          PCSimMatrix = (2 * PC1 .* PC2 + T1) ./ (PC1.^2 + PC2.^2 + T1);
          gradientSimMatrix = (2*GM_map1.*GM_map2 + T2) ./(GM_map1.^2 + GM_map2.^2 + T2);
          PCm = max(PC1.*(Sal_map1), PC2.*Sal_map2);
          T3 = 200;
          T4 = 200;        
          ISimMatrix = (2 * I1 .* I2 + T3) ./ (I1.^2 + I2.^2 + T3);
          QSimMatrix = (2 * Q1 .* Q2 + T4) ./ (Q1.^2 + Q2.^2 + T4);
          lambda = 0.03;
          SimMatrixC = gradientSimMatrix .* PCSimMatrix .* real((ISimMatrix .* QSimMatrix) .^ lambda) .* PCm.*((Sal_SIM_Map.^(10*lambda)));        
          outCT = sum(sum(SimMatrixC)) / sum(sum(PCm));         
      otherwise
          
          
  end
  
  
  