; ft_write: write syscall을 직접 호출
; 입력:
;   RDI = fd
;   RSI = buf
;   RDX = count
; 출력:
;   RAX = 쓰여진 바이트 수 또는 -1

global ft_write
extern __errno_location     ; errno 주소 반환 함수 (glibc)

section .text

ft_write:
    mov     rax, 1           ; syscall 번호 1번 (write)
    syscall                  ; 시스템 콜 수행

    cmp     rax, 0
    jl      .error           ; RAX < 0 이면 에러 처리

    ret                      ; 성공 시 RAX 그대로 리턴

.error:
    ; errno 설정: *__errno_location() = -RAX
    mov     rdi, rax         ; 에러코드 백업
    neg     rdi              ; 양수로 변경
    ;call    __errno_location ; errno 위치 얻기
    call    [rel __errno_location wrt ..got]
    mov     [rax], edi       ; errno에 값 저장 (32비트)

    mov     rax, -1          ; 함수 리턴값은 -1
    ret

; GNU-stack 섹션: 실행 가능한 스택을 방지하기 위한 보안용 섹션
; 실행 권한이 없는 스택임을 링커에 명시하여 경고를 제거함
section .note.GNU-stack noalloc noexec nowrite progbits