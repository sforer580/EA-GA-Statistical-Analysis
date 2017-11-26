close all; clear all; clc

%data_1 data_2 must be of the dimensions (i.e. size(data_1) = 30,100)
data_1 = load('.txt');      %loads data
data_2 = load('.txt');      %loads data
size(data_1);
size(data_2);

num_gen = 100;
num_sr = 30;
sum_data_1 = zeros(1, num_gen);     %place holders
sum_data_2 = zeros(1, num_gen);     %place holders
err_data_1 = zeros(1, num_gen);     %place holders
err_data_2 = zeros(1, num_gen);     %place holders
Generation = 1:1:num_gen;

%Sums each gen from each sr
for (sr=1:num_sr)
    for (gen=1:num_gen)
        sum_data_1(gen) = sum_data_1(gen) + data_1(sr,gen);
        sum_data_2(gen) = sum_data_2(gen) + data_2(sr,gen);
    end
end

%Calculates the average
Ave_data_1 = sum_data_1/num_sr;
Ave_data_2 = sum_data_2/num_sr;

%Outputs the final average values
Final_Ave_data_1 = Ave_data_1(num_gen)
Final_Ave_data_2 = Ave_data_2(num_gen)

%Calculates the error bars for each generation
for (gen=1:num_gen)
    stdv_ph_1 = zeros(1, num_sr);       %place holders
    stdv_ph_2 = zeros(1, num_sr);       %place holders
    for (sr=1:num_sr)
        stdv_ph_1(sr) = data_1(sr,gen);
        stdv_ph_2(sr) = data_2(sr,gen);
    end
    
    %calculates the error in each point
    if(gen == 1)
    err_data_1(gen) = std(stdv_ph_1)/sqrt(num_sr);
    err_data_2(gen) = std(stdv_ph_2)/sqrt(num_sr);
    elseif (~mod(gen,20))
    err_data_1(gen) = std(stdv_ph_1)/sqrt(num_sr);
    err_data_2(gen) = std(stdv_ph_2)/sqrt(num_sr);
    else
    err_data_1(gen) = NaN;
    err_data_2(gen) = NaN;
    end
end

figure(1)
hold all;
errorbar(Generation, Ave_data_1, err_data_1, 'LineWidth', 1.5)
errorbar(Generation, Ave_data_2, err_data_2, 'LineWidth', 1.5)
xlabel('Generation', 'FontSize', 20, 'FontWeight', 'bold')
ylabel('Fitness', 'FontSize', 20, 'FontWeight', 'bold')
set(gca,'FontSize',15)
axis([0 num_gen 0 2000])
legend ('')
%print('R1','-dpng')
