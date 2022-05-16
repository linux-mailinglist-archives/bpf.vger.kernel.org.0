Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7971D529306
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbiEPVlg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 17:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349511AbiEPVlH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 17:41:07 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA57DE93
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 14:41:06 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id s23so17406330iog.13
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=vSnc8K8fi9byDcPGvIymx+sB48a6BLe1no0FBmZpFDw=;
        b=Z4XOQEL3KqU1LrbKwG9kBe0gsdQ2YJUeQm39S7ujMVlL6Ua6vznESXsX9fsYFVtdV4
         4LhV9rnNVFGBqbvzJ+jlTY3Pw0bQRaV+uEQkTa4/ygLhYfPWoUhv+zBpIwFt+qN2YU/Q
         gBgxaS3F15Sl4QjGIqMc4r3IkMR960StGdDU1+a+kKJitMDq0Xmkpn/hFQAqyL3vDWoT
         NzZfKN0fmLRPvxuVWEs66H6U4lVFzOTcGYx8Hcy0BRRhKeESosZGzEW85tXMgNELWs2E
         uBRYE/BVl2CfUm3diBAFhs8K2GpX2UEKWJ6CSfCpmmbeH2K6GWy59bCr9CzHBEwTBkJC
         Pv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vSnc8K8fi9byDcPGvIymx+sB48a6BLe1no0FBmZpFDw=;
        b=wm4Yu/WmeVCnz6BvUd67VJVyU2evfUR4kLj+EC9v8ViD0awgmim/u8Y3qyFuBwbIGI
         Riq0XDWivDkCmBd7WrDnl5ofqmJdeSGzJxFPluzPWu5oSVmwvBJWck0eYXSIjEyWeNJo
         LosjtqC3FktC7f39AD08ArO+cZSvJcVWdzxA4gSzRb8rnm6twKDFqDC2j1PutjoE9lj7
         pQ8vpUfBBRT5q0K9dNoE0Nsnq2/U/qeCcBp+OWbH6cuUJcGhuFDDbBDkG7AOkuQ94yKW
         vx4NokRGaU3clfWhL0jt2IMOw/bOZAXiV1z4OdxY8qRF2k0yIAHFmZKjqB+jY+oygaHr
         dk/Q==
X-Gm-Message-State: AOAM531vlUjuly1S3fgchB5bWM4430pms7ZyrMGPWm9KYAZhhfXZ41ak
        hVWXhP2KRw/IcuwhIQ/4J5gE/LVihG0JFYlQxhbUbT/ZI24=
X-Google-Smtp-Source: ABdhPJxYDEKCao7VANCV0ppPnh5Q1u4ZVOzaI1K7MfhJxBYEt8QzW8Wh3j9S/xvCdz+wAOljKP97cg2eff3zpHaoyIk=
X-Received: by 2002:a05:6638:33a1:b0:32b:8e2b:f9ba with SMTP id
 h33-20020a05663833a100b0032b8e2bf9bamr10234396jav.93.1652737265987; Mon, 16
 May 2022 14:41:05 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 14:40:55 -0700
Message-ID: <CAEf4Bza1HKkeVq=sfGP3=AFEo8j-Wv=VCoSP+UQd7=rNAKri7g@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v0.8 release
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

libbpf v0.8 was just released ([0]). It has some long-awaited new
features (USDT support, BPF sub-skeleton support), added support to
latest kernel features (multi-kprobe, BPF cookies for fentry/fexit,
etc), but also a lot of quality of life improvements (BPF verifier log
post-processing done by libbpf) and functionality to make CO-RE-based
application (in very general BPF portability sense) easier to write
and support. Further API documentation was added to existing and newly
added APIs as well.

libbpf v0.8 is intended to be the last v0.x release, so the next one
is going to be official v1.0 with deprecated APIs and per-1.0
behaviors removed. Let's use the time between v0.8 and the next v1.0
release to fix any missed or outstanding issues, tighten up error
handling and safety checks, where appropriate, as well as complete and
improve libbpf API documentation. New features are still welcome, of
course, but first and foremost I'd like to focus on general polish as
much as possible. I also encourage everyone to help with documenting a
pretty big API surface of libbpf as much as you can!

Thank you to all the contributors for making libbpf better!


## New features and APIs:
- major improvements for `uprobe`/`uretprobe` programs:
  - support auto-resolution of binaries and shared libraries from
PATH, if necessary;
  - support attaching by function names (only by IP was supported before);
- support attaching to USDTs (`SEC("usdt/...")` and
`bpf_program__attach_usdt()`) with initially supported architectures:
  - x86-64 (amd64);
  - x86 (i386);
  - s390x;
  - ARM64 (aarch64);
  - RISC V (riscv);
- improved BPF verifier log reporting for CO-RE relocation failures
(no more obscure "invalid func unknown#195896080" errors);
- auto-adjust BPF ringbuf size according to host kernel's page size
requirements;
- high-level BPF map APIs: `bpf_map__lookup_elem()`,
`bpf_map__update_elem()`, etc that validate key/value buffer sizes;
- `bpf_link_create()` can create all bpf_link-based (including raw_tp,
fentry/fexit, etc), falling back to `bpf_raw_tracepoint_open()` on old
kernels transparently;
- support opting out from auto-loading BPF programs declaratively with
`SEC("?...")`;
- support opting out from auto-creation of declarative BPF maps with
`bpf_map__set_autocreate()`;
- support multi-kprobes (`SEC("kprobe.multi/...")` and
`bpf_program__attach_kprobe_multi_opts()`);
- support target-less `SEC()` programs (e.g., `SEC("kprobe")`,
`SEC("tp")`, etc);
- support BPF sub-skeletons for "incomplete" BPF object files
(requires matching `bpftool` to generate `.subskel.h`);
- BPF cookie support for `fentry`/`fexit`/`fmod_ret` BPF programs
(`bpf_program__attach_trace_opts()`);
- support for custom `SEC()` handlers (`libbpf_register_prog_handler()`).

## BPF-side API
- BPF-side USDT APIs. See new `usdt.bpf.h` header:
  - `BPF_USDT()` program wrapper macro;
  - `bpf_usdt_arg()`, `bpf_usdt_arg_cnt()`, `bpf_usdt_cookie()` helpers;
- new `bpf_core_field_offset()` CO-RE helper and support
`bpf_core_field_size(type, field)` forms;
- `barrier()` and `barrier_var()` macros for improving BPF code generation;
- `__kptr` and `__kptr_ref` tags added;
- ARC architecture support in `bpf_tracing.h` header;
- new BPF helpers:
  - `bpf_skb_set_tstamp()`;
  - `bpf_ima_file_hash()`;
  - `bpf_kptr_xchg()`;
  - `bpf_map_lookup_percpu_elem()`.

## Bug fixes
- netlink bug fixes;
- libbpf.pc fixes to support patch releases properly;
- `BPF_MAP_TYPE_PERF_EVENT_ARRAY` map auto-pinning fix;
- minor CO-RE fixes and improvements for some corner cases;
- various other small fixes and improvements.

**Full Changelog**: https://github.com/libbpf/libbpf/compare/v0.7.0...v0.8.0

  [0] https://github.com/libbpf/libbpf/releases/tag/v0.8.0

-- Andrii
