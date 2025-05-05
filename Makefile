# 파일 및 디렉토리 설정
NAME        := libasm.a
SRC_DIR     := src
ASM_SRCS    := $(wildcard $(SRC_DIR)/ft_*.s)
ASM_OBJS    := $(ASM_SRCS:.s=.o)

MAIN_SRC    := $(SRC_DIR)/main.c
MAIN_OBJ    := $(MAIN_SRC:.c=.o)
EXEC        := main

# 컴파일러 및 옵션
NASM        := nasm
NASMFLAGS   := -f elf64
CC          := gcc
CFLAGS      := -Wall -Wextra -Werror

# 기본 빌드 규칙
all: $(NAME)

$(NAME): $(ASM_OBJS)
	ar rcs $@ $^

%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

# main 실행 파일 빌드
$(EXEC): $(NAME) $(MAIN_SRC)
	$(CC) $(CFLAGS) $(MAIN_SRC) $(NAME) -o $(EXEC)

# 정리 명령
clean:
	rm -f $(ASM_OBJS) $(MAIN_OBJ)

fclean: clean
	rm -f $(NAME) $(EXEC)

re: fclean all

# bonus 대상 분리 가능 (보너스 구현 시 여기에 추가)
bonus: all

.PHONY: all clean fclean re bonus
