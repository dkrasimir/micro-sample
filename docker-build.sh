#!/bin/sh
mvn clean package && docker build -t 016973021151.dkr.ecr.us-west-2.amazonaws.com/dkrasimir/micro .