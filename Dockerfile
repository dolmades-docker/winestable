FROM dolmades/base:1.2

MAINTAINER Stefan Kombrink

# install wine stable
RUN apt-get update && apt-get install -y winehq-stable winetricks && apt-get clean && rm -rf /var/lib/apt/lists/*
# force a winetricks version which supports --self-update
COPY winetricks.deb /winetricks.deb
RUN apt-get update && apt-get install -y binutils cabextract p7zip unzip && dpkg -i /winetricks.deb && winetricks --self-update && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -f /winetricks.deb
