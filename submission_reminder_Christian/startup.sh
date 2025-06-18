#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "Reminder app started at: $(date)"
source ./config/config.env
source ./modules/functions.sh
bash ./app/reminder.sh
