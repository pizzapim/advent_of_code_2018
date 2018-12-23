#include <stdio.h>
#include <stdlib.h>

int
main(int argc, char *argv[])
{
  FILE *stream;
  char *line = NULL;
  size_t len = 0;
  int nread;

  if (argc != 2) {
    fprintf(stderr, "Usage: %s <file>\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  stream = fopen(argv[1], "r");
  if (stream == NULL) {
    perror("fopen");
    exit(EXIT_FAILURE);
  }

  int number;
  int total = 0;

  while ((nread = getline(&line, &len, stream)) != -1) {
    number = atoi(line);
    total += number;
  }

  printf("%d\n", total);

  free(line);
  fclose(stream);
  exit(EXIT_SUCCESS);
}