% Beibery attack with s (theoretical)
a = 0.3;
b = 0.3;
r = 0;
bribes = 0.02;


rwd_a = bribery_selfish_reward_attacker_fun(a, b, r, bribes);
rwd_p = bribery_selfish_reward_bribee_fun(a, b, r, bribes);

rwd_a = (rwd_a-a)/a
rwd_p = (rwd_p-b)/b