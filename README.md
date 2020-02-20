# Discourse IPFS File Store

A [Discourse forum](https://discourse.org) plugin to use IPFS to store files, using the Fission web API.

[![License](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://github.com/fission-suite/discourse-ipfs-file-store/blob/master/LICENSE)
[![Built by FISSION](https://img.shields.io/badge/⌘-Built_by_FISSION-purple.svg)](https://fission.codes)
[![Discord](https://img.shields.io/discord/478735028319158273.svg)](https://discord.gg/zAQBDEq)
[![Discourse](https://img.shields.io/discourse/https/talk.fission.codes/topics)](https://talk.fission.codes)

![](https://ipfs.runfission.com/ipfs/QmXR9Ljbn79uHnruXmts7VnwvhhL9SBeNUHqr7PJiGj9dN)

## Installing on your own Discourse

Follow the [instructions for installing plugins into Discourse](https://meta.discourse.org/t/install-plugins-in-discourse/19157).

Currently the testing branch is where the up to date code is, so you'll need to add this line to your `containers/app.yml`:

`- git clone https://github.com/fission-suite/discourse-ipfs-file-store.git -b "v1"`

Follow the [Fission Guide to register a new user / API key on the command line](https://guide.fission.codes/apps/getting-started). This gets filled into the Discourse settings for username and password (see screenshot above).

For best results, use the Fission gateway: `ipfs.runfission.com`

Further [discussion in the forum](https://talk.fission.codes/t/testing-discourse-ipfs-plugin/482).
