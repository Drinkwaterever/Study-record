%RGB图像在matlab处理
%先进行灰度化a=rgb2gray(a)
%再转为双精度a=im2double(a)

p=imread('C:\Users\YUWEI\Desktop\lena.png');
a=im2double(rgb2gray(p));
%定义DCT变换矩阵
t=dctmtx(8);
%将原图的每个8*8块进行DCT变换
y = blkproc(a, [8 8], 'P1*x*P2', t, t');

%定义舍弃数据区域
m1 =    [1 0 0 0 0 0 0 0
         0 0 0 0 0 0 0 0
         0 0 0 0 0 0 0 0
         0 0 0 0 0 0 0 0
         0 0 0 0 0 0 0 0
         0 0 0 0 0 0 0 0
         0 0 0 0 0 0 0 0
         0 0 0 0 0 0 0 0];
        
     
%舍弃DCT系数矩阵中的指定系数

my1 = blkproc(y, [8 8], 'P1.*x', m1);

%对每个8*8块进行IDCT变换，获取解压缩图像

y1 = blkproc(my1, [8 8], 'P1*x*P2',t',t);

subplot(1,2,1), imshow(a), title('原图');
subplot(1,2,2),imshow(y1),title('解压缩图像');

%计算MSE和信噪比
shape = size(a);
se = (a-y1).^2;
MSE1=sum(se(:)) / (shape(1)*shape(2))
PSNR1=10*log10(double(255^2/MSE1))


