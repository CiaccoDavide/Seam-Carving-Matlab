function J = remove_vertical_seam( I,S )
%REMOVE_VERTICAL_SEAM Rimuove un seam verticale S da un'immagine I

    J = I(:,1:size(I,2)-1,:);
    for y = 1:size(I,1)
        J(y,S(y):size(J,2),:) = I(y,S(y)+1:size(I,2),:);
    end
    
end

