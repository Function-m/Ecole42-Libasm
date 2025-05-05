; ft_strlen 함수: 문자열의 길이를 계산합니다.
; 입력: RDI 레지스터에 문자열의 주소 (const char *str)
; 출력: RAX 레지스터에 문자열 길이 (size_t)

global ft_strlen         ; 외부에서 이 함수를 사용할 수 있도록 선언

section .text            ; 코드 섹션 시작

ft_strlen:
    xor     rax, rax     ; RAX = 0으로 초기화 (문자열 길이 카운터로 사용)
                         ; RAX는 곧 리턴값이 됨

.loop:
    cmp     byte [rdi + rax], 0  ; 문자열의 현재 문자가 null인지 확인
                                 ; [rdi + rax]는 str[rax]와 같음
    je      .done        ; 만약 null 문자('\0')라면 루프 종료
    inc     rax          ; null이 아니면 길이 1 증가
    jmp     .loop        ; 다음 문자 확인을 위해 루프 반복

.done:
    ret                  ; 결과값(RAX)을 리턴

; GNU-stack 섹션: 실행 가능한 스택을 방지하기 위한 보안용 섹션
; 실행 권한이 없는 스택임을 링커에 명시하여 경고를 제거함
section .note.GNU-stack noalloc noexec nowrite progbits