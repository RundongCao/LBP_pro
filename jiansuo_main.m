clear all;
close all;
clc;

Path0 = 'E:\��ҵ���\UIUC�������ݿ�\dataset\';
Path_list0=dir(Path0);
loop1=22;%��һ���Ǵ�3��ʼ,һֱ��27
file_path=['E:\��ҵ���\UIUC�������ݿ�\dataset\' Path_list0(loop1).name];
img_path_list=dir(file_path);
img_num=length(img_path_list)-2;


input1=imread([file_path '\' img_path_list(5).name]);%3��42

LBPtest = get_feature3(input1);
LBPtest = LBPtest(:)';

dist = zeros(1,1000);
flag = 0;
for loop1=3:27
    file_path=['E:\��ҵ���\UIUC�������ݿ�\dataset\' Path_list0(loop1).name];
    img_path_list=dir(file_path);
    for loop2 = 3:42
        flag = flag+1;
        input2 = imread([file_path '\' img_path_list(loop2).name]);
        LBPfeature2 = get_feature3(input2);
        LBPfeature2=LBPfeature2(:)';
        distance = sqrt((LBPtest-LBPfeature2)*(LBPtest-LBPfeature2)');
        dist(flag) = distance;
    end
    fprintf('done\n');
end

[B,I]=sort(dist);

