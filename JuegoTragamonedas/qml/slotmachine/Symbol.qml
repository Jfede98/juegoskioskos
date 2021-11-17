import Felgo 3.0
import QtQuick 2.0

Item {
  // we want to set the image for each symbol
  property alias imageSource: image.source
    height: 73
    width: 139
    x: -20
  // add image with some margin add the top/bottom
  Image {
    id: image
    anchors.fill: parent
    anchors.topMargin: 23
    anchors.bottomMargin: 20
    anchors.leftMargin: 60
    anchors.rightMargin: 47
  }
}
