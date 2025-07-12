Return-Path: <bpf+bounces-63094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26BBB026F7
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 00:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3A21737A6
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9761B221D9E;
	Fri, 11 Jul 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuqQm1p8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176831F3B83;
	Fri, 11 Jul 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752273328; cv=none; b=JG9OG0TMxLxKV+x3xQs7G2Z1TA3NvkMIgg5uKf7FUL70eRcYyCZo5m+12rGy3EFVyMGBaarkyyoJIQkzGj4riYrfGZyKE9HilKRB5SkilPjR7ddH0vERvpdseiEPzXmP/XfUJ/j4rCu/tnhlLZGAq/MsE+dOJxB/1cfK2oKvtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752273328; c=relaxed/simple;
	bh=YMpf4JlkDaIVStMXojvCBJK9Xs4NqVg6j27LofU9kdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsjAr4QGTUfrShp5j7OWkK3UvFlgBdKpc+L5BbYjrwrbsJzyYsFIiYNK6RQBfvCpO7RtTnXr1SxXFh4+MvZk/BRKcYx2IdKo9/ZHYXZ5vGTtpfmlyqc3Qy4dv2UKGbbFlcTnITg8yIVWKOUhv/BO2x3OWf/5gy/cnx087iiNqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuqQm1p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC4EC4CEED;
	Fri, 11 Jul 2025 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752273327;
	bh=YMpf4JlkDaIVStMXojvCBJK9Xs4NqVg6j27LofU9kdM=;
	h=From:To:Cc:Subject:Date:From;
	b=TuqQm1p8bRfXra8tEn/HGMYGRP4XFFsFW3jJJ/VXor7C6ORdIzxA7MQnCT5CEsRuA
	 Uf04vh/sqUyEvR4qn1OG4PzHx6o1/ZMn71G6xBT9+KwCKR9dsbcSjSQg4EzXXA4hYA
	 BtfWX1uRr/+LFuCurklTJfByJN8tERqJ0Ts62aleMoJOJo/EC3ed6T+fs7whYc1l23
	 xyuBr9avzoENwc87Y/qei0Ju4Y2B5z9COpoUcI97KwD0yeDGrE8DoGdjbLQgk6UU+N
	 leVqdFWzpOCW8h03A2kMPF1cUjPsG7cI2eSNqGkBoExpQnwhadRoh6BYZ7Io0V3HUN
	 3oUhI4xmsciBA==
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
	bpf@vger.kernel.org
Subject: [PATCH] perf ftrace latency: Add -e option to measure time between two events
Date: Fri, 11 Jul 2025 15:35:25 -0700
Message-ID: <20250711223525.323906-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to the function latency, it can measure events latencies.
Some kernel tracepoints are paired and it's menningful to measure how
long it takes between the two events.  The latency is tracked for the
same thread.

Currently it only uses BPF to do the work but it can be lifted later.
Instead of having separate a BPF program for each tracepoint, it only
uses generic 'event_begin' and 'event_end' programs to attach to any
(raw) tracepoints.

  $ sudo perf ftrace latency -a -b --hide-empty \
    -e i915_request_wait_begin,i915_request_wait_end -- sleep 1
  #   DURATION     |      COUNT | GRAPH                                |
     256 -  512 us |          4 | ######                               |
       2 -    4 ms |          2 | ###                                  |
       4 -    8 ms |         12 | ###################                  |
       8 -   16 ms |         10 | ################                     |

  # statistics  (in usec)
    total time:               194915
      avg time:                 6961
      max time:                12855
      min time:                  373
         count:                   28

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-ftrace.txt    |   6 +
 tools/perf/builtin-ftrace.c                 |  50 ++++++-
 tools/perf/util/bpf_ftrace.c                |  69 ++++++---
 tools/perf/util/bpf_skel/func_latency.bpf.c | 148 +++++++++++++-------
 tools/perf/util/ftrace.h                    |   1 +
 5 files changed, 199 insertions(+), 75 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index b77f58c4d2fdcff9..914457853bcf53ac 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -139,6 +139,12 @@ OPTIONS for 'perf ftrace latency'
 	Set the function name to get the histogram.  Unlike perf ftrace trace,
 	it only allows single function to calculate the histogram.
 
+-e::
+--events=::
+	Set the pair of events to get the histogram.  The histogram is calculated
+	by the time difference between the two events from the same thread.  This
+	requires -b/--use-bpf option.
+
 -b::
 --use-bpf::
 	Use BPF to measure function latency instead of using the ftrace (it
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 3a253a1b9f4526b9..e1f2f3fb1b0850a3 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1549,6 +1549,33 @@ static void delete_filter_func(struct list_head *head)
 	}
 }
 
+static int parse_filter_event(const struct option *opt, const char *str,
+			     int unset __maybe_unused)
+{
+	struct list_head *head = opt->value;
+	struct filter_entry *entry;
+	char *s, *p;
+	int ret = -ENOMEM;
+
+	s = strdup(str);
+	if (s == NULL)
+		return -ENOMEM;
+
+	while ((p = strsep(&s, ",")) != NULL) {
+		entry = malloc(sizeof(*entry) + strlen(p) + 1);
+		if (entry == NULL)
+			goto out;
+
+		strcpy(entry->name, p);
+		list_add_tail(&entry->list, head);
+	}
+	ret = 0;
+
+out:
+	free(s);
+	return ret;
+}
+
 static int parse_buffer_size(const struct option *opt,
 			     const char *str, int unset)
 {
@@ -1711,6 +1738,8 @@ int cmd_ftrace(int argc, const char **argv)
 	const struct option latency_options[] = {
 	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
 		     "Show latency of given function", parse_filter_func),
+	OPT_CALLBACK('e', "events", &ftrace.event_pair, "event1,event2",
+		     "Show latency between the two events", parse_filter_event),
 #ifdef HAVE_BPF_SKEL
 	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
 		    "Use BPF to measure function latency"),
@@ -1763,6 +1792,7 @@ int cmd_ftrace(int argc, const char **argv)
 	INIT_LIST_HEAD(&ftrace.notrace);
 	INIT_LIST_HEAD(&ftrace.graph_funcs);
 	INIT_LIST_HEAD(&ftrace.nograph_funcs);
+	INIT_LIST_HEAD(&ftrace.event_pair);
 
 	signal(SIGINT, sig_handler);
 	signal(SIGUSR1, sig_handler);
@@ -1817,9 +1847,24 @@ int cmd_ftrace(int argc, const char **argv)
 		cmd_func = __cmd_ftrace;
 		break;
 	case PERF_FTRACE_LATENCY:
-		if (list_empty(&ftrace.filters)) {
-			pr_err("Should provide a function to measure\n");
+		if (list_empty(&ftrace.filters) && list_empty(&ftrace.event_pair)) {
+			pr_err("Should provide a function or events to measure\n");
 			parse_options_usage(ftrace_usage, options, "T", 1);
+			parse_options_usage(NULL, options, "e", 1);
+			ret = -EINVAL;
+			goto out_delete_filters;
+		}
+		if (!list_empty(&ftrace.filters) && !list_empty(&ftrace.event_pair)) {
+			pr_err("Please specify either of function or events\n");
+			parse_options_usage(ftrace_usage, options, "T", 1);
+			parse_options_usage(NULL, options, "e", 1);
+			ret = -EINVAL;
+			goto out_delete_filters;
+		}
+		if (!list_empty(&ftrace.event_pair) && !ftrace.target.use_bpf) {
+			pr_err("Event processing needs BPF\n");
+			parse_options_usage(ftrace_usage, options, "b", 1);
+			parse_options_usage(NULL, options, "e", 1);
 			ret = -EINVAL;
 			goto out_delete_filters;
 		}
@@ -1910,6 +1955,7 @@ int cmd_ftrace(int argc, const char **argv)
 	delete_filter_func(&ftrace.notrace);
 	delete_filter_func(&ftrace.graph_funcs);
 	delete_filter_func(&ftrace.nograph_funcs);
+	delete_filter_func(&ftrace.event_pair);
 
 	return ret;
 }
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 7324668cc83e747e..34ac0adf841c27ee 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -21,16 +21,21 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 {
 	int fd, err;
 	int i, ncpus = 1, ntasks = 1;
-	struct filter_entry *func;
+	struct filter_entry *func = NULL;
 
-	if (!list_is_singular(&ftrace->filters)) {
-		pr_err("ERROR: %s target function(s).\n",
-		       list_empty(&ftrace->filters) ? "No" : "Too many");
-		return -1;
+	if (!list_empty(&ftrace->filters)) {
+		if (!list_is_singular(&ftrace->filters)) {
+			pr_err("ERROR: Too many target functions.\n");
+			return -1;
+		}
+		func = list_first_entry(&ftrace->filters, struct filter_entry, list);
+	} else {
+		if (list_is_singular(&ftrace->event_pair)) {
+			pr_err("ERROR: Needs two target events.\n");
+			return -1;
+		}
 	}
 
-	func = list_first_entry(&ftrace->filters, struct filter_entry, list);
-
 	skel = func_latency_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open func latency skeleton\n");
@@ -93,20 +98,44 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 
 	skel->bss->min = INT64_MAX;
 
-	skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
-							    false, func->name);
-	if (IS_ERR(skel->links.func_begin)) {
-		pr_err("Failed to attach fentry program\n");
-		err = PTR_ERR(skel->links.func_begin);
-		goto out;
-	}
+	if (func) {
+		skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
+								    false, func->name);
+		if (IS_ERR(skel->links.func_begin)) {
+			pr_err("Failed to attach fentry program\n");
+			err = PTR_ERR(skel->links.func_begin);
+			goto out;
+		}
 
-	skel->links.func_end = bpf_program__attach_kprobe(skel->progs.func_end,
-							  true, func->name);
-	if (IS_ERR(skel->links.func_end)) {
-		pr_err("Failed to attach fexit program\n");
-		err = PTR_ERR(skel->links.func_end);
-		goto out;
+		skel->links.func_end = bpf_program__attach_kprobe(skel->progs.func_end,
+								  true, func->name);
+		if (IS_ERR(skel->links.func_end)) {
+			pr_err("Failed to attach fexit program\n");
+			err = PTR_ERR(skel->links.func_end);
+			goto out;
+		}
+	} else {
+		struct filter_entry *event;
+
+		event = list_first_entry(&ftrace->event_pair, struct filter_entry, list);
+
+		skel->links.event_begin = bpf_program__attach_raw_tracepoint(skel->progs.event_begin,
+									     event->name);
+		if (IS_ERR(skel->links.event_begin)) {
+			pr_err("Failed to attach first tracepoint program\n");
+			err = PTR_ERR(skel->links.event_begin);
+			goto out;
+		}
+
+		event = list_next_entry(event, list);
+
+		skel->links.event_end = bpf_program__attach_raw_tracepoint(skel->progs.event_end,
+									     event->name);
+		if (IS_ERR(skel->links.event_end)) {
+			pr_err("Failed to attach second tracepoint program\n");
+			err = PTR_ERR(skel->links.event_end);
+			goto out;
+		}
 	}
 
 	/* XXX: we don't actually use this fd - just for poll() */
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index e731a79a753a4d2d..621e2022c8bc9648 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -52,34 +52,89 @@ const volatile unsigned int min_latency;
 const volatile unsigned int max_latency;
 const volatile unsigned int bucket_num = NUM_BUCKET;
 
-SEC("kprobe/func")
-int BPF_PROG(func_begin)
+static bool can_record(void)
 {
-	__u64 key, now;
-
-	if (!enabled)
-		return 0;
-
-	key = bpf_get_current_pid_tgid();
-
 	if (has_cpu) {
 		__u32 cpu = bpf_get_smp_processor_id();
 		__u8 *ok;
 
 		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
 		if (!ok)
-			return 0;
+			return false;
 	}
 
 	if (has_task) {
-		__u32 pid = key & 0xffffffff;
+		__u32 pid = bpf_get_current_pid_tgid();
 		__u8 *ok;
 
 		ok = bpf_map_lookup_elem(&task_filter, &pid);
 		if (!ok)
-			return 0;
+			return false;
 	}
+	return true;
+}
+
+static void update_latency(__s64 delta)
+{
+	__u64 val = delta;
+	__u32 key = 0;
+	__u64 *hist;
+	__u64 cmp_base = use_nsec ? 1 : 1000;
+
+	if (delta < 0)
+		return;
 
+	if (bucket_range != 0) {
+		val = delta / cmp_base;
+
+		if (min_latency > 0) {
+			if (val > min_latency)
+				val -= min_latency;
+			else
+				goto do_lookup;
+		}
+
+		// Less than 1 unit (ms or ns), or, in the future,
+		// than the min latency desired.
+		if (val > 0) { // 1st entry: [ 1 unit .. bucket_range units )
+			key = val / bucket_range + 1;
+			if (key >= bucket_num)
+				key = bucket_num - 1;
+		}
+
+		goto do_lookup;
+	}
+	// calculate index using delta
+	for (key = 0; key < (bucket_num - 1); key++) {
+		if (delta < (cmp_base << key))
+			break;
+	}
+
+do_lookup:
+	hist = bpf_map_lookup_elem(&latency, &key);
+	if (!hist)
+		return;
+
+	__sync_fetch_and_add(hist, 1);
+
+	__sync_fetch_and_add(&total, delta); // always in nsec
+	__sync_fetch_and_add(&count, 1);
+
+	if (delta > max)
+		max = delta;
+	if (delta < min)
+		min = delta;
+}
+
+SEC("kprobe/func")
+int BPF_PROG(func_begin)
+{
+	__u64 key, now;
+
+	if (!enabled || !can_record())
+		return 0;
+
+	key = bpf_get_current_pid_tgid();
 	now = bpf_ktime_get_ns();
 
 	// overwrite timestamp for nested functions
@@ -92,7 +147,6 @@ int BPF_PROG(func_end)
 {
 	__u64 tid;
 	__u64 *start;
-	__u64 cmp_base = use_nsec ? 1 : 1000;
 
 	if (!enabled)
 		return 0;
@@ -101,56 +155,44 @@ int BPF_PROG(func_end)
 
 	start = bpf_map_lookup_elem(&functime, &tid);
 	if (start) {
-		__s64 delta = bpf_ktime_get_ns() - *start;
-		__u64 val = delta;
-		__u32 key = 0;
-		__u64 *hist;
-
+		update_latency(bpf_ktime_get_ns() - *start);
 		bpf_map_delete_elem(&functime, &tid);
+	}
 
-		if (delta < 0)
-			return 0;
+	return 0;
+}
 
-		if (bucket_range != 0) {
-			val = delta / cmp_base;
+SEC("raw_tp")
+int BPF_PROG(event_begin)
+{
+	__u64 key, now;
 
-			if (min_latency > 0) {
-				if (val > min_latency)
-					val -= min_latency;
-				else
-					goto do_lookup;
-			}
+	if (!enabled || !can_record())
+		return 0;
 
-			// Less than 1 unit (ms or ns), or, in the future,
-			// than the min latency desired.
-			if (val > 0) { // 1st entry: [ 1 unit .. bucket_range units )
-				key = val / bucket_range + 1;
-				if (key >= bucket_num)
-					key = bucket_num - 1;
-			}
+	key = bpf_get_current_pid_tgid();
+	now = bpf_ktime_get_ns();
 
-			goto do_lookup;
-		}
-		// calculate index using delta
-		for (key = 0; key < (bucket_num - 1); key++) {
-			if (delta < (cmp_base << key))
-				break;
-		}
+	// overwrite timestamp for nested events
+	bpf_map_update_elem(&functime, &key, &now, BPF_ANY);
+	return 0;
+}
 
-do_lookup:
-		hist = bpf_map_lookup_elem(&latency, &key);
-		if (!hist)
-			return 0;
+SEC("raw_tp")
+int BPF_PROG(event_end)
+{
+	__u64 tid;
+	__u64 *start;
 
-		__sync_fetch_and_add(hist, 1);
+	if (!enabled)
+		return 0;
 
-		__sync_fetch_and_add(&total, delta); // always in nsec
-		__sync_fetch_and_add(&count, 1);
+	tid = bpf_get_current_pid_tgid();
 
-		if (delta > max)
-			max = delta;
-		if (delta < min)
-			min = delta;
+	start = bpf_map_lookup_elem(&functime, &tid);
+	if (start) {
+		update_latency(bpf_ktime_get_ns() - *start);
+		bpf_map_delete_elem(&functime, &tid);
 	}
 
 	return 0;
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index a9bc47da83a56cd6..3f5094ac59080310 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -17,6 +17,7 @@ struct perf_ftrace {
 	struct list_head	notrace;
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
+	struct list_head	event_pair;
 	struct hashmap		*profile_hash;
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
-- 
2.50.0.727.gbf7dc18ff4-goog


