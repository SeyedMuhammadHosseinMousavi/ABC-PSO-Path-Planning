
function Plotting(sol,model)

    xs=model.xs;
    ys=model.ys;
    xt=model.xt;
    yt=model.yt;
    xobs=model.xobs;
    yobs=model.yobs;
    robs=model.robs;
    
    XS=sol.XS;
    YS=sol.YS;
    xx=sol.xx;
    yy=sol.yy;
    
    theta=(1/24:1/12:1)'*2*pi;
    for k=1:numel(xobs)
        fill(xobs(k)+robs(k)*cos(theta),yobs(k)+robs(k)*sin(theta),[0.9 0.2 0.7]);
        hold on;
    end
    

% figure;
    plot(xx,yy,'g','LineWidth',2);
    plot(XS,YS,'ro');
    plot(xs,ys,'yo','MarkerSize',14,'MarkerFaceColor','b');
    plot(xt,yt,'bh','MarkerSize',14,'MarkerFaceColor','r');
    hold off;
    grid on;
    axis equal;

end