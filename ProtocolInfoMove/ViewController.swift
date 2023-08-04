//
//  ViewController.swift
//  ProtocolInfoAndTableView
//
//  Created by cheshire on 2023/08/04.
//

import UIKit

protocol ProtocolData : AnyObject {
    func passData(_ data: String)
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    
    weak var dataDelegate: ProtocolData?
    
    
    @IBOutlet weak var secondButtonMoveButton: UIButton!
    @IBOutlet weak var textFieldMain: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondButtonMoveButton.setTitle("다른 화면으로 이동하는 버튼", for: .normal)
        textFieldMain.placeholder = "텍스트 입력 하면 다른 화면에 뜸"
        textFieldMain.delegate = self
        
        
    }
    
    @IBAction func secondViewMoveButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "secondMoveIdentifire", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 스토리보드에서 identifier 적용 필요 secondMoveIdentifire
        if segue.identifier == "secondMoveIdentifire" {
            let secondViewController = segue.destination as! SecondViewController
            self.dataDelegate = secondViewController
            if let text = textFieldMain.text {
                dataDelegate?.passData(text)
            }
        }
    }

}



/*
 

 1. `override func prepare(for segue: UIStoryboardSegue, sender: Any?)`:
    - 이 메서드는 뷰 컨트롤러에서 다른 뷰 컨트롤러로 전환하기 전에 준비 작업을 수행하는 데 사용됩니다. 즉, 하나의 화면에서 다른 화면으로 넘어가기 전에 필요한 작업을 수행하게 됩니다.

 2. `if segue.identifier == "secondMoveIdentifire"`:
    - 이 조건문은 segue의 identifier가 "secondMoveIdentifire"인 경우에만 아래의 코드를 실행하도록 합니다. segue identifier는 Storyboard에서 설정하며, 여러 개의 segue가 있을 때 각각을 구분하기 위해 사용됩니다.

 3. `let secondViewController = segue.destination as! SecondViewController`:
    - 이 라인은 segue의 목적지(destination)를 `SecondViewController`로 타입 캐스팅합니다. 이것은 "이 segue가 우리를 `SecondViewController`로 이동시킬 것이라고 확신하고 있으므로, 우리는 그 목적지를 `SecondViewController`로 처리하도록 할 것"이라는 뜻입니다.

 4. `self.delegate = secondViewController`:
    - 이 라인은 `SecondViewController` 인스턴스를 현재 뷰 컨트롤러의 `delegate`로 설정합니다. 이렇게 함으로써, 현재 뷰 컨트롤러는 `SecondViewController`에 정의된 `ProtocolData` 프로토콜의 메서드를 호출할 수 있게 됩니다.
 
    이 코드는 "delegation"이라는 디자인 패턴을 사용하고 있습니다. 이 패턴은 한 객체가 다른 객체의 특정 작업을 대신 처리하도록 위임하는 방식입니다. 여기서 "위임자(delegate)"는 특정 작업을 대신 처리할 객체를 가리킵니다.

    `self.delegate = secondViewController` 코드에서 `self.delegate`는 `ViewController` 클래스의 `delegate` 프로퍼티를 가리킵니다. 이 프로퍼티는 `ProtocolData` 프로토콜을 준수하는 어떤 객체든 저장할 수 있습니다. 이 프로토콜은 `passData(_:)` 메서드를 정의하고 있습니다.

    `secondViewController`는 `SecondViewController` 클래스의 인스턴스를 가리키며, 이 클래스는 `ProtocolData` 프로토콜을 준수합니다. 즉, `SecondViewController`는 `passData(_:)` 메서드를 가지고 있습니다.

    따라서 `self.delegate = secondViewController` 코드는 `ViewController`의 `delegate` 프로퍼티에 `SecondViewController` 인스턴스를 저장합니다. 이렇게 하면 `ViewController`는 `delegate` 프로퍼티를 통해 `passData(_:)` 메서드를 호출할 수 있습니다. 이 메서드는 실제로 `SecondViewController` 인스턴스에서 실행되므로, `ViewController`는 `SecondViewController`에게 데이터 전달 작업을 위임하게 됩니다.

    이 방식은 두 객체 간의 결합도를 낮추고, 코드의 재사용성과 유연성을 높이는 데 도움이 됩니다. 특히 UIKit에서는 이 패턴을 광범위하게 사용하고 있습니다. 예를 들어, 테이블 뷰는 테이블 뷰의 데이터 소스나 델리게이트를 설정하여 데이터를 제공하거나 사용자 상호작용을 처리하는 등의 작업을 위임받습니다.

 5. `if let text = textFieldMain.text`:
    - 이 라인은 Swift의 Optional Binding을 사용하여 `textFieldMain.text`의 값을 안전하게 추출합니다. `textFieldMain.text`는 Optional 값이므로 `nil`일 수 있습니다. 이 구문을 사용하면 `textFieldMain.text`가 `nil`이 아닐 경우에만 아래의 코드를 실행하도록 합니다.

 6. `delegate?.passData(text)`:
    - 이 라인은 delegate에 `passData(_:)` 메서드를 호출하여 텍스트 필드의 텍스트를 전달합니다. 이것은 "텍스트 필드의 내용을 `SecondViewController`로 전달하고 싶다"는 뜻입니다. `delegate?.passData(text)`에서 `?`는 delegate가 `nil`일 경우 메서드 호출을 무시하도록 합니다. 이렇게 하면 delegate가 아직 설정되지 않은 상황에서 메서드를 호출하려 해도 크래시가 발생하지 않습니다.
 
 
 */
