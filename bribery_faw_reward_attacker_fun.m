% get the reward of the attacker (target accepts/denies) with FAW attacks
function rwd = bribery_faw_reward_attacker_fun(a, bv, bb, t, r, bribes)
    pa = 1-a-bv-bb;
    pb = bb;
    pc = (1-t)*a;
    pd = bv;
    pe = t*a;
    pe1 = pe*(1-a-bv-bb)/(1-t*a);
    pe2 = pe*bb/(1-t*a);
    pe3 = pe*(1-t)*a/(1-t*a);
    pe4 = pe*bv/(1-t*a);

    % accept bribes
    Raa = (pe1+pe2)*(a+bv+r*(1-a-bv-bb)) + pe1*bb;
    raa = ((t*a)/(bv+t*a)-bribes)*Raa + pc+pe3 + (pd+pe4)*(t*a)/(bv+t*a) + (pe1+pe2)*((1-t)*a+t*a*(t*a)/(bv+t*a)+bv*(t*a)/(bv+t*a));
    rpa = pb+pe2*(1-r)*(1-a-bv-bb) + pe2*bb*2 + pe1*bb + bribes*Raa;
    rva = (bv)/(bv+t*a)*(Raa+pd+pe4+pe1*bv+pe2*bv)+(bv)/(bv+t*a)*(pe1+pe2)*t*a;
    roa = pa + pe1*r*(1-a-bv-bb) + pe1*(1-r)*(1-a-bv-bb)*2 + pe2*(1-a-bv-bb);

    % deny bribes
    rad = (t*a)/(bv+t*a)*(Raa-pe1*bb) + pc+pe3 + (pd+pe4)*(t*a)/(bv+t*a) + (pe1+pe2)*((1-t)*a+t*a*(t*a)/(bv+t*a)+bv*(t*a)/(bv+t*a));
    rpd = pb + pe2*(1-r)*(1-a-bv-bb) + pe2*bb*2 + pe1*bb;
    rvd = (bv)/(bv+t*a)*((Raa-pe1*bb)+pd+pe4+(pe1+pe2)*bv)+(bv)/(bv+t*a)*(pe1+pe2)*t*a;
    rod = pa + pe2*(1-a-bv-bb) + pe1*r*(1-a-bv-bb) + pe1*bb + pe1*(1-r)*(1-a-bv-bb)*2;

    a_reward_a = raa/(raa+rpa+roa+rva);
    a_reward_d = rad/(rad+rpd+rod+rvd);
    %if bribes == 0
    %    a_reward_a = a_reward_d;
    %end
    rwd = [a_reward_a, a_reward_d];