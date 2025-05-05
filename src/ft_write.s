; ft_write.s
; ssize_t ft_write(int fd, const void *buf, size_t count);
; 파일 디스크립터 fd에 count 바이트만큼 buf의 내용을 출력합니다.
; 성공 시 쓴 바이트 수를, 실패 시 -1을 반환하고 errno를 설정합니다.

; 호출 규약 (System V x86-64):
;   1. fd   → rdi
;   2. buf  → rsi
;   3. count → rdx
;   반환값: ssize_t → rax

extern __errno_location      ; errno 설정을 위한 외부 함수
global ft_write
section .text

ft_write:
    mov     rax, 1           ; syscall 번호 1: write
    syscall                  ; 호출 → 결과는 rax에 저장됨

    cmp     rax, 0           ; rax < 0 → 에러 발생
    jl      .handle_error    ; 오류 처리 루틴으로 이동

    ret                      ; 성공 시 바로 반환

.handle_error:
    ; 오류 발생 시 errno 설정
    neg     rax              ; 오류 코드는 음수로 반환되므로 양수로 만듦
    mov     rbx, rax         ; 오류 코드를 rbx에 저장 (보존)

    call    __errno_location ; errno의 주소를 반환받음
    mov     [rax], ebx       ; errno에 오류 코드 저장 (하위 32비트만 저장)

    mov     rax, -1          ; 함수는 -1을 반환해야 함
    ret
