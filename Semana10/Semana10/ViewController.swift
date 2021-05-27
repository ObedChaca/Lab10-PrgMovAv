import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.transToHome()
        } else {
            
        }
        
        
    }

    func transToHome() {
        
        let homeVC = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.homeVC) as? SnapsViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    
}

