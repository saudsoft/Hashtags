//
//  HashtagsEditViewController.swift
//  Hashtags
//
//  Created by Saud Almutlaq on 21/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import TagListView

class HashtagsEditViewController: UIViewController, TagListViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var hashtagVeiw: TagListView!
    @IBOutlet weak var hashtagString: UITextField!
    @IBOutlet weak var savePosition: UISegmentedControl!
    
    @IBAction func dismissView(_ sender: Any) {
        let alert = UIAlertController(title: "تنبيه", message: "هل ترغب في حفظ التغييرات قبل الإغلاق؟", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "إلغاء", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.doDismissView()
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("non")
            }
        }))
        alert.addAction(UIAlertAction(title: "حفظ", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.saveChanges(viewAlert: false)
                self.doDismissView()
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("non")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func doDismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addHashtag(_ sender: Any) {
        if hashtagString.text != "" {
            let newHashtag = "#\(hashtagString.text ?? "")"
            
            if savePosition.selectedSegmentIndex != 0 {
                hashtagsArray.insert(newHashtag, at: 0)
            } else {
                hashtagsArray.append(newHashtag)
            }
            
            hashtagVeiw.removeAllTags()
            hashtagVeiw.addTags(hashtagsArray)
            hashtagString.text = ""
        } else {
            hashtagString.becomeFirstResponder()
            showAlert(withTitle: "", andMessage: "يرجى كتابة الهاشتاق المطلوب أولاً.", inView: self)
        }
    }
    
    func saveChanges(viewAlert:Bool = true) {
        UserDefaults.standard.set(hashtagsArray.joined(separator: " "), forKey: "hashtags")
        if viewAlert {
            showAlert(withTitle: "", andMessage: "تم حفظ التعديلات بنجاح", inView: self)
        }
    }
    
    func loadHashtags() {
        let userHashtagData = UserDefaults.standard.value(forKey: "hashtags") as! String
        
        hashtagsArray = userHashtagData.components(separatedBy: " ")
        hashtagVeiw.addTags(hashtagsArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hashtagVeiw.delegate = self
        hashtagString.delegate = self
        hashtagVeiw.fontSize(ofSize: 20)

        loadHashtags()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        hashtagsArray = hashtagsArray.filter {$0 != title}
//        saveChanges()
        sender.removeTagView(tagView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let firstVC = presentingViewController as? ViewController {
            DispatchQueue.main.async {
                firstVC.updateView()
            }
        }
    }
}
