clc;clear;close all;

AD_FTD = load('F:\Research\dataset\Epoched_EEGdata_Preprocessed_Manually.mat');

eeg_class_data = AD_FTD.('EEG_Class');

seg = 10;
fs = 250;
t = 0:1/fs:seg;
save_directory = strcat('F:\Research\dataset\Final_1Hz\AD_FTD_Scal_seg_10_fr_45_cwt_amor_1Hz_Col\');
mkdir(save_directory);
%% 
for sub = 1:size(eeg_class_data,2)
        s = eeg_class_data{1, sub};
        for ch = 1:size(s,2)
            for epoch = 1:size(s,3)
                sig = s(:, ch, epoch);
                [cfs, f] = cwt(sig, fs, 'FrequencyLimits', [1, 45], 'amor');
                fig = figure('Visible', 'off');
                imagesc(t, f, abs(cfs));
                set(gca,'ColorScale','log') 
                set(gca,'CLim',[0 25])  
                colorbar;
                axis xy; 
                ylabel('Frequency [Hz]');
                xlabel('Time [s]');
                colormap parula 
                save_path = strcat(save_directory,'Subject_', num2str(sub), '_','Channel_', num2str(ch), '_', 'Epoch_', num2str(epoch), '.jpg');
                saveas(gcf, save_path);
            end
        end
end

