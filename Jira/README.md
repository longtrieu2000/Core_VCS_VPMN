Jira
How to hack jira

    docker exec jira-srv java -jar /var/agent/atlassian-agent.jar \
        -d \
        -p jira \
        -m Hello@world.com \
        -n Hello@world.com \
        -o your-org \
        -s you-server-id-xxxx
    
How to hack jira plugin

.eg I want to use BigGantt plugin

Install BigGantt from jira marketplace.

Find App Key of BigGantt is : eu.softwareplant.biggantt

Execute :

    docker exec jira-srv java -jar /var/agent/atlassian-agent.jar \
        -d \
        -p eu.softwareplant.biggantt \
        -m Hello@world.com \
        -n Hello@world.com \
        -o your-org \
        -s you-server-id-xxxx
        
Paste your license

Hack Jira Service Management(jsm) Plugin

Thanks to:

d1m0nstr for Jira Service Management

    docker exec jira-srv java -jar /var/agent/atlassian-agent.jar \
        -d \
        -p jsm \
        -m Hello@world.com \
        -n Hello@world.com \
        -o your-org/ \
        -s you-server-id
