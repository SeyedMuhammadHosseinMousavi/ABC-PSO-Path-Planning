
function model=Basics()

    % Start
    xs=-7;
    ys=-15;
    % Destination
    xt=13;
    yt=13;
    
    % Obsticles
    r = -1 + (1+1)*rand;
    xobs=[1.5+r*rand 4.0+r*rand 1.2+r*rand 2.2+r*rand 3.2+r*rand 0.3+r*rand 1.6+r*rand 8.0+r*rand 5.0+r*rand 12.0+r*rand 6.0+r*rand -6.0+r*rand -6.0+r*rand 6.0+r*rand -3.0+r*rand];
    yobs=[4.5+r*rand 1.0+r*rand 1.5+r*rand 0.9+r*rand 2.2+r*rand 0.6+r*rand 7.1+r*rand 8.0+r*rand 6.0+r*rand 6.0+r*rand 12.0+r*rand -4.0+r*rand 6.0+r*rand -6.0+r*rand -9.0+r*rand];
    robs=[1.5+r*rand 1.0+r*rand 0.8+r*rand 1.3+r*rand 1.3+r*rand 0.2+r*rand 1.3+r*rand 1.6+r*rand 2.0+r*rand 1.5+r*rand 1.0+r*rand 2.0+r*rand 2.0+r*rand 2.0+r*rand 3.0+r*rand];
   
    n=6;
    xmin=-10;
    xmax= 10;
    ymin=-10;
    ymax= 10;
    model.xs=xs;
    model.ys=ys;
    model.xt=xt;
    model.yt=yt;
    model.xobs=xobs;
    model.yobs=yobs;
    model.robs=robs;
    model.n=n;
    model.xmin=xmin;
    model.xmax=xmax;
    model.ymin=ymin;
    model.ymax=ymax;
    
end