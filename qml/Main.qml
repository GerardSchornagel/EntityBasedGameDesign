import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    EntityManager {
        id: entityManager
        entityContainer: scene
    }

    // start physics once the splash screen has disappeared, else the box would fall out of the screen while the splash is shown
    onSplashScreenFinished: world.running = true

    Scene {
        id: scene

        PhysicsWorld {
            id: world
            // physics is disabled initially, and enabled after the splash is finished
            running: false
            gravity.y: 9.81
            z: 10 // draw the debugDraw on top of the entities

            // these are performance settings to avoid boxes colliding too far together
            // set them as low as possible so it still looks good
            updatesPerSecondForPhysics: 60
            velocityIterations: 5
            positionIterations: 5
            // set this to true to see the debug draw of the physics system
            // this displays all bodies, joints and forces which is great for debugging
            debugDrawVisible: false
        }

        EntityBase {
            entityId: "box1"
            entityType: "box"

            Image {
                id: boxImage
                source: "../assets/img/box.png"
                width: 32
                height: 32
            }
            BoxCollider {
                anchors.fill: boxImage
            }
        }
        EntityBase {
            entityId: "ground1"
            entityType: "ground"
            height: 20
            anchors {
                bottom: scene.bottom
                left: scene.left
                right: scene.right
            }

            Rectangle {
                anchors.fill: parent
                color: "blue"
            }
            BoxCollider {
                anchors.fill: parent
                bodyType: Body.Static // the body shouldn't move
            }
        }
    }
}
