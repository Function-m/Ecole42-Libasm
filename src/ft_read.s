; ft_read: read syscall을 호출하여 입력을 받습니다.
; 입력:
;   RDI = fd
;   RSI = buf
;   RDX = count
; 출력:
;   RAX = 읽은 바이트 수, 또는 -1 (에러 시)

global ft_read
extern __errno_location     ; errno 위치를 반환하는 함수

section .text

ft_read:
    mov     rax, 0           ; syscall 번호: 0 (read)
    syscall                  ; 시스템 콜 호출

    cmp     rax, 0
    jl      .error           ; RAX < 0 → 에러 처리

    ret                      ; 정상적으로 읽었으면 RAX 리턴

.error:
    mov     rdi, rax         ; 에러 코드 백업
    neg     rdi              ; 양수로 변환
    ;call    __errno_location ; errno 위치 얻기
    call    [rel __errno_location wrt ..got]
    mov     [rax], edi       ; errno에 에러코드 저장 (32비트)

    mov     rax, -1          ; 함수 리턴값은 -1
    ret

; GNU-stack 섹션: 실행 가능한 스택을 방지하기 위한 보안용 섹션
; 실행 권한이 없는 스택임을 링커에 명시하여 경고를 제거함
section .note.GNU-stack noalloc noexec nowrite progbits