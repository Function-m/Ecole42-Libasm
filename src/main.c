#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>

// ASM으로 작성한 함수들 선언
size_t  ft_strlen(const char *s);
char    *ft_strcpy(char *dst, const char *src);
int     ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);
char    *ft_strdup(const char *s);

int main(void) {
    char buffer[100];
    char *str = "Libasm is cool!";
    char dup_test[100];

    // ft_strlen
    printf("[ft_strlen]      = %zu\n", ft_strlen(str));
    printf("[strlen]         = %zu\n\n", strlen(str));

    // ft_strcpy
    ft_strcpy(dup_test, str);
    printf("[ft_strcpy]      = %s\n", dup_test);
    strcpy(buffer, str);
    printf("[strcpy]         = %s\n\n", buffer);

    // ft_strcmp
    printf("[ft_strcmp eq]   = %d\n", ft_strcmp("abc", "abc"));
    printf("[strcmp eq]      = %d\n", strcmp("abc", "abc"));
    printf("[ft_strcmp lt]   = %d\n", ft_strcmp("abc", "abd"));
    printf("[ft_strcmp gt]   = %d\n", ft_strcmp("abd", "abc"));
    printf("[strcmp check]   = %d\n\n", strcmp("abd", "abc"));

    // ft_write (정상)
    ssize_t w1 = ft_write(1, "[ft_write] test\n", 17);
    printf("ft_write returned: %zd, errno: %d\n", w1, errno);

    // ft_write (오류)
    ssize_t w2 = ft_write(-1, "Error!\n", 7);
    printf("ft_write (err)   = %zd, errno: %d\n\n", w2, errno);

    // ft_read (정상)
    printf("Type something for [ft_read]: ");
    ssize_t r = ft_read(0, buffer, 99); // STDIN
    if (r > 0) {
        buffer[r] = '\0';
        printf("You typed: %s", buffer);
    } else {
        perror("ft_read");
    }

    // ft_read (오류)
    ssize_t r2 = ft_read(-1, buffer, 10);
    printf("\nft_read (err)    = %zd, errno: %d\n\n", r2, errno);

    // ft_strdup
    char *dup = ft_strdup(str);
    if (dup) {
        printf("[ft_strdup]      = %s\n", dup);
        free(dup);
    } else {
        perror("ft_strdup");
    }

    return 0;
}
