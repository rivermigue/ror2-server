FROM cm2network/steamcmd:root

RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		gnupg2 \
		xauth \
		gettext \
		winbind \
	&& wget -nc https://dl.winehq.org/wine-builds/winehq.key \
	&& apt-key add winehq.key \
	&& echo "deb https://dl.winehq.org/wine-builds/debian/ buster main" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		xvfb \
		lib32gcc1 \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wine-stable-amd64=3.0.1~buster \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wine-stable-i386=3.0.1~buster \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wine-stable=3.0.1~buster \
	&& chown -R steam:steam ${STEAMAPPDIR} \
	&& ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAMAPPDIR} \
		+@sSteamCmdForcePlatformType windows +app_update ${STEAMAPPID} +quit \
	&& apt-get remove --purge -y \
		wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*
  
RUN adduser -u 1000 bedrock
RUN usermod -a -G bedrock bedrock

ENV WINEPREFIX=/home/bedrock
ENV WINEDEBUG=-all
USER 1000:1000
