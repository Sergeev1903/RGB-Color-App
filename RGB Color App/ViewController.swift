//
//  ViewController.swift
//  RGB Color App
//
//  Created by Артем Сергеев on 17.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var canvasView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvasView.layer.cornerRadius = 10
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        // calling methods to enable start values
        setColorForCanvasView()
        setValueForLabel()
        setValueForTextField()
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
        
    }
    
    @IBAction func getValueFromSlider(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLabel.text = toString(from: sender)
            redTextField.text = toString(from: sender)
        case 1:
            greenLabel.text = toString(from: sender)
            greenTextField.text = toString(from: sender)
        case 2:
            blueLabel.text = toString(from: sender)
            blueTextField.text =  toString(from: sender)
        default:
            break
        }
        
        setColorForCanvasView()
    }
    
    private func setColorForCanvasView() {
        canvasView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value / 255),
            green: CGFloat(greenSlider.value / 255),
            blue: CGFloat(blueSlider.value / 255),
            alpha: 1
        )
//        view.backgroundColor = canvasView.backgroundColor
    }
    
    private func setValueForLabel() {
        redLabel.text = toString(from: redSlider)
        greenLabel.text = toString(from: greenSlider)
        blueLabel.text = toString(from: blueSlider)
    }
    
    private func setValueForTextField() {
        redTextField.text = toString(from: redSlider)
        greenTextField.text = toString(from: greenSlider)
        blueTextField.text = toString(from: blueSlider)
    }
    
    // casting parameters to string
    private func toString(from slider: UISlider) -> String {
        return String(Int(slider.value))
    }
}

extension ViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру нажатием на "Done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Скрытие клавиатуры по тапу за пределами Text View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true) // Скрывает клавиатуру, вызванную для любого объекта
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            
            switch textField.tag {
            case 0:
                redSlider.value = currentValue
            case 1:
                greenSlider.value = currentValue
            case 2:
                blueSlider.value = currentValue
            default: break
            }
            
            setColorForCanvasView()
            setValueForLabel()
        } else {
            showAlert(title: "Wrong format!",
                      message: "Please enter correct value")
        }
    }
}

extension ViewController {
    
    // Метод для отображения кнопки "Готово" на цифровой клавиатуре
    private func addDoneButtonTo(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}






