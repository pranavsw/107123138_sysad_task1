#!/bin/bash

(crontab -l 2>/dev/null; echo "0 0 * * * bash /path/to/displayStatus.sh") | crontab -

(crontab -l 2>/dev/null; echo "10 10 * * 0,2,4,6 bash /path/to/deRegister.sh") | crontab -