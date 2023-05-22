--1. Cho biết họ tên và mức lương của các giáo viên nữ.
select HOTEN, LUONG
from GIAOVIEN
where PHAI = N'Nữ'

--2. Cho biết họ tên của các giáo viên và lương của họ sau khi tăng 10%.
select HOTEN, LUONG*1.1 as Luong_update
from GIAOVIEN

--3. Cho biết mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 
--											hoặc,
--											giáo viên là trưởng bộ môn nhận chức sau năm 1995.
select MAGV
from GIAOVIEN
where HOTEN LIKE N'Nguyễn%' AND LUONG > 2000
union
select TRUONGBM
from BOMON
where year(NGAYNHANCHUC) > 1995

-- 4. Cho biết tên những giáo viên khoa Công nghệ thông tin.
 select HOTEN
 from GIAOVIEN
 where MABM in (
 select MABM
 from BOMON
 where MAKHOA = 'CNTT')

-- 5. Cho biết thông tin của bộ môn cùng thông tin giảng viên làm trưởng bộ môn đó.
select *
from BOMON BM join GIAOVIEN GV on BM.TRUONGBM = GV.MAGV

-- 6. Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc.
select *
from GIAOVIEN GV join BOMON BM on BM.MABM = GV.MABM

--7. Cho biết tên đề tài và giáo viên chủ nhiệm đề tài.
select TENDT, GVCNDT
from DETAI

-- 8. Với mỗi khoa cho biết thông tin trưởng khoa.
select *
from KHOA K join GIAOVIEN GV on K.TRUONGKHOA = GV.MAGV

-- 9.Cho biết các giáo viên của bộ môn “Vi sinh” có tham gia đề tài 006.
select *
from GIAOVIEN
where MABM = 'VS' AND MAGV in (
select MAGV
from THAMGIADT
where MADT = '006'
)

-- 10. Với những đề tài thuộc cấp quản lý “Thành phố”, cho biết mã đề tài, đề tài thuộc về chủ
-- đề nào, họ tên người chủ nghiệm đề tài cùng với ngày sinh và địa chỉ của người ấy.
select DT.MADT, CD.MACD, CD.TENCD, GV.HOTEN, Gv.NGAYSINH, GV.DIACHI
from DETAI DT join CHUDE CD on Dt.MACD = cd.MACD join GIAOVIEN GV on Dt.GVCNDT = MAGV
where DT.CAPQL = N'Thành phố'

-- 11. Tìm họ tên của từng giáo viên và người phụ trách chuyên môn trực tiếp của giáo viên đó.
Select gv1.HOTEN, gv2.HOTEN as N'Người quản li chuyên môn'
from GIAOVIEN gv1 left join GIAOVIEN gv2 on gv1.GVQLCM = gv2.MAGV

--Q12. Tìm họ tên của những giáo viên được “Nguyễn Thanh Tùng” phụ trách trực tiếp.
select HOTEN
from GIAOVIEN
where GVQLCM in (
select MAGV
from GIAOVIEN
where HOTEN = N'Nguyễn Thanh Tùng'
)

--Q13. Cho biết tên giáo viên là trưởng bộ môn “Hệ thống thông tin”.
select HOTEN
from GIAOVIEN
where MAGV = (
select TRUONGBM
from BOMON
where TENBM = N'Hệ thống thông tin'
)
--Q14. Cho biết tên người chủ nhiệm đề tài của những đề tài thuộc chủ đề Quản lý giáo dục.
select HOTEN
from GIAOVIEN
where MAGV in (
select GVCNDT
from DETAI
where MACD = 'QLGD'
)
--Q15. Cho biết tên các công việc của đề tài 'HTTT quản lý các trường ĐH' có thời gian bắt đầu
--trong tháng 3/2008.
select TENCV
from CONGVIEC
where NGAYBD >=  '2008/03/01' AND NGAYBD <= '2008/03/31'
AND MADT = (
select MADT
from DETAI
where TENDT = N'HTTT quản lý các trường ĐH'
)

--Q16. Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
Select gv1.HOTEN, gv2.HOTEN as N'Người quản li chuyên môn'
from GIAOVIEN gv1 left join GIAOVIEN gv2 on gv1.GVQLCM = gv2.MAGV

--Q17. Cho biết các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007.
select *
from CONGVIEC
where NGAYBD >=  '2007/01/01' AND NGAYBD <= '2007/08/01'

--Q18. Cho biết họ tên các giáo viên cùng bộ môn với giáo viên “Trần Trà Hương”.
select hoten
from GIAOVIEN
where MABM = 
(
select MABM
from GIAOVIEN
where HOTEN = N'Trần Trà Hương'
)
AND HOTEN <> N'Trần Trà Hương'

--Q19. Tìm những giáo viên vừa là trưởng bộ môn vừa chủ nhiệm đề tài.
select *
from GIAOVIEN
where MAGV in (
				select TRUONGBM
				from BOMON
				)	
				AND MAGV in (
				select GVCNDT
				from DETAI
				)

--Q20. Cho biết tên những giáo viên vừa là trưởng khoa và vừa là trưởng bộ môn.
select HOTEN
from GIAOVIEN
where MAGV in 
			( 
			select TRUONGKHOA
			from KHOA
			)
			AND MAGV in (
			select TRUONGBM
			from BOMON
			)
--Q21. Cho biết tên những trưởng bộ môn mà vừa chủ nhiệm đề tài.
select HOTEN
from GIAOVIEN
where MAGV in (
				select TRUONGBM
				from BOMON
				)	
				AND MAGV in (
				select GVCNDT
				from DETAI
				)
--Q22. Cho biết mã số các trưởng khoa có chủ nhiệm đề tài.
select MAGV
from GIAOVIEN
where MAGV in (
select TRUONGKHOA
from KHOA
)
AND MAGV in (
select GVCNDT
from DETAI
)

--Q23. Cho biết mã số các giáo viên thuộc bộ môn “HTTT” 
					-- hoặc có tham gia đề tài mã “001”.
select MAGV
from GIAOVIEN
where MABM = 'HTTT' 
		or 
	  MAGV in (
	  select MAGV
	  from THAMGIADT
	  where MADT = '001'
	  )
--Q24. Cho biết giáo viên làm việc cùng bộ môn với giáo viên 002.
select *
from GIAOVIEN
where MABM = (
	select MABM
	from GIAOVIEN
	where MAGV = '002'
	)
	AND 
	MAGV <> '002'
--Q25. Tìm những giáo viên là trưởng bộ môn.
select *
from GIAOVIEN
where MAGV in (
select TRUONGBM
from BOMON)

--Q26. Cho biết họ tên và mức lương của các giáo viên.
select HOTEN, LUONG
from GIAOVIEN

--Q27. Cho biết số lượng giáo viên viên và tổng lương của họ.
select count(MAGV) as SoLuongGV , sum(LUONG) as TongLuong
from GIAOVIEN

--Q28. Cho biết số lượng giáo viên và lương trung bình của từng bộ môn.
select MABM ,count(MAGV) as SoLuongGV , AVG(LUONG) as LuongTB
from GIAOVIEN
group by MABM

--Q29. Cho biết tên chủ đề và số lượng đề tài thuộc về chủ đề đó.
select C.TENCD, count(MADT) as N'Số lượng'
from DETAI D join CHUDE C on D.MACD = C.MACD
group by C.TENCD

--Q30. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó tham gia.
select GV.HOTEN, count(distinct MADT) as SoLuong
from THAMGIADT T Join GIAOVIEN GV on T.MAGV = GV.MAGV
group by T.MAGV, GV.HOTEN

--Q31. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó làm chủ nhiệm.
select GV.HOTEN, count(MADT) as SoLuong
from DETAI DT join GIAOVIEN GV on GVCNDT = MAGV
group by DT.GVCNDT, GV.HOTEN

--Q32. Với mỗi giáo viên cho tên giáo viên và số người thân của giáo viên đó.
select GV.HOTEN, 
			(select count(NT.Ten)
			from NGUOI_THAN NT
			where GV.MAGV = NT.MAGV
			) as SoLuong
from GIAOVIEN GV

--Q33. Cho biết tên những giáo viên đã tham gia từ 3 đề tài trở lên.
select HOTEN, count( distinct MADT) as SoDeTai
from GIAOVIEN GV join THAMGIADT TG on GV.MAGV = TG.MAGV
group by GV.MAGV, GV.HOTEN
having count( distinct MADT) >= 3

--Q34. Cho biết số lượng giáo viên đã tham gia vào đề tài Ứng dụng hóa học
select count(DISTINCT MAGV)
from THAMGIADT
where MADT = (
				select MADT
				from DETAI
				where TENDT = N'Ứng dụng hóa học'
				)
