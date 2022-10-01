Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82205F1CEE
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJAOrY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Oct 2022 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJAOrX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Oct 2022 10:47:23 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFE876444;
        Sat,  1 Oct 2022 07:47:21 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id i12so4577975qvs.2;
        Sat, 01 Oct 2022 07:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xOHhqkEX8GkjEzhBZhVsybXwl18+zuU+bDpSzWeRWr0=;
        b=ArksnCTsHZaQefFNFhUqsuxxVVWv5s55xMOeAHkpRDs+axHjilUEz0rJh3G11j1S3C
         EnHgd5S90pE6xEVVwNp1rwnplITH+iG+Oc8uIGuU83WY+2JnwKFjptK4D3Y6InDPtNVV
         x/tYV+EuVTmFQoulx6k2YBbKdBdpejxJmM41BDIt/mP115wpfpFx+GvraqMka3zpvgRR
         +nMDWFcmOxwnAIGkR28r1A3SxenT6OJdGXPkmSFSJOSWGNrcZjZAgvLtx5rhUNOt5/zT
         EF25jg2UMQQHSBiYQim/0N4YVIwpy23vF3Tl6qa1ocabjBdrOZT37/ypacHG3+FSmAhG
         nF0g==
X-Gm-Message-State: ACrzQf1bInztsi2MSTkbCqXXF9nTGfuplt4RbV+qreG1o9MaTdHpTdG7
        s3BDYKgN3ZEk4EJcy5bxVvk=
X-Google-Smtp-Source: AMsMyM7Yig87+0LDZI14XiV0LC/heKArthWzFdcrtl2nH8xQrgV9XWyEG9qkalYIlGDx5pz8KxOtag==
X-Received: by 2002:a05:6214:246f:b0:4ac:a1f8:4c9b with SMTP id im15-20020a056214246f00b004aca1f84c9bmr10875044qvb.18.1664635640784;
        Sat, 01 Oct 2022 07:47:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::dcb2])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006cec8001bf4sm6490232qkn.26.2022.10.01.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:47:20 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev
Cc:     kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        memxor@gmail.com
Subject: [PATCH v2 0/2] Support storing struct task_struct objects as kptrs
Date:   Sat,  1 Oct 2022 09:47:14 -0500
Message-Id: <20221001144716.3403120-1-void@manifault.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that BPF supports adding new kernel functions with kfuncs, and storing
kernel objects in maps with kptrs, we can add a set of kfuncs which allow
struct task_struct objects to be stored in maps as referenced kptrs.

The possible use-cases for doing this are plentiful.  During tracing,
for example, it would be useful to be able to collect some tasks that
performed a certain operation, and then periodically summarize who they
are, which cgroup they're in, how much CPU time they've spent, etc.
Doing this now would require storing the task's pids along with some
relevant data to be exported to user space, and later associating the
pids to tasks in other event handlers where the data is recorded.
Another useful by-product of this is that it allows a program to pin a
task, and by proxy therefore also pin its task local storage.

This patch set adds this aforementioned set of kfuncs, along with a new
selftest suite for validation.

Signed-off-by: David Vernet <void@manifault.com>
---
v1 -> v2:
- Rename tracing_btf_ids to generic_kfunc_btf_ids, and add the new
  kfuncs to that list instead of making a separate btf id list (Alexei).
- Don't run the new selftest suite on s390x, which doesn't appear to
  support invoking kfuncs.
- Add a missing __diag_ignore block for -Wmissing-prototypes
  (lkp@intel.com).
- Fix formatting on some of the SPDX-License-Identifier tags.
- Clarified the function header comment a bit on bpf_task_kptr_get().

David Vernet (2):
  bpf: Add kfuncs for storing struct task_struct * as a kptr
  bpf/selftests: Add selftests for new task kfuncs

 kernel/bpf/helpers.c                          |  83 ++++++-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/task_kfunc.c     | 155 ++++++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  83 +++++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 225 ++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 113 +++++++++
 6 files changed, 655 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_kfunc_success.c

-- 
2.37.3

