; ft_strcpy.s
; 문자열 복사 함수: char *ft_strcpy(char *dst, const char *src);
; dst에 src 문자열을 복사하고, dst를 반환합니다.

; 호출 규약 (System V x86-64):
; 첫 번째 인자: dst → rdi
; 두 번째 인자: src → rsi
; 반환값: dst → rax

global ft_strcpy
section .text

ft_strcpy:
    push    rdi             ; 원래 dst 주소를 보존하기 위해 스택에 저장

.copy_loop:
    mov     al, [rsi]       ; src에서 한 글자 읽기 (al = *src)
    mov     [rdi], al       ; 그 글자를 dst에 저장 (*dst = al)
    inc     rsi             ; src 포인터 증가
    inc     rdi             ; dst 포인터 증가
    test    al, al          ; 복사한 문자가 널문자('\0')인지 확인
    jne     .copy_loop      ; 널이 아니면 루프 계속

    pop     rax             ; rax = 원래 dst 주소 (반환값)
    ret
