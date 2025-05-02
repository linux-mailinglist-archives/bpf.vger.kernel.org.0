Return-Path: <bpf+bounces-57169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB44AA6667
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346929A025A
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D612517BE;
	Thu,  1 May 2025 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5/Guegb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD211F0990;
	Thu,  1 May 2025 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140019; cv=none; b=bR0LrZEjhASux5j2FhTGD4hG4ZOVwLVUmGWIQtdBmu/pzbDHhiQPqW/1GrbBniUp+bG3YJSDYWNzEIE/iKaipnWK6yzW/l/7myHMV2ZdmowBEh0M8kMrV7zsN18f6M1yg1GkJ8CzKUQRuUmE1Y63KbUgcb6i4GLhv82G7pk4G6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140019; c=relaxed/simple;
	bh=YdG+crROlfIYXjtOnNn9BxIcBkzTZdpY/njpp4zMggY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxqdIpjwaLU5kNyr3B7ur5+oBu3Q7B+76cN5EgLT8C5jBq9vY9+uW2Pbi5WJw3D21vAgXk97nypRjiseUUodjUt/Y7YYY0OMWGt3+mopCWvHPTmudAENh7Mbymhi1AuUT5LU4aEQXESQTOfBqe11K7HceOYb65WwI2zJArLhHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5/Guegb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB00C4CEED;
	Thu,  1 May 2025 22:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746140018;
	bh=YdG+crROlfIYXjtOnNn9BxIcBkzTZdpY/njpp4zMggY=;
	h=From:To:Cc:Subject:Date:From;
	b=t5/Guegbjym/Hwj+y+fdEErwiQTb7z3bAczBlr9dpIpGbjxN+koKk0+DfhSk+v2pk
	 M2anURJRol8gIzxcCJ19Ve5eQvsiQSa6GofK1NRolnpahzmnn8abyYtknxON18ugp1
	 /sycGlHSXPhzrAveei8PSIM981s4260x3i9sZ6mpca8XUw5E4l9GK/VGVV5WmCrTTb
	 zK+FivQmRlgoI5UAPV+kOoPe3wmOQWbzc6i9pnvXecCeyWmr+hDEY9i/mDoR9g70ZM
	 ds6q/UzXELg3wgIkmoKPUd/gFedujE8dgh0cJ5YfYSrEk+2mWHmhwOuR91nFc9Q9it
	 X8n9bu0L0OtfQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Support --summary-mode=cgroup
Date: Thu,  1 May 2025 15:53:37 -0700
Message-ID: <20250501225337.928470-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new summary mode to collect stats for each cgroup.

  $ sudo ./perf trace -as --bpf-summary --summary-mode=cgroup -- sleep 1

   Summary of events:

   cgroup /user.slice/user-657345.slice/user@657345.service/session.slice/org.gnome.Shell@x11.service, 535 events

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     ppoll                 15      0   373.600     0.004    24.907   197.491     55.26%
     poll                  15      0     1.325     0.001     0.088     0.369     38.76%
     close                 66      0     0.567     0.007     0.009     0.026      3.55%
     write                150      0     0.471     0.001     0.003     0.010      3.29%
     recvmsg               94     83     0.290     0.000     0.003     0.037     16.39%
     ioctl                 26      0     0.237     0.001     0.009     0.096     50.13%
     timerfd_create        66      0     0.236     0.003     0.004     0.024      8.92%
     timerfd_settime       70      0     0.160     0.001     0.002     0.012      7.66%
     writev                10      0     0.118     0.001     0.012     0.019     18.17%
     read                   9      0     0.021     0.001     0.002     0.004     14.07%
     getpid                14      0     0.019     0.000     0.001     0.004     20.28%

   cgroup /system.slice/polkit.service, 94 events

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     ppoll                 22      0    19.811     0.000     0.900     9.273     63.88%
     write                 30      0     0.040     0.001     0.001     0.003     12.09%
     recvmsg               12      0     0.018     0.001     0.002     0.006     28.15%
     read                  18      0     0.013     0.000     0.001     0.003     21.99%
     poll                  12      0     0.006     0.000     0.001     0.001      4.48%

   cgroup /user.slice/user-657345.slice/user@657345.service/app.slice/app-org.gnome.Terminal.slice/gnome-terminal-server.service, 21 events

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     ppoll                  4      0    17.476     0.003     4.369    13.298     69.65%
     recvmsg               15     12     0.068     0.002     0.005     0.014     26.53%
     writev                 1      0     0.033     0.033     0.033     0.033      0.00%
     poll                   1      0     0.005     0.005     0.005     0.005      0.00%

   ...

It works only for --bpf-summary for now.

Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-trace.txt       |   3 +-
 tools/perf/builtin-trace.c                    |  10 +-
 tools/perf/util/bpf-trace-summary.c           | 123 +++++++++++++++++-
 .../perf/util/bpf_skel/syscall_summary.bpf.c  |  43 +++++-
 tools/perf/util/bpf_skel/syscall_summary.h    |   2 +
 tools/perf/util/trace.h                       |   1 +
 6 files changed, 170 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index a8a0d8c33438fef7..c1fb6056a0d36dda 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -152,7 +152,8 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 
 --summary-mode=mode::
 	To be used with -s or -S, to select how to show summary.  By default it'll
-	show the syscall summary by thread.  Possible values are: thread, total.
+	show the syscall summary by thread.  Possible values are: thread, total,
+	cgroup.
 
 --tool_stats::
 	Show tool stats such as number of times fd->pathname was discovered thru
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b2c5a9b765ab5d33..83c62c30d914306c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5301,6 +5301,8 @@ static int trace__parse_summary_mode(const struct option *opt, const char *str,
 		trace->summary_mode = SUMMARY__BY_THREAD;
 	} else if (!strcmp(str, "total")) {
 		trace->summary_mode = SUMMARY__BY_TOTAL;
+	} else if (!strcmp(str, "cgroup")) {
+		trace->summary_mode = SUMMARY__BY_CGROUP;
 	} else {
 		pr_err("Unknown summary mode: %s\n", str);
 		return -1;
@@ -5460,7 +5462,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_BOOLEAN(0, "errno-summary", &trace.errno_summary,
 		    "Show errno stats per syscall, use with -s or -S"),
 	OPT_CALLBACK(0, "summary-mode", &trace, "mode",
-		     "How to show summary: select thread (default) or total",
+		     "How to show summary: select thread (default), total or cgroup",
 		     trace__parse_summary_mode),
 	OPT_CALLBACK_DEFAULT('F', "pf", &trace.trace_pgfaults, "all|maj|min",
 		     "Trace pagefaults", parse_pagefaults, "maj"),
@@ -5774,6 +5776,12 @@ int cmd_trace(int argc, const char **argv)
 		symbol_conf.keep_exited_threads = true;
 		if (trace.summary_mode == SUMMARY__NONE)
 			trace.summary_mode = SUMMARY__BY_THREAD;
+
+		if (!trace.summary_bpf && trace.summary_mode == SUMMARY__BY_CGROUP) {
+			pr_err("Error: --summary-mode=cgroup only works with --bpf-summary\n");
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (output_name != NULL) {
diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
index 114d8d9ed9b2d3f3..69fb165da206b01f 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -6,10 +6,12 @@
 
 #include "dwarf-regs.h" /* for EM_HOST */
 #include "syscalltbl.h"
+#include "util/cgroup.h"
 #include "util/hashmap.h"
 #include "util/trace.h"
 #include "util/util.h"
 #include <bpf/bpf.h>
+#include <linux/rbtree.h>
 #include <linux/time64.h>
 #include <tools/libc_compat.h> /* reallocarray */
 
@@ -18,6 +20,7 @@
 
 
 static struct syscall_summary_bpf *skel;
+static struct rb_root cgroups = RB_ROOT;
 
 int trace_prepare_bpf_summary(enum trace_summary_mode mode)
 {
@@ -29,9 +32,14 @@ int trace_prepare_bpf_summary(enum trace_summary_mode mode)
 
 	if (mode == SUMMARY__BY_THREAD)
 		skel->rodata->aggr_mode = SYSCALL_AGGR_THREAD;
+	else if (mode == SUMMARY__BY_CGROUP)
+		skel->rodata->aggr_mode = SYSCALL_AGGR_CGROUP;
 	else
 		skel->rodata->aggr_mode = SYSCALL_AGGR_CPU;
 
+	if (cgroup_is_v2("perf_event") > 0)
+		skel->rodata->use_cgroup_v2 = 1;
+
 	if (syscall_summary_bpf__load(skel) < 0) {
 		fprintf(stderr, "failed to load syscall summary bpf skeleton\n");
 		return -1;
@@ -42,6 +50,9 @@ int trace_prepare_bpf_summary(enum trace_summary_mode mode)
 		return -1;
 	}
 
+	if (mode == SUMMARY__BY_CGROUP)
+		read_all_cgroups(&cgroups);
+
 	return 0;
 }
 
@@ -88,9 +99,13 @@ static double rel_stddev(struct syscall_stats *stat)
  * per-cpu analysis so it's keyed by the syscall number to combine stats
  * from different CPUs.  And syscall_data always has a syscall_node so
  * it can effectively work as flat hierarchy.
+ *
+ * For per-cgroup stats, it uses two-level data structure like thread
+ * syscall_data is keyed by CGROUP and has an array of node which
+ * represents each syscall for the cgroup.
  */
 struct syscall_data {
-	int key; /* tid if AGGR_THREAD, syscall-nr if AGGR_CPU */
+	u64 key; /* tid if AGGR_THREAD, syscall-nr if AGGR_CPU, cgroup if AGGR_CGROUP */
 	int nr_events;
 	int nr_nodes;
 	u64 total_time;
@@ -191,7 +206,7 @@ static int print_thread_stat(struct syscall_data *data, FILE *fp)
 
 	qsort(data->nodes, data->nr_nodes, sizeof(*data->nodes), nodecmp);
 
-	printed += fprintf(fp, " thread (%d), ", data->key);
+	printed += fprintf(fp, " thread (%d), ", (int)data->key);
 	printed += fprintf(fp, "%d events\n\n", data->nr_events);
 
 	printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");
@@ -283,6 +298,75 @@ static int print_total_stats(struct syscall_data **data, int nr_data, FILE *fp)
 	return printed;
 }
 
+static int update_cgroup_stats(struct hashmap *hash, struct syscall_key *map_key,
+			       struct syscall_stats *map_data)
+{
+	struct syscall_data *data;
+	struct syscall_node *nodes;
+
+	if (!hashmap__find(hash, map_key->cgroup, &data)) {
+		data = zalloc(sizeof(*data));
+		if (data == NULL)
+			return -ENOMEM;
+
+		data->key = map_key->cgroup;
+		if (hashmap__add(hash, data->key, data) < 0) {
+			free(data);
+			return -ENOMEM;
+		}
+	}
+
+	/* update thread total stats */
+	data->nr_events += map_data->count;
+	data->total_time += map_data->total_time;
+
+	nodes = reallocarray(data->nodes, data->nr_nodes + 1, sizeof(*nodes));
+	if (nodes == NULL)
+		return -ENOMEM;
+
+	data->nodes = nodes;
+	nodes = &data->nodes[data->nr_nodes++];
+	nodes->syscall_nr = map_key->nr;
+
+	/* each thread has an entry for each syscall, just use the stat */
+	memcpy(&nodes->stats, map_data, sizeof(*map_data));
+	return 0;
+}
+
+static int print_cgroup_stat(struct syscall_data *data, FILE *fp)
+{
+	int printed = 0;
+	struct cgroup *cgrp = __cgroup__find(&cgroups, data->key);
+
+	qsort(data->nodes, data->nr_nodes, sizeof(*data->nodes), nodecmp);
+
+	if (cgrp)
+		printed += fprintf(fp, " cgroup %s,", cgrp->name);
+	else
+		printed += fprintf(fp, " cgroup id:%lu,", (unsigned long)data->key);
+
+	printed += fprintf(fp, " %d events\n\n", data->nr_events);
+
+	printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");
+	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
+	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
+
+	printed += print_common_stats(data, fp);
+	printed += fprintf(fp, "\n\n");
+
+	return printed;
+}
+
+static int print_cgroup_stats(struct syscall_data **data, int nr_data, FILE *fp)
+{
+	int printed = 0;
+
+	for (int i = 0; i < nr_data; i++)
+		printed += print_cgroup_stat(data[i], fp);
+
+	return printed;
+}
+
 int trace_print_bpf_summary(FILE *fp)
 {
 	struct bpf_map *map = skel->maps.syscall_stats_map;
@@ -305,10 +389,19 @@ int trace_print_bpf_summary(FILE *fp)
 		struct syscall_stats stat;
 
 		if (!bpf_map__lookup_elem(map, &key, sizeof(key), &stat, sizeof(stat), 0)) {
-			if (skel->rodata->aggr_mode == SYSCALL_AGGR_THREAD)
+			switch (skel->rodata->aggr_mode) {
+			case SYSCALL_AGGR_THREAD:
 				update_thread_stats(&schash, &key, &stat);
-			else
+				break;
+			case SYSCALL_AGGR_CPU:
 				update_total_stats(&schash, &key, &stat);
+				break;
+			case SYSCALL_AGGR_CGROUP:
+				update_cgroup_stats(&schash, &key, &stat);
+				break;
+			default:
+				break;
+			}
 		}
 
 		prev_key = &key;
@@ -325,10 +418,19 @@ int trace_print_bpf_summary(FILE *fp)
 
 	qsort(data, nr_data, sizeof(*data), datacmp);
 
-	if (skel->rodata->aggr_mode == SYSCALL_AGGR_THREAD)
+	switch (skel->rodata->aggr_mode) {
+	case SYSCALL_AGGR_THREAD:
 		printed += print_thread_stats(data, nr_data, fp);
-	else
+		break;
+	case SYSCALL_AGGR_CPU:
 		printed += print_total_stats(data, nr_data, fp);
+		break;
+	case SYSCALL_AGGR_CGROUP:
+		printed += print_cgroup_stats(data, nr_data, fp);
+		break;
+	default:
+		break;
+	}
 
 	for (i = 0; i < nr_data && data; i++) {
 		free(data[i]->nodes);
@@ -343,5 +445,14 @@ int trace_print_bpf_summary(FILE *fp)
 
 void trace_cleanup_bpf_summary(void)
 {
+	if (!RB_EMPTY_ROOT(&cgroups)) {
+		struct cgroup *cgrp, *tmp;
+
+		rbtree_postorder_for_each_entry_safe(cgrp, tmp, &cgroups, node)
+			cgroup__put(cgrp);
+
+		cgroups = RB_ROOT;
+	}
+
 	syscall_summary_bpf__destroy(skel);
 }
diff --git a/tools/perf/util/bpf_skel/syscall_summary.bpf.c b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
index b25f53b3c1351392..1bcd066a5199a476 100644
--- a/tools/perf/util/bpf_skel/syscall_summary.bpf.c
+++ b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
@@ -8,6 +8,7 @@
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 
 /* This is to calculate a delta between sys-enter and sys-exit for each thread */
 struct syscall_trace {
@@ -35,10 +36,41 @@ struct syscall_stats_map {
 int enabled; /* controlled from userspace */
 
 const volatile enum syscall_aggr_mode aggr_mode;
+const volatile int use_cgroup_v2;
 
-static void update_stats(int cpu_or_tid, int nr, s64 duration, long ret)
+int perf_subsys_id = -1;
+
+static inline __u64 get_current_cgroup_id(void)
+{
+	struct task_struct *task;
+	struct cgroup *cgrp;
+
+	if (use_cgroup_v2)
+		return bpf_get_current_cgroup_id();
+
+	task = bpf_get_current_task_btf();
+
+	if (perf_subsys_id == -1) {
+#if __has_builtin(__builtin_preserve_enum_value)
+		perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
+						     perf_event_cgrp_id);
+#else
+		perf_subsys_id = perf_event_cgrp_id;
+#endif
+	}
+
+	cgrp = BPF_CORE_READ(task, cgroups, subsys[perf_subsys_id], cgroup);
+	return BPF_CORE_READ(cgrp, kn, id);
+}
+
+static void update_stats(int cpu_or_tid, u64 cgroup_id, int nr, s64 duration,
+			 long ret)
 {
-	struct syscall_key key = { .cpu_or_tid = cpu_or_tid, .nr = nr, };
+	struct syscall_key key = {
+		.cpu_or_tid = cpu_or_tid,
+		.cgroup = cgroup_id,
+		.nr = nr,
+	};
 	struct syscall_stats *stats;
 
 	stats = bpf_map_lookup_elem(&syscall_stats_map, &key);
@@ -90,7 +122,8 @@ SEC("tp_btf/sys_exit")
 int sys_exit(u64 *ctx)
 {
 	int tid;
-	int key;
+	int key = 0;
+	u64 cgroup = 0;
 	long ret = ctx[1]; /* return value of the syscall */
 	struct syscall_trace *st;
 	s64 delta;
@@ -105,11 +138,13 @@ int sys_exit(u64 *ctx)
 
 	if (aggr_mode == SYSCALL_AGGR_THREAD)
 		key = tid;
+	else if (aggr_mode == SYSCALL_AGGR_CGROUP)
+		cgroup = get_current_cgroup_id();
 	else
 		key = bpf_get_smp_processor_id();
 
 	delta = bpf_ktime_get_ns() - st->timestamp;
-	update_stats(key, st->nr, delta, ret);
+	update_stats(key, cgroup, st->nr, delta, ret);
 
 	bpf_map_delete_elem(&syscall_trace_map, &tid);
 	return 0;
diff --git a/tools/perf/util/bpf_skel/syscall_summary.h b/tools/perf/util/bpf_skel/syscall_summary.h
index 17f9ecba657088aa..72ccccb45925cd10 100644
--- a/tools/perf/util/bpf_skel/syscall_summary.h
+++ b/tools/perf/util/bpf_skel/syscall_summary.h
@@ -6,9 +6,11 @@
 enum syscall_aggr_mode {
 	SYSCALL_AGGR_THREAD,
 	SYSCALL_AGGR_CPU,
+	SYSCALL_AGGR_CGROUP,
 };
 
 struct syscall_key {
+	u64 cgroup;
 	int cpu_or_tid;
 	int nr;
 };
diff --git a/tools/perf/util/trace.h b/tools/perf/util/trace.h
index ef8361ed12c4edc1..fa8d480527a22cef 100644
--- a/tools/perf/util/trace.h
+++ b/tools/perf/util/trace.h
@@ -8,6 +8,7 @@ enum trace_summary_mode {
 	SUMMARY__NONE = 0,
 	SUMMARY__BY_TOTAL,
 	SUMMARY__BY_THREAD,
+	SUMMARY__BY_CGROUP,
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.49.0.906.g1f30a19c02-goog


