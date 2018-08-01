//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Jonathan T. Miles on 8/1/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memoryController.memories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell", for: indexPath)
        let memory = memoryController.memories[indexPath.row]
        cell.textLabel?.text = memory.title
        cell.imageView?.image = UIImage(data: memory.imageData) // converts the imageData of the model into an image before passing it into the .image property
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memoryController.deleteMemory(memory: memoryController.memories[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? MemoryDetailViewController else { return }
        destVC.memoryController = memoryController
        
        if segue.identifier == "CreateMemoryDetail" {
            
        } else if segue.identifier == "ShowMemoryDetail"{
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            destVC.memory = memoryController.memories[index]
        }
        
    }
    
    // MARK: - Properties
    
    var memory: Memory?
    var memoryController = MemoryController()

}
