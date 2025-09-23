Return-Path: <bpf+bounces-69344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FFEB94363
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E1B3B496D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2737D2D94A5;
	Tue, 23 Sep 2025 04:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUaQ7y9H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582412D7DF4
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601182; cv=none; b=Y7k8FdbqlMpzEiRxd/yZPEBZWS1rz2hJAZ7w3pMlwpptJcZlO3gvdfGxgxhFPBDDW7ID/F+jD6RbNO4X+ZE5wN4okbr/vBWknwo31jlQHxmqMMQKYt19I7mV87i6Q16w6TiZ4GtQrVg9kIOunKqd4AKn7F2wPJmVoWIzQ9gYPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601182; c=relaxed/simple;
	bh=J/njVxYCDEmbW4+z7frkDxwUpOtGcRaj4HsDxiGSg7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WJ3WVLvmvOyTSengtCz2b6pvOPaAPbcS2G7rgwO+QwpL4lum2XWJxHgCXJMbjzwfR1qR7Wh8e741zSdMPTY8FLGEu2cac1YE51FpErmu2JiYIIUeCw573nS66oOkEPi8VIb1MC3B6ari6Sqdscje5SbWwnxTMFM9tuax09sIiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUaQ7y9H; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77daad52913so3933503b3a.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601180; x=1759205980; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqGe0PNL9mmdDtMTbjwPoyqHqrWIwFj8Nxxf5qA3690=;
        b=aUaQ7y9HrJ/ixeW7Pq+kYgKyAod4s8lH8dDWm2S1LsGC2fgFIBGhu/n38FxucFj6Jv
         wjg28LpJiXRNvPU2mYulFEfjTz6xBmc4qI5kMbaBXx/RTL2enIxisnl5YlxFwgA5LQ5P
         dEF8//VVJgRqi494c22ga1dj74h8s+WRqtxjhPBQvhpz2DpQrywGpFt+oRUo+6wHkvIk
         3Lo6y4ZbSXsQJ703utqTyuxa+rN/ph/jw6rwJfjYCoiVbPv+jmVT6NOj0mqVQBc7glKl
         7VgCCt2os48YVH6L0NX/ukr9tn4ZzOavF5FbQDv8q5P3JYreuYJOHhra/uGNjl0+faGl
         zwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601180; x=1759205980;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqGe0PNL9mmdDtMTbjwPoyqHqrWIwFj8Nxxf5qA3690=;
        b=cv491dUj2/+JbVdR9ivRbig4I6awBOSpr3wSXHATvxInZlWwFnOZV9e5gRsJ8cUweB
         qcH47//2h1fEvCwcIuod6oQKkYB2COsblVZ0KyeVuaOYsrSEty11yIfI3KWR0Kz2KuCv
         ITVM/LoZWT8iAMoIRLYhMepT5+PioOp3FWPqeVsVQxoTatUvaPnZlOHqR+n9Qg63wpV3
         hK7SE2+6jEoE1zTuA56zU3/df6ySL7JOVnDilPgaAs/cPQiQxNDtmBZVBPbl/BCwx+zN
         0DswffXYaQsLg9ZuETnesdbeI3wRL+cz0I3uk15u46aDdzA6NiUrPWrldGTAfDs0F9Hc
         KSQA==
X-Forwarded-Encrypted: i=1; AJvYcCVVw80DArB21JrhQ50Uh0YoF5iWzgfqTAZBh0QPIS/N4O6Mo9k8Y98U+g5AQ/0Yeb+0WYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OrLffBw+Hdd/m0QGN0S7fOE4BnWqziu314vHvPl3rUblgNeh
	2q3L2C5ylJkrLRH4ilw+AkALO4+/UAQEoq9MXLmw6bXJGl3NLwGy2ujjp+WWfhcwmwyIyy7FX6b
	guf1+yAOGcw==
X-Google-Smtp-Source: AGHT+IGWp2qzmdaD/9P+NZzg4BtuVDVcrbuR6Y4GJ3eU5LtzSkHc0WCx5dhdYZWvarADZIxi3DZGFesI+ygN
X-Received: from pgci187.prod.google.com ([2002:a63:6dc4:0:b0:b4e:547e:d9bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748a:b0:262:9461:2e5b
 with SMTP id adf61e73a8af0-2cffd6a334bmr1811288637.53.1758601179660; Mon, 22
 Sep 2025 21:19:39 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:42 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-24-irogers@google.com>
Subject: [PATCH v5 23/25] perf test parse-events: Without a PMU use cpu-cycles
 rather than cycles
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

Without a PMU perf matches an event against any PMU with the
event. Unfortunately some PMU drivers advertise a "cycles" event which
is typically just a core event. Switch to using "cpu-cycles" which is
an indentical legacy event but avoids the multiple PMU confusion
introduced by the PMU drivers. Note, on x86 cpu-cycles is also a sysfs
event but cycles isn't.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 57 +++++++++++++++++----------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4f197f34621b..8a48a671e593 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -585,9 +585,10 @@ static int test__checkevent_pmu(struct evlist *evlist)
 {
 
 	struct evsel *evsel = evlist__first(evlist);
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",    test_config(evsel, 10));
 	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
@@ -651,14 +652,14 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 
 	/* default_core/config=1,name=krava/u */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
 
 	/* default_core/config=2/u" */
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
 	snprintf(buf, sizeof(buf), "%s/config=2/u", core_pmu->name);
 	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, buf));
@@ -669,10 +670,11 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	/* default_core/config=1,call-graph=fp,time,period=100000/ */
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
@@ -684,7 +686,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 
 	/* default_core/config=2,call-graph=no,time=0,period=2000/ */
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 2 == evsel->core.attr.config);
 	/*
 	 * The period, time and callgraph value gets configured within evlist__config,
@@ -700,11 +702,12 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 static int test__checkevent_pmu_events(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct perf_pmu *core_pmu = perf_pmus__find_core_pmu();
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 <= evlist->core.nr_entries);
 
 	evlist__for_each_entry(evlist, evsel) {
-		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
+		TEST_ASSERT_VAL("wrong type", core_pmu->type == evsel->core.attr.type ||
 				!strncmp(evsel__name(evsel), evsel->pmu->name,
 					 strlen(evsel->pmu->name)));
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
@@ -1603,7 +1606,7 @@ static int test__checkevent_complex_name(struct evlist *evlist)
 
 	TEST_ASSERT_VAL("wrong complex name parsing",
 			evsel__name_is(evsel,
-				       "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks"));
+				       "COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks"));
 	return TEST_OK;
 }
 
@@ -1740,7 +1743,7 @@ static const struct evlist_test test__events[] = {
 		/* 4 */
 	},
 	{
-		.name  = "cycles/period=100000,config2/",
+		.name  = "cpu-cycles/period=100000,config2/",
 		.check = test__checkevent_symbolic_name_config,
 		/* 5 */
 	},
@@ -1855,27 +1858,27 @@ static const struct evlist_test test__events[] = {
 		/* 7 */
 	},
 	{
-		.name  = "{instructions:k,cycles:upp}",
+		.name  = "{instructions:k,cpu-cycles:upp}",
 		.check = test__group1,
 		/* 8 */
 	},
 	{
-		.name  = "{faults:k,branches}:u,cycles:k",
+		.name  = "{faults:k,branches}:u,cpu-cycles:k",
 		.check = test__group2,
 		/* 9 */
 	},
 	{
-		.name  = "group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u",
+		.name  = "group1{syscalls:sys_enter_openat:H,cpu-cycles:kppp},group2{cpu-cycles,1:3}:G,instructions:u",
 		.check = test__group3,
 		/* 0 */
 	},
 	{
-		.name  = "{cycles:u,instructions:kp}:p",
+		.name  = "{cpu-cycles:u,instructions:kp}:p",
 		.check = test__group4,
 		/* 1 */
 	},
 	{
-		.name  = "{cycles,instructions}:G,{cycles:G,instructions:G},cycles",
+		.name  = "{cpu-cycles,instructions}:G,{cpu-cycles:G,instructions:G},cpu-cycles",
 		.check = test__group5,
 		/* 2 */
 	},
@@ -1885,27 +1888,27 @@ static const struct evlist_test test__events[] = {
 		/* 3 */
 	},
 	{
-		.name  = "{cycles,cache-misses:G}:H",
+		.name  = "{cpu-cycles,cache-misses:G}:H",
 		.check = test__group_gh1,
 		/* 4 */
 	},
 	{
-		.name  = "{cycles,cache-misses:H}:G",
+		.name  = "{cpu-cycles,cache-misses:H}:G",
 		.check = test__group_gh2,
 		/* 5 */
 	},
 	{
-		.name  = "{cycles:G,cache-misses:H}:u",
+		.name  = "{cpu-cycles:G,cache-misses:H}:u",
 		.check = test__group_gh3,
 		/* 6 */
 	},
 	{
-		.name  = "{cycles:G,cache-misses:H}:uG",
+		.name  = "{cpu-cycles:G,cache-misses:H}:uG",
 		.check = test__group_gh4,
 		/* 7 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:S",
+		.name  = "{cpu-cycles,cache-misses,branch-misses}:S",
 		.check = test__leader_sample1,
 		/* 8 */
 	},
@@ -1920,7 +1923,7 @@ static const struct evlist_test test__events[] = {
 		/* 0 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:D",
+		.name  = "{cpu-cycles,cache-misses,branch-misses}:D",
 		.check = test__pinned_group,
 		/* 1 */
 	},
@@ -1958,7 +1961,7 @@ static const struct evlist_test test__events[] = {
 		/* 6 */
 	},
 	{
-		.name  = "task-clock:P,cycles",
+		.name  = "task-clock:P,cpu-cycles",
 		.check = test__checkevent_precise_max_modifier,
 		/* 7 */
 	},
@@ -1989,17 +1992,17 @@ static const struct evlist_test test__events[] = {
 		/* 2 */
 	},
 	{
-		.name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
+		.name  = "cpu-cycles/name='COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks'/Duk",
 		.check = test__checkevent_complex_name,
 		/* 3 */
 	},
 	{
-		.name  = "cycles//u",
+		.name  = "cpu-cycles//u",
 		.check = test__sym_event_slash,
 		/* 4 */
 	},
 	{
-		.name  = "cycles:k",
+		.name  = "cpu-cycles:k",
 		.check = test__sym_event_dc,
 		/* 5 */
 	},
@@ -2009,17 +2012,17 @@ static const struct evlist_test test__events[] = {
 		/* 6 */
 	},
 	{
-		.name  = "{cycles,cache-misses,branch-misses}:e",
+		.name  = "{cpu-cycles,cache-misses,branch-misses}:e",
 		.check = test__exclusive_group,
 		/* 7 */
 	},
 	{
-		.name  = "cycles/name=name/",
+		.name  = "cpu-cycles/name=name/",
 		.check = test__term_equal_term,
 		/* 8 */
 	},
 	{
-		.name  = "cycles/name=l1d/",
+		.name  = "cpu-cycles/name=l1d/",
 		.check = test__term_equal_legacy,
 		/* 9 */
 	},
@@ -2117,7 +2120,7 @@ static const struct evlist_test test__events_pmu[] = {
 		/* 2 */
 	},
 	{
-		.name  = "default_core/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
+		.name  = "default_core/name='COMPLEX_CYCLES_NAME:orig=cpu-cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.valid = test__pmu_default_core_event_valid,
 		.check = test__checkevent_complex_name,
 		/* 3 */
-- 
2.51.0.534.gc79095c0ca-goog


