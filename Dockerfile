FROM graphhopper/graphhopper:latest



ENV OSM_FILE map.pbf
ENV OSM_SOURCE https://skoleskyss.akt.no/osrm/agder.osm.pbf
ENV CONFIG config.yml

# Let the container know that there is no TTY
ARG DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get -y update && apt-get install -y -qq --no-install-recommends cron

COPY ./launcher.sh ./config.yml ./

COPY monitor.sh /
RUN chmod +x /monitor.sh

COPY monitor-cron /etc/cron.d/monitor-cron
RUN chmod 0644 /etc/cron.d/monitor-cron
RUN crontab /etc/cron.d/monitor-cron
CMD cron

ENTRYPOINT [ "./launcher.sh" ]
