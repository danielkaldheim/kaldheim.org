---
title: "Last.fm to mqtt"
path: "/lastfm-to-mqtt"
date: "2020-05-07"
coverImage: "../images/lastfm-to-mqtt.png"
author: "Daniel Rufus Kaldheim"
type: "post"
excerpt: "I'm building a photo-display that will show photos and album art. For that reason I needed to extract album art from what I'm playing. Since there is multiple sources this could be gathered from Last.fm is joining these sources together."
tags: ["Photo display", "last.fm", "mqtt"]
github: https://github.com/danielkaldheim/last.fm-to-mqtt
---

I'm building a photo-display that will show photos and album art. For that reason I needed to extract album art from what I'm playing. Since there is multiple sources this could be gathered from [Last.fm](https://last.fm) is joining these sources together.

This projects pulls recent tracks from Last.fm and distributes it to MQTT and WebSocket. A small browser app to show what's playing now.

## Mqtt payload

```json
{
  "track": "I Sat by the Ocean",
  "artist": "Queens of the Stone Age",
  "album": "...Like Clockwork",
  "nowPlaying": true,
  "mbid": "3d07181c-afe8-4f36-8526-bbee50b98a36",
  "image": "https://lastfm.freetls.fastly.net/i/u/300x300/9872bc77018f9ba97f4bf504e25e1380.png"
}

```

Checkout this project on [github](https://github.com/danielkaldheim/last.fm-to-mqtt).
