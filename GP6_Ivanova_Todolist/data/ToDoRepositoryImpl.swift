import Foundation

class ToDoRepositoryImpl: ToDoRepository {
    
    var dataStore: ToDoDataStore = ToDoDataStore()
    
    func addItem(nameItem: String, isCompleted: Bool = false) {
        dataStore.addItem(nameItem: nameItem, isCompleted: isCompleted)
    }
    
    func removeItem(index: Int) {
        dataStore.removeItem(index: index)
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        dataStore.moveItem(fromIndex: fromIndex, toIndex: toIndex)
    }
    
    func changeState(item: Int) -> Bool {
         return dataStore.changeState(item: item)
    }
    
    func getItemsCount() -> Int {
        return dataStore.getItemsCount()
    }
    
    func getItem(index: Int) -> [String: Any] {
        return dataStore.getItem(index: index)
    }
}
