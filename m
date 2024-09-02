Return-Path: <bpf+bounces-38735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40E968EAF
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BD71C220E1
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDAE21C160;
	Mon,  2 Sep 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfWFcmaX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9B2101A3;
	Mon,  2 Sep 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307518; cv=none; b=R+JAOHvwH4nzrePIsWV9xnDIbKHqfP0Zm9PIPJMXAfyiLw2RlnfMj9ClZv3AuJko/cMEEuO8CZH/zNVJR3MwBa9gDCf2AfgwbDMDvLqeGZ4dlkdO4kcPM5L2YmCT7fS6Y4RaYsgCwEiglgtUSB0kNeDj1si3pGEQI6Q6VkPwIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307518; c=relaxed/simple;
	bh=X0ek1mkNREyiAUXg/Zefjuh2UjFk41svoWx7X7V/gXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxvLSiXgLVMn2+Vs0FnwCfjQOXITJ4z7WLAhp9nIvGOyWInzqtxa7/98FgP7QkeDL1fcuZQxJg2ucTjVOVmTS4H9JAPBEehjdEgYG5Akg1kMBSjurJiSrZLLa5ZN88lkmvWhjTuz7Vly/zFTqe/6Zs+mxWcSwVfwJEZUvVp6i8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfWFcmaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC3FC4CEC6;
	Mon,  2 Sep 2024 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725307517;
	bh=X0ek1mkNREyiAUXg/Zefjuh2UjFk41svoWx7X7V/gXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfWFcmaXkqXOyiKyuLySUQCBSTLT+vaUa/Wf34esFu3T7u6/0cfcV6VMC5UDUM6NE
	 4iCtLLrCh6P3kK+WYLqAd/bi2FzWOExK7Icm5359ajYT/f0+hG3x2G1hwEEPFa5fQv
	 hIh/khzaaOiQelWCV2j9YayG5On6hkyQBH8JFB4achqGvxMne24aQ1I8tMbrH/+0M8
	 UTmJQCPTe+f7PBNWkQ1kvjqnILaxaD5Rqei6W/N0QT/gGAwnlG1XAuY3af3YDh82Tg
	 ajS+DZDEcGe71IuaLO9938rmPjW1Eyy9CxDDZC3/lIpGDNNSea1xgWVbtyfDRXZDGW
	 4z1TNq8TBM1qQ==
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
Subject: [PATCH 2/5] perf ftrace latency: Constify control data for BPF
Date: Mon,  2 Sep 2024 13:05:12 -0700
Message-ID: <20240902200515.2103769-3-namhyung@kernel.org>
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
 tools/perf/util/bpf_ftrace.c                | 8 ++++----
 tools/perf/util/bpf_skel/func_latency.bpf.c | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 7a4297d8fd2ce925..06d1c4018407a265 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -40,13 +40,17 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 	if (ftrace->target.cpu_list) {
 		ncpus = perf_cpu_map__nr(ftrace->evlist->core.user_requested_cpus);
 		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
+		skel->rodata->has_cpu = 1;
 	}
 
 	if (target__has_task(&ftrace->target) || target__none(&ftrace->target)) {
 		ntasks = perf_thread_map__nr(ftrace->evlist->core.threads);
 		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+		skel->rodata->has_task = 1;
 	}
 
+	skel->rodata->use_nsec = ftrace->use_nsec;
+
 	set_max_rlimit();
 
 	err = func_latency_bpf__load(skel);
@@ -59,7 +63,6 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		u32 cpu;
 		u8 val = 1;
 
-		skel->bss->has_cpu = 1;
 		fd = bpf_map__fd(skel->maps.cpu_filter);
 
 		for (i = 0; i < ncpus; i++) {
@@ -72,7 +75,6 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		u32 pid;
 		u8 val = 1;
 
-		skel->bss->has_task = 1;
 		fd = bpf_map__fd(skel->maps.task_filter);
 
 		for (i = 0; i < ntasks; i++) {
@@ -81,8 +83,6 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		}
 	}
 
-	skel->bss->use_nsec = ftrace->use_nsec;
-
 	skel->links.func_begin = bpf_program__attach_kprobe(skel->progs.func_begin,
 							    false, func->name);
 	if (IS_ERR(skel->links.func_begin)) {
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index 9d01e3af747922ca..f613dc9cb123480c 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -37,9 +37,10 @@ struct {
 
 
 int enabled = 0;
-int has_cpu = 0;
-int has_task = 0;
-int use_nsec = 0;
+
+const volatile int has_cpu = 0;
+const volatile int has_task = 0;
+const volatile int use_nsec = 0;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
-- 
2.46.0.469.g59c65b2a67-goog


