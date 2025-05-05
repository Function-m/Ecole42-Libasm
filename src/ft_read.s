; ft_read.s
; ssize_t ft_read(int fd, void *buf, size_t count);
; fd로부터 최대 count 바이트를 buf에 읽어들입니다.
; 성공 시 읽은 바이트 수, 실패 시 -1 반환 및 errno 설정

; 호출 규약 (System V x86-64):
;   rdi → int fd
;   rsi → void *buf
;   rdx → size_t count
;   반환값: ssize_t → rax

extern __errno_location      ; errno 설정 함수
global ft_read
section .text

ft_read:
    mov     rax, 0           ; syscall 번호 0: read
    syscall                  ; 시스템 콜 실행

    cmp     rax, 0           ; rax < 0 이면 오류
    jl      .handle_error    ; 오류 처리 루틴으로 이동

    ret                      ; 성공 시 rax를 그대로 반환

.handle_error:
    neg     rax              ; 오류 코드 양수로 변환 (ex: -5 → 5)
    mov     rbx, rax         ; 오류 코드 rbx에 저장

    call    __errno_location ; errno 변수 주소를 rax에 반환
    mov     [rax], ebx       ; 오류 코드를 errno에 저장

    mov     rax, -1          ; 함수는 -1 반환
    ret
