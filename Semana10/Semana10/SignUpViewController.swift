import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var btnSignup: UIButton!
    
    var ref: DatabaseReference!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        firstnameTextField.text! = "Joel"
        lastnameTextField.text! = "Joel"
        userTextField.text! = "joelc"
        passTextField.text! = "123456"
        emailTextField.text! = "joelc@gmail.com"
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        birthdayTextField.inputAccessoryView = toolbar
        birthdayTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        //datePicker.locale = Locale(identifier: "es")
    }
    
    @objc func donePressed(){
        let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .none
        //format.locale = Locale(identifier: "es")
        birthdayTextField.text = format.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        
        let firstname = firstnameTextField.text!
        let lastname = lastnameTextField.text!
        let username = userTextField.text!
        let pass = passTextField.text!
        let email = emailTextField.text!
        let birthday = birthdayTextField.text!
        
        if firstname.isEmpty || lastname.isEmpty || username.isEmpty || pass.isEmpty || email.isEmpty || birthday.isEmpty {
            let alert = UIAlertView()
            alert.title = "Oops"
            alert.message = "Complete todos los campos"
            alert.addButton(withTitle: "Ok")
            alert.show()
        } else {
            Auth.auth().createUser(withEmail: email, password: pass, completion: { authResult, error in
                if error == nil {
                    print("SignUp OK")
                    Auth.auth().signIn(withEmail: email, password: pass, completion: { authResult, error  in
                        if error == nil {
                            guard let userID = (Auth.auth().currentUser?.uid) else { return }
                            self.ref = Database.database().reference()
                            self.ref.child("users").child(userID).setValue(["firstname": firstname, "lastname": lastname, "username": username, "email": email, "birthday": birthday])
                            self.performSegue(withIdentifier: "nextsignup", sender: nil)
                        } else {
                            print("SignUp Error:\(String(describing: error))")
                        }
                    })
                } else {
                    print("SignUp Error:\(String(describing: error))")
                }
            })
        }
    }
}
