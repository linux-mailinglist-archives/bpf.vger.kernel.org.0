Return-Path: <bpf+bounces-7486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208087780B8
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 20:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A3D281FFB
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4B22EF9;
	Thu, 10 Aug 2023 18:49:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE4214F9
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 18:49:11 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2382728
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 11:49:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d637af9a981so1231086276.0
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691693347; x=1692298147;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVjjGok9IASUwnAiNgFon9ahVXRE8L9c2SWxILfSpDo=;
        b=ls73ipBpmzOnL7tXQFG3uKS0s3YuZAIjeTzM//vqOBF4BLL07M34JgrKlkBuLM1Lpo
         vZO+ail+8pez2x/Ti7FjX3v1NagwXFWS8P6zS7WokJYDNkY7L53TIfo6a6KcaZW5OKy6
         0yAgB3TQBTj1aHCxcLO+4ZNnjCY0PQHWI64D4oNkb3tialD5Va1fC247plT+roXfP5n9
         D1+wpIz555pmF2pUq29mUSxPMXPcdq3ecFp9JtahK9IkJr6SusAMc5YT+5j5/HdAr2MQ
         IJbDEA+4Z0ypjuSzFrlvf3gU3BVVBEcYl5qnXbEb8OAOV4ceSJ/gWpK7hNP+9stxodEX
         cxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693347; x=1692298147;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVjjGok9IASUwnAiNgFon9ahVXRE8L9c2SWxILfSpDo=;
        b=IVqLGcwJr8xrnSc1seRvOVPJiC0gPxLN5yjO3jKoAZUK2mmFRy8eA+71GOysRsMHlD
         jgOPr6f3yNel0xcG8UWmzcO+ZIIxDapN/05xEjWEI3MAeVSKXp1YcbzsS8w0PSe0LDWp
         WIbPRrgG8ia/vFLTahDGVvJVkddXpFZcRw1t0ErbmmFGgt6fAVjmywmhceRwp0PmMA/L
         JsR+QTyhVWsAFy2P/Qd8nXtI6ZWeUmKfmwiLKMTYyfD1d8R/oq/p9up/IOW9iRBdX1Yf
         X5uzno3YV8fdH5B627iBRkxkjXkc+8J5wNIMGVPskpLBAaciQ1lXt/zCn+wyTChQzUVq
         mhAA==
X-Gm-Message-State: AOJu0YwFz06VlZ6S1vPnGs1Ly4gUyuLkW8NNHAPtKeHozxBedQ3UtoUK
	ps2ipiH2XeVO8x5VF0BJ1/oU7GLcJjuR
X-Google-Smtp-Source: AGHT+IGYEBQ52YF9Pk4NN3UZt6XqpN9GvdCWd2zH/PJih0EBeB+PClDDBbuTFlAFwzdQQHYDo82n8A1K6lGX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a25:d711:0:b0:d4a:7656:a680 with SMTP id
 o17-20020a25d711000000b00d4a7656a680mr59233ybg.2.1691693347291; Thu, 10 Aug
 2023 11:49:07 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:48:51 -0700
In-Reply-To: <20230810184853.2860737-1-irogers@google.com>
Message-Id: <20230810184853.2860737-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810184853.2860737-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v1 2/4] perf trace: Migrate BPF augmentation to use a skeleton
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Fangrui Song <maskray@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>, 
	Wang ShaoBo <bobo.shaobowang@huawei.com>, YueHaibing <yuehaibing@huawei.com>, 
	He Kuang <hekuang@huawei.com>, Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Previously a BPF event of augmented_raw_syscalls.c could be used to
enable augmentation of syscalls by perf trace. As BPF events are no
longer supported, switch to using a BPF skeleton which when attached
explicitly opens the sysenter and sysexit tracepoints.

The dump map is removed as debugging wasn't supported by the
augmentation and bpf_printk can be used when necessary.

Remove tools/perf/examples/bpf/augmented_raw_syscalls.c so that the
rename/migration to a BPF skeleton captures that this was the source.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf                      |   1 +
 tools/perf/builtin-trace.c                    | 180 +++++++++++-------
 .../bpf_skel/augmented_raw_syscalls.bpf.c}    |  27 +--
 3 files changed, 131 insertions(+), 77 deletions(-)
 rename tools/perf/{examples/bpf/augmented_raw_syscalls.c => util/bpf_skel/augmented_raw_syscalls.bpf.c} (96%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6ec5079fd697..0e1597712b95 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1042,6 +1042,7 @@ SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
 SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
+SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
 
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 59862467e781..8625fca42cd8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,9 @@
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#ifdef HAVE_BPF_SKEL
+#include "bpf_skel/augmented_raw_syscalls.skel.h"
+#endif
 #endif
 #include "util/bpf_map.h"
 #include "util/rlimit.h"
@@ -127,25 +130,19 @@ struct trace {
 	struct syscalltbl	*sctbl;
 	struct {
 		struct syscall  *table;
-		struct { // per syscall BPF_MAP_TYPE_PROG_ARRAY
-			struct bpf_map  *sys_enter,
-					*sys_exit;
-		}		prog_array;
 		struct {
 			struct evsel *sys_enter,
-					  *sys_exit,
-					  *augmented;
+				*sys_exit,
+				*bpf_output;
 		}		events;
-		struct bpf_program *unaugmented_prog;
 	} syscalls;
-	struct {
-		struct bpf_map *map;
-	} dump;
+#ifdef HAVE_BPF_SKEL
+	struct augmented_raw_syscalls_bpf *skel;
+#endif
 	struct record_opts	opts;
 	struct evlist	*evlist;
 	struct machine		*host;
 	struct thread		*current;
-	struct bpf_object	*bpf_obj;
 	struct cgroup		*cgroup;
 	u64			base_time;
 	FILE			*output;
@@ -415,6 +412,7 @@ static int evsel__init_syscall_tp(struct evsel *evsel)
 		if (evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr") &&
 		    evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
 			return -ENOENT;
+
 		return 0;
 	}
 
@@ -2845,7 +2843,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	if (thread)
 		trace__fprintf_comm_tid(trace, thread, trace->output);
 
-	if (evsel == trace->syscalls.events.augmented) {
+	if (evsel == trace->syscalls.events.bpf_output) {
 		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
 		struct syscall *sc = trace__syscall_info(trace, evsel, id);
 
@@ -3278,24 +3276,16 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 	goto out;
 }
 
-#ifdef HAVE_LIBBPF_SUPPORT
-static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
-{
-	if (trace->bpf_obj == NULL)
-		return NULL;
-
-	return bpf_object__find_map_by_name(trace->bpf_obj, name);
-}
-
+#ifdef HAVE_BPF_SKEL
 static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
 {
 	struct bpf_program *pos, *prog = NULL;
 	const char *sec_name;
 
-	if (trace->bpf_obj == NULL)
+	if (trace->skel->obj == NULL)
 		return NULL;
 
-	bpf_object__for_each_program(pos, trace->bpf_obj) {
+	bpf_object__for_each_program(pos, trace->skel->obj) {
 		sec_name = bpf_program__section_name(pos);
 		if (sec_name && !strcmp(sec_name, name)) {
 			prog = pos;
@@ -3313,12 +3303,14 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
 
 	if (prog_name == NULL) {
 		char default_prog_name[256];
-		scnprintf(default_prog_name, sizeof(default_prog_name), "!syscalls:sys_%s_%s", type, sc->name);
+		scnprintf(default_prog_name, sizeof(default_prog_name), "tp/syscalls/sys_%s_%s",
+			  type, sc->name);
 		prog = trace__find_bpf_program_by_title(trace, default_prog_name);
 		if (prog != NULL)
 			goto out_found;
 		if (sc->fmt && sc->fmt->alias) {
-			scnprintf(default_prog_name, sizeof(default_prog_name), "!syscalls:sys_%s_%s", type, sc->fmt->alias);
+			scnprintf(default_prog_name, sizeof(default_prog_name),
+				  "tp/syscalls/sys_%s_%s", type, sc->fmt->alias);
 			prog = trace__find_bpf_program_by_title(trace, default_prog_name);
 			if (prog != NULL)
 				goto out_found;
@@ -3336,7 +3328,7 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
 	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
 		 prog_name, type, sc->name);
 out_unaugmented:
-	return trace->syscalls.unaugmented_prog;
+	return trace->skel->progs.syscall_unaugmented;
 }
 
 static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
@@ -3353,13 +3345,21 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
 static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(trace->syscalls.unaugmented_prog);
+
+	if (sc)
+		return bpf_program__fd(sc->bpf_prog.sys_enter);
+
+	return bpf_program__fd(trace->skel->progs.syscall_unaugmented);
 }
 
 static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->syscalls.unaugmented_prog);
+
+	if (sc)
+		return bpf_program__fd(sc->bpf_prog.sys_exit);
+
+	return bpf_program__fd(trace->skel->progs.syscall_unaugmented);
 }
 
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
@@ -3384,7 +3384,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 		bool is_candidate = false;
 
 		if (pair == NULL || pair == sc ||
-		    pair->bpf_prog.sys_enter == trace->syscalls.unaugmented_prog)
+		    pair->bpf_prog.sys_enter == trace->skel->progs.syscall_unaugmented)
 			continue;
 
 		for (field = sc->args, candidate_field = pair->args;
@@ -3437,7 +3437,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 		 */
 		if (pair_prog == NULL) {
 			pair_prog = trace__find_syscall_bpf_prog(trace, pair, pair->fmt ? pair->fmt->bpf_prog_name.sys_enter : NULL, "enter");
-			if (pair_prog == trace->syscalls.unaugmented_prog)
+			if (pair_prog == trace->skel->progs.syscall_unaugmented)
 				goto next_candidate;
 		}
 
@@ -3452,8 +3452,8 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 
 static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 {
-	int map_enter_fd = bpf_map__fd(trace->syscalls.prog_array.sys_enter),
-	    map_exit_fd  = bpf_map__fd(trace->syscalls.prog_array.sys_exit);
+	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
+	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
 	int err = 0, key;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
@@ -3515,7 +3515,7 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 		 * For now we're just reusing the sys_enter prog, and if it
 		 * already has an augmenter, we don't need to find one.
 		 */
-		if (sc->bpf_prog.sys_enter != trace->syscalls.unaugmented_prog)
+		if (sc->bpf_prog.sys_enter != trace->skel->progs.syscall_unaugmented)
 			continue;
 
 		/*
@@ -3538,22 +3538,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 			break;
 	}
 
-
 	return err;
 }
-
-#else // HAVE_LIBBPF_SUPPORT
-static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace __maybe_unused,
-						   const char *name __maybe_unused)
-{
-	return NULL;
-}
-
-static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace __maybe_unused)
-{
-	return 0;
-}
-#endif // HAVE_LIBBPF_SUPPORT
+#endif // HAVE_BPF_SKEL
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
@@ -3917,13 +3904,31 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	err = evlist__open(evlist);
 	if (err < 0)
 		goto out_error_open;
+#ifdef HAVE_BPF_SKEL
+	{
+		struct perf_cpu cpu;
 
+		/*
+		 * Set up the __augmented_syscalls__ BPF map to hold for each
+		 * CPU the bpf-output event's file descriptor.
+		 */
+		perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
+			bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
+					&cpu.cpu, sizeof(int),
+					xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
+						       cpu.cpu, 0),
+					sizeof(__u32), BPF_ANY);
+		}
+	}
+#endif
 	err = trace__set_filter_pids(trace);
 	if (err < 0)
 		goto out_error_mem;
 
-	if (trace->syscalls.prog_array.sys_enter)
+#ifdef HAVE_BPF_SKEL
+	if (trace->skel->progs.sys_enter)
 		trace__init_syscalls_bpf_prog_array_maps(trace);
+#endif
 
 	if (trace->ev_qualifier_ids.nr > 0) {
 		err = trace__set_ev_qualifier_filter(trace);
@@ -3956,9 +3961,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_apply_filters;
 
-	if (trace->dump.map)
-		bpf_map__fprintf(trace->dump.map, trace->output);
-
 	err = evlist__mmap(evlist, trace->opts.mmap_pages);
 	if (err < 0)
 		goto out_error_mmap;
@@ -4655,6 +4657,18 @@ static void trace__exit(struct trace *trace)
 	zfree(&trace->perfconfig_events);
 }
 
+#ifdef HAVE_BPF_SKEL
+static int bpf__setup_bpf_output(struct evlist *evlist)
+{
+	int err = parse_event(evlist, "bpf-output/no-inherit=1,name=__augmented_syscalls__/");
+
+	if (err)
+		pr_debug("ERROR: failed to create the \"__augmented_syscalls__\" bpf-output event\n");
+
+	return err;
+}
+#endif
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -4686,7 +4700,6 @@ int cmd_trace(int argc, const char **argv)
 		.max_stack = UINT_MAX,
 		.max_events = ULONG_MAX,
 	};
-	const char *map_dump_str = NULL;
 	const char *output_name = NULL;
 	const struct option trace_options[] = {
 	OPT_CALLBACK('e', "event", &trace, "event",
@@ -4720,9 +4733,6 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
-#ifdef HAVE_LIBBPF_SUPPORT
-	OPT_STRING(0, "map-dump", &map_dump_str, "BPF map", "BPF map to periodically dump"),
-#endif
 	OPT_BOOLEAN(0, "sched", &trace.sched, "show blocking scheduler events"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_BOOLEAN('T', "time", &trace.full_time,
@@ -4849,16 +4859,55 @@ int cmd_trace(int argc, const char **argv)
 				       "cgroup monitoring only available in system-wide mode");
 	}
 
-	err = -1;
+#ifdef HAVE_BPF_SKEL
+	trace.skel = augmented_raw_syscalls_bpf__open();
+	if (!trace.skel) {
+		pr_debug("Failed to open augmented syscalls BPF skeleton");
+	} else {
+		/*
+		 * Disable attaching the BPF programs except for sys_enter and
+		 * sys_exit that tail call into this as necessary.
+		 */
+		bpf_program__set_autoattach(trace.skel->progs.syscall_unaugmented,
+					    /*autoattach=*/false);
+		bpf_program__set_autoattach(trace.skel->progs.sys_enter_connect,
+					    /*autoattach=*/false);
+		bpf_program__set_autoattach(trace.skel->progs.sys_enter_sendto,
+					    /*autoattach=*/false);
+		bpf_program__set_autoattach(trace.skel->progs.sys_enter_open,
+					    /*autoattach=*/false);
+		bpf_program__set_autoattach(trace.skel->progs.sys_enter_openat,
+					    /*autoattach=*/false);
+		bpf_program__set_autoattach(trace.skel->progs.sys_enter_rename,
+					    /*autoattach=*/false);
+		bpf_program__set_autoattach(trace.skel->progs.sys_enter_renameat,
+					    /*autoattach=*/false);
+		bpf_program__set_autoattach(trace.skel->progs.sys_enter_perf_event_open,
+					    /*autoattach=*/false);
+		bpf_program__set_autoattach(trace.skel->progs.sys_enter_clock_nanosleep,
+					    /*autoattach=*/false);
+
+		err = augmented_raw_syscalls_bpf__load(trace.skel);
 
-	if (map_dump_str) {
-		trace.dump.map = trace__find_bpf_map_by_name(&trace, map_dump_str);
-		if (trace.dump.map == NULL) {
-			pr_err("ERROR: BPF map \"%s\" not found\n", map_dump_str);
-			goto out;
+		if (err < 0) {
+			pr_debug("Failed to load augmented syscalls BPF skeleton\n");
+		} else {
+			augmented_raw_syscalls_bpf__attach(trace.skel);
+			trace__add_syscall_newtp(&trace);
 		}
 	}
 
+	err = bpf__setup_bpf_output(trace.evlist);
+	if (err) {
+		libbpf_strerror(err, bf, sizeof(bf));
+		pr_err("ERROR: Setup BPF output event failed: %s\n", bf);
+		goto out;
+	}
+	trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
+	assert(!strcmp(evsel__name(trace.syscalls.events.bpf_output), "__augmented_syscalls__"));
+#endif
+	err = -1;
+
 	if (trace.trace_pgfaults) {
 		trace.opts.sample_address = true;
 		trace.opts.sample_time = true;
@@ -4909,7 +4958,7 @@ int cmd_trace(int argc, const char **argv)
 	 * buffers that are being copied from kernel to userspace, think 'read'
 	 * syscall.
 	 */
-	if (trace.syscalls.events.augmented) {
+	if (trace.syscalls.events.bpf_output) {
 		evlist__for_each_entry(trace.evlist, evsel) {
 			bool raw_syscalls_sys_exit = strcmp(evsel__name(evsel), "raw_syscalls:sys_exit") == 0;
 
@@ -4918,9 +4967,9 @@ int cmd_trace(int argc, const char **argv)
 				goto init_augmented_syscall_tp;
 			}
 
-			if (trace.syscalls.events.augmented->priv == NULL &&
+			if (trace.syscalls.events.bpf_output->priv == NULL &&
 			    strstr(evsel__name(evsel), "syscalls:sys_enter")) {
-				struct evsel *augmented = trace.syscalls.events.augmented;
+				struct evsel *augmented = trace.syscalls.events.bpf_output;
 				if (evsel__init_augmented_syscall_tp(augmented, evsel) ||
 				    evsel__init_augmented_syscall_tp_args(augmented))
 					goto out;
@@ -5025,5 +5074,8 @@ int cmd_trace(int argc, const char **argv)
 		fclose(trace.output);
 out:
 	trace__exit(&trace);
+#ifdef HAVE_BPF_SKEL
+	augmented_raw_syscalls_bpf__destroy(trace.skel);
+#endif
 	return err;
 }
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
similarity index 96%
rename from tools/perf/examples/bpf/augmented_raw_syscalls.c
rename to tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 9a03189d33d3..70478b9460ee 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -18,6 +18,8 @@
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
 
+#define MAX_CPUS  4096
+
 // FIXME: These should come from system headers
 typedef char bool;
 typedef int pid_t;
@@ -34,7 +36,7 @@ struct __augmented_syscalls__ {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__type(key, int);
 	__type(value, __u32);
-	__uint(max_entries, __NR_CPUS__);
+	__uint(max_entries, MAX_CPUS);
 } __augmented_syscalls__ SEC(".maps");
 
 /*
@@ -170,7 +172,7 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 	return augmented_len;
 }
 
-SEC("!raw_syscalls:unaugmented")
+SEC("tp/raw_syscalls/sys_enter")
 int syscall_unaugmented(struct syscall_enter_args *args)
 {
 	return 1;
@@ -182,7 +184,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
  * on from there, reading the first syscall arg as a string, i.e. open's
  * filename.
  */
-SEC("!syscalls:sys_enter_connect")
+SEC("tp/syscalls/sys_enter_connect")
 int sys_enter_connect(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
@@ -201,7 +203,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	return augmented__output(args, augmented_args, len + socklen);
 }
 
-SEC("!syscalls:sys_enter_sendto")
+SEC("tp/syscalls/sys_enter_sendto")
 int sys_enter_sendto(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
@@ -220,7 +222,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 	return augmented__output(args, augmented_args, len + socklen);
 }
 
-SEC("!syscalls:sys_enter_open")
+SEC("tp/syscalls/sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
@@ -235,7 +237,7 @@ int sys_enter_open(struct syscall_enter_args *args)
 	return augmented__output(args, augmented_args, len);
 }
 
-SEC("!syscalls:sys_enter_openat")
+SEC("tp/syscalls/sys_enter_openat")
 int sys_enter_openat(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
@@ -250,7 +252,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
 	return augmented__output(args, augmented_args, len);
 }
 
-SEC("!syscalls:sys_enter_rename")
+SEC("tp/syscalls/sys_enter_rename")
 int sys_enter_rename(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
@@ -267,7 +269,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
 	return augmented__output(args, augmented_args, len);
 }
 
-SEC("!syscalls:sys_enter_renameat")
+SEC("tp/syscalls/sys_enter_renameat")
 int sys_enter_renameat(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
@@ -295,7 +297,7 @@ struct perf_event_attr_size {
         __u32                   size;
 };
 
-SEC("!syscalls:sys_enter_perf_event_open")
+SEC("tp/syscalls/sys_enter_perf_event_open")
 int sys_enter_perf_event_open(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
@@ -327,7 +329,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
 	return 1; /* Failure: don't filter */
 }
 
-SEC("!syscalls:sys_enter_clock_nanosleep")
+SEC("tp/syscalls/sys_enter_clock_nanosleep")
 int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
@@ -358,7 +360,7 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
-SEC("raw_syscalls:sys_enter")
+SEC("tp/raw_syscalls/sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args;
@@ -371,7 +373,6 @@ int sys_enter(struct syscall_enter_args *args)
 	 * We'll add to this as we add augmented syscalls right after that
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
-	unsigned int len = sizeof(augmented_args->args);
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
@@ -393,7 +394,7 @@ int sys_enter(struct syscall_enter_args *args)
 	return 0;
 }
 
-SEC("raw_syscalls:sys_exit")
+SEC("tp/raw_syscalls/sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
-- 
2.41.0.640.ga95def55d0-goog


