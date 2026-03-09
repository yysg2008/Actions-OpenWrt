#!/bin/sh
state_file="/etc/usb_role"
driver_path="/sys/class/udc/ci_hdrc.0/device/driver/ci_hdrc.0/role"

# 等待节点最多 30 秒
for i in $(seq 1 30); do
    [ -f "$driver_path" ] && break
    sleep 1
done

# 恢复模式
if [ -f "$state_file" ]; then
    role=$(cat "$state_file")
    echo "$role" > "$driver_path" 2>/dev/null
    echo "Restored USB role to $role"
else
    echo "No saved USB role, keep default gadget mode"
fi
