# Q: Your C program uses an enumerated type to represent one of
#    100 states. You'd like to print out the state as a string
#    (as opposed to a number) for debugging purposes. Write a
#    script that reads from standard input a file containing
#   
#    name
#    state_a
#    state_b
#    ...
#
#    Produce the file name.h:
#
#    extern const char* NAME_names[];
#    typedef enum {
#        state_a,
#        state_b,
#        ...
#    } NAME;
# 
#    And name.c:
#
#    const char* NAME_names[] = {
#        "state_a",
#        "state_b",
#        ...
#    };

supplied_path = ARGV[0]
file_name = File.basename(supplied_path, ".*")

name, *states = File.readlines(supplied_path).map { |line| line.strip }

# Header file
File.write(file_name + '.h', %|
extern const char* #{name.upcase}_names[];
typedef enum {
  #{states.join(",\n  ")}
} #{name.upcase};
|.strip)

# Implementation file
File.write(file_name + '.c', %!
const char* #{name.upcase}_names[] = {
  #{states.map { |state| %{"#{state}"} }.join(",\n  ")
};
!.strip)



