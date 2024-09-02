Return-Path: <bpf+bounces-38736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F34C968EB1
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6041B224D3
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9C21C165;
	Mon,  2 Sep 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcw4QedY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC82101AD;
	Mon,  2 Sep 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307518; cv=none; b=kvMmVU5UzJ36jr7asExvzElDtf7UK/5xLer2eIZs3u80KIV1PKgvaAfVp5/YIYLMm658XMdyJvu7RcJMOsGtFrHt+oRRSOAiPRGLuxaNbkiiHaKVmCZj7IS/FuQvJb6rgZyG0MCk92bnDi4gHwn1H3ZLLrJ+Qm05BPzm/T7W4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307518; c=relaxed/simple;
	bh=l9WvYqLtg7S11PYIe7m0qJ7EWnF5FzWibwNh2ZfGfh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2VokN/U5INcvvTk4j0c6s69zYfakl5IucDQZ5b43HlqHCL2MSaES20A7BY0teAdpchOQbyJVkR8ylScvm70deA22akYh/jCAiIQ1Pd5qLh0Ye5NCJy6in4eyWfBwGJTwcrLOAchFgszQn7nqHg3diRzH6oVOfCnk1cxchf1K+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcw4QedY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877A3C4CEC2;
	Mon,  2 Sep 2024 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725307518;
	bh=l9WvYqLtg7S11PYIe7m0qJ7EWnF5FzWibwNh2ZfGfh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xcw4QedY8Hsw3AEiWp2y/ghitLVzgHDnnTnLlMit3qi4rOInt5+SX62KHGVcxO4mv
	 VHHs8TTJ8jBYUtKKWgx8uYdaRI6E7m5V3VVDlYXtzIrI2L9WB9GeJQH74XdLC+F0L6
	 F+NZXi2bIWdWTTrpGfMI+J2GGNDCbxlYaUhSPUX3R2GUUvHP9yC1saw5y+rPzX/33h
	 g4NsZRGchgJdnyQirsd9kzxYmOECyUxLu9MBmYEbNBepu0qRjI3r0VsFAqUy7yLzsi
	 doGHAiLXZtSh3CMObS1dmAmpeGE52af6veKcpxDpokHW4PMP9OJ+vM7R7qCerwhkg7
	 07oTXI+N3BD4g==
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
	Yang Jihong <yangjihong@bytedance.com>
Subject: [PATCH 3/5] perf kwork: Constify control data for BPF
Date: Mon,  2 Sep 2024 13:05:13 -0700
Message-ID: <20240902200515.2103769-4-namhyung@kernel.org>
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

Cc: Yang Jihong <yangjihong@bytedance.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_kwork.c                | 9 +++++----
 tools/perf/util/bpf_kwork_top.c            | 7 ++++---
 tools/perf/util/bpf_skel/kwork_top.bpf.c   | 2 +-
 tools/perf/util/bpf_skel/kwork_trace.bpf.c | 5 +++--
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
index 44f0f708a15d6a14..6c7126b7670dd0c9 100644
--- a/tools/perf/util/bpf_kwork.c
+++ b/tools/perf/util/bpf_kwork.c
@@ -176,8 +176,6 @@ static int setup_filters(struct perf_kwork *kwork)
 			bpf_map_update_elem(fd, &cpu.cpu, &val, BPF_ANY);
 		}
 		perf_cpu_map__put(map);
-
-		skel->bss->has_cpu_filter = 1;
 	}
 
 	if (kwork->profile_name != NULL) {
@@ -197,8 +195,6 @@ static int setup_filters(struct perf_kwork *kwork)
 
 		key = 0;
 		bpf_map_update_elem(fd, &key, kwork->profile_name, BPF_ANY);
-
-		skel->bss->has_name_filter = 1;
 	}
 
 	return 0;
@@ -239,6 +235,11 @@ int perf_kwork__trace_prepare_bpf(struct perf_kwork *kwork)
 			class_bpf->load_prepare(kwork);
 	}
 
+	if (kwork->cpu_list != NULL)
+		skel->rodata->has_cpu_filter = 1;
+	if (kwork->profile_name != NULL)
+		skel->rodata->has_name_filter = 1;
+
 	if (kwork_trace_bpf__load(skel)) {
 		pr_debug("Failed to load kwork trace skeleton\n");
 		goto out;
diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index 22a3b00a1e23f929..7261cad43468d7a4 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -151,14 +151,12 @@ static int setup_filters(struct perf_kwork *kwork)
 			bpf_map_update_elem(fd, &cpu.cpu, &val, BPF_ANY);
 		}
 		perf_cpu_map__put(map);
-
-		skel->bss->has_cpu_filter = 1;
 	}
 
 	return 0;
 }
 
-int perf_kwork__top_prepare_bpf(struct perf_kwork *kwork __maybe_unused)
+int perf_kwork__top_prepare_bpf(struct perf_kwork *kwork)
 {
 	struct bpf_program *prog;
 	struct kwork_class *class;
@@ -193,6 +191,9 @@ int perf_kwork__top_prepare_bpf(struct perf_kwork *kwork __maybe_unused)
 			class_bpf->load_prepare();
 	}
 
+	if (kwork->cpu_list)
+		skel->rodata->has_cpu_filter = 1;
+
 	if (kwork_top_bpf__load(skel)) {
 		pr_debug("Failed to load kwork top skeleton\n");
 		goto out;
diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
index 84c15ccbab44ccc9..594da91965a2f6c9 100644
--- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
@@ -84,7 +84,7 @@ struct {
 
 int enabled = 0;
 
-int has_cpu_filter = 0;
+const volatile int has_cpu_filter = 0;
 
 __u64 from_timestamp = 0;
 __u64 to_timestamp = 0;
diff --git a/tools/perf/util/bpf_skel/kwork_trace.bpf.c b/tools/perf/util/bpf_skel/kwork_trace.bpf.c
index 063c124e099938ed..cbd79bc4b3302d81 100644
--- a/tools/perf/util/bpf_skel/kwork_trace.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_trace.bpf.c
@@ -68,8 +68,9 @@ struct {
 } perf_kwork_name_filter SEC(".maps");
 
 int enabled = 0;
-int has_cpu_filter = 0;
-int has_name_filter = 0;
+
+const volatile int has_cpu_filter = 0;
+const volatile int has_name_filter = 0;
 
 static __always_inline int local_strncmp(const char *s1,
 					 unsigned int sz, const char *s2)
-- 
2.46.0.469.g59c65b2a67-goog


