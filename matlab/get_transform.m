function t = get_transform(center,scale,res)

    h = 200*scale;
    t = eye(3,3);
    t(1,1) = res(2)/h;
    t(2,2) = res(1)/h;
    t(1,3) = res(2)*(-center(1)/h + 0.5);
    t(2,3) = res(1)*(-center(2)/h + 0.5);
    t(3,3) = 1;
    
end