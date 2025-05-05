; ft_strcmp: 두 문자열을 비교합니다.
; 입력:
;   RDI = const char *s1
;   RSI = const char *s2
; 출력:
;   RAX = 정수값 (s1[i] - s2[i])

global ft_strcmp

section .text

ft_strcmp:
.loop:
    movzx   eax, byte [rdi]    ; s1의 현재 문자 -> EAX (zero-extend)
    movzx   ecx, byte [rsi]    ; s2의 현재 문자 -> ECX (zero-extend)

    cmp     eax, ecx           ; s1[i]와 s2[i] 비교
    jne     .diff              ; 다르면 차이 반환

    test    al, al             ; s1[i] == '\0' 인가?
    je      .equal             ; 같으면 문자열 끝이므로 0 반환

    inc     rdi                ; 다음 문자로 이동
    inc     rsi
    jmp     .loop

.diff:
    sub     eax, ecx           ; s1[i] - s2[i]
    ret

.equal:
    xor     eax, eax           ; 두 문자열 동일 → 0 반환
    ret

; GNU-stack 섹션: 실행 가능한 스택을 방지하기 위한 보안용 섹션
; 실행 권한이 없는 스택임을 링커에 명시하여 경고를 제거함
section .note.GNU-stack noalloc noexec nowrite progbits