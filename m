Return-Path: <bpf+bounces-10746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D407AD677
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 12:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 28DCBB20980
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0878171AA;
	Mon, 25 Sep 2023 10:56:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D515EA0
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 10:56:11 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8048FDF
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 03:56:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so3871215b3a.3
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 03:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695639369; x=1696244169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O1IYq2E0iRWWNCjth+VgALshowxNmpqObLZCu3x7r8=;
        b=Hs4Ulemu93KqHfzQ/MHQJ8mDYlK1Ic0VWIsI/rb3zd7aDPcPKQU0/gAqUPc5ScTsvC
         9l17xsaqzaK/WCg/yxLyFxN/fE51CI1E2a6z6+K3DH/nEMxpjZsB3HJEjeKUwTVh4+kN
         V753IpVyUQZb+6MV0V0EHn0xlFrV1AN0f+a/JUr9wupXWN2h/cQMdZs7wezwlbkG/mEr
         9H1FszmGDJz2ti4Hr0b3TcKYiTMzvygac6vObPns+Zs/XSAhVnAKojJC0PgzKV5VdsWZ
         2ZYDkkNK5Vqnc2K2Ezv6BnCTQPFehZGKHHWSeBZt9bO4JKI8C+Vrb90GeLYXUxdIcIba
         4NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639369; x=1696244169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2O1IYq2E0iRWWNCjth+VgALshowxNmpqObLZCu3x7r8=;
        b=SKnYtRrmJKB80j3S5bvaE1KYozv6xexfKqTVg3mWoJGNYRj2/dz5BVSNZgtXUp71Ib
         YrLLjmVgvu68PntcsO9KrfpAzsH/eowHuRK3VjyY6xGaDs0vNv+o8UoI30pIU0RFDAwx
         gCGrXSD5vFYTXLxdy3UtWj0/4N1y2eLcvsKgEfGXXIyt2ZAUEcctqZlA/QjV6vpctwje
         M/tBpY7ugKrXtFycjLxRxbccb3XRq3VzHo7zCa6gnWhpok2EtuUdRsaM/cQ4ATd/e+5s
         XUb2MBhyvfLED+b4pHDk+VpgXzhNcYU4WvMB6CV8Ac3q82iI4S1I3mVswW0NAw3ipHZR
         EkSg==
X-Gm-Message-State: AOJu0YyRobDkpmjkaiSI7r1rHEAzCE3vEpmdxat5QnyNFSna+xCJA5gg
	IldVn3qQqbeUDHmvlS7oDNxKn7bjR9LIpq0ObN8=
X-Google-Smtp-Source: AGHT+IF+f8JVpC2aeTO8JbmvHw76KWlam76gM+1n2vmIuXXczYMw/3iE6eCLmbnb7dTr4IGlU5z0WA==
X-Received: by 2002:a05:6a20:7d96:b0:152:efa4:21b with SMTP id v22-20020a056a207d9600b00152efa4021bmr7791456pzj.5.1695639368762;
        Mon, 25 Sep 2023 03:56:08 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a16c900b002772faee740sm2297842pje.5.2023.09.25.03.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:56:08 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 3/7] bpf: Introduce task open coded iterator kfuncs
Date: Mon, 25 Sep 2023 18:55:48 +0800
Message-Id: <20230925105552.817513-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230925105552.817513-1-zhouchuyi@bytedance.com>
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_task in open-coded iterator
style. BPF programs can use these kfuncs or through bpf_for_each macro to
iterate all processes in the system.

The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
accepts a specific task and iterating type which allows:
1. iterating all process in the system

2. iterating all threads in the system

3. iterating all threads of a specific task
Here we also resuse enum bpf_iter_task_type and rename BPF_TASK_ITER_TID
to BPF_TASK_ITER_THREAD, rename BPF_TASK_ITER_TGID to BPF_TASK_ITER_PROC.

The newly-added struct bpf_iter_task has a name collision with a selftest
for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
renamed in order to avoid the collision.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/linux/bpf.h                           |  8 +-
 kernel/bpf/helpers.c                          |  3 +
 kernel/bpf/task_iter.c                        | 96 ++++++++++++++++---
 .../testing/selftests/bpf/bpf_experimental.h  |  5 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 18 ++--
 .../{bpf_iter_task.c => bpf_iter_tasks.c}     |  0
 6 files changed, 106 insertions(+), 24 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 87eeb3a46a1d..0ef5b7a59d62 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2194,16 +2194,16 @@ int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
  * BPF_TASK_ITER_ALL (default)
  *	Iterate over resources of every task.
  *
- * BPF_TASK_ITER_TID
+ * BPF_TASK_ITER_THREAD
  *	Iterate over resources of a task/tid.
  *
- * BPF_TASK_ITER_TGID
+ * BPF_TASK_ITER_PROC
  *	Iterate over resources of every task of a process / task group.
  */
 enum bpf_iter_task_type {
 	BPF_TASK_ITER_ALL = 0,
-	BPF_TASK_ITER_TID,
-	BPF_TASK_ITER_TGID,
+	BPF_TASK_ITER_THREAD,
+	BPF_TASK_ITER_PROC,
 };
 
 struct bpf_iter_aux_info {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 189d158c9b7f..556262c27a75 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2507,6 +2507,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 2cfcb4dd8a37..9bcd3f9922b1 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -94,7 +94,7 @@ static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *co
 	struct task_struct *task = NULL;
 	struct pid *pid;
 
-	if (common->type == BPF_TASK_ITER_TID) {
+	if (common->type == BPF_TASK_ITER_THREAD) {
 		if (*tid && *tid != common->pid)
 			return NULL;
 		rcu_read_lock();
@@ -108,7 +108,7 @@ static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *co
 		return task;
 	}
 
-	if (common->type == BPF_TASK_ITER_TGID) {
+	if (common->type == BPF_TASK_ITER_PROC) {
 		rcu_read_lock();
 		task = task_group_seq_get_next(common, tid, skip_if_dup_files);
 		rcu_read_unlock();
@@ -217,15 +217,15 @@ static int bpf_iter_attach_task(struct bpf_prog *prog,
 
 	aux->task.type = BPF_TASK_ITER_ALL;
 	if (linfo->task.tid != 0) {
-		aux->task.type = BPF_TASK_ITER_TID;
+		aux->task.type = BPF_TASK_ITER_THREAD;
 		aux->task.pid = linfo->task.tid;
 	}
 	if (linfo->task.pid != 0) {
-		aux->task.type = BPF_TASK_ITER_TGID;
+		aux->task.type = BPF_TASK_ITER_PROC;
 		aux->task.pid = linfo->task.pid;
 	}
 	if (linfo->task.pid_fd != 0) {
-		aux->task.type = BPF_TASK_ITER_TGID;
+		aux->task.type = BPF_TASK_ITER_PROC;
 
 		pid = pidfd_get_pid(linfo->task.pid_fd, &flags);
 		if (IS_ERR(pid))
@@ -305,7 +305,7 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 	rcu_read_unlock();
 	put_task_struct(curr_task);
 
-	if (info->common.type == BPF_TASK_ITER_TID) {
+	if (info->common.type == BPF_TASK_ITER_THREAD) {
 		info->task = NULL;
 		return NULL;
 	}
@@ -566,7 +566,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
 	return curr_vma;
 
 next_task:
-	if (info->common.type == BPF_TASK_ITER_TID)
+	if (info->common.type == BPF_TASK_ITER_THREAD)
 		goto finish;
 
 	put_task_struct(curr_task);
@@ -677,10 +677,10 @@ static const struct bpf_iter_seq_info task_seq_info = {
 static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, struct bpf_link_info *info)
 {
 	switch (aux->task.type) {
-	case BPF_TASK_ITER_TID:
+	case BPF_TASK_ITER_THREAD:
 		info->iter.task.tid = aux->task.pid;
 		break;
-	case BPF_TASK_ITER_TGID:
+	case BPF_TASK_ITER_PROC:
 		info->iter.task.pid = aux->task.pid;
 		break;
 	default:
@@ -692,9 +692,9 @@ static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, struct b
 static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *aux, struct seq_file *seq)
 {
 	seq_printf(seq, "task_type:\t%s\n", iter_task_type_names[aux->task.type]);
-	if (aux->task.type == BPF_TASK_ITER_TID)
+	if (aux->task.type == BPF_TASK_ITER_THREAD)
 		seq_printf(seq, "tid:\t%u\n", aux->task.pid);
-	else if (aux->task.type == BPF_TASK_ITER_TGID)
+	else if (aux->task.type == BPF_TASK_ITER_PROC)
 		seq_printf(seq, "pid:\t%u\n", aux->task.pid);
 }
 
@@ -856,6 +856,80 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 	bpf_mem_free(&bpf_global_ma, kit->css_it);
 }
 
+struct bpf_iter_task {
+	__u64 __opaque[2];
+	__u32 __opaque_int[1];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_task_kern {
+	struct task_struct *task;
+	struct task_struct *pos;
+	unsigned int type;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task, unsigned int type)
+{
+	struct bpf_iter_task_kern *kit = (void *)it;
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) != sizeof(struct bpf_iter_task));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
+					__alignof__(struct bpf_iter_task));
+	kit->task = kit->pos = NULL;
+	switch (type) {
+	case BPF_TASK_ITER_ALL:
+	case BPF_TASK_ITER_PROC:
+	case BPF_TASK_ITER_THREAD:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (type == BPF_TASK_ITER_THREAD)
+		kit->task = task;
+	else
+		kit->task = &init_task;
+	kit->pos = kit->task;
+	kit->type = type;
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
+{
+	struct bpf_iter_task_kern *kit = (void *)it;
+	struct task_struct *pos;
+	unsigned int type;
+
+	type = kit->type;
+	pos = kit->pos;
+
+	if (!pos)
+		goto out;
+
+	if (type == BPF_TASK_ITER_PROC)
+		goto get_next_task;
+
+	kit->pos = next_thread(kit->pos);
+	if (kit->pos == kit->task) {
+		if (type == BPF_TASK_ITER_THREAD) {
+			kit->pos = NULL;
+			goto out;
+		}
+	} else
+		goto out;
+
+get_next_task:
+	kit->pos = next_task(kit->pos);
+	kit->task = kit->pos;
+	if (kit->pos == &init_task)
+		kit->pos = NULL;
+
+out:
+	return pos;
+}
+
+__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
+{
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d3ea90f0e142..d989775dbdb5 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -169,4 +169,9 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
 extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
 extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
 
+struct bpf_iter_task;
+extern int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task, unsigned int type) __weak __ksym;
+extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) __weak __ksym;
+extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..dc60e8e125cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -7,7 +7,7 @@
 #include "bpf_iter_ipv6_route.skel.h"
 #include "bpf_iter_netlink.skel.h"
 #include "bpf_iter_bpf_map.skel.h"
-#include "bpf_iter_task.skel.h"
+#include "bpf_iter_tasks.skel.h"
 #include "bpf_iter_task_stack.skel.h"
 #include "bpf_iter_task_file.skel.h"
 #include "bpf_iter_task_vma.skel.h"
@@ -215,12 +215,12 @@ static void *do_nothing_wait(void *arg)
 static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 				     int *num_unknown, int *num_known)
 {
-	struct bpf_iter_task *skel;
+	struct bpf_iter_tasks *skel;
 	pthread_t thread_id;
 	void *ret;
 
-	skel = bpf_iter_task__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
+	skel = bpf_iter_tasks__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
 		return;
 
 	ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock");
@@ -239,7 +239,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 	ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
 		     "pthread_join");
 
-	bpf_iter_task__destroy(skel);
+	bpf_iter_tasks__destroy(skel);
 }
 
 static void test_task_common(struct bpf_iter_attach_opts *opts, int num_unknown, int num_known)
@@ -307,10 +307,10 @@ static void test_task_pidfd(void)
 
 static void test_task_sleepable(void)
 {
-	struct bpf_iter_task *skel;
+	struct bpf_iter_tasks *skel;
 
-	skel = bpf_iter_task__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
+	skel = bpf_iter_tasks__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_task_sleepable);
@@ -320,7 +320,7 @@ static void test_task_sleepable(void)
 	ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
 		  "num_success_copy_from_user_task");
 
-	bpf_iter_task__destroy(skel);
+	bpf_iter_tasks__destroy(skel);
 }
 
 static void test_task_stack(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/bpf_iter_task.c
rename to tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
-- 
2.20.1


