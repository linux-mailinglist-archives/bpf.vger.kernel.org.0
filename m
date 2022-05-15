Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5045274F4
	for <lists+bpf@lfdr.de>; Sun, 15 May 2022 04:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiEOCfO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 May 2022 22:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiEOCfN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 May 2022 22:35:13 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326B95B7
        for <bpf@vger.kernel.org>; Sat, 14 May 2022 19:35:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o8-20020a17090a9f8800b001dc9f554c7fso6206379pjp.4
        for <bpf@vger.kernel.org>; Sat, 14 May 2022 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IU+Vi4Ob23fwiLlYzh8GDnN8SnUFyY7qicvCIYHwbGE=;
        b=oMG9OdYMWUdI4I+WvEwgmsD0xEUwkGfpPPUHciAB7L3RnbthLqYsqlu5mU4QEUXP3K
         Vwa1QKalIW2DZa0FQ9ua5g/pJo8H/Cw3YfJmFCCi5/QtFUmSnVlcyMGmYFHNjRSNZ2vS
         T4Fb9ChrCveZr4AsuzIzsOpOFJvIuBWkTOZlZ7JoL/ZT/skItTjOjIoEHL98uGIR7LVs
         gaSDgtX++wRa+31pnL3ME4QUszBq3ap2PHIJasDRsM3DdikIMbWZipsTNhPmB2O2LW1A
         tBdMCye4/b9s6BYSWSNV33QOUstdG7CJo7ra6MnMMnlmB8W8zL+zr+mS/NAxxECz5Puj
         bcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IU+Vi4Ob23fwiLlYzh8GDnN8SnUFyY7qicvCIYHwbGE=;
        b=hoxKx00wQ4Xmwe97YhnZMStQgJKnGK3AU0h7l02Ug2e8Ip6JDkw1DIw61egGf41egn
         VJBcmzZLedUrYrefDmNv5X/djec/5bsfvONBfeA2ujpYeZ3r/CNwQpnseSecFLNxTFrP
         5vbI423/K1nmXJwx7BBjvew9C3IhGB+2HjzN62eW0abSpl5IVAel1RV5bnqPmXMDq7y6
         clVoMIc6mgwrflaX91jxpNvVKcF6R6sSuQS4j3Bm5Id7z75BB9EBFLKuQIMlwL899CLI
         SQzkO3cNkAbZKJcYW9wi65j0bGTLs2kg2xsswN2MUW9SP3dHUolzkImCXTPraqqL++OJ
         B1lw==
X-Gm-Message-State: AOAM532orW50wNqJr9DqZ45E4bKi7EYiO01/Erda7Z5gzqjl+51NA8UR
        FEKp3R6sxqfxbf73090Kz52AlY0RxZnc3L97
X-Google-Smtp-Source: ABdhPJzaMCzLNX2WZCU2aLHDM5R9d54wMaYfRdNDWi1SjGhqU+OJpdMKNv8qtu3yLZztiXmhf7w+R1aT4wzWEshm
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:8d83:b0:1dd:258c:7c55 with SMTP
 id d3-20020a17090a8d8300b001dd258c7c55mr319038pjo.1.1652582111328; Sat, 14
 May 2022 19:35:11 -0700 (PDT)
Date:   Sun, 15 May 2022 02:34:57 +0000
Message-Id: <20220515023504.1823463-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH bpf-next v2 0/7] bpf: rstat: cgroup hierarchical stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series allows for using bpf to collect hierarchical cgroup
stats efficiently by integrating with the rstat framework. The rstat
framework provides an efficient way to collect cgroup stats and
propagate them through the cgroup hierarchy.

* Background on rstat (I am using a subscriber analogy that is not
commonly used):

The rstat framework maintains a tree of cgroups that have updates and
which cpus have updates. A subscriber to the rstat framework maintains
their own stats. The framework is used to tell the subscriber when
and what to flush, for the most efficient stats propagation. The
workflow is as follows:

- When a subscriber updates a cgroup on a cpu, it informs the rstat
  framework by calling cgroup_rstat_updated(cgrp, cpu).

- When a subscriber wants to read some stats for a cgroup, it asks
  the rstat framework to initiate a stats flush (propagation) by calling
  cgroup_rstat_flush(cgrp).

- When the rstat framework initiates a flush, it makes callbacks to
  subscribers to aggregate stats on cpus that have updates, and
  propagate updates to their parent.

Currently, the main subscribers to the rstat framework are cgroup
subsystems (e.g. memory, block). This patch series allow bpf programs to
become subscribers as well.

The first three patches introduce a new bpf program type, RSTAT_FLUSH,
which is a callback that rstat makes to bpf when a stats flush is
ongoing.

The fourth patch adds bpf_cgroup_rstat_updated() and
bpf_cgroup_rstat_flush() helpers, to allow bpf stat collectors and
readers to communicate with rstat.

The fifth patch is actually v2 of a previously submitted patch [1]
by Hao Luo. We agreed that it fits better as a part of this series. It
introduces cgroup_iter programs that can dump stats for cgroups to
userspace.
v1 - > v2:
- Getting the cgroup's reference at the time at attaching, instead of
  at the time when iterating. (Yonghong) (context [1])
- Remove .init_seq_private and .fini_seq_private callbacks for
  cgroup_iter. They are not needed now. (Yonghong)

The sixth patch extends bpf selftests cgroup helpers, as necessary for
the following patch.

The seventh patch is a selftest that demonstrates the entire workflow.
It includes programs that collect, aggregate, and dump per-cgroup stats
by fully integrating with the rstat framework.

[1]https://lore.kernel.org/lkml/20220225234339.2386398-9-haoluo@google.com/

RFC v1 -> RFC v2:
- Instead of rstat flush programs attach to subsystems, they now attach
  to rstat (global flushers, not per-subsystem), based on discussions
  with Tejun. The first patch is entirely rewritten.
- Pass cgroup pointers to rstat flushers instead of cgroup ids. This is
  much more flexibility and less likely to need a uapi update later.
- rstat helpers are now only defined if CGROUP_CONFIG.
- Most of the code is now only defined if CGROUP_CONFIG and
  CONFIG_BPF_SYSCALL.
- Move rstat helper protos from bpf_base_func_proto() to
  tracing_prog_func_proto().
- rstat helpers argument (cgroup pointer) is now ARG_PTR_TO_BTF_ID, not
  ARG_ANYTHING.
- Rewrote the selftest to use the cgroup helpers.
- Dropped bpf_map_lookup_percpu_elem (already added by Feng).
- Dropped patch to support cgroup v1 for cgroup_iter.
- Dropped patch to define some cgroup_put() when !CONFIG_CGROUP. The
  code that calls it is no longer compiled when !CONFIG_CGROUP.


Hao Luo (1):
  bpf: Introduce cgroup iter

Yosry Ahmed (6):
  bpf: introduce RSTAT_FLUSH program type
  cgroup: bpf: flush bpf stats on rstat flush
  libbpf: Add support for rstat flush progs
  bpf: add bpf rstat helpers
  selftests/bpf: extend cgroup helpers
  bpf: add a selftest for cgroup hierarchical stats collection

 include/linux/bpf-rstat.h                     |  31 ++
 include/linux/bpf.h                           |   4 +
 include/linux/bpf_types.h                     |   4 +
 include/uapi/linux/bpf.h                      |  33 ++
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/cgroup_iter.c                      | 148 ++++++++
 kernel/bpf/helpers.c                          |  30 ++
 kernel/bpf/rstat.c                            | 187 ++++++++++
 kernel/bpf/syscall.c                          |   6 +
 kernel/cgroup/rstat.c                         |   2 +
 kernel/trace/bpf_trace.c                      |   4 +
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |  33 ++
 tools/lib/bpf/bpf.c                           |   1 -
 tools/lib/bpf/libbpf.c                        |  40 +++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/cgroup_helpers.c  | 158 +++++---
 tools/testing/selftests/bpf/cgroup_helpers.h  |  14 +-
 .../test_cgroup_hierarchical_stats.c          | 339 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../selftests/bpf/progs/cgroup_vmscan.c       | 222 ++++++++++++
 22 files changed, 1225 insertions(+), 47 deletions(-)
 create mode 100644 include/linux/bpf-rstat.h
 create mode 100644 kernel/bpf/cgroup_iter.c
 create mode 100644 kernel/bpf/rstat.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cgroup_hierarchical_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_vmscan.c

-- 
2.36.0.550.gb090851708-goog

