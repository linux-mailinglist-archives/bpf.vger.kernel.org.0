Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0B43546F
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 22:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTUTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJTUTG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 16:19:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1854CC06161C;
        Wed, 20 Oct 2021 13:16:52 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m21so23484125pgu.13;
        Wed, 20 Oct 2021 13:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Qep4jU4rGfaGWhq0LfkXrPTSxqEwdeHLhOkIRnswTKw=;
        b=gvAFXm+kUmrZgm9Zk5gQOuUiqZicVA7K56bWg91F2DMPu/miowM0kYQmu1nfvyKbEH
         cKh+GC+Z+Eo5b4UtI7nRGtNIAKaSgeYqJHJLEpM6fj2l6CZQ3/td0r+N/IT9ZrNsRZYs
         OgBx8IkWC6HHtxkDj7L2soV4u1GrRhKfMDZDfh3kXcvgYVZnykYSpZLYnlBhhiU8/r7E
         kxuvSfKtkI7wT4HBWx8mblHL7s6t5J7wEc0+Ce7ehhzSyZggN6yjR0sgVBmLPVHawm49
         R1+0+HVj7q5TKsRc5fm05Xw1/Rl/dWY0FJNe8znCv0Ib9q+rl7pNRyF1pmog91oMxLum
         7Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Qep4jU4rGfaGWhq0LfkXrPTSxqEwdeHLhOkIRnswTKw=;
        b=29JBKr+9fGXkfO/2K7Q1jIXbEv0OmXWZNc21tEV3NVSoPcCYACUa9a4znSUhxmTYfy
         btemZNHDYYfyx/9fgfIMA98QwIIge4VAfhk2RnCUFPEPTXAmb/WUgOpUz1RGSAP7jKd8
         8Pwubd6qQ5qy0DkGYXl57KUSOFbnEBrpeMlruWYbKGrTjOgVE18rzUQ8uo+ne2fpzU77
         a53J0ZChAgrMN9JUrq7LDl3WbnxFrRQTa9aWSLK7wCZkP/kN1ll23jd7LnpyC7DAxGaJ
         iWrDLEZcFXggM8xriK8Ms14hQgXtXQbEnQ+9V9e/LmUv8JRU3zY3bIUYZ1gmf3yRZrxa
         GTig==
X-Gm-Message-State: AOAM533VMEkiIHUagfTIgpz8cAoAb24CRGRFaLv4efFToh9xE9APOFBM
        IQXQ1x1SPTTKavDzSWYaGJ8=
X-Google-Smtp-Source: ABdhPJwu+k7qLEG3bLxdcPPPTjHAgxpsaA43HRqp6K1UyMfq1Ke+7YwzqDTs/8r3h5N41w2S1RURxA==
X-Received: by 2002:a62:7b43:0:b0:44c:6d72:ac4d with SMTP id w64-20020a627b43000000b0044c6d72ac4dmr1095173pfc.73.1634761011423;
        Wed, 20 Oct 2021 13:16:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s7sm3496476pfu.139.2021.10.20.13.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:16:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Oct 2021 10:16:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     bpf@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [RFC] bpf: Implement prealloc for task_local_storage
Message-ID: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

task_local_storage currently does not support pre-allocation and the memory
is allocated on demand using the GFP_ATOMIC mask. While atomic allocations
succeed most of the time and the occasional failures aren't a problem for
many use-cases, there are some which can benefit from reliable allocations -
e.g. tracking acquisitions and releases of specific resources to root cause
long-term reference leaks.

This patchset implements prealloc support for task_local_storage so that
once a map is created, it's guaranteed that the storage area is always
available for all tasks unless explicitly deleted.

The only tricky part is syncronizing against the fork path. Fortunately,
cgroup needs to do the same thing and is already using
cgroup_threadgroup_rwsem and we can use the same mechanism without adding
extra overhead. This patchset generalizes the rwsem and make cgroup and bpf
select it.

This patchset is on top of bpf-next 223f903e9c83 ("bpf: Rename BTF_KIND_TAG
to BTF_KIND_DECL_TAG") and contains the following patches:

 0001-cgroup-Drop-cgroup_-prefix-from-cgroup_threadgroup_r.patch
 0002-sched-cgroup-Generalize-threadgroup_rwsem.patch
 0003-bpf-Implement-prealloc-for-task_local_storage.patch

and also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git bpf-task-local-storage-prealloc

diffstat follows. Thanks.

 fs/exec.c                                                   |    7 +
 include/linux/bpf.h                                         |    6 +
 include/linux/bpf_local_storage.h                           |   12 +++
 include/linux/cgroup-defs.h                                 |   33 ---------
 include/linux/cgroup.h                                      |   11 +--
 include/linux/sched/threadgroup_rwsem.h                     |   46 ++++++++++++
 init/Kconfig                                                |    4 +
 kernel/bpf/Kconfig                                          |    1 
 kernel/bpf/bpf_local_storage.c                              |  112 ++++++++++++++++++++++--------
 kernel/bpf/bpf_task_storage.c                               |  138 +++++++++++++++++++++++++++++++++++++-
 kernel/cgroup/cgroup-internal.h                             |    4 -
 kernel/cgroup/cgroup-v1.c                                   |    9 +-
 kernel/cgroup/cgroup.c                                      |   74 ++++++++++++--------
 kernel/cgroup/pids.c                                        |    2 
 kernel/fork.c                                               |   16 ++++
 kernel/sched/core.c                                         |    4 +
 kernel/sched/sched.h                                        |    1 
 kernel/signal.c                                             |    7 +
 tools/testing/selftests/bpf/prog_tests/task_local_storage.c |  101 +++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/task_ls_prealloc.c        |   15 ++++
 20 files changed, 489 insertions(+), 114 deletions(-)

--
tejun

