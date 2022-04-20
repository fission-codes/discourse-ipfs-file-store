# Discourse IPFS File Store

A [Discourse forum](https://discourse.org) plugin to use IPFS to store files, using the Fission web API.

[![License](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://github.com/fission-suite/discourse-ipfs-file-store/blob/master/LICENSE)
[![Built by FISSION](https://img.shields.io/badge/⌘-Built_by_FISSION-purple.svg)](https://fission.codes)
[![Discord](https://img.shields.io/discord/478735028319158273.svg)](https://discord.gg/zAQBDEq)
[![Discourse](https://img.shields.io/discourse/https/talk.fission.codes/topics)](https://talk.fission.codes)

## Description

This add a file store component that stores files on IPFS, initially using Fission's Web API (other IPFS services welcome!).

When you use this plugin with Discourse, you enter your API keys and an optional IPFS gateway URI. Files that are uploaded through Discourse will be stored and pinned on IPFS, and served up over http using the gateway.

TO DO:
* Add support for get-ipfs to load IPFS files natively

## Installation

[Follow instructions here to install Discourse plugins](https://meta.discourse.org/t/install-plugins-in-discourse/19157) -- so you'll need to add this line to your `containers/app.yml`:

`- git clone https://github.com/fission-suite/discourse-ipfs-file-store.git`

And then rebuild the container.

## Configuration

Now you can enable and configure the plugin:

![](https://ipfs.runfission.com/ipfs/QmXR9Ljbn79uHnruXmts7VnwvhhL9SBeNUHqr7PJiGj9dN)

0. Make sure you've signed up for a Fission account, [read the guide to register using the CLI interface](https://guide.fission.codes/developers/installation)
1. Visit `$your_site/admin/site_settings/category/plugins?filter=ipfs_storage`
2. Select Enable IPFS storage
3. Enter your Fission username and password
4. Optionally enter an IPFS gateway 

## Notes

* Uploads to IPFS will go through the Fission API at [runfission.com](https://runfission.com/docs)
* If you enter an IPFS gateway (step 4 in Configuration), downloads will be pulled from that IPFS gateway. For best results, use the Fission gateway: `ipfs.runfission.com`

Further [discussion in the forum](https://talk.fission.codes/t/testing-discourse-ipfs-plugin/482), or file an issue if you run into problems.
