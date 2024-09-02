Return-Path: <bpf+bounces-38738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7DA968EB5
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D01F2343F
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BDD3DAC09;
	Mon,  2 Sep 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHKAT3vc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B621C19E;
	Mon,  2 Sep 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307519; cv=none; b=OLcrY3yPFGBxBho3TSP3EEH997ZM6vKhUKFHfpYUU8x0Gepa3zVCBYhNbKNSBi6xlinKHxGlICEwR8kNOl2/Olemqgjwq1rrEnJTZkYfnhxs3rS7CokiQGza6rnApRVF0Mj29AFanjYuncb5uMGT0i5S4QtqjH0D/f0IzW+685I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307519; c=relaxed/simple;
	bh=+Pwd5GaA9knREy8lwTTeOVCpbI0xDH9FKh/p825ZiW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBq006awsAbS+2e6xiZNAPZQ3/J+R90KtY1UrKpLEGgWdfEN3eQDwi/rAovVblrzGhX8mqjhRxMhUsxoF/Yo5nod8ihNjragtRquYb0+ZNLfxz1pANqA+GnEikV0yHXTwfqRSNR+VLnbwjFy5m14Zf5jLIi3Xp6kvYLqUnHLqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHKAT3vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CE1C4CED4;
	Mon,  2 Sep 2024 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725307519;
	bh=+Pwd5GaA9knREy8lwTTeOVCpbI0xDH9FKh/p825ZiW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHKAT3vcR/3ZyLfB90CSL3UldTyRqP/Z4jDLAbdHrop+kFB6gZFw9TBniv0PORXHJ
	 eUKgiWz3MS1acbIFVyApmYtjT6pS5ZEP9bKx2eE+Y3mKF4eFMoOUH1875B2QRkFhRz
	 2Ktd/b6xnzr6IK32MUcxs4ribt2JWoLh5VRhZWxLnERn2Xfxm8d06yZs4OHCGMZBcy
	 N+35ssm00BaE2gtjPEsRNnJpH2jlnzn4jOrRDemLVXxIrWj3ru17T6cKy3laY0Y+di
	 d1+AVY6tx0GOiE1wBWZug0OzLat/WP+Dj3efcDQ4udm5CldeqToRaQXBwREQj+vL6t
	 USohxECgf5Tpg==
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
Subject: [PATCH 5/5] perf record offcpu: Constify control data for BPF
Date: Mon,  2 Sep 2024 13:05:15 -0700
Message-ID: <20240902200515.2103769-6-namhyung@kernel.org>
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
 tools/perf/util/bpf_off_cpu.c          | 16 ++++++++--------
 tools/perf/util/bpf_skel/off_cpu.bpf.c |  9 +++++----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 6af36142dc5a7fd0..a590a8ac1f9d42f0 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -73,14 +73,12 @@ static void off_cpu_start(void *arg)
 	struct evlist *evlist = arg;
 
 	/* update task filter for the given workload */
-	if (!skel->bss->has_cpu && !skel->bss->has_task &&
+	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
 	    perf_thread_map__pid(evlist->core.threads, 0) != -1) {
 		int fd;
 		u32 pid;
 		u8 val = 1;
 
-		skel->bss->has_task = 1;
-		skel->bss->uses_tgid = 1;
 		fd = bpf_map__fd(skel->maps.task_filter);
 		pid = perf_thread_map__pid(evlist->core.threads, 0);
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
@@ -148,6 +146,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	if (target->cpu_list) {
 		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
 		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
+		skel->rodata->has_cpu = 1;
 	}
 
 	if (target->pid) {
@@ -173,11 +172,16 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 			ntasks = MAX_PROC;
 
 		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+		skel->rodata->has_task = 1;
+		skel->rodata->uses_tgid = 1;
 	} else if (target__has_task(target)) {
 		ntasks = perf_thread_map__nr(evlist->core.threads);
 		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+		skel->rodata->has_task = 1;
 	} else if (target__none(target)) {
 		bpf_map__set_max_entries(skel->maps.task_filter, MAX_PROC);
+		skel->rodata->has_task = 1;
+		skel->rodata->uses_tgid = 1;
 	}
 
 	if (evlist__first(evlist)->cgrp) {
@@ -186,6 +190,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 
 		if (!cgroup_is_v2("perf_event"))
 			skel->rodata->uses_cgroup_v1 = true;
+		skel->rodata->has_cgroup = 1;
 	}
 
 	if (opts->record_cgroup) {
@@ -208,7 +213,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		u32 cpu;
 		u8 val = 1;
 
-		skel->bss->has_cpu = 1;
 		fd = bpf_map__fd(skel->maps.cpu_filter);
 
 		for (i = 0; i < ncpus; i++) {
@@ -220,8 +224,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 	if (target->pid) {
 		u8 val = 1;
 
-		skel->bss->has_task = 1;
-		skel->bss->uses_tgid = 1;
 		fd = bpf_map__fd(skel->maps.task_filter);
 
 		strlist__for_each_entry(pos, pid_slist) {
@@ -240,7 +242,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		u32 pid;
 		u8 val = 1;
 
-		skel->bss->has_task = 1;
 		fd = bpf_map__fd(skel->maps.task_filter);
 
 		for (i = 0; i < ntasks; i++) {
@@ -253,7 +254,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		struct evsel *evsel;
 		u8 val = 1;
 
-		skel->bss->has_cgroup = 1;
 		fd = bpf_map__fd(skel->maps.cgroup_filter);
 
 		evlist__for_each_entry(evlist, evsel) {
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index d877a0a9731f9f2f..c152116df72f9bc1 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -85,10 +85,11 @@ struct task_struct___old {
 } __attribute__((preserve_access_index));
 
 int enabled = 0;
-int has_cpu = 0;
-int has_task = 0;
-int has_cgroup = 0;
-int uses_tgid = 0;
+
+const volatile int has_cpu = 0;
+const volatile int has_task = 0;
+const volatile int has_cgroup = 0;
+const volatile int uses_tgid = 0;
 
 const volatile bool has_prev_state = false;
 const volatile bool needs_cgroup = false;
-- 
2.46.0.469.g59c65b2a67-goog


