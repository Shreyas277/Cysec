#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

static int val0 = 0, val1 = 0, val2 = 0, val3 = 0, val4 = 0;

// Helper to parse the string and fill 5 values
int parseExpr(const char* str) {
    int nums[3];
    int ops[2];
    int n = 0, o = 0;
    const char* p = str;
    while (*p) {
        if (isdigit(*p)) {
            int num = 0;
            while (isdigit(*p)) {
                num = num * 10 + (*p - '0');
                p++;
            }
            if (n < 3) nums[n++] = num;
        } else if (*p == '+' || *p == '-') {
            ops[o++] = (*p == '+') ? 0 : 1;
            p++;
        } else {
            p++; // skip anything else
        }
    }

    if (n == 3 && o == 2) {
        val0 = nums[0];
        val1 = ops[0];
        val2 = nums[1];
        val3 = ops[1];
        val4 = nums[2];
        return 1; // success
    }
    return 0; // failure
}

// BDPI-accessible getters
int getVal0() { return val0; }
int getVal1() { return val1; }
int getVal2() { return val2; }
int getVal3() { return val3; }
int getVal4() { return val4; }

