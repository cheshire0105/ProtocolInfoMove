//
//  ViewController.swift
//  ProtocolInfoAndTableView
//
//  Created by cheshire on 2023/08/04.
//

import UIKit

// 우편을 어떻게 전송 하려고 하는가.
protocol ProtocolData : AnyObject {
    // 편지를 어떻게 받을까?
    func passData(_ data: String)
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    // 주소록을 확인 하는 것. 편지를 받을 친구가 내 주소를 알고 있을까? 확인 하는 작업
    weak var dataDelegate: ProtocolData?
    
    /*
     물론이죠! dataDelegate 변수에 대한 설명을 좀 더 깊게 들어가겠습니다.

     dataDelegate 란?
     dataDelegate는 ProtocolData 프로토콜을 준수하는 객체의 참조를 저장하는 변수입니다. weak 키워드는 이 변수가 약한 참조(weak reference)를 가지게 됨을 의미합니다.

     1. 프로토콜과 델리게이트
     델리게이트(delegate)는 특정 작업을 대신 수행하거나, 또는 특정 이벤트가 발생했을 때 그 정보를 전달하는 역할을 합니다. 프로토콜은 이러한 델리게이트가 어떤 메서드나 속성을 가져야 하는지 정의합니다. 따라서, ProtocolData는 델리게이트가 데이터를 전달받는 방식을 정의한 것이고, dataDelegate는 이를 구현한 구체적인 객체의 참조를 저장하는 변수입니다.

     2. weak 키워드
     weak는 약한 참조를 나타내는 키워드입니다. 약한 참조는 참조 카운트를 증가시키지 않기 때문에 순환 참조(circular reference)로 인한 메모리 누수를 방지할 수 있습니다.

     예를 들어, ViewController가 SecondViewController를 참조하고, 동시에 SecondViewController도 ViewController를 참조하는 상황이 발생하면 순환 참조가 생길 수 있습니다. 이런 상황에서 weak를 사용하면 한 객체가 다른 객체를 강하게 참조하지 않기 때문에 메모리 누수를 방지할 수 있습니다.

     3. 왜 dataDelegate를 선언하는가?
     ViewController에서 SecondViewController로 데이터를 전달하기 위해 dataDelegate를 사용합니다. ViewController는 자신이 가진 데이터를 직접 SecondViewController에 전달할 수 없기 때문에, 대신하여 dataDelegate를 통해 데이터를 전달합니다. 이렇게 하면 ViewController는 SecondViewController의 구체적인 구현에 의존하지 않고, 대신 프로토콜에만 의존하여 데이터를 전달할 수 있습니다. 이는 두 컨트롤러 간의 결합도를 낮추고 유연성을 높이는 방법입니다.

     결론적으로, dataDelegate는 ViewController와 SecondViewController 사이의 데이터 전달 역할을 하는 "중개자" 역할을 합니다.
     */
    
    /*
     메모리 관점에서의 weak:
     상상해보세요. 여러분이 빌려준 책이 있는데, 누군가에게 그 책을 빌려주었다고 생각해보세요. 여러분이 그 책을 필요로 하면 언제든지 다시 가져올 수 있습니다. 그러나 그 사람이 그 책을 필요로 하지 않게 되면, 그 책은 여러분에게 자동으로 돌아옵니다.

     메모리에서의 weak 참조도 비슷합니다:

     ViewController (빌려주는 사람)가 SecondViewController (빌리는 사람)에게 데이터를 전달할 의도를 가지고 있습니다.
     ViewController는 dataDelegate를 사용하여 SecondViewController에게 데이터를 전달할 준비를 합니다.
     그러나, ViewController는 SecondViewController를 영구히 기억하고 싶지 않습니다. 그냥 일시적으로 연결하고 싶을 뿐입니다.
     여기서 weak가 등장합니다. weak는 ViewController가 SecondViewController를 잠시 연결하되, 너무 오래 기억하지 않게 해줍니다.
     SecondViewController가 사라지면 (즉, 메모리에서 해제되면), dataDelegate는 자동으로 nil이 됩니다.
     
     dataDelegate 사용:
     dataDelegate는 사실상 전화기와 같습니다. ViewController가 SecondViewController에게 데이터를 전달하려면, 이 전화기(dataDelegate)를 사용하여 호출합니다. 이 때, ViewController는 직접 SecondViewController를 알 필요가 없습니다. 단순히 전화기만 사용하여 연락을 취하면 됩니다.

     요약하면, weak는 메모리에서의 안전한 연결을 보장하며, dataDelegate는 두 컨트롤러 사이의 통신을 도와줍니다.

     
     */
    
    
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
                // 편지함에 편지를 넣는 것.
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


/*
 상황: 친구 A와 친구 B가 있습니다. A는 편지를 쓰고, B에게 그 내용을 전달하려고 합니다.

 프로토콜 정의: 우리의 세계에서 우편 전송 방식(우편 규칙)을 정의해 둔 것과 같습니다.

 여기서 ProtocolData는 특정 형식의 편지(데이터)를 어떻게 전달받을지 규칙을 정의합니다.
 passData(_ data: String)은 "편지를 받는 방법"입니다.
 
 친구 A (ViewController):
 친구 A는 편지를 쓴 후 친구 B에게 전달하려고 합니다.
 편지를 전달하기 전에 친구 A는 친구 B가 우편 전송 방식(우편 규칙)을 알고 있는지 확인합니다.
 dataDelegate는 친구 A가 편지를 전달할 준비를 하기 위해 친구 B의 주소록에 있는 주소와 같습니다.
 
 친구 B (SecondViewController):
 친구 B는 우편 전송 방식(우편 규칙)을 알고 있기 때문에 편지를 받을 준비가 되어 있습니다.
 passData(_ data: String) 메서드는 친구 B의 "편지함"과 같습니다. 친구 A가 편지를 보내면, 친구 B는 이 편지함에 편지를 받아 둡니다.
 
 편지 전송:
 친구 A는 performSegue를 사용하여 친구 B에게 방문합니다.
 친구 A가 친구 B의 집에 도착하면, prepare(for:sender:) 메서드를 통해 편지를 전달합니다.
 이 때 dataDelegate?.passData(text) 코드는 친구 A가 친구 B의 "편지함"에 편지를 넣는 것과 같습니다.
 
 편지 확인:
 친구 B는 자신의 "편지함"을 확인하여 친구 A로부터 받은 편지 내용을 확인합니다.
 textFieldSecondView.text = data 코드는 친구 B가 편지 내용을 읽는 것과 같습니다.
 */
