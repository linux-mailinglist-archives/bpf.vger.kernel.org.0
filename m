Return-Path: <bpf+bounces-69323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C89B942E1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2692C443E8E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B80F2773C0;
	Tue, 23 Sep 2025 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMQxi83d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0C274FF1
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601134; cv=none; b=aukJuk8gc359af7sF8a8nhKRTumMwF9O+/sSC4dSYmvwouK1os4X/U3cyqMJRtQzjrjVzYYI080+ZJDeMfCqgiFG8B8hQSKmk/6o+xlV1Z6FkyX87PMCltbrhDmrEQ8dQrrxutTnWLhQMskvXxLIey7bje1MJJkQEdiU/O1ri5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601134; c=relaxed/simple;
	bh=L+pT+AcEatKTFNx03XP2+UW4uPwki5/m42f47BIrFO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dv08/HEpgmr6Nkrek8bVdL0XEUySU426DzIy2Q8RMLXsXJH+TWGzPi5b37ADqI6TzKn90Vh+egaudQT6eyTK+uUtF6XmErCCT68WhRDcMC4EB1DJWZTfWsEQBix+l9pvXgq0ApvHfeuijVT/EZMEUdDOIqEELhrYIq0xNcWALqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AMQxi83d; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77df7f0d7a3so4152851b3a.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601132; x=1759205932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yU89r1Lif32XcTKVN3dVRhkhOuKCxo5EjEhuE/dx2oE=;
        b=AMQxi83dVVxnXkZDlgiQ667MZQIj5IIGfjgKmt2Ulf9Nui2FfkBPtqub8l0RvFhgYA
         RVJxYx5yz+Lxn6k/ad8PdpE8dBpqWgkvRj0VqSef9Qz/GnjqUtWzyU5j9yoXXsH6KhVe
         1YQkR9tXIs+zTJzBLsQM6EMgb30AwwujvLImIeXv+3e7Nln8Pu58aI0LNCq4JzH0kSuM
         AothPD1OJedlvxJPVwIMeuv/nJ2N/R8MzcApEXj+n+L+elbDLoHwl8tNyKNXd0U3QUsA
         4NLml+TDcajneGozSPqcFGtJCgg5vkC+mLbV0ll+AKHD3PwkVUH6IdYV+Dz4TDnzcGkw
         auBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601132; x=1759205932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yU89r1Lif32XcTKVN3dVRhkhOuKCxo5EjEhuE/dx2oE=;
        b=j2sVvxXvenYKw9qgCDiBbd3Rk/RoUzeNejEPbbCo7tSMrouUyz9BmYGuLofnOeIT1v
         Oms8SNoY4/91w5hyDV584ghJKt8OujZ2Z0dXZbARwzqyn8FQqyLtx1P29/MIUF2dGych
         wJlV1vcIBLRUlO1Kuf1lAy/goAVLEoHEf9IlJOkF/l6/yU6QyxuMg/PgJq2Yu+ED74HV
         WnFl/HSTXzB0VXhlp6BqtsS7MEG7Z+TWqBExqvikCyD0bUB/NAs+wKGB/HTCP8FjTiET
         GMJMxR4hlq2iTTsNqap00Up/8J10Knf/L+4ZRt1VmiH6yGAIdUO8PlKamCXgGfHT2+l4
         h+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVONNnFpyITSFbXXBvtujEE7Hbdh4qVhpCLWiQVIUq9WS8Y82brOL29hRgnR7fzxJGdhqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjL1qOhxhfQjrIoqCaFw/GtRXxmROX47swzrc94W/xMZRs7O2/
	tp7XZ1jBS4wkjrujZNo5ux+rcHV5VGEh6CqTFpuJMok1WtNT2hK2qadirECRiXInmGa5ewffzlA
	bQmwUFVSYFw==
X-Google-Smtp-Source: AGHT+IHt1YpfmJ/hoDdTTUoTBZxbLuXJsdaqngBJF9rDVpAKojmfWFxniP+wqcGd8RPfzriVghi47oF1PXFE
X-Received: from pgao189.prod.google.com ([2002:a63:41c6:0:b0:b55:c92:92c1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca6:b0:248:4d59:93d4
 with SMTP id adf61e73a8af0-2cffc6461a9mr1771977637.45.1758601132116; Mon, 22
 Sep 2025 21:18:52 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:21 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-3-irogers@google.com>
Subject: [PATCH v5 02/25] perf parse-events: Fix legacy cache events if event
 is duplicated in a PMU
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
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The term list when adding an event to a PMU is expected to have the
event name for the alias lookup. Also, set found_supported so that
-EINVAL isn't returned.

Fixes: 62593394f66a ("perf parse-events: Legacy cache names on all
PMUs and lower priority")

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 28 +++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 452f12191f6e..d5675471afc5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -475,8 +475,10 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms)
+			   struct parse_events_terms *parsed_terms,
+			   void *loc_)
 {
+	YYLTYPE *loc = loc_;
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
@@ -497,12 +499,36 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 * The PMU has the event so add as not a legacy cache
 			 * event.
 			 */
+			struct parse_events_terms temp_terms;
+			struct parse_events_term *term;
+			char *config = strdup(name);
+
+			if (!config)
+				goto out_err;
+
+			parse_events_terms__init(&temp_terms);
+			if (!parsed_terms)
+				parsed_terms = &temp_terms;
+
+			if (parse_events_term__num(&term,
+						    PARSE_EVENTS__TERM_TYPE_USER,
+						    config, /*num=*/1, /*novalue=*/true,
+						    loc, /*loc_val=*/NULL) < 0) {
+				zfree(&config);
+				goto out_err;
+			}
+			list_add(&term->list, &parsed_terms->terms);
+
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
 						   first_wildcard_match,
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+			list_del_init(&term->list);
+			parse_events_term__delete(term);
+			parse_events_terms__exit(&temp_terms);
 			if (ret)
 				goto out_err;
+			found_supported = true;
 			if (first_wildcard_match == NULL)
 				first_wildcard_match =
 					container_of(list->prev, struct evsel, core.node);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a5c5fc39fd6f..be8d2ac1e4e4 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -236,7 +236,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     bool wildcard);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms);
+			   struct parse_events_terms *parsed_terms,
+			   void *loc);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index a2361c0040d7..ced26c549c33 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -353,7 +353,7 @@ PE_LEGACY_CACHE opt_event_config
 	if (!list)
 		YYNOMEM;
 
-	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2, &@1);
 
 	parse_events_terms__delete($2);
 	free($1);
-- 
2.51.0.534.gc79095c0ca-goog


