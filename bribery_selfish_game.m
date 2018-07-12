step = 1000;

a = 0.35;
b = 0.2;
bribes = 0.02;
b_o = 0.5/step:0.5/step:0.5;

r=1/step:1/step:1;

b_balance_o = [];
b_balance_r = [];
o_balance_o = [];
o_balance_r = [];

for i = 1:step % r
    for j = 1:step % b_o
        % analyze b
        r_all_b = b_o(j)+r(i)*(1-a-b_o(j)-b);
        rwd = bribery_selfish_reward_bribee_fun(a, b, r_all_b, bribes);
        extra_rwd_b(i,j)=(rwd(1)-b)*100;
        
        if j>1 && extra_rwd_b(i, j)<=0 && extra_rwd_b(i, j-1)>0
            b_balance_o = [b_balance_o, b_o(j)];
            b_balance_r = [b_balance_r, r(i)];
        end
        
        % analyze b_o
        r_all_o = b+r(i)*(1-a-b_o(j)-b);
        rwd = bribery_selfish_reward_bribee_fun(a, b_o(j), r_all_o, bribes);
        extra_rwd_o(i,j)=(rwd(1)-b_o(j))*100;
        if j>1 && extra_rwd_o(i, j)<=0 && extra_rwd_o(i, j-1)>0
            o_balance_o = [o_balance_o, b_o(j)];
            o_balance_r = [o_balance_r, r(i)];
        end
    end
end

imagesc(b_o, r, extra_rwd_b);
hold on
plot(b_balance_o,b_balance_r,'k','LineWidth',1);
cb = colorbar;
cb.Label.String = 'Extra Reward (\times10^{-2})';
set(gca, 'YDir', 'normal');
xlabel('\beta_2');
ylabel('\gamma');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);

pause;

imagesc(b_o, r, extra_rwd_o);
hold on
plot(o_balance_o,o_balance_r,'k','LineWidth',1);
cb = colorbar;
cb.Label.String = 'Extra Reward (\times10^{-2})';
set(gca, 'YDir', 'normal');
xlabel('\beta_2');
ylabel('\gamma');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);