# 📘 libasm 튜토리얼 - 입문자용 가이드

이 문서는 42서울의 `libasm` 프로젝트를 시작하기 전에 필요한 지식을 단계별로 배우도록 도와줍니다.

---

## 목차

1. [어셈블리 언어란?](#1-어셈블리-언어란)
2. [컴퓨터와 CPU 구조 기초](#2-컴퓨터와-cpu-구조-기초)
3. [x86-64 아키텍처 소개](#3-x86-64-아키텍처-소개)
4. [NASM 설치 및 사용법](#4-nasm-설치-및-사용법)
5. [Intel 어셈블리 문법](#5-intel-어셈블리-문법)
6. [시스템 호출 (Syscall)이란?](#6-시스템-호출-syscall이란)
7. [Calling Convention (호출 규약)](#7-calling-convention-호출-규약)
8. [자주 쓰는 레지스터 정리](#8-자주-쓰는-레지스터-정리)
9. [기초 명령어 정리](#9-기초-명령어-정리)
10. [프로젝트 요구사항 요약](#10-프로젝트-요구사항-요약)
11. [예제: ft_strlen.s 구현](#11-예제-ft_strlens-구현)
12. [디버깅 & 테스트 팁](#12-디버깅--테스트-팁)

---

## 1. 어셈블리 언어란?
어셈블리(Assembly) 언어는 CPU가 이해할 수 있는 기계어와 거의 1:1로 대응되는 저수준 언어입니다.
- C 같은 고급 언어보다 훨씬 더 하드웨어에 가깝습니다.
- 메모리, 레지스터 등을 직접 다뤄야 하므로 어렵지만 빠르고 정밀합니다.
- 이 프로젝트에서는 x86-64용 어셈블리를 작성하게 됩니다.

## 2. 컴퓨터와 CPU 구조 기초
CPU는 연산을 처리하고, 메모리(RAM)는 데이터를 저장합니다. 어셈블리에서는 대부분의 연산을 **레지스터**라는 CPU 내부 저장소를 통해 수행합니다.

## 3. x86-64 아키텍처 소개
- 64비트 레지스터를 사용 (`rax`, `rdi`, `rsi`, ...)
- 16개의 범용 레지스터 존재
- 각 레지스터는 64/32/16/8비트 단위로 접근 가능 (예: `rax`, `eax`, `ax`, `al`)

## 4. NASM 설치 및 사용법
### 설치 (Ubuntu 기준)
```bash
sudo apt update
sudo apt install nasm
```
### 컴파일 예시
```bash
nasm -f elf64 ft_strlen.s -o ft_strlen.o
gcc main.c ft_strlen.o -o test
```
⚠️ libasm에서는 `-no-pie` 옵션 사용 금지

## 5. Intel 어셈블리 문법
- **대상 ← 원본** 순서 (예: `mov rax, rdi` → `rdi` 값을 `rax`에 복사)
  
  `mov a, b`는 'b 값을 a에 저장해라'는 뜻입니다. 즉, **오른쪽의 값을 왼쪽에 덮어쓴다**는 의미예요.
  
  예시:
  ```asm
  mov rdi, 5     ; rdi = 5
  mov rax, 10    ; rax = 10
  mov rax, rdi   ; 이제 rax = 5 (기존 10은 사라짐)
  ```
  
  정리:
  - 왼쪽이 결과 저장 위치
  - 오른쪽은 가져올 값
  - 기존 왼쪽 값은 덮어씌워짐
- `%`, `$` 기호 사용 안 함
- AT&T 문법(반대 순서)은 사용하지 않음

## 6. 시스템 호출 (Syscall)이란?
운영체제에 작업을 요청하는 명령입니다.
- 예: `write`, `read`, `open` 등
- `syscall` 명령으로 실행하며, 인자와 번호는 레지스터로 전달

예시 (write syscall):
```asm
mov rax, 1      ; syscall 번호: write
mov rdi, 1      ; STDOUT
mov rsi, msg    ; 메시지 주소
mov rdx, 13     ; 메시지 길이
syscall
```

## 7. Calling Convention (호출 규약)
C 함수 인자는 다음과 같은 레지스터로 전달됩니다:
1. `rdi`
2. `rsi`
3. `rdx`
4. `rcx`
5. `r8`
6. `r9`

함수의 반환값은 `rax`에 저장됩니다.

## 8. 자주 쓰는 레지스터 정리

| 레지스터 | 설명 |
|----------|------|
| `rax` | 반환값 저장, 일반 계산 |
| `rdi` | 1번째 인자 |
| `rsi` | 2번째 인자 |
| `rdx` | 3번째 인자 |
| `rsp` | 스택 포인터 |
| `rbp` | 베이스 포인터 (함수 기준점) |

## 9. 기초 명령어 정리

| 명령어 | 설명 |
|--------|------|
| `mov` | 값 복사 |
| `cmp` | 두 값 비교 |
| `jmp` | 무조건 점프 |
| `je`  | 같으면 점프 |
| `jne` | 다르면 점프 |
| `inc` | 1 증가 |
| `dec` | 1 감소 |
| `ret` | 함수 반환 |
| `call`| 함수 호출 |

## 10. 프로젝트 요구사항 요약
- 구현 대상 함수: `ft_strlen`, `ft_strcpy`, `ft_strcmp`, `ft_write`, `ft_read`, `ft_strdup`
- 64비트 어셈블리 (`.s` 파일)로 작성
- `errno` 설정 필요 (`extern ___error` 등 사용 가능)
- `Makefile` 필수 (`all`, `clean`, `fclean`, `re`, `bonus` 포함)
- inline ASM 금지, NASM 사용

## 11. 예제: ft_strlen.s 구현

```asm
global ft_strlen
section .text

ft_strlen:
    xor rax, rax            ; 길이 저장용 rax 초기화 (0)
.loop:
    cmp byte [rdi + rax], 0 ; rdi[rax]가 null인지 확인
    je .done                ; null이면 종료
    inc rax                 ; 길이 +1
    jmp .loop               ; 다시 반복
.done:
    ret                     ; 결과 반환
```

## 12. 디버깅 & 테스트 팁

### gdb 사용
```bash
gdb ./a.out
layout asm   # 어셈블리 뷰 보기
start        # main부터 시작
stepi        # 명령어 한 줄씩 실행
```

### strace로 시스템 호출 추적
```bash
strace ./a.out
```
