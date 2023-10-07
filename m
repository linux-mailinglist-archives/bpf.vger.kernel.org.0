Return-Path: <bpf+bounces-11613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B27BC7CA
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8312824CE
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336520B1A;
	Sat,  7 Oct 2023 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KH5HK5fW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE81A59C
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 12:46:09 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5410C
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 05:46:00 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af5fda8f6fso2088790b6e.3
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696682759; x=1697287559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bph2orvoCEU3nv14q5S6Q5Uk2g2Q/moZTxGqgTwE44w=;
        b=KH5HK5fW66gdj59zqZFSxfA3GCMX+qJ6J47Z68sBO5/vzQAj+U4fmoB6utua08tA9f
         mhF+/VGaiR+VgTSJZbDaRQYBdTilzM6B8oVJ+fhSS7AGNLRTkfNC4asw4bUgmIQpyD0J
         OJtE1zxE1hqxy2r7wwoNx7VWkR1HJ6V4oZjI13JnNTOtnryBoaYBa5cKXdieDncc5Z+3
         vVOdYDWU5IhyETdRIdvo9U7y8maZ/Pmild5+z1WssUDq2t4gH4taqOVSccJ7l86Wdw4y
         fSYywwmsXesSM3sqxf3r3R5SXzDe3Jl6UOrHrFB4h+9v4524HxosGa4Cu2TTjGE1EbSm
         ELJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696682759; x=1697287559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bph2orvoCEU3nv14q5S6Q5Uk2g2Q/moZTxGqgTwE44w=;
        b=mE7BKS4lCPrlo+Lq1i0tem37txOX5iyyB0xdTDpMySEuImalPmNGmRczFHwxuDirLX
         SrpE+7eXDydexk6DpifDAk7Ew7ApVjvON90fOlzYLvKCNFULRFFVflfV+B3gy161dpU5
         L7FubCvJ712/TzuN5zNUby+kXnUE24N4CN/4681RLJFk7SUVWc2LnT6oBbHyn9L7S/JC
         /Xhw9+3s8Ki3pMq0DwyaoihVy856lLLIb4b90vg9dRhcjYuJG8lg1KmERAchlegeLPk0
         s34j0LgiCsPemB5Si6SD82EWPcQ9QtFJC7S9UvIlR8RaHq8IkyLd8eCFMP3uV0jM23DD
         KaGQ==
X-Gm-Message-State: AOJu0YwRyiNFbotq57w0gPzcQWjFoTAqL1/FaT49bAKNOzgsmY5etTdh
	mewRylyNEBghLEzzyRVlyORjYFDITAOOtH3DbEU=
X-Google-Smtp-Source: AGHT+IE+krSO+hjP5vcrFe929tH50nBOct+R0k4rcF4h8IxLbrTOs/Ntr7dPh2WM5PvPht92gccksA==
X-Received: by 2002:a05:6358:99a8:b0:141:d2d:6da7 with SMTP id j40-20020a05635899a800b001410d2d6da7mr10552271rwb.17.1696682759556;
        Sat, 07 Oct 2023 05:45:59 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b00256799877ffsm5095388pjw.47.2023.10.07.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:45:59 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Add tests for open-coded task and css iter
Date: Sat,  7 Oct 2023 20:45:22 +0800
Message-Id: <20231007124522.34834-9-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231007124522.34834-1-zhouchuyi@bytedance.com>
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds three subtests to demonstrate these patterns and validating
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

subtest2: We create a cgroup and add the current task to the cgroup. In the
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

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../testing/selftests/bpf/prog_tests/iters.c  | 161 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/iters_css.c |  74 ++++++++
 .../selftests/bpf/progs/iters_css_task.c      |  42 +++++
 .../testing/selftests/bpf/progs/iters_task.c  |  41 +++++
 .../selftests/bpf/progs/iters_task_failure.c  | 105 ++++++++++++
 5 files changed, 423 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 10804ae5ae97..d1d5dc3bedd3 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -1,13 +1,24 @@
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
 #include "iters_looping.skel.h"
 #include "iters_num.skel.h"
 #include "iters_testmod_seq.skel.h"
+#include "iters_task.skel.h"
+#include "iters_css_task.skel.h"
+#include "iters_css.skel.h"
+#include "iters_task_failure.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -90,6 +101,149 @@ static void subtest_testmod_seq_iters(void)
 	iters_testmod_seq__destroy(skel);
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
+	struct iters_task *skel;
+	pthread_t thread_ids[thread_num];
+	void *ret;
+	int err;
+
+	skel = iters_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	err = iters_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
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
+	ASSERT_EQ(skel->bss->process_cnt, 1, "process_cnt");
+	ASSERT_EQ(skel->bss->thread_cnt, thread_num + 1, "thread_cnt");
+	ASSERT_EQ(skel->bss->all_thread_cnt, thread_num + 1, "all_thread_cnt");
+	pthread_mutex_unlock(&do_nothing_mutex);
+	for (int i = 0; i < thread_num; i++)
+		pthread_join(thread_ids[i], &ret);
+cleanup:
+	iters_task__destroy(skel);
+}
+
+extern int stack_mprotect(void);
+
+static void subtest_css_task_iters(void)
+{
+	struct iters_css_task *skel;
+	int err, cg_fd, cg_id;
+	const char *cgrp_path = "/cg1";
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+	cg_fd = create_and_get_cgroup(cgrp_path);
+	if (!ASSERT_GE(cg_fd, 0, "cg_create"))
+		goto cleanup;
+	cg_id = get_cgroup_id(cgrp_path);
+	err = join_cgroup(cgrp_path);
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+
+	skel = iters_css_task__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	err = iters_css_task__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->cg_id = cg_id;
+	err = iters_css_task__attach(skel);
+
+	err = stack_mprotect();
+	if (!ASSERT_OK(err, "iters_task__attach"))
+		goto cleanup;
+
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
+	struct iters_css *skel;
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
+		if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
+			goto cleanup;
+	}
+
+	skel = iters_css__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	err = iters_css__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
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
+	ASSERT_EQ(skel->bss->pre_css_dec_cnt, cg_nr, "pre order search dec count");
+	ASSERT_EQ(skel->bss->first_cg_id, get_cgroup_id(cgs[0].path),
+				"pre order search first cgroup id");
+
+	ASSERT_EQ(skel->bss->post_css_dec_cnt, cg_nr, "post order search dec count");
+	ASSERT_EQ(skel->bss->last_cg_id, get_cgroup_id(cgs[0].path),
+				"post order search last cgroup id");
+	ASSERT_EQ(skel->bss->tree_high, cg_nr - 1, "tree high");
+	iters_css__detach(skel);
+cleanup:
+	cleanup_cgroup_environment();
+	iters_css__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
@@ -103,4 +257,11 @@ void test_iters(void)
 		subtest_num_iters();
 	if (test__start_subtest("testmod_seq"))
 		subtest_testmod_seq_iters();
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
index 000000000000..1422a7956c44
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_css.c
@@ -0,0 +1,74 @@
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
+pid_t target_pid = 0;
+u64 root_cg_id;
+u64 leaf_cg_id;
+
+u64 last_cg_id = 0;
+u64 first_cg_id = 0;
+
+int post_css_dec_cnt = 0;
+int pre_css_dec_cnt = 0;
+int tree_high = 0;
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
+	bpf_rcu_read_lock();
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+		cur_cgrp = pos->cgroup;
+		post_css_dec_cnt += 1;
+		last_cg_id = cur_cgrp->kn->id;
+	}
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_PRE) {
+		cur_cgrp = pos->cgroup;
+		pre_css_dec_cnt += 1;
+		if (!first_cg_id)
+			first_cg_id = cur_cgrp->kn->id;
+	}
+
+	bpf_for_each(css, pos, leaf_css, BPF_CGROUP_ITER_ANCESTORS_UP)
+		tree_high += 1;
+
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_ANCESTORS_UP)
+		tree_high -= 1;
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(root_cgrp);
+	bpf_cgroup_release(leaf_cgrp);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/testing/selftests/bpf/progs/iters_css_task.c
new file mode 100644
index 000000000000..506a2755234e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
@@ -0,0 +1,42 @@
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
+
+pid_t target_pid = 0;
+int css_task_cnt = 0;
+u64 cg_id;
+
+SEC("lsm/file_mprotect")
+int BPF_PROG(iter_css_task_for_each)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+	struct cgroup *cgrp;
+
+	if (cur_task->pid != target_pid)
+		return 0;
+
+	cgrp = bpf_cgroup_from_id(cg_id);
+
+	if (cgrp == NULL)
+		return 0;
+	css = &cgrp->self;
+
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS)
+		if (task->pid == target_pid)
+			css_task_cnt += 1;
+
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_task.c b/tools/testing/selftests/bpf/progs/iters_task.c
new file mode 100644
index 000000000000..bd6d4f7b5e59
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
+pid_t target_pid = 0;
+int process_cnt = 0;
+int thread_cnt = 0;
+int all_thread_cnt = 0;
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
+	bpf_rcu_read_lock();
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_ALL_PROCS)
+		if (pos->pid == target_pid)
+			process_cnt += 1;
+
+	bpf_for_each(task, pos, cur_task, BPF_TASK_ITER_PROC_THREADS)
+		thread_cnt += 1;
+
+	bpf_for_each(task, pos, NULL, BPF_TASK_ITER_ALL_THREADS)
+		if (pos->tgid == target_pid)
+			all_thread_cnt += 1;
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


