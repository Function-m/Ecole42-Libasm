# === 설정 ===
NAME        := libasm.a
SRC_DIR     := src
ASM_SRCS    := $(wildcard $(SRC_DIR)/ft_*.s)
ASM_OBJS    := $(ASM_SRCS:.s=.o)

MAIN_SRC    := $(SRC_DIR)/main.c
EXEC        := main

# 컴파일러 및 옵션
NASM        := nasm
NASMFLAGS   := -f elf64
CC          := gcc
CFLAGS      := -Wall -Wextra -Werror

# === 기본 규칙 ===
all: $(NAME)

# 정적 라이브러리 생성
$(NAME): $(ASM_OBJS)
	ar rcs $@ $^

# ASM → OBJ 변환
%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

# 실행 파일 (테스트용)
$(EXEC): $(NAME) $(MAIN_SRC)
	$(CC) $(CFLAGS) $(MAIN_SRC) -L. -lasm -o $@

# === 정리 ===
clean:
	rm -f $(ASM_OBJS)

fclean: clean
	rm -f $(NAME) $(EXEC)

re: fclean all

# === 보너스 (추후 확장용 자리) ===
bonus: all

.PHONY: all clean fclean re bonus
