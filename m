Return-Path: <bpf+bounces-38737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D522968EB4
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F661C21F03
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8385521C19C;
	Mon,  2 Sep 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxFojMMn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1D1C62DB;
	Mon,  2 Sep 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307519; cv=none; b=M823azHNlIwcvrEMQ7YB+VAfW/5pQnv5pkWXKLT/+T/oDAm+apAxH4ifu0vJdS1Kx/W0bSugXxN81S9TZKcAzk4ZZ9Yu2Drvp+fg3eZARRVZtNCynKPJyzW8ue/1p5Tw4nQgcIo4fFODRopGnc9GLCKa/yGFLUeL7GRSepgSjpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307519; c=relaxed/simple;
	bh=vbXiJUW44MYn4zKNicBPcWvvEQsLojbALFnxDDCzRRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1JjEwBV8fSwf4WER1Y3xe60qgyZddsqgy7kw9L22sfRbKVM0yBFVnKG4eZmebXO9V+6uDG36jR7xmWwby+y3V5/KyVA6UEZxMSr9kGqlbz2vf5Iu1e1tKAo+bNDKCHDsyW9I+dWeS8qPv0eJqIH9PT6BgIys0TxLZGSHjl9/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxFojMMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21931C4CED8;
	Mon,  2 Sep 2024 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725307518;
	bh=vbXiJUW44MYn4zKNicBPcWvvEQsLojbALFnxDDCzRRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxFojMMnaxyrEJG1fjJldXz3VQfQtCEhqEd9/XyRgPQfPoeb7e+3eqA7MRPgXDbgB
	 qcCGpmOT6At+kOhRbaGhvMuWBFM/hE1i78Sf5PcOoCGqkKpDw73mPN6x+2yjS4BhAN
	 N0gjLgEOIzaxh4KamQxCKawXDc770muvYd/PH4GNSTE3ZSOR/NfKmYZcKnE8mSt0MZ
	 m+7+f1U37xV7u14MgBbf11n9C9rPmR5UwoKQq2seqxB/rDEat4FgcELJV1jZSJ3MxU
	 AsPvnq9euqHRgxYXh7fhfPQjDLt2qOo3zMQ72Yx3OtvvLDnpGgI9pv5sXDrQb8S4JQ
	 2F5s62IIXeiLA==
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
Subject: [PATCH 4/5] perf lock contention: Constify control data for BPF
Date: Mon,  2 Sep 2024 13:05:14 -0700
Message-ID: <20240902200515.2103769-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902200515.2103769-1-namhyung@kernel.org>
References: <20240902200515.2103769-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control knobs set before loading BPF programs should be declared as
'const volatile' so that it can be optimized by the BPF core.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c         | 45 ++++++++++---------
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 27 +++++------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index bc4e92c0c08b8b20..41a1ad08789511c3 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -46,14 +46,22 @@ int lock_contention_prepare(struct lock_contention *con)
 	else
 		bpf_map__set_max_entries(skel->maps.stacks, 1);
 
-	if (target__has_cpu(target))
+	if (target__has_cpu(target)) {
+		skel->rodata->has_cpu = 1;
 		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
-	if (target__has_task(target))
+	}
+	if (target__has_task(target)) {
+		skel->rodata->has_task = 1;
 		ntasks = perf_thread_map__nr(evlist->core.threads);
-	if (con->filters->nr_types)
+	}
+	if (con->filters->nr_types) {
+		skel->rodata->has_type = 1;
 		ntypes = con->filters->nr_types;
-	if (con->filters->nr_cgrps)
+	}
+	if (con->filters->nr_cgrps) {
+		skel->rodata->has_cgroup = 1;
 		ncgrps = con->filters->nr_cgrps;
+	}
 
 	/* resolve lock name filters to addr */
 	if (con->filters->nr_syms) {
@@ -82,6 +90,7 @@ int lock_contention_prepare(struct lock_contention *con)
 			con->filters->addrs = addrs;
 		}
 		naddrs = con->filters->nr_addrs;
+		skel->rodata->has_addr = 1;
 	}
 
 	bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
@@ -90,6 +99,16 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_map__set_max_entries(skel->maps.addr_filter, naddrs);
 	bpf_map__set_max_entries(skel->maps.cgroup_filter, ncgrps);
 
+	skel->rodata->stack_skip = con->stack_skip;
+	skel->rodata->aggr_mode = con->aggr_mode;
+	skel->rodata->needs_callstack = con->save_callstack;
+	skel->rodata->lock_owner = con->owner;
+
+	if (con->aggr_mode == LOCK_AGGR_CGROUP || con->filters->nr_cgrps) {
+		if (cgroup_is_v2("perf_event"))
+			skel->rodata->use_cgroup_v2 = 1;
+	}
+
 	if (lock_contention_bpf__load(skel) < 0) {
 		pr_err("Failed to load lock-contention BPF skeleton\n");
 		return -1;
@@ -99,7 +118,6 @@ int lock_contention_prepare(struct lock_contention *con)
 		u32 cpu;
 		u8 val = 1;
 
-		skel->bss->has_cpu = 1;
 		fd = bpf_map__fd(skel->maps.cpu_filter);
 
 		for (i = 0; i < ncpus; i++) {
@@ -112,7 +130,6 @@ int lock_contention_prepare(struct lock_contention *con)
 		u32 pid;
 		u8 val = 1;
 
-		skel->bss->has_task = 1;
 		fd = bpf_map__fd(skel->maps.task_filter);
 
 		for (i = 0; i < ntasks; i++) {
@@ -125,7 +142,6 @@ int lock_contention_prepare(struct lock_contention *con)
 		u32 pid = evlist->workload.pid;
 		u8 val = 1;
 
-		skel->bss->has_task = 1;
 		fd = bpf_map__fd(skel->maps.task_filter);
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
@@ -133,7 +149,6 @@ int lock_contention_prepare(struct lock_contention *con)
 	if (con->filters->nr_types) {
 		u8 val = 1;
 
-		skel->bss->has_type = 1;
 		fd = bpf_map__fd(skel->maps.type_filter);
 
 		for (i = 0; i < con->filters->nr_types; i++)
@@ -143,7 +158,6 @@ int lock_contention_prepare(struct lock_contention *con)
 	if (con->filters->nr_addrs) {
 		u8 val = 1;
 
-		skel->bss->has_addr = 1;
 		fd = bpf_map__fd(skel->maps.addr_filter);
 
 		for (i = 0; i < con->filters->nr_addrs; i++)
@@ -153,25 +167,14 @@ int lock_contention_prepare(struct lock_contention *con)
 	if (con->filters->nr_cgrps) {
 		u8 val = 1;
 
-		skel->bss->has_cgroup = 1;
 		fd = bpf_map__fd(skel->maps.cgroup_filter);
 
 		for (i = 0; i < con->filters->nr_cgrps; i++)
 			bpf_map_update_elem(fd, &con->filters->cgrps[i], &val, BPF_ANY);
 	}
 
-	/* these don't work well if in the rodata section */
-	skel->bss->stack_skip = con->stack_skip;
-	skel->bss->aggr_mode = con->aggr_mode;
-	skel->bss->needs_callstack = con->save_callstack;
-	skel->bss->lock_owner = con->owner;
-
-	if (con->aggr_mode == LOCK_AGGR_CGROUP) {
-		if (cgroup_is_v2("perf_event"))
-			skel->bss->use_cgroup_v2 = 1;
-
+	if (con->aggr_mode == LOCK_AGGR_CGROUP)
 		read_all_cgroups(&con->cgroups);
-	}
 
 	bpf_program__set_autoload(skel->progs.collect_lock_syms, false);
 
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 52a876b4269917fe..1069bda5d733887f 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -117,21 +117,22 @@ struct mm_struct___new {
 } __attribute__((preserve_access_index));
 
 /* control flags */
-int enabled;
-int has_cpu;
-int has_task;
-int has_type;
-int has_addr;
-int has_cgroup;
-int needs_callstack;
-int stack_skip;
-int lock_owner;
-
-int use_cgroup_v2;
-int perf_subsys_id = -1;
+const volatile int has_cpu;
+const volatile int has_task;
+const volatile int has_type;
+const volatile int has_addr;
+const volatile int has_cgroup;
+const volatile int needs_callstack;
+const volatile int stack_skip;
+const volatile int lock_owner;
+const volatile int use_cgroup_v2;
 
 /* determine the key of lock stat */
-int aggr_mode;
+const volatile int aggr_mode;
+
+int enabled;
+
+int perf_subsys_id = -1;
 
 __u64 end_ts;
 
-- 
2.46.0.469.g59c65b2a67-goog


