//
//  SavedColorViewController.swift
//  RGB Color App
//
//  Created by Артем Сергеев on 07.07.2022.
//

import UIKit

class SavedColorViewController: UIViewController {

    @IBOutlet var savedCanvas: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func editColor(_ sender: UIBarButtonItem) {
        let generateColorVC = storyboard?.instantiateViewController(withIdentifier: "idViewController") as! GenerateColorViewController
        generateColorVC.viewColorDelegate = self
        navigationController?.pushViewController(generateColorVC, animated: true)
//        present(generateColorVC, animated: true)
    
    }
    
//    @IBAction func unwindToSavedColor(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source as! GenerateColorViewController
//        savedCanvas.backgroundColor = sourceViewController.canvasView.backgroundColor
//        // Use data from the view controller which initiated the unwind segue
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SavedColorViewController: ViewColorDelegate {
    func getViewBackground(view: UIView) {
        savedCanvas.backgroundColor = view.backgroundColor
    }
    
    
}
