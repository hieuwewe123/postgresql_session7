CREATE INDEX idx_email ON SinhVien(email);
CREATE INDEX idx_lop_id ON SinhVien(lop_id);
CREATE INDEX idx_que_quan ON SinhVien(que_quan);
CREATE INDEX idx_gioi_tinh_que_quan ON SinhVien(gioi_tinh, que_quan);

CREATE VIEW v_bao_cao_diem AS
SELECT 
    sv.ma_sv,
    sv.ho_ten,
    sv.email,
    l.ten_lop,
    COUNT(bd.id) as so_mon_hoc,
    AVG(bd.diem_so) as diem_trung_binh
FROM SinhVien sv
JOIN LopHoc l ON sv.lop_id = l.id
JOIN BangDiem bd ON sv.id = bd.sinh_vien_id
GROUP BY sv.id, sv.ma_sv, sv.ho_ten, sv.email, l.ten_lop;

CREATE VIEW v_thong_ke_lop AS
SELECT 
    l.ten_lop,
    COUNT(sv.id) as si_so,
    AVG(bd.diem_so) as diem_tb_lop,
    CASE 
        WHEN AVG(bd.diem_so) >= 8 THEN 'Giỏi'
        WHEN AVG(bd.diem_so) >= 6.5 THEN 'Khá'
        WHEN AVG(bd.diem_so) >= 5 THEN 'Trung Bình'
        ELSE 'Yếu'
    END as hoc_luc
FROM LopHoc l
JOIN SinhVien sv ON l.id = sv.lop_id
JOIN BangDiem bd ON sv.id = bd.sinh_vien_id
GROUP BY l.ten_lop;

CREATE MATERIALIZED VIEW mv_thong_ke_toan_truong AS
SELECT 
    que_quan,
    gioi_tinh,
    COUNT(*) as so_luong,
    AVG(diem_trung_binh) as diem_tb_tinh
FROM v_bao_cao_diem
GROUP BY que_quan, gioi_tinh;

CREATE VIEW v_sinh_vien_ca_nhan AS
SELECT 
    ma_sv, ho_ten, email, ten_lop, diem_trung_binh
FROM v_bao_cao_diem
WHERE email = CURRENT_USER;

CREATE VIEW v_giang_vien AS
SELECT 
    ma_sv, ho_ten, ten_lop, diem_trung_binh
FROM v_bao_cao_diem;