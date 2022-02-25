Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614BF4C5235
	for <lists+bpf@lfdr.de>; Sat, 26 Feb 2022 00:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiBYXom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 18:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbiBYXok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9499F1BE133
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:44:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w1-20020a05690204e100b006244315a721so4975024ybs.0
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mnpUHa/7ilfAutSYFbFz7WOqZO/5qWSihfyAdgaHxvw=;
        b=AE+b+1YFMHdLarVClvHMRgI2KRhKCKNhQ/Yi5xLr+vYSboaPkmq24kX+agaWmTjIsE
         mC6jEVFVpNPeravHTTNV5UuBbu9LaIiPwsiHrN+YxZanruN7nof+StAsLu+l+P8WO6BE
         wIkIfDAUQRzRlwPmE66y0AVHNMAl0x5ilpxgT/NUgCgIOG2eTjkcNui5PE3lJVqn2Wki
         j3XOqqAIMIkeg8u2Yay+1LO6EhuxP3NJ0XC5KFkhL2zQpxZPrCc4v4PdC6Dk+AgdqkS6
         4TGRW8nsOgPF5k47cbVmEJZj3MpWzbxV8gey8OBqYg7VKMeN7X6NBiC7wZpo321EA2CZ
         YuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mnpUHa/7ilfAutSYFbFz7WOqZO/5qWSihfyAdgaHxvw=;
        b=wcYtwqYOS9PhwizoLfctqHEOInqKQAnCdt1tos9Al+sPeZEmAWPGK8V625j1wpvf7W
         mZohJXe/is5rg+H+NcO7qseRP5woalL6zI2QI62Yjhds+6cxETmpzd2anbyT+RgxrAkG
         Y8ejfK2ROaq/QTPOtJrF09PO3XTP9R3J8hb9OxdBXJpEE6rraHdK/RJOZflTPoAkoaR8
         /hX99Kgwlg7s0Sj56hSSdO5c6fvqummTS7SEXrQ2kS28yDkOygikkQjeBzTlDRzHCcdr
         pO6Vt8BFzwZexwMdhmkCyJN63iWgcsShVo/OU5I25GsQDD9GBfS9tsbsReZwVVPgU2Zg
         dzcA==
X-Gm-Message-State: AOAM533wlpqZ86880mujEG8REwiSAXRVW9ix5QC0fKdNF1RmD0WLnbn1
        IMUUZNGDiesJ9FFAu9hMeB9KBAOtP6M=
X-Google-Smtp-Source: ABdhPJyk4wWTO4jdK2xsOjpeiCiDnM2+f8PS2s6q52g0nS7vYWtEVDQKhogFo0NyHyrWV4sSyRxM5UG+eYY=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a5b:e:0:b0:61d:841c:543b with SMTP id
 a14-20020a5b000e000000b0061d841c543bmr9460079ybp.604.1645832645829; Fri, 25
 Feb 2022 15:44:05 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:39 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-10-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 9/9] selftests/bpf: Tests using sleepable
 tracepoints to monitor cgroup events
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
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

Tests the functionalities of sleepable tracing prog, sleepable tracepoints
(i.e. cgroup_mkdir_s and cgroup_rmdir_s) and cgroup iter prog all together.

The added selftest resembles a real-world application, where bpf is used
to export cgroup-level performance stats. There are two sets of progs in
the test: cgroup_monitor and cgroup_sched_lat

- Cgroup_monitor monitors cgroup creation and deletion using sleepable
  tracing; for each cgroup created, creates a directory in bpffs; creates
  a cgroup iter link and pins it in that directory.

- Cgroup_sched_lat is the program that collects cgroup's scheduling
  latencies and store them in hash map. Cgroup_sched_lat implements a
  cgroup iter prog, which reads the stats from the map and seq_prints
  them. This cgroup iter prog is the prog pinned by cgroup_monitor in
  each bpffs directory.

The cgroup_sched_lat in this test can be adapted for exporting similar
cgroup-level performance stats.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../bpf/prog_tests/test_cgroup_stats.c        | 187 ++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../selftests/bpf/progs/cgroup_monitor.c      |  78 ++++++
 .../selftests/bpf/progs/cgroup_sched_lat.c    | 232 ++++++++++++++++++
 4 files changed, 504 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cgroup_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_monitor.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_sched_lat.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_cgroup_stats.c b/tools/testing/selftests/bpf/prog_tests/test_cgroup_stats.c
new file mode 100644
index 000000000000..b6607ac074bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_cgroup_stats.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+#define _GNU_SOURCE
+#include <sys/stat.h>	/* mkdir */
+#include <fcntl.h>	/* name_to_handle_at */
+#include <stdlib.h>
+#include <test_progs.h>
+#include "cgroup_monitor.skel.h"
+#include "cgroup_sched_lat.skel.h"
+
+static char mkdir_prog_path[64];
+static char rmdir_prog_path[64];
+static char dump_prog_path[64];
+
+/* Get cgroup id from a full path to cgroup */
+static int get_cgroup_id(const char *cgroup)
+{
+	int mount_id = 0;
+	struct {
+		struct file_handle fh;
+		__u64 cgid;
+	} fh = {};
+
+	fh.fh.handle_bytes = sizeof(fh.cgid);
+	if (name_to_handle_at(AT_FDCWD, cgroup, &fh.fh, &mount_id, 0))
+		return -1;
+
+	return fh.cgid;
+}
+
+static void spin_on_cpu(int seconds)
+{
+	time_t start, now;
+
+	start = time(NULL);
+	do {
+		now = time(NULL);
+	} while (now - start < seconds);
+}
+
+static void do_work(const char *cgroup)
+{
+	int i, cpu = 0, pid;
+	char cmd[128];
+
+	/* make cgroup threaded */
+	snprintf(cmd, 128, "echo threaded > %s/cgroup.type", cgroup);
+	system(cmd);
+
+	/* try to enable cpu controller. this may fail if cpu controller is not
+	 * available in cgroup.controllers or there is a cgroup v1 already
+	 * mounted in the system.
+	 */
+	snprintf(cmd, 128, "echo \"+cpu\" > %s/cgroup.subtree_control", cgroup);
+	system(cmd);
+
+	/* launch two children, both running in child cgroup */
+	for (i = 0; i < 2; ++i) {
+		pid = fork();
+		if (pid == 0) {
+			/* attach to cgroup */
+			snprintf(cmd, 128, "echo %d > %s/cgroup.procs", getpid(), cgroup);
+			system(cmd);
+
+			/* pin process to target cpu */
+			snprintf(cmd, 128, "taskset -pc %d %d", cpu, getpid());
+			system(cmd);
+
+			spin_on_cpu(3); /* spin on cpu for 3 seconds */
+			exit(0);
+		}
+	}
+
+	/* pin parent process to target cpu */
+	snprintf(cmd, 128, "taskset -pc %d %d", cpu, getpid());
+	system(cmd);
+
+	spin_on_cpu(3); /* spin on cpu for 3 seconds */
+	wait(NULL);
+}
+
+/* Check reading cgroup stats from auto pinned objects
+ * @root: root directory in bpffs set up for this test
+ * @cgroup: cgroup path
+ */
+static void check_cgroup_stats(const char *root, const char *cgroup)
+{
+	unsigned long queue_self, queue_other;
+	char buf[64], path[64];
+	int id, cgroup_id;
+	FILE *file;
+
+	id = get_cgroup_id(cgroup);
+	if (!ASSERT_GE(id, 0, "get_cgroup_id"))
+		return;
+
+	snprintf(path, sizeof(path), "%s/%d/stats", root, id);
+	file = fopen(path, "r");
+	if (!ASSERT_OK_PTR(file, "open"))
+		return;
+
+	ASSERT_OK_PTR(fgets(buf, sizeof(buf), file), "cat");
+	ASSERT_EQ(sscanf(buf, "cgroup_id: %8d", &cgroup_id), 1, "output");
+	ASSERT_EQ(id, cgroup_id, "cgroup_id");
+
+	ASSERT_OK_PTR(fgets(buf, sizeof(buf), file), "cat");
+	ASSERT_EQ(sscanf(buf, "queue_self: %8lu", &queue_self), 1, "output");
+
+	ASSERT_OK_PTR(fgets(buf, sizeof(buf), file), "cat");
+	ASSERT_EQ(sscanf(buf, "queue_other: %8lu", &queue_other), 1, "output");
+	fclose(file);
+}
+
+/* Set up bpf progs for monitoring cgroup activities. */
+static void setup_cgroup_monitor(const char *root)
+{
+	struct cgroup_monitor *skel = NULL;
+
+	skel = cgroup_monitor__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_monitor_skel_load"))
+		return;
+
+	cgroup_monitor__attach(skel);
+
+	snprintf(skel->bss->root, sizeof(skel->bss->root), "%s", root);
+
+	snprintf(mkdir_prog_path, 64, "%s/mkdir_prog", root);
+	bpf_obj_pin(bpf_link__fd(skel->links.mkdir_prog), mkdir_prog_path);
+
+	snprintf(rmdir_prog_path, 64, "%s/rmdir_prog", root);
+	bpf_obj_pin(bpf_link__fd(skel->links.rmdir_prog), rmdir_prog_path);
+
+	cgroup_monitor__destroy(skel);
+}
+
+void test_cgroup_stats(void)
+{
+	char bpf_tmpl[] = "/sys/fs/bpf/XXXXXX";
+	char cgrp_tmpl[] = "/sys/fs/cgroup/XXXXXX";
+	struct cgroup_sched_lat *skel = NULL;
+	char *root, *cgroup;
+
+	/* prepare test directories */
+	system("mount -t cgroup2 none /sys/fs/cgroup");
+	system("mount -t bpf bpffs /sys/fs/bpf");
+	root = mkdtemp(bpf_tmpl);
+	chmod(root, 0777);
+
+	/* set up progs for monitoring cgroup events */
+	setup_cgroup_monitor(root);
+
+	/* set up progs for profiling cgroup stats */
+	skel = cgroup_sched_lat__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_sched_lat_skel_load"))
+		goto cleanup_root;
+
+	snprintf(dump_prog_path, 64, "%s/prog", root);
+	bpf_obj_pin(bpf_program__fd(skel->progs.dump_cgroup), dump_prog_path);
+	chmod(dump_prog_path, 0644);
+
+	cgroup_sched_lat__attach(skel);
+
+	/* thanks to cgroup monitoring progs, a directory corresponding to the
+	 * cgroup is created in bpffs.
+	 */
+	cgroup = mkdtemp(cgrp_tmpl);
+
+	/* collect some cgroup-level stats and check reading them from bpffs */
+	do_work(cgroup);
+	check_cgroup_stats(root, cgroup);
+
+	/* thanks to cgroup monitoring progs, removing cgroups also removes
+	 * the created directory in bpffs.
+	 */
+	rmdir(cgroup);
+
+	/* clean up cgroup monitoring progs */
+	cgroup_sched_lat__detach(skel);
+	cgroup_sched_lat__destroy(skel);
+	unlink(dump_prog_path);
+cleanup_root:
+	/* remove test directories in bpffs */
+	unlink(mkdir_prog_path);
+	unlink(rmdir_prog_path);
+	rmdir(root);
+	return;
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index 8cfaeba1ddbf..0d1bf954e831 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -16,6 +16,7 @@
 #define bpf_iter__bpf_map_elem bpf_iter__bpf_map_elem___not_used
 #define bpf_iter__bpf_sk_storage_map bpf_iter__bpf_sk_storage_map___not_used
 #define bpf_iter__sockmap bpf_iter__sockmap___not_used
+#define bpf_iter__cgroup bpf_iter__cgroup__not_used
 #define btf_ptr btf_ptr___not_used
 #define BTF_F_COMPACT BTF_F_COMPACT___not_used
 #define BTF_F_NONAME BTF_F_NONAME___not_used
@@ -37,6 +38,7 @@
 #undef bpf_iter__bpf_map_elem
 #undef bpf_iter__bpf_sk_storage_map
 #undef bpf_iter__sockmap
+#undef bpf_iter__cgroup
 #undef btf_ptr
 #undef BTF_F_COMPACT
 #undef BTF_F_NONAME
@@ -132,6 +134,11 @@ struct bpf_iter__sockmap {
 	struct sock *sk;
 };
 
+struct bpf_iter__cgroup {
+	struct bpf_iter_meta *meta;
+	struct cgroup *cgroup;
+} __attribute__((preserve_access_index));
+
 struct btf_ptr {
 	void *ptr;
 	__u32 type_id;
diff --git a/tools/testing/selftests/bpf/progs/cgroup_monitor.c b/tools/testing/selftests/bpf/progs/cgroup_monitor.c
new file mode 100644
index 000000000000..fa5debe1e15a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_monitor.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* root is the directory path. */
+char root[64];
+
+SEC("tp_btf.s/cgroup_mkdir_s")
+int BPF_PROG(mkdir_prog, struct cgroup *cgrp)
+{
+	static char dirname[64];
+	static char prog_path[64];
+	static char iter_path[64];
+	static union bpf_iter_link_info info;
+	static union bpf_attr get_attr;
+	static union bpf_attr link_attr;
+	static union bpf_attr pin_attr;
+	int link_fd, prog_fd, ret;
+	__u64 id;
+
+	/* create directory in bpffs named by cgroup's id. */
+	id = cgrp->kn->id;
+	BPF_SNPRINTF(dirname, sizeof(dirname), "%s/%lu", root, id);
+	ret = bpf_mkdir(dirname, sizeof(dirname), 0755);
+	if (ret)
+		return ret;
+
+	/* get cgroup iter prog pinned by test progs. */
+	BPF_SNPRINTF(prog_path, sizeof(prog_path), "%s/prog", root);
+	get_attr.bpf_fd = 0;
+	get_attr.pathname = (__u64)prog_path;
+	get_attr.file_flags = BPF_F_RDONLY;
+	prog_fd = bpf_sys_bpf(BPF_OBJ_GET, &get_attr, sizeof(get_attr));
+	if (prog_fd < 0)
+		return prog_fd;
+
+	/* create a link, parameterized by cgroup id. */
+	info.cgroup.cgroup_id = id;
+	link_attr.link_create.prog_fd = prog_fd;
+	link_attr.link_create.attach_type = BPF_TRACE_ITER;
+	link_attr.link_create.target_fd = 0;
+	link_attr.link_create.flags = 0;
+	link_attr.link_create.iter_info = (__u64)&info;
+	link_attr.link_create.iter_info_len = sizeof(info);
+	ret = bpf_sys_bpf(BPF_LINK_CREATE, &link_attr, sizeof(link_attr));
+	if (ret < 0) {
+		bpf_sys_close(prog_fd);
+		return ret;
+	}
+	link_fd = ret;
+
+	/* pin the link in the created directory */
+	BPF_SNPRINTF(iter_path, sizeof(iter_path), "%s/stats", dirname);
+	pin_attr.pathname = (__u64)iter_path;
+	pin_attr.bpf_fd = link_fd;
+	pin_attr.file_flags = 0;
+	ret = bpf_sys_bpf(BPF_OBJ_PIN, &pin_attr, sizeof(pin_attr));
+
+	bpf_sys_close(prog_fd);
+	bpf_sys_close(link_fd);
+	return ret;
+}
+
+SEC("tp_btf.s/cgroup_rmdir_s")
+int BPF_PROG(rmdir_prog, struct cgroup *cgrp)
+{
+	static char dirname[64];
+	static char path[64];
+
+	BPF_SNPRINTF(dirname, sizeof(dirname), "%s/%lu", root, cgrp->kn->id);
+	BPF_SNPRINTF(path, sizeof(path), "%s/stats", dirname);
+	bpf_unlink(path, sizeof(path));
+	return bpf_rmdir(dirname, sizeof(dirname));
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_sched_lat.c b/tools/testing/selftests/bpf/progs/cgroup_sched_lat.c
new file mode 100644
index 000000000000..90fe709377e1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_sched_lat.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define TASK_RUNNING 0
+#define BPF_F_CURRENT_CPU 0xffffffffULL
+
+extern void fair_sched_class __ksym;
+extern bool CONFIG_FAIR_GROUP_SCHED __kconfig;
+extern bool CONFIG_CGROUP_SCHED __kconfig;
+
+struct wait_lat {
+	/* Queue_self stands for the latency a task experiences while waiting
+	 * behind the tasks that are from the same cgroup.
+	 *
+	 * Queue_other stands for the latency a task experiences while waiting
+	 * behind the tasks that are from other cgroups.
+	 *
+	 * For example, if there are three tasks: A, B and C. Suppose A and B
+	 * are in the same cgroup and C is in another cgroup and we see A has
+	 * a queueing latency X milliseconds. Let's say during the X milliseconds,
+	 * B has run for Y milliseconds. We can break down X to two parts: time
+	 * when B is on cpu, that is Y; the time when C is on cpu, that is X - Y.
+	 *
+	 * Queue_self is the former (Y) while queue_other is the latter (X - Y).
+	 *
+	 * large value in queue_self is an indication of contention within a
+	 * cgroup; while large value in queue_other is an indication of
+	 * contention from multiple cgroups.
+	 */
+	u64 queue_self;
+	u64 queue_other;
+};
+
+struct timestamp {
+	/* timestamp when last queued */
+	u64 tsp;
+
+	/* cgroup exec_clock when last queued */
+	u64 exec_clock;
+};
+
+/* Map to store per-cgroup wait latency */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, u64);
+	__type(value, struct wait_lat);
+	__uint(max_entries, 65532);
+} cgroup_lat SEC(".maps");
+
+/* Map to store per-task queue timestamp */
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct timestamp);
+} start SEC(".maps");
+
+/* adapt from task_cfs_rq in kernel/sched/sched.h */
+__always_inline
+struct cfs_rq *task_cfs_rq(struct task_struct *t)
+{
+	if (!CONFIG_FAIR_GROUP_SCHED)
+		return NULL;
+
+	return BPF_CORE_READ(&t->se, cfs_rq);
+}
+
+/* record enqueue timestamp */
+__always_inline
+static int trace_enqueue(struct task_struct *t)
+{
+	u32 pid = t->pid;
+	struct timestamp *ptr;
+	struct cfs_rq *cfs_rq;
+
+	if (!pid)
+		return 0;
+
+	/* only measure for CFS tasks */
+	if (t->sched_class != &fair_sched_class)
+		return 0;
+
+	ptr = bpf_task_storage_get(&start, t, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+
+	/* CONFIG_FAIR_GROUP_SCHED may not be enabled */
+	cfs_rq = task_cfs_rq(t);
+	if (!cfs_rq)
+		return 0;
+
+	ptr->tsp = bpf_ktime_get_ns();
+	ptr->exec_clock = BPF_CORE_READ(cfs_rq, exec_clock);
+	return 0;
+}
+
+SEC("tp_btf/sched_wakeup")
+int handle__sched_wakeup(u64 *ctx)
+{
+	/* TP_PROTO(struct task_struct *p) */
+	struct task_struct *p = (void *)ctx[0];
+
+	return trace_enqueue(p);
+}
+
+SEC("tp_btf/sched_wakeup_new")
+int handle__sched_wakeup_new(u64 *ctx)
+{
+	/* TP_PROTO(struct task_struct *p) */
+	struct task_struct *p = (void *)ctx[0];
+
+	return trace_enqueue(p);
+}
+
+/* task_group() from kernel/sched/sched.h */
+__always_inline
+struct task_group *task_group(struct task_struct *p)
+{
+	if (!CONFIG_CGROUP_SCHED)
+		return NULL;
+
+	return BPF_CORE_READ(p, sched_task_group);
+}
+
+__always_inline
+struct cgroup *task_cgroup(struct task_struct *p)
+{
+	struct task_group *tg;
+
+	tg = task_group(p);
+	if (!tg)
+		return NULL;
+
+	return BPF_CORE_READ(tg, css).cgroup;
+}
+
+__always_inline
+u64 max(u64 x, u64 y)
+{
+	return x > y ? x : y;
+}
+
+SEC("tp_btf/sched_switch")
+int handle__sched_switch(u64 *ctx)
+{
+	/* TP_PROTO(bool preempt, struct task_struct *prev,
+	 *	    struct task_struct *next)
+	 */
+	struct task_struct *prev = (struct task_struct *)ctx[1];
+	struct task_struct *next = (struct task_struct *)ctx[2];
+	u64 delta, delta_self, delta_other, id;
+	struct cfs_rq *cfs_rq;
+	struct timestamp *tsp;
+	struct wait_lat *lat;
+	struct cgroup *cgroup;
+
+	/* ivcsw: treat like an enqueue event and store timestamp */
+	if (prev->__state == TASK_RUNNING)
+		trace_enqueue(prev);
+
+	/* only measure for CFS tasks */
+	if (next->sched_class != &fair_sched_class)
+		return 0;
+
+	/* fetch timestamp and calculate delta */
+	tsp = bpf_task_storage_get(&start, next, 0, 0);
+	if (!tsp)
+		return 0;   /* missed enqueue */
+
+	/* CONFIG_FAIR_GROUP_SCHED may not be enabled */
+	cfs_rq = task_cfs_rq(next);
+	if (!cfs_rq)
+		return 0;
+
+	/* cpu controller may not be enabled */
+	cgroup = task_cgroup(next);
+	if (!cgroup)
+		return 0;
+
+	/* calculate self delay and other delay */
+	delta = bpf_ktime_get_ns() - tsp->tsp;
+	delta_self = BPF_CORE_READ(cfs_rq, exec_clock) - tsp->exec_clock;
+	if (delta_self > delta)
+		delta_self = delta;
+	delta_other = delta - delta_self;
+
+	/* insert into cgroup_lat map */
+	id = BPF_CORE_READ(cgroup, kn, id);
+	lat = bpf_map_lookup_elem(&cgroup_lat, &id);
+	if (!lat) {
+		struct wait_lat w = {
+			.queue_self = delta_self,
+			.queue_other = delta_other,
+		};
+
+		bpf_map_update_elem(&cgroup_lat, &id, &w, BPF_ANY);
+	} else {
+		lat->queue_self = max(delta_self, lat->queue_self);
+		lat->queue_other = max(delta_other, lat->queue_other);
+	}
+
+	bpf_task_storage_delete(&start, next);
+	return 0;
+}
+
+SEC("iter/cgroup")
+int dump_cgroup(struct bpf_iter__cgroup *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct cgroup *cgroup = ctx->cgroup;
+	struct wait_lat *lat;
+	u64 id = cgroup->kn->id;
+
+	BPF_SEQ_PRINTF(seq, "cgroup_id: %8lu\n", id);
+	lat = bpf_map_lookup_elem(&cgroup_lat, &id);
+	if (lat) {
+		BPF_SEQ_PRINTF(seq, "queue_self: %8lu\n", lat->queue_self);
+		BPF_SEQ_PRINTF(seq, "queue_other: %8lu\n", lat->queue_other);
+	} else {
+		/* print anyway for universal parsing logic in userspace. */
+		BPF_SEQ_PRINTF(seq, "queue_self: %8d\n", 0);
+		BPF_SEQ_PRINTF(seq, "queue_other: %8d\n", 0);
+	}
+	return 0;
+}
-- 
2.35.1.574.g5d30c73bfb-goog

