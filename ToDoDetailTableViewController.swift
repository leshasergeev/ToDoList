//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Алексей Сергеев on 28.04.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    
    // MARK: - Properties
    
    var todo: ToDo?
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Actions
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func editingBegan(_ sender: Any) {
        if titleTextField.text == "Remind me to..." {
            titleTextField.text = ""
        }
        titleTextField.textColor = .black
    }
    
    @IBAction func returnPressed(_ sender: UITextView) {
        sender.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.textColor = .black
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
            saveButton.isEnabled = false
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
    }

    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isDatePickerHidden.toggle()
            dueDateLabel.textColor = .black
            updateDueDateLabel(date: dueDatePickerView.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == false:
            return 216
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    // MARK: - Other functions
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    private func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title       = titleTextField.text!
        let isComplete  = isCompleteButton.isSelected
        let dueDate     = dueDatePickerView.date
        let notes       = notesTextView.text
        
        // checking todo to nil.
        // If it is, will be created new todo instance.
        // If not, all properties will be replaced to new ones, though ID won't be changed to replace it's cell.
        if todo == nil {
            self.todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
            return
        } else {
            todo?.title         = title
            todo?.isComplete    = isComplete
            todo?.dueDate       = dueDate
            todo?.notes         = notes
        }
        
    }
}
