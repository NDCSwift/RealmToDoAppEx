//
// Project: RealmToDoAppEx
//  File: ContentView.swift
//  Created by Noah Carpenter
//  🐱 Follow me on YouTube! 🎥
//  https://www.youtube.com/@NoahDoesCoding97
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//  Dream Big, Code Bigger

// Import SwiftUI to create the app's user interface
import SwiftUI
// Import RealmSwift to use Realm database features and object observation
import RealmSwift

struct ContentView: View {
    // Observes live-updating list of ToDoItem objects stored in Realm.
    // Any changes to the database will automatically update the UI.
    @ObservedResults(ToDoItem.self) var todoItems

    // Stores the text input from the user for creating a new task.
    @State private var newTask = ""

    var body: some View {
        // Provides a navigation bar and stack-based navigation for the app.
        NavigationView {
            VStack {
                // Horizontal stack for the new task input field and Add button.
                HStack {
                    // TextField binds to newTask and allows user input for new tasks.
                    TextField("New Task", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    // Button to add a new task to the list.
                    Button("Add") {
                        // Only add if the new task text is not empty.
                        guard !newTask.isEmpty else { return }
                        // Append a new ToDoItem with the entered title to the Realm collection.
                        // $todoItems is a binding to the live list of ToDoItem objects.
                        $todoItems.append(ToDoItem(value: ["title": newTask]))
                        // Clear the input field after adding.
                        newTask = ""
                    }
                }
                .padding()

                // List displays all ToDoItems, grouped into two sections.
                List {
                    // Section for tasks that are not completed.
                    Section(header: Text("Active Tasks")) {
                        // Filter todoItems to only show those that are not completed.
                        ForEach(todoItems.filter { !$0.isCompleted }) { item in
                            // Each row is a horizontal stack with the task title and a completion icon.
                            HStack {
                                // Show the task title.
                                Text(item.title)
                                Spacer()
                                // Show a circle or checkmark depending on completion state.
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .onTapGesture {
                                        // Tapping toggles the completion state.
                                        // .thaw() returns a mutable (thawed) reference to the Realm object,
                                        // required for making write transactions.
                                        if let item = item.thaw(), let realm = item.realm {
                                            // Perform the update inside a Realm write transaction.
                                            try? realm.write {
                                                item.isCompleted.toggle()
                                            }
                                        }
                                    }
                            }
                        }
                        // Enables swipe-to-delete for active tasks.
                        .onDelete { indexSet in
                            // Map indexSet to the filtered array to get correct objects, since ForEach is on a filtered array.
                            let activeItems = todoItems.filter { !$0.isCompleted }
                            let objectsToDelete = indexSet.map { activeItems[$0] }
                            for obj in objectsToDelete {
                                // .thaw() makes the object mutable for deletion.
                                if let thawed = obj.thaw(), let realm = thawed.realm {
                                    // Delete the object within a Realm write transaction.
                                    try? realm.write {
                                        realm.delete(thawed)
                                    }
                                }
                            }
                        }
                    }

                    // Section for tasks that are completed.
                    Section(header: Text("Completed Tasks")) {
                        // Filter todoItems to only show those that are completed.
                        ForEach(todoItems.filter { $0.isCompleted }) { item in
                            HStack {
                                // Show the task title in gray to indicate completion.
                                Text(item.title)
                                    .foregroundColor(.gray)
                                Spacer()
                                // Show a filled checkmark icon in green.
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .onTapGesture {
                                        // Tapping toggles the completion state back to active.
                                        if let item = item.thaw(), let realm = item.realm {
                                            try? realm.write {
                                                item.isCompleted.toggle()
                                            }
                                        }
                                    }
                            }
                        }
                        // Enables swipe-to-delete for completed tasks.
                        .onDelete { indexSet in
                            // Map indexSet to the filtered array to get correct objects.
                            let completedItems = todoItems.filter { $0.isCompleted }
                            let objectsToDelete = indexSet.map { completedItems[$0] }
                            for obj in objectsToDelete {
                                if let thawed = obj.thaw(), let realm = thawed.realm {
                                    try? realm.write {
                                        realm.delete(thawed)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // Sets the title of the navigation bar.
            .navigationTitle("My To-Do List")
        }
        // Executes when the view appears.
        .onAppear{
            // Prints the file URL where the Realm database file is stored.
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
}


#Preview {
    ContentView()
        .environment(\.realmConfiguration, Realm.Configuration(inMemoryIdentifier: "Preview"))
}
