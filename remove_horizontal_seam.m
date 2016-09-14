function J = remove_horizontal_seam( I,S )
%REMOVE_HORIZONTAL_SEAM  Rimuove un seam orizzontale S da un'immagine I

    J = I(1:size(I,1)-1,:,:);
    for x = 1:size(I,2)
        J(S(x):size(J,1),x,:) = I(S(x)+1:size(I,1),x,:);
    end
    
end

