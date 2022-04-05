const String databaseName = "MyToDoApp.sqlite";
const int databaseVersion = 1;
const String toDoTable = "todo";
const createTodoTable = """
    CREATE TABLE IF NOT EXISTS todo (
      id INTEGER PRIMARY KEY,
      title TEXT,
      description TEXT,
      status INTEGER NOT NULL DEFAULT 0
    )
  """;

const dropTodoTable = "DROP TABLE IF EXISTS todo";
