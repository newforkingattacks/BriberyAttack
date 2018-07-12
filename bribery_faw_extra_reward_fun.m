% get the extra reward of the attacker (w/wo bribery attack) with FAW attacks
function rwd = bribery_faw_extra_reward_fun(a, bv, x, t, r, bribes)

    bb = x(1);
    
    pa = (1-t)*a/(1-t*a);
    pb = bv/(1-t*a);
    pc = bb/(1-t*a);
    pd = (1-a-bv-bb)/(1-t*a);

    % accept bribes
    Raa = (pc+pd)*(a+bv+r*(1-a-bv-bb)) + pd*bb;
    raa = ((t*a)/(bv+t*a)-bribes)*Raa + pa + pb*(t*a)/(bv+t*a) + (pc+pd)*((1-t)*a+t*a*(t*a)/(bv+t*a)+bv*(t*a)/(bv+t*a));
    rpa = pc*(1-r)*(1-a-bv-bb) + pc*bb*2 + pd*bb + bribes*Raa;
    rva = (bv)/(bv+t*a)*(Raa+pb+pc*bv+pd*bv)+(bv)/(bv+t*a)*(pc+pd)*t*a;
    roa = pc*(1-a-bv-bb) + pd*r*(1-a-bv-bb) + pd*(1-r)*(1-a-bv-bb)*2;

    % deny bribes
    rad = (t*a)/(bv+t*a)*(Raa-pd*bb) + pa + pb*(t*a)/(bv+t*a) + (pc+pd)*((1-t)*a+t*a*(t*a)/(bv+t*a)+bv*(t*a)/(bv+t*a));
    rpd = pc*(1-r)*(1-a-bv-bb) + pc*bb*2 + pd*bb;
    rvd = (bv)/(bv+t*a)*((Raa-pd*bb)+pb+(pc+pd)*bv)+(bv)/(bv+t*a)*(pc+pd)*t*a;
    rod = pc*(1-a-bv-bb) + pd*r*(1-a-bv-bb) + pd*bb + pd*(1-r)*(1-a-bv-bb)*2;


    rwd = rad-raa;