USE [QLBanHang]
GO
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'01        ', N'Nguyễn Văn A                  ', N'Nam       ', N'0854755867', N'Quận 7, Hồ Chí Minh           ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'02        ', N'Lưu Văn B                     ', N'Nam       ', N'0147589632', N'Quận 7, Hồ Chí Minh           ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'03        ', N'Lưu Thị C                     ', N'Nữ        ', N'0147589364', N'Quận 1, Hồ Chí Minh           ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'04        ', N'Trần Văn D                    ', N'Nam       ', N'0157896547', N'Quận 3, Hồ Chí Minh           ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (N'05        ', N'Nguyễn E                      ', N'Nam       ', N'0125364789', N'Quận 3, Hồ Chí Minh           ')
GO
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'01        ', CAST(N'2021-08-09' AS Date), N'02        ')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'02        ', CAST(N'2021-10-04' AS Date), N'03        ')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'03        ', CAST(N'2021-12-15' AS Date), N'01        ')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'04        ', CAST(N'2022-04-01' AS Date), N'04        ')
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (N'05        ', CAST(N'2023-01-01' AS Date), N'05        ')
GO
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'01        ', N'Sách      ', CAST(N'2021-12-25' AS Date), 5000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'02        ', N'Tập       ', CAST(N'2021-12-27' AS Date), 2000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'03        ', N'Bàn       ', CAST(N'2022-10-28' AS Date), 50000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'04        ', N'Ghế       ', CAST(N'2022-04-07' AS Date), 20000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (N'05        ', N'Thước     ', CAST(N'2022-08-09' AS Date), 5000)
GO
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'01        ', N'05        ', 5, 5000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'02        ', N'03        ', 8, 50000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'03        ', N'04        ', 4, 20000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'04        ', N'01        ', 1, 5000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (N'05        ', N'03        ', 3, 50000)
GO
