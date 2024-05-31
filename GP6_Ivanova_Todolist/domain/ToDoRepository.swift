import Foundation

protocol ToDoRepository {
    
    func addItem(nameItem: String, isCompleted: Bool)
    
    func removeItem(index: Int)
    
    func moveItem(fromIndex: Int, toIndex: Int)
    
    func changeState(item: Int)-> Bool
    
    func getItemsCount() -> Int
    
    func getItem(index: Int) -> [String: Any]
}
