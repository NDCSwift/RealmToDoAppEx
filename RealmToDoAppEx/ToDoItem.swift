// Import RealmSwift to use Realm's database features
import RealmSwift

// Define a category model with a one-to-many relationship to ToDoItems
class Category: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var activeItems = RealmSwift.List<ToDoItem>()
    @Persisted var completedItems = RealmSwift.List<ToDoItem>()
}

// Define a model class for each to-do item, conforming to Realm's Object and Identifiable for use in SwiftUI
class ToDoItem: Object, Identifiable {
    // Unique identifier for each item, generated automatically
    @Persisted(primaryKey: true) var id: ObjectId

    // Title or description of the task
    @Persisted var title: String = ""

    // Flag indicating whether the task is completed
    @Persisted var isCompleted: Bool = false

    // Backlinks to the categories that own this item
    @Persisted(originProperty: "activeItems") var activeCategory: LinkingObjects<Category>
    @Persisted(originProperty: "completedItems") var completedCategory: LinkingObjects<Category>
}
