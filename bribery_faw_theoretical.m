% Beibery attack with FAW (theoretical)

a = 0.2;
bv = 0.1;
bb = 0.3;
r = 1;
bribes = 0.02;


x0 = [0.5; 0.5];
A = [];
b = [];
Aeq = [];
beq = [];
VLB = [0; 0];
VUB = [1; 1];

c = bv+a+r*(1-bb-bv-a);
[x, total_reward] = fmincon(@(x) bit_faw_reward(x, a, bv, c), x0, A, b, Aeq, beq, VLB, VUB);
t = x(1);


rwd_a = bribery_faw_reward_attacker_fun(a, bv, bb, t, r, bribes);
rwd_b = bribery_faw_reward_bribee_fun(a, bv, bb, t, r, bribes);
    
rwd_a = (rwd_a-a)./a*100
rwd_b = (rwd_b-bb)./bb*100