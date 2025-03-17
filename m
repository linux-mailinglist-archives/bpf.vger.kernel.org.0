Return-Path: <bpf+bounces-54232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D252FA65BF1
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92AD880E77
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6231A7AF7;
	Mon, 17 Mar 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLqju+RQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2D1527B4;
	Mon, 17 Mar 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234916; cv=none; b=lB3zsvmAXByJl2skrFLCpaLHf0k8ioQzwJ7hMqy8Ok0gzpygIDSY2o/1TnNDOy9qPsAWeFPFxTbUYkP+I11aq+A49ZpWWVzMxM1bMU/eMeZhrGu/+NV2QSWNxEa/rI49JmszTuVuRBaneBQXGkHuERf2sBE+/OJaDSe5Y8+WoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234916; c=relaxed/simple;
	bh=RYab/OVQxmx1BmSaOf80ZjwxXGzMOBWnUaWi1psJ7r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hp+aEI1Kt1Pi/udXGnsj2WB7bkCBQjlqyRPF3ME5yN02vN+wu5Yxs3mWKPnBMsQXZZIRiWdu81djxoZFDrLoF7RV4GvYRb8B4RkENf8TsdFCkpw7C8Q9coqsrnjyeVUZKGYZXGRtT6wq69Q3fkgIRVYdP6acI4cJrIsBPKOGpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLqju+RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBDCC4CEED;
	Mon, 17 Mar 2025 18:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234915;
	bh=RYab/OVQxmx1BmSaOf80ZjwxXGzMOBWnUaWi1psJ7r0=;
	h=From:To:Cc:Subject:Date:From;
	b=uLqju+RQWrgD2KTQcSeT4VdT1DYfyrEnYUK483SJKkGc0Ad26kj3w6aGcZZjgDNTl
	 e5+cl3FuSeJ5rzWXPN+42zlZC5phmiD3ny7lM1lt1JjoAGncDd2HFw31v+v1tQeY0U
	 axDU2Ud45SddST7nSxfnYu4ciIZlKsEyKMNAmoi3yuYq5Ji7vTU4D5aEduB2fs5OP+
	 PqnCOX7aTwoWI5E9PqTmdExedrbY9XxY7eKSB68wOHMXpGldu7cAjXG3KFBnYTWLW+
	 jpn1bT3K+EJ+zLUEqK0GSJPBtcsv/OOo/y6wT2Hxi3rOA8h/18csRTpyFZm0p+6Y7y
	 YG3R2QZiHWiiw==
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
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2] perf trace: Implement syscall summary in BPF
Date: Mon, 17 Mar 2025 11:08:34 -0700
Message-ID: <20250317180834.1862079-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When -s/--summary option is used, it doesn't need (augmented) arguments
of syscalls.  Let's skip the augmentation and load another small BPF
program to collect the statistics in the kernel instead of copying the
data to the ring-buffer to calculate the stats in userspace.  This will
be much more light-weight than the existing approach and remove any lost
events.

Let's add a new option --bpf-summary to control this behavior.  I cannot
make it default because there's no way to get e_machine in the BPF which
is needed for detecting different ABIs like 32-bit compat mode.

No functional changes intended except for no more LOST events. :)

  $ sudo perf trace -as --bpf-summary --summary-mode=total -- sleep 1

   Summary of events:

   total, 2824 events

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     futex                372     18  4373.773     0.000    11.757   997.715    660.42%
     poll                 241      0  2757.963     0.000    11.444   997.758    580.34%
     epoll_wait           161      0  2460.854     0.000    15.285   325.189    260.73%
     ppoll                 19      0  1298.652     0.000    68.350   667.172    281.46%
     clock_nanosleep        1      0  1000.093     0.000  1000.093  1000.093      0.00%
     epoll_pwait           16      0   192.787     0.000    12.049   173.994    348.73%
     nanosleep              6      0    50.926     0.000     8.488    10.210     43.96%
     ...

Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2)
 * rebased on top of Ian's e_machine changes
 * add --bpf-summary option
 * support per-thread summary
 * add stddev calculation  (Howard)

 tools/perf/Documentation/perf-trace.txt       |   6 +
 tools/perf/Makefile.perf                      |   2 +-
 tools/perf/builtin-trace.c                    |  43 ++-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf-trace-summary.c           | 334 ++++++++++++++++++
 .../perf/util/bpf_skel/syscall_summary.bpf.c  | 118 +++++++
 tools/perf/util/bpf_skel/syscall_summary.h    |  25 ++
 tools/perf/util/trace.h                       |  37 ++
 8 files changed, 553 insertions(+), 13 deletions(-)
 create mode 100644 tools/perf/util/bpf-trace-summary.c
 create mode 100644 tools/perf/util/bpf_skel/syscall_summary.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/syscall_summary.h
 create mode 100644 tools/perf/util/trace.h

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 887dc37773d0f4d6..a8a0d8c33438fef7 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -251,6 +251,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
 	better pretty-print integer flags and struct pointers.
 
+--bpf-summary::
+	Collect system call statistics in BPF.  This is only for live mode and
+	works well with -s/--summary option where no argument information is
+	required.
+
+
 PAGEFAULTS
 ----------
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f3cd8de15d1a2681..d7a7e0c68fc10b8b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1206,7 +1206,7 @@ SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
-SKELETONS += $(SKEL_OUT)/kwork_top.skel.h
+SKELETONS += $(SKEL_OUT)/kwork_top.skel.h $(SKEL_OUT)/syscall_summary.skel.h
 SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
 SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7fef59306db2891f..deeb7250e8c52354 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -55,6 +55,7 @@
 #include "util/thread_map.h"
 #include "util/stat.h"
 #include "util/tool.h"
+#include "util/trace.h"
 #include "util/util.h"
 #include "trace/beauty/beauty.h"
 #include "trace-event.h"
@@ -141,12 +142,6 @@ struct syscall_fmt {
 	bool	   hexret;
 };
 
-enum summary_mode {
-	SUMMARY__NONE = 0,
-	SUMMARY__BY_TOTAL,
-	SUMMARY__BY_THREAD,
-};
-
 struct trace {
 	struct perf_tool	tool;
 	struct {
@@ -205,7 +200,7 @@ struct trace {
 	} stats;
 	unsigned int		max_stack;
 	unsigned int		min_stack;
-	enum summary_mode	summary_mode;
+	enum trace_summary_mode	summary_mode;
 	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
 	bool			fd_path_disabled;
@@ -234,6 +229,7 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	bool			force_btf;
+	bool			summary_bpf;
 	int			trace_pgfaults;
 	char			*perfconfig_events;
 	struct {
@@ -4356,6 +4352,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	trace->live = true;
 
+	if (trace->summary_bpf) {
+		if (trace_prepare_bpf_summary(trace->summary_mode) < 0)
+			goto out_delete_evlist;
+
+		goto create_maps;
+	}
+
 	if (!trace->raw_augmented_syscalls) {
 		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
 			goto out_error_raw_syscalls;
@@ -4414,6 +4417,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->cgroup)
 		evlist__set_default_cgroup(trace->evlist, trace->cgroup);
 
+create_maps:
 	err = evlist__create_maps(evlist, &trace->opts.target);
 	if (err < 0) {
 		fprintf(trace->output, "Problems parsing the target to trace, check your options!\n");
@@ -4426,7 +4430,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	if (trace->summary_mode == SUMMARY__BY_TOTAL) {
+	if (trace->summary_mode == SUMMARY__BY_TOTAL && !trace->summary_bpf) {
 		trace->syscall_stats = alloc_syscall_stats();
 		if (trace->syscall_stats == NULL)
 			goto out_delete_evlist;
@@ -4512,9 +4516,11 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_apply_filters;
 
-	err = evlist__mmap(evlist, trace->opts.mmap_pages);
-	if (err < 0)
-		goto out_error_mmap;
+	if (!trace->summary_bpf) {
+		err = evlist__mmap(evlist, trace->opts.mmap_pages);
+		if (err < 0)
+			goto out_error_mmap;
+	}
 
 	if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
 		evlist__enable(evlist);
@@ -4527,6 +4533,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		evlist__enable(evlist);
 	}
 
+	if (trace->summary_bpf)
+		trace_start_bpf_summary();
+
 	trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
 		perf_thread_map__nr(evlist->core.threads) > 1 ||
 		evlist__first(evlist)->core.attr.inherit;
@@ -4594,12 +4603,17 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	evlist__disable(evlist);
 
+	if (trace->summary_bpf)
+		trace_end_bpf_summary();
+
 	if (trace->sort_events)
 		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
 
 	if (!err) {
 		if (trace->summary) {
-			if (trace->summary_mode == SUMMARY__BY_TOTAL)
+			if (trace->summary_bpf)
+				trace_print_bpf_summary(trace->output);
+			else if (trace->summary_mode == SUMMARY__BY_TOTAL)
 				trace__fprintf_total_summary(trace, trace->output);
 			else
 				trace__fprintf_thread_summary(trace, trace->output);
@@ -4615,6 +4629,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	}
 
 out_delete_evlist:
+	trace_cleanup_bpf_summary();
 	delete_syscall_stats(trace->syscall_stats);
 	trace__symbols__exit(trace);
 	evlist__free_syscall_tp_fields(evlist);
@@ -5444,6 +5459,7 @@ int cmd_trace(int argc, const char **argv)
 		     "start"),
 	OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump general pretty printer"
 		       "to customized ones"),
+	OPT_BOOLEAN(0, "bpf-summary", &trace.summary_bpf, "Summary syscall stats in BPF"),
 	OPTS_EVSWITCH(&trace.evswitch),
 	OPT_END()
 	};
@@ -5535,6 +5551,9 @@ int cmd_trace(int argc, const char **argv)
 		goto skip_augmentation;
 	}
 
+	if (trace.summary_only && trace.summary_bpf)
+		goto skip_augmentation;
+
 	trace.skel = augmented_raw_syscalls_bpf__open();
 	if (!trace.skel) {
 		pr_debug("Failed to open augmented syscalls BPF skeleton");
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 034a6603d5a8e8b0..ba4201a6f3c69753 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -171,6 +171,7 @@ perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-flex.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-bison.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-trace-summary.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += btf.o
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
new file mode 100644
index 0000000000000000..5ae9feca244d5b22
--- /dev/null
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -0,0 +1,334 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <inttypes.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "dwarf-regs.h" /* for EM_HOST */
+#include "syscalltbl.h"
+#include "util/hashmap.h"
+#include "util/trace.h"
+#include "util/util.h"
+#include <bpf/bpf.h>
+#include <linux/time64.h>
+#include <tools/libc_compat.h> /* reallocarray */
+
+#include "bpf_skel/syscall_summary.h"
+#include "bpf_skel/syscall_summary.skel.h"
+
+
+static struct syscall_summary_bpf *skel;
+
+int trace_prepare_bpf_summary(enum trace_summary_mode mode)
+{
+	skel = syscall_summary_bpf__open();
+	if (skel == NULL) {
+		fprintf(stderr, "failed to open syscall summary bpf skeleton\n");
+		return -1;
+	}
+
+	if (mode == SUMMARY__BY_THREAD)
+		skel->rodata->aggr_mode = SYSCALL_AGGR_THREAD;
+	else
+		skel->rodata->aggr_mode = SYSCALL_AGGR_CPU;
+
+	if (syscall_summary_bpf__load(skel) < 0) {
+		fprintf(stderr, "failed to load syscall summary bpf skeleton\n");
+		return -1;
+	}
+
+	if (syscall_summary_bpf__attach(skel) < 0) {
+		fprintf(stderr, "failed to attach syscall summary bpf skeleton\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+void trace_start_bpf_summary(void)
+{
+	skel->bss->enabled = 1;
+}
+
+void trace_end_bpf_summary(void)
+{
+	skel->bss->enabled = 0;
+}
+
+struct syscall_node {
+	int syscall_nr;
+	struct syscall_stats stats;
+};
+
+static double rel_stddev(struct syscall_stats *stat)
+{
+	double variance, average;
+
+	if (stat->count < 2)
+		return 0;
+
+	average = (double)stat->total_time / stat->count;
+
+	variance = stat->squared_sum;
+	variance -= (stat->total_time * stat->total_time) / stat->count;
+	variance /= stat->count;
+
+	return 100 * sqrt(variance) / average;
+}
+
+struct syscall_data {
+	int key; /* tid if AGGR_THREAD, syscall-nr if AGGR_CPU */
+	int nr_events;
+	int nr_nodes;
+	u64 total_time;
+	struct syscall_node *nodes;
+};
+
+static int datacmp(const void *a, const void *b)
+{
+	const struct syscall_data * const *sa = a;
+	const struct syscall_data * const *sb = b;
+
+	return (*sa)->total_time > (*sb)->total_time ? -1 : 1;
+}
+
+static int nodecmp(const void *a, const void *b)
+{
+	const struct syscall_node *na = a;
+	const struct syscall_node *nb = b;
+
+	return na->stats.total_time > nb->stats.total_time ? -1 : 1;
+}
+
+static size_t sc_node_hash(long key, void *ctx __maybe_unused)
+{
+	return key;
+}
+
+static bool sc_node_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
+static int print_common_stats(struct syscall_data *data, FILE *fp)
+{
+	int printed = 0;
+
+	for (int i = 0; i < data->nr_nodes; i++) {
+		struct syscall_node *node = &data->nodes[i];
+		struct syscall_stats *stat = &node->stats;
+		double total = (double)(stat->total_time) / NSEC_PER_MSEC;
+		double min = (double)(stat->min_time) / NSEC_PER_MSEC;
+		double max = (double)(stat->max_time) / NSEC_PER_MSEC;
+		double avg = total / stat->count;
+		const char *name;
+
+		/* TODO: support other ABIs */
+		name = syscalltbl__name(EM_HOST, node->syscall_nr);
+		if (name)
+			printed += fprintf(fp, "   %-15s", name);
+		else
+			printed += fprintf(fp, "   syscall:%-7d", node->syscall_nr);
+
+		printed += fprintf(fp, " %8u %6u %9.3f %9.3f %9.3f %9.3f %9.2f%%\n",
+				   stat->count, stat->error, total, min, avg, max,
+				   rel_stddev(stat));
+	}
+	return printed;
+}
+
+static int update_thread_stats(struct hashmap *hash, struct syscall_key *map_key,
+			       struct syscall_stats *map_data)
+{
+	struct syscall_data *data;
+	struct syscall_node *nodes;
+
+	if (!hashmap__find(hash, map_key->cpu_or_tid, &data)) {
+		data = zalloc(sizeof(*data));
+		if (data == NULL)
+			return -ENOMEM;
+
+		data->key = map_key->cpu_or_tid;
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
+static int print_thread_stat(struct syscall_data *data, FILE *fp)
+{
+	int printed = 0;
+
+	qsort(data->nodes, data->nr_nodes, sizeof(*data->nodes), nodecmp);
+
+	printed += fprintf(fp, " thread (%d), ", data->key);
+	printed += fprintf(fp, "%d events\n\n", data->nr_events);
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
+static int print_thread_stats(struct syscall_data **data, int nr_data, FILE *fp)
+{
+	int printed = 0;
+
+	for (int i = 0; i < nr_data; i++)
+		printed += print_thread_stat(data[i], fp);
+
+	return printed;
+}
+
+static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
+			      struct syscall_stats *map_data)
+{
+	struct syscall_data *data;
+	struct syscall_stats *stat;
+
+	if (!hashmap__find(hash, map_key, &data)) {
+		data = zalloc(sizeof(*data));
+		if (data == NULL)
+			return -ENOMEM;
+
+		data->nodes = zalloc(sizeof(*data->nodes));
+		if (data->nodes == NULL) {
+			free(data);
+			return -ENOMEM;
+		}
+
+		data->nr_nodes = 1;
+		data->key = map_key->nr;
+		data->nodes->syscall_nr = data->key;
+
+		if (hashmap__add(hash, data->key, data) < 0) {
+			free(data->nodes);
+			free(data);
+			return -ENOMEM;
+		}
+	}
+
+	/* update total stats for this syscall */
+	data->nr_events += map_data->count;
+	data->total_time += map_data->total_time;
+
+	/* This is sum of the same syscall from different CPUs */
+	stat = &data->nodes->stats;
+
+	stat->total_time += map_data->total_time;
+	stat->squared_sum += map_data->squared_sum;
+	stat->count += map_data->count;
+	stat->error += map_data->error;
+
+	if (stat->max_time < map_data->max_time)
+		stat->max_time = map_data->max_time;
+	if (stat->min_time > map_data->min_time)
+		stat->min_time = map_data->min_time;
+
+	return 0;
+}
+
+static int print_total_stats(struct syscall_data **data, int nr_data, FILE *fp)
+{
+	int printed = 0;
+	int nr_events = 0;
+
+	for (int i = 0; i < nr_data; i++)
+		nr_events += data[i]->nr_events;
+
+	printed += fprintf(fp, " total, %d events\n\n", nr_events);
+
+	printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");
+	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
+	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
+
+	for (int i = 0; i < nr_data; i++)
+		printed += print_common_stats(data[i], fp);
+
+	printed += fprintf(fp, "\n\n");
+	return printed;
+}
+
+int trace_print_bpf_summary(FILE *fp)
+{
+	struct bpf_map *map = skel->maps.syscall_stats_map;
+	struct syscall_key *prev_key, key;
+	struct syscall_data **data = NULL;
+	struct hashmap schash;
+	struct hashmap_entry *entry;
+	int nr_data = 0;
+	int printed = 0;
+	int i;
+	size_t bkt;
+
+	hashmap__init(&schash, sc_node_hash, sc_node_equal, /*ctx=*/NULL);
+
+	printed = fprintf(fp, "\n Summary of events:\n\n");
+
+	/* get stats from the bpf map */
+	prev_key = NULL;
+	while (!bpf_map__get_next_key(map, prev_key, &key, sizeof(key))) {
+		struct syscall_stats stat;
+
+		if (!bpf_map__lookup_elem(map, &key, sizeof(key), &stat, sizeof(stat), 0)) {
+			if (skel->rodata->aggr_mode == SYSCALL_AGGR_THREAD)
+				update_thread_stats(&schash, &key, &stat);
+			else
+				update_total_stats(&schash, &key, &stat);
+		}
+
+		prev_key = &key;
+	}
+
+	nr_data = hashmap__size(&schash);
+	data = calloc(nr_data, sizeof(*data));
+	if (data == NULL)
+		goto out;
+
+	i = 0;
+	hashmap__for_each_entry(&schash, entry, bkt)
+		data[i++] = entry->pvalue;
+
+	qsort(data, nr_data, sizeof(*data), datacmp);
+
+	if (skel->rodata->aggr_mode == SYSCALL_AGGR_THREAD)
+		printed += print_thread_stats(data, nr_data, fp);
+	else
+		printed += print_total_stats(data, nr_data, fp);
+
+	for (i = 0; i < nr_data && data; i++) {
+		free(data[i]->nodes);
+		free(data[i]);
+	}
+	free(data);
+
+out:
+	hashmap__clear(&schash);
+	return printed;
+}
+
+void trace_cleanup_bpf_summary(void)
+{
+	syscall_summary_bpf__destroy(skel);
+}
diff --git a/tools/perf/util/bpf_skel/syscall_summary.bpf.c b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
new file mode 100644
index 0000000000000000..b25f53b3c1351392
--- /dev/null
+++ b/tools/perf/util/bpf_skel/syscall_summary.bpf.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Trace raw_syscalls tracepoints to collect system call statistics.
+ */
+
+#include "vmlinux.h"
+#include "syscall_summary.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* This is to calculate a delta between sys-enter and sys-exit for each thread */
+struct syscall_trace {
+	int nr; /* syscall number is only available at sys-enter */
+	int unused;
+	u64 timestamp;
+};
+
+#define MAX_ENTRIES	(128 * 1024)
+
+struct syscall_trace_map {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int); /* tid */
+	__type(value, struct syscall_trace);
+	__uint(max_entries, MAX_ENTRIES);
+} syscall_trace_map SEC(".maps");
+
+struct syscall_stats_map {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, struct syscall_key);
+	__type(value, struct syscall_stats);
+	__uint(max_entries, MAX_ENTRIES);
+} syscall_stats_map SEC(".maps");
+
+int enabled; /* controlled from userspace */
+
+const volatile enum syscall_aggr_mode aggr_mode;
+
+static void update_stats(int cpu_or_tid, int nr, s64 duration, long ret)
+{
+	struct syscall_key key = { .cpu_or_tid = cpu_or_tid, .nr = nr, };
+	struct syscall_stats *stats;
+
+	stats = bpf_map_lookup_elem(&syscall_stats_map, &key);
+	if (stats == NULL) {
+		struct syscall_stats zero = {};
+
+		bpf_map_update_elem(&syscall_stats_map, &key, &zero, BPF_NOEXIST);
+		stats = bpf_map_lookup_elem(&syscall_stats_map, &key);
+		if (stats == NULL)
+			return;
+	}
+
+	__sync_fetch_and_add(&stats->count, 1);
+	if (ret < 0)
+		__sync_fetch_and_add(&stats->error, 1);
+
+	if (duration > 0) {
+		__sync_fetch_and_add(&stats->total_time, duration);
+		__sync_fetch_and_add(&stats->squared_sum, duration * duration);
+		if (stats->max_time < duration)
+			stats->max_time = duration;
+		if (stats->min_time > duration || stats->min_time == 0)
+			stats->min_time = duration;
+	}
+
+	return;
+}
+
+SEC("tp_btf/sys_enter")
+int sys_enter(u64 *ctx)
+{
+	int tid;
+	struct syscall_trace st;
+
+	if (!enabled)
+		return 0;
+
+	st.nr = ctx[1]; /* syscall number */
+	st.unused = 0;
+	st.timestamp = bpf_ktime_get_ns();
+
+	tid = bpf_get_current_pid_tgid();
+	bpf_map_update_elem(&syscall_trace_map, &tid, &st, BPF_ANY);
+
+	return 0;
+}
+
+SEC("tp_btf/sys_exit")
+int sys_exit(u64 *ctx)
+{
+	int tid;
+	int key;
+	long ret = ctx[1]; /* return value of the syscall */
+	struct syscall_trace *st;
+	s64 delta;
+
+	if (!enabled)
+		return 0;
+
+	tid = bpf_get_current_pid_tgid();
+	st = bpf_map_lookup_elem(&syscall_trace_map, &tid);
+	if (st == NULL)
+		return 0;
+
+	if (aggr_mode == SYSCALL_AGGR_THREAD)
+		key = tid;
+	else
+		key = bpf_get_smp_processor_id();
+
+	delta = bpf_ktime_get_ns() - st->timestamp;
+	update_stats(key, st->nr, delta, ret);
+
+	bpf_map_delete_elem(&syscall_trace_map, &tid);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/util/bpf_skel/syscall_summary.h b/tools/perf/util/bpf_skel/syscall_summary.h
new file mode 100644
index 0000000000000000..17f9ecba657088aa
--- /dev/null
+++ b/tools/perf/util/bpf_skel/syscall_summary.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Data structures shared between BPF and tools. */
+#ifndef UTIL_BPF_SKEL_SYSCALL_SUMMARY_H
+#define UTIL_BPF_SKEL_SYSCALL_SUMMARY_H
+
+enum syscall_aggr_mode {
+	SYSCALL_AGGR_THREAD,
+	SYSCALL_AGGR_CPU,
+};
+
+struct syscall_key {
+	int cpu_or_tid;
+	int nr;
+};
+
+struct syscall_stats {
+	u64 total_time;
+	u64 squared_sum;
+	u64 max_time;
+	u64 min_time;
+	u32 count;
+	u32 error;
+};
+
+#endif /* UTIL_BPF_SKEL_SYSCALL_SUMMARY_H */
diff --git a/tools/perf/util/trace.h b/tools/perf/util/trace.h
new file mode 100644
index 0000000000000000..ef8361ed12c4edc1
--- /dev/null
+++ b/tools/perf/util/trace.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef UTIL_TRACE_H
+#define UTIL_TRACE_H
+
+#include <stdio.h>  /* for FILE */
+
+enum trace_summary_mode {
+	SUMMARY__NONE = 0,
+	SUMMARY__BY_TOTAL,
+	SUMMARY__BY_THREAD,
+};
+
+#ifdef HAVE_BPF_SKEL
+
+int trace_prepare_bpf_summary(enum trace_summary_mode mode);
+void trace_start_bpf_summary(void);
+void trace_end_bpf_summary(void);
+int trace_print_bpf_summary(FILE *fp);
+void trace_cleanup_bpf_summary(void);
+
+#else /* !HAVE_BPF_SKEL */
+
+static inline int trace_prepare_bpf_summary(enum trace_summary_mode mode __maybe_unused)
+{
+	return -1;
+}
+static inline void trace_start_bpf_summary(void) {}
+static inline void trace_end_bpf_summary(void) {}
+static inline int trace_print_bpf_summary(FILE *fp __maybe_unused)
+{
+	return 0;
+}
+static inline void trace_cleanup_bpf_summary(void) {}
+
+#endif /* HAVE_BPF_SKEL */
+
+#endif /* UTIL_TRACE_H */
-- 
2.49.0.rc1.451.g8f38331e32-goog


