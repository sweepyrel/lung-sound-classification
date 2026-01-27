clc; clear; close all;

fprintf('loading data...\n');
P99 = load('data99okeh.mat');
result = P99.result;

if isfield(P99,'fs')
    fs = P99.fs;
else
    fs = 8000;
end

N = numel(result);     
K = 5;                

fprintf('Total sinyal      : %d\n', N);
fprintf('Sampling rate     : %d Hz\n', fs);
fprintf('Jumlah level DWT  : %d\n\n', K);

% preproc
preproc = @(x) ((x - mean(x)) ./ (max(abs(x - mean(x))) + eps));

%parameter FDispEn
m   = 3;    
c   = 6;    
tau = 1;    

FDispEn_all = zeros(N, K);
DWT_store   = cell(N,1);

fprintf('running DWT & FDispEn extraction...\n');

for i = 1:N
    if mod(i,10) == 0
        fprintf('Processing: %d/%d (%.1f%%)\n', i, N, i/N*100);
    end

    x = preproc(result{i});

    % DWT db4
    [C,L] = wavedec(x, K, 'db4'); 

    % detail coefficients D1–D5
    for k = 1:K
        Dk = detcoef(C, L, k);
        FDispEn_all(i,k) = FDispEn(Dk, m, c, tau);
    end

    DWT_store{i}.C = C;
    DWT_store{i}.L = L;
end

fprintf('feature extraction done!\n\n');

fprintf('labeling data...\n');

yText = strings(N,1);
yText(  1:18) = "bronchial";
yText( 19:31) = "asthma";
yText( 32:47) = "crackle";
yText( 48:61) = "frictionrub";
yText( 62:82) = "stridor";
yText( 83:85) = "bronchial";
yText( 86:90) = "asthma";
yText( 91:95) = "crackle";
yText( 96:99) = "frictionrub";

label_names = {'bronchial','asthma','crackle','frictionrub','stridor'};
label = grp2idx(categorical(yText, label_names));

fprintf('labeling done!\n\n');

% raw vs preprocessed 
len_min = min(cellfun(@length, result));
raw_stack  = zeros(N, len_min);
prep_stack = zeros(N, len_min);

for i = 1:N
    raw_stack(i,:)  = result{i}(1:len_min);
    prep_stack(i,:) = preproc(result{i}(1:len_min));
end

t = (0:len_min-1)/fs;

figure('Name','Mean Raw vs Preprocessed');
tiledlayout(2,1);

nexttile;
plot(t, mean(raw_stack,1),'b','LineWidth',1.3); grid on;
title('Mean Raw Signal'); ylabel('Amplitude');

nexttile;
plot(t, mean(prep_stack,1),'r','LineWidth',1.3); grid on;
title('Mean Preprocessed Signal'); xlabel('Time (s)');

% visualisasi DWT
idx_sample = 10;
x_pre = preproc(result{idx_sample});
[C,L] = wavedec(x_pre, K, 'db4');
t_vis = (0:length(x_pre)-1)/fs;

figure('Name',sprintf('DWT Decomposition - Sample #%d (%s)', ...
    idx_sample, yText(idx_sample)), 'Color','k');

tiledlayout(K+1,1,'TileSpacing','compact','Padding','compact');

nexttile;
plot(t_vis, x_pre,'Color',[0 0.6 1],'LineWidth',1);
grid on;
set(gca,'Color','k','XColor','w','YColor','w');
title('Preprocessed Signal','Color','w');

for k = 1:K
    Dk = detcoef(C,L,k);
    nexttile;
    plot(linspace(0,t_vis(end),length(Dk)), Dk,'g','LineWidth',0.8);
    grid on;
    set(gca,'Color','k','XColor','w','YColor','w');
    title(sprintf('Detail Coefficient D%d',k),'Color','w');
end

xlabel('Time (s)','Color','w');

% barplot 
figure('Name','FDispEn per DWT Level (Sample)');
bar(1:K, FDispEn_all(idx_sample,:));
set(gca,'XTick',1:K,'XTickLabel',{'D1','D2','D3','D4','D5'});
xlabel('DWT Level');
ylabel('FDispEn');
title('Fluctuation-based Dispersion Entropy');
grid on;

% scatter plot
figure('Name','Scatter FDispEn');
colors = lines(5);

pairs  = [1 2;
          2 3;
          3 4;
          4 5];

titles = {'D1 vs D2','D2 vs D3','D3 vs D4','D4 vs D5'};

tiledlayout(1,4,'Padding','compact');

for p = 1:4
    nexttile; hold on;
    for i = 1:5
        idx = label == i;
        scatter(FDispEn_all(idx,pairs(p,1)), ...
                FDispEn_all(idx,pairs(p,2)), ...
                45, colors(i,:), 'filled');
    end
    xlabel(sprintf('FDispEn D%d',pairs(p,1)));
    ylabel(sprintf('FDispEn D%d',pairs(p,2)));
    title(titles{p});
    grid on;
    if p == 4
        legend(label_names,'Location','best');
    end
    hold off;
end

% boxplot
figure('Name','Boxplot FDispEn per Level');

for k = 1:K
    subplot(2,3,k);
    boxplot(FDispEn_all(:,k), label, 'Labels', label_names);
    title(sprintf('FDispEn D%d',k));
    ylabel('FDispEn');
    grid on;
end

fprintf('saving to CSV...\n');

T = array2table([FDispEn_all label], ...
    'VariableNames',[strcat("FDispEn_D",string(1:K)),"Label"]);
T.ClassName = cellstr(yText);

csv_filename = "DWT_FDispersionEntropy_Features.csv";
writetable(T, csv_filename);

fprintf('file saved: %s\n\n', csv_filename);
