function [ M ] = addSeamToMask( mask, seam )
%ADDSEAMTOMASK Posiziona un seam su una maschera da sovrapporre all'immagine originale

    cols = size(mask,2);
    
    for p = 1 : cols
        shift = sum(mask(1:seam(p),p));
        mask(seam(p)+shift, p) = 1;
    end

    M = mask;
    
end

