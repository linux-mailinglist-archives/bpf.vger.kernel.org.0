Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257894041BC
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 01:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhIHXZt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 19:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbhIHXZt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 19:25:49 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A04C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 16:24:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id q70so7607050ybg.11
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 16:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mwcTJBko8mgmWTViC5+9/og5pc8KnSrFWBWKXCs+Rr0=;
        b=ayq0K3SaHJiGLfz8eHqsiSMuyK4KkTBn6qrFcvselThay+myi557Tg44PedCZiYa8E
         w6F5tQZnVGXH+CikOWP7TTLOcSSs/j1d74To/jUssz+KBwT+VvSC1Mp1ezGvp8IFWVfo
         cMN2/3BgaFPtPOF4atbNDTOnedLkOhklVA/pIym890Xhi2VZF7VxyTslJlBPCmvRXkNs
         J/eDt05o1/x7eXSiyQi0x9MM5bwphLTjkWC0N9/Ywj/DbBWDgljlivhT+6suiYqfmkEG
         4LamzBHZrw9guXopqY7pXzzmHydNbQLRZ716N+EVUm3Yt6YnYZU2gmTT3jetyQK6pmxx
         1uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mwcTJBko8mgmWTViC5+9/og5pc8KnSrFWBWKXCs+Rr0=;
        b=wULaOKOn8VJXOweRPmLPgOjKmklpAmGmtxKTja95Ou5Dgr5CbGBK3I56b0jC5wEJUr
         CWbzJycTkjr57yEkMUsypISFRt142YFyDJuV3F/8kpF3x1KcpEPsxOPE9i9x6MM2iLyx
         Jzb55qZdblJUkNvgA1lJVjg9iECynb2ryz+GtMJNLIN8BkyiInEycke+tRPAFBjXhk3z
         wRCWiIjRclacfxAWx1svGQ1IUzcyiR2K3c/3p89lgh03w8NtF/nsFXcSLmSPGeEWzt8/
         8ILmFj3/pJ7nkN8WdZZ0uOTCrUktNkRqYXO6nT3t+LNMU5BCubdgmqpY7YK0fnGh/V1z
         0siA==
X-Gm-Message-State: AOAM532/wn6yDdTges/LtdRBESvF0uWriyLxu6ubx+Qq8mLjnaeUddv3
        6GHyTIok9gFK49gdCfZ/Rh6IiQq8oCGajRrNy2Ni50Ls9Rc=
X-Google-Smtp-Source: ABdhPJyEI5s1a7yNyBl32JgaR9Wo9lWQXIZz393suQy5jeQSa5rxZLAEPWgNjCEk8kbvT22xWC4td4m0q83CgIR6leY=
X-Received: by 2002:a25:8c4:: with SMTP id 187mr956560ybi.369.1631143479900;
 Wed, 08 Sep 2021 16:24:39 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 16:24:28 -0700
Message-ID: <CAEf4Bza7L2NAXd9TZpmdGa9Xt=YiZmRxGJgoZx3ae9UWFdUD=w@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v0.5 release
To:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf v0.5 was just released ([0]). There are a lot of exciting new
features and APIs, so give them a try! And please report any issues
and bugs we might have missed during preparation of this release.

This is also the first official release with some of the upcoming
libbpf 1.0 features, which can be opted in through
`libbpf_set_strict_mode()` API. Please consider opting in early to
make sure your BPF applications are ready for libbpf 1.0 release and
will have a smooth transition.

Thanks a lot to all the contributors sending fixes and new features
and all the users asking and answering libbpf and BPF questions,
adopting and testing libbpf, and overall improving the BPF ecosystem!


## New features and user-space APIs:
  - `libbpf_set_strict_mode()` allowing to opt-in into backwards
incompatible libbpf-1.0 changes. See ["Libbpf: the road to
1.0"](https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0)
and ["Libbpf 1.0 migration
guide"](https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide)
for more details.
  - streamlined error reporting for low-level APIs, high-level
error-returning APIs, and pointer-returning APIs (as a libbpf-1.0
opt-in);
  - "Light" BPF skeleton support;
  - `BPF_PROG_TYPE_SYSCALL` support;
  - BPF perf link support for kprobe, uprobe, tracepoint, and
perf_event BPF programs;
  - BPF cookie support for kprobe, uprobe, tracepoint, and perf_event
BPF programs through `bpf_program__attach_[ku]probe_opts()` APIs;
  - allow to specify `ref_ctr_off` for USDT semaphores through
`bpf_program__attach_uprobe_opts()` API;
  - `btf_custom_path` support in `bpf_object_open_opts`, allowing to
specify custom BTF for CO-RE relocations;
  - `sk_reuseport/migrate` program type support;
  - `btf_dump__dump_type_data()` API, allowing to dump binary data
according to BTF type description;
  - `btf__load_into_kernel()` and `btf__load_from_kernel_by_id()`, and
split BTF variants of them;
  - `btf__load_vmlinux_btf()` and `btf__load_module_btf()` APIs;
  - `bpf_map__initial_value()` API to get initial value of mmap-ed BPF maps;
  - `bpf_map_lookup_and_delete_elem_flags()` API.


## BPF-side APIs and features:
  - support for weak typed `__ksym` externs;
  - BPF timer helpers: `bpf_timer_init()`, `bpf_timer_set_callback()`,
`bpf_timer_start()`, `bpf_timer_cancel()`;
  - `bpf_get_attach_cookie()` helper to get BPF cookie from BPF program side;
  - `bpf_get_func_ip()` helper;
  - `bpf_sys_bpf()` helper;
  - `bpf_task_pt_regs()` helper;
  - `bpf_btf_find_by_name_kind()` helper;
  - usability improvements for `bpf_tracing.h` when target
architecture is missing.


## Bug fixes and compatibility improvements:
  - improve BPF support detection on old Red Hat kernels with
backported BPF patches;
  - improvements for LTO builds with GCC 10+;
  - pass NLM_F_EXCL when creating TC qdisc;
  - better support of BPF map reuse on old kernels;
  - fix the bug resulting in sometimes closing FD 0, which wasn't
created and owned by libbpf itself.


  [0] https://github.com/libbpf/libbpf/releases/tag/v0.5.0

-- Andrii
