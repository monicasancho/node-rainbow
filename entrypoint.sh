#!/bin/sh

# Extra Runs
${RUNEXTRA:-echo "No extra runs"}

# Default exec
EXEC=${EXEC:-npm start --prefix /usr/src/node-red -- --userDir /data}

# Exec ARGS or EXEC
exec ${@:-$EXEC}
