# Discourse IPFS File Store

A [Discourse forum](https://discourse.org) plugin to use IPFS to store files.

[![License](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://github.com/fission-suite/discourse-ipfs-file-store/blob/master/LICENSE)
[![Built by FISSION](https://img.shields.io/badge/⌘-Built_by_FISSION-purple.svg)](https://fission.codes)
[![Discord](https://img.shields.io/discord/478735028319158273.svg)](https://discord.gg/zAQBDEq)
[![Discourse](https://img.shields.io/discourse/https/talk.fission.codes/topics)](https://talk.fission.codes)

## Description

This add a file store component that stores files on IPFS, initially using Fission's Web API.

When you use this plugin with Discourse, you enter your Fission API keys and an optional IPFS gateway URI. Files that are uploaded through Discourse will be stored and pinned on IPFS.

## Installation

[Follow instructions here to install](https://meta.discourse.org/t/install-plugins-in-discourse/19157)

## Configuration

0. Make sure you've signed up for a [Fission](https://RunFission.com) account
1. Visit `$your_site/admin/site_settings/category/plugins?filter=ipfs_storage`
2. Select Enable IPFS storage
2. Enter your Fission username and password
3. Optionally enter an IPFS gateway 

## Notes

* Uploads to IPFS will go through RunFission.com
* If you enter an IPFS gateway (step 4 in Configuration), downloads will be pulled from that IPFS gateway
