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

// 출력 구분자
void print_separator(const char *title) {
    printf("\n===== %s =====\n", title);
}

int main(void) {
    char buffer[100];
    char *str = "Libasm is cool!";
    char dup_test[100];

    // === ft_strlen ===
    print_separator("ft_strlen vs strlen");
    printf("ft_strlen(\"%s\") = %zu\n", str, ft_strlen(str));
    printf("   strlen(\"%s\") = %zu\n", str, strlen(str));

    // === ft_strcpy ===
    print_separator("ft_strcpy vs strcpy");
    ft_strcpy(dup_test, str);
    printf("ft_strcpy result = \"%s\"\n", dup_test);
    strcpy(buffer, str);
    printf("   strcpy result = \"%s\"\n", buffer);

    // === ft_strcmp ===
    print_separator("ft_strcmp vs strcmp");
    const char *a = "abc", *b = "abc", *c = "abd";
    printf("ft_strcmp(\"%s\", \"%s\") = %d\n", a, b, ft_strcmp(a, b));
    printf("   strcmp(\"%s\", \"%s\") = %d\n", a, b, strcmp(a, b));
    printf("ft_strcmp(\"%s\", \"%s\") = %d\n", a, c, ft_strcmp(a, c));
    printf("   strcmp(\"%s\", \"%s\") = %d\n", a, c, strcmp(a, c));
    printf("ft_strcmp(\"%s\", \"%s\") = %d\n", c, a, ft_strcmp(c, a));
    printf("   strcmp(\"%s\", \"%s\") = %d\n", c, a, strcmp(c, a));

    // === ft_write ===
    print_separator("ft_write vs write");
    const char *msg = "[ft_write] test (stdout)\n";
    errno = 0;
    ssize_t w1 = ft_write(1, msg, strlen(msg));
    printf("ft_write returned: %zd, errno: %d (%s)\n", w1, errno, strerror(errno));

    errno = 0;
    ssize_t w2 = ft_write(-1, "Error!\n", 7);
    printf("ft_write(-1) ret: %zd, errno: %d (%s)\n", w2, errno, strerror(errno));

    // === ft_read ===
    print_separator("ft_read vs read (stdin)");
    printf("Type something and press ENTER: ");
    fflush(stdout);
    errno = 0;
    ssize_t r = ft_read(0, buffer, 99);
    if (r >= 0) {
        buffer[r] = '\0';
        printf("ft_read returned: %zd, input: \"%s\"\n", r, buffer);
    } else {
        perror("ft_read");
    }

    errno = 0;
    ssize_t r2 = ft_read(-1, buffer, 10);
    printf("ft_read(-1) ret: %zd, errno: %d (%s)\n", r2, errno, strerror(errno));

    // === ft_strdup ===
    print_separator("ft_strdup vs strdup");
    char *dup = ft_strdup(str);
    char *libc_dup = strdup(str);
    if (dup && libc_dup) {
        printf("ft_strdup result  = \"%s\"\n", dup);
        printf("   strdup result  = \"%s\"\n", libc_dup);
    } else {
        perror("ft_strdup or strdup failed");
    }
    free(dup);
    free(libc_dup);

    printf("\n✅ All tests complete.\n");
    return 0;
}
