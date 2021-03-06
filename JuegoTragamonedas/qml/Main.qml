import Felgo 3.0
import QtQuick 2.0
import "slotmachine"

GameWindow {
  id: gameWindow

  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  activeScene: scene

  // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
  // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
  // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
  // this resolution is for iPhone 4 & iPhone 4S
  width: 937
  height: 1648

  Scene {
    id: scene

    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 640
    height: 1160

    // properties for the game
    property int betAmount: 1 // amount to bet per line
    property int creditAmount: 4 // player credit for gambling


    // animate credit amount when changed
    Behavior on creditAmount {
      PropertyAnimation { duration: scene.betAmount * 50 }
    }

    // fill game window with background
    Rectangle {
      anchors.fill: scene.gameWindowAnchorItem
      color: "#8A2E73"
    }

    Image {
      id: watermark
      anchors.fill: scene
      source: "../assets/watermark_bg.png"
    }

    Image {
        id: credito
        source: "../assets/credits.png"
        x: 425
        y:378
        width: 150
        height: 50
    }

    Image {
        id: rightlight
        source: "../assets/right_light.png"
        x: 110
        y: 520
        width: 550
        height: 635
    }

    Image {
        id: leftlight
        source: "../assets/left_light.png"
        x: -17
        y: 520
        width: 550
        height: 635
    }



    Juegoslot{
        id: slotMachine
        x: 163
        y: 567
        defaultItemHeight: 73
        defaultReelWidth: 100


        // velocity of spin should decrease/increase along with item height
        spinVelocity: Math.round(defaultItemHeight / 80 * 750)

        // link signal to handler function
        onSpinEnded: scene.spinEnded()


        // choose random delay to stop each reel for every spin
        onSpinStarted: {
          // delay stop of each reel between 350 and 700 ms
          slotMachine.reelStopDelay = utils.generateRandomValueBetween(350, 700)
        }

    }

    Image {
        id: maquina
        source: "../assets/Frame.png"
        width: 467
        height: 532
        x: 87
        y: 400

    }


    Image {
        id: titulo
        source: "../assets/title.png"
        width: 490
        height: 320
        x: 85
        y: 85
    }

/*
    Image {
        id: pinkmac
        source: "../assets/pinkmac.png"
        smooth: true
        opacity: 1
        width: 150
        height: 150
        x: 257
        y: 415


        MouseArea {
            id: mouseArea
            anchors.fill: parent
            anchors.margins: -10
            hoverEnabled: true //this line will enable mouseArea.containsMouse
            onClicked: pinkmac.opacity= 0
        }


         states: State {
             name: "mouse-over"; when: mouseArea.containsMouse
             PropertyChanges { target: pinkmac; scale: 0.8; opacity: 0 }
             PropertyChanges { target: greymac; scale: 0.8; opacity: 1}
         }

        transitions: Transition {
                 NumberAnimation { properties: "scale, opacity"; easing.type: Easing.InOutQuad; duration: 1000  }
             }

    }*/

    Image {
        id: watch
        source: "../assets/apple_watch.png"
        smooth: true
        opacity: 1
        width: 150
        height: 150
        x: 247
        y: 405
    }

    Image {
        id: moneda
        source: "../assets/Icono-coin.png"
        x: 113
        y: 870
        width: 425
        height: 175
        z:1
    }

    Image {
        id: presionar
        source: "../assets/Iconos-Boton.png"
        x: 190
        y: 950
        width: 275
        height: 75
        MouseArea {
          anchors.fill: parent
          onClicked: scene.startSlotMachine()
        }
    }

    Image {
        id: credit
        source: "../assets/icono-num.png"
        x: 460
        y: 430
        width: 75
        height: 75
    }


    Text {
      anchors.centerIn: numcont
      text: scene.creditAmount
      color: "white"
      font.pixelSize: 22
      font.family: "Times"
      font.bold: true
      x: 475
      y: 445
      z:1
    }

    Rectangle {
        id: numcont
        anchors.centerIn: credit
        width: 50
        height: 50
        x: 460
        y: 430
        color: "#753fbc"
        radius: width / 2
    }

    Image {
        id: lost
        source: "../assets/perdiste.png"
        visible: false
        x: 95
        y: 450
        width: 475
        height: 375
        z:1
        MouseArea{
            anchors.fill: parent
            onClicked: scene.restartGame()
        }
    }

    Image {
        id: win
        source: "../assets/ganaste.png"
        visible: false
        x: 95
        y: 420
        width: 475
        height: 445
        z:1
        MouseArea{
            anchors.fill: parent
            onClicked: scene.restartGame()
        }
    }


    // validator to check if player has won
        WinValidator {
          id: winValidator
          height: slotMachine.height // height is the same as slotmachine height
          width: Math.round(height /  240 * 408) // width/height ratio should remain constant
          anchors.centerIn: slotMachine
          z:1
        }







    // configure top bar
       /* TopBar {
          id: topBar
          width: scene.gameWindowAnchorItem.width
          anchors.top: scene.gameWindowAnchorItem.top
          anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        }*/

        // configure bottom bar
        BottomBar {
          opacity: 0
          id: bottomBar
          width: scene.gameWindowAnchorItem.width
          anchors.bottom: scene.gameWindowAnchorItem.bottom
          anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter

          // link signals to handler functions
          onStartClicked: scene.startSlotMachine()
          onAutoClicked: scene.autoPlaySlotMachine()
          onIncreaseBetClicked: scene.increaseBetAmount()
          onDecreaseBetClicked: scene.decreaseBetAmount()
          onMaxBetClicked: scene.maxBetAmount()
        }

        // increase bet
        function increaseBetAmount() {
          // prevent bet changes while start button is active (machine is running)
          if(bottomBar.startActive)
            return

          // increase bet amount to next bigger step
          if (betAmount < 5 && creditAmount >= 5)
            betAmount = 5
          else if (betAmount < 8 && creditAmount >= 8)
            betAmount = 8
          else if (betAmount < 10 && creditAmount >= 10)
            betAmount = 10
          else if (betAmount < 15 && creditAmount >= 15)
            betAmount = 15
          else if (betAmount < 20 && creditAmount >= 20)
            betAmount = 20
        }

        // decrease bet
        function decreaseBetAmount() {
          // prevent bet changes while start button is active (machine is running)
          if(bottomBar.startActive)
            return

          // decrease bet amount to next smaller step
          if (betAmount > 15 && creditAmount >= 15)
            betAmount = 15
          else if (betAmount > 10 && creditAmount >= 10)
            betAmount = 10
          else if (betAmount > 8 && creditAmount >= 8)
            betAmount = 8
          else if (betAmount > 5 && creditAmount >= 5)
            betAmount = 5
          else if (betAmount > 4)
            betAmount = 4
        }

        // set maximum bet
        function maxBetAmount() {
          // prevent bet changes while machine is started
          if(bottomBar.startActive)
            return

          // set bet amount to maximum affordable available step
          if(creditAmount >= 20)
            betAmount = 20
          else if(creditAmount >= 15)
            betAmount = 15
          else if(creditAmount >= 10)
            betAmount = 10
          else if(creditAmount >= 8)
            betAmount = 8
          else if(creditAmount >= 5)
            betAmount = 5
          else if(creditAmount >= 4)
            betAmount = 4
        }

        // auto play slot machine
        function autoPlaySlotMachine() {
          // switch active state of auto button
          bottomBar.autoActive = !bottomBar.autoActive
          if(bottomBar.autoActive)
            startSlotMachine()
        }

            // start slot machine
        function startSlotMachine() {
            if(!slotMachine.spinning && scene.creditAmount >= scene.betAmount) {
              bottomBar.startActive = true

              // reduce player credits
              scene.creditAmount -= scene.betAmount

              // start machine
              winValidator.reset()
              var stopInterval = utils.generateRandomValueBetween(500, 1000) // between 500 and 1000 ms
              slotMachine.spin(stopInterval)
            }
            if(scene.creditAmount === 0)
                lost.visible= true
        }

        function spinEnded() {
          bottomBar.startActive = false
          var won = winValidator.validate(slotMachine)
          if(won){
            //winValidator.showWinningLines()
            win.visible= true
          }else if(bottomBar.autoActive)
            startSlotMachine()
        }

        function restartGame(){
            lost.visible = false
            win.visible = false
            scene.creditAmount = 4
        }

  }
}
