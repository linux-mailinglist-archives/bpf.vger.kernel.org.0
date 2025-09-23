Return-Path: <bpf+bounces-69343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6DB9435D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC13A8124
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F4A277013;
	Tue, 23 Sep 2025 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05KHM8S7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553342D6E73
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601180; cv=none; b=Vw8lgavxL9/wPIEvr6K0Ud9sGekwjhDnq4LuG2sTI4kfl9b6LhwkrNWAeGgIyxXF0pR9J0Hd1kGHtoYZlY1MB5rICuu53o34fG81soXSFFQ7Z23lJ+5qLN7t/9Ts9B4dUo3qejOmVjb/32R4uhFaSjA+4YVibdin2Bddbb78IQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601180; c=relaxed/simple;
	bh=sMXibGAMylnnOTr9IMrkloBsHRo/TuSst+eik782LGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uydLElAOmZNJ7n0UZPHHsGNtEvVwrJ1/3hFiUFGZljGKWB4GkCHEvq9Bd0v/ZlsgK7/aPX+SkWbs0lk/4LgNM3ZKdGK3DLs9MJrw0J8dNpWUrm3Ybk4h90LwV0ZLCurPV0ATBQaGokUrfN3l6+yLehYoyCVbLGYbcuGnxfcmyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05KHM8S7; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-34f747ca47eso11226fac.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601177; x=1759205977; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFehdj+GFPwFMTY63Me6tuRq8q+VYWjAfL7ANtjBHOA=;
        b=05KHM8S7us08NtsYcAvNtor8hS1fMD1mjN1x1UB3vbyFRIJ35qxxox68r/aIMNRZ1D
         NEwg5XC0bdxc5anMIoN+qc9WVEdH75V6wCZzu6RqYg1tuW7zODqhZYnRzG5ajbQYpd+C
         Vud8qw0PmF0m3TbmEpw5edhELfhNR+RaQcSwjQr4LhuNFuv7PIlZJHIZiYF8KakqIOkh
         L4D7/vuXobXLp9cBg1xTf3V+xoDcxD5OGzhkMd0v6BB2y+vx9MKSzWe8FuvghFx7I0u/
         Y4mEL+BudG13dNfqkvJaXkDOTLvS6BNRbXBLTpHSfr49eQvSgnWDPi6ocXt72065PYas
         wqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601177; x=1759205977;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFehdj+GFPwFMTY63Me6tuRq8q+VYWjAfL7ANtjBHOA=;
        b=GiDvl9+CMf+tD9FYaOmFFkJdAAo6g1CTyBLELtMPlBjLI03fq65PMqVzhjIQdRflkr
         LnULzQXTLcBQDODhcM0m8PLPHIa5shghY86fu337UIddIImC7Nik1vkEudoO/8ON8M21
         zShs9kvRbitUPEGPTIOxxh/IzAu6EQRDGeBXm5Ly4Z//tjZV4eSETujWRYUMaRVEZXwg
         YFnyuDA43vIjMGuZySXuU0T/2nm2a3/GKT2WYNKWFozRC4vbp+fT1WgCzXz5lFqxFFUs
         5+1645oZu2oSbZYQJIPVj2a1Q4DeWu4MihdHIRpWsqrZa8bZ9PhktSoKoeBWtnfysAm3
         5HPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2JyAjpCrBi4jeM7eCN4lCzwCaHI4AEkBnFqcq0RAdK1LF/EPdz8lkLxK+Oaymn02x20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lvtN9lx5HnOFLXOkc9WLPtLclkMn5DY/npJeZxxB7Jv8WDup
	r2HtCMnrQpPtRmkD0y9yA4coHO1S68Q7iI17PHx4UbVZPAwc4N8Zcojr+OW6XOyAg5ui7Bz8E/Z
	l6oGqvBdMhg==
X-Google-Smtp-Source: AGHT+IFYJLWg6R+xLesrlcZ26KCcGDTtIACNtv/0PFx/jnIGt+Kn4yXN+9qBD5mhLVmYTjEszZizeuu7MQZH
X-Received: from oabpu26.prod.google.com ([2002:a05:6870:9e9a:b0:31d:67f5:36cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:6b97:b0:337:74c4:8f18
 with SMTP id 586e51a60fabf-34c77660addmr625318fac.6.1758601177537; Mon, 22
 Sep 2025 21:19:37 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:41 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-23-irogers@google.com>
Subject: [PATCH v5 22/25] perf test parse-events: Remove cpu PMU requirement
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

In the event parse string, switch "cpu" to "default_core" and then
rewrite this to the first core PMU name prior to parsing. This enables
testing with a PMU on hybrid x86 and other systems that don't use
"cpu" for the core PMU name. The name "default_core" is already used
by jevents. Update test expectations to match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 141 ++++++++++++++------------------
 1 file changed, 63 insertions(+), 78 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index d0f1e05139ac..4f197f34621b 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -646,19 +646,22 @@ static int test__checkevent_list(struct evlist *evlist)
 static int test__checkevent_pmu_name(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
+	char buf[256];
 
-	/* cpu/config=1,name=krava/u */
+	/* default_core/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
 
-	/* cpu/config=2/u" */
+	/* default_core/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=2/u"));
+	snprintf(buf, sizeof(buf), "%s/config=2/u", core_pmu->name);
+	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, buf));
 
 	return TEST_OK;
 }
@@ -667,7 +670,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	/* cpu/config=1,call-graph=fp,time,period=100000/ */
+	/* default_core/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
@@ -679,7 +682,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
 
-	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
+	/* default_core/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
@@ -702,7 +705,8 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 
 	evlist__for_each_entry(evlist, evsel) {
 		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
-					      strcmp(evsel->pmu->name, "cpu"));
+				!strncmp(evsel__name(evsel), evsel->pmu->name,
+					 strlen(evsel->pmu->name)));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -735,7 +739,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 	}
-	/* cpu/pmu-event/u*/
+	/* default_core/pmu-event/u*/
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", evsel__find_pmu(evsel)->is_core);
 	TEST_ASSERT_VAL("wrong exclude_user",
@@ -1570,14 +1574,9 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	return test__checkevent_genhw(evlist);
 }
 
-static bool test__pmu_cpu_valid(void)
+static bool test__pmu_default_core_event_valid(void)
 {
-	return !!perf_pmus__find("cpu");
-}
-
-static bool test__pmu_cpu_event_valid(void)
-{
-	struct perf_pmu *pmu = perf_pmus__find("cpu");
+	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
 
 	if (!pmu)
 		return false;
@@ -2103,26 +2102,23 @@ static const struct evlist_test test__events[] = {
 
 static const struct evlist_test test__events_pmu[] = {
 	{
-		.name  = "cpu/config=10,config1=1,config2=3,period=1000/u",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/config=10,config1=1,config2=3,period=1000/u",
 		.check = test__checkevent_pmu,
 		/* 0 */
 	},
 	{
-		.name  = "cpu/config=1,name=krava/u,cpu/config=2/u",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/config=1,name=krava/u,default_core/config=2/u",
 		.check = test__checkevent_pmu_name,
 		/* 1 */
 	},
 	{
-		.name  = "cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/config=1,call-graph=fp,time,period=100000/,default_core/config=2,call-graph=no,time=0,period=2000/",
 		.check = test__checkevent_pmu_partial_time_callgraph,
 		/* 2 */
 	},
 	{
-		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
-		.valid = test__pmu_cpu_event_valid,
+		.name  = "default_core/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
+		.valid = test__pmu_default_core_event_valid,
 		.check = test__checkevent_complex_name,
 		/* 3 */
 	},
@@ -2137,158 +2133,132 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 5 */
 	},
 	{
-		.name  = "cpu/L1-dcache-load-miss/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/L1-dcache-load-miss/",
 		.check = test__checkevent_genhw,
 		/* 6 */
 	},
 	{
-		.name  = "cpu/L1-dcache-load-miss/kp",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/L1-dcache-load-miss/kp",
 		.check = test__checkevent_genhw_modifier,
 		/* 7 */
 	},
 	{
-		.name  = "cpu/L1-dcache-misses,name=cachepmu/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/L1-dcache-misses,name=cachepmu/",
 		.check = test__checkevent_config_cache,
 		/* 8 */
 	},
 	{
-		.name  = "cpu/instructions/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/",
 		.check = test__checkevent_symbolic_name,
 		/* 9 */
 	},
 	{
-		.name  = "cpu/cycles,period=100000,config2/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles,period=100000,config2/",
 		.check = test__checkevent_symbolic_name_config,
 		/* 0 */
 	},
 	{
-		.name  = "cpu/instructions/h",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/h",
 		.check = test__checkevent_symbolic_name_modifier,
 		/* 1 */
 	},
 	{
-		.name  = "cpu/instructions/G",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/G",
 		.check = test__checkevent_exclude_host_modifier,
 		/* 2 */
 	},
 	{
-		.name  = "cpu/instructions/H",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/H",
 		.check = test__checkevent_exclude_guest_modifier,
 		/* 3 */
 	},
 	{
-		.name  = "{cpu/instructions/k,cpu/cycles/upp}",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/instructions/k,default_core/cycles/upp}",
 		.check = test__group1,
 		/* 4 */
 	},
 	{
-		.name  = "{cpu/cycles/u,cpu/instructions/kp}:p",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/u,default_core/instructions/kp}:p",
 		.check = test__group4,
 		/* 5 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/G}:H",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/G}:H",
 		.check = test__group_gh1,
 		/* 6 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/H}:G",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/H}:G",
 		.check = test__group_gh2,
 		/* 7 */
 	},
 	{
-		.name  = "{cpu/cycles/G,cpu/cache-misses/H}:u",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/G,default_core/cache-misses/H}:u",
 		.check = test__group_gh3,
 		/* 8 */
 	},
 	{
-		.name  = "{cpu/cycles/G,cpu/cache-misses/H}:uG",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/G,default_core/cache-misses/H}:uG",
 		.check = test__group_gh4,
 		/* 9 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:S",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/,default_core/branch-misses/}:S",
 		.check = test__leader_sample1,
 		/* 0 */
 	},
 	{
-		.name  = "{cpu/instructions/,cpu/branch-misses/}:Su",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/instructions/,default_core/branch-misses/}:Su",
 		.check = test__leader_sample2,
 		/* 1 */
 	},
 	{
-		.name  = "cpu/instructions/uDp",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/uDp",
 		.check = test__checkevent_pinned_modifier,
 		/* 2 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:D",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/,default_core/branch-misses/}:D",
 		.check = test__pinned_group,
 		/* 3 */
 	},
 	{
-		.name  = "cpu/instructions/I",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/I",
 		.check = test__checkevent_exclude_idle_modifier,
 		/* 4 */
 	},
 	{
-		.name  = "cpu/instructions/kIG",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/kIG",
 		.check = test__checkevent_exclude_idle_modifier_1,
 		/* 5 */
 	},
 	{
-		.name  = "cpu/cycles/u",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles/u",
 		.check = test__sym_event_slash,
 		/* 6 */
 	},
 	{
-		.name  = "cpu/cycles/k",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles/k",
 		.check = test__sym_event_dc,
 		/* 7 */
 	},
 	{
-		.name  = "cpu/instructions/uep",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/instructions/uep",
 		.check = test__checkevent_exclusive_modifier,
 		/* 8 */
 	},
 	{
-		.name  = "{cpu/cycles/,cpu/cache-misses/,cpu/branch-misses/}:e",
-		.valid = test__pmu_cpu_valid,
+		.name  = "{default_core/cycles/,default_core/cache-misses/,default_core/branch-misses/}:e",
 		.check = test__exclusive_group,
 		/* 9 */
 	},
 	{
-		.name  = "cpu/cycles,name=name/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles,name=name/",
 		.check = test__term_equal_term,
 		/* 0 */
 	},
 	{
-		.name  = "cpu/cycles,name=l1d/",
-		.valid = test__pmu_cpu_valid,
+		.name  = "default_core/cycles,name=l1d/",
 		.check = test__term_equal_legacy,
 		/* 1 */
 	},
@@ -2378,15 +2348,30 @@ static int combine_test_results(int existing, int latest)
 static int test_events(const struct evlist_test *events, int cnt)
 {
 	int ret = TEST_OK;
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	for (int i = 0; i < cnt; i++) {
-		const struct evlist_test *e = &events[i];
+		struct evlist_test e = events[i];
 		int test_ret;
+		const char *pos = e.name;
+		char buf[1024], *buf_pos = buf, *end;
+
+		while ((end = strstr(pos, "default_core"))) {
+			size_t len = end - pos;
+
+			strncpy(buf_pos, pos, len);
+			pos = end + 12;
+			buf_pos += len;
+			strcpy(buf_pos, core_pmu->name);
+			buf_pos += strlen(core_pmu->name);
+		}
+		strcpy(buf_pos, pos);
 
-		pr_debug("running test %d '%s'\n", i, e->name);
-		test_ret = test_event(e);
+		e.name = buf;
+		pr_debug("running test %d '%s'\n", i, e.name);
+		test_ret = test_event(&e);
 		if (test_ret != TEST_OK) {
-			pr_debug("Event test failure: test %d '%s'", i, e->name);
+			pr_debug("Event test failure: test %d '%s'", i, e.name);
 			ret = combine_test_results(ret, test_ret);
 		}
 	}
-- 
2.51.0.534.gc79095c0ca-goog


