Return-Path: <bpf+bounces-26744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0508A4836
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E374DB21B1B
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7A2C684;
	Mon, 15 Apr 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbZ5OWR4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717223774
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163001; cv=none; b=soLBTnp62+U4Hk/Pso5pb5boRKXaWnj6MaFhLl8O8CHgL83xAm9CeD1PEc95NyaygwNxOX9QR0lgGcx5qQOXPds5jRMF/Hi7twlL+P6nTmhdPS2T62YChm6avZKou5/7ZSCErOu1Vy/81OJdML/Yw1pBdLlq2n3Z7QB65DoCeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163001; c=relaxed/simple;
	bh=NNBkMnc8dVfv9V9vLNnG/1mM4wevTmH7XxAWAoZoX9s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mgu5OYqKo+nLqDXwfSvlEPSIx5yqgCdUW4Wwno/LqiIMN5yeu1vrF0PsO0D0faRDEXL1NXTULZB80dnpr5mp09BsP90BO6dm7Hbfr4f8ESsVuZ2T7wOFiIbOkJ5sXNzV0ktNOzYHHzz7U4pTOlu27bDBDS3W3Deb32ei+RCaaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbZ5OWR4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a473ba0632so3211434a91.0
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163000; x=1713767800; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vbu7aFj7CDfYjc9NaQu8KLUrRIg296ZgDVYr3Mka6h8=;
        b=TbZ5OWR4dcZPAUr+UopubPh2FcGLDS0ONnCJFxgHxUqtS0bzBL/HV19y7Rm8ZplN0d
         S/zn8yvhXGvIK9Ec/zM/FKR0w9XqD49OWI7KeOOahxpfnLSBE2XuHYRnTCRFj9GXfTje
         Tzi9knPort4OGWaq7DvMZ6ESh791hWEyY2jFl774qQvQz54gl/GhkMRK53oshATSgUAI
         cU3UD/7pW1Vtxp6pQbxt+PfOBB3v9FG8Ylt5ox6GmrNhDChbQLYB9fudvEQLKAug4kp5
         EEB/I2LQa9k7xugeUKQNiKvGqgOkr/JS9Z5SdzSji7X/wYkcQiCbYwakOit7TBmtbo7G
         UzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163000; x=1713767800;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbu7aFj7CDfYjc9NaQu8KLUrRIg296ZgDVYr3Mka6h8=;
        b=Ls8KzafdCvmIDPFfCsqoK/rb5P78SFaKz61bsfGmmtehhdU25KOGcyEBux+VSDJvjJ
         A4f8iTEerl/wp7xXWNc5+hr0oQJwK49M4a2C+PVthEqfk7kzKzk7g5In68kx1HMWqRjm
         hCF1z4W+oHx3vvnNaSyug4kllGZAndDi+DCETFooWssVCWHxB1KEStIAS8coBDXQYTMS
         iVOZMynbtKyT5XyMJq3uJeY+NzL88wAdLmv+tfMXDVZwF+uUlGpZOkmG2BLe2Snpeymm
         H+zsima7cNNReFaPqc3xeXgtJIF8eC6HGEnIzIWndLnrTKrrgivGiGRnMnpgRuzAQnhk
         LG6w==
X-Forwarded-Encrypted: i=1; AJvYcCV4GAPjVQ/e/BZUa7fNK8PmgvnhSGH06ds0v3SqDc/aF6sYW2/r+7vcrA6NgWF2mjg0pRtO8Y0JiP/Sttcy+RxN5vX0
X-Gm-Message-State: AOJu0YzvVfYFhQeDk1V0GTx61axu8yLIybCQqxhI0ifyIfmhTmf6BDVu
	j+NAaO3bStf9JdZDSUENs2bQvKQrscrhvPd5h32p6DiQrBBc91PK8s04wGNtgA05BIE4DkEl3LF
	GAsSjXQ==
X-Google-Smtp-Source: AGHT+IF81B9h9k2M6zDz/afTJ7Wc9UGW5/Q0UBXG/tDqklKUIScYFFrhSUp9FPvMgq45GrANH22AdKOozLUh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a17:90a:f287:b0:29b:f937:cc00 with SMTP id
 fs7-20020a17090af28700b0029bf937cc00mr27827pjb.7.1713162999848; Sun, 14 Apr
 2024 23:36:39 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:21 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 4/9] perf pmu: Refactor perf_pmu__match
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Move all implementation to pmu code. Don't allocate a fnmatch wildcard
pattern, matching ignoring the suffix already handles this, and only
use fnmatch if the given PMU name has a '*' in it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 19 ++-----------------
 tools/perf/util/pmu.c          | 27 +++++++++++++++++++--------
 tools/perf/util/pmu.h          |  2 +-
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7e23168deeb9..f4de374dab59 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1610,7 +1610,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 					struct list_head **listp,
 					void *loc_)
 {
-	char *pattern = NULL;
 	YYLTYPE *loc = loc_;
 	struct perf_pmu *pmu;
 	int ok = 0;
@@ -1630,22 +1629,9 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
-	if (asprintf(&pattern, "%s*", event_or_pmu) < 0) {
-		zfree(listp);
-		return -ENOMEM;
-	}
-
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		const char *name = pmu->name;
-
-		if (parse_events__filter_pmu(parse_state, pmu))
-			continue;
-
-		if (!strncmp(name, "uncore_", 7) &&
-		    strncmp(event_or_pmu, "uncore_", 7))
-			name += 7;
-		if (!perf_pmu__match(pattern, name, event_or_pmu) ||
-		    !perf_pmu__match(pattern, pmu->alias_name, event_or_pmu)) {
+		if (!parse_events__filter_pmu(parse_state, pmu) &&
+		    perf_pmu__match(pmu, event_or_pmu)) {
 			bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
 			if (!parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
@@ -1655,7 +1641,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 			}
 		}
 	}
-	zfree(&pattern);
 	if (ok)
 		return 0;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ce72c99e4f61..d7521d84fe4a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2073,18 +2073,29 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 		   name ?: "N/A", buf, config_name, config);
 }
 
-int perf_pmu__match(const char *pattern, const char *name, const char *tok)
+bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok)
 {
-	if (!name)
-		return -1;
+	const char *name = pmu->name;
+	bool need_fnmatch = strchr(tok, '*') != NULL;
 
-	if (fnmatch(pattern, name, 0))
-		return -1;
+	if (!strncmp(tok, "uncore_", 7))
+		tok += 7;
+	if (!strncmp(name, "uncore_", 7))
+		name += 7;
 
-	if (tok && !perf_pmu__match_ignoring_suffix(name, tok))
-		return -1;
+	if (perf_pmu__match_ignoring_suffix(name, tok) ||
+	    (need_fnmatch && !fnmatch(tok, name, 0)))
+		return true;
 
-	return 0;
+	name = pmu->alias_name;
+	if (!name)
+		return false;
+
+	if (!strncmp(name, "uncore_", 7))
+		name += 7;
+
+	return perf_pmu__match_ignoring_suffix(name, tok) ||
+		(need_fnmatch && !fnmatch(tok, name, 0));
 }
 
 double __weak perf_pmu__cpu_slots_per_cycle(void)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 152700f78455..93d03bd3ecbe 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -263,7 +263,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   const char *config_name);
 void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
 
-int perf_pmu__match(const char *pattern, const char *name, const char *tok);
+bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok);
 
 double perf_pmu__cpu_slots_per_cycle(void);
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
-- 
2.44.0.683.g7961c838ac-goog


