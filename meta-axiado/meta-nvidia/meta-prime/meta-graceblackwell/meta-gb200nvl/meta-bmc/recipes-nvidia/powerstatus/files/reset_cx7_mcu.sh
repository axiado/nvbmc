#!/bin/sh

set -eu

LOG_FILE="/var/log/mcu-reset-once.log"
GPIO_POLL_INTERVAL_SEC=2
USB_POLL_INTERVAL_SEC=2

BOOT_COMPLETE_GPIOS="SEC_CX_BOOT_CMPLT_CX0-I SEC_CX_BOOT_CMPLT_CX1-I CX_BOOT_CMPLT_CX0-I CX_BOOT_CMPLT_CX1-I"

log()
{
	msg="$(date '+%Y-%m-%d %H:%M:%S') $*"
	printf '%s\n' "$msg" >> "$LOG_FILE"
	printf '%s\n' "$msg"
}

read_gpio_value()
{
	gpio_name="$1"

	set -- $(gpiofind "$gpio_name")
	chip="${1:-}"
	line="${2:-}"

	if [ -z "$chip" ] || [ -z "$line" ]; then
		log "failed to resolve GPIO line for $gpio_name"
		return 1
	fi

	gpioget "$chip" "$line"
}

wait_for_boot_complete_gpio_high()
{
	while :; do
		all_high=1
		values=""

		for gpio_name in $BOOT_COMPLETE_GPIOS; do
			value="$(read_gpio_value "$gpio_name" 2>/dev/null || echo 0)"
			log "read_gpio_value for $gpio_name: $value"
			values="${values}${values:+ }${gpio_name}=${value}"
			if [ "$value" != "1" ]; then
				all_high=0
			fi
		done

		#log "boot-complete GPIO states: $values"

		if [ "$all_high" -eq 1 ]; then
			log "all boot-complete GPIOs are high"
			return 0
		fi

		sleep "$GPIO_POLL_INTERVAL_SEC"
	done
}

resolve_gpio_line()
{
	gpio_name="$1"

	set -- $(gpiofind "$gpio_name")
	chip="${1:-}"
	line="${2:-}"

	if [ -z "$chip" ] || [ -z "$line" ]; then
		log "failed to resolve GPIO line for $gpio_name"
		return 1
	fi

	printf '%s %s\n' "$chip" "$line"
}

set_gpio_level()
{
	gpio_name="$1"
	gpio_level="$2"

	set -- $(resolve_gpio_line "$gpio_name")
	chip="$1"
	line="$2"

	log "gpioset $gpio_name to $gpio_level"
	gpioset "$chip" "$line=$gpio_level"
}

wait_for_lsusb_id()
{
	while :; do
		count="$(lsusb | grep -c "0955:cf10" || true)"
		if [ "$count" -ge 2 ]; then
			log "lsusb has device ID 0955:cf10 with count=$count"
			return 0
		fi

		log "waiting for two occurrences of device ID 0955:cf10 in lsusb (current count=$count)"
		sleep "$USB_POLL_INTERVAL_SEC"
	done
}

log "mcu reset one-shot flow started"

wait_for_boot_complete_gpio_high

set_gpio_level "MCU_RST_N-O" 0
sleep 2
set_gpio_level "MCU_RST_N-O" 1
sleep 2
set_gpio_level "SEC_MCU_RST_N-O" 0
sleep 2
set_gpio_level "SEC_MCU_RST_N-O" 1

wait_for_lsusb_id

log "mcu reset one-shot flow completed"

