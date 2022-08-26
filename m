Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B656C5A3255
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 01:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbiHZXGq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 19:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiHZXGq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 19:06:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41A9C6FFB
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:06:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dbfb6d2a3so47280147b3.11
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=Hw5TIrA9mbe2J+yIccd+krsobVghcwS9aKtee++gLAY=;
        b=dUXKcb1dS09Ozz3fellIhwsOp6hptsObSorqGazjSf7nmOZ+Uzu7q02h980ahqEVcI
         +gE/+jPyG6JhA35nigXmn6owboltCMSA2vvf00mQF0FyQQXU+2u0A5mltNFVq27IsMWT
         F5jzq17f5MQtH4zOVNxYY8CZmXXSHz/9j66RPXhZYsZDn+ps/Pa4elMME2jWxuidepJ8
         nQDaMcauQ4zMtkGPOqh2G2cJSsf9i15aO0ifrSlDMBxzAXZx8VkXiTH+Y1Hwf45DNIuP
         BxIcRLanJAOidvZzOE6UwkmQXVlliHt2fkT0HyFKCcw7BTn8Su2nMxWYIImwWM4fecm5
         dJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=Hw5TIrA9mbe2J+yIccd+krsobVghcwS9aKtee++gLAY=;
        b=nNFzMms0EgNOa89DZi0rACIu00CP8TZyAOvaWFbfGuW7UoW0xHOplOm5ykOc7rJ1w9
         lcmABNZQU9BgR0W7hXrXJkxv50qp4HnyuELNB2H0vbqMCQRiOGz1I3xawQrfOkrVWhhD
         /0qGFMZpTKRNvaeq1STpwMgOw5RsXdgEscD6JDerR3WNK6h7CejxDgCz2GUAnnZMRWrq
         NnU219F4moXm7gO64nnL06zINEbnjEdupb74+gFoK0VPVD1rioh9Uu9H6TFhyd+Pv3ql
         BXzyzv3WxppWImfIh1nODZ4/H6aRWUzUBbZKBXdZfzoxeao7WMaDfexOaQWSUfs4/5iI
         /vsA==
X-Gm-Message-State: ACgBeo1kSuxpom7uIYtco6d/D4SkXagFtGBeNuIZp6YtsIzFWQWSSo68
        5RajBB+pI9XdmSZZnWmaamWUrHN5bqyNSthi
X-Google-Smtp-Source: AA6agR7wDHtMoYz8/9Oo8lUL7m+znA2q40j67hCDFueebcrTlJGAHSAwPiSrmaqe5WqFc+FWTEkksIUWdGR5wTIN
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a0d:e6c1:0:b0:334:ae47:e0e0 with SMTP
 id p184-20020a0de6c1000000b00334ae47e0e0mr1947019ywe.516.1661555203067; Fri,
 26 Aug 2022 16:06:43 -0700 (PDT)
Date:   Fri, 26 Aug 2022 23:06:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826230639.1249436-1-yosryahmed@google.com>
Subject: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
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

The cgroup_hierarchical_stats selftest is complicated. It has to be,
because it tests an entire workflow of recording, aggregating, and
dumping cgroup stats. However, some of the complexity is unnecessary.
The test now enables the memory controller in a cgroup hierarchy, invokes
reclaim, measure reclaim time, THEN uses that reclaim time to test the
stats collection and aggregation. We don't need to use such a
complicated stat, as the context in which the stat is collected is
orthogonal.

Simplify the test by using a simple stat instead of reclaim time, the
total number of times a process has ever entered a cgroup. This makes
the test simpler and removes the dependency on the memory controller and
the memory reclaim interface.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

When the test failed on Alexei's setup because the memory controller was
not enabled I realized this is an unnecessary dependency for the test,
which inspired this patch :) I am not sure if this prompt a Fixes tag as
the test wasn't broken.

---
 .../prog_tests/cgroup_hierarchical_stats.c    | 157 ++++++---------
 .../bpf/progs/cgroup_hierarchical_stats.c     | 181 ++++++------------
 2 files changed, 118 insertions(+), 220 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
index bed1661596f7..12a6d4ddbd77 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Functions to manage eBPF programs attached to cgroup subsystems
+ * This test runs a BPF program that keeps a stat of the number of processes
+ * that ever attached to a cgroup, and makes sure that BPF integrates well with
+ * the rstat framework to efficiently collect those stat percpu to avoid
+ * locking, and to efficiently aggregate the stat across the hierarchy.
  *
  * Copyright 2022 Google LLC.
  */
@@ -21,8 +24,10 @@
 #define PAGE_SIZE 4096
 #define MB(x) (x << 20)
 
+#define PROCESSES_PER_CGROUP 3
+
 #define BPFFS_ROOT "/sys/fs/bpf/"
-#define BPFFS_VMSCAN BPFFS_ROOT"vmscan/"
+#define BPFFS_ATTACH_COUNTERS BPFFS_ROOT"attach_counters/"
 
 #define CG_ROOT_NAME "root"
 #define CG_ROOT_ID 1
@@ -79,7 +84,7 @@ static int setup_bpffs(void)
 		return err;
 
 	/* Create a directory to contain stat files in bpffs */
-	err = mkdir(BPFFS_VMSCAN, 0755);
+	err = mkdir(BPFFS_ATTACH_COUNTERS, 0755);
 	if (!ASSERT_OK(err, "mkdir"))
 		return err;
 
@@ -89,7 +94,7 @@ static int setup_bpffs(void)
 static void cleanup_bpffs(void)
 {
 	/* Remove created directory in bpffs */
-	ASSERT_OK(rmdir(BPFFS_VMSCAN), "rmdir "BPFFS_VMSCAN);
+	ASSERT_OK(rmdir(BPFFS_ATTACH_COUNTERS), "rmdir "BPFFS_ATTACH_COUNTERS);
 
 	/* Unmount bpffs, if it wasn't already mounted when we started */
 	if (mounted_bpffs)
@@ -118,18 +123,6 @@ static int setup_cgroups(void)
 
 		cgroups[i].fd = fd;
 		cgroups[i].id = get_cgroup_id(cgroups[i].path);
-
-		/*
-		 * Enable memcg controller for the entire hierarchy.
-		 * Note that stats are collected for all cgroups in a hierarchy
-		 * with memcg enabled anyway, but are only exposed for cgroups
-		 * that have memcg enabled.
-		 */
-		if (i < N_NON_LEAF_CGROUPS) {
-			err = enable_controllers(cgroups[i].path, "memory");
-			if (!ASSERT_OK(err, "enable_controllers"))
-				return err;
-		}
 	}
 	return 0;
 }
@@ -154,109 +147,85 @@ static void destroy_hierarchy(void)
 	cleanup_bpffs();
 }
 
-static int reclaimer(const char *cgroup_path, size_t size)
+static int attach_processes(void)
 {
-	static char size_buf[128];
-	char *buf, *ptr;
-	int err;
-
-	/* Join cgroup in the parent process workdir */
-	if (join_parent_cgroup(cgroup_path))
-		return EACCES;
-
-	/* Allocate memory */
-	buf = malloc(size);
-	if (!buf)
-		return ENOMEM;
+	int i, j, status;
 
-	/* Write to memory to make sure it's actually allocated */
-	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
-		*ptr = 1;
-
-	/* Try to reclaim memory */
-	snprintf(size_buf, 128, "%lu", size);
-	err = write_cgroup_file_parent(cgroup_path, "memory.reclaim", size_buf);
-
-	free(buf);
-	/* memory.reclaim returns EAGAIN if the amount is not fully reclaimed */
-	if (err && errno != EAGAIN)
-		return errno;
-
-	return 0;
-}
-
-static int induce_vmscan(void)
-{
-	int i, status;
-
-	/*
-	 * In every leaf cgroup, run a child process that allocates some memory
-	 * and attempts to reclaim some of it.
-	 */
+	/* In every leaf cgroup, attach 3 processes */
 	for (i = N_NON_LEAF_CGROUPS; i < N_CGROUPS; i++) {
-		pid_t pid;
-
-		/* Create reclaimer child */
-		pid = fork();
-		if (pid == 0) {
-			status = reclaimer(cgroups[i].path, MB(5));
-			exit(status);
+		for (j = 0; j < PROCESSES_PER_CGROUP; j++) {
+			pid_t pid;
+
+			/* Create child and attach to cgroup */
+			pid = fork();
+			if (pid == 0) {
+				if (join_parent_cgroup(cgroups[i].path))
+					exit(EACCES);
+				exit(0);
+			}
+
+			/* Cleanup child */
+			waitpid(pid, &status, 0);
+			if (!ASSERT_TRUE(WIFEXITED(status), "child process exited"))
+				return 1;
+			if (!ASSERT_EQ(WEXITSTATUS(status), 0,
+				       "child process exit code"))
+				return 1;
 		}
-
-		/* Cleanup reclaimer child */
-		waitpid(pid, &status, 0);
-		ASSERT_TRUE(WIFEXITED(status), "reclaimer exited");
-		ASSERT_EQ(WEXITSTATUS(status), 0, "reclaim exit code");
 	}
 	return 0;
 }
 
 static unsigned long long
-get_cgroup_vmscan_delay(unsigned long long cgroup_id, const char *file_name)
+get_attach_counter(unsigned long long cgroup_id, const char *file_name)
 {
-	unsigned long long vmscan = 0, id = 0;
+	unsigned long long attach_counter = 0, id = 0;
 	static char buf[128], path[128];
 
 	/* For every cgroup, read the file generated by cgroup_iter */
-	snprintf(path, 128, "%s%s", BPFFS_VMSCAN, file_name);
+	snprintf(path, 128, "%s%s", BPFFS_ATTACH_COUNTERS, file_name);
 	if (!ASSERT_OK(read_from_file(path, buf, 128), "read cgroup_iter"))
 		return 0;
 
 	/* Check the output file formatting */
-	ASSERT_EQ(sscanf(buf, "cg_id: %llu, total_vmscan_delay: %llu\n",
-			 &id, &vmscan), 2, "output format");
+	ASSERT_EQ(sscanf(buf, "cg_id: %llu, attach_counter: %llu\n",
+			 &id, &attach_counter), 2, "output format");
 
 	/* Check that the cgroup_id is displayed correctly */
 	ASSERT_EQ(id, cgroup_id, "cgroup_id");
-	/* Check that the vmscan reading is non-zero */
-	ASSERT_GT(vmscan, 0, "vmscan_reading");
-	return vmscan;
+	/* Check that the counter is non-zero */
+	ASSERT_GT(attach_counter, 0, "attach counter non-zero");
+	return attach_counter;
 }
 
-static void check_vmscan_stats(void)
+static void check_attach_counters(void)
 {
-	unsigned long long vmscan_readings[N_CGROUPS], vmscan_root;
+	unsigned long long attach_counters[N_CGROUPS], root_attach_counter;
 	int i;
 
-	for (i = 0; i < N_CGROUPS; i++) {
-		vmscan_readings[i] = get_cgroup_vmscan_delay(cgroups[i].id,
-							     cgroups[i].name);
-	}
+	for (i = 0; i < N_CGROUPS; i++)
+		attach_counters[i] = get_attach_counter(cgroups[i].id,
+							cgroups[i].name);
 
 	/* Read stats for root too */
-	vmscan_root = get_cgroup_vmscan_delay(CG_ROOT_ID, CG_ROOT_NAME);
+	root_attach_counter = get_attach_counter(CG_ROOT_ID, CG_ROOT_NAME);
+
+	/* Check that all leafs cgroups have an attach counter of 3 */
+	for (i = N_NON_LEAF_CGROUPS; i < N_CGROUPS; i++)
+		ASSERT_EQ(attach_counters[i], PROCESSES_PER_CGROUP,
+			  "leaf cgroup attach counter");
 
 	/* Check that child1 == child1_1 + child1_2 */
-	ASSERT_EQ(vmscan_readings[1], vmscan_readings[3] + vmscan_readings[4],
-		  "child1_vmscan");
+	ASSERT_EQ(attach_counters[1], attach_counters[3] + attach_counters[4],
+		  "child1_counter");
 	/* Check that child2 == child2_1 + child2_2 */
-	ASSERT_EQ(vmscan_readings[2], vmscan_readings[5] + vmscan_readings[6],
-		  "child2_vmscan");
+	ASSERT_EQ(attach_counters[2], attach_counters[5] + attach_counters[6],
+		  "child2_counter");
 	/* Check that test == child1 + child2 */
-	ASSERT_EQ(vmscan_readings[0], vmscan_readings[1] + vmscan_readings[2],
-		  "test_vmscan");
+	ASSERT_EQ(attach_counters[0], attach_counters[1] + attach_counters[2],
+		  "test_counter");
 	/* Check that root >= test */
-	ASSERT_GE(vmscan_root, vmscan_readings[1], "root_vmscan");
+	ASSERT_GE(root_attach_counter, attach_counters[1], "root_counter");
 }
 
 /* Creates iter link and pins in bpffs, returns 0 on success, -errno on failure.
@@ -278,12 +247,12 @@ static int setup_cgroup_iter(struct cgroup_hierarchical_stats *obj,
 	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
-	link = bpf_program__attach_iter(obj->progs.dump_vmscan, &opts);
+	link = bpf_program__attach_iter(obj->progs.dumper, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		return -EFAULT;
 
 	/* Pin the link to a bpffs file */
-	snprintf(path, 128, "%s%s", BPFFS_VMSCAN, file_name);
+	snprintf(path, 128, "%s%s", BPFFS_ATTACH_COUNTERS, file_name);
 	err = bpf_link__pin(link, path);
 	ASSERT_OK(err, "pin cgroup_iter");
 
@@ -313,7 +282,7 @@ static int setup_progs(struct cgroup_hierarchical_stats **skel)
 	if (!ASSERT_OK(err, "setup_cgroup_iter"))
 		return err;
 
-	bpf_program__set_autoattach((*skel)->progs.dump_vmscan, false);
+	bpf_program__set_autoattach((*skel)->progs.dumper, false);
 	err = cgroup_hierarchical_stats__attach(*skel);
 	if (!ASSERT_OK(err, "attach"))
 		return err;
@@ -328,13 +297,13 @@ static void destroy_progs(struct cgroup_hierarchical_stats *skel)
 
 	for (i = 0; i < N_CGROUPS; i++) {
 		/* Delete files in bpffs that cgroup_iters are pinned in */
-		snprintf(path, 128, "%s%s", BPFFS_VMSCAN,
+		snprintf(path, 128, "%s%s", BPFFS_ATTACH_COUNTERS,
 			 cgroups[i].name);
 		ASSERT_OK(remove(path), "remove cgroup_iter pin");
 	}
 
 	/* Delete root file in bpffs */
-	snprintf(path, 128, "%s%s", BPFFS_VMSCAN, CG_ROOT_NAME);
+	snprintf(path, 128, "%s%s", BPFFS_ATTACH_COUNTERS, CG_ROOT_NAME);
 	ASSERT_OK(remove(path), "remove cgroup_iter root pin");
 	cgroup_hierarchical_stats__destroy(skel);
 }
@@ -347,9 +316,9 @@ void test_cgroup_hierarchical_stats(void)
 		goto hierarchy_cleanup;
 	if (setup_progs(&skel))
 		goto cleanup;
-	if (induce_vmscan())
+	if (attach_processes())
 		goto cleanup;
-	check_vmscan_stats();
+	check_attach_counters();
 cleanup:
 	destroy_progs(skel);
 hierarchy_cleanup:
diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
index 8ab4253a1592..c74362854948 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Functions to manage eBPF programs attached to cgroup subsystems
- *
  * Copyright 2022 Google LLC.
  */
 #include "vmlinux.h"
@@ -11,25 +9,14 @@
 
 char _license[] SEC("license") = "GPL";
 
-/*
- * Start times are stored per-task, not per-cgroup, as multiple tasks in one
- * cgroup can perform reclaim concurrently.
- */
-struct {
-	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
-	__type(key, int);
-	__type(value, __u64);
-} vmscan_start_time SEC(".maps");
-
-struct vmscan_percpu {
+struct percpu_attach_counter {
 	/* Previous percpu state, to figure out if we have new updates */
 	__u64 prev;
 	/* Current percpu state */
 	__u64 state;
 };
 
-struct vmscan {
+struct attach_counter {
 	/* State propagated through children, pending aggregation */
 	__u64 pending;
 	/* Total state, including all cpus and all children */
@@ -38,147 +25,94 @@ struct vmscan {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
-	__uint(max_entries, 100);
+	__uint(max_entries, 1024);
 	__type(key, __u64);
-	__type(value, struct vmscan_percpu);
-} pcpu_cgroup_vmscan_elapsed SEC(".maps");
+	__type(value, struct percpu_attach_counter);
+} percpu_attach_counters SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
-	__uint(max_entries, 100);
+	__uint(max_entries, 1024);
 	__type(key, __u64);
-	__type(value, struct vmscan);
-} cgroup_vmscan_elapsed SEC(".maps");
+	__type(value, struct attach_counter);
+} attach_counters SEC(".maps");
 
 extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __ksym;
 extern void cgroup_rstat_flush(struct cgroup *cgrp) __ksym;
 
-static struct cgroup *task_memcg(struct task_struct *task)
-{
-	int cgrp_id;
-
-#if __has_builtin(__builtin_preserve_enum_value)
-	cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id, memory_cgrp_id);
-#else
-	cgrp_id = memory_cgrp_id;
-#endif
-	return task->cgroups->subsys[cgrp_id]->cgroup;
-}
-
 static uint64_t cgroup_id(struct cgroup *cgrp)
 {
 	return cgrp->kn->id;
 }
 
-static int create_vmscan_percpu_elem(__u64 cg_id, __u64 state)
+static int create_percpu_attach_counter(__u64 cg_id, __u64 state)
 {
-	struct vmscan_percpu pcpu_init = {.state = state, .prev = 0};
+	struct percpu_attach_counter pcpu_init = {.state = state, .prev = 0};
 
-	return bpf_map_update_elem(&pcpu_cgroup_vmscan_elapsed, &cg_id,
+	return bpf_map_update_elem(&percpu_attach_counters, &cg_id,
 				   &pcpu_init, BPF_NOEXIST);
 }
 
-static int create_vmscan_elem(__u64 cg_id, __u64 state, __u64 pending)
+static int create_attach_counter(__u64 cg_id, __u64 state, __u64 pending)
 {
-	struct vmscan init = {.state = state, .pending = pending};
+	struct attach_counter init = {.state = state, .pending = pending};
 
-	return bpf_map_update_elem(&cgroup_vmscan_elapsed, &cg_id,
+	return bpf_map_update_elem(&attach_counters, &cg_id,
 				   &init, BPF_NOEXIST);
 }
 
-SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
-int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
+SEC("fentry/cgroup_attach_task")
+int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
+	     bool threadgroup)
 {
-	struct task_struct *task = bpf_get_current_task_btf();
-	__u64 *start_time_ptr;
-
-	start_time_ptr = bpf_task_storage_get(&vmscan_start_time, task, 0,
-					      BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (start_time_ptr)
-		*start_time_ptr = bpf_ktime_get_ns();
-	return 0;
-}
-
-SEC("tp_btf/mm_vmscan_memcg_reclaim_end")
-int BPF_PROG(vmscan_end, unsigned long nr_reclaimed)
-{
-	struct vmscan_percpu *pcpu_stat;
-	struct task_struct *current = bpf_get_current_task_btf();
-	struct cgroup *cgrp;
-	__u64 *start_time_ptr;
-	__u64 current_elapsed, cg_id;
-	__u64 end_time = bpf_ktime_get_ns();
-
-	/*
-	 * cgrp is the first parent cgroup of current that has memcg enabled in
-	 * its subtree_control, or NULL if memcg is disabled in the entire tree.
-	 * In a cgroup hierarchy like this:
-	 *                               a
-	 *                              / \
-	 *                             b   c
-	 *  If "a" has memcg enabled, while "b" doesn't, then processes in "b"
-	 *  will accumulate their stats directly to "a". This makes sure that no
-	 *  stats are lost from processes in leaf cgroups that don't have memcg
-	 *  enabled, but only exposes stats for cgroups that have memcg enabled.
-	 */
-	cgrp = task_memcg(current);
-	if (!cgrp)
+	__u64 cg_id = cgroup_id(dst_cgrp);
+	struct percpu_attach_counter *pcpu_counter = bpf_map_lookup_elem(
+			&percpu_attach_counters,
+			&cg_id);
+
+	if (pcpu_counter)
+		pcpu_counter->state += 1;
+	else if (create_percpu_attach_counter(cg_id, 1))
 		return 0;
 
-	cg_id = cgroup_id(cgrp);
-	start_time_ptr = bpf_task_storage_get(&vmscan_start_time, current, 0,
-					      BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (!start_time_ptr)
-		return 0;
-
-	current_elapsed = end_time - *start_time_ptr;
-	pcpu_stat = bpf_map_lookup_elem(&pcpu_cgroup_vmscan_elapsed,
-					&cg_id);
-	if (pcpu_stat)
-		pcpu_stat->state += current_elapsed;
-	else if (create_vmscan_percpu_elem(cg_id, current_elapsed))
-		return 0;
-
-	cgroup_rstat_updated(cgrp, bpf_get_smp_processor_id());
+	cgroup_rstat_updated(dst_cgrp, bpf_get_smp_processor_id());
 	return 0;
 }
 
 SEC("fentry/bpf_rstat_flush")
-int BPF_PROG(vmscan_flush, struct cgroup *cgrp, struct cgroup *parent, int cpu)
+int BPF_PROG(flusher, struct cgroup *cgrp, struct cgroup *parent, int cpu)
 {
-	struct vmscan_percpu *pcpu_stat;
-	struct vmscan *total_stat, *parent_stat;
+	struct percpu_attach_counter *pcpu_counter;
+	struct attach_counter *total_counter, *parent_counter;
 	__u64 cg_id = cgroup_id(cgrp);
 	__u64 parent_cg_id = parent ? cgroup_id(parent) : 0;
-	__u64 *pcpu_vmscan;
 	__u64 state;
 	__u64 delta = 0;
 
 	/* Add CPU changes on this level since the last flush */
-	pcpu_stat = bpf_map_lookup_percpu_elem(&pcpu_cgroup_vmscan_elapsed,
-					       &cg_id, cpu);
-	if (pcpu_stat) {
-		state = pcpu_stat->state;
-		delta += state - pcpu_stat->prev;
-		pcpu_stat->prev = state;
+	pcpu_counter = bpf_map_lookup_percpu_elem(&percpu_attach_counters,
+						  &cg_id, cpu);
+	if (pcpu_counter) {
+		state = pcpu_counter->state;
+		delta += state - pcpu_counter->prev;
+		pcpu_counter->prev = state;
 	}
 
-	total_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed, &cg_id);
-	if (!total_stat) {
-		if (create_vmscan_elem(cg_id, delta, 0))
+	total_counter = bpf_map_lookup_elem(&attach_counters, &cg_id);
+	if (!total_counter) {
+		if (create_attach_counter(cg_id, delta, 0))
 			return 0;
-
 		goto update_parent;
 	}
 
 	/* Collect pending stats from subtree */
-	if (total_stat->pending) {
-		delta += total_stat->pending;
-		total_stat->pending = 0;
+	if (total_counter->pending) {
+		delta += total_counter->pending;
+		total_counter->pending = 0;
 	}
 
 	/* Propagate changes to this cgroup's total */
-	total_stat->state += delta;
+	total_counter->state += delta;
 
 update_parent:
 	/* Skip if there are no changes to propagate, or no parent */
@@ -186,20 +120,20 @@ int BPF_PROG(vmscan_flush, struct cgroup *cgrp, struct cgroup *parent, int cpu)
 		return 0;
 
 	/* Propagate changes to cgroup's parent */
-	parent_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed,
-					  &parent_cg_id);
-	if (parent_stat)
-		parent_stat->pending += delta;
+	parent_counter = bpf_map_lookup_elem(&attach_counters,
+					     &parent_cg_id);
+	if (parent_counter)
+		parent_counter->pending += delta;
 	else
-		create_vmscan_elem(parent_cg_id, 0, delta);
+		create_attach_counter(parent_cg_id, 0, delta);
 	return 0;
 }
 
 SEC("iter.s/cgroup")
-int BPF_PROG(dump_vmscan, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+int BPF_PROG(dumper, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 {
 	struct seq_file *seq = meta->seq;
-	struct vmscan *total_stat;
+	struct attach_counter *total_counter;
 	__u64 cg_id = cgrp ? cgroup_id(cgrp) : 0;
 
 	/* Do nothing for the terminal call */
@@ -209,18 +143,13 @@ int BPF_PROG(dump_vmscan, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 	/* Flush the stats to make sure we get the most updated numbers */
 	cgroup_rstat_flush(cgrp);
 
-	total_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed, &cg_id);
-	if (!total_stat) {
-		BPF_SEQ_PRINTF(seq, "cg_id: %llu, total_vmscan_delay: 0\n",
+	total_counter = bpf_map_lookup_elem(&attach_counters, &cg_id);
+	if (!total_counter) {
+		BPF_SEQ_PRINTF(seq, "cg_id: %llu, attach_counter: 0\n",
 			       cg_id);
 	} else {
-		BPF_SEQ_PRINTF(seq, "cg_id: %llu, total_vmscan_delay: %llu\n",
-			       cg_id, total_stat->state);
+		BPF_SEQ_PRINTF(seq, "cg_id: %llu, attach_counter: %llu\n",
+			       cg_id, total_counter->state);
 	}
-
-	/*
-	 * We only dump stats for one cgroup here, so return 1 to stop
-	 * iteration after the first cgroup.
-	 */
-	return 1;
+	return 0;
 }
-- 
2.37.2.672.g94769d06f0-goog

