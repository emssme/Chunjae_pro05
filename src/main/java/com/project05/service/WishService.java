package com.project05.service;

import com.project05.entity.Wish;
import com.project05.entity.WishProduct;
import com.project05.util.Page;

import java.util.List;

public interface WishService {
    List<Wish> wishList(String uid);

    Wish wishGet(Long wno);

    List<WishProduct> wishProductList(String uid, Page page);

    int wishProductCount(String uid, Page page);

    int wishFind(Long pno, String uid);

    int wishCount(Long pno);

    int wishInsert(Wish wish);

    int wishDelete(Wish wish);

    void increaseWish(Long pno);

    void decreaseWish(Long pno);

    void wishRemove(Long wno);

    int checkWish(Wish wish);
}
