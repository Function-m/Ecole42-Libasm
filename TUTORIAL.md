# 📘 libasm 튜토리얼 - 입문자용 가이드

이 문서는 Ecole 42의 `libasm` 프로젝트를 처음 시작할 때 필요한 기초 지식과 실습을 단계별로 제공합니다.

---

## 📑 목차

1. [어셈블리 언어란?](#1-어셈블리-언어란)
2. [컴퓨터 구조와 스택](#2-컴퓨터-구조와-스택)
3. [x86-64 아키텍처 개요](#3-x86-64-아키텍처-개요)
4. [NASM 설치 및 빌드](#4-nasm-설치-및-빌드)
5. [Intel 어셈블리 문법 기초](#5-intel-어셈블리-문법-기초)
6. [시스템 호출이란? (Syscall)](#6-시스템-호출이란-syscall)
7. [Calling Convention 정리](#7-calling-convention-정리)
8. [자주 쓰는 레지스터 정리](#8-자주-쓰는-레지스터-정리)
9. [기초 명령어 정리](#9-기초-명령어-정리)
10. [레이블(Label) 문법](#10-레이블label-문법)
11. [메모리 참조([]) 문법](#11-메모리-참조-문법)
12. [PIE란 무엇이고 왜 주의해야 하나?](#12-pie란-무엇이고-왜-주의해야-하나)
13. [GNU-stack 섹션의 역할](#13-gnu-stack-섹션의-역할)
14. [ft_strlen.s 예제](#14-ft_strlens-예제)
15. [디버깅 및 테스트 팁](#15-디버깅-및-테스트-팁)

---

## 1. 어셈블리 언어란?
어셈블리(Assembly)는 CPU가 이해하는 기계어와 1:1로 거의 매칭되는 저수준 언어입니다.
- 고급 언어(C 등)보다 직접적이고 빠르며, 하드웨어 제어에 적합
- `libasm`에서는 `x86-64`(AMD64) 기반의 **NASM (Intel 문법)** 을 사용합니다

---

## 2. 컴퓨터 구조와 스택
- 스택은 함수 호출 시 생성되는 임시 메모리 공간입니다 (LIFO).
- 지역 변수, 함수 인자, 리턴 주소 등을 저장하며 **코드가 위치하는 곳은 아님**.
- 어셈블리 함수는 `.text` 섹션에 저장되고, 스택은 데이터용입니다.

---

## 3. x86-64 아키텍처 개요
- 64비트 레지스터 사용 (`rax`, `rdi`, `rsi` 등)
- 레지스터는 하위 크기로 나눌 수 있음: `rax` → `eax` → `ax` → `al`

---

## 4. NASM 설치 및 빌드

```bash
sudo apt update
sudo apt install nasm
```

```bash
nasm -f elf64 ft_strlen.s -o ft_strlen.o
gcc -Wall -Wextra -Werror main.c ft_strlen.o -o test
```

> ⚠️ `-no-pie` 금지 (PIE 환경을 유지해야 함)

---

## 5. Intel 어셈블리 문법 기초

```asm
mov rax, rdi   ; rdi 값을 rax에 복사
```

- 순서: 왼쪽 ← 오른쪽
- `%`, `$` 등 AT&T 스타일 금지
- `mov a, b`는 "b 값을 a에 복사"

---

## 6. 시스템 호출이란? (Syscall)

```asm
mov rax, 1      ; syscall 번호 (write)
mov rdi, 1      ; fd = 1 (stdout)
mov rsi, msg    ; 메시지 주소
mov rdx, 13     ; 메시지 길이
syscall
```

> 시스템 콜 번호는: https://filippo.io/linux-syscall-table/

---

## 7. Calling Convention 정리

| 순서 | 레지스터 |
|------|----------|
| 1    | rdi |
| 2    | rsi |
| 3    | rdx |
| 4    | rcx |
| 5    | r8  |
| 6    | r9  |

- 반환값은 `rax`

---

## 8. 자주 쓰는 레지스터 정리

| 레지스터 | 용도 |
|----------|------|
| `rax`    | 반환값, 계산 |
| `rdi`    | 1번째 인자 |
| `rsi`    | 2번째 인자 |
| `rdx`    | 3번째 인자 |
| `rsp`    | 스택 포인터 |
| `rbp`    | 프레임 기준 포인터 |

---

## 9. 기초 명령어 정리

| 명령어 | 설명 |
|--------|------|
| `mov`  | 값 복사 |
| `cmp`  | 비교 |
| `jmp`  | 무조건 점프 |
| `je`   | 같으면 점프 |
| `jne`  | 다르면 점프 |
| `inc`  | +1 증가 |
| `dec`  | -1 감소 |
| `call` | 함수 호출 |
| `ret`  | 함수 종료 |

---

## 10. 레이블(Label) 문법

```asm
global ft_strlen
ft_strlen:
.loop:
    ...
    jmp .loop
.done:
    ret
```

- `ft_strlen:` → 함수의 전역 시작 위치 (C에서 호출 가능)
- `.loop:`, `.done:` → 점프 대상인 내부 흐름 제어용 레이블

---

## 11. 메모리 참조 문법 (`[]`)

`[]`는 메모리 주소 접근 (간접 참조)

| 문법            | 의미                            |
|-----------------|---------------------------------|
| `mov rax, rdi`  | rdi 값을 rax에 복사             |
| `mov [rax], edi`| edi 값을 rax가 가리키는 주소에 저장 |
| `mov rdi, [rax]`| rax가 가리키는 주소에서 값 읽기 |

C 코드와 비교:

```c
int *ptr = &x;
*ptr = 42;  // == mov [rax], edi
```

---

## 12. PIE란 무엇이고 왜 주의해야 하나?

PIE = Position Independent Executable

- 실행 시 주소가 매번 랜덤 (보안: ASLR)
- 절대 주소 참조 금지:

```nasm
call malloc              ; ❌ 금지
call [rel malloc wrt ..got]  ; ✅ 허용
```

---

## 13. GNU-stack 섹션의 역할

```asm
section .note.GNU-stack noalloc noexec nowrite progbits
```

- 링커에게 "스택에 실행 권한 주지 마라"고 명시
- 없으면 경고 발생 → 반드시 `.s` 파일 끝에 넣을 것

---

## 14. ft_strlen.s 예제

```asm
global ft_strlen
section .text

ft_strlen:
    xor rax, rax
.loop:
    cmp byte [rdi + rax], 0
    je .done
    inc rax
    jmp .loop
.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
```

---

## 15. 디버깅 및 테스트 팁

### GDB

```bash
gdb ./main
layout asm
start
stepi
info registers
```

### strace

```bash
strace ./main
```

---

이 문서는 42의 libasm 프로젝트를 처음 접하는 사람을 위한 정리 자료입니다.  
실습을 통해 익히고, syscall, errno, GOT/PLT까지 확장해보세요!