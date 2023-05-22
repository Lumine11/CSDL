-- 21120580 _ Trần Thị Kim Trinh
--Query 
--01. Cho biết mã sản phẩn, tên, giá tiền, và đơn vị tính của những sản phẩm có giá trên 100 (nghìn) đồng.
SELECT MASP, TENSP , GIATIEN , DVTINH 
FROM SANPHAM
WHERE GIATIEN > 100

--02. Cho biết những sản phẩm có loại là “Đồ dùng”.
SELECT *
FROM SANPHAM, LOAISP
WHERE SanPham.MaLoai = LoaiSP.MaLoai AND
		LoaiSP.TenLoai = N'Đồ dùng'

--03. Cho biết tên và giá tiền của các sản phẩm “Bàn chải đánh răng”.
SELECT TENSP, GIATIEN
FROM SANPHAM
WHERE TENSP LIKE N'Bàn chải đánh răng%'

--04. Cho biết tên sản phẩm và tên loại sản phẩm.
SELECT SP.TENSP, LSP.TENLOAI
FROM SANPHAM SP , LOAISP LSP 
WHERE SP.MALOAI = LSP.MALOAI

--05. Cho biết tên sản phẩm và tên loại sản phẩm của những sản phẩm có số lượng tồn > 50.
SELECT SP.TENSP, LSP.TENLOAI
FROM SANPHAM SP , LOAISP LSP 
WHERE SP.MALOAI = LSP.MALOAI
AND  SP.LUONGTON > 50

--06. Cho biết những sản phẩm có đơn vị tính là “túi”.
SELECT*
FROM SANPHAM SP
WHERE SP.DVTINH = N'túi'

-- 07. Cho biết tên loại sản phẩm của mặt hàng “Bột giặt Omo”.
SELECT LSP.TENLOAI
FROM SANPHAM SP JOIN LOAISP LSP ON SP.MALOAI = LSP.MALOAI 
WHERE SP.TENSP = N'Bột giặt Omo'

-- 08. Cho biết tên của sản phẩm có giá thấp nhất.
SELECT SP.TENSP
FROM SANPHAM SP
WHERE 
SP.GIATIEN = 
(
SELECT MIN(SP.GIATIEN)
FROM SANPHAM SP
)

-- 09. Cho biết tên của sản phẩm có giá cao nhất
SELECT SP.TENSP
FROM SANPHAM SP
WHERE 
SP.GIATIEN = 
(
SELECT MAX(SP.GIATIEN)
FROM SANPHAM SP
)

select min(SP.GiaTien)
from SanPham SP
group by SP.TenSP