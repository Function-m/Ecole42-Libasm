; ft_strlen.s
; size_t ft_strlen(const char *str);
; 문자열의 길이를 계산하는 함수
; 반환값: 문자열의 길이 (널 문자 전까지의 바이트 수)
; 규약: 첫 번째 인자 str은 rdi 레지스터에 저장되어 전달됨
; 반환값은 rax 레지스터에 저장되어 반환됨

global ft_strlen            ; 외부에서 사용할 수 있도록 전역 심볼 선언
section .text               ; 코드 영역 시작

ft_strlen:
    xor     rax, rax        ; rax = 0, 문자열 길이 카운터 초기화

.loop:
    cmp     byte [rdi + rax], 0    ; 현재 문자(str[rax])가 널문자인지 확인
    je      .done                   ; 널문자면 루프 종료
    inc     rax                    ; 아니면 길이 증가
    jmp     .loop                  ; 다시 루프 반복

.done:
    ret                         ; rax에 담긴 길이 값 반환
