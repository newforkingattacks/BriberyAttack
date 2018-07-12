% get the reward of the attacker (target accepts/denies) with selfish
% mining
function rwd = bribery_selfish_reward_attacker_fun(a, b, r, bribes)

    p0 = (a-2*a^2)/a/(2*a^3-4*a^2+1);
    p0o = (1-a-b)*(a-2*a^2)/(2*a^3-4*a^2+1);
    p0p = b*(a-2*a^2)/(2*a^3-4*a^2+1);
    p1 = (a-2*a^2)/(2*a^3-4*a^2+1);
    p2 = p1*a/(1-a);
    p3n = a^3/(1-a)/(2*a^3-4*a^2+1);

    % accept bribes
    Raa = (p0o+p0p)*a*2+p0o*(r*(1-a-b)+b)+p0p*r*(1-a-b)+p2*(1-a)*2+p3n*(1-a);
    rpa = p0o*b+p0p*(1-r)*(1-a-b)+p0p*b*2+p0*b+bribes*Raa;
    raa = Raa*(1-bribes);
    roa = (p0o+p0p)*r*(1-a-b)+p0o*(1-r)*(1-a-b)*2+p0p*(1-r)*(1-a-b)+p0*(1-a-b);

    % deny bribes
    rad = (p0o+p0p)*a*2+p0o*r*(1-a-b)+p0p*r*(1-a-b)+p2*(1-a)*2+p3n*(1-a);
    rpd = p0o*b+p0p*(1-r)*(1-a-b)+p0p*b*2+p0*b;
    rod = (p0o+p0p)*r*(1-a-b)+p0o*(1-r)*(1-a-b)*2+p0o*b+p0p*(1-r)*(1-a-b)+p0*(1-a-b);

    a_reward_a = raa/(raa+rpa+roa);
    a_reward_d = rad/(rad+rpd+rod);
    %if bribes == 0
    %    a_reward_a = a_reward_d;
    %end
    rwd = [a_reward_a, a_reward_d];