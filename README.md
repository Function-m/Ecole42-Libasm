# Ecole42-Libasm

리눅스 x86_64 환경에서 어셈블리(NASM)를 이용해 C 표준 함수들을 직접 구현하는 프로젝트입니다.  

---

## 목차

1. [사전 지식 가이드](#-사전-지식-가이드)
2. [프로젝트 개요](#-프로젝트-개요)
3. [구현 목록](#-구현-목록)
4. [컴파일 및 실행 방법](#-컴파일-및-실행-방법)
5. [테스트 방법](#-테스트-방법)
6. [참고 자료](#-참고-자료)

---

## 사전 지식 가이드
- [TUTORIAL.md](TUTORIAL.md)

---

## 프로젝트 개요

C의 기본 함수들을 어셈블리어로 직접 구현:

- 어셈블리로 구현된 함수들을 `libasm.a`로 묶음
- C의 `main.c`에서 해당 함수들을 테스트
- `Makefile`로 컴파일 자동화

---

## 구현 목록

### 필수 함수

| 함수명      | 설명                   |
|-------------|------------------------|
| ft_strlen   | 문자열 길이 계산       |
| ft_strcpy   | 문자열 복사           |
| ft_strcmp   | 문자열 비교           |
| ft_write    | 시스템 콜로 출력       |
| ft_read     | 시스템 콜로 입력       |
| ft_strdup   | 문자열 복제 (malloc)  |

### 보너스 함수

| 함수명               | 설명                     |
|----------------------|--------------------------|
| ft_atoi_base         | 진수 문자열을 정수로 변환 |
| ft_list_push_front   | 리스트 앞에 노드 추가     |
| ft_list_size         | 리스트 길이 반환          |
| ft_list_sort         | 리스트 정렬               |
| ft_list_remove_if    | 조건에 맞는 노드 제거     |

---

## 컴파일 및 실행 방법

```bash
make        # libasm.a 생성
make main   # main 실행파일 생성
./main      # 실행
```

---

## 테스트 방법

`main.c`는 각 함수의 동작을 검증하는 테스트 스크립트를 포함합니다.

예:
```bash
./main
```

출력값과 `errno`를 통해 정상 동작 여부 확인 가능.

---

## 참고 자료

- [x86_64 System V ABI](https://refspecs.linuxfoundation.org/elf/x86_64-abi-0.99.pdf)
- [NASM 공식 문서](https://www.nasm.us/doc/)
- [Linux syscall table](https://filippo.io/linux-syscall-table/)
- [errno 목록](https://man7.org/linux/man-pages/man3/errno.3.html)
- [프로젝트 명세](subject.pdf)
- BSD Library Functions Manual
