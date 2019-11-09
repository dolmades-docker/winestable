FROM dolmades/base:1.2

MAINTAINER Stefan Kombrink

# install wine stable
RUN apt-get update && apt-get install -y winehq-stable winetricks && apt-get clean && rm -rf /var/lib/apt/lists/*
# install mono
RUN mkdir -p /opt/wine-stable/share/wine/mono && \
    wget http://dl.winehq.org/wine/wine-mono/4.7.5/wine-mono-4.7.5.msi \
    -O /opt/wine-stable/share/wine/mono/wine-mono-4.7.5.msi
# install gecko
RUN mkdir -p /opt/wine-stable/share/wine/gecko && cd /opt/wine-stable/share/wine/gecko && \
    wget http://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi && \
    wget http://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi
# force a winetricks version which supports --self-update
COPY winetricks.deb /winetricks.deb
RUN apt-get update && apt-get install -y binutils cabextract p7zip unzip && dpkg -i /winetricks.deb && winetricks --self-update && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -f /winetricks.deb
