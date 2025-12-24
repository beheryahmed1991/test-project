#!/bin/bash


# this a usage help and gracful exit for not correct argument
if [ "$#" -ne 2 ]; then
  cat <<EOF
Использование: $0 <каталог_логов> <количество_дней>

Аргументы:
  LOG     Путь к директории с файлами .log
  N       Число дней (N)

Пример:
  $0 logs 7
EOF
  exit 1
fi


LOG="$1" #1st argument
N="$2" #2nd argument

# check for the existence of dir
if [ ! -d "$LOG" ]; then
  echo "ОШИБКА: каталог '$LOG' не существует"
  exit 1
fi

# search for all log files with extension *.log
FILES=$(find "$LOG" -type f -name "*.log" -mtime +"$N")

# check if there are no log files
if [ -z "$FILES" ]; then
  echo "Файлы .log старше $N дней не найдены"
  exit 0
fi

# there are files
echo "Найдены следующие файлы:"
echo "$FILES"
echo

# ask to delete the files
read -p "Удалить эти файлы? (y/n): " CONFIRM

# delete files or not
if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
  echo "$FILES" | xargs rm -f
  echo "Файлы успешно удалены"
else
  echo "Удаление отменено"
fi
