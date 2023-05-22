--Q35. Cho biết mức lương cao nhất của các giảng viên.
select max(LUONG)
from GIAOVIEN
--Q36. Cho biết những giáo viên có lương lớn nhất.
select *
from GIAOVIEN
where LUONG >= all (
select LUONG
from GIAOVIEN
)
--Q37. Cho biết lương cao nhất trong bộ môn “HTTT”.
select MAX(LUONG)
from GIAOVIEN
where MABM = 'HTTT'
--Q38. Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
select Min(Year(NGAYSINH))
from GIAOVIEN
where MABM = 'HTTT'
--Q39. Cho biết tên giáo viên nhỏ tuổi nhất khoa Công nghệ thông tin.
select *
from GIAOVIEN
where MABM in (
			select MABM
			from BOMON
			where MAKHOA = 'CNTT'
			)
		AND
		year(ngaysinh) >= all (
							select year(ngaysinh)
							from GIAOVIEN
							where MABM in (
								select MABM
								from BOMON
								where MAKHOA = 'CNTT'
								)
							)

--Q40. Cho biết tên giáo viên và tên khoa của giáo viên có lương cao nhất.
select GV.HOTEN, K.TENKHOA
from GIAOVIEN GV join BOMON BM on GV.MABM = BM.MABM
				 join KHOA K on K.MAKHOA = BM.MAKHOA
where LUONG >= all (
select LUONG
from GIAOVIEN
)
--Q41. Cho biết những giáo viên có lương lớn nhất trong bộ môn của họ.
select *
from GIAOVIEN GV join (
				select MABM,MAX(LUONG) as Max_Luong
				from GIAOVIEN
				group by MABM ) as T on GV.MABM = T.MABM
where GV.LUONG = T.Max_Luong

--Q42. Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia.

select TENDT
from DETAI

except

select DT.TENDT
from THAMGIADT T join DETAI DT on T.MADT = DT.MADT
where T.MAGV = (
select MAGV
from GIAOVIEN
where HOTEN = N'Nguyễn Hoài An'
)

--Q43. Cho biết những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia. Xuất ra tên đề tài, tên người chủ nhiệm đề tài.
select T.TENDT, GV.HOTEN
from GIAOVIEN GV join (

	select TENDT, GVCNDT
	from DETAI

	except

	select DT.TENDT, DT.GVCNDT
	from THAMGIADT T join DETAI DT on T.MADT = DT.MADT
	where MAGV = (
	select MAGV
	from GIAOVIEN
	where HOTEN = N'Nguyễn Hoài An'
)
) as T on GV.MAGV = T.GVCNDT

--Q44. Cho biết tên những giáo viên khoa Công nghệ thông tin mà chưa tham gia đề tài nào.
-- gv khoa cntt giao với gv có thamgia detai, xong lấy gv k cntt trừ đi
select HOTEN from GIAOVIEN 
except 
select HOTEN
from GIAOVIEN
where		MABM in (
			select MABM
			from BOMON
			where MAKHOA = 'CNTT'
			)
			AND MAGV in (
			select MAGV
			from THAMGIADT
			)
--Q45. Tìm những giáo viên không tham gia bất kỳ đề tài nào
select * from GIAOVIEN 
except 
select *
from GIAOVIEN
where		MAGV in (
			select MAGV
			from THAMGIADT
			)
--Q46. Cho biết giáo viên có lương lớn hơn lương của giáo viên “Nguyễn Hoài An”
select *
from GIAOVIEN
where LUONG > (
select LUONG
from GIAOVIEN
where HOTEN = N'Nguyễn Hoài An'
)
--Q47. Tìm những trưởng bộ môn tham gia tối thiểu 1 đề tài
-- là trưởng bộ môn và có tham gia đề tài
select * from GIAOVIEN join (
select TRUONGBM
from BOMON
intersect 
select MAGV
from THAMGIADT) as T on MAGV = T.TRUONGBM

--Q48. Tìm giáo viên trùng tên và cùng giới tính với giáo viên khác trong cùng bộ môn
select GV.*
from GIAOVIEN GV join (
select MABM, PHAI, HOTEN
from GIAOVIEN
group by MABM,PHAI, HOTEN
having count(MAGV) > 1 ) as T on GV.HOTEN = T.HOTEN and GV.PHAI = T.PHAI AND GV.MABM = T.MABM
--Q49. Tìm những giáo viên có lương lớn hơn lương của ít nhất một giáo viên bộ môn “Công nghệ phần mềm”
select *
from GIAOVIEN
where LUONG >= any (
select Luong
from GIAOVIEN
where MABM = 'CNPM'
)
--Q50. Tìm những giáo viên có lương lớn hơn lương của tất cả giáo viên thuộc bộ môn “Hệ thống thông tin”
select* 
from GIAOVIEN
Where Luong > all (
select Max(Luong)
from GIAOVIEN
where MaBM = 'HTTT')
--Q51. Cho biết tên khoa có đông giáo viên nhất
select TENKHOA, count(MAGV) as SoLuong
from KHOA K join BOMON BM on K.MAKHOA = BM.MAKHOA
			join GIAOVIEN GV on GV.MABM = BM.MABM
group by TENKHOA
having count(MAGV) >= all (
select count(MAGV)
from KHOA K join BOMON BM on K.MAKHOA = BM.MAKHOA
			join GIAOVIEN GV on GV.MABM = BM.MABM
group by TENKHOA
)
--Q52. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
select GV.HOTEN, count(DT.MADT)
from DETAI DT join GIAOVIEN GV on DT.GVCNDT = GV.MAGV
group by GV.HOTEN
having count(DT.MADT) >= all (
select count(MADT)
from DETAI
group by GVCNDT
)
--Q53. Cho biết mã bộ môn có nhiều giáo viên nhất
--Q54. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
select GV.HOTEN
from GIAOVIEN GV join (
select MAGV
from THAMGIADT
group by MAGV
having count(distinct MADT) >= all (
	select count(distinct MADT)
	from THAMGIADT
	group by MAGV )
	) as T on GV.MAGV = T.MAGV
--Q55. Cho biết tên giáo viên tham gia nhiều đề tài nhất của bộ môn HTTT.
--Q56. Cho biết tên giáo viên và tên bộ môn của giáo viên có nhiều người thân nhất.
--Q57. Cho biết tên trưởng bộ môn mà chủ nhiệm nhiều đề tài nhất.


---- chưa tgia đề tài
select MAGV
from giaovien
where MAGV not in ( -- hoạt động trên 1 thuộc tính
select MAGV
from THAMGIADT
)

select GV.magv
from GIAOVIEN GV
where not exists -- hoạt động trên 1 bộ
(select * from THAMGIADT
where THAMGIADT.MAGV = GV.MAGV)

--- -- PHÉP CHIA
-- tìm gv tham gia tất cả đề tài
-- R: ThamGiaDT(MAGV, MADT)
-- S: DeTai
-- KQ: MAGV
-- in SQL:
-- Xét từng MAGV trong R sao cho
-- nếu tìm các đề tài mà gv i chưa tham gia
-- nếu tìm thấy: không tham gia tất cả đề tài
-- tìm thấy: gv i tham gia tất cả

select GV.MAGV
from GIAOVIEN GV
where not exists
( 
 select MADT
 from DETAI
 except
 select MADT
 from THAMGIADT TG
 where TG.MAGV = GV.MAGV
)

---- Tìm ds các gv (mã gv, họ tên) tg tất cả đề tài cấp trường
select R.MaGV
from THAMGIADT R join GIAOVIEN GV on R.MAGV = GV.MAGV
where not exists
(-- ds các đề tài cấp trường gv i chưa tham gia)
 select MADT
 from DETAI
 where CAPQL = N'Trường'

 except

 select MADT
 from THAMGIADT TG
 where TG.MAGV = R.MAGV
)


select distinct TG.MAGV
from THAMGIADT TG join DETAI DT on TG.MADT = DT.MADT
where DT.CAPQL = 'Trường'
group by TG.MAGV
having count(distinct DT.MADT) = 
(
select count(MADt)
from DETAI
where CAPQL = 'Trường'
)


--Q58: tên gv tham gia đề tài đủ tất cả chủ đề
-- R ThamGiaDT(MaGV, MaDT)
-- S: tất cả chủ đề (Detai(madt, macd))
-- KQ: Tên gv

select R.MaGV
from THAMGIADT R
where not exists -- chọn ra chủ đề chưa tham gia
(
		select macd from ChuDe S
		except
		select MACD-- tìm gv 1 tham gia chủ đề nào
		from
			THAMGIADT TG join DETAI DT
			on TG.MADT = DT.MADT
		where R.MAGV = TG.MAGV
)


select R.MaGV
from THAMGIADT R
where not exists 
( -- chọn ra chủ đề gv i chưa tham gia
	select macd from CHUDE S -- chọn ra mã chủ đề không có trong bảng đã tham gia
	where not exists
		(
		select *
		from
		THAMGIADT TG join DETAI DT
					on TG.MADT = DT.MADT
				where R.MAGV = TG.MAGV and S.MACD = DT.MACD
		)
)

-- not in

select R.MaGV
from THAMGIADT R
where not exists 
(
-- ds chủ đề mà gv đó chưa tham gia
			select dt1.MADT from detai dt1
			where dt1.MaDT not in (
						select tg.MADT
						from THAMGIADT tg join DETAi dt on tg.MADT = dt.MADT
						where tg.MADT = dt1.MADT and tg.MAGV = R.MaGV
						)
)


-- group by having


-- cho biết giảng viên tham gia nhiều đê tài cấp trường nhất của bộ mon httt

select magv, count(distinct madt)
from THAMGIADT
where MaGV in (
	select MAGV
	from GIAOVIEN
	where MABM = 'HTTT'
)
group by MaGV
having count(distinct madt) >= all (
		-- đếm số đề tài cấp trường mà gv httt đã tham gia
		select count (distinct tg.MaDT)
		from THAMGIADT tg join DETAI dt on tg.MADT = dt.MADT
				join GIAOVIEN gv on tg.MAGV = gv.MAGV
		where dt.CAPQL = N'Trường' and gv.MABM = N'HTTT'
		group by gv.MAGV
)

--Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn HTTT tham gia.
-- R: TenDeTai + Giao Vien => GV + DeTai + ThamGia
-- S: gv httt

-- except
select d.TENDT
from DETAI d
where not exists
( -- danh sách giáo viên không tham gia đề tài đó
select MaGV from GIAOVIEN where MaBM = 'HTTT'
except
select MaGV 
from THAMGIADT tg join DeTai dt on tg.MADT = dt.MADT
where dt.TENDT = d.TENDT
)

-- not in
select d.TENDT
from DETAI d
where not exists (
( -- danh sách giáo viên không tham gia đề tài đó
	select gv.MAGV from GiaoVien gv 
	where gv.MABM = 'HTTT' and gv.MaGV not in (
		-- ds gv tham gia đề tài đó
			select tg.MaGV from THAMGIADT tg
			where tg.MaGV = gv.MAGV 
				  and tg.MADT = d.MADT
		)
	)
)

-- not exists
select d.TENDT
from DETAI d
where not exists (
-- giáo viên httt không tham gia đề tài đó
-- CHỌN RA CÁC GV MÀ TRONG DS THAM GIA ủac gv đó K CÓ ĐỀ TÀI ĐÓ
select *
from GIAOVIEN gv
where gv.MABM = 'HTTT' and not exists (
	select *
	from THAMGIADT tg join DETAI dt
	on tg.MADT = dt.MADT
	where gv.MAGV = tg.MAGV and d.MADT = dt.MADT
	)
)
-- 61.  Cho biết giáo viên nào đã tham gia tất cả các đề tài có mã chủ đề là QLGD
-- R: GV + đề tài quản lí giáo dục đã tha gia
-- S: DeTai có mã là quản lí giáo dục
select *
from GIAOVIEN gv
where not exists (
-- danh sách đề tài qlgd chưa tham gia
select MaDT from DETAI where MaCD = 'QLGD'
except
select dt.MADT
from DETAI dt join THAMGIADT tg on dt.MADT = tg.MADT
where MaCD = 'QLGD' and tg.MAGV = gv.MAGV
)

select *
from GIAOVIEN gv
where not exists (
-- danh sách đề tài QLGD gv i chưa tham gia
		select *
		from DETAI dt
		where dt.MaCD = 'QLGD'
		and dt.MADT not in (
			select td1.MADT
			from THAMGIADT td1
			where td1.MADT = dt.MADT and gv.MAGV = td1.MAGV
		)
)


select *
from GIAOVIEN gv
where not exists (
--	ds đề tài qlgd mà gv i không tham gia
	select dt1.TENDT
	from DETAI dt1
	where dt1.MACD = 'QLGD' and not exists (
		select *
		from DETAI dt join THAMGIADT tg on dt.MADT = tg.MADT
		where dt1.MADT = dt.MADT and gv.MAGV = tg.MAGV 
	)
) 

-- Cho biết tên giáo viên nào tham gia tất cả các đề tài mà giáo viên Trần Trà Hương đã tham gia
-- R: gv + đề tài
-- S: đề tài trần trà hương đã tham gia
select *
from GIAOVIEN gv
where not exists (
-- danh sách đề tài gv TTH tham gia nhưng gv này chưa tham gia
	select dt.MaDT
	from DETAI dt join THAMGIADT tg on dt.MADT = tg.MADT
	where tg.MAGV= (
						select MAGV
						from GIAOVIEN
						where HOTEN = N'Trần Trà Hương'
						)

	except

	select dt.MaDT
	from DETAI dt join THAMGIADT tg on dt.MADT = tg.MADT
	where tg.MAGV = gv.MAGV
)

-- not in
-- Cho biết tên giáo viên nào tham gia tất cả các đề tài mà giáo viên Trần Trà Hương đã tham gia
select *
from GIAOVIEN gv
where not exists (
-- danh sách đề tài gv TTH tham gia nhưng gv này chưa tham gia
	select dt.MADT
	from  DETAI dt join THAMGIADT tg on dt.MADT = tg.MADT
	where tg.MAGV= (
						select MAGV
						from GIAOVIEN
						where HOTEN = N'Trần Trà Hương'
						)
			and 
			dt.MADT not in (
			-- danh sach tham gia của gv i
			select dt1.MADT
			from  DETAI dt1 join THAMGIADT tg1 on dt1.MADT = tg1.MADT
			where tg1.MAGV = gv.MAGV
			)
)
-- not exixsts
select *
from GIAOVIEN gv
where not exists (
-- ds gv TTH tgia mà gv i k tham gia
			select dt.MADT
			from  DETAI dt join THAMGIADT tg on dt.MADT = tg.MADT
			where tg.MAGV= (
								select MAGV
								from GIAOVIEN
								where HOTEN = N'Trần Trà Hương'
								)
			and not exists (
					select dt1.MADT
					from  DETAI dt1 join THAMGIADT tg1 on dt1.MADT = tg1.MADT
					where tg1.MAGV = gv.MAGV and dt.MADT = dt1.MADT
			)
		)
-- Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn Hóa Hữu Cơ tham gia.
-- Tên đề tài, tên giáo viên HHC
-- S: tất cả giáo viên bộ môn HHC
select dt.MADT
from DeTai dt
where not exists (
-- ds gv k tham gia đề tài trên
		select MaGV
		from GIAOVIEN
		where MABM = (
				select MaBM from BOMON where TENBM = N'Hóa Hữu Cơ')
		except
		select tg1.MAGV
		from DETAI dt1 join THAMGIADT tg1 on dt1.MADT = tg1.MADT
		where tg1.MADT = dt.MADT 
)

select dt.MADT
from DeTai dt
where not exists (
-- danh sách giáo viên hóa hữu cơ không tham gia đề tài
	select MaGV
	from GIAOVIEN gv
	where MABm = 'HHC' and not exists (
			select *
			from THAMGIADT tg
			where tg.MAGV = gv.MAGV and dt.MADT = tg.MADT
	)
)

-- Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài 006
--R: Mã Gv thâm gia công việc
--S : tất cả công việc của đề tài 006
-- not in
select gv.MAGV, gv.HOTEN
from GIAOVIEN gv
where not exists (
-- danh sách các công việc đề tài 006 mà gv đó chưa làm
	select distinct cv.STT -- not in gv i đã làm
	from THAMGIADT tg join Congviec cv on tg.MADT = cv.MADT and tg.STT = cv.STT
	where cv.MADT = '006' and cv.STT not in (
		select tgg.STT
		from THAMGIADT tgg
		where tgg.MAGV = gv.MAGV and tgg.MADT = '006'
	)
)


