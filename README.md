# Discourse IPFS File Store

A [Discourse forum](https://discourse.org) plugin to use IPFS to store files.

_Note: this is an empty repo, and is where the code for this project will go. Please join our Discord chat for more info._

[![License](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://github.com/fission-suite/discourse-ipfs-file-store/blob/master/LICENSE)
[![Built by FISSION](https://img.shields.io/badge/⌘-Built_by_FISSION-purple.svg)](https://fission.codes)
[![Discord](https://img.shields.io/discord/478735028319158273.svg)](https://discord.gg/zAQBDEq)
[![Discourse](https://img.shields.io/discourse/https/talk.fission.codes/topics)](https://talk.fission.codes)

## Scope

Discourse includes S3 File Storage as a base component (see [components/file_store](https://github.com/discourse/discourse/tree/master/spec/components/file_store)).

This will add a file store component that stores files on IPFS, initially using Fission's Web API.

The goal is to have a plugin that anyone can add to Discourse, enter their Fission API keys and an optional IPFS gateway URI, and files that are uploaded through Discourse will be stored and pinned on IPFS.
