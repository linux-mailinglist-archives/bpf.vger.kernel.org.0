Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF8546D6A
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349599AbiFJTop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347086AbiFJToo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 15:44:44 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FA369D1
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:44:41 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h10-20020a170902f54a00b00166449db7f8so33823plf.9
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=i6zkq+SbTrXADRy8+ig+1J4qQLsOeKLI1rJct5wsC9M=;
        b=oENthMDx1DemDENCKb7+vR7A7KrZ7ow+cOkqgpT6ERoa9Z51W1sj50TrJ8NjWW1e7P
         WmwmpRLa7IBRpvSKKK3KUypFHi2UYXbl0mXpkeIz92R+yq1Fz7WLAs1pikLdRUzShb7K
         praWX/XjS3A+mYEZwW48swWq4dZ3WOkvu4+a3TCJCw7VCvhFP7xbEM458N5UQU23aDfK
         kWthEGQRt9h8V/8C+thO62LIRmy3vTEFjdRiW0h8/xgNU3DX5oa+r2NIvHypB0cPOhAb
         JymCgAsdgRzr4Dp5NWTjkV0Q13YtYxhwnRKyqajWXITueq4CrMS5Sc/KVlolYNq8nplF
         QVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=i6zkq+SbTrXADRy8+ig+1J4qQLsOeKLI1rJct5wsC9M=;
        b=E9DYIbV40OsEWkmgRQd4IEZetggiisyldPETq5Mfk6Rkme7Yi5s7gWP20Wns6Z2x/V
         l3/LMdlIneMmg4JcEiZq2ZmqHZ2gfyalr275Su3IWga8PgGb8PoEnhMyRInGSjT5NGHn
         7L96u30ihgPA46McSRVW/4wCOnSEhCShHFeBSXgzW6U/1xeaXfbhx8xqZqO5w1wM/Dcc
         qFJJvre7ll94TsSA2F3v4Oih7JANBfwhMFzj+p1jta8fZ7dZWuQFURQHVbVykgATZPqp
         WYuSjNI3gV3g5yRtTNFRKc8n7Uc0wfJZjJucgVEhWjCOWjkRyeo5qnsiPmmUaFWS+Z1B
         u87Q==
X-Gm-Message-State: AOAM530HjF4KD8maAQIBQj43K08vaz8qD10ek7d6QE+nV/6fkX0CSYmE
        UFkop/xU1OqgnYTxm3/YC20wcGHF/PWCoFeF
X-Google-Smtp-Source: ABdhPJxtdO6pRShCr96FVJhsqRyi3L1gIlwPDweIzWvz3ftA8aV64mUawP4Nqp2M5P34aQSrYCK2YEWR/tPv4pIU
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2341:b0:51c:6413:ab2e with
 SMTP id j1-20020a056a00234100b0051c6413ab2emr16265298pfj.63.1654890281125;
 Fri, 10 Jun 2022 12:44:41 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:44:27 +0000
Message-Id: <20220610194435.2268290-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH bpf-next v2 0/8] bpf: rstat: cgroup hierarchical stats
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
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series allows for using bpf to collect hierarchical cgroup
stats efficiently by integrating with the rstat framework. The rstat
framework provides an efficient way to collect cgroup stats percpu and
propagate them through the cgroup hierarchy.

The stats are exposed to userspace in textual form by reading files in
bpffs, similar to cgroupfs stats by using a cgroup_iter program.
cgroup_iter is a type of bpf_iter. It walks over cgroups in two modes:

 - walking a cgroup's descendants.
 - walking a cgroup's ancestors.

When attaching cgroup_iter, one needs to set a cgroup to the iter_link
created from attaching. This cgroup is passed as a file descriptor and
serves as the starting point of the walk.

For walking descendants, one can specify the order: either pre-order or
post-order. For walking ancestors, the walk starts at the specified
cgroup and ends at the root.

One can also terminate the walk early by returning 1 from the iter
program.

Note that because walking cgroup hierarchy holds cgroup_mutex, the iter
program is called with cgroup_mutex held.

** Background on rstat for stats collection **
(I am using a subscriber analogy that is not commonly used)

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

Patches in this series are based off a patch in the mailing
list which adds a new kfunc set for sleepable functions:
"btf: Add a new kfunc set which allows to mark a function to be
sleepable" [1].

Patches in this series are organized as follows:
* Patch 1 enables the use of cgroup_get_from_file() in cgroup1.
  This is useful because it enables cgroup_iter to work with cgroup1, and
  allows the entire stat collection workflow to be cgroup1-compatible.
* Patches 2-5 introduce cgroup_iter prog, and a selftest.
* Patches 6-8 allow bpf programs to integrate with rstat by adding the
  necessary hook points and kfunc. A comprehensive selftest that
  demonstrates the entire workflow for using bpf and rstat to
  efficiently collect and output cgroup stats is added.

v1 -> v2:
- Redesign of cgroup_iter from v1, based on Alexei's idea [2]:
  - supports walking cgroup subtree.
  - supports walking ancestors of a cgroup. (Andrii)
  - supports terminating the walk early.
  - uses fd instead of cgroup_id as parameter for iter_link. Using fd is
    a convention in bpf.
  - gets cgroup's ref at attach time and deref at detach.
  - brought back cgroup1 support for cgroup_iter.
- Squashed the patches adding the rstat flush hook points and kfuncs
  (Tejun).
- Added a comment explaining why bpf_rstat_flush() needs to be weak
  (Tejun).
- Updated the final selftest with the new cgroup_iter design.
- Changed CHECKs in the selftest with ASSERTs (Yonghong, Andrii).
- Removed empty line at the end of the selftest (Yonghong).
- Renamed test files to cgroup_hierarchical_stats.c.
- Reordered CGROUP_PATH params order to match struct declaration
  in the selftest (Michal).
- Removed memory_subsys_enabled() and made sure memcg controller
  enablement checks make sense and are documented (Michal).

RFC v2 -> v1:
- Instead of introducing a new program type for rstat flushing, add an
  empty hook point, bpf_rstat_flush(), and use fentry bpf programs to
  attach to it and flush bpf stats.
- Instead of using helpers, use kfuncs for rstat functions.
- These changes simplify the patchset greatly, with minimal changes to
  uapi.

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

cgroup_iter was originally introduced in a different patch series[3].
Hao and I agreed that it fits better as part of this series.
RFC v1 of this patch series had the following changes from [3]:
- Getting the cgroup's reference at the time at attaching, instead of
  at the time when iterating. (Yonghong)
- Remove .init_seq_private and .fini_seq_private callbacks for
  cgroup_iter. They are not needed now. (Yonghong)

[1] https://lore.kernel.org/bpf/20220421140740.459558-5-benjamin.tissoires@redhat.com/
[2] https://lore.kernel.org/bpf/20220520221919.jnqgv52k4ajlgzcl@MBP-98dd607d3435.dhcp.thefacebook.com/
[3] https://lore.kernel.org/lkml/20220225234339.2386398-9-haoluo@google.com/

Hao Luo (4):
  cgroup: Add cgroup_put() in !CONFIG_CGROUPS case
  bpf, iter: Fix the condition on p when calling stop.
  bpf: Introduce cgroup iter
  selftests/bpf: Test cgroup_iter.

Yosry Ahmed (4):
  cgroup: enable cgroup_get_from_file() on cgroup1
  cgroup: bpf: enable bpf programs to integrate with rstat
  selftests/bpf: extend cgroup helpers
  bpf: add a selftest for cgroup hierarchical stats collection

 include/linux/bpf.h                           |   8 +
 include/linux/cgroup.h                        |   3 +
 include/uapi/linux/bpf.h                      |  21 ++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_iter.c                         |   5 +
 kernel/bpf/cgroup_iter.c                      | 235 ++++++++++++
 kernel/cgroup/cgroup.c                        |   5 -
 kernel/cgroup/rstat.c                         |  46 +++
 tools/include/uapi/linux/bpf.h                |  21 ++
 tools/testing/selftests/bpf/cgroup_helpers.c  | 173 +++++++--
 tools/testing/selftests/bpf/cgroup_helpers.h  |  15 +-
 .../prog_tests/cgroup_hierarchical_stats.c    | 351 ++++++++++++++++++
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 190 ++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../bpf/progs/cgroup_hierarchical_stats.c     | 234 ++++++++++++
 .../testing/selftests/bpf/progs/cgroup_iter.c |  39 ++
 16 files changed, 1303 insertions(+), 52 deletions(-)
 create mode 100644 kernel/bpf/cgroup_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter.c

-- 
2.36.1.476.g0c4daa206d-goog

