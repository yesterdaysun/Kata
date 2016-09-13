package com.kata;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Eric on 16/9/13.
 */
public class BookStore {
    private static List<BigDecimal> discounts = Arrays.asList(
            BigDecimal.ZERO,
            BigDecimal.ONE,
            BigDecimal.valueOf(1 - 0.05)
    );

    public BigDecimal getPrice(BookPurchase bookPurchase) {
        return BigDecimal.valueOf(8)
                .multiply(BigDecimal.valueOf(bookPurchase.count()))
                .multiply(discounts.get(bookPurchase.count()));
    }
}
