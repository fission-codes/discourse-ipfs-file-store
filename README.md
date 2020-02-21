# Discourse IPFS File Store

A [Discourse forum](https://discourse.org) plugin to use IPFS to store files, using the Fission web API.

[![License](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://github.com/fission-suite/discourse-ipfs-file-store/blob/master/LICENSE)
[![Built by FISSION](https://img.shields.io/badge/⌘-Built_by_FISSION-purple.svg)](https://fission.codes)
[![Discord](https://img.shields.io/discord/478735028319158273.svg)](https://discord.gg/zAQBDEq)
[![Discourse](https://img.shields.io/discourse/https/talk.fission.codes/topics)](https://talk.fission.codes)

## Description

This add a file store component that stores files on IPFS, initially using Fission's Web API.

When you use this plugin with Discourse, you enter your Fission API keys and an optional IPFS gateway URI. Files that are uploaded through Discourse will be stored and pinned on IPFS.

## Installation

1. [Follow instructions here to install](https://meta.discourse.org/t/install-plugins-in-discourse/19157)

2. Don't forget to go to the directory where you installed the plugin and check out the v1 branch: `git checkout v1`.  

3. Start discourse `bundle exec rails s`

## Configuration

0. Make sure you've signed up for a [Fission](https://RunFission.com) account
1. Visit `$your_site/admin/site_settings/category/plugins?filter=ipfs_storage`
2. Select Enable IPFS storage
2. Enter your Fission username and password
3. Optionally enter an IPFS gateway 

## Notes

* Uploads to IPFS will go through RunFission.com
* If you enter an IPFS gateway (step 4 in Configuration), downloads will be pulled from that IPFS gateway
=======
![](https://ipfs.runfission.com/ipfs/QmXR9Ljbn79uHnruXmts7VnwvhhL9SBeNUHqr7PJiGj9dN)

## Installing on your own Discourse

Follow the [instructions for installing plugins into Discourse](https://meta.discourse.org/t/install-plugins-in-discourse/19157).

Currently the testing branch is where the up to date code is, so you'll need to add this line to your `containers/app.yml`:

`- git clone https://github.com/fission-suite/discourse-ipfs-file-store.git -b "v1"`

Follow the [Fission Guide to register a new user / API key on the command line](https://guide.fission.codes/apps/getting-started). This gets filled into the Discourse settings for username and password (see screenshot above).

For best results, use the Fission gateway: `ipfs.runfission.com`

Further [discussion in the forum](https://talk.fission.codes/t/testing-discourse-ipfs-plugin/482).
