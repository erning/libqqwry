#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include "qqwry.h"

static uint32_t ip_atoi(const char *ip_str) {
    const char *p = ip_str;
    uint32_t parts[4], i;
    
    for (i=0; i<4; i++) {
        parts[i] = atoi(p);
        while (*p != '.' && *p) p++;
        
        /* skip dot */
        if (*p == '.') p++;
    }
    
    return parts[3] | parts[2] << 8 | parts[1] << 16 | parts[0] << 24;
}

int main(int argc, char** argv) {
    
    if (argc < 2) {
        printf("Usage: %s ip_addr [qqwry.dat file]\n", argv[0]);
        return 1;
    }
    
    char *path = argc < 3 ? "qqwry.dat" : argv[2];

    uint32_t ip = ip_atoi(argv[1]);
    
    qqwry_data_t data;    
    if (qqwry_init(path, &data) != 0) {
        perror(path);
        return 1;
    }

    qqwry_result_t result;
    qqwry_query(data, ip, &result);
    qqwry_clean(data);

    printf("%s | %s\n", result.country, result.area);
    return 0;
}
