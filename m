Return-Path: <bpf+bounces-48150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD6A048F3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5153A565D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB81F5406;
	Tue,  7 Jan 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkklKNO2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FB1F2C3F
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273365; cv=none; b=r+wb8S86d664VmQhVC/14vM7EtqFtjd14t2vpC0hrxIOQMsaJFCYwON+XR19hgJtQGqqVuWht+uEfY56gZpuOMw6fOfR/23kb2O0eLC/k9HVc+wKs1R8H+BJBCiYSOvJOGDhNbd772jQNO+dhZVYMSC/npL3e/l4j8qX5ocCpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273365; c=relaxed/simple;
	bh=3/t2IbEPz4rN8sB6XlwyAEYEFBdFqxnzZyoasEkvKao=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=IOdEDG8wdQLOu0++JT6+53jPD1xyRgGwVuWweUFC1qidpHKjOU9OzCdWZfVifU5odbNqhuOHtzPvOjPQukVmtN87vorCOr7bWvqtRNK6bavI41KnfbnU/c59yIzlzcKUhAA+a4o5PdffnCO6kAyiMEjbJAoghRHj4IlMiPK1Yl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkklKNO2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e39fd56398cso35892516276.1
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 10:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736273359; x=1736878159; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gsJqu5S2FVCHZY/sqyRxwjspJ6Srprq184fTFcf/+o=;
        b=BkklKNO2+7imfXW7x75Na3+4o5Q+fkR+8vbyaKHtMy3v4glKowR3IX9zNchNngf9s3
         0Fsz9Tvs9MzsOx6EENwJN8zxbmdg1axZ9ATjaWK/LMOkK/1iwu6e00HZXfFSRAxkuSLp
         HhYr+HVRaDJT8RYrOxZzAfLBdnoHriHe6OIXStwaN0/pwGsxj5+PO8Z8S93n7SmGHOuJ
         h4L8SJbaHn42aHMTNALiDC3zPvBnZl+/A2hiSu7Ml609A/1ghQtoKL1CDVZNxHMbDhDZ
         Bef7ncLJ8A+8wN3gXY9KJChfJ8OZIPcvvudFxQqqLHb66ZHIao2Ox9BaLi13WIcO3yco
         CNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273359; x=1736878159;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gsJqu5S2FVCHZY/sqyRxwjspJ6Srprq184fTFcf/+o=;
        b=pspvLX17Vewf7yXLIO+tI63dBhNUAh90+HrPDNJj9/ZXDlCiN+6FSvhIsNzRDe8Zsu
         E5l8tj9LeHOjB8QgpnjwPoDTzJac5PwTqPsTITL0W2++WlfxjWxNhPlm1LiWnvjVuR4q
         93NzZy8Mu0uT75md/EZesb7/PHJXWdpBp3VP/pZvxUOHpRPxnATmugHLqRlC4e8dVJdN
         oN1gkNYkOsqFFySxJYbj/tAMMBmaWLjdqDPhdRlT/yAB51lU/BN7HehV4u60Cjl2nEuT
         Ke3G79w+0CG2SIt1gyYU/fahJz3/iUf3ja7taZLg7pvIC3ULTBPTiQL5ZmvVdefQTN4A
         Fx3w==
X-Forwarded-Encrypted: i=1; AJvYcCViBPsLTwrAUWFzEzhBFhBSL7LAbbsPuKeC3EStPDKLBAy0ExTcTswZ4Uhx2I6AQXcPNCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyRSoeMuh5ZeFthawdB8kPiU9yMkXaTplqd5DGeBHYSBRYrnq
	Lq+xswQyFkbogdl5/sbnr8P5kPS6j+hDjDKPEWNxeukXalc5H67VWZoySu8j9/A1i1ElIEnVgv+
	N0acW5A==
X-Google-Smtp-Source: AGHT+IEXuCh6QcRMzYXeb67JLDoqi6EvpTvf4F+FY3EUZs8ddIo2R7QzCJ0n0HLdN2toAHdcS4AmbdyhLcXw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ede7:40c7:c970:8d77])
 (user=irogers job=sendgmr) by 2002:a05:690c:6605:b0:6ef:3402:f56b with SMTP
 id 00721157ae682-6f3f80df0c6mr2573127b3.1.1736273359442; Tue, 07 Jan 2025
 10:09:19 -0800 (PST)
Date: Tue,  7 Jan 2025 10:08:52 -0800
In-Reply-To: <20250107180854.770470-1-irogers@google.com>
Message-Id: <20250107180854.770470-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107180854.770470-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 2/4] perf stat: Fix find_stat for mixed legacy/non-legacy events
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
index fa8b2a1048ff..d83bda5824d2 100644
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


