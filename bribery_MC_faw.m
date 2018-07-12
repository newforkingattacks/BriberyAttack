% Beibery attack with FAW (simulation)

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

nround = 1000000000;

ra = 0;
rb = 0;
rv = 0;
ro = 0;

rab = 0;


% 0: accept
% else: deny
choice = 0;



for i=1:nround
    ori_block = rand();
    if ori_block <= (1-t)*a
        % inncent
        ra = ra+1;
    elseif (1-t)*a<ori_block && ori_block<=(1-t)*a+bv
        % victim pool
        ra = ra+t*a/(t*a+bv);
        rv = rv+bv/(t*a+bv);
    elseif (1-t)*a+bv<ori_block && ori_block<=(1-t)*a+bv+bb
        % bribee
        rb = rb+1;
    elseif (1-t)*a+bv+bb<ori_block && ori_block<=(1-t)*a+bv+bb+(1-a-bb-bv)
        % others
        ro = ro+1;
    else
        % infiltration
        block = rand();
        if block <= (1-t)*a/(1-t*a)
            % innocent
            ra = ra+1;
        elseif (1-t)*a/(1-t*a)<block && block<=((1-t)*a+bv)/(1-t*a)
            % victim pool
            ra = ra+t*a/(t*a+bv);
            rv = rv+bv/(t*a+bv);
        elseif ((1-t)*a+bv)/(1-t*a)<block && block<=((1-t)*a+bv+bb)/(1-t*a)
            % bribee
            new_block = rand();
            if new_block <= a
                % attacker
                trand = rand();
                if trand <= t
                    % infiltration
                    ra = ra+t*a/(t*a+bv);
                    rv = rv+bv/(t*a+bv);
                else
                    % innocent
                    ra = ra+1;
                end
                rab = rab+1;
                ra = ra+t*a/(t*a+bv);
                rv = rv+bv/(t*a+bv);
            elseif a<new_block && new_block<=a+bv
                % victim
                rab = rab+1;
                ra = ra+2*t*a/(t*a+bv);
                rv = rv+2*bv/(t*a+bv);
            elseif a+bv<new_block && new_block<=a+bv+r*(1-a-bb-bv)
                % others
                rab = rab+1;
                ra = ra+t*a/(t*a+bv);
                rv = rv+bv/(t*a+bv);
                ro = ro+1;
            elseif a+bv+r*(1-a-bb-bv)<new_block && new_block<=1-bb
                rb = rb+1;
                ro = ro+1;
            else
                rb = rb+2;
            end
        else
            % others
            % d
            new_block = rand();
            if new_block <= a
                % d-1 (attacker)
                trand = rand();
                if trand <= t
                    % infiltration
                    ra = ra+t*a/(t*a+bv);
                    rv = rv+bv/(t*a+bv);
                else
                    % innocent
                    ra = ra+1;
                end
                rab = rab+1;
                ra = ra+t*a/(t*a+bv);
                rv = rv+bv/(t*a+bv);
            elseif a<new_block && new_block<=a+bv
                % d-1 (victim)
                rab = rab+1;
                ra = ra+2*t*a/(t*a+bv);
                rv = rv+2*bv/(t*a+bv);
            elseif a+bv<new_block && new_block<=a+bv+r*(1-a-bb-bv)
                % d-1 (others)
                rab = rab+1;
                ra = ra+t*a/(t*a+bv);
                rv = rv+bv/(t*a+bv);
                ro = ro+1;
            elseif a+bv+r*(1-a-bb-bv)<new_block && new_block<=1-bb
                % d-4 (others)
                ro = ro+2;
            else
                % accept: d-2 / deny: d-3
                if choice == 0
                    % accept d-2
                    rab = rab+1;
                    ra = ra+t*a/(t*a+bv);
                    rv = rv+bv/(t*a+bv);
                else
                    % deny d-3
                    ro = ro+1;
                end
                rb = rb+1;
            end
        end
    end
end

ra_f = ra;
rb_f = rb;
if choice == 0
    ra_f = ra-rab*bribes;
    rb_f = rb+rab*bribes;
end 
ra_f = ra_f/(ra+rb+ro+rv);
ra_f = (ra_f-a)/a*100
rb_f = rb_f/(ra+rb+ro+rv);
rb_f = (rb_f-bb)/bb*100