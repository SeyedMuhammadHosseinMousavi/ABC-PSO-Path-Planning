

function sol1=CRSolution(model)

    n=model.n;
    
    xmin=model.xmin;
    xmax=model.xmax;
    
    ymin=model.ymin;
    ymax=model.ymax;

    sol1.x=unifrnd(xmin,xmax,1,n);
    sol1.y=unifrnd(ymin,ymax,1,n);
    
end