%This project works for searching similar images from a large scale dataset based on LBP feature
clear all;
close all;
clc;

Path0 = 'E:\毕业设计\UIUC纹理数据库\dataset\';
Path_list0=dir(Path0);
loop1=22;%第一个是从3开始,一直到27
file_path=['E:\毕业设计\UIUC纹理数据库\dataset\' Path_list0(loop1).name];
img_path_list=dir(file_path);
img_num=length(img_path_list)-2;


input1=imread([file_path '\' img_path_list(5).name]);%3到42

LBPtest = get_feature3(input1);
LBPtest = LBPtest(:)';

dist = zeros(1,1000);
flag = 0;
for loop1=3:27
    file_path=['E:\毕业设计\UIUC纹理数据库\dataset\' Path_list0(loop1).name];
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

