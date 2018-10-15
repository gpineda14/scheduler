# Class Scheduling #
***
## Running The Program ##
***
The program can be ran using the following command:
```
./scheduler name_of_json_file
```
I used Ruby version 2.4.0 to create the program. The folder also contains a scheduler.rb file that I used to test my code. With the help of rspec, I created a number of automated tests. I used the files in the input folder as test input for the program. You can run rspec within the scheduler folder to see the results of the tests.
## The Thought Process ##
***
### Brute Force Method ###

My first idea involved a simple brute force method where I initially scan the json array for classes that do not have any prerequisites. These classes would then be added to an array of classes that have been taken (lets call the array taken). I would then rescan the json array. These classes would have prerequisites that I would then compare against the taken array. If prerequisite courses have been taken then the class can be added to the taken class. This would continue until all classes are in the taken array.

Some Issues with this method
* This method would lead to an inefficient time complexity (O(n^2)) because we're scanning the class array and scanning each item against the taken array.
* I wanted to find way to sort the classes at a first come basis, where whichever class came first in the array of objects, we would find its prerequisites and add them first so we can add that "set" of classes.

### Frame Scheduling as a Graph Problem ###

I began to expand on the second issue and came up with this simple set:

Suppose I have three classes to take [CS 31, CS 32, CS 33] where each class has the former as a prerequisite (CS 31 not having any prerequisites). This then produced the following diagram:

CS 31 -> CS 32 -> CS 33.

The structure of the diagram reminded me of a tree and I recognized that the ordering we desired (i.e all prerequisites are satisfied before taking a course) was the result of a post-order depth-first search.

So instead of going for a bottom-up approach where I find classes with no prerequisites and build up from there, I decided to take top-down approach where I get a class and if it has prerequisites, I then schedule all its prerequisites first so I can add the class after.

After I drew a couple more examples, I saw that the classes resembled a Directed Acyclic Graph. Because we wanted a schedule with all the classes, then the solution became clear. We just needed a way to visit all the nodes in a graph (nodes being classes) at least once where the leaves are added before adding the root. This fits our requirements of satisfying the prerequisites of a class.

## Designing the Program ##
***
I broke the program down into four components

### readAndParse ###

The readAndParse method was responsible for taking the first argument (i.e the name of the file). The program would then find the absolute path of the file and then read the file. Using the JSON library, I parsed the file, which returned an array of objects. Each object had a name and an array of prerequisite courses.

Time Complexity: O(N)

### convertToAdjList ###

I wanted to change the array of objects into a hash map where the key is the name of the class and its value is the array of prerequisite classes. I wanted to do this to allow for fast lookups (O(1) time). I did this by creating a new hash map and iterating through the array of objects.

Time Complexity: O(N), where N is the number of classes in the array

### arrangeClasses ###

The most important part of the code is the arrangeClasses method which accepts an adjacency list as input. I first begin by creating a "visited" hash map that marks which vertices (or classes) have been visited. The arrOfClasses variable will contain the list of courses in an ordering that satisfies our condition (all prerequisites of a class are satisfied before taking the class).

The function would then iterate through all classes and if a class has not been visited, a depth-first search would be performed with the given class as root. Because of the visited map, if a vertex has already been visited then we return and don't perform a depth-first search.

The depth-first search is doing a post-order traversal, so all prerequisites of a class are added first to the arrOfClasses array before adding the class itself. This ensures that our conditions are satisfied, producing a correct ordering of classes.

Space Complexity: O(N), for the visited hash map where N is number of classes

Time Complexity: O(N) for the traversal of the adjacency list while creating the visited map, O(N + E) for traversing through the graph, where N is number of classes and E is number of edges (there is a edge between class and prerequisite courses). This results to having a time complexity of O(2N + E) => O(N + E).

### convertToMessage ###

The convertToMessage function takes the array of classes that has been ordered correctly and turns it into a string where every class is on a new line. This string is then printed to standard out.

Time Complexity: O(N), where N is number of classes

## Time Complexity ##
***
The functions readAndParse, convertToAdjList, and convertToMessage all have a time complexity of O(N). The arrangeClasses function has a time complexity of O(2N + E). The whole program then has a time complexity of O(5N + E) => O(N + E).
