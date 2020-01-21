---
title: Pre-requirements
date: '2020-01-13'
weight: 30
---

I assume that you are confident in managing Linux (Ubuntu). Specifically, I assume you already know how to:

* Edit configuration files using vim or nano
* Tail a log file
* Stop and start services
* SSH into a remote virtual machine

We will not cover any of these topics in detail:

* Vertical scaling with load balancing
* Docker, kubernetes and launcher
* Authentication methods other than LDAP
* Database configuration, pro drivers
* Setting up proxies or reverse proxies, e.g. using Nginx or Apache
* Automated, scripted deployment, e.g. using Chef, Puppet or Ansible

Hardware requirements:

* You should be working on a laptop with a modern web browser. We have tested on Chrome and Firefox, but any web browser in the [officially supported list](https://support.rstudio.com/hc/en-us/articles/227449447-Supported-browsers-for-RStudio-Connect) is fine.
* Your laptop firewall should allow traffic on websockets (for RStudio Server)
* You should be able to SSH into an AWS virtual machine

You will not be required to install any software on your laptop.  We will provide you with an Amazon AWS virtual machine and you will access this VM and do installation there.