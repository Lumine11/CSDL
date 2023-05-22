create database QLiLopHoc21120580
go
use QLiLopHoc21120580
go

create table LopHoc(
MaLop char(5), 
TenLop nvarchar(40) unique, 
LopTruong char(4), 
SiSo int default 0, 
Phong char(3)
constraint PK_Lop primary key (MaLop)
)
create table ToHT(
IDLop char(5), 
STT int,
TenTo nvarchar(20),
ToTruong char(4)
constraint PK_ToHT primary key (IDLop, STT)
)
create table HocVien(
MaHV char(4),
HoTen nvarchar(30),
NgaySinh date,
Phai nchar(5) check (Phai in (N'nam', N'nữ')),
IDLop char(5),
IDTo int,
constraint PK_HV primary key (MaHV)
)

alter table LopHoc
add constraint FK_LH_HV
foreign key (LopTruong)
references HocVien(MaHV)

alter table ToHT
add constraint FK_To_Lop
foreign key (IDLop)
references LopHoc(Malop)

alter table ToHT
add constraint FK_To_HV
foreign key (ToTruong)
references HocVien(MaHV)

alter table HocVien
add constraint FK_HV_To
foreign key (IDLop, IDTo)
references ToHT(IDLop, STT)

---- Nhập liệu
insert into LopHoc
values('LH011', N'Lớp một 1', null, 2, 'P01')

insert into LopHoc
values('LH012', N'Lớp một 2', null, 2, 'P02')

insert into LopHoc
values('LH013', N'Lớp một 3', null,0 , 'P03')

insert into ToHT
values ('LH011',1 ,N'Tổ 1', null)

insert into ToHT
values ('LH012',1 ,N'Tổ 1', null)

insert into ToHT
values ('LH012',2 ,N'Tổ 2', null)

insert into HocVien
values ('HV01',N'Bảo Duy','2015-01-12','nam','LH012',1)

insert into HocVien
values ('HV02',N'Kiều Linh','2015-04-05',N'nữ','LH012',1)

insert into HocVien
values ('HV06',N'Mai Anh','2015-01-01',N'nữ','LH012',2)

insert into HocVien
values ('HV03',N'Trúc An','2015-07-15',N'nữ','LH011',1)

insert into HocVien
values ('HV04',N'Gia Hào','2015-09-28','nam','LH012',2)

update LopHoc
set LopTruong = 'HV03'
where MaLop = 'LH011'

update LopHoc
set LopTruong = 'HV01'
where MaLop = 'LH012'

update ToHT
set ToTruong = 'HV04'
where IDLop = 'LH011' and STT = 1

update ToHT
set ToTruong = 'HV02'
where IDLop = 'LH012' and STT = 1

update ToHT
set ToTruong = 'HV06'
where IDLop = 'LH012' and STT = 2

-- truy vấn
--Cho danh sách các lớp chưa có học viên
select MaLop from LopHoc
except
select IDLop from HocVien

--Cho danh sách các học viên (mã hv, tên hv, tên tổ, tên tổ trưởng) của tổ 1 trong
--lớp một 2
select HV.MaHV, HV.HoTen, T.TenTo, HV2.HoTen
from LopHoc LH join ToHT T on LH.MaLop = T.IDLop
		join HocVien HV on T.IDLop = HV.IDLop AND T.STT = HV.IDTo
		join HocVien HV2 on T.ToTruong = HV2.MaHV
where STT = 1 AND TenLop = N'Lớp một 2'

-- Đếm số học viên trong mỗi tổ của lớp một 2.
select STT, count (distinct MAHV)
from LopHoc LH join ToHT T on LH.MaLop = T.IDLop
		join HocVien HV on T.IDLop = HV.IDLop AND T.STT = HV.IDTo
where TenLop = N'Lớp một 2'
group by STT

