#!/bin/bash
swaymsg -t get_inputs | python3 -c "
import sys, json
inputs = json.load(sys.stdin)
for i in inputs:
    if i.get('type') == 'keyboard' and 'xkb_active_layout_name' in i:
        name = i['xkb_active_layout_name']
        # Extract short code from parentheses or use first word
        import re
        m = re.search(r'\((\w+)\)', name)
        short = m.group(1) if m else name.split()[0]
        print(short.upper())
        break
"
