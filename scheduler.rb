#!/usr/bin/ruby
require 'json'

def scheduler(file)
  # read and parse json file
  classes = readAndParse(file)
  # convert json to adjacency list
  adjList = convertToAdjList(classes)
  # order the classes using a dfs search
  schedule = arrangeClasses(adjList)
  # convert array to string
  finalSchedule = convertToMessage(schedule)
  print finalSchedule
end

# String -> Array of Objects
def readAndParse(file)
  classes = nil
  begin
    json = File.read(file)
    classes = JSON.parse(json)
  rescue Exception => ex
    print "Error: #{ex}"
  end
  classes
end

# Array -> Hash
def convertToAdjList(vertices)
    adjList = {}
    vertices.each { |obj| adjList[obj['name']] = obj['prerequisites'] }
    adjList
end

# Hash -> Array
def arrangeClasses(adjList)
  visited = {}
  arrOfClasses = []

  adjList.each_key { |vertex| visited[vertex] = false}
  adjList.each_key do |vertex|
    if !visited[vertex]
      dfs(visited, vertex, adjList, arrOfClasses)
    end
  end

  arrOfClasses
end

# Postorder dfs
def dfs(visited, vertex, adjList, classes)
  if (visited[vertex])
    return
  end
  visited[vertex] = true
  currNode = adjList[vertex]
  if !currNode.empty?
    currNode.each { |neighbor| dfs(visited, neighbor, adjList, classes) }
  end
  classes << vertex
end

# Array -> String
def convertToMessage(arr)
  msg = ""
  arr.each do |lesson|
    name = lesson + "\n"
    msg += name
  end
  msg
end
