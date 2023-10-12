Return-Path: <bpf+bounces-11987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340CD7C62EA
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 04:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3657828235D
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463137F4;
	Thu, 12 Oct 2023 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QYuUo61w"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20531362
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 02:39:14 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E4128
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 19:39:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692eed30152so396972b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 19:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697078338; x=1697683138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukFwaVuiX8KOny+uf9UCRgoHcJfgS4eWf2GBAkGs/Cc=;
        b=QYuUo61wY+J3bKCQiwID8TRYOrcVT85B/WYnEw5rLFKXUceAW0sdskIJ+2vAS6mN4p
         K6ZVoF8K8r1BOa8rSFR47ovvriLhWzR7ci1joHg6j/7TaYORDBhnwUUJx2RptIFh0/vt
         DI2ZWev/kDQSqNxnM9lSMfVZAftMoTLOece+4RBjhgNj0VfzC2MFUTxwXUtZbE2Q1tbD
         JAsia0v/hrfnGg1ILR9Uo/R/kq+HzyuoQqt+A713J5qqVR/Ob+rXbVp4j/STxVe2qvlV
         TEsQsFyOsCla5uXMSCIbkgtALoRXprbaCFS5fxwxnGSn+vd2kIqIv64gmreaus0yhOIR
         Y7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697078338; x=1697683138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukFwaVuiX8KOny+uf9UCRgoHcJfgS4eWf2GBAkGs/Cc=;
        b=LnWk6pxQSd0ccDaX0mDWxlaTOpGexnVDsmeHyQOApk6iHD9wCAZDEUe4OHszq3QK/Y
         Gu4CrDa/HfsK2GkA2mCMQsm4d0Kypggk0eHaCxcge5rcFglY+Vd0BflIEioc81hkkK44
         l2t2Fmck8wdgXB4gMINVT8AldtpNO21Q98iZ0Tbg+6QmbcKhTj4zRDp716SYBLY5whDa
         7VfcNcKmQ6r4EMyyB+ejgEFc0QgN9qtziGBOppIwIOE5xsP97QArX+5XsxUMJZ3UzB6l
         7wEQO8cMTWIU4cZvQuH01mYQRTtfmbIOemPD5w5pTUAOiNxeOU09TOK+A0P4gp4AK5nL
         x1/Q==
X-Gm-Message-State: AOJu0Yxq68cjPwvxfczVZ7ypNVv/9V6XXtZrUFzFiInlc2CEoX1rHjnd
	3zrrVTYvIxy/ZnRWuiS2skLVXLIFPLTsm2/y5HU=
X-Google-Smtp-Source: AGHT+IGFQ9TUC8JrWwEY/YNi7A6lVOBgqtfr2eoAfKgMmQrm3WbYXsK8H7bO80zTxpJ1VaSpnerdGA==
X-Received: by 2002:a05:6a20:8e0c:b0:15a:7d2:7594 with SMTP id y12-20020a056a208e0c00b0015a07d27594mr24042697pzj.11.1697078338431;
        Wed, 11 Oct 2023 19:38:58 -0700 (PDT)
Received: from [10.4.197.144] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a034800b00279479e9105sm751272pjf.2.2023.10.11.19.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 19:38:57 -0700 (PDT)
Message-ID: <b3c5fd4b-8fb6-4308-81dd-9355a675e5c7@bytedance.com>
Date: Thu, 12 Oct 2023 10:38:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 8/8] selftests/bpf: Add tests for open-coded
 task and css iter
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
 <20231011120857.251943-9-zhouchuyi@bytedance.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20231011120857.251943-9-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/10/11 20:08, Chuyi Zhou 写道:
> This patch adds three subtests to demonstrate these patterns and validating
> correctness.
> 
> subtest1:
> 
> 1) We use task_iter to iterate all process in the system and search for the
> current process with a given pid.
> 
> 2) We create some threads in current process context, and use
> BPF_TASK_ITER_PROC_THREADS to iterate all threads of current process. As
> expected, we would find all the threads of current process.
> 
> 3) We create some threads and use BPF_TASK_ITER_ALL_THREADS to iterate all
> threads in the system. As expected, we would find all the threads which was
> created.
> 
> subtest2: We create a cgroup and add the current task to the cgroup. In the
> BPF program, we would use bpf_for_each(css_task, task, css) to iterate all
> tasks under the cgroup. As expected, we would find the current process.
> 
> subtest3:
> 
> 1) We create a cgroup tree. In the BPF program, we use
> bpf_for_each(css, pos, root, XXX) to iterate all descendant under the root
> with pre and post order. As expected, we would find all descendant and the
> last iterating cgroup in post-order is root cgroup, the first iterating
> cgroup in pre-order is root cgroup.
> 
> 2) We wse BPF_CGROUP_ITER_ANCESTORS_UP to traverse the cgroup tree starting
> from leaf and root separately, and record the height. The diff of the
> hights would be the total tree-high - 1.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   .../testing/selftests/bpf/prog_tests/iters.c  | 161 ++++++++++++++++++
>   tools/testing/selftests/bpf/progs/iters_css.c |  74 ++++++++
>   .../selftests/bpf/progs/iters_css_task.c      |  42 +++++
>   .../testing/selftests/bpf/progs/iters_task.c  |  41 +++++
>   .../selftests/bpf/progs/iters_task_failure.c  | 105 ++++++++++++
>   5 files changed, 423 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_css.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_css_task.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
> index 10804ae5ae97..8d7a7bef5c73 100644
> --- a/tools/testing/selftests/bpf/prog_tests/iters.c
> +++ b/tools/testing/selftests/bpf/prog_tests/iters.c
> @@ -1,13 +1,24 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>   
> +#include <sys/syscall.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <malloc.h>
> +#include <stdlib.h>
>   #include <test_progs.h>
> +#include "cgroup_helpers.h"
>   
>   #include "iters.skel.h"
>   #include "iters_state_safety.skel.h"
>   #include "iters_looping.skel.h"
>   #include "iters_num.skel.h"
>   #include "iters_testmod_seq.skel.h"
> +#include "iters_task.skel.h"
> +#include "iters_css_task.skel.h"
> +#include "iters_css.skel.h"
> +#include "iters_task_failure.skel.h"
>   
>   static void subtest_num_iters(void)
>   {
> @@ -90,6 +101,149 @@ static void subtest_testmod_seq_iters(void)
>   	iters_testmod_seq__destroy(skel);
>   }
>   
> +static pthread_mutex_t do_nothing_mutex;
> +
> +static void *do_nothing_wait(void *arg)
> +{
> +	pthread_mutex_lock(&do_nothing_mutex);
> +	pthread_mutex_unlock(&do_nothing_mutex);
> +
> +	pthread_exit(arg);
> +}
> +
> +#define thread_num 2
> +
> +static void subtest_task_iters(void)
> +{
> +	struct iters_task *skel = NULL;
> +	pthread_t thread_ids[thread_num];
> +	void *ret;
> +	int err;
> +
> +	skel = iters_task__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +	err = iters_task__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +	skel->bss->target_pid = getpid();
> +	err = iters_task__attach(skel);
> +	if (!ASSERT_OK(err, "iters_task__attach"))
> +		goto cleanup;
> +	pthread_mutex_lock(&do_nothing_mutex);
> +	for (int i = 0; i < thread_num; i++)
> +		ASSERT_OK(pthread_create(&thread_ids[i], NULL, &do_nothing_wait, NULL),
> +			"pthread_create");
> +
> +	syscall(SYS_getpgid);
> +	iters_task__detach(skel);
> +	ASSERT_EQ(skel->bss->process_cnt, 1, "process_cnt");
> +	ASSERT_EQ(skel->bss->thread_cnt, thread_num + 1, "thread_cnt");
> +	ASSERT_EQ(skel->bss->all_thread_cnt, thread_num + 1, "all_thread_cnt");
> +	pthread_mutex_unlock(&do_nothing_mutex);
> +	for (int i = 0; i < thread_num; i++)
> +		pthread_join(thread_ids[i], &ret);
> +cleanup:
> +	iters_task__destroy(skel);
> +}
> +
> +extern int stack_mprotect(void);
> +
> +static void subtest_css_task_iters(void)
> +{
> +	struct iters_css_task *skel = NULL;
> +	int err, cg_fd, cg_id;
> +	const char *cgrp_path = "/cg1";
> +
> +	err = setup_cgroup_environment();
> +	if (!ASSERT_OK(err, "setup_cgroup_environment"))
> +		goto cleanup;
> +	cg_fd = create_and_get_cgroup(cgrp_path);
> +	if (!ASSERT_GE(cg_fd, 0, "cg_create"))
> +		goto cleanup;
> +	cg_id = get_cgroup_id(cgrp_path);
> +	err = join_cgroup(cgrp_path);
> +	if (!ASSERT_OK(err, "setup_cgroup_environment"))
> +		goto cleanup;
> +
> +	skel = iters_css_task__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	err = iters_css_task__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	skel->bss->target_pid = getpid();
> +	skel->bss->cg_id = cg_id;
> +	err = iters_css_task__attach(skel);
> +
> +	err = stack_mprotect();
> +	if (!ASSERT_OK(err, "iters_task__attach"))
> +		goto cleanup;

The is incorrect and would fail the lsm_test in prog_test.

Here we should check the stack_mprotect return value is -1 or
-EPERM. In BPF Prog iter_css_task_for_each, we need to return -EPERM.

The whole logic should keep same with lsm_test.c/bpf_cookie.c

After the following fix, CI would works well.

(https://github.com/kernel-patches/bpf/actions/runs/6484774470/job/17609349165?pr=5808)

@@ -177,11 +177,12 @@ static void subtest_css_task_iters(void)
         skel->bss->target_pid = getpid();
         skel->bss->cg_id = cg_id;
         err = iters_css_task__attach(skel);
-
-       err = stack_mprotect();
         if (!ASSERT_OK(err, "iters_task__attach"))
                 goto cleanup;
-
+       err = stack_mprotect();
+       if (!ASSERT_EQ(err, -1, "stack_mprotect") ||
+           !ASSERT_EQ(errno, EPERM, "stack_mprotect"))
+               goto cleanup;
         iters_css_task__detach(skel);
         ASSERT_EQ(skel->bss->css_task_cnt, 1, "css_task_cnt");

diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c 
b/tools/testing/selftests/bpf/progs/iters_css_task.c
index 506a2755234e..9f79a57fde8e 100644
--- a/tools/testing/selftests/bpf/progs/iters_css_task.c
+++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
@@ -2,6 +2,7 @@
  /* Copyright (C) 2023 Chuyi Zhou <zhouchuyi@bytedance.com> */

  #include "vmlinux.h"
+#include <errno.h>
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_tracing.h>
  #include "bpf_misc.h"
@@ -17,7 +18,8 @@ int css_task_cnt = 0;
  u64 cg_id;

  SEC("lsm/file_mprotect")
-int BPF_PROG(iter_css_task_for_each)
+int BPF_PROG(iter_css_task_for_each, struct vm_area_struct *vma,
+           unsigned long reqprot, unsigned long prot, int ret)
  {
         struct task_struct *cur_task = bpf_get_current_task_btf();
         struct cgroup_subsys_state *css;
@@ -25,12 +27,12 @@ int BPF_PROG(iter_css_task_for_each)
         struct cgroup *cgrp;

         if (cur_task->pid != target_pid)
-               return 0;
+               return ret;

         cgrp = bpf_cgroup_from_id(cg_id);

-       if (cgrp == NULL)
-               return 0;
+       if (!cgrp)
+               goto out;
         css = &cgrp->self;

         bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS)
@@ -38,5 +40,6 @@ int BPF_PROG(iter_css_task_for_each)
                         css_task_cnt += 1;

         bpf_cgroup_release(cgrp);
-       return 0;
+out:
+       return -EPERM;
  }


