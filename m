Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB14A668F
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 21:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiBAUzy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 15:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiBAUzw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 15:55:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A08C06173B
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 12:55:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so35664485ybb.0
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 12:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pL1E8fJxKw13cCsiOnlzxl+3OEwkHyaKnHI4u2VvDps=;
        b=iLwxZIv5uqjajpGnCS3rmRzTL28QDNo1wzcLG4pKrQAIir+6+XS5Oth4WrIeoROhaC
         K4x9s+1s0lVKIYmOYxqRr2YllIsLUD/Fd2Kr/4loQYX1M8KrWo+hswzpdIkl0MOVnLI5
         qyyQptR7MsdpfC7LZCBs+JmxPf700zWwkxD6xiTZRkk8IcluJD7XR60iDT01WAl6DP+G
         ygG2vSjX8X5sGmeHwzxsFlPFFeaxnrVNuesRujenB9aTqUvV2ILCLTW4bckP+y9yJhuw
         HejzUN2pY4TY054MLd4OIijtaAGbHt0mdUDYd2hE2Iywrk/r50G5z4cfcIE5K7DBjaNO
         +a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pL1E8fJxKw13cCsiOnlzxl+3OEwkHyaKnHI4u2VvDps=;
        b=quDmCh64flj2plZt4Qfou0mIryFx71ROYRklJS40Nt5cSZKEoOLyzdvIK1HXgVnFP+
         MAGGxGCM2hRIl03UIzDsUYmhsnRyF3kNEOPwo9QH+X4aPJAD5Thk+iWWz9B9R0FWYpwe
         FrdmZ21b25JJ5Ir+f4fB5ZWCSlvSBJL/jDSroNjqo07FTq7gz0OYvPLb331z//iQWF2k
         3X56HD+cEtDRN4HsNsZ8Tuxaor9SzviMmqT2HsS/wKy7sZt26ksMTc7+Mil3KRVc153H
         bkLr9neiPtpaKXUPA4ij0ZOjLJU7i90xWwKjKOCFm6A4KuOt7pUmJjurRWMfDCYKfvRR
         QNTw==
X-Gm-Message-State: AOAM5323OS68403w4Wxt9exzO8ArSXr/ukDujV+6D+jICqYCOZ8+5V0U
        wQ4tGBSJJKkG9JotK8BQ3IlvOiehOeY=
X-Google-Smtp-Source: ABdhPJx2K4/2udytZZXqNqYSXlX+Tejacq3qe7zEpZvsjURu1Lo9LnFuORhx1dED7XoxakLOdMSUBRGlftA=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:1cdb:a263:2495:80fd])
 (user=haoluo job=sendgmr) by 2002:a25:c5cc:: with SMTP id v195mr41095321ybe.373.1643748951613;
 Tue, 01 Feb 2022 12:55:51 -0800 (PST)
Date:   Tue,  1 Feb 2022 12:55:34 -0800
In-Reply-To: <20220201205534.1962784-1-haoluo@google.com>
Message-Id: <20220201205534.1962784-6-haoluo@google.com>
Mime-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH RFC bpf-next v2 5/5] selftests/bpf: test for pinning for
 cgroup_view link
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A selftest for demo/testing cgroup_view pinning, directory tagging and
cat cgroup_view pinned objects. The added cgroup_view prog is a naive
use case, which merely reads the cgroup's id.

This selftest introduces two metrics for measuring cgroup-level
scheduling queuing delays:

 - queue_self: queueing delays caused by waiting behind self cgroup.
 - queue_other: queueing delays caused by waiting behind other cgroups.

The selftest collects task-level queuing delays and breaks them into
queue_self delays and queue_other delays. This is done by hooking at
handlers at context switch and wakeup. Only the max queue_self and
queue_other delays are recorded. This breakdown is helpful in analyzing
the cause of long scheduling delays. Large value in queue_self is an
indication of contention that comes from within the cgroup. Large value
in queue_other indicates contention between cgroups.

A new iter prog type cgroup_view is implemented "dump_cgropu_lat", which
reads the recorded delays and dumps the stats through bpffs interfaces.
Specifically, cgroup_view is initially pinned in an empty directory
bpffs, which effectively turns the directory into a mirror of the cgroup
hierarchy. When a new cgroup is created, we manually created a new
directory in bpffs in correspondence. The new directory will contain
a file prepopulated with the pinned cgroup_view object. Reading that
file yields the queue stats of the corresponding cgroup.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../selftests/bpf/prog_tests/pinning_cgroup.c | 143 +++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../bpf/progs/bpf_iter_cgroup_view.c          | 232 ++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_cgroup_view.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pinning_cgroup.c b/tools/testing/selftests/bpf/prog_tests/pinning_cgroup.c
new file mode 100644
index 000000000000..ebef154e63c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pinning_cgroup.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <test_progs.h>
+#include <time.h>
+#include <unistd.h>
+#include "bpf_iter_cgroup_view.skel.h"
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
+	/* try to enable cpu controller. this may fail if there cpu controller
+	 * is not available in cgroup.controllers or there is a cgroup v1 already
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
+	/* pin process to target cpu */
+	snprintf(cmd, 128, "taskset -pc %d %d", cpu, getpid());
+	system(cmd);
+
+	spin_on_cpu(3); /* spin on cpu for 3 seconds */
+	wait(NULL);
+}
+
+static void check_pinning(const char *rootpath)
+{
+	const char *child_cgroup = "/sys/fs/cgroup/child";
+	struct bpf_iter_cgroup_view *skel;
+	struct bpf_link *link;
+	struct stat statbuf = {};
+	FILE *file;
+	unsigned long queue_self, queue_other;
+	int cgroup_id, link_fd;
+	char path[64];
+	char buf[64];
+
+	skel = bpf_iter_cgroup_view__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_cgroup_view__open_and_load"))
+		return;
+
+	/* pin path at parent dir. */
+	link = bpf_program__attach_iter(skel->progs.dump_cgroup_lat, NULL);
+	link_fd = bpf_link__fd(link);
+
+	/* test initial pinning */
+	snprintf(path, 64, "%s/obj", rootpath);
+	ASSERT_OK(bpf_obj_pin(link_fd, path), "bpf_obj_pin");
+	ASSERT_OK(stat(path, &statbuf), "pinned_object_exists");
+
+	/* test mkdir */
+	mkdir(child_cgroup, 0755);
+	snprintf(path, 64, "%s/child", rootpath);
+	ASSERT_OK(mkdir(path, 0755), "mkdir");
+
+	/* test that new dir has been pre-populated with pinned objects */
+	snprintf(path, 64, "%s/child/obj", rootpath);
+	ASSERT_OK(stat(path, &statbuf), "populate");
+
+	bpf_iter_cgroup_view__attach(skel);
+	do_work(child_cgroup);
+	bpf_iter_cgroup_view__detach(skel);
+
+	/* test cat inherited objects */
+	file = fopen(path, "r");
+	if (ASSERT_OK_PTR(file, "open")) {
+		ASSERT_OK_PTR(fgets(buf, sizeof(buf), file), "cat");
+		ASSERT_EQ(sscanf(buf, "cgroup_id: %8d", &cgroup_id), 1, "output");
+
+		ASSERT_OK_PTR(fgets(buf, sizeof(buf), file), "cat");
+		ASSERT_EQ(sscanf(buf, "queue_self: %8lu", &queue_self), 1, "output");
+
+		ASSERT_OK_PTR(fgets(buf, sizeof(buf), file), "cat");
+		ASSERT_EQ(sscanf(buf, "queue_other: %8lu", &queue_other), 1, "output");
+
+		fclose(file);
+	}
+
+	/* test rmdir */
+	snprintf(path, 64, "%s/child", rootpath);
+	ASSERT_OK(rmdir(path), "rmdir");
+
+	/* unpin object */
+	snprintf(path, 64, "%s/obj", rootpath);
+	ASSERT_OK(unlink(path), "unlink");
+
+	bpf_link__destroy(link);
+	bpf_iter_cgroup_view__destroy(skel);
+}
+
+void test_pinning_cgroup(void)
+{
+	char tmpl[] = "/sys/fs/bpf/pinning_test_XXXXXX";
+	char *rootpath;
+
+	system("mount -t cgroup2 none /sys/fs/cgroup");
+	system("mount -t bpf bpffs /sys/fs/bpf");
+
+	rootpath = mkdtemp(tmpl);
+	chmod(rootpath, 0755);
+
+	/* check pinning map, prog and link in kernfs */
+	if (test__start_subtest("pinning"))
+		check_pinning(rootpath);
+
+	rmdir(rootpath);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index 8cfaeba1ddbf..506bb3efd9b4 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -16,6 +16,7 @@
 #define bpf_iter__bpf_map_elem bpf_iter__bpf_map_elem___not_used
 #define bpf_iter__bpf_sk_storage_map bpf_iter__bpf_sk_storage_map___not_used
 #define bpf_iter__sockmap bpf_iter__sockmap___not_used
+#define bpf_iter__cgroup_view bpf_iter__cgroup_view___not_used
 #define btf_ptr btf_ptr___not_used
 #define BTF_F_COMPACT BTF_F_COMPACT___not_used
 #define BTF_F_NONAME BTF_F_NONAME___not_used
@@ -37,6 +38,7 @@
 #undef bpf_iter__bpf_map_elem
 #undef bpf_iter__bpf_sk_storage_map
 #undef bpf_iter__sockmap
+#undef bpf_iter__cgroup_view
 #undef btf_ptr
 #undef BTF_F_COMPACT
 #undef BTF_F_NONAME
@@ -132,6 +134,11 @@ struct bpf_iter__sockmap {
 	struct sock *sk;
 };
 
+struct bpf_iter__cgroup_view {
+	struct bpf_iter_meta *meta;
+	struct cgroup *cgroup;
+} __attribute__((preserve_access_index));
+
 struct btf_ptr {
 	void *ptr;
 	__u32 type_id;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_cgroup_view.c b/tools/testing/selftests/bpf/progs/bpf_iter_cgroup_view.c
new file mode 100644
index 000000000000..43404c21aee3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_cgroup_view.c
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
+SEC("iter/cgroup_view")
+int dump_cgroup_lat(struct bpf_iter__cgroup_view *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct cgroup *cgroup = ctx->cgroup;
+	struct wait_lat *lat;
+	u64 id;
+
+	BPF_SEQ_PRINTF(seq, "cgroup_id: %8lu\n", cgroup->kn->id);
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
2.35.0.rc2.247.g8bbb082509-goog

