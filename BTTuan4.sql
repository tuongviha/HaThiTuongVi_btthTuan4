USE QLBH
GO
DELETE FROM dbo.CT_HoaDon
DELETE FROM dbo.HoaDon
DELETE FROM dbo.KhachHang
DELETE FROM dbo.NhaCungCap
DELETE FROM dbo.Nhanvien
DELETE FROM dbo.NhomSanPham
DELETE FROM dbo.SanPham
go
---2
Insert into dbo.Nhomsanpham
 values (1,'Dientu'),
 (2,'giadung'),
 (3,'dungcugiadinh'),
 (4,'cacmathangkhac'),
 go
 Insert into dbo.NhaCungCap
 values (1,'Cty TNHH Nam Phuong','1 Le loi p4 GoVap','083843456','32343434','NamPhuong@yahoo.com'),
 (2,' Cty Lan Ngoc','10 Nguyen Van Dung', '086234567','8343435'5,'LanNgoc@gmail.com'),
 go
 Insert into dbo.SanPham
 values (1,'Maytinh','cai',7000,100,1,1,'maY SONY ram 2gb'),
 (2,'Ban phim','cai', 1000,50,1,1,'Ban phim 101 phim'),
 (3,'chuot', 'cai', 800,150,1,1,'Chhuot khong dayy'),
 (4, 'CPU','cai',3000,200,1,1,'CPU'),
 (5,'USB','cai',500,100,1,1,'8gb'),
 (6,'Lovisong','cai',1000000,20,3,2,NULL),
 Insert into dbo.KhachHang
 values (KH1,'Nguyen Thu Hang','12 nguyen du', null, 'VL',Null,Null,Null) ,
 (KH2,'Le Minh', '34 dien bien phu', '012394355','TV',Null,'leminh@yahoo.com',100),
 (KH3,'Nguyen minh trung','3 le loi','098343434','VIP',null,'Trung@gmail.com',800),
 go
Insert into dbo.CT_HoaDon
 values (1,1,5,8000),
 (1,2,4,5000),
 (1,3,15,1000),
 (2,2,9,1200),
 (2,4,5,800),
 (3,2,20,3500),
 (3,3,15,1000),
go
--3
UPDATE SanPham
SET GiaGoc = GiaGoc * 1.05
WHERE MaSp = 2
go
UPDATE SanPham
SET SLTon = SLTon + 100
WHERE NhomMH = 3 AND MaNCC = 2;
go
UPDATE KhachHang
SET DiemTL = DiemTL + 50
WHERE LoaiKH <> 'VL';
GO
UPDATE SanPham
SET MoTa = 'Lo vi song hien dai bac nhat vn'
WHERE TenSP = 'Lovisong';
go
UPDATE SanPham
SET GiaGoc = GiaGoc * 1.02
WHERE TenSanPham LIKE '%u%';
go
---4
DELETE FROM SanPham
WHERE SLTon < 2;
go
DELETE FROM HoaDon
WHERE MaKhachHang IN (
    SELECT MaKH
    FROM KhachHang
    WHERE LoaiKH = 'VL'
);
go
DELETE FROM KhachHang
WHERE LoaiKH = 'VIP' AND DiemTL = 0;
go
