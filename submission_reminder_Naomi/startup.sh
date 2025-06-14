#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"
source ./config/config.env
source ./modules/functions.sh
bash ./app/reminder.sh
