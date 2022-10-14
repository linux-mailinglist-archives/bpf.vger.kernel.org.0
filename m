Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696575FF48B
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiJNU3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 16:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiJNU3X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 16:29:23 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712765D702;
        Fri, 14 Oct 2022 13:29:22 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id a5so3237016qkl.6;
        Fri, 14 Oct 2022 13:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PW8mHRQgVN29JVQfa80ZbsvQpYu3G3VerTPmn74QPd8=;
        b=am7tH3CzjQIU8nlbO6zX5a6dn9UsrO1EhiSpqqcMm4k0HO0x19k4cHQcp3fJwhekwh
         ul5qF5Zp2/8VgHoBt+FfXrMXl1EvYixZZG6a8R+Pd1eceWSYXqhiINlFq3YhF36qAbxA
         D1kqvbNAzFoZRBBE23h1Lqds1w/k1t5R+vnte6lg9CWayy390jy9Jra54jRu7sGJUJfD
         rbOGJccRM2kncRaBntvXgLTZ6mA4PZ6EcRmekCyIOZlEiCqB0ji6N1q5W7HcJRkD4MnQ
         nMSgnpb2YNMv2bO/zfEG0K5NuWX8aAY4Anxgy07iu6mLt0K0LWhIUH8iYKlalSkXubI5
         LWWg==
X-Gm-Message-State: ACrzQf0Nuhs6r1E83JcTK/9KDR8Hx8oU1sjUNMn4ARABCwoeKUoW9GOk
        ycHKPu+dqZ0ZympNo+cvn3yw6cGGuMM6uA==
X-Google-Smtp-Source: AMsMyM5PqHNYFKAGr6RW0sfqyImz7BJPkZWiSzFD69jAoB/wKI4YmRgcNGMOyoR1YMCQtg69TKSD2w==
X-Received: by 2002:ae9:c318:0:b0:6ee:245a:a4d8 with SMTP id n24-20020ae9c318000000b006ee245aa4d8mr5180091qkg.346.1665779361325;
        Fri, 14 Oct 2022 13:29:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id u8-20020a37ab08000000b006cbc6e1478csm3047832qke.57.2022.10.14.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:29:21 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH v4 0/3] Support storing struct task_struct objects as kptrs
Date:   Fri, 14 Oct 2022 15:28:49 -0500
Message-Id: <20221014202852.2491657-1-void@manifault.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TVD_PH_BODY_ACCOUNTS_PRE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that BPF supports adding new kernel functions with kfuncs, and storing
kernel objects in maps with kptrs, we can add a set of kfuncs which allow
struct task_struct objects to be stored in maps as referenced kptrs.

The possible use cases for doing this are plentiful.  During tracing,
for example, it would be useful to be able to collect some tasks that
performed a certain operation, and then periodically summarize who they
are, which cgroup they're in, how much CPU time they've utilized, etc.
Doing this now would require storing the task's pids along with some
relevant data to be exported to user space, and later associating the
pids to tasks in other event handlers where the data is recorded.
Another useful by-product of this is that it allows a program to pin a
task in a BPF program, and by proxy therefore also e.g. pin its task
local storage.

In order to support this, we'll need to expand KF_TRUSTED_ARGS to
support receiving trusted, non-refcounted pointers. It currently only
supports either PTR_TO_CTX pointers, or refcounted pointers . What this
means in terms of implementation is that btf_check_func_arg_match()
would have to add another condition to its logic for checking if
a ptr needs a refcount to also require that the pointer has at least one
type modifier, such as PTR_UNTRUSTED. PTR_UNTRUSTED does not cover all
of the possible pointers we need to watch out for, though. For example,
a pointer obtained from walking a struct is considered "trusted" (or at
least, not PTR_UNTRUSTED). To account for this and enable us to expand
KF_TRUSTED_ARGS, this patch set also introduces a new PTR_NESTED type
flag modifier which records if a pointer was obtained from walking a
struct.

This patch set adds this new PTR_NESTED type flag, expands
KF_TRUSTED_ARGS accordingly, adds the new set of kfuncs mentioned above,
and then finally adds a new selftest suite to validate all of this new
behavior.

David Vernet (3):
  bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
  Now that BPF supports adding new kernel functions with kfuncs, and
    storing kernel objects in maps with kptrs, we can add a set of
    kfuncs which allow struct task_struct objects to be stored in maps
    as referenced kptrs. The possible use cases for doing this are
    plentiful. During tracing, for example, it would be useful to be
    able to collect some tasks that performed a certain operation, and
    then periodically summarize who they are, which cgroup they're in,
    how much CPU time they've utilized, etc.
  bpf/selftests: Add selftests for new task kfuncs

 include/linux/bpf.h                           |   6 +
 kernel/bpf/btf.c                              |  11 +-
 kernel/bpf/helpers.c                          |  86 ++++-
 kernel/bpf/verifier.c                         |  12 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     | 160 +++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  83 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 315 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 132 ++++++++
 tools/testing/selftests/bpf/verifier/calls.c  |   4 +-
 10 files changed, 801 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

-- 
2.38.0

