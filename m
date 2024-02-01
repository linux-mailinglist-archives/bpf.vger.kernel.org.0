Return-Path: <bpf+bounces-20909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BA784503C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05501F23F87
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAE3FE4C;
	Thu,  1 Feb 2024 04:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4JhR1+W1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18F3F9C6
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761384; cv=none; b=JpG/kOWG4W+y4nNv+5QRbPYN2yOtj25N0ywA7usPnJ5sLSMB7XZCUffo/ULBas4pvaqnrssBwo8MHBexzp77TQF+BPHwO94mNVf9OIN1ZUGG3LWkQ+eoFXybO/n598SQ2hE7UGYR4WGFkoYH34r+jwolg8Ar2+RR/ZsyTjEr428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761384; c=relaxed/simple;
	bh=rcLKh3+Pos68LmxJ9Hm/6wnfZr3ChIf03nmHam1edtQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iv24bQvqyO1g2G02+9tcrC58quItMTD39GqZLUgkXwF0zRV7hR64RU7+Z5JoCwWRmTMyWZSAiuwzYbZXVVhFOXHxjbNABr+qNiY1kQi7IKjfPZSpoDXJuntUvnBnoJneioNDpMZBhIHLtaH5OJ+KP/AoEfo9x4UEhDx1kcP9dEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4JhR1+W1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so991969276.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761381; x=1707366181; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaackeHVB/qKw2MvrD7oP7QYNMjIwSaxho/+246ePe0=;
        b=4JhR1+W1YmqUbpXA7T4AygMApo80I6G3b1PQq9FzIZ/dej7f0oIpEFE3A/GrQPkfVw
         YxRgxcPboW8nY3qGZ7/5RgUgvvhHT+fKN36BUmuyyvWfEWPEtqBJYzIcq1Qy3A2Lobfh
         Vm5C96+GBSJ+ckbmkn7KZ62DxY4vc3zP+qVtD5Y3cVfOQUZbXXOtQEtu6MHZKxXTLKyA
         qwQwe/M1RG+aC/PYGH9oZUjGIjsujZ/7QCp0Iku6J+AkBs/1WNBuxLp9YijQON9+0ZMZ
         aNMuukIwV3J/SV+rBhF7QPmKQOzpiXqsafSF//aHPq2Xz+dPYdG+MlgNmsnqeDjMBP5h
         e7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761381; x=1707366181;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaackeHVB/qKw2MvrD7oP7QYNMjIwSaxho/+246ePe0=;
        b=qGj3j/vRqUPC1kM3Nb4rP/xQTZhlB3t6MNRHlpkXfMlnQkXnmZxp4s+pH01i2qpf9j
         59LXEsN0A6dzInLmWzX6WiZTvzVtkY04blkcRPzZYb/Lev90ncSWdIDbfMYIjbOwhf/x
         qoOSgSwsqjEZdYArn01bL4H37wAEe08cU/NL2O/Fmsm6FVlXFJQlu7oWoze0QK/vMOW+
         Yi4gbeMkKEmPqLdGqqUJygl9NJ6vHiWgVJtfNo5iR/1fV5J5zwfw/exjqkLGG1eAGPFH
         ymbBcFgki76KU8pjWeh5TMx01dhwBTV5ZX53nUSuKFfsDdwycZcLTOZ1qMM4Af4NOb3e
         lGqQ==
X-Gm-Message-State: AOJu0YyAL05dOxkfB0ZFKbUaeTRDh/6Ncppa8irW3dgB7V80b+n4gwSn
	t33fUOdguRlCXbNU6qdVF0LYIptnv91+nI/JlTSgIcf99RKknMdsjHoISsqckC57ogALMcUoBJG
	fvBdhpw==
X-Google-Smtp-Source: AGHT+IEUPC2zlxhPtNWRqxBFUB5XE3UaTGp/yUzEFGp5NGipkKsgllYlB40XOB8TU6jIChbSPsGFseZNtWq5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:6902:2082:b0:dc2:50cd:bee6 with SMTP
 id di2-20020a056902208200b00dc250cdbee6mr1003483ybb.9.1706761381204; Wed, 31
 Jan 2024 20:23:01 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:33 -0800
In-Reply-To: <20240201042236.1538928-1-irogers@google.com>
Message-Id: <20240201042236.1538928-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 5/8] perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
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
2.43.0.429.g432eaa2c6b-goog


