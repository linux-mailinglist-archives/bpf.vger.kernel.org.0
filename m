Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F39465B7D
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 02:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhLBBFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 20:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhLBBFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 20:05:07 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C41DC061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 17:01:46 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id f186so68592390ybg.2
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 17:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pNq/j1Bm8IV0LlBYNBG1hyGx+nyGBOW5XMLtrMtLJh4=;
        b=OClEfBdvODItKj7L3YC7gwK0/r9Q96VxEWq9pkuxdz9xhdqhc/soXTQ6fnlyowjV3o
         kSGA7fOy2kk3dfPdVG/WrBu3s8M2FqNHNNCwvWHchWbnmT+msoaNdFIyunuFdhbiVmI2
         LNTLVoUUtVW9rOgpDSlfzgv57lNmJlPX66U9I4crc/DuzqWkgae3GiFum/7yQ51RgW4k
         V22dmwmgAbY2z0UChZa4G+5pIfuqau3cz6bXPu6cDC4TmUui8Bfte0MxlQkOOf9Ee8OR
         aG007mxiEDMKZbZbBQ0d2HtDSzz3C4YdEJIjgZwn/ZGse8ZVTKfSd+XJpOtGI83WUsZ8
         nmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pNq/j1Bm8IV0LlBYNBG1hyGx+nyGBOW5XMLtrMtLJh4=;
        b=x6W2ttnyVppFmW550YsrUR94dPvQA0XiaeGYCEEIwR2NcRPH3ekXaymYQcaFykthTX
         dLNoWIgWkICsIPePwKu6m8r3Xuz6YjnJF2tvofsDOIFUMXxtUgJLrEtd70rvpkxO2vhc
         mI0x7UZHCg40CPtH+NU7cGXyZDYgiMK8GNmTts/Md02ZFL5kZ5iSRzPhzyIaLBPo83sC
         rgZmXIL63B5UmbCAymZq7yC0jaPj2AnoFj3r+5pyh4DhLkhdAoyjJKmSWDSX6GgxusMK
         c/hysOSbieZE+i5kYqKoLlP4CSDGKndVzC085vWAq3Yc9W9OBfa+ci/rp3QOO3ze7Hnr
         kSVQ==
X-Gm-Message-State: AOAM533CjoUdebVOkkeQonDTHNA0Zb+6Sc6O68PgBMwyZJqyH944fVY8
        o/Rt1gAHmj7yU3QjX/hmKEUsOd7TPkv1ub8R+HQpOM6txPQ=
X-Google-Smtp-Source: ABdhPJxS90KCz+v6q002hMBre7lvcGRMaKgjw5hpF2NL8olG/UIgjyWGaIy3BF3PSVGbE0eyPVwcfWbn1G1LSaB2Xho=
X-Received: by 2002:a25:2c92:: with SMTP id s140mr11315228ybs.308.1638406904936;
 Wed, 01 Dec 2021 17:01:44 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Dec 2021 17:01:33 -0800
Message-ID: <CAEf4BzZS02bE+qZfmOP-DqyRsLMxXjePs+DsT_i5wtO6J6eW+w@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v0.6 release
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        grantseltzer <grantseltzer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf v0.6 was just released ([0]). This is a pretty big release with
both new features and a whole bunch of API deprecations and clean ups.
So please take a look and give it a try! And please report any issues
and bugs we might have missed during preparation of this release.

I'd like to also call out the documentation effort started by Grant
Seltzer. Thank you! I encourage everyone to contribute to this effort
so that the libbpf v1.0 release documentation is in a great shape.

Thanks a lot to all the contributors sending fixes and new features
and all the users asking and answering libbpf and BPF questions,
adopting and testing libbpf, and overall improving the BPF ecosystem!

## Important updates towards Libbpf 1.0
  - a first big batch of deprecated APIs; compiler will let you know
or grep for "LIBBPF_DEPRECATED". Please also double-check
https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide.
  - documentation for a bunch of APIs added, available on
https://libbpf.readthedocs.io/en/latest/api.html;
  - libbpf version APIs added: compile-time
`LIBBPF_MAJOR_VERSION`/`LIBBPF_MINOR_VERSION` and runtime
`libbpf_major_version()`/`libbpf_minor_version()`/`libbpf_version_string()`;
  - stricter logic for `SEC()` definition handling (opt-in until
libbpf v1.0); see
https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
for details.
  - function name will be used when pinning if
`LIBBPF_STRICT_SEC_NAME` strict mode flag is specified;

## New features and APIs:
  - support custom `.rodata.*` and `.data.*` data sections;
  - `bpf_program__attach_kprobe()` and `bpf_program__attach_uprobe()`
supports older kernels now (don't forget about `bpf_link__destroy()`
when you are done!);
  - `BPF_MAP_TYPE_PROG_ARRAY` can be initialized statically with
syntax similar to map-in-map initialization (see
https://github.com/libbpf/libbpf/commit/472c0726e84d821186a315889c885b23895b155e
for an example);
  - libbpf-less "light" skeleton gained new capabilities and got a
bunch of fixes;
  - BTF support for `BTF_KIND_DECL_TAG` and `BTF_KIND_TYPE_TAG`;
  - new `bpf_prog_load()` and `bpf_map_create()` APIs supersede a
whole zoo of to-be-deprecated APIs;
  - support for writable raw tracepoints (`SEC("raw_tp.w/...")`) added;
  - `btf__add_btf()` API for appending entire contents of BTF to
another BTF object;
  - `bpf_program__insns()` and `bpf_program__insn_cnt()` to access
underlying BPF assembly instructions; can be used for inspection or
BPF program cloning.
  - a bunch of older APIs (`perf_buffer__new()`, `btf__dedup()`,
`btf_dump__new()`, etc) were modernized to use OPTS infrastructure.

## BPF-side APIs and features:
  - unstable BPF helpers (kernel function calls) support for kernel modules;
  - `bpf_trace_vprintk()` helper and corresponding `bpf_printk()`
macro enhancements. Note, `bpf_printk()` will now attempt to use
static global functions, so on very old kernels this might break
existing programs. Please `#define BPF_NO_GLOBAL_DATA` before
`#include <bpf/bpf_helpers.h>` if that's the case for you.
  - `bpf_get_branch_snapshot()` helper;
  - `bpf_skc_to_unix_sock()` helper;
  - `bpf_find_vma()` helper;
  - `SEC("tc")` added as a replacement for `SEC("classifier")`.

## Bug fixes and compatibility improvements:
  - libbpf now guarantees that all FDs for BPF programs, maps, BTFs,
and links are strictly greater than 0, which is important for some BPF
UAPIs;
  - no need to use `__uint(key_size, ...)` for special BPF maps (e.g.,
`BPF_MAP_PERF_EVENT_ARRAY`). Libbpf automatically downgrades
`__type(key, int)` into key_size, if a map doesn't support BTF types
for keys and values;
  - endianness fixes in `BPF_CORE_READ_BITFIELD_PROBED()` macro;
  - `btf_dump__dump_type_data()` improvements for handling unaligned data;
  - various fixes and improvements found though fuzzing and sanitizers.

**Full Changelog**: https://github.com/libbpf/libbpf/compare/v0.5.0...v0.6.0

  [0] https://github.com/libbpf/libbpf/releases/tag/v0.6.0

-- Andrii
