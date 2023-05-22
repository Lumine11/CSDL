-- 22 Cho biết số lượng khách hàng của từng phái. 
select Gender,count(MaKH) as SoLuongKhach
from KhachHang
group by Gender

--23 Cho biết số lượng khách hàng ở từng tỉnh thành.
select Addr,count(MaKH) as SoLuongKhach
from KhachHang
group by Addr

 --24 Cho biết Tỉnh thành có nhiều khách hàng nhất.
select Addr,count(MaKH) as SoLuongKhach
from KhachHang
group by Addr
having count(MAKH) >= all (
select count(MaKH)
from KhachHang
group by Addr
)

-- Cho tên, địa chỉ, điện thoại biết khách hàng cao tuổi nhất. 
select Hoten, Addr, DienThoai
from KhachHang
where NamSinh <= all (
select NamSinh
from KhachHang
)

-- 26 Cho biết số lượng khách hàng sinh ra trong từng năm. Gom nhóm
select NamSinh, count(MaKH)  as SoLuongKhach
from KhachHang
group by NamSinh

-- 27 Cho biết mã khách hàng của những khách hàng chưa từng mua hàng. Đơn giản, tập
-- hợp
select MaKH from KhachHang
except 
select MAKH from HoaDon

--28 Cho biết mã khách hàng và tên của những khách hàng chưa từng mua hàng. 
select KH.MaKH, KH.Hoten
from KhachHang KH join (
select MaKH from KhachHang
except 
select MAKH from HoaDon) as T on KH.MaKH = T.MaKH

--29 Cho biết mã khách hàng và số lần mua hàng của khách hàng đó. 
select MaKH,count(MaHd) as SoLanMua
from HoaDon
group by MaKH

--  30 Cho biết mã khách hàng, tên và số lần mua hàng của mỗi khách hàng. Gom nhóm
select K.MaKH, K.Hoten, count(MaHD) as SoLanMua
from KhachHang K join HoaDon H on K.MaKH = H.MaKH
group by K.MaKH, K.Hoten

-- 31 Cho biết mã khách hàng của khách hàng đã mua hàng nhiều lần nhất.
select MaKH
from HoaDon
group by MaKH
having count(MaHd) >= all (
select count(MaHd)
from HoaDon
group by MaKH
)

-- 32 Cho biết mã khách hàng và tên của những khách hàng đã mua hàng nhiều lần nhất.
select H.MaKH, K.Hoten
from HoaDon H join KhachHang K on H.MaKH = K.MaKH
group by H.MaKH, K.Hoten
having count (MaHD) >= all 
(
select count(MaHd)
from HoaDon
group by MaKH
)
