Return-Path: <bpf+bounces-16121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0E7FCEB8
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB292835C7
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABA1DDD0;
	Wed, 29 Nov 2023 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBY45QlV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023051BE3
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cbfcf3ae48so4461337b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 22:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237756; x=1701842556; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uG9dHqe+W7QKF/tqT6hMSrmaRYWeZm2ANVmXQYyVcMw=;
        b=MBY45QlVN+VLPP18MF80I+TOuNvbEVxLQXwYNqvHMktrELL/abBHP+Q5kA5CnVRIQR
         mJLH0YtVeHKd8ruEswkwl2IJx4tBEzzjqhUCFnAQ8qHCZajJGwVvdCSVebNySoPeCf6V
         INWDBPUK0Phkoe6v3gfYnHubHHoc7jaR6U9EIcLGyLAqUErf9r2/zaoE947hrC2IWLjf
         dcroVHPNUhVXDg6rpt1fYKTk5Ee+5rpRY5AZJPHQDKI+L7XLqSayZ3v+S8ttqVPnhl9m
         yN3kLHsHebcO8oEQfXV/JTfk7qAHLx732RrijpmdXnFLCUTGuyYtUaPxsbF7x68sDaDq
         6H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237756; x=1701842556;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uG9dHqe+W7QKF/tqT6hMSrmaRYWeZm2ANVmXQYyVcMw=;
        b=lJSaG92oU4KOfpZnTejYgLuT0UlEx/NfAZiLKMfuDnIblHx79z6eROrkXR6+oy2tUJ
         ZXnff+T/F/4QBxgOiRS+S8csvrGEBRxX4kxaE83lEnWcf0hgX5WJQQFuGUiZhQSWiVjA
         1RErtb3X2pQylV1rA6H9t3eruSi60C1QDxKDs3Mgb3sTEVnVyT5vZnGrO2EvzytnSsPp
         ZQal61rtQXfzFMOei+lnGgj8KKPGT0h9Du61to80kmcnSOhoELpwZr+BmO5OzU47Sk9e
         HwIrA8nmLvtlXZrA0PGiuZK+Raj+VgYSl1bikLt3r4+W/sdjePSWB9Um/RGygBcfB0qd
         aM9Q==
X-Gm-Message-State: AOJu0Yw3EkOAkaQAEECsqOrQkFAV/O0jvMueaaU77QtZHmdErgO5bGQY
	3BX2+2WSXMP4tTkqhag6TLGW5Z6e2+yN
X-Google-Smtp-Source: AGHT+IHZ7VKuLrd0RTaphxrTR9JPVsSgxwODprHGGe8tro5qukldPn6DgcQliDLHW2yuWD/XgfiuGYaXrgpT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:aa49:0:b0:d89:42d7:e72d with SMTP id
 s67-20020a25aa49000000b00d8942d7e72dmr669750ybi.3.1701237756399; Tue, 28 Nov
 2023 22:02:36 -0800 (PST)
Date: Tue, 28 Nov 2023 22:02:06 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 09/14] perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
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
---
 tools/perf/builtin-c2c.c   | 6 +-----
 tools/perf/builtin-stat.c  | 9 ++++-----
 tools/perf/util/auxtrace.c | 4 ++--
 tools/perf/util/record.c   | 2 +-
 tools/perf/util/stat.c     | 2 +-
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f78eea9e2153..ef7ed53a4b4e 100644
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
index 3303aa20f326..f583027a0639 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1316,10 +1316,9 @@ static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
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
@@ -1622,7 +1621,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(evsel_list->core.user_requested_cpus))
 		nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
 	else
 		nr = 0;
@@ -2289,7 +2288,7 @@ int process_stat_config_event(struct perf_session *session,
 
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
index 012c4946b9c4..915808a6211a 100644
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
2.43.0.rc1.413.gea7ed67945-goog


