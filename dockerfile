FROM nginx:latest

# Install necessary packages
RUN apt-get update && apt-get install -y cron curl tzdata

# Set the timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create necessary directories
RUN mkdir -p /var/www/html

# Copy the Nginx default config
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy the custom entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Copy the toggle alert script
COPY toggle_alert.sh /usr/local/bin/toggle_alert.sh
RUN chmod +x /usr/local/bin/toggle_alert.sh

# Copy the crontab file (empty for now)
COPY crontab.txt /etc/cron.d/probealarm-cron

# Create a log file for cron job
RUN touch /var/log/cron.log

# Expose port 80
EXPOSE 80

# Start the cron service and nginx
CMD /usr/local/bin/entrypoint.sh
