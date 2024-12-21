Return-Path: <bpf+bounces-47525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595529FA235
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 20:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89EC165352
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521B198A29;
	Sat, 21 Dec 2024 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XsK/ur9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAA18FDA9
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809225; cv=none; b=RprJJeuUP3JH91wAzWypIHv5sUm04cLDjOF5Lc132VDETCbc3YYuHRi6U3852pnZmkH3WssLINWSVi0/oIRFAQ6YwYVFFn+SYre1naFrQdfdVGX80jNbAZ3cLAp2a7Wx/lqz7F7GPqir+Vojj1pcj/qoD41DB9bgsgsOPEV6y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809225; c=relaxed/simple;
	bh=mbSjQSmFx03BBbUNYmEFNvOSfaebIobQfcRuwGZsa6E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=O9MR1ADMqB3Yjx3x4DihkjAHEU8SS+obH6u8uxW/K6vOP5ArSkZS3nIMx58uHagN3RdPbOkSgrx9wXew3kK46VZrA3pZ4ikNc/lRCbksYVRHWC0Z/ct4iP2Qj6y+oHNfb2vD6Z1lr/CLyZAg9fOa8LYGZNo7oGytczBAlSUfm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2XsK/ur9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a1bc0c876so4018351276.1
        for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 11:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734809223; x=1735414023; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx8LXjjEYC9Y4HOJdp2FCstQyDUI0FCzF2hebA9zeIg=;
        b=2XsK/ur9aNDHZtoTxoJJ2oIf3sMrFoXRUJG/wGbqvODPblCuSTzhjQzdfkdCRLFcMq
         7YP5bkmtL0V93g4Et8SF5O9AYhnWPzXdlC2wh9AqI2xaV2BsXzGS2RJH3pfhfmtj/WyG
         IVsEiQKOQbF5ZN4Qtrzxz6cVbzsfOjxVcV11G7eB+WTCaGbTCB1lw2il3zCSQUZ3leKQ
         fL6c+1V+Y7oDlPfi9tvLdvxV6ffxcxlXhTCO7ie1nLoct8V7CJeJYPW24GBi5F+livR3
         KdUDIOK8WpfPjr7rRfCGdZSxI5SPqZ2WWXDsXj5gwpmnOVhf6lElRPESr5aJjSWwJGsJ
         oYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734809223; x=1735414023;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx8LXjjEYC9Y4HOJdp2FCstQyDUI0FCzF2hebA9zeIg=;
        b=u5Ey/rsLJCGbw1ckouyeXB4QQ9YvkfKuPcOd33LllGfdECEChuHuhTPJ37LCIFKdeb
         nix2DyxMZ7GvIXq8CvrsQvZ1FgOZ+WPRhIU0gzGY0iQVSdcke0yIlwRtNy9bY4jXlfXg
         y4Zjgp80/clibsRieczmWzTACbxhhEU6gy40Bye7L/NzsBsUPE5k6ED9sfpBvfS7pNWz
         FGO7hebl97IDB0rvMse53fBBs2kXLdF+p8yEGjrhbmBGMDw7d0rRcfHXRPUxR/JI1iUk
         ImM8kC+4PC4kNyAW3MorWdtvWPcYLcA+cMnuquyjhkkkXpivX2sidEncebVxBWYvX/MS
         xnEw==
X-Forwarded-Encrypted: i=1; AJvYcCUhlPRQpPdLxk5Bcu140obAmc7LUekVOPVHV7xfjo8tNxMeYS+vXBjUJjWX+tzxRdzImuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBXqwjZnGIxGdAcE0Vtgj8euhSBanZ1Oae9PGuRqUaQKpZc0z
	zdrFva2n1ig+QtoFBt80FvOojPT4rrXebEq8wa3UlAaHA9i864jzW7Z/+RVP1NqpS587urkxepU
	7vmWiNg==
X-Google-Smtp-Source: AGHT+IFXmoVmR4aIc2dv+ZDgEpdlVfba/zEH9nUjbZlAMKv2bwtgTIAVXJj4c4ROsh93/QVcrAxMBYEXb7iA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a2bc:ec03:1143:41ab])
 (user=irogers job=sendgmr) by 2002:a25:acd7:0:b0:e39:6fdc:556d with SMTP id
 3f1490d57ef6-e538c019dfcmr14276276.0.1734809222886; Sat, 21 Dec 2024 11:27:02
 -0800 (PST)
Date: Sat, 21 Dec 2024 11:26:52 -0800
In-Reply-To: <20241221192654.94344-1-irogers@google.com>
Message-Id: <20241221192654.94344-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241221192654.94344-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 2/4] perf stat: Fix find_stat for mixed legacy/non-legacy events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Cc: Leo Yan <leo.yan@arm.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Legacy events typically don't have a PMU when added leading to
mismatched legacy/non-legacy cases in find_stat. Use evsel__find_pmu
to make sure the evsel PMU is looked up. Update the evsel__find_pmu
code to look for the PMU using the extended config type or, for legacy
hardware/hw_cache events on non-hybrid systems, just use the core PMU.

Before:
```
$ perf stat -e cycles,cpu/instructions/ -a sleep 1
 Performance counter stats for 'system wide':

       215,309,764      cycles
        44,326,491      cpu/instructions/

       1.002555314 seconds time elapsed
```
After:
```
$ perf stat -e cycles,cpu/instructions/ -a sleep 1

 Performance counter stats for 'system wide':

       990,676,332      cycles
     1,235,762,487      cpu/instructions/                #    1.25  insn per cycle

       1.002667198 seconds time elapsed
```

Fixes: 3612ca8e2935 ("perf stat: Fix the hard-coded metrics
calculation on the hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/util/pmus.c        | 20 +++++++++++++++++---
 tools/perf/util/stat-shadow.c |  3 ++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b493da0d22ef..60d81d69503e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -710,11 +710,25 @@ char *perf_pmus__default_pmu_name(void)
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
+	bool legacy_core_type;
 
-	if (!pmu) {
-		pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		((struct evsel *)evsel)->pmu = pmu;
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
+	legacy_core_type =
+		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
+		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
+	if (!pmu && legacy_core_type) {
+		if (perf_pmus__supports_extended_type()) {
+			u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+
+			pmu = perf_pmus__find_by_type(type);
+		} else {
+			pmu = perf_pmus__find_core_pmu();
+		}
 	}
+	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 47718610d5d8..109c4a012ce8 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -151,6 +151,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 {
 	struct evsel *cur;
 	int evsel_ctx = evsel_context(evsel);
+	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
 
 	evlist__for_each_entry(evsel->evlist, cur) {
 		struct perf_stat_aggr *aggr;
@@ -177,7 +178,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 		 * Except the SW CLOCK events,
 		 * ignore if not the PMU we're looking for.
 		 */
-		if ((type != STAT_NSECS) && (evsel->pmu != cur->pmu))
+		if ((type != STAT_NSECS) && (evsel_pmu != evsel__find_pmu(cur)))
 			continue;
 
 		aggr = &cur->stats->aggr[aggr_idx];
-- 
2.47.1.613.gc27f4b7a9f-goog


