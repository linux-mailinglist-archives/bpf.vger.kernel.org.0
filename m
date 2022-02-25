Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0DD4C5221
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiBYXoS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiBYXoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC450DFF8
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a19-20020a25ca13000000b0061db44646b3so4945022ybg.2
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6bAxxFG63DRPuDsT0vUEAuT5W3exlbdGkZq/vGVvqig=;
        b=E9BrWa2OGvZOn/4lQfkUyV6+tRketyIgps/0nJeamTIDyWCeyWoQIMLJVmZ+pw7s+T
         78/hFwkzO/uDYI9KFSKcofsgVUpRfw2Wbzq5cqO3O9GRdt0NU/0uni1Pcr6JkmABeFK5
         zvI36i08XOc/rcrOBy3qEniufl5WJeFK8NkOmETjWN+Grdfrv1OdrvceF6TsjeEzz9VQ
         SYzmsDWyHUxPzKPfGFhQPnJ9WS5S6uM3L3I3rLYRDNJ5eo289sgVlMHx70N67PWEe822
         liO6z2LB+gmmPE5A/EsvCS/SpcnLwmD5Jgn7b1YL+4+G/h8FLh9dJqAc9g8fUeFmr6V8
         J1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6bAxxFG63DRPuDsT0vUEAuT5W3exlbdGkZq/vGVvqig=;
        b=Z/QSFU5VuKJKP587/7PVT8DxgeeMdG3xs3ibQw3S55hRXWKiliyjDhxayeOvD5SmRu
         GFMKwbNLWg75j6/zzj75sAKQnSiK+45WJ8PFBedXUapKN9jecJXgHfjRPqBV5kwQD/yf
         eKVCdZQg5yWxXBvEc6d2MOJmHQk5+sySHxML4aDQhcMh6L53oto+VA6JoVXDbDF8jBPQ
         XNGpIktEP6H8M0DT/Q+zMguixF0LsMpSJ0xMc1+xnTYxcMeRnlAOiqv5y/GXsVzpS0wO
         oxCD4Ckr3p65q+PeMYeCXZvFVkF+b7IRvSEPPn8ul3oddibSw7AllFp8yguRfPnsnibk
         xKyw==
X-Gm-Message-State: AOAM5335URXhmnCtn7wIL7M0eKP7C5XktVfhd7wInJHpATd7oT0wdEwe
        mNSdYl6B8m6bePKcCYZ7c0owV+D14rk=
X-Google-Smtp-Source: ABdhPJx3R1SmDpR/fUMtd6s2QZQ4s4svywee3HLxPhZwr9ENHWDETxP7C1YKjOe1/6C1IraUvUGRp5ACnvM=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a0d:ca86:0:b0:2d1:3fbf:b8ae with SMTP id
 m128-20020a0dca86000000b002d13fbfb8aemr10217917ywd.89.1645832623942; Fri, 25
 Feb 2022 15:43:43 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:30 -0800
Message-Id: <20220225234339.2386398-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 0/9] Extend cgroup interface with bpf
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
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

This patchset provides a bpf solution for monitoring cgroup activities
and exporting cgroup states in an organized way in bpffs. It introduces
the following features:

 1. sleepable tracepoints and sleepable tracing programs.
 2. a set of bpf helpers for creating and deleting files and
    directories in bpffs.
 3. a new iter prog, parameterizable by cgroup ids, to print cgroup
    state.

Sleepable tracepoints and tracing progs allow us to run bpf progs when
a new cgroup is created or an existing cgroup is removed. The set of
filesystem helpers allows sleepable tracing progs to set up directories
in bpffs for each cgroup. The progs can also pin and unlink bpf objects
from these bpffs directories. The new iter prog can be used to export
cgroup states. Using this set of additions, we are creating an extension
to the current cgroup interface to export per-cgroup stats.

See the selftest added in patch 09/09, test_cgroup_stats, as a full
example on how it can be done. The test develops a custom metric
measuring per-cgroup scheduling latencies and exports it via cgroup
iters, which are pinned by sleepable tracing progs attaching at cgroup
tracepoints.

Not only for per-cgroup stats, the same approach can be used for other
states such as task_vma iter and per-bpf-prog state. As an example, we
can write sleepable tracing progs to monitor task fork and exit, and let
the tracing prog to set up directories, parameterize task_vma iter and
pin the iters.

Hao Luo (9):
  bpf: Add mkdir, rmdir, unlink syscalls for prog_bpf_syscall
  bpf: Add BPF_OBJ_PIN and BPF_OBJ_GET in the bpf_sys_bpf helper
  selftests/bpf: tests mkdir, rmdir, unlink and pin in syscall
  bpf: Introduce sleepable tracepoints
  cgroup: Sleepable cgroup tracepoints.
  libbpf: Add sleepable tp_btf
  bpf: Lift permission check in __sys_bpf when called from kernel.
  bpf: Introduce cgroup iter
  selftests/bpf: Tests using sleepable tracepoints to monitor cgroup
    events

 include/linux/bpf.h                           |  16 +-
 include/linux/tracepoint-defs.h               |   1 +
 include/trace/bpf_probe.h                     |  22 +-
 include/trace/events/cgroup.h                 |  45 ++++
 include/uapi/linux/bpf.h                      |  32 +++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/cgroup_iter.c                      | 141 +++++++++++
 kernel/bpf/inode.c                            |  33 ++-
 kernel/bpf/syscall.c                          | 237 ++++++++++++++++--
 kernel/cgroup/cgroup.c                        |   5 +
 kernel/trace/bpf_trace.c                      |   5 +
 tools/include/uapi/linux/bpf.h                |  32 +++
 tools/lib/bpf/libbpf.c                        |   1 +
 .../selftests/bpf/prog_tests/syscall.c        |  67 ++++-
 .../bpf/prog_tests/test_cgroup_stats.c        | 187 ++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../selftests/bpf/progs/cgroup_monitor.c      |  78 ++++++
 .../selftests/bpf/progs/cgroup_sched_lat.c    | 232 +++++++++++++++++
 .../testing/selftests/bpf/progs/syscall_fs.c  |  69 +++++
 19 files changed, 1175 insertions(+), 37 deletions(-)
 create mode 100644 kernel/bpf/cgroup_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cgroup_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_monitor.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_sched_lat.c
 create mode 100644 tools/testing/selftests/bpf/progs/syscall_fs.c

-- 
2.35.1.574.g5d30c73bfb-goog

