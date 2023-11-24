package com.project05.service;


import com.project05.entity.Notice;
import com.project05.util.Page;

import java.util.List;

public interface NoticeSerivce {
    public List<Notice> boardList();
    public Notice boardGet(int no);
    public void boardAdd(Notice notice);
    public void boardEdit(Notice notice);
    public void boardDel(int no);
    public List<Notice> boardPage(Page page);
    public int noticeCount(Page page);
}
