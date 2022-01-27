function [z, sol]=Cost(sol1,model)

    sol=Pars(sol1,model);
    beta=100;
    z=sol.L*(1+beta*sol.Violation);

end