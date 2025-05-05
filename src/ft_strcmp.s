; ft_strcmp.s
; 문자열 비교 함수: int ft_strcmp(const char *s1, const char *s2);
; 두 문자열을 사전순으로 비교하여 결과를 정수로 반환합니다.
;
; 반환값:
;   0  → 두 문자열이 같음
;   <0 → s1이 s2보다 작음
;   >0 → s1이 s2보다 큼

; 호출 규약:
;   첫 번째 인자: s1 → rdi
;   두 번째 인자: s2 → rsi
;   반환값: int → rax

global ft_strcmp
section .text

ft_strcmp:
.loop:
    mov     al, [rdi]        ; s1의 현재 문자 → al
    mov     bl, [rsi]        ; s2의 현재 문자 → bl
    cmp     al, bl           ; al - bl 비교
    jne     .done            ; 다르면 그 차이 반환
    test    al, al           ; al이 0이면 (널 문자) 끝
    je      .done            ; 같고 널이면 종료 (== 문자열 끝)
    inc     rdi              ; s1 다음 문자로
    inc     rsi              ; s2 다음 문자로
    jmp     .loop            ; 다음 문자 비교

.done:
    ; 문자 차이를 부호 있는 정수로 반환
    movzx   eax, al          ; al → eax (0-255 정수)
    movzx   ebx, bl          ; bl → ebx
    sub     eax, ebx         ; eax = (int)al - (int)bl
    ret
