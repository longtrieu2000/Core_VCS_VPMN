How to hack confluence

        docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
            -d \
            -p conf \
            -m Hello@world.com \
            -n Hello@world.com \
            -o your-org \
            -s you-server-id-xxxx

How to hack confluence plugin

.eg I want to use BigGantt plugin

Install BigGantt from confluence marketplace.

Find App Key of BigGantt is : eu.softwareplant.biggantt

Execute :

        docker exec confluence-srv java -jar /var/agent/atlassian-agent.jar \
            -d \
            -p eu.softwareplant.biggantt \
            -m Hello@world.com \
            -n Hello@world.com \
            -o your-org \
            -s you-server-id-xxxx
            
Paste your license