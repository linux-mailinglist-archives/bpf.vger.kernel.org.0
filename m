Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53D259CA69
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiHVUzA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 16:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiHVUy6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 16:54:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7447848CA7
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 13:54:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so14954389ejt.6
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=owOZBLZRnQrlshVjhoPSQgWVG/Di/LOhS2qR4oiE4G8=;
        b=MSshdC9rG+m80wd/a2nInR5kLsj5p5O8SioHpu6cYAMde8tj65NhIyrsn4x6TSLNM8
         iklzC0oTNYG9DgKDPgOxPD1MQOuMFUMRGJYe5ZvCuwyBKyPHbBOqa/I9H9YhR/SbVq9F
         ePkk36rKKSe6JwA7p5dnj4KqslFbu6HbxynGtqdO0EqqH0ZkVyWEhBNGgWG+Y8Iz1XSM
         kyQGsXsSL13GbZxvKKcQv/gcEZao5hMQ8yF3JnczhQBjeqpjtxkdeQfPnmJtqTP2GhQK
         3b+Uyr+bPiKqGMRrPe86RogqqdzaVfTv1EbuZRTtwpn2GzMqwUmK39e/Au6xTfNyowXi
         yBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=owOZBLZRnQrlshVjhoPSQgWVG/Di/LOhS2qR4oiE4G8=;
        b=EpBxjnZaPc0HEXmWnCzcTtg/HcQT0LUqzzJ249OO12Ccjp0WGp8nVMXl3HFlsKFBzV
         lGU7HRJuLTYPAWUwHSyv6rFFBNQQgO1fEYRB1FGwjAYjIAj7CX73hJMC0j3A3/jdJ/h9
         zStXGNW0U9FEvTtjeDv4xPX9NcMGzCVLuA4+xLlE8j0NU7j2WSkWo54ZE/XJyesBylYC
         aYJi4vWeUleYW1mn41WtOESan01KpwMkmaZnaQB/7vgDCHLqrAVbnup4NwW7d48GHF+s
         RejMVjZRcEVbwBZFYZtO2rsX8R+kRprMfpLQiUvWjv5LEXmSooQLcmc51v0CcxzyRFWs
         tBCw==
X-Gm-Message-State: ACgBeo1WUYOO0hO1GPl8C/LUHgfp6ELk1F2vbz5ck+RtW2ny1CteHc0J
        LxkGDszAGGi4MJyMRYpbtNEnEgrLjRCaCL7gYOLm0A8P/bY=
X-Google-Smtp-Source: AA6agR6yPmmeZsKix8LQkSw+ynuP+J/k60z8mkttBkhT+dCnwunzjz985HrGLQRxOWlA8YeUp3qbGPMOgdTS0B+wKn8=
X-Received: by 2002:a17:907:2d12:b0:731:6a4e:ceb0 with SMTP id
 gs18-20020a1709072d1200b007316a4eceb0mr14073980ejc.115.1661201695769; Mon, 22
 Aug 2022 13:54:55 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Aug 2022 13:54:44 -0700
Message-ID: <CAEf4BzbK2zBVwNhgxmVC27RHuyqLke+m69M0iz=2XwWjJehKBQ@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v1.0 release
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf v1.0 ([0]) is here!

It's been a long journey for libbpf to get to 1.0, but it was worth
it. By taking time to get here, with community help and involvement,
we got a more well thought out, user friendly, and full-featured
library. libbpf 1.0 now provides a battle-tested foundation for
building any kind of BPF application. It also sets a good base for
future libbpf releases with more exciting functionality while
backwards compatibility across minor version releases, all while
keeping maintainability in focus.

A big "Thank you!" goes to hundreds of contributors and bug reporters
across the entire libbpf family of projects for all your work and
support!

**Congratulations on the long-awaited v1.0!**

To celebrate this event, I wrote a blog post ([1]) describing the
journey to libbpf 1.0 and also highlighting main breaking changes and
new functionality added on the way to libbpf 1.0. Please take a look
if you are a libbpf user.

See detailed change log for v1.0 below.

## User-space-side features and APIs:
- **All deprecated APIs and features removed!**
- support for syscall-specific kprobe/kretprobe
(`SEC("ksyscall/<syscall_name>")` and
`SEC("kretsyscall/<syscall_name>")`);
- support for sleepable uprobe BPF programs (`SEC("uprobe.s")`);
- support for per-cgroup LSM BPF programs (`SEC("lsm_cgroup")`);
- support for new BPF CO-RE relocation `TYPE_MATCHES`;
- `bpf_prog_load()` and `bpf_map_create()` are now smarter about
handling program and map name on old kernels (it will be ignored if
kernel doesn't support names);
- `BTF_KIND_ENUM64` support;
- increase tracing attachment (kprobe/uprobe/tracepoint) robustness by
using tracefs or debugfs, whichever is mounted;
- new APIs for converting BPF enums to their string representation:
  - `libbpf_bpf_prog_type_str()`;
  - `libbpf_bpf_map_type_str()`;
  - `libbpf_bpf_link_type_str()`;
  - `libbpf_bpf_attach_type_str()`;
- `bpf_program__set_autoattach()` and `bpf_program__autoattach()` to
allow opting out from auto-attaching of BPF program by BPF skeleton;
- `perf_buffer__buffer()` API to give access to underlying per-CPU
buffer for BPF ringbuf;
- `bpf_obj_get_opts()` API for more flexible fetching of BPF kernel
objects' information.

## BPF-side features and APIs;
- `bpf_core_type_matches()` helper macro to emit `TYPE_MATCHES` CO-RE
relocations;
- USDT support now doesn't rely on BPF CO-RE;
- new and improved `BPF_KSYSCALL()` macro for tracing syscalls, which
abstracts away a lot of kernel- and architecture-specific differences;
- new BPF helpers:
  - `bpf_skc_to_mptcp_sock()`;
  - `bpf_dynptr_from_mem()`;
  - `bpf_ringbuf_reserve_dynptr()`, `bpf_ringbuf_submit_dynptr()`,
`bpf_ringbuf_discard_dynptr()`;
  - `bpf_dynptr_read()`, `bpf_dynptr_write()`;
  - `bpf_dynptr_data()`;
  - `bpf_tcp_raw_gen_syncookie_ipv4()`,
`bpf_tcp_raw_gen_syncookie_ipv6()`,
`bpf_tcp_raw_check_syncookie_ipv4()`,
`bpf_tcp_raw_check_syncookie_ipv6()`;
  - `bpf_ktime_get_tai_ns()`.

## Bug fixes
- fix power-of-2 check when adjusting BPF ringbuf map size;
- improve robustness of pointer size determination in BTF processing;
- symbol offset calculation logic fixes for uprobes and USDTs;
- fixes for clean up of legacy kprobe/uprobe attachments on partial failures;
- fix register definition for riscv architecture;
- improve robustness of reused map name handling.

  [0] https://github.com/libbpf/libbpf/releases/tag/v1.0.0
  [1] https://nakryiko.com/posts/libbpf-v1/
  [2] Full Changelog: https://github.com/libbpf/libbpf/compare/v0.8.0...v1.0.0

-- Andrii
