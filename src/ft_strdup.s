; ft_strdup: 문자열을 동적 복사합니다.
; 입력:
;   RDI = const char *s
; 출력:
;   RAX = 복사된 문자열의 포인터 (char *)

global ft_strdup
extern ft_strlen
extern malloc

section .text

ft_strdup:
    push    rdi                 ; s 저장 (ft_strlen이 RDI를 덮어씀)

    call    ft_strlen           ; 문자열 길이 계산
    inc     rax                 ; NULL 문자 포함을 위해 +1

    mov     rdi, rax            ; malloc 인자: size = strlen + 1
    ;call    malloc              ; malloc(size)
    call    [rel malloc wrt ..got]   ; malloc 간접 호출 (PIE-safe)

    test    rax, rax
    je      .return_null        ; malloc 실패 시 NULL 리턴

    pop     rsi                 ; 저장해뒀던 원본 문자열 주소 (s)
    mov     rdi, rax            ; 목적지 버퍼 주소

.copy_loop:
    mov     dl, byte [rsi]      ; src 문자 → DL
    mov     byte [rdi], dl      ; dest에 문자 저장
    inc     rsi
    inc     rdi
    test    dl, dl
    jnz     .copy_loop          ; NULL이 아니라면 계속 복사

    sub     rdi, rax            ; RDI를 원래 시작 주소로 되돌릴 필요는 없음
    ret

.return_null:
    pop     rsi                 ; 스택 정리 (에러 시)
    ret

; GNU-stack 섹션: 실행 가능한 스택을 방지하기 위한 보안용 섹션
; 실행 권한이 없는 스택임을 링커에 명시하여 경고를 제거함
section .note.GNU-stack noalloc noexec nowrite progbits