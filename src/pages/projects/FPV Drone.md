---
title: "FPV Drone"
date: "2021-02-09 11:13:18 +0100"
author: "Daniel Rufus Kaldheim"
type: "page"
path: "/projects/fpv-drone"
github: https://github.com/danielkaldheim/my-public-notes/tree/master/Projects/FPV%20Drone
---


## My 5" freestyle drone

![Drone](../../images/projects/fpv-drone/images/A50BBC46-800F-4ABC-9506-681974DC7E3F.jpeg)

### Drone components

| Type                     | Manufacturer    | Model                          | Link                                                                                                               | Comment                |
| ------------------------ | --------------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ---------------------- |
| Frame 5"                 | iFlight         | Cidora SL5 V2.1 HD             | [iFlight-rc.com](https://shop.iflight-rc.com/index.php?route=product/product&product_id=1369)                      |                        |
| Flight controller        | Hobbywing       | XRotor Flight Controller F4 G3 | [hobbywing.com](http://hobbywing.com/goods.php?id=662)                                                             | Not in use. Changed to Mateksys F722-SE. |
| Flight controller        | Mateksys        | F722-SE F7 Dual Gryo           | [mateksys.com](http://www.mateksys.com/?portfolio=f722-se)                                                         |                        |
| ESC                      | Hobbywing       | XRotor Micro 60A 4in1 ESC      | [hobbywing.com](http://hobbywing.com/goods.php?id=653)                                                             |                        |
| FPV Camera               | Foxeer          | Micro Predator 5 Racing        | [foxeer.com](https://www.foxeer.com/foxeer-micro-predator-5-racing-fpv-camera-m8-lens-4ms-latency-super-wdr-g-304) |                        |
| VTX                      | Team Blacksheep | VTX UNIFY PRO 5G8 V3           | [team-blacksheep.com](https://www.team-blacksheep.com/products/prod:unify_pro)                                     |                        |
| VTX Antenna              | Team Blacksheep | TBS Triumph Pro SMA            | [team-blacksheep.com](https://www.team-blacksheep.com/products/prod:triumph_pro_sma)                               |                        |
| GPS                      | Mateksys        | GPS & COMPASS MODULE M8Q-5883  | [mateksys.com](http://www.mateksys.com/?portfolio=m8q-5883)                                                        |                        |
| Receiver                 | FrSky           | R-XSR                          | [frsky-rc.com](https://www.frsky-rc.com/product/r-xsr/)                                                            |                        |
| Props                    | HQ Ethix        | S5 5x4x3 Light Grey Combo      |                                                                                                                    |                        |
| Transmitter              | Radiomaster     | TX16S                          | [radiomasterrc.com](https://www.radiomasterrc.com/article-77.html)                                                 |                        |
| Video Receiver (goggles) | Fat Shark       | Recon V3                       | [fatshark.com](https://www.fatshark.com/product/recon-v3/)                                                         |                        |

![Drone](../../images/projects/fpv-drone/images/IMG_0303.jpeg)

### Betaflight configuration

#### Rateprofile Settings

|       | RC Rate | Rate | RC Expo | Max Vel [deg/s] |
| ----- | :-----: | :--: | :-----: | :-------------: |
| Roll  | 1.27    | 0.72 | 0.10    | 907             |
| Pitch | 1.27    | 0.72 | 0.10    | 907             |
| Yaw   | 1.00    | 0.75 | 0.00    | 800             |
