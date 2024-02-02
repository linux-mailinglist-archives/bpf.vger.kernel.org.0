Return-Path: <bpf+bounces-21113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1211847D4F
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 00:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF62B20E96
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5994132488;
	Fri,  2 Feb 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMuuW/oA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC706130AF0
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917284; cv=none; b=cJCdfcLKWXLGG+ZxnvIJ+AcZh4PCG2KXuEjZCfRuVs01X+FCu5hJM+T3z/dY5RGLbNjWG9DmdBYWiVyZHY5+opI/i3yOmD5sOjV/z/MffP61PptHNDZQSjTmlqHLt+5q0UtJeutma3VYttsAnyqve8jHW5mLMkfZO2S8unGVAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917284; c=relaxed/simple;
	bh=TXC4fY94F4QG3R5rAXB5MKDuVhvys01fhTTOf+9TuDM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nTSOOb+n0ompNDdd/0ICjxU66d1YKA87zb5zMUkmqCYOLXOl8VELr9zbuj7zzkud5G4HHBECyzPCvrFqvA+IzT6nXJupqFlhJTLeSqAJldJ/Ai+SemJafaOpmH90OOGEnnRgmQhP/WxyV3m+b6g7toTZ7pWyHvO4Jc5Ys2zshDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMuuW/oA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ecfd153ccfso45601447b3.2
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 15:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917281; x=1707522081; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PKn59qI/eEru2iRWjl8r3A2NQszSA8YlNSVgwlBz0k=;
        b=sMuuW/oAwOEVa93y3Ljf4HwsW9FKQ/j+oHFKLOuY1zE1iGOnRqhmjnRRaE4Z8jwLR3
         gEQcjNhVLPW1yyMJWUR9nnCwtNM1m8j9Q6zssgfYlyUWfiC7mEo2LyLETLlD/dU0kqhO
         ejm/n+48PbiQFl4x9qw9MB73KRCtRZJZ8A8q2kzTUwZr06x7IyiWJPjJAi9XbbssnAYz
         JmqupUkqXZy52FfPvWgUSeqAddd5T9PmV8fiH8wwTV1VyiQKNaK5hnkd+hEc2tovNRhO
         ifi4wFsNI43STWImWgqqeBtMCdXi2saFTZ4DT1sEVa4E2GhDd/VzKPWLOOv5bloQu7+o
         zo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917281; x=1707522081;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PKn59qI/eEru2iRWjl8r3A2NQszSA8YlNSVgwlBz0k=;
        b=Y3wOEiB2IpTusq0urHEtzVLC+0sicpsvEDeBaWRCOFvDTWukQ4Oy910SCC7QlfUrgE
         jUVetlPx0Rg15/xAUGAF+CkNogko+q+f9/NlQ7d/sf8ejJjJhwPBRxRVrV3LuAdKrStU
         6QdJHA1KO/gN4uVonN59C+xDTONTKUyJ3Q4dLhvn7NX8PXJe9wnNGo7b7jJO0Vh5hwp7
         E+o+cPMpj0aUubfBj5MSgFsx524mBvyz7sBctYsCLvJcHwv0DB/4An3LSkPQkMBuNgL7
         NCgfGRDHc1qbUaKaeJ7FTkVqJInlLwgVsOiDN1yA4Su5d4dt95CK9Rtuw0PnmXwj58L1
         gPlg==
X-Gm-Message-State: AOJu0YxAauePAwHeueSBaey/G10SRNk1oT01olo0HrMgiysqj9I9Yi6R
	8pUrQh7jQrkM1g9IlSJkivXSRDKG/q8FjgaLSMmfY5XZMI0ODSiOAKTKmABxdbBFokX/j+sARa2
	y6PJ7tw==
X-Google-Smtp-Source: AGHT+IHWmLxSFYG5o2YfD0f8kFtxG69QWwfC87vLwnlWGI5t07xlvynFj+vFP0PXcxWx19/9iJha3k0Bf84P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:6902:2512:b0:dc2:1dd0:c517 with SMTP
 id dt18-20020a056902251200b00dc21dd0c517mr2454050ybb.7.1706917280766; Fri, 02
 Feb 2024 15:41:20 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:54 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 5/8] perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Most uses of what was perf_cpu_map__empty but is now
perf_cpu_map__has_any_cpu_or_is_empty want to do something with the
CPU map if it contains CPUs. Replace uses of
perf_cpu_map__has_any_cpu_or_is_empty with other helpers so that CPUs
within the map can be handled.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-c2c.c   | 6 +-----
 tools/perf/builtin-stat.c  | 9 ++++-----
 tools/perf/util/auxtrace.c | 4 ++--
 tools/perf/util/record.c   | 2 +-
 tools/perf/util/stat.c     | 2 +-
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 16b40f5d43db..24107062c43e 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2319,11 +2319,7 @@ static int setup_nodes(struct perf_session *session)
 
 		nodes[node] = set;
 
-		/* empty node, skip */
-		if (perf_cpu_map__has_any_cpu_or_is_empty(map))
-			continue;
-
-		perf_cpu_map__for_each_cpu(cpu, idx, map) {
+		perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
 			__set_bit(cpu.cpu, set);
 
 			if (WARN_ONCE(cpu2node[cpu.cpu] != -1, "node/cpu topology bug"))
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5fe9abc6a524..280eb0c99d2b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1317,10 +1317,9 @@ static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
 	 * be the first online CPU in the cache domain else use the
 	 * first online CPU of the cache domain as the ID.
 	 */
-	if (perf_cpu_map__has_any_cpu_or_is_empty(cpu_map))
+	id = perf_cpu_map__min(cpu_map).cpu;
+	if (id == -1)
 		id = cpu.cpu;
-	else
-		id = perf_cpu_map__cpu(cpu_map, 0).cpu;
 
 	/* Free the perf_cpu_map used to find the cache ID */
 	perf_cpu_map__put(cpu_map);
@@ -1623,7 +1622,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
 		nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
 	else
 		nr = 0;
@@ -2290,7 +2289,7 @@ int process_stat_config_event(struct perf_session *session,
 
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
 
-	if (perf_cpu_map__has_any_cpu_or_is_empty(st->cpus)) {
+	if (perf_cpu_map__is_empty(st->cpus)) {
 		if (st->aggr_mode != AGGR_UNSET)
 			pr_warning("warning: processing task data, aggregation mode not set\n");
 	} else if (st->aggr_mode != AGGR_UNSET) {
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3684e6009b63..6b1d4bafad59 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -174,7 +174,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   struct evlist *evlist,
 				   struct evsel *evsel, int idx)
 {
-	bool per_cpu = !perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus);
+	bool per_cpu = !perf_cpu_map__has_any_cpu(evlist->core.user_requested_cpus);
 
 	mp->mmap_needed = evsel->needs_auxtrace_mmap;
 
@@ -648,7 +648,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 
 static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
 {
-	bool per_cpu_mmaps = !perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus);
+	bool per_cpu_mmaps = !perf_cpu_map__has_any_cpu(evlist->core.user_requested_cpus);
 
 	if (per_cpu_mmaps) {
 		struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 87e817b3cf7e..e867de8ddaaa 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -237,7 +237,7 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
 
 	evsel = evlist__last(temp_evlist);
 
-	if (!evlist || perf_cpu_map__has_any_cpu_or_is_empty(evlist->core.user_requested_cpus)) {
+	if (!evlist || perf_cpu_map__is_any_cpu_or_is_empty(evlist->core.user_requested_cpus)) {
 		struct perf_cpu_map *cpus = perf_cpu_map__new_online_cpus();
 
 		if (cpus)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index b0bcf92f0f9c..0bd5467389e4 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -315,7 +315,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 	if (!counter->per_pkg)
 		return 0;
 
-	if (perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+	if (perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 		return 0;
 
 	if (!mask) {
-- 
2.43.0.594.gd9cf4e227d-goog


