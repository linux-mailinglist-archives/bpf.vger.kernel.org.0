Return-Path: <bpf+bounces-26894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299A8A6387
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55491C20D93
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECCA6BFD4;
	Tue, 16 Apr 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bi8kZoQZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE23C48E
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248155; cv=none; b=BcFNCcM62Q8FfBNt0hdToLdIyJkFFZ/ee2Qc1l4YEVbSQql5Tl/xk1xhQE7VLrduqAlU07nujWpu8dxwWJetBa9cjywkRGUdeC0T30e+N/IjLG3RouBYWk/HyV7aIPwqzIaQN4O04HZ/KDihupX+yzCg5Y4TxpQYVRjnIJhbgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248155; c=relaxed/simple;
	bh=lLSR9Zme6R3eaZpgcappeWu5jfr6jnHFV6BaEVpUHMk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OUonCbdCDMc1UbyEdkopqF4Fec/nDNkPozMpQ9gFDT65FB5ZKXhkzRmdTFjNxHOJfR2SoOs3dIMzQ4O4Vq7QW5j2VxFMFyruVhfgeLr8CD2RkcNM8zH0U9x5fh2jAgF/JI+47kzpIfLibpy1LMK5q3Yl+8v+7WDT5Woa8VfWhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bi8kZoQZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615138794f5so68039807b3.2
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248153; x=1713852953; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoQwW/NovL7e2tX2zfVq3KY3APeKDAqGoyhJSMq8amM=;
        b=Bi8kZoQZjCB2V/V0PplZ6NWHRF0PNQ8XrwjwDQMY4xt+cbR+96VttCc2QwHQ6sW92g
         Z4E0vPbWXIBVeoysmXe6mOEHVgg37vcLDwtbrmcroiu1BE19nHxoa4htzMBO7rz9ggjj
         hIONz7dl0L8LdXXVY9EuEEg4SxWrkrUjqZ+Qc+LAvPTzPNbRb1RZRzWTSctfWVIFaQfO
         6LyJowHdGDj1MbznqiklJmLMZOUFXUNT3NAv8ZSmnwl8J6/tOB6BEE3m6PdNvj87oF+N
         h1J81C6K1XWdTsigKh374hrRlqEOIeW2Y3Xv1LIv8bhlhJLwbZziU/lJuLwVd298GTl8
         O7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248153; x=1713852953;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoQwW/NovL7e2tX2zfVq3KY3APeKDAqGoyhJSMq8amM=;
        b=vin6dhcGlO2JkVvztaR8VoFG6Zo7SPjHEU5RQhMlwxdRB1RWr8J5RYmD38G0MWJpav
         aJXCxSLp2arJjwTUEZmpjORP2Z+aoE0dyIqn2zY5Oor8T9qmj9m1dSBoILW8jRcgGNH9
         NQfQnDDfz11tQi+zUi7XPCBnYn35Ov2FU7Wup0h6z2uKCu6Pn4pgYTm6Uwvmb8+wt64p
         FQIy/DwnONDbrmLLuF6QIxsuV8a4ADdDKCzlWl1Fmn+itpuW+WAUdgJQsujZD1Q9vj9Q
         bXHileYwiObNOFgkR3KAV4dywieoIa6RcJ+IWMZKMlx1jwMkiiB0r/6UQJFqsn/fUJyI
         tkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXmRED6WBqw0YbjCrGQJqX+6/QYiYgYNj3E5Y3nZYKknjMfqVwvp02fZYyByufMxLcMHCzj3Y3uHg+QDkoDAy39nY3
X-Gm-Message-State: AOJu0YwGORPnlh1kyAJh3oCHCopdSINGgNWTTAOQnvBtUWZBf3h5N/9Y
	eznRAsUmkp8NPtgDty3XtCs84gTnKE8DkS/xwwgbZ+197hviCbk1PUgMRWy/7rCrKhUvyJZYzh8
	6UfOojQ==
X-Google-Smtp-Source: AGHT+IHOfFNw3FUspTDzag8H1Vs2s4R7H3wtDbw+0o1oktnOEpdBiBC3Jt+NP9eC79ubMPCeMtZbdbJRfZUt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1027:b0:dc6:dfd9:d423 with SMTP
 id x7-20020a056902102700b00dc6dfd9d423mr968428ybt.3.1713248153495; Mon, 15
 Apr 2024 23:15:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:20 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 04/16] perf pmu: Refactor perf_pmu__match
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
index 3b1f767039fa..39548ec645ec 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1611,7 +1611,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 					struct list_head **listp,
 					void *loc_)
 {
-	char *pattern = NULL;
 	YYLTYPE *loc = loc_;
 	struct perf_pmu *pmu;
 	int ok = 0;
@@ -1631,22 +1630,9 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
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
 
 			if (!parse_events_add_pmu(parse_state, *listp, pmu,
@@ -1657,7 +1643,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
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


