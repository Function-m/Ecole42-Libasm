; ft_strcpy 함수: src 문자열을 dest에 복사합니다.
; 입력:
;   RDI: char *dest
;   RSI: const char *src
; 출력:
;   RAX: char *dest (복사된 문자열의 시작 주소 반환)

global ft_strcpy

section .text

ft_strcpy:
    mov     rax, rdi        ; RAX에 dest 저장 (리턴값으로 사용할 주소)
    
.copy_loop:
    mov     dl, byte [rsi]  ; DL에 src의 현재 문자 복사
    mov     byte [rdi], dl  ; dest에 DL 값 저장
    inc     rsi             ; src 포인터 증가
    inc     rdi             ; dest 포인터 증가
    test    dl, dl          ; 현재 문자가 NULL인지 확인
    jnz     .copy_loop      ; NULL이 아니면 계속 복사

    ret                     ; 복사 완료 후 RAX (dest) 리턴

; GNU-stack 섹션: 실행 가능한 스택을 방지하기 위한 보안용 섹션
; 실행 권한이 없는 스택임을 링커에 명시하여 경고를 제거함
section .note.GNU-stack noalloc noexec nowrite progbits