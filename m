Return-Path: <bpf+bounces-26896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67FC8A638D
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A62813DD
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7616EB56;
	Tue, 16 Apr 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBNYMtQx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFC6DD0D
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248160; cv=none; b=CgFWVLT38Rii+UeEKr41Qu32i4k6SNYHLOqZY3aPX3iKOcBRRm14qfZn928L1BiaJkV+8mZj9sJkVNKOPBJTJ7Nzz8I5HRGpY1wyLn1plUViZivA+qYl3Ng8rdQurRuKq3qo0PqY2egETXj6FPt4nWT0Jf2ymKbueg2kfrkvyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248160; c=relaxed/simple;
	bh=uAsvZz6qZ6F1ygzrsRJ+PGu0crnaXT8b4/31RPpmBkY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ofwG4I3t85F5bd0KiMFztGAlcuYqeDPqFOGOUX4H0Dc66jepXwcr4kTruYgpPEeKZXEEUindXs0R3q5en21Gt5oFnT+1dhH1HlcftVX9ghb6JqccYdfWkVMpzeIeUYKXBzYQpTA5ob+JSiTmB0XSI573EpguTaM6doWyrxQV/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBNYMtQx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so46127877b3.2
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248158; x=1713852958; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k83zolc/tumM7XBpJQ8EaNI+D4ORxoBWKEwoUmDFaek=;
        b=yBNYMtQxir6VYwDh5XjEXed/iwXo97ERNTTpncTAZOspIy2szGImrLF88elDbKUviM
         ljCMXX3zgvYXijCpyqUL32YIMSlIFMHf9hFKjW9R3SS0jzjTLcPkEXNDYIjVwQByANUi
         oC6EWekCLNvoy7DKFbJRdInn+3qIm43Kj2xAky9PE7jGH2BsiXdQUzPxMHqJ0BQOQjDc
         BvogPfFuLHH6HlmUYXGt9n0YBxgIMZsvgJ0SNjb270ohsmqRuuORHlUQI9FcxC/8YcJu
         XwwZM5b+NdP8JU9mC2gBMxpNIYymWBeDcub0nKZjiMnQ6t1rZrXhoXNvEpvz07xjh3RQ
         FoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248158; x=1713852958;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k83zolc/tumM7XBpJQ8EaNI+D4ORxoBWKEwoUmDFaek=;
        b=aaktRKIQZx5i1bGZ4giybspltuQZieRvGo5WQ6EjTPUEuvEbguSEh/z9QXzaATCPQK
         2AURM7bBaw9ISTqxfJpyQbrIvzqdXgocgzXPFuzO0tx+CdKNUHGhX+D/LFa6GMlkri59
         c2vDgkasFYw8LCr6bFKHS/TnmWqFJe7+ggYTaVU3/HT50OLtCvLWjo/juDTVvgLn+xmu
         EqqmnQOtiGhhX78HN+vAD/yM07PkxMpbYM/5hHrKbL2CpGDsV/hk+3GUUY94S2ba9pP8
         NFsgpugOC8k7/UPl6dl9xJwKzDB7fvdtNoN2XfR9umGnZD6aeuqCypl5nxeCCQ3BGBrL
         J9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWjBNa8PWxjDShOkKnrzRUKJYqKF3i3SerFjy48gSLrtkd1hNqovZsskI1vEP2iZkNpglqrii59YDPdbXg2ey0zv0tJ
X-Gm-Message-State: AOJu0YyynCknFWfcyQ5xTPvtN+Mp2apbvtIegyogAb4J8V+q8yuVrcos
	GWwAzjcgmyYFUDFjJLHdubCH0wFfHQ6VG4MVuyCs39T9kGEQLeccUKBZMzgp9QjzXgI7vnao88d
	q+126lg==
X-Google-Smtp-Source: AGHT+IEpN/W9bPJeui69q0ZUQ4qSKte3BSaEqlY+RZGoPcSYQ+AbbeHfa7sJctYDOzeLW8y3VSjctuWlZy+r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a0d:ca07:0:b0:615:27b6:7624 with SMTP id
 m7-20020a0dca07000000b0061527b67624mr3084038ywd.6.1713248158096; Mon, 15 Apr
 2024 23:15:58 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:22 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 06/16] perf parse-events: Legacy cache names on all PMUs
 and lower priority
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

Prior behavior is to not look for legacy cache names in sysfs/json and
to create events on all core PMUs. New behavior is to look for
sysfs/json events first on all PMUs, for core PMUs add a legacy event
if the sysfs/json event isn't present.

This is done so that there is consistency with how event names in
terms are handled and their prioritization of sysfs/json over
legacy. It may make sense to use a legacy cache event name as an event
name on a non-core PMU so we should allow it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 39 +++++++++++++++++++++++++++-------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 39548ec645ec..1440a3b4b674 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -442,17 +442,21 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 	return strcmp(parse_state->pmu_filter, pmu->name) != 0;
 }
 
+static int parse_events_add_pmu(struct parse_events_state *parse_state,
+				struct list_head *list, struct perf_pmu *pmu,
+				const struct parse_events_terms *const_parsed_terms,
+				bool auto_merge_stats);
+
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *head_config)
+			   struct parse_events_terms *parsed_terms)
 {
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
-	const char *config_name = get_config_name(head_config);
-	const char *metric_id = get_config_metric_id(head_config);
+	const char *config_name = get_config_name(parsed_terms);
+	const char *metric_id = get_config_metric_id(parsed_terms);
 
-	/* Legacy cache events are only supported by core PMUs. */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 		LIST_HEAD(config_terms);
 		struct perf_event_attr attr;
 		int ret;
@@ -460,6 +464,24 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
+		if (perf_pmu__have_event(pmu, name)) {
+			/*
+			 * The PMU has the event so add as not a legacy cache
+			 * event.
+			 */
+			ret = parse_events_add_pmu(parse_state, list, pmu,
+						   parsed_terms,
+						   perf_pmu__auto_merge_stats(pmu));
+			if (ret)
+				return ret;
+			continue;
+		}
+
+		if (!pmu->is_core) {
+			/* Legacy cache events are only supported by core PMUs. */
+			continue;
+		}
+
 		memset(&attr, 0, sizeof(attr));
 		attr.type = PERF_TYPE_HW_CACHE;
 
@@ -469,11 +491,12 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 		found_supported = true;
 
-		if (head_config) {
-			if (config_attr(&attr, head_config, parse_state->error, config_term_common))
+		if (parsed_terms) {
+			if (config_attr(&attr, parsed_terms, parse_state->error,
+					config_term_common))
 				return -EINVAL;
 
-			if (get_config_terms(head_config, &config_terms))
+			if (get_config_terms(parsed_terms, &config_terms))
 				return -ENOMEM;
 		}
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a331b9f0da2b..db47913e54bc 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -203,7 +203,7 @@ int parse_events_add_tool(struct parse_events_state *parse_state,
 			  int tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *head_config);
+			   struct parse_events_terms *parsed_terms);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
-- 
2.44.0.683.g7961c838ac-goog


