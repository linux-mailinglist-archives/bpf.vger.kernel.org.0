Return-Path: <bpf+bounces-12514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5A7CD43B
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD745B210A1
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 06:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984E28F76;
	Wed, 18 Oct 2023 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="go/gNRkW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4908F77
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:18:54 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6826119B6
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:18:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf55a81eeaso44227325ad.0
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609897; x=1698214697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8WV2XVvAQuJkK59o/8tW8GBGlk0HThG8biP3YZXvQU=;
        b=go/gNRkWlhHnC98EH3YpacP/SzqFJYjjIcR7IYtChqHS9L4DX0P7rR+L7BKli7ikYt
         QEZYYswE6H8n7yNSd8JRsbpsjeME2PtDKGHY1s33h9WtmzThwOxj0FCKLJNZzqrxOFkZ
         3yeXRsqoiGz1B4tL8+EwZI/nNM2d/ScohstdCrgWmMC3XpKf/bqd5XKQT0psBroooFcS
         AG9YUm8/3SXWBGYY2t5/y+OZnh8ie2YTRue8j9P+w0lfbUm9gIv0zhrPrN6zmWwk4dYh
         Pk2Wx8bNaI0AMP9cSoDhDWTctkd4yU6HR1HesjQknGQ6Hy9lBiCHkSjOxOCQ92B6168C
         MGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609897; x=1698214697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8WV2XVvAQuJkK59o/8tW8GBGlk0HThG8biP3YZXvQU=;
        b=djWe2eRiyK3ttHuXH5pO79pv3sxNwkCVKy1dK+Y/G+EJaTu50XxDgSIhljbXDro5f5
         vVdgXEJCMRGwfCvBPdbupS5QoihDZYVad1GzJawZudhE4ugNEA8Qmy9WnlVD2U715KZB
         94waRbFrPDkfL/NBBAymyklm4D8rJbjizqq2vT0Qn2+IjSTsMP+BW16xKidi1kRfRb79
         EB6jGYlaqfWX/rET48JLzO5Mvi7oBxhkZKv05UYV8cjhPjHAw2S3j6BFoSv4OZZfuKNN
         w0sajSrVw0GoPqILR3QsrgL99HozPa/5yFdakqeaG2BS3g0vmhQ+awvfD6c2Va3puKwV
         g0IA==
X-Gm-Message-State: AOJu0YwyZ1OeouhXqwXGgvZi35MwdVApcHkKTzjiKBJYxHAKIweQU+kH
	rWm+gMtF5MA9CJRFELWh6AFDZsIswUi6sMG9tzAHtw==
X-Google-Smtp-Source: AGHT+IED3OurEtw0LiTgaNLzkIKcCTH0nRKrEwXkzzhEeE8B3ReEVKh5f1Oeij2KGfRj7sNu3FxcRg==
X-Received: by 2002:a17:902:c40a:b0:1c3:a4f2:7c92 with SMTP id k10-20020a170902c40a00b001c3a4f27c92mr5260298plk.65.1697609897359;
        Tue, 17 Oct 2023 23:18:17 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:18:17 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 8/8] selftests/bpf: Add tests for open-coded task and css iter
Date: Wed, 18 Oct 2023 14:17:46 +0800
Message-Id: <20231018061746.111364-9-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds 4 subtests to demonstrate these patterns and validating
correctness.

subtest1:

1) We use task_iter to iterate all process in the system and search for the
current process with a given pid.

2) We create some threads in current process context, and use
BPF_TASK_ITER_PROC_THREADS to iterate all threads of current process. As
expected, we would find all the threads of current process.

3) We create some threads and use BPF_TASK_ITER_ALL_THREADS to iterate all
threads in the system. As expected, we would find all the threads which was
created.

subtest2:

We create a cgroup and add the current task to the cgroup. In the
BPF program, we would use bpf_for_each(css_task, task, css) to iterate all
tasks under the cgroup. As expected, we would find the current process.

subtest3:

1) We create a cgroup tree. In the BPF program, we use
bpf_for_each(css, pos, root, XXX) to iterate all descendant under the root
with pre and post order. As expected, we would find all descendant and the
last iterating cgroup in post-order is root cgroup, the first iterating
cgroup in pre-order is root cgroup.

2) We wse BPF_CGROUP_ITER_ANCESTORS_UP to traverse the cgroup tree starting
from leaf and root separately, and record the height. The diff of the
hights would be the total tree-high - 1.

subtest4:

Add some failure testcase when using css_task, task and css iters, e.g,
unlock when using task-iters to iterate tasks.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../testing/selftests/bpf/prog_tests/iters.c  | 150 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/iters_css.c |  72 +++++++++
 .../selftests/bpf/progs/iters_css_task.c      |  47 ++++++
 .../testing/selftests/bpf/progs/iters_task.c  |  41 +++++
 .../selftests/bpf/progs/iters_task_failure.c  | 105 ++++++++++++
 5 files changed, 415 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index b696873c5455..c2425791c923 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -1,7 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <malloc.h>
+#include <stdlib.h>
 #include <test_progs.h>
+#include "cgroup_helpers.h"
 
 #include "iters.skel.h"
 #include "iters_state_safety.skel.h"
@@ -9,6 +16,10 @@
 #include "iters_num.skel.h"
 #include "iters_testmod_seq.skel.h"
 #include "iters_task_vma.skel.h"
+#include "iters_task.skel.h"
+#include "iters_css_task.skel.h"
+#include "iters_css.skel.h"
+#include "iters_task_failure.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -146,6 +157,138 @@ static void subtest_task_vma_iters(void)
 	iters_task_vma__destroy(skel);
 }
 
+static pthread_mutex_t do_nothing_mutex;
+
+static void *do_nothing_wait(void *arg)
+{
+	pthread_mutex_lock(&do_nothing_mutex);
+	pthread_mutex_unlock(&do_nothing_mutex);
+
+	pthread_exit(arg);
+}
+
+#define thread_num 2
+
+static void subtest_task_iters(void)
+{
+	struct iters_task *skel = NULL;
+	pthread_t thread_ids[thread_num];
+	void *ret;
+	int err;
+
+	skel = iters_task__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+	skel->bss->target_pid = getpid();
+	err = iters_task__attach(skel);
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+	pthread_mutex_lock(&do_nothing_mutex);
+	for (int i = 0; i < thread_num; i++)
+		ASSERT_OK(pthread_create(&thread_ids[i], NULL, &do_nothing_wait, NULL),
+			"pthread_create");
+
+	syscall(SYS_getpgid);
+	iters_task__detach(skel);
+	ASSERT_EQ(skel->bss->procs_cnt, 1, "procs_cnt");
+	ASSERT_EQ(skel->bss->threads_cnt, thread_num + 1, "threads_cnt");
+	ASSERT_EQ(skel->bss->proc_threads_cnt, thread_num + 1, "proc_threads_cnt");
+	pthread_mutex_unlock(&do_nothing_mutex);
+	for (int i = 0; i < thread_num; i++)
+		ASSERT_OK(pthread_join(thread_ids[i], &ret), "pthread_join");
+cleanup:
+	iters_task__destroy(skel);
+}
+
+extern int stack_mprotect(void);
+
+static void subtest_css_task_iters(void)
+{
+	struct iters_css_task *skel = NULL;
+	int err, cg_fd, cg_id;
+	const char *cgrp_path = "/cg1";
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+	cg_fd = create_and_get_cgroup(cgrp_path);
+	if (!ASSERT_GE(cg_fd, 0, "create_and_get_cgroup"))
+		goto cleanup;
+	cg_id = get_cgroup_id(cgrp_path);
+	err = join_cgroup(cgrp_path);
+	if (!ASSERT_OK(err, "join_cgroup"))
+		goto cleanup;
+
+	skel = iters_css_task__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->cg_id = cg_id;
+	err = iters_css_task__attach(skel);
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+	err = stack_mprotect();
+	if (!ASSERT_EQ(err, -1, "stack_mprotect") ||
+	    !ASSERT_EQ(errno, EPERM, "stack_mprotect"))
+		goto cleanup;
+	iters_css_task__detach(skel);
+	ASSERT_EQ(skel->bss->css_task_cnt, 1, "css_task_cnt");
+
+cleanup:
+	cleanup_cgroup_environment();
+	iters_css_task__destroy(skel);
+}
+
+static void subtest_css_iters(void)
+{
+	struct iters_css *skel = NULL;
+	struct {
+		const char *path;
+		int fd;
+	} cgs[] = {
+		{ "/cg1" },
+		{ "/cg1/cg2" },
+		{ "/cg1/cg2/cg3" },
+		{ "/cg1/cg2/cg3/cg4" },
+	};
+	int err, cg_nr = ARRAY_SIZE(cgs);
+	int i;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+	for (i = 0; i < cg_nr; i++) {
+		cgs[i].fd = create_and_get_cgroup(cgs[i].path);
+		if (!ASSERT_GE(cgs[i].fd, 0, "create_and_get_cgroup"))
+			goto cleanup;
+	}
+
+	skel = iters_css__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->root_cg_id = get_cgroup_id(cgs[0].path);
+	skel->bss->leaf_cg_id = get_cgroup_id(cgs[cg_nr - 1].path);
+	err = iters_css__attach(skel);
+
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+
+	syscall(SYS_getpgid);
+	ASSERT_EQ(skel->bss->pre_order_cnt, cg_nr, "pre_order_cnt");
+	ASSERT_EQ(skel->bss->first_cg_id, get_cgroup_id(cgs[0].path), "first_cg_id");
+
+	ASSERT_EQ(skel->bss->post_order_cnt, cg_nr, "post_order_cnt");
+	ASSERT_EQ(skel->bss->last_cg_id, get_cgroup_id(cgs[0].path), "last_cg_id");
+	ASSERT_EQ(skel->bss->tree_high, cg_nr - 1, "tree_high");
+	iters_css__detach(skel);
+cleanup:
+	cleanup_cgroup_environment();
+	iters_css__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -161,4 +304,11 @@ void test_iters(void)
 		subtest_testmod_seq_iters();
 	if (test__start_subtest("task_vma"))
 		subtest_task_vma_iters();
+	if (test__start_subtest("task"))
+		subtest_task_iters();
+	if (test__start_subtest("css_task"))
+		subtest_css_task_iters();
+	if (test__start_subtest("css"))
+		subtest_css_iters();
+	RUN_TESTS(iters_task_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_css.c b/tools/testing/selftests/bpf/progs/iters_css.c
new file mode 100644
index 000000000000..ec1f6c2f590b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_css.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Chuyi Zhou <zhouchuyi@bytedance.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+pid_t target_pid;
+u64 root_cg_id, leaf_cg_id;
+u64 first_cg_id, last_cg_id;
+
+int pre_order_cnt, post_order_cnt, tree_high;
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int iter_css_for_each(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct cgroup_subsys_state *root_css, *leaf_css, *pos;
+	struct cgroup *root_cgrp, *leaf_cgrp, *cur_cgrp;
+
+	if (cur_task->pid != target_pid)
+		return 0;
+
+	root_cgrp = bpf_cgroup_from_id(root_cg_id);
+
+	if (!root_cgrp)
+		return 0;
+
+	leaf_cgrp = bpf_cgroup_from_id(leaf_cg_id);
+
+	if (!leaf_cgrp) {
+		bpf_cgroup_release(root_cgrp);
+		return 0;
+	}
+	root_css = &root_cgrp->self;
+	leaf_css = &leaf_cgrp->self;
+	pre_order_cnt = post_order_cnt = tree_high = 0;
+	first_cg_id = last_cg_id = 0;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+		cur_cgrp = pos->cgroup;
+		post_order_cnt++;
+		last_cg_id = cur_cgrp->kn->id;
+	}
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_PRE) {
+		cur_cgrp = pos->cgroup;
+		pre_order_cnt++;
+		if (!first_cg_id)
+			first_cg_id = cur_cgrp->kn->id;
+	}
+
+	bpf_for_each(css, pos, leaf_css, BPF_CGROUP_ITER_ANCESTORS_UP)
+		tree_high++;
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_ANCESTORS_UP)
+		tree_high--;
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(root_cgrp);
+	bpf_cgroup_release(leaf_cgrp);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/testing/selftests/bpf/progs/iters_css_task.c
new file mode 100644
index 000000000000..5089ce384a1c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Chuyi Zhou <zhouchuyi@bytedance.com> */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+
+pid_t target_pid;
+int css_task_cnt;
+u64 cg_id;
+
+SEC("lsm/file_mprotect")
+int BPF_PROG(iter_css_task_for_each, struct vm_area_struct *vma,
+	    unsigned long reqprot, unsigned long prot, int ret)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+	struct cgroup *cgrp;
+
+	if (cur_task->pid != target_pid)
+		return ret;
+
+	cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (!cgrp)
+		return -EPERM;
+
+	css = &cgrp->self;
+	css_task_cnt = 0;
+
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS)
+		if (task->pid == target_pid)
+			css_task_cnt++;
+
+	bpf_cgroup_release(cgrp);
+
+	return -EPERM;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_task.c b/tools/testing/selftests/bpf/progs/iters_task.c
new file mode 100644
index 000000000000..c9b4055cd410
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Chuyi Zhou <zhouchuyi@bytedance.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+pid_t target_pid;
+int procs_cnt, threads_cnt, proc_threads_cnt;
+
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int iter_task_for_each_sleep(void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct task_struct *pos;
+
+	if (cur_task->pid != target_pid)
+		return 0;
+	procs_cnt = threads_cnt = proc_threads_cnt = 0;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_ALL_PROCS)
+		if (pos->pid == target_pid)
+			procs_cnt++;
+
+	bpf_for_each(task, pos, cur_task, BPF_TASK_ITER_PROC_THREADS)
+		proc_threads_cnt++;
+
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_ALL_THREADS)
+		if (pos->tgid == target_pid)
+			threads_cnt++;
+	bpf_rcu_read_unlock();
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
new file mode 100644
index 000000000000..c3bf96a67dba
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Chuyi Zhou <zhouchuyi@bytedance.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_task_next")
+int BPF_PROG(iter_tasks_without_lock)
+{
+	struct task_struct *pos;
+
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_ALL_PROCS) {
+
+	}
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_css_next")
+int BPF_PROG(iter_css_without_lock)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *root_css, *pos;
+
+	if (!cgrp)
+		return 0;
+	root_css = &cgrp->self;
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_task_next")
+int BPF_PROG(iter_tasks_lock_and_unlock)
+{
+	struct task_struct *pos;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_ALL_PROCS) {
+		bpf_rcu_read_unlock();
+
+		bpf_rcu_read_lock();
+	}
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_css_next")
+int BPF_PROG(iter_css_lock_and_unlock)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *root_css, *pos;
+
+	if (!cgrp)
+		return 0;
+	root_css = &cgrp->self;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+		bpf_rcu_read_unlock();
+
+		bpf_rcu_read_lock();
+	}
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s")
+int BPF_PROG(iter_css_task_for_each)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+
+	if (cgrp == NULL)
+		return 0;
+	css = &cgrp->self;
+
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
+
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
-- 
2.20.1


