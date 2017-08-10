# Usage

	docker run -i --rm -v $(pwd):/usr/src/project \
	           -e LOCAL_USER_ID=$(id -u ${USER}) \
	           -e DISPLAY=${DISPLAY} \
	           -v /tmp/.X11-unix:/tmp/.X11-unix \
	           -v /run/dbus/:/run/dbus/ \
	           -v /dev/shm:/dev/shm \
	           -t gtalent/openlp-devenv bash
