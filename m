Return-Path: <bpf+bounces-12508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE8D7CD41B
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8784C281729
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603F08F71;
	Wed, 18 Oct 2023 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ifdtDxmJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF158F69
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:18:07 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429BD43
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:17:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d0a173e61so4133029a91.0
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609875; x=1698214675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WGehLvi+FTWeGkTWKP/DHbfVzwre07LJ9bBGVXupS4=;
        b=ifdtDxmJ2hvbsEOUlsNcxitO6NodJJ1mFQZweYGCky2DFCSXiyT37RzSu8xiT5nqJZ
         NqjxUg2Rgnyfc24AZSV9FE7guW66zD8A8yX4woJLonSi+CDc1e4bW/IFmqEtvDqOX2e6
         HorCDrJLaEGKWhH5pYuV0EI0Wd23fO8PU8WbUM7EIQnbRBn3Mf/gpXPS60nnK00whH8c
         FVzUnFVC7htM79kO04lcMdOC5ZJ6DNWl6y76a+9ScS+RtuDKnU6QKcrn2vWsh+tY5yj2
         Cff/11dx+fITiJF8/uZVF8HDuVmsBUist/DjyvlRXMzYMhW0XxV1YSPRCKdLjpqYOIdS
         9E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609875; x=1698214675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WGehLvi+FTWeGkTWKP/DHbfVzwre07LJ9bBGVXupS4=;
        b=nxnich+5CSHopddb2koOTIxH1dwIvaN/7+VOv+9MOncaJvIDaJX6JvIEIo2jjlIA1d
         BQCg+WUQPjsfwDUf1nd7VdAHihXggr5Hy5nCxvMPug/9UOw86cOYXbmzE8my0x6+rbUM
         cCOArZhc5LSaWbCXRLr//V7+t6x6ZFcEPDk4+5LG3W0xnHNXQFymidezz1/ycyfQz10s
         u8hUvA9oOOBS2t5xtTa76JwJ7VNqemBM5Rj7Por89ncfOb1RAPmj0Haj768mnoUiZMnh
         bpKQluxgn+sgQ7/rIX2Nxyx/dnFksrjm/89BZ7mCVNJWgykcKwb5EN8E2iQdYBIapGjL
         KnBg==
X-Gm-Message-State: AOJu0YxSrds3tc5OUd1VuAd0U6kfJ81FWEV5Zsq8mUpWZbO23lNr6DIc
	zXUht1hY/FAvDU94A5UNwJeJ65OnapHZ3Q28smQ=
X-Google-Smtp-Source: AGHT+IF9pwZQJ/oUNzQ0rStDH9whuphmOQIXCQUqfZTC6ax/a0ujVx2R67oPfE2ZDYCvAWQGxBsr1A==
X-Received: by 2002:a17:90a:ec88:b0:27d:2e39:25da with SMTP id f8-20020a17090aec8800b0027d2e3925damr4090446pjy.39.1697609875037;
        Tue, 17 Oct 2023 23:17:55 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:17:54 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 0/8] Add Open-coded task, css_task and css iters
Date: Wed, 18 Oct 2023 14:17:38 +0800
Message-Id: <20231018061746.111364-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is version 6 of task, css_task and css iters support.

--- Changelog ---

v5 -> v6:

Patch #3:
 * In bpf_iter_task_next, return pos rather than goto out. (Andrii)
Patch #2, #3, #4:
 * Add the missing __diag_ignore_all to avoid kernel build warning
Patch #5, #6, #7:
 * Add Andrii's ack

Patch #8:
 * In BPF prog iter_css_task_for_each, return -EPERM rather than 0, and
   ensure stack_mprotect() in iters.c not success. If not, it would cause
   the subsequent 'test_lsm' fail, since the 'is_stack' check in
   test_int_hook(lsm.c) would not be guaranteed.
   (https://github.com/kernel-patches/bpf/actions/runs/6489662214/job/17624665086?pr=5790)

v4 -> v5:https://lore.kernel.org/lkml/20231007124522.34834-1-zhouchuyi@bytedance.com/

Patch 3~4:
 * Relax the BUILD_BUG_ON check in bpf_iter_task_new and bpf_iter_css_new to avoid
   netdev/build_32bit CI error.
   (https://netdev.bots.linux.dev/static/nipa/790929/13412333/build_32bit/stderr)
Patch 8:
 * Initialize skel pointer to fix the LLVM-16 build CI error
   (https://github.com/kernel-patches/bpf/actions/runs/6462875618/job/17545170863)

v3 -> v4:https://lore.kernel.org/all/20230925105552.817513-1-zhouchuyi@bytedance.com/

* Address all the comments from Andrii in patch-3 ~ patch-6
* Collect Tejun's ack
* Add a extra patch to rename bpf_iter_task.c to bpf_iter_tasks.c
* Seperate three BPF program files for selftests (iters_task.c iters_css_task.c iters_css.c)

v2 -> v3:https://lore.kernel.org/lkml/20230912070149.969939-1-zhouchuyi@bytedance.com/

Patch 1 (cgroup: Prepare for using css_task_iter_*() in BPF)
  * Add tj's ack and Alexei's suggest-by.
Patch 2 (bpf: Introduce css_task open-coded iterator kfuncs)
  * Use bpf_mem_alloc/bpf_mem_free rather than kzalloc()
  * Add KF_TRUSTED_ARGS for bpf_iter_css_task_new (Alexei)
  * Move bpf_iter_css_task's definition from uapi/linux/bpf.h to
    kernel/bpf/task_iter.c and we can use it from vmlinux.h
  * Move bpf_iter_css_task_XXX's declaration from bpf_helpers.h to
    bpf_experimental.h
Patch 3 (Introduce task open coded iterator kfuncs)
  * Change th API design keep consistent with SEC("iter/task"), support
    iterating all threads(BPF_TASK_ITERATE_ALL) and threads of a
    specific task (BPF_TASK_ITERATE_THREAD).（Andrii)
  * Move bpf_iter_task's definition from uapi/linux/bpf.h to
    kernel/bpf/task_iter.c and we can use it from vmlinux.h
  * Move bpf_iter_task_XXX's declaration from bpf_helpers.h to
    bpf_experimental.h
Patch 4 (Introduce css open-coded iterator kfuncs)
  * Change th API design keep consistent with cgroup_iters, reuse
    BPF_CGROUP_ITER_DESCENDANTS_PRE/BPF_CGROUP_ITER_DESCENDANTS_POST
    /BPF_CGROUP_ITER_ANCESTORS_UP(Andrii)
  * Add KF_TRUSTED_ARGS for bpf_iter_css_new
  * Move bpf_iter_css's definition from uapi/linux/bpf.h to
    kernel/bpf/task_iter.c and we can use it from vmlinux.h
  * Move bpf_iter_css_XXX's declaration from bpf_helpers.h to
    bpf_experimental.h
Patch 5 (teach the verifier to enforce css_iter and task_iter in RCU CS)
  * Add KF flag KF_RCU_PROTECTED to maintain kfuncs which need RCU CS.(Andrii)
  * Consider STACK_ITER when using bpf_for_each_spilled_reg.
Patch 6 (Let bpf_iter_task_new accept null task ptr)
  * Add this extra patch to let bpf_iter_task_new accept a 'nullable'
  * task pointer(Andrii)
Patch 7 (selftests/bpf: Add tests for open-coded task and css iter)
  * Add failure testcase(Alexei)


Changes from v1(https://lore.kernel.org/lkml/20230827072057.1591929-1-zhouchuyi@bytedance.com/):
- Add a pre-patch to make some preparations before supporting css_task
  iters.(Alexei)
- Add an allowlist for css_task iters(Alexei)
- Let bpf progs do explicit bpf_rcu_read_lock() when using process
  iters and css_descendant iters.(Alexei)
---------------------

In some BPF usage scenarios, it will be useful to iterate the process and
css directly in the BPF program. One of the expected scenarios is
customizable OOM victim selection via BPF[1].

Inspired by Dave's task_vma iter[2], this patchset adds three types of
open-coded iterator kfuncs:

1. bpf_task_iters. It can be used to
1) iterate all process in the system, like for_each_forcess() in kernel.
2) iterate all threads in the system.
3) iterate all threads of a specific task

2. bpf_css_iters. It works like css_task_iter_{start, next, end} and would
be used to iterating tasks/threads under a css.

3. css_iters. It works like css_next_descendant_{pre, post} to iterating all
descendant css.

BPF programs can use these kfuncs directly or through bpf_for_each macro.

link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/

Chuyi Zhou (8):
  cgroup: Prepare for using css_task_iter_*() in BPF
  bpf: Introduce css_task open-coded iterator kfuncs
  bpf: Introduce task open coded iterator kfuncs
  bpf: Introduce css open-coded iterator kfuncs
  bpf: teach the verifier to enforce css_iter and task_iter in RCU CS
  bpf: Let bpf_iter_task_new accept null task ptr
  selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
  selftests/bpf: Add tests for open-coded task and css iter

 include/linux/bpf_verifier.h                  |  19 ++-
 include/linux/btf.h                           |   1 +
 include/linux/cgroup.h                        |  12 +-
 kernel/bpf/cgroup_iter.c                      |  65 ++++++++
 kernel/bpf/helpers.c                          |   9 ++
 kernel/bpf/task_iter.c                        | 151 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  86 ++++++++--
 kernel/cgroup/cgroup.c                        |  18 ++-
 .../testing/selftests/bpf/bpf_experimental.h  |  19 +++
 .../selftests/bpf/prog_tests/bpf_iter.c       |  18 +--
 .../testing/selftests/bpf/prog_tests/iters.c  | 150 +++++++++++++++++
 .../{bpf_iter_task.c => bpf_iter_tasks.c}     |   0
 tools/testing/selftests/bpf/progs/iters_css.c |  72 +++++++++
 .../selftests/bpf/progs/iters_css_task.c      |  47 ++++++
 .../testing/selftests/bpf/progs/iters_task.c  |  41 +++++
 .../selftests/bpf/progs/iters_task_failure.c  | 105 ++++++++++++
 16 files changed, 771 insertions(+), 42 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c

-- 
2.20.1


