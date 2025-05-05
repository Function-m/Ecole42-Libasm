; ft_strdup.s
; char *ft_strdup(const char *s);
; s 문자열을 동적으로 복사하여 반환합니다.
; 실패 시 NULL을 반환하고 errno를 설정합니다.

; 호출 규약 (System V x86-64):
;   rdi → const char *s
;   반환값 → rax (새로 할당된 문자열 포인터)

extern malloc               ; 메모리 할당
extern __errno_location     ; errno 설정
extern ft_strlen            ; 문자열 길이 계산
extern ft_strcpy            ; 문자열 복사
global ft_strdup
section .text

ft_strdup:
    ; rdi = s (원본 문자열)

    ; 문자열 길이 구하기
    push    rdi             ; s 보존
    call    ft_strlen       ; rax = strlen(s)
    mov     rbx, rax        ; 길이를 rbx에 저장
    inc     rbx             ; 널 문자('\0') 포함해서 +1

    ; 메모리 할당
    mov     rdi, rbx        ; malloc(size) → size = rbx
    call    malloc          ; rax = 할당된 메모리 주소 or NULL

    test    rax, rax        ; rax == NULL이면 오류
    je      .malloc_failed

    ; 문자열 복사
    ; rdi = dest, rsi = src
    pop     rsi             ; rsi = s
    mov     rdi, rax        ; rdi = malloc으로 받은 dest
    call    ft_strcpy       ; rax = dest 반환

    ret

.malloc_failed:
    ; 오류 발생 → errno 설정
    call    __errno_location
    mov     dword [rax], 12     ; 12 = ENOMEM (Out of memory)
    xor     rax, rax            ; NULL 반환
    ret
