package com.kata;

import java.math.BigDecimal;

/**
 * Created by Eric on 16/9/13.
 */
public class BookStore {
    public BigDecimal getPrice(BookPurchase bookPurchase) {
        return BigDecimal.valueOf(8).multiply(BigDecimal.valueOf(bookPurchase.count()));
    }
}
