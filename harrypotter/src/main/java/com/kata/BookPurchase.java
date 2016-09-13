package com.kata;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Eric on 16/9/13.
 */
public class BookPurchase {
    private List<Integer> books = new ArrayList<Integer>();

    public static BookPurchase of(Integer... books) {
        BookPurchase bookPurchase = new BookPurchase();
        bookPurchase.books = Arrays.asList(books);
        return bookPurchase;
    }

    public int count() {
        return books.size();
    }
}
