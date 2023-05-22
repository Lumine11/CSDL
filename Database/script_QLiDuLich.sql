-- MSSV: 21120580
-- Họ tên: Trần Thị Kim Trinh


create database QLiDuLich
go
use QLiDuLich
go

create table Tinh_TP(
QuocGia char(10),
MaTinhThanh char(10),
TenTT char(10),
SoDan int, check (SoDan > 0),
DienTich float, check (DienTich > 0), -- đề ghi int nhưng trong bảng lại biểu diễn số thực nên em đổi lại
DiemDLUaThichNhat char(10),
constraint PK_Tinh_TP primary key (QuocGia, MaTinhThanh)
)

create table QUOCGIA(
MaQG char(10),
TenQG nchar(10) unique,
ThuDo char(10),
constraint PK_QuocGia primary key (MaQG)
)
create table DIEM_DL(
MaDiaDiem char(10),
TenDiaDiem nchar(50),
TinhTP char(10),
QuocGia char(10),
DacDiem nchar(100)
constraint PK_DiemDL primary key (MaDiaDiem,TinhTP,QuocGia)
)

alter table Tinh_TP
add constraint FK_Tinh_QG
foreign key (QuocGia)
references QUOCGIA(MaQG)

alter table QUOCGIA
add constraint FK_QG_T
foreign key (MaQG, ThuDo)
references Tinh_TP(QuocGia,MaTinhThanh)

alter table DIEM_DL
add constraint FK_Diem_TinhTP
foreign key (QuocGia, TinhTP)
references Tinh_TP(QuocGia, MaTinhThanh)

alter table Tinh_TP
add constraint FK_Tinh_DiemDL
foreign key (DiemDLUaThichNhat, MaTinhThanh, QuocGia)
references DIEM_DL(MaDiaDiem, TinhTP, QuocGia)

-- do nhập theo thứ tự đề bài thì sẽ lỗi nên em đổi lại nhập quốc gia trước
insert into QUOCGIA
values('QG001' , N'Việt Nam', null)
insert into QUOCGIA
values('QG002' , N'Nhật Bản', null)

insert into Tinh_TP
values ('QG001', 'TT001', N'Hà Nội', 2500000 ,927.39, null)
insert into Tinh_TP
values ('QG001', 'TT002', N'Huế', 5344000 ,5009.00, null)
insert into Tinh_TP
values ('QG002', 'TT001', N'Tokyo', 12084000 ,2187.00, null)
insert into Tinh_TP
values ('QG002', 'TT002', N'Osaka', 18000000 ,221.96, null)

update QUOCGIA
set ThuDo = 'TT001'
where MAQG = 'QG001'

update QUOCGIA
set ThuDo = 'TT001'
where MAQG = 'QG002'

insert into DIEM_DL 
values('DD001', N'Văn Miếu', 'TT001', 'QG001', N'Di tích cổ')
insert into DIEM_DL 
values('DD002', N'Hoàng lăng', 'TT002', 'QG001', N'Di tích cổ')
insert into DIEM_DL 
values('DD001', N'Núi Fuji', 'TT001', 'QG002', N'Núi lửa ngưng hoạt động cao nhất Nhật Bản')
insert into DIEM_DL 
values('DD001', N'Minami', 'TT002', 'QG002', N'quê hương của cây cầu Shinsaibashi')
insert into DIEM_DL 
values('DD002', N'Lâu đài Osaka', 'TT002', 'QG002', N'Chứa bảo tàng thông tin lịch sử của lâu đài và Toyotomi Hideyoshi')


update Tinh_TP
set DiemDLUaThichNhat= 'DD001'
where QuocGia = 'QG001' and MaTinhThanh = 'TT001' 

update Tinh_TP
set DiemDLUaThichNhat= 'DD002'
where QuocGia = 'QG001' and MaTinhThanh = 'TT002' 

update Tinh_TP
set DiemDLUaThichNhat= 'DD001'
where QuocGia = 'QG002' and MaTinhThanh = 'TT002' 

