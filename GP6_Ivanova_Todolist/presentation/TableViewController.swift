import UIKit

class TableViewController: UITableViewController {
    
    var repository: ToDoRepository = ToDoRepositoryImpl()
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        
        let alertAction1 = UIAlertAction(title: "cancel", style: .default){ alert in
            
        }
        let alertAction2 = UIAlertAction(title: "create", style: .cancel){ alert in
            let newItem = alertController.textFields![0].text
            self.repository.addItem(nameItem: newItem!, isCompleted: false)
            self.tableView.reloadData()
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New item name"
            alertAction2.isEnabled = false
            let editingChanged = UIAction { _ in
                if (textField.text ?? "").isEmpty  {
                    alertAction2.isEnabled = false
                } else {
                    alertAction2.isEnabled = true
                }
            }
            textField.addAction(editingChanged, for: .editingChanged)
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(named: "ColorPink")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repository.getItemsCount()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let curentItem = repository.getItem(index: indexPath.row)
        cell.textLabel?.text = curentItem["Name"] as? String

        if curentItem["isCompleted"] as? Bool == true{
            cell.imageView?.image = UIImage(named: "check.png")
        }
        else{
            cell.imageView?.image = UIImage(named: "uncheck.png")
        }
        
        if tableView.isEditing{
            cell.textLabel?.alpha = 0.4
            cell.imageView?.alpha = 0.4
        }
        else{
            cell.textLabel?.alpha = 1
            cell.imageView?.alpha = 1
        }


        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            repository.removeItem(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if repository.changeState(item: indexPath.row){
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check.png")
            
        }
        else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "uncheck.png")
        }

    }
    

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        repository.moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing{
            return .none
        }
        else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
