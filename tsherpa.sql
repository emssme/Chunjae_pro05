CREATE DATABASE tsherpa;
DROP DATABASE tsherpa;
USE tsherpa;

-- 회원
CREATE TABLE member(
    mno BIGINT PRIMARY KEY AUTO_INCREMENT,            -- 고유번호
    id VARCHAR(20) UNIQUE KEY NOT NULL,             -- 로그인 아이디
    pw VARCHAR(300) NOT NULL,                       -- 비밀번호
    name VARCHAR(100) NOT NULL,                     -- 이름
    tel VARCHAR(20) NOT NULL,                       -- 전화번호
    email VARCHAR(100),                             -- 이메일
    addr1 VARCHAR(100),                             -- 주소
    addr2 VARCHAR(200),                             -- 상세 주소
    addr3 VARCHAR(100),                             -- 주요 직거래 주소
    postcode VARCHAR(10),                           -- 우편 번호
    status VARCHAR(50) DEFAULT 'ACTIVE',            -- REMOVE(삭제), DORMANT(휴면), ACTIVE(활동)
    createAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- 회원 등록일
    loginAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP     -- 마지막 로그인
);

INSERT INTO member (id, pw, name, tel, addr3, status) VALUES ('admin', '$2a$10$oS1.3wpbnpIanIW4RoXxSOea/vGIijBMpLUBxZqurQqNjjMiJHgGa', 'admin', '010-1111-1111','가산동', default);
INSERT INTO member (id, pw, name, tel, addr3) VALUES ('teacher1', '$2a$10$oS1.3wpbnpIanIW4RoXxSOea/vGIijBMpLUBxZqurQqNjjMiJHgGa', '김쌤1', '010-1111-1111','가산동');
INSERT INTO member (id, pw, name, tel, addr3) VALUES ('teacher2', '$2a$10$oS1.3wpbnpIanIW4RoXxSOea/vGIijBMpLUBxZqurQqNjjMiJHgGa', '김쌤2', '010-1111-1111','가산동');
INSERT INTO member (id, pw, name, tel, addr3) VALUES ('teacher3', '$2a$10$oS1.3wpbnpIanIW4RoXxSOea/vGIijBMpLUBxZqurQqNjjMiJHgGa', '김쌤3', '010-1111-1111', '가산동');
INSERT INTO member (id, pw, name, tel, status) VALUES ('rest', '$2a$10$oS1.3wpbnpIanIW4RoXxSOea/vGIijBMpLUBxZqurQqNjjMiJHgGa', 'admin', '010-1111-1111', 'REST');
INSERT INTO member (id, pw, name, tel, status) VALUES ('out', '$2a$10$oS1.3wpbnpIanIW4RoXxSOea/vGIijBMpLUBxZqurQqNjjMiJHgGa', 'admin', '010-1111-1111', 'OUTSIDE');
UPDATE member set loginAt='2023-08-15 15:12:35' WHERE id='rest'
UPDATE member set status='ACTIVE' WHERE id='rest'

CREATE EVENT daily_update_status
    ON SCHEDULE
    EVERY 60 SECOND
    STARTS CURRENT_TIMESTAMP
            DO
UPDATE member
SET status = 'REST'
WHERE loginAt <= DATE_SUB(NOW(), INTERVAL 30 DAY);

-- 상품 카테고리 (추가됨)
CREATE TABLE category(
	cate VARCHAR(50) NOT NULL PRIMARY KEY, 	-- 카테고리 코드
	cateName VARCHAR(100) NOT NULL);				-- 카테고리 이름
	
INSERT INTO category VALUES('A', '국어');
INSERT INTO category VALUES('B', '수학');
INSERT INTO category VALUES('C', '영어');
INSERT INTO category VALUES('D', '기타');


-- 중고거래 상품
CREATE TABLE product(
    pno BIGINT PRIMARY KEY AUTO_INCREMENT,
    pname VARCHAR(300) NOT NULL,                                -- 상품 이름
    content VARCHAR(2000),                                      -- 상품 설명
    cate VARCHAR(100),                                      	 -- 상품 카테고리
    seller VARCHAR(20) NOT NULL,                                -- 판매자 member.id
    price INT NOT NULL DEFAULT 0,                               -- 상품 가격
    proaddr VARCHAR(100),                                       -- 직거래 동네
    image BIGINT,                                                 -- 썸네일 이미지
    createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,      -- 등록일
    baseAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,        -- 끌어올리기 날짜
    status VARCHAR(50) DEFAULT 'SALE',                          -- REMOVE(삭제), 'SALE' 판매중, 'RESERVED' 예약중, 'OUT' 거래 완료
    visited INT DEFAULT 0,                                      -- 조회수
    heart INT DEFAULT 0                                         -- 찜한 수
);

INSERT INTO product VALUES(DEFAULT, '중2 교과서 작품읽기','국어 교과서 작품읽기 전권 판매합니다. 사용감 좀 있어요','A','teacher1',15000, '연남동',NULL, DEFAULT, DEFAULT, 'RESERVED',DEFAULT, 3);
INSERT INTO product VALUES(DEFAULT, '매3비,매3문 세트 판매합니다.','매3비,매3문 세트 판매합니다. 새책이에요','A','teacher3',10000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, 10);
INSERT INTO product VALUES(DEFAULT, '교사용 국어 참고서 판매합니다.','교사용 참고서 입니다. 평가 문제도 포함되어 있어요','A','teacher1',5000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, default);
INSERT INTO product VALUES(DEFAULT, '교사용 국어 참고서 판매합니다.','교사용 참고서 입니다. 평가 문제도 포함되어 있어요','A','teacher1',5000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '국어 한글 카드게임.','사용감있습니다','A','teacher2',0, '연희동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '국어 초등 학력평가 문제집','똑같은 책이 하나 더 생겨서 나눔해요~','A','teacher2',0, '구로2동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '수학의 샘 교사용 문제집','새책입니다','B','teacher2',20000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '수학 마플 문제집','앞에 조금 필기되어있어요','B','teacher3',8000, '구로동',NULL, DEFAULT, DEFAULT, 'RESERVED',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '수학 중학 수학 문제집','새책입니다','B','teacher3',10000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '유아 영어 알파벳 교구 나눔합니다','사용감 좀 있어요','C','teacher1',0, '가산동',NULL, DEFAULT, DEFAULT, 'RESERVED',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '영어교사를 위한 고급 영문법','강의하면서 도움 많이 받았던 책이에요','C','teacher2',0, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '컨셉 영어 듣기 모의고사, 백발백중 영어 문제집','영어책 중 가장 좋은거같아요','C','teacher3',7000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '사회 세계지도 판매합니다', '가르칠때 도움 많이 되었어요','D','teacher3',3000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '독도퍼즐 판매합니다', '수업시간에 학생들이 많이 좋아해요','D','teacher1',5000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, DEFAULT);
INSERT INTO product VALUES(DEFAULT, '과학 분자모형, 화학실험 키트 판매', '설명하는거 보다 모형으로 보여주니까 학생들이 더 잘 이해했어요','D','teacher3',10000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, 3);
INSERT INTO product VALUES(DEFAULT, '코딩 책 모음', '여러 코딩책들 판매합니다.','D','teacher2',20000, '가산동',NULL, DEFAULT, DEFAULT, 'SALE',DEFAULT, 4);


-- 업로드 파일 관리
CREATE TABLE fileData(
    fileNo BIGINT PRIMARY KEY AUTO_INCREMENT,
    tableName VARCHAR(100),                     -- 테이블 이름
    columnNo INT,                               -- 테이블 PK 번호
    originName VARCHAR(255),                    -- 원래 이름
    saveName VARCHAR(255),                      -- 저장 이름
    savePath VARCHAR(255),                      -- 저장 파일
    fileType VARCHAR(100),                      -- 파일 종류
    status VARCHAR(50) DEFAULT 'ACTIVE'         -- REMOVE(삭제), ACTIVE(활동)
);

-- 채팅방
CREATE TABLE chatRoom (
    roomNo BIGINT PRIMARY KEY AUTO_INCREMENT,  -- 고유 번호
    memId VARCHAR(20) NOT NULL,            -- member.id
    pno INT NOT NULL,                       -- product.pno
    status VARCHAR(50) DEFAULT 'ON',        -- ON(진행), OFF(차단)
    UNIQUE (memId, pno)                    -- memId와 pno를 묶어서 UNIQUE 제약 설정
);

-- 채팅 메시지 ( receiver 추가됨)
CREATE TABLE chatMessage(
    chatNo BIGINT PRIMARY KEY AUTO_INCREMENT,   -- 채팅 번호
    type VARCHAR(20) NOT NULL,                  -- 채팅 타입: ENTER, TALK, LEAVE, NOTICE
    roomNo INT NOT NULL,                        -- 채팅방 번호
    sender VARCHAR(20) NOT NULL,                -- 송신자
    receiver VARCHAR(20) NOT NULL,              -- 수신자
    message VARCHAR(2000) NOT NULL,             -- 채팅 메시지
    status VARCHAR(50) DEFAULT 'UNREAD',        -- 읽음 여부
    time TIMESTAMP DEFAULT CURRENT_TIMESTAMP    -- 채팅 발송 시간
);

-- 사용자 알림 키워드 지정
CREATE TABLE keyword (
    kno BIGINT AUTO_INCREMENT PRIMARY KEY,      -- 고유번호
    word VARCHAR(200) NOT NULL,                 -- 키워드
    uid VARCHAR(20) NOT NULL                    -- member.id
);

-- 알림
CREATE TABLE notification (
    nno BIGINT AUTO_INCREMENT PRIMARY KEY,      -- 고유번호
    tableName VARCHAR(100),                     -- 테이블 이름
    columnNo BIGINT NOT NULL,                   -- 테이블의 PK 번호(keyword의 kno)
    word VARCHAR(200) NOT NULL,                 -- 어떤 키워드에 대한 알림인지
    message VARCHAR(2000),                      -- 알림 내용
    uid VARCHAR(20) NOT NULL,                   -- member.id
    status VARCHAR(50) DEFAULT 'UNREAD'         -- 읽음 여부
);

CREATE TABLE notice(
    no INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(500) NOT NULL,
    content VARCHAR(1000) NOT NULL,
    author VARCHAR(50),
    img VARCHAR(1000),
    resdate timestamp DEFAULT CURRENT_TIMESTAMP
)

INSERT INTO notice(title, content, author) VALUES ('신규 회원 가입 안내','저희 학부모 커뮤니티에 가입하신 것을 진심으로 환영합니다. 회원 가입을 통해 여러분의 소중한 의견과 경험을 공유해주세요. 커뮤니티가 더욱 풍요롭고 활기찬 공간이 되도록 함께 노력하겠습니다.','admin');
INSERT INTO notice(title, content, author) VALUES ('자주 묻는 질문 (FAQ) 업데이트 안내','티셀파에서 자주 묻는 질문들에 대한 업데이트가 이루어졌습니다. 더 나은 서비스를 위한 자주 묻는 질문을 확인하시어 필요한 정보를 얻어가시길 바랍니다.','admin');
INSERT INTO notice(title, content, author) VALUES ('사용자 경험 개선을 위한 소중한 의견 수렴 안내','티셀파는 회원 여러분들의 소중한 의견을 항상 기다리고 있습니다. 사용자들의 의견을 토대로 커뮤니티를 보다 나은 곳으로 만들기 위해 최선을 다하겠습니다. 의견이나 제안 사항은 언제든지 환영합니다.','admin');
INSERT INTO notice(title, content, author) VALUES ('중고거래 게시판 활동 방법 안내','티셀파에서 어떻게 참여하고 활동할 수 있는지에 대한 자세한 방법을 안내해 드립니다. 다양한 기능을 활용하여 보다 활발한 거래에에 참여해주시길 바랍니다.','admin');
INSERT INTO notice(title, content, author) VALUES ('교사용 중고 교육 도구 판매','불필요한 교육 도구를 판매하거나 필요한 자료를 저렴하게 구입하세요. 교육 과정을 지원해주세요.','admin');
INSERT INTO notice(title, content, author) VALUES ('중고 교육 자료 거래 커뮤니티','교육에 활용되는 다양한 자료를 거래하는 플랫폼입니다. 교사들끼리 자원을 공유해보세요!','admin');

CREATE TABLE recomment(
    NO INT PRIMARY KEY AUTO_INCREMENT,
    mem_id VARCHAR(100) NOT NULL,
    COMMENT VARCHAR(300) NOT null
);

-- 찜
CREATE TABLE wish (
    wno BIGINT AUTO_INCREMENT PRIMARY KEY,      -- 고유 번호
    pno BIGINT,                                 -- 상품 번호
    uid VARCHAR(20) NOT NULL,                   -- member.id
    status INT DEFAULT 0                        -- 찜 여부
);

-- 상품의 카테고리 이름을 같이 가져오기 위한 view
CREATE VIEW productWithCate AS (
    SELECT pno, pname, seller, price, proaddr, image, createAt, baseAt, status, visited, cateName, heart
    FROM product p
    JOIN category c ON (p.cate = c.cate)
);

SELECT * FROM member;
