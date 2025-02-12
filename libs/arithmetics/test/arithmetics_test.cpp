#include <gtest/gtest.h>

#include "include/arithmetics.hpp"

using namespace Arithmetics;

TEST(Arithmetics, add) {
    const auto expected_value = 10;
    EXPECT_EQ(add(4, 6), expected_value);
}

TEST(Arithmetics, subtract) {
    const auto expected_value = -2;
    EXPECT_EQ(subtract(4, 6), expected_value);
}

TEST(Arithmetics, multiply) {
    const auto expected_value = 24;
    EXPECT_EQ(multiply(4, 6), expected_value);
}
