
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        printf("Error: enter a, b, c\n");
        return 1;
    }

    long long a = atoll(argv[1]);
    long long b = atoll(argv[2]);
    long long c = atoll(argv[3]);

    if (a == 0) {
        printf("Error: division by zero\n");
        return 1;
    }

    long long result = b * a;
    result = result / a;
    result = result * b;
    result = result * c;

    printf("%lld\n", result);

    return 0;
}
