Return-Path: <bpf+bounces-68334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F85B56B1A
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B521189BBE4
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C762E5B0C;
	Sun, 14 Sep 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XifuoIAH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98722E5B09
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873519; cv=none; b=TmvSij7FABZzEBveuCU605l8phDG3Fe8WJpQ5DJU73ww/Sr2L0wERgYjqJ7UGoKClOr/cPQr0fHnjT11ESWPDpWbQqJ7riEfI0txwPh+y9xXepr6W0kiy4rTM24ufbjTDwNS3lnleFiCvo2olam/l7+6e9GOiuqlYGDSVtBFl7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873519; c=relaxed/simple;
	bh=dC5n01h2u+b96EziYEui7ig0C6nDxE6FM0az+7eyt3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SL51dGYhGuE60kPPnim652/CImX0WLZevauhAq0DN7Gk2OmrCJp4uk7HUzYcaLROwU6Pv8ZB27kjUrLzt/zAOB+PCgz+YO116qTDh3JWykHRSNenwuakRLA4hWhDTaV62pGL1NrcwlFmaKcof00jdmUVld9fyEmHJJwwL+Cqvso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XifuoIAH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e3c3e748dso248458a91.2
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873515; x=1758478315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHJ5CdlfQ54+oYe5/TJXNXWiWnOzHpzpFdsqGarS1fM=;
        b=XifuoIAH+nnqXqh82fEhHYDS3dPAQyKiMtG7MdarH8A9ODb9JbHOdBgswV987++PVH
         Zg+2OIIV4ApbEbDaRDMUl0SsXRN1IC0GXFNt3R04EHtR5bDJMR5lx4EtFNcad6Kf7ECu
         J6znWhN4dZmKezoa06wBH3mGV1otB4P08YN6hhGAwz73TfFTFs7A5jjN0GqJsjkhN5kG
         z47QcOZdmuwUUrH0hdVijX+kC/P8FU6kRilLaU36Lb9ZsbPZvKwdTIERTUGCy57BM3jV
         IJs2bMDXRILHtoT4BlEeiBEhJfuuDxhFpt+0Ty7bumvoSnfthGlvwK1wLaf666OJbgsR
         COww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873515; x=1758478315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHJ5CdlfQ54+oYe5/TJXNXWiWnOzHpzpFdsqGarS1fM=;
        b=XsgZ+9byHK8CELk76dVg5kHcunYoTJ5aATvWrDqFQxqwHtT6PlKaU3ev+BBav3k5+u
         ckvmv7qxsCG5DAV8AYhql72yhm2veJqouPPBQBy8LQ17r6Hzv+Ojb1AAt6UumEUEzX8O
         I2XrElHKb1PBQf6xpOp2r1bfyUJLuwVi8DTZDu0sSsKOkofFX4HeMzc6rT8MbsW+0K/M
         wZXA8GawX/NN1jD2iq65uw0Xcq3QDoAUMdS+3Nzprxs5aDfD8DVv9a+BqZbkxXY6y0vZ
         b9dj4X50VHsVgJqus6wHMHQj6ibz5wgwKjcmBWPh0bvDAvM72w7EnVuSp6m09gHOV3nb
         Ez1g==
X-Forwarded-Encrypted: i=1; AJvYcCXFB9A4x/Ejwx+RlIlNN8pwK1UmZq1T1KSeh7jQABxRVgEuWuyqkKaUfcvI89dbH8W1o9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jhRGtCYHo2ynh6KFsChM66V8YZPGTfflcmizKS+a+eWP175O
	Q3pYSj3Jx8RJ3UBWZZtWtH+cxrcBYMQ8FJVtjkih1PPknhcqgslUqGVhLFPzMSZigdeB+bAtwXl
	AUdGSyHpimw==
X-Google-Smtp-Source: AGHT+IH3yTARLAtLvP44VndVHvMzqBb+OdS0lgPEnj70mu1O80i/OX1k/VqXYYp91/ACpZuKmZasSMe6D2Xy
X-Received: from pjbnc8.prod.google.com ([2002:a17:90b:37c8:b0:32d:a4d4:bb17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380e:b0:32e:5d87:8abc
 with SMTP id 98e67ed59e1d1-32e5d878c5dmr983594a91.36.1757873515144; Sun, 14
 Sep 2025 11:11:55 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:15 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-16-irogers@google.com>
Subject: [PATCH v4 15/21] perf parse-events: Remove hard coded legacy hardware
 and cache parsing
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

Now that legacy hardware and cache events are in json, having the
lexer match the specific event is no longer necessary and generic PMU
parsing can take place. Because of this remove the specific term
parsing, event adding, and passing of alternate_hw_config which was
now always PERF_COUNT_HW_MAX.

This mirrors a similar change for software events in commit 6e9fa4131abb
("perf parse-events: Remove non-json software events").

With no hard coded legacy hardware or cache events the wild card, case
insensitivity, etc. is consistent for events. This does, however, mean
events like cycles will wild card against all PMUs. A change does the
same was originally posted and merged from:
https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
and reverted by Linus in commit 4f1b067359ac ("Revert "perf
parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
his dislike for the cycles behavior on ARM. Earlier patches in this
series make perf record event opening failures non-fatal and hide the
cycles event's failure to open on ARM in perf record, so it is
expected the behavior will now be transparent in perf record. perf
stat with a cycles event will wildcard open the event on all PMUs.

The change to support legacy events with PMUs was done to clean up
Intel's hybrid PMU implementation.  Having sysfs/json events with
increased priority to legacy was requested by Mark Rutland
<mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
events on that PMU. It was requested that RISC-V be able to add events
to the perf tool json so the PMU driver didn't need to map legacy
events to config encodings:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/

A previous series of patches decreasing legacy hardware event
priorities was posted in:
https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
software events can be implemented similarly:
https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/parse-events.c | 191 ++-------------------------------
 tools/perf/util/parse-events.h |  14 +--
 tools/perf/util/parse-events.l |  52 ---------
 tools/perf/util/parse-events.y | 114 +-------------------
 tools/perf/util/pmu.c          |   9 +-
 5 files changed, 17 insertions(+), 363 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 72cc59cfc46d..ab5a3048fa9e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -419,111 +419,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				struct evsel *first_wildcard_match, u64 alternate_hw_config);
-
-int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
-			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms,
-			   void *loc_)
-{
-	YYLTYPE *loc = loc_;
-	struct perf_pmu *pmu = NULL;
-	bool found_supported = false;
-	const char *config_name = get_config_name(parsed_terms);
-	const char *metric_id = get_config_metric_id(parsed_terms);
-	struct perf_cpu_map *cpus = get_config_cpu(parsed_terms);
-	int ret = 0;
-	struct evsel *first_wildcard_match = NULL;
-
-	while ((pmu = perf_pmus__scan_for_event(pmu, name)) != NULL) {
-		LIST_HEAD(config_terms);
-		struct perf_event_attr attr;
-
-		if (parse_events__filter_pmu(parse_state, pmu))
-			continue;
-
-		if (perf_pmu__have_event(pmu, name)) {
-			/*
-			 * The PMU has the event so add as not a legacy cache
-			 * event.
-			 */
-			struct parse_events_terms temp_terms;
-			struct parse_events_term *term;
-			char *config = strdup(name);
-
-			if (!config)
-				goto out_err;
-
-			parse_events_terms__init(&temp_terms);
-			if (!parsed_terms)
-				parsed_terms = &temp_terms;
-
-			if (parse_events_term__num(&term,
-						    PARSE_EVENTS__TERM_TYPE_USER,
-						    config, /*num=*/1, /*novalue=*/true,
-						    loc, /*loc_val=*/NULL) < 0) {
-				zfree(&config);
-				goto out_err;
-			}
-			list_add(&term->list, &parsed_terms->terms);
-
-			ret = parse_events_add_pmu(parse_state, list, pmu,
-						   parsed_terms,
-						   first_wildcard_match,
-						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
-			list_del_init(&term->list);
-			parse_events_term__delete(term);
-			parse_events_terms__exit(&temp_terms);
-			if (ret)
-				goto out_err;
-			found_supported = true;
-			if (first_wildcard_match == NULL)
-				first_wildcard_match =
-					container_of(list->prev, struct evsel, core.node);
-			continue;
-		}
-
-		if (!pmu->is_core) {
-			/* Legacy cache events are only supported by core PMUs. */
-			continue;
-		}
-
-		memset(&attr, 0, sizeof(attr));
-		attr.type = PERF_TYPE_HW_CACHE;
-
-		ret = parse_events__decode_legacy_cache(name, pmu->type, &attr.config);
-		if (ret)
-			return ret;
-
-		found_supported = true;
-
-		if (parsed_terms) {
-			if (config_attr(&attr, parsed_terms, parse_state->error,
-					config_term_common)) {
-				ret = -EINVAL;
-				goto out_err;
-			}
-			if (get_config_terms(parsed_terms, &config_terms)) {
-				ret = -ENOMEM;
-				goto out_err;
-			}
-		}
-
-		if (__add_event(list, idx, &attr, /*init_attr*/true, config_name ?: name,
-				metric_id, pmu, &config_terms, first_wildcard_match,
-				cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) == NULL)
-			ret = -ENOMEM;
-
-		if (first_wildcard_match == NULL)
-			first_wildcard_match = container_of(list->prev, struct evsel, core.node);
-		free_config_terms(&config_terms);
-		if (ret)
-			goto out_err;
-	}
-out_err:
-	perf_cpu_map__put(cpus);
-	return found_supported ? 0 : -EINVAL;
-}
+				struct evsel *first_wildcard_match);
 
 static void tracepoint_error(struct parse_events_error *e, int err,
 			     const char *sys, const char *name, int column)
@@ -815,8 +711,6 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
 		[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
-		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
-		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG]	= "legacy-hardware-config",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG]	= "legacy-cache-config",
 		[PARSE_EVENTS__TERM_TYPE_CPU]			= "cpu",
@@ -868,8 +762,6 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 	case PARSE_EVENTS__TERM_TYPE_RAW:
-	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
-	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
@@ -1027,8 +919,6 @@ do {									   \
 	}
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
-	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
-	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG:
 	default:
@@ -1115,59 +1005,6 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		attr->type = PERF_TYPE_HW_CACHE;
 		return 0;
 	}
-	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
-		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
-
-		if (!pmu) {
-			char *err_str;
-
-			if (asprintf(&err_str, "Failed to find PMU for type %d", attr->type) >= 0)
-				parse_events_error__handle(err, term->err_term,
-							   err_str, /*help=*/NULL);
-			return -EINVAL;
-		}
-		/*
-		 * Rewrite the PMU event to a legacy cache one unless the PMU
-		 * doesn't support legacy cache events or the event is present
-		 * within the PMU.
-		 */
-		if (perf_pmu__supports_legacy_cache(pmu) &&
-		    !perf_pmu__have_event(pmu, term->config)) {
-			attr->type = PERF_TYPE_HW_CACHE;
-			return parse_events__decode_legacy_cache(term->config, pmu->type,
-								 &attr->config);
-		} else {
-			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
-			term->no_value = true;
-		}
-	}
-	if (term->type_term == PARSE_EVENTS__TERM_TYPE_HARDWARE) {
-		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
-
-		if (!pmu) {
-			char *err_str;
-
-			if (asprintf(&err_str, "Failed to find PMU for type %d", attr->type) >= 0)
-				parse_events_error__handle(err, term->err_term,
-							   err_str, /*help=*/NULL);
-			return -EINVAL;
-		}
-		/*
-		 * If the PMU has a sysfs or json event prefer it over
-		 * legacy. ARM requires this.
-		 */
-		if (perf_pmu__have_event(pmu, term->config)) {
-			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
-			term->no_value = true;
-			term->alternate_hw_config = true;
-		} else {
-			attr->type = PERF_TYPE_HARDWARE;
-			attr->config = term->val.num;
-			if (perf_pmus__supports_extended_type())
-				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
-		}
-		return 0;
-	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
 	    term->type_term == PARSE_EVENTS__TERM_TYPE_DRV_CFG) {
 		/*
@@ -1212,8 +1049,6 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_RAW:
-	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
-	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_CPU:
 	default:
 		if (err) {
@@ -1349,8 +1184,6 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_NAME:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
-		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
-		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
@@ -1406,8 +1239,6 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
-		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
-		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_CPU:
 		default:
 			break;
@@ -1533,8 +1364,9 @@ static bool config_term_percore(struct list_head *config_terms)
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
 				struct list_head *list, struct perf_pmu *pmu,
 				const struct parse_events_terms *const_parsed_terms,
-				struct evsel *first_wildcard_match, u64 alternate_hw_config)
+				struct evsel *first_wildcard_match)
 {
+	u64 alternate_hw_config = PERF_COUNT_HW_MAX;
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
 	struct evsel *evsel;
@@ -1667,7 +1499,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name, u64 hw_config,
+			       const char *event_name,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc_)
 {
@@ -1719,7 +1551,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			continue;
 
 		if (!parse_events_add_pmu(parse_state, list, pmu,
-					  &parsed_terms, first_wildcard_match, hw_config)) {
+					  &parsed_terms, first_wildcard_match)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1734,7 +1566,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, list, perf_pmus__fake_pmu(), &parsed_terms,
-					 first_wildcard_match, hw_config)) {
+					  first_wildcard_match)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1776,15 +1608,13 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
 	pmu = perf_pmus__find(event_or_pmu);
 	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
-					 first_wildcard_match,
-					 /*alternate_hw_config=*/PERF_COUNT_HW_MAX))
+					 first_wildcard_match))
 		return 0;
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, *listp, perf_pmus__fake_pmu(),
 					  const_parsed_terms,
-					  first_wildcard_match,
-					  /*alternate_hw_config=*/PERF_COUNT_HW_MAX))
+					  first_wildcard_match))
 			return 0;
 	}
 
@@ -1797,8 +1627,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 		if (!parse_events_add_pmu(parse_state, *listp, pmu,
 					  const_parsed_terms,
-					  first_wildcard_match,
-					  /*alternate_hw_config=*/PERF_COUNT_HW_MAX)) {
+					  first_wildcard_match)) {
 			ok++;
 			parse_state->wild_card_pmus = true;
 		}
@@ -1812,7 +1641,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	/* Failure to add, assume event_or_pmu is an event name. */
 	zfree(listp);
-	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, PERF_COUNT_HW_MAX,
+	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu,
 					const_parsed_terms, listp, loc))
 		return 0;
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 32bde974c9f5..db92cd67bc0f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -79,8 +79,6 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
 	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
 	PARSE_EVENTS__TERM_TYPE_RAW,
-	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
-	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_CPU,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG,
@@ -132,12 +130,6 @@ struct parse_events_term {
 	 * value is assumed to be 1. An event name also has no value.
 	 */
 	bool no_value;
-	/**
-	 * @alternate_hw_config: config is the event name but num is an
-	 * alternate PERF_TYPE_HARDWARE config value which is often nice for the
-	 * sake of quick matching.
-	 */
-	bool alternate_hw_config;
 };
 
 struct parse_events_error {
@@ -233,10 +225,6 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     u32 type, u64 config,
 			     const struct parse_events_terms *head_config,
 			     bool wildcard);
-int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
-			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms,
-			   void *loc);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
@@ -248,7 +236,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      struct perf_pmu *pmu);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name, u64 hw_config,
+			       const char *event_name,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc);
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index b5058b6b49d3..e390f30499b4 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -75,11 +75,6 @@ static int quoted_str(yyscan_t scanner, int token)
 	return token;
 }
 
-static int lc_str(yyscan_t scanner, const struct parse_events_state *state)
-{
-	return str(scanner, state->match_legacy_cache_terms ? PE_LEGACY_CACHE : PE_NAME);
-}
-
 /*
  * This function is called when the parser gets two kind of input:
  *
@@ -117,14 +112,6 @@ do {								\
 	yyless(0);						\
 } while (0)
 
-static int sym(yyscan_t scanner, int config)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-
-	yylval->num = config;
-	return PE_VALUE_SYM_HW;
-}
-
 static int term(yyscan_t scanner, enum parse_events__term_type type)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
@@ -133,16 +120,6 @@ static int term(yyscan_t scanner, enum parse_events__term_type type)
 	return PE_TERM;
 }
 
-static int hw_term(yyscan_t scanner, int config)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-	char *text = parse_events_get_text(scanner);
-
-	yylval->hardware_term.str = strdup(text);
-	yylval->hardware_term.num = PERF_TYPE_HARDWARE + config;
-	return PE_TERM_HW;
-}
-
 static void modifiers_error(struct parse_events_state *parse_state, yyscan_t scanner,
 			    int pos, char mod_char, const char *mod_name)
 {
@@ -256,8 +233,6 @@ drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
  */
 modifier_event	[ukhpPGHSDIWebR]{1,16}
 modifier_bp	[rwx]{1,3}
-lc_type 	(L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node)
-lc_op_result	(load|loads|read|store|stores|write|prefetch|prefetches|speculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
 digit		[0-9]
 non_digit	[^0-9]
 
@@ -338,23 +313,10 @@ metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CPU); }
 legacy-hardware-config 	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG); }
 legacy-cache-config	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE_CONFIG); }
-cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
-stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
-stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-instructions					{ return hw_term(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
-cache-references				{ return hw_term(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
-cache-misses					{ return hw_term(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
-branch-instructions|branches			{ return hw_term(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
-branch-misses					{ return hw_term(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
-bus-cycles					{ return hw_term(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
-ref-cycles					{ return hw_term(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
 r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 ,			{ return ','; }
 "/"			{ BEGIN(INITIAL); return '/'; }
-{lc_type}			{ return lc_str(yyscanner, _parse_state); }
-{lc_type}-{lc_op_result}	{ return lc_str(yyscanner, _parse_state); }
-{lc_type}-{lc_op_result}-{lc_op_result}	{ return lc_str(yyscanner, _parse_state); }
 {num_dec}		{ return value(_parse_state, yyscanner, 10); }
 {num_hex}		{ return value(_parse_state, yyscanner, 16); }
 {term_name}		{ return str(yyscanner, PE_NAME); }
@@ -393,20 +355,6 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 <<EOF>>			{ BEGIN(INITIAL); }
 }
 
-cpu-cycles|cycles				{ return sym(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
-stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
-stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-instructions					{ return sym(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
-cache-references				{ return sym(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
-cache-misses					{ return sym(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
-branch-instructions|branches			{ return sym(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
-branch-misses					{ return sym(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
-bus-cycles					{ return sym(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
-ref-cycles					{ return sym(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
-
-{lc_type}			{ return str(yyscanner, PE_LEGACY_CACHE); }
-{lc_type}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
-{lc_type}-{lc_op_result}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
 mem:			{ BEGIN(mem); return PE_PREFIX_MEM; }
 r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 {num_dec}		{ return value(_parse_state, yyscanner, 10); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index ced26c549c33..c194de5ec1ec 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -55,22 +55,18 @@ static void free_list_evsel(struct list_head* list_evsel)
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
-%token PE_VALUE PE_VALUE_SYM_HW PE_TERM
+%token PE_VALUE PE_TERM
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
-%token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM
 %token PE_ERROR
 %token PE_DRV_CFG_TERM
-%token PE_TERM_HW
 %type <num> PE_VALUE
-%type <num> PE_VALUE_SYM_HW
 %type <mod> PE_MODIFIER_EVENT
 %type <term_type> PE_TERM
 %type <str> PE_RAW
 %type <str> PE_NAME
-%type <str> PE_LEGACY_CACHE
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
 %type <str> PE_DRV_CFG_TERM
@@ -83,8 +79,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <list_terms> opt_pmu_config
 %destructor { parse_events_terms__delete ($$); } <list_terms>
 %type <list_evsel> event_pmu
-%type <list_evsel> event_legacy_symbol
-%type <list_evsel> event_legacy_cache
 %type <list_evsel> event_legacy_mem
 %type <list_evsel> event_legacy_tracepoint
 %type <list_evsel> event_legacy_numeric
@@ -100,8 +94,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %destructor { free_list_evsel ($$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
 %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
-%type <hardware_term> PE_TERM_HW
-%destructor { free ($$.str); } <hardware_term>
 
 %union
 {
@@ -116,10 +108,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 		char *sys;
 		char *event;
 	} tracepoint_name;
-	struct hardware_term {
-		char *str;
-		u64 num;
-	} hardware_term;
 }
 %%
 
@@ -262,8 +250,6 @@ PE_EVENT_NAME event_def
 event_def
 
 event_def: event_pmu |
-	   event_legacy_symbol |
-	   event_legacy_cache sep_dc |
 	   event_legacy_mem sep_dc |
 	   event_legacy_tracepoint sep_dc |
 	   event_legacy_numeric sep_dc |
@@ -288,7 +274,7 @@ PE_NAME sep_dc
 	struct list_head *list;
 	int err;
 
-	err = parse_events_multi_pmu_add(_parse_state, $1, PERF_COUNT_HW_MAX, NULL, &list, &@1);
+	err = parse_events_multi_pmu_add(_parse_state, $1, /*const_parsed_terms*/NULL, &list, &@1);
 	if (err < 0) {
 		struct parse_events_state *parse_state = _parse_state;
 		struct parse_events_error *error = parse_state->error;
@@ -304,66 +290,6 @@ PE_NAME sep_dc
 	$$ = list;
 }
 
-event_legacy_symbol:
-PE_VALUE_SYM_HW '/' event_config '/'
-{
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYNOMEM;
-	err = parse_events_add_numeric(_parse_state, list,
-				       PERF_TYPE_HARDWARE, $1,
-				       $3,
-				       /*wildcard=*/true);
-	parse_events_terms__delete($3);
-	if (err) {
-		free_list_evsel(list);
-		PE_ABORT(err);
-	}
-	$$ = list;
-}
-|
-PE_VALUE_SYM_HW sep_slash_slash_dc
-{
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYNOMEM;
-	err = parse_events_add_numeric(_parse_state, list,
-				       PERF_TYPE_HARDWARE, $1,
-				       /*head_config=*/NULL,
-				       /*wildcard=*/true);
-	if (err)
-		PE_ABORT(err);
-	$$ = list;
-}
-
-event_legacy_cache:
-PE_LEGACY_CACHE opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYNOMEM;
-
-	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2, &@1);
-
-	parse_events_terms__delete($2);
-	free($1);
-	if (err) {
-		free_list_evsel(list);
-		PE_ABORT(err);
-	}
-	$$ = list;
-}
-
 event_legacy_mem:
 PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 {
@@ -582,12 +508,7 @@ event_term
 	$$ = head;
 }
 
-name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
-|
-PE_TERM_HW
-{
-	$$ = $1.str;
-}
+name_or_raw: PE_RAW | PE_NAME
 
 event_term:
 PE_RAW
@@ -629,19 +550,6 @@ name_or_raw '=' PE_VALUE
 	$$ = term;
 }
 |
-PE_LEGACY_CACHE
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
-					 $1, /*num=*/1, /*novalue=*/true, &@1, /*loc_val=*/NULL);
-
-	if (err) {
-		free($1);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-|
 PE_NAME
 {
 	struct parse_events_term *term;
@@ -655,20 +563,6 @@ PE_NAME
 	$$ = term;
 }
 |
-PE_TERM_HW
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_HARDWARE,
-					 $1.str, $1.num & 255, /*novalue=*/false,
-					 &@1, /*loc_val=*/NULL);
-
-	if (err) {
-		free($1.str);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-|
 PE_TERM '=' name_or_raw
 {
 	struct parse_events_term *term;
@@ -737,8 +631,6 @@ PE_DRV_CFG_TERM
 
 sep_dc: ':' |
 
-sep_slash_slash_dc: '/' '/' | ':' |
-
 %%
 
 void parse_events_error(YYLTYPE *loc, void *_parse_state,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7f5bdb6688db..b98413c37df2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1920,9 +1920,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		if (alias->per_pkg)
 			info->per_pkg = true;
 
-		if (term->alternate_hw_config)
-			*alternate_hw_config = term->val.num;
-
 		info->retirement_latency_mean = alias->retirement_latency_mean;
 		info->retirement_latency_min = alias->retirement_latency_min;
 		info->retirement_latency_max = alias->retirement_latency_max;
@@ -2029,10 +2026,10 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 
 	/*
 	 * max-events and driver-config are missing above as are the internal
-	 * types user, metric-id, raw, legacy cache and hardware. Assert against
-	 * the enum parse_events__term_type so they are kept in sync.
+	 * types user, metric-id, and raw. Assert against the enum
+	 * parse_events__term_type so they are kept in sync.
 	 */
-	_Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 6,
+	_Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 4,
 		       "perf_pmu__for_each_format()'s terms must be kept in sync with enum parse_events__term_type");
 	list_for_each_entry(format, &pmu->format, list) {
 		perf_pmu_format__load(pmu, format);
-- 
2.51.0.384.g4c02a37b29-goog


