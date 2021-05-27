import UIKit
import Firebase

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.black.cgColor
        //imageView.layer.cornerRadius = imageView.bounds.width / 2
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        let url = info[UIImagePickerController.InfoKey.imageURL] as? URL
        print(url!)
        uploadIMG(fileURL: url!)
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoBoton.isEnabled = false
        performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)
    }
    
    func uploadIMG (fileURL : URL) {
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let localFile = fileURL
        //let imagenData = UIImage.pngData(imageView.image!)
    
        imagenesFolder.child("\(NSUUID().uuidString).png").putFile(from: localFile, metadata: nil) { (metadata, error) in
            if error != nil {
                print("Ocurrió un error:\(String(describing: error))")
            } else {
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)
                
            }
        }
    }
}
