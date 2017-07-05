#!/usr/bin/env bash

# start gui: http://localhost:3000
sh ../gui/build-run.sh 1.0.0

# start partyservice: http://localhost:8091/partyservice/resources/parties
gnome-terminal -x sh -c "../partyservice/build-run.sh 1.0.0;bash"

# start read-partyservice: http://localhost:8092/partyservice.read/resources/parties
gnome-terminal -x sh -c "../readparty/build-run.sh 1.0.0;bash"


# start streams: http://localhost:8093/kafka-streams/resources/streams
gnome-terminal -x sh -c "../stream/build-run.sh;bash"


