---
title: Shining a light on async internals
author: 'Alex Povel'
date: 'October 30, 2024'
theme: dracula
---

# `$ whoami`

- Alex Povel
- been rusting away for ~2 years
- today, also use Rust at my work at Cloudflare

# Why does async exist?

- Performance
  - **right-sized tasks**: less memory consumption
  - **fewer context switches**: switching between tasks cheaper than between threads
  - **zero-cost abstractions**: C-friendly state machines
