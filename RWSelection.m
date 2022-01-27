
function i = RWSelection(P)
    r = rand;
    C = cumsum(P);
    i = find(r <= C, 1, 'first');
end