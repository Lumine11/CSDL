create database HairSalon
go
use HairSalon 
go
CREATE TABLE PHIEU_YEU_CAU (
    MaPhieu INT PRIMARY KEY,
    MaKH INT,
    HoTen VARCHAR(255),
    DienThoai VARCHAR(255),
    DiaChi VARCHAR(255),
    TGLap DATE,
    TongTien FLOAT
);
CREATE TABLE PHU_TRACH_DV (
    MaPhieu INT,
    MaDV INT,
    TenDV VARCHAR(255),
    MaNV INT,
    TenNV VARCHAR(255),
    TGBatDau DATE,
    TGHoanTat DATE,
    GiaTienDV FLOAT
);
CREATE TABLE SAN_PHAM (
    MaSP INT PRIMARY KEY,
    TenSP VARCHAR(255),
    GiaTien FLOAT
);

CREATE TABLE CT_SANPHAM (
    MaPhieu INT,
    MaSP INT,
    SoLuong INT,
    GiaTien FLOAT,
    ThanhTien FLOAT
);
ALTER TABLE PHU_TRACH_DV
ADD FOREIGN KEY (MaPhieu) REFERENCES PHIEU_YEU_CAU(MaPhieu);

ALTER TABLE CT_SANPHAM
ADD FOREIGN KEY (MaPhieu) REFERENCES PHIEU_YEU_CAU(MaPhieu);

ALTER TABLE CT_SANPHAM
ADD FOREIGN KEY (MaSP) REFERENCES SAN_PHAM(MaSP);

INSERT INTO PHIEU_YEU_CAU (MaPhieu, MaKH, HoTen, DienThoai, DiaChi, TGLap, TongTien)
VALUES (1, 1, 'Nguyen Van A', '0123456789', '123 ABC Street', '2022-01-01', 1000000),
       (2, 2, 'Tran Thi B', '0987654321', '456 DEF Street', '2022-01-02', 2000000),
       (3, 3, 'Le Van C', '0123456789', '789 GHI Street', '2022-01-03', 1500000),
       (4, 4, 'Pham Thi D', '0987654321', '321 JKL Street', '2022-01-04', 2500000),
       (5, 5, 'Hoang Van E', '0123456789', '654 MNO Street', '2022-01-05', 3000000);

INSERT INTO PHU_TRACH_DV (MaPhieu, MaDV, TenDV, MaNV, TenNV, TGBatDau, TGHoanTat, GiaTienDV)
VALUES (1, 1, 'Cat toc', 1, 'Tran Thi B', '2022-01-01 09:00:00', '2022-01-01 10:00:00', 100000),
       (2, 2, 'Goi dau', 2, 'Nguyen Van C', '2022-01-02 10:00:00', '2022-01-02 11:00:00', 200000),
       (3, 3, 'Cham soc da mat', 3, 'Le Thi D', '2022-01-03 11:00:00', '2022-01-03 12:00:00', 150000),
       (4, 4, 'Nhuom toc', 4, 'Pham Van E', '2022-01-04 12:00:00', '2022-01-04 13:00:00', 250000),
       (5, 5,'Uon toc' ,5,'Hoang Thi F','2022-01-05 13:00:00','14:00:00' ,300000);

INSERT INTO SAN_PHAM (MaSP,TenSP,GiaTien)
VALUES (1,'Dau goi dau' ,50000),
       (2,'Sua tam' ,40000),
       (3,'Kem duong da' ,60000),
       (4,'Son moi' ,70000),
       (5,'Nuoc hoa' ,80000);

INSERT INTO CT_SANPHAM(MaPhieu,MaSP,Soluong,GiaTien,ThanhTien)
VALUES(1 ,1 ,2 ,50000 ,100000),
      (2 ,2 ,3 ,40000 ,120000),
      (3 ,3 ,4 ,60000 ,240000),
      (4 ,4 ,5 ,70000 ,350000),
      (5 ,5 ,6 ,80000 ,480000);

INSERT INTO CT_SANPHAM (MaPhieu, MaSP, SoLuong, GiaTien, ThanhTien)
VALUES (1, 2, 1, 40000, 40000),
       (1, 3, 1, 60000, 60000),
       (2, 1, 2, 50000, 100000),
       (2, 3, 1, 60000, 60000);


INSERT INTO PHIEU_YEU_CAU (MaPhieu, MaKH, HoTen, DienThoai, DiaChi, TGLap, TongTien)
VALUES (6, 6, 'Nguyen Van F', '0123456789', '123 PQR Street', '2022-01-06', 2000000),
       (7, 7, 'Tran Thi G', '0987654321', '456 STU Street', '2022-01-07', 2500000),
       (8, 8, 'Le Van H', '0123456789', '789 VWX Street', '2022-01-08', 3000000);

INSERT INTO PHU_TRACH_DV (MaPhieu, MaDV, TenDV, MaNV, TenNV, TGBatDau, TGHoanTat, GiaTienDV)
VALUES (6, 1, 'Cat toc', 1, 'Tran Thi B', '2022-01-06 09:00:00', '2022-01-06 10:00:00', 100000),
       (7, 1, 'Cat toc', 1, 'Tran Thi B', '2022-01-07 09:00:00', '2022-01-07 10:00:00', 100000),
       (8, 1,'Cat toc' ,1,'Tran Thi B','2022-01-08 09:00:00','10:00:00' ,100000);

INSERT INTO SAN_PHAM (MaSP,TenSP,GiaTien)
VALUES (6,'Dau goi dau Dove' ,70000);

INSERT INTO CT_SANPHAM(MaPhieu,MaSP,Soluong,GiaTien,ThanhTien)
VALUES(6 ,6 ,1 ,70000 ,70000),
      (7 ,6 ,1 ,70000 ,70000),
      (8 ,6 ,1 ,70000 ,70000);

select * from PHIEU_YEU_CAU
select * from PHU_TRACH_DV
select * from CT_SANPHAM
select * from SAN_PHAM

Select yc.MaPhieu, yc.TGLap, yc.HoTen, yc.DienThoai
From PHIEU_YEU_CAU yc join PHU_TRACH_DV dv on yc.MaPhieu = dv.MaPhieu
			 join CT_SANPHAM ct on ct.MaPhieu = dv.MaPhieu
			 join SAN_PHAM sp on sp.MaSP = ct.MaSP
where dv.TenDV = 'Cat toc' and sp.TenSP = 'Dau goi dau Dove'

-- chọn ra dùng 2 sp
select yc.MaPhieu, yc.TGLap, yc.HoTen, 
(
select sum(ThanhTien)
from CT_SANPHAM ct
where ct.MaPhieu = yc.MaPhieu
)
from PHIEU_YEU_CAU yc
where MaPhieu in (
select MaPhieu
from CT_SANPHAM
group by MaPhieu
having count (MaSP) >= 2
intersect 
select MaPhieu
from PHU_TRACH_DV
where TenDV != 'Cat toc')

select * from PHU_TRACH_DV

INSERT INTO PHIEU_YEU_CAU (MaPhieu, MaKH, HoTen, DienThoai, DiaChi, TGLap, TongTien)
VALUES (9, 9, 'Nguyen Van I', '0123456789', '123 YZA Street', '2022-01-09', 2000000),
       (10, 10, 'Tran Thi J', '0987654321', '456 BCD Street', '2022-01-10', 2500000),
       (11, 11, 'Le Van K', '0123456789', '789 EFG Street', '2022-01-11', 3000000);

INSERT INTO CT_SANPHAM(MaPhieu,MaSP,Soluong,GiaTien,ThanhTien)
VALUES(9 ,1 ,1 ,50000 ,50000),
      (9 ,2 ,1 ,40000 ,40000),
      (10 ,3 ,1 ,60000 ,60000),
      (10 ,4 ,1 ,70000 ,70000),
      (11 ,5 ,1 ,80000 ,80000),
      (11 ,6 ,1 ,70000 ,70000);

INSERT INTO PHU_TRACH_DV (MaPhieu, MaDV, TenDV, MaNV, TenNV, TGBatDau, TGHoanTat, GiaTienDV)
VALUES (9, 2, 'Goi dau', 2, 'Nguyen Van C', '2022-01-09 10:00:00', '2022-01-09 11:00:00', 200000),
       (10, 3, 'Cham soc da mat', 3, 'Le Thi D', '2022-01-10 11:00:00', '2022-01-10 12:00:00', 150000),
       (11, 4,'Nhuom toc' ,4,'Pham Van E','2022-01-11 12:00:00','13:00:00' ,250000);