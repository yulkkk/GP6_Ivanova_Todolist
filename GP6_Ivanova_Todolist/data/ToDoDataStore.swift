import Foundation

class ToDoDataStore {
    
    var toDoItems: [[String: Any]] {
        set{
            UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
            UserDefaults.standard.synchronize()
        }
        get{
            if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]]{
                return array
            }
            else{
                return []
            }
        }
    }
    
    func addItem(nameItem: String, isCompleted: Bool = false) {
        toDoItems.append(["Name": nameItem, "isCompleted": isCompleted])
    }

    func removeItem(index: Int){
        toDoItems.remove(at: index)
    }

    func moveItem(fromIndex: Int, toIndex: Int){
        let from = toDoItems[fromIndex]
        toDoItems.remove(at: fromIndex)
        toDoItems.insert(from, at: toIndex)
    }

    func changeState(item: Int)-> Bool{
        toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
        return toDoItems[item]["isCompleted"] as! Bool
    }
    
    func getItemsCount() -> Int {
        return toDoItems.count
    }
    
    func getItem(index: Int) -> [String: Any] {
        return toDoItems[index]
    }
}
