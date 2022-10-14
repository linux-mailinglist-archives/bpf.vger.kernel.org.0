Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE45FF464
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJNUP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiJNUPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 16:15:07 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07472F39E;
        Fri, 14 Oct 2022 13:15:00 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id z18so3941619qvn.6;
        Fri, 14 Oct 2022 13:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPMxAoolUKUZpMFf0g5q1NnQIG6EvSAKe+JJbcK/7Z8=;
        b=e1XaPGiGlGRUnV5FY547aw7fQNsjiSbqdw7HivThWcaX03L+wA0hEw+2LK/+8xtxnX
         uQNu3980ji+s4CZpy6tijaspdMH0pSJ/bG/txAA7hnFTwlBtimkNKFZ0g0UDoqEZ+p1C
         iJmMb2xvTqQ0b4z1Q4zmk8p/PvmqrBjo80kYyD/t8g4w+rE1x3f04PLSlMs7x8a6guvz
         t09HGLobiQ5bL2hmtD+WirJnWh87zw+UvtcA6HMmIu+rXSy7wKKR+uxNUHSkBzND+hUt
         7EU4rbbbwHgy4WTcfxd+NzKRalIegBptUhdqoo1j7FjsjRga/ghILtPr7TubmoV7D5mY
         lhHg==
X-Gm-Message-State: ACrzQf3KsathmnsaV0pp/L6J3Wsj5bA0sPPSv/PtJHqlh6LiV6e/EFos
        RTX9FMapkvwVN4Km8dF/nKlFitWlX8fC7w==
X-Google-Smtp-Source: AMsMyM6Wm/pUbZhtwR4a9PtrwKInPgqki5i7r7d8Qu4wc14QwIm7Q/2Z136MC7GRkkhhJYRV9TuB3w==
X-Received: by 2002:a05:6214:3017:b0:4b1:bfdc:d4c1 with SMTP id ke23-20020a056214301700b004b1bfdcd4c1mr5429379qvb.42.1665778499589;
        Fri, 14 Oct 2022 13:14:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b61b2cb1d2sm3297124qkp.46.2022.10.14.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:14:59 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH v3 0/3] Support storing struct task_struct objects as kptrs
Date:   Fri, 14 Oct 2022 15:14:24 -0500
Message-Id: <20221014201427.2435461-1-void@manifault.com>
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
  bpf: Add kfuncs for storing struct task_struct * as a kptr
  bpf/selftests: Add selftests for new task kfuncs

 include/linux/bpf.h                           |   6 +
 kernel/bpf/btf.c                              |  11 +-
 kernel/bpf/helpers.c                          |  86 ++++-
 kernel/bpf/verifier.c                         |  15 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     | 160 +++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  83 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 315 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 132 ++++++++
 tools/testing/selftests/bpf/verifier/calls.c  |   4 +-
 10 files changed, 804 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

-- 
2.38.0

