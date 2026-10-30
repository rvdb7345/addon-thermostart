# Changelog

## 1.0.8
- store the setpoint the thermostat reports, so changes made on the device and schedule transitions show up in the API / Home Assistant

## 1.0.7
- API can set the firmware host/port and trigger a one-shot over-the-air firmware update
- THERMOSTART_COMMIT in the Dockerfile so a rebuild never reuses a cached older checkout

## 1.0.6
- expose the /thermostat JSON API on the direct port (3888) so Home Assistant can reach it

## 1.0.5
- build Thermostart from rvdb7345/thermostart (fixed /thermostat POST API for Home Assistant, fail-safe weather lookup)
- unpin apt package versions so the image still builds

## 1.0.4
- migrate to 7.6.2 base image

## 1.0.3
- fix for flask migrate

## 1.0.2
- added flask migrate

## 1.0.1
- fixed autologin - moved autologin variables to correct run

## 1.0.0

- Add autologin support
