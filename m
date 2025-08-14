Return-Path: <bpf+bounces-65610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23CB25CEB
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD09E13E5
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 07:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7483226CE0A;
	Thu, 14 Aug 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp7+YgzF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA7253920;
	Thu, 14 Aug 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155878; cv=none; b=LfWs6U0j72rUIvRr9gUYM40A4WIs78NJEBytnfKdhcp7t9O2HX4ySMiYIjTEvmPbUtLhb612XoH6pRC8ubdM5WtNgtv1UiWQxATWErrKKoyMjb4hqknrmcy+2pxRzEIxUEqyslnBwI0gApwAt5Zw/9PcCIIsyLwaFe2nQHt1c7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155878; c=relaxed/simple;
	bh=x+9M5F5x387QNOybxfpdJicfYn3UHE1jdPztSgN78SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1DkoqnKqlYNkpSXm1fCsdkH0jbjYXXK8A82QADIill/3bjdmhC5KgALut1ncwoaKZgklojj+HtIS96rZtNvbru2ZA4pLv0fpNyE8SlnGMgNFMAEHeMskd+8IwTT33aJNSa2wWNV6JreHA3nigL1I9Sj1YOfvVHunDjOpp9ASsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp7+YgzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CF5C4CEEF;
	Thu, 14 Aug 2025 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755155877;
	bh=x+9M5F5x387QNOybxfpdJicfYn3UHE1jdPztSgN78SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dp7+YgzFGHQmu223p6w/Om757sPoMtEVYKNNCZmJ+q81X0zu/YyarFt6EO0N4SG5V
	 XcokePz6UGLH2rjT65QdvKW9dNo13MRGewRKo3osnHyWSat7mOJzNvRltbW1mM6ns+
	 gFWComMUk3o4mZNXG7u3pUfviVuZV+ez0QarIRpVFVZDFAqBhktZqdfkO5LylFFJ5Z
	 4Cw/hB51a3bY0E+2YIKrgnquMdow0aTcfF6E5ZC1Z38ezZlZlkzRR1YWBLrkuMSh1d
	 OCMYJNH2CdcQcq8O9mrg4qwMlwalChbAZIGlHT9iZRV4DMSC5IvJnyS+GDEv3T0gRi
	 F3B1a0sFAKT/Q==
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
Subject: [PATCH 3/5] perf trace: Do not return 0 from syscall tracepoint BPF
Date: Thu, 14 Aug 2025 00:17:52 -0700
Message-ID: <20250814071754.193265-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250814071754.193265-1-namhyung@kernel.org>
References: <20250814071754.193265-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Howard reported that returning 0 from the BPF resulted in affecting
global syscall tracepoint handling.  What we want to do is just to drop
syscall output in the current perf session.  So we need a different
approach.

Currently perf trace uses bpf-output event for augmented arguments and
raw_syscalls:sys_{enter,exit} tracepoint events for normal arguments.
But I think we can just use bpf-output in both cases and drop the trace
point events.

Then it needs to distinguish bpf-output data if it's for enter or exit.
Repurpose struct trace_entry.type which is common in both syscall entry
and exit tracepoints.

Closes: https://lore.kernel.org/r/20250529065537.529937-1-howardchu95@gmail.com
Suggested-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c                    | 119 ++++++++++++++----
 .../bpf_skel/augmented_raw_syscalls.bpf.c     |  37 ++++--
 tools/perf/util/bpf_skel/perf_trace_u.h       |  14 +++
 3 files changed, 133 insertions(+), 37 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/perf_trace_u.h

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1bc912273af2db66..e1caa82bc427b68b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -22,6 +22,7 @@
 #include <bpf/btf.h>
 #endif
 #include "util/bpf_map.h"
+#include "util/bpf_skel/perf_trace_u.h"
 #include "util/rlimit.h"
 #include "builtin.h"
 #include "util/cgroup.h"
@@ -535,6 +536,61 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	return NULL;
 }
 
+static struct syscall_tp sys_enter_tp;
+static struct syscall_tp sys_exit_tp;
+
+static int evsel__init_bpf_output_tp(struct evsel *evsel)
+{
+	struct tep_event *event;
+	struct tep_format_field *field;
+	struct syscall_tp *sc;
+
+	if (evsel == NULL)
+		return 0;
+
+	event = trace_event__tp_format("raw_syscalls", "sys_enter");
+	if (IS_ERR(event))
+		event = trace_event__tp_format("syscalls", "sys_enter");
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
+	field = tep_find_field(event, "id");
+	if (field == NULL)
+		return -EINVAL;
+
+	tp_field__init_uint(&sys_enter_tp.id, field, evsel->needs_swap);
+	__tp_field__init_ptr(&sys_enter_tp.args, sys_enter_tp.id.offset + sizeof(u64));
+
+	/* ID is at the same offset, use evsel sc for convenience */
+	sc = evsel__syscall_tp(evsel);
+	if (sc == NULL)
+		return -ENOMEM;
+
+	event = trace_event__tp_format("raw_syscalls", "sys_exit");
+	if (IS_ERR(event))
+		event = trace_event__tp_format("syscalls", "sys_exit");
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
+	field = tep_find_field(event, "id");
+	if (field == NULL)
+		return -EINVAL;
+
+	tp_field__init_uint(&sys_exit_tp.id, field, evsel->needs_swap);
+
+	field = tep_find_field(event, "ret");
+	if (field == NULL)
+		return -EINVAL;
+
+	tp_field__init_uint(&sys_exit_tp.ret, field, evsel->needs_swap);
+
+	/* Save the common part to the evsel sc */
+	BUG_ON(sys_enter_tp.id.offset != sys_exit_tp.id.offset);
+	sc->id = sys_enter_tp.id;
+
+	return 0;
+}
+
 #define perf_evsel__sc_tp_uint(evsel, name, sample) \
 	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
 	   fields->name.integer(&fields->name, sample); })
@@ -2777,7 +2833,10 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 
 	trace__fprintf_sample(trace, evsel, sample, thread);
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	if (evsel == trace->syscalls.events.bpf_output)
+		args = sys_enter_tp.args.pointer(&sys_enter_tp.args, sample);
+	else
+		args = perf_evsel__sc_tp_ptr(evsel, args, sample);
 
 	if (ttrace->entry_str == NULL) {
 		ttrace->entry_str = malloc(trace__entry_str_size);
@@ -2797,8 +2856,10 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	 * thinking that the extra 2 u64 args are the augmented filename, so just check
 	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
 	 */
-	if (evsel != trace->syscalls.events.sys_enter)
-		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
+	if (evsel == trace->syscalls.events.bpf_output) {
+		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size,
+							 trace->raw_augmented_syscalls_args_size);
+	}
 	ttrace->entry_time = sample->time;
 	msg = ttrace->entry_str;
 	printed += scnprintf(msg + printed, trace__entry_str_size - printed, "%s(", sc->name);
@@ -2922,7 +2983,10 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 
 	trace__fprintf_sample(trace, evsel, sample, thread);
 
-	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
+	if (evsel == trace->syscalls.events.bpf_output)
+		ret = sys_exit_tp.ret.integer(&sys_exit_tp.ret, sample);
+	else
+		ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
 	if (trace->summary)
 		thread__update_stats(thread, ttrace, id, sample, ret, trace);
@@ -3252,6 +3316,17 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		}
 	}
 
+	if (evsel == trace->syscalls.events.bpf_output) {
+		short *event_type = sample->raw_data;
+
+		if (*event_type == SYSCALL_TRACE_ENTER)
+			trace__sys_enter(trace, evsel, event, sample);
+		else
+			trace__sys_exit(trace, evsel, event, sample);
+
+		goto printed;
+	}
+
 	trace__printf_interrupted_entry(trace);
 	trace__fprintf_tstamp(trace, sample->time, trace->output);
 
@@ -3261,25 +3336,6 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	if (thread)
 		trace__fprintf_comm_tid(trace, thread, trace->output);
 
-	if (evsel == trace->syscalls.events.bpf_output) {
-		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
-		int e_machine = thread ? thread__e_machine(thread, trace->host) : EM_HOST;
-		struct syscall *sc = trace__syscall_info(trace, evsel, e_machine, id);
-
-		if (sc) {
-			fprintf(trace->output, "%s(", sc->name);
-			trace__fprintf_sys_enter(trace, evsel, sample);
-			fputc(')', trace->output);
-			goto newline;
-		}
-
-		/*
-		 * XXX: Not having the associated syscall info or not finding/adding
-		 * 	the thread should never happen, but if it does...
-		 * 	fall thru and print it as a bpf_output event.
-		 */
-	}
-
 	fprintf(trace->output, "%s(", evsel->name);
 
 	if (evsel__is_bpf_output(evsel)) {
@@ -3299,7 +3355,6 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		}
 	}
 
-newline:
 	fprintf(trace->output, ")\n");
 
 	if (callchain_ret > 0)
@@ -3307,6 +3362,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", evsel__name(evsel));
 
+printed:
 	++trace->nr_events_printed;
 
 	if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
@@ -4527,7 +4583,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
 		perf_thread_map__nr(evlist->core.threads) > 1 ||
-		evlist__first(evlist)->core.attr.inherit;
+		!trace->opts.no_inherit;
 
 	/*
 	 * Now that we already used evsel->core.attr to ask the kernel to setup the
@@ -5552,8 +5608,6 @@ int cmd_trace(int argc, const char **argv)
 	if (err < 0)
 		goto skip_augmentation;
 
-	trace__add_syscall_newtp(&trace);
-
 	err = augmented_syscalls__create_bpf_output(trace.evlist);
 	if (err == 0)
 		trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
@@ -5589,6 +5643,7 @@ int cmd_trace(int argc, const char **argv)
 
 	if (trace.evlist->core.nr_entries > 0) {
 		bool use_btf = false;
+		struct evsel *augmented = trace.syscalls.events.bpf_output;
 
 		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
 		if (evlist__set_syscall_tp_fields(trace.evlist, &use_btf)) {
@@ -5598,6 +5653,16 @@ int cmd_trace(int argc, const char **argv)
 
 		if (use_btf)
 			trace__load_vmlinux_btf(&trace);
+
+		if (augmented) {
+			if (evsel__init_bpf_output_tp(augmented) < 0) {
+				perror("failed to initialize bpf output fields\n");
+				goto out;
+			}
+			trace.raw_augmented_syscalls_args_size = sys_enter_tp.id.offset;
+			trace.raw_augmented_syscalls_args_size += (6 + 1) * sizeof(long);
+			trace.raw_augmented_syscalls = true;
+		}
 	}
 
 	/*
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 0016deb321fe0d97..979d60d7dce6565b 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -7,6 +7,7 @@
  */
 
 #include "vmlinux.h"
+#include "perf_trace_u.h"
 
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
@@ -140,7 +141,7 @@ static inline struct augmented_args_payload *augmented_args_payload(void)
 	return bpf_map_lookup_elem(&augmented_args_tmp, &key);
 }
 
-static inline int augmented__output(void *ctx, struct augmented_args_payload *args, int len)
+static inline int augmented__output(void *ctx, void *args, int len)
 {
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
@@ -182,12 +183,20 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter_unaugmented(struct trace_event_raw_sys_enter *args)
 {
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
+
+        if (augmented_args)
+		augmented__output(args, &augmented_args->args, sizeof(*args));
 	return 1;
 }
 
 SEC("tp/raw_syscalls/sys_exit")
 int sys_exit_unaugmented(struct trace_event_raw_sys_exit *args)
 {
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
+
+	if (augmented_args)
+		augmented__output(args, &augmented_args->args, sizeof(*args));
 	return 1;
 }
 
@@ -450,6 +459,7 @@ static int augment_sys_enter(void *ctx, struct trace_event_raw_sys_enter *args)
 
 	/* copy the sys_enter header, which has the id */
 	__builtin_memcpy(&payload->args, args, sizeof(*args));
+	payload->args.ent.type = SYSCALL_TRACE_ENTER;
 
 	/*
 	 * Determine what type of argument and how many bytes to read from user space, using the
@@ -532,13 +542,14 @@ int sys_enter(struct trace_event_raw_sys_enter *args)
 	 */
 
 	if (pid_filter__has(&pids_filtered, getpid()))
-		return 0;
+		return 1;
 
 	augmented_args = augmented_args_payload();
 	if (augmented_args == NULL)
 		return 1;
 
 	bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->args), args);
+	augmented_args->args.ent.type = SYSCALL_TRACE_ENTER;
 
 	/*
 	 * Jump to syscall specific augmenter, even if the default one,
@@ -548,29 +559,35 @@ int sys_enter(struct trace_event_raw_sys_enter *args)
 	if (augment_sys_enter(args, &augmented_args->args))
 		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.id);
 
-	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
-	return 0;
+	return 1;
 }
 
 SEC("tp/raw_syscalls/sys_exit")
 int sys_exit(struct trace_event_raw_sys_exit *args)
 {
-	struct trace_event_raw_sys_exit exit_args;
+	struct augmented_args_payload *augmented_args;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
-		return 0;
+		return 1;
+
+	augmented_args = augmented_args_payload();
+	if (augmented_args == NULL)
+		return 1;
+
+	bpf_probe_read_kernel(&augmented_args->args, sizeof(*args), args);
+	augmented_args->args.ent.type = SYSCALL_TRACE_EXIT;
 
-	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
 	/*
 	 * Jump to syscall specific return augmenter, even if the default one,
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
 	 * unaugmented tracepoint payload.
 	 */
-	bpf_tail_call(args, &syscalls_sys_exit, exit_args.id);
+	bpf_tail_call(args, &syscalls_sys_exit, args->id);
 	/*
-	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
+	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it
+	 * by not emitting bpf-output event.
 	 */
-	return 0;
+	return 1;
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/util/bpf_skel/perf_trace_u.h b/tools/perf/util/bpf_skel/perf_trace_u.h
new file mode 100644
index 0000000000000000..5b41afa734331d89
--- /dev/null
+++ b/tools/perf/util/bpf_skel/perf_trace_u.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2025 Google
+
+// This file will be shared between BPF and userspace.
+
+#ifndef __PERF_TRACE_U_H
+#define __PERF_TRACE_U_H
+
+enum syscall_trace_type {
+	SYSCALL_TRACE_ENTER = 0,
+	SYSCALL_TRACE_EXIT,
+};
+
+#endif /* __PERF_TRACE_U_H */
-- 
2.51.0.rc1.167.g924127e9c0-goog


