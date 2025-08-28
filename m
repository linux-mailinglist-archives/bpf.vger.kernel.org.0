Return-Path: <bpf+bounces-66856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA6B3A676
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2101C864BE
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE033EB11;
	Thu, 28 Aug 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXTpo3ml"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C733CEBA
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398785; cv=none; b=Mr72KpG5njPckQxKksaPNJwm4eiVKgqaCM+jCSHrmXf44wIqxbAtUnzGSDVCcTF/o/mdv40QFzclMQyMWcES0mbWuIptHldO8GqyhIp2hDqMFik+z8E1fIzjuwHPOvABMibrdNLl8KzoYNbjdJEos/AbCrOQcuCG1agIgxXsit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398785; c=relaxed/simple;
	bh=GdvG28TxvruPQzR3pzCKSXrFfm30tAXtid6setzKjP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QDNe7DpPC6zH4c2vDWl5QqcnZvqKm25o9sbjwpu25Px8qONwKyAqjyccRpoy2SfF0kPJUE4JaegINHwBbtnc+6kSVFZ8lPDQtpnbHLP+dJ86uMorzlGWUpHYee3Zen+P30QWf226fpS4vLRUYLWKyFoMAd5eoeLdYTbkG40Ix4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXTpo3ml; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b00af618so884963a91.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398783; x=1757003583; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdqRy/1COBZaYWoa2RoQuymv9cvGjeUg+Gx0uTV3d9w=;
        b=qXTpo3mlzVKdKO0xrkclNxG/WboUElEMVKCaLIXNpN2vPgesXaEuudbgY27pICfpRV
         PnlNyPTmKNXHMHfa5diXPuWdXEWt6/C8qdDPbn5guYvsQpuNmJkqml01BOiJ09iRPX7o
         00zzO/31RhS6j7hr2XrtgaJdTgTc0ql9T3q1YfMTrzv3z1gqvF6s6GIYzsH9NIya6xMS
         hWy3R988J7oMQPulkC1QNOj8IcX57VHrReD9Xammc3EACoKDH+zGHUnIQoQcu3XTGg/r
         owSOHc/EDPfEgwD4OdxN94QDkyvGxNulyre77w8tCPjewoDlTC64m0H0cqVXwvEF06GX
         xLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398783; x=1757003583;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdqRy/1COBZaYWoa2RoQuymv9cvGjeUg+Gx0uTV3d9w=;
        b=AbY7njZVu2MP7lsnKWnKXvIEuV2a5haQAN8P1qmjI4rQLXq7NTLNUpozx75X2rx9/D
         VdvacjaYFG+dbuOBt3fuA1RCFUnjagtEAjZOBXk+r7LDlY0iRKogPmSYmw5B6WY0949A
         Ss3en5m3qqgQ0xQxchulapmvZ5QUzebzUg2oFLx30EPDrTd8UdLYo7VNupNJ3ws8IB11
         1+/xFGdpp99D6GWqMXv+5BuBerm/Jj+cOB9UXk8ZeH3SFO1QZAk0uaE43ePMWiwJ82ps
         GSyuSj1011kthNyIeolww/A/kyxEC2JIHTjfl9Lu/7/jD5g+bXA9neRaAgxIjuQd9jyY
         l/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQJXDBSb0tT3FRMrzaynab7c0pPY6ytJ0a6ASofvyeHRA4cbaMp1Crezi3E9+UnXhKSLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bk0fr2S+4g78zFP2x8Rw61LgiepdRL6NSfvqqwbWTh6gSh4y
	xa7secuQk6yJaBZO2tcT3JJBIYzzuuIchs8OV6Pb/SK2IchQ9ekB7BlqD20r3HePF+2Lu38124c
	f+WlBaW7qfw==
X-Google-Smtp-Source: AGHT+IHz1Epqb64N3BHLWMKbxZU1zBfjF004EwEdgHt5HpmNPG9KsRsSIZ0oU/zMSjmKwmoQaQQ8nz2lo8+f
X-Received: from pjbee8.prod.google.com ([2002:a17:90a:fc48:b0:31f:6a10:6ea6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a90:b0:327:712c:be1d
 with SMTP id 98e67ed59e1d1-327712cc062mr8657380a91.21.1756398782693; Thu, 28
 Aug 2025 09:33:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:21 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-12-irogers@google.com>
Subject: [PATCH v2 11/15] perf pmu: Add and use legacy_terms in alias information
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

Add support to finding/adding events from the default_core event
table. If an event already exists from sysfs/json then the
default_core configuration is saved in the legacy_terms string. Lazily
use the legacy_terms string to set a legacy hardware or cache event as
deprecated if the core PMU doesn't support it. Use the legacy terms
string to set the alternate_hw_config, avoiding the value needing to
be passed from the parse_events parser.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 133 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 115 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f718eb41af88..b9e489ce696e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -69,6 +69,11 @@ struct perf_pmu_alias {
 	char *topic;
 	/** @terms: Owned copy of the event terms. */
 	char *terms;
+	/**
+	 * @legacy_terms: If the event aliases a legacy event, holds a copy
+	 * ofthe legacy event string.
+	 */
+	char *legacy_terms;
 	/**
 	 * @pmu_name: The name copied from the json struct pmu_event. This can
 	 * differ from the PMU name as it won't have suffixes.
@@ -101,6 +106,12 @@ struct perf_pmu_alias {
 	 * default.
 	 */
 	bool deprecated;
+	/**
+	 * @legacy_deprecated_checked: Legacy events may not be supported by the
+	 * PMU need to be checked. If they aren't supported they are marked
+	 * deprecated.
+	 */
+	bool legacy_deprecated_checked;
 	/** @from_sysfs: Was the alias from sysfs or a json event? */
 	bool from_sysfs;
 	/** @info_loaded: Have the scale, unit and other values been read from disk? */
@@ -430,6 +441,7 @@ static void perf_pmu_free_alias(struct perf_pmu_alias *alias)
 	zfree(&alias->topic);
 	zfree(&alias->pmu_name);
 	zfree(&alias->terms);
+	zfree(&alias->legacy_terms);
 	free(alias);
 }
 
@@ -522,6 +534,7 @@ static void read_alias_info(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 struct update_alias_data {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
+	bool legacy;
 };
 
 static int update_alias(const struct pmu_event *pe,
@@ -537,8 +550,13 @@ static int update_alias(const struct pmu_event *pe,
 	assign_str(pe->name, "topic", &data->alias->topic, pe->topic);
 	data->alias->per_pkg = pe->perpkg;
 	if (pe->event) {
-		zfree(&data->alias->terms);
-		data->alias->terms = strdup(pe->event);
+		if (data->legacy) {
+			zfree(&data->alias->legacy_terms);
+			data->alias->legacy_terms = strdup(pe->event);
+		} else {
+			zfree(&data->alias->terms);
+			data->alias->terms = strdup(pe->event);
+		}
 	}
 	if (!ret && pe->unit) {
 		char *unit;
@@ -628,7 +646,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			return ret;
 		}
 	}
-
 	alias->name = strdup(name);
 	alias->desc = desc ? strdup(desc) : NULL;
 	alias->long_desc = long_desc ? strdup(long_desc) : NULL;
@@ -650,10 +667,24 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			struct update_alias_data data = {
 				.pmu = pmu,
 				.alias = alias,
+				.legacy = false,
 			};
-			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
-							 update_alias, &data) == 0)
+			if ((pmu_events_table__find_event(pmu->events_table, pmu, name,
+							  update_alias, &data) == 0)) {
+				/*
+				 * Override sysfs encodings with json encodings
+				 * specific to the cpuid.
+				 */
 				pmu->cpu_common_json_aliases++;
+			}
+			if (pmu->is_core) {
+				/* Add in legacy encodings. */
+				data.legacy = true;
+				if (pmu_events_table__find_event(
+						perf_pmu__default_core_events_table(),
+						pmu, name, update_alias, &data) == 0)
+					pmu->cpu_common_json_aliases++;
+			}
 		}
 		pmu->sysfs_aliases++;
 		break;
@@ -1054,13 +1085,16 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
 
 static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
 {
-	if (!pmu->events_table)
+	if (!pmu->events_table && !pmu->is_core)
 		return;
 
 	if (pmu->cpu_aliases_added)
 		return;
 
 	pmu_add_cpu_aliases_table(pmu, pmu->events_table);
+	if (pmu->is_core)
+		pmu_add_cpu_aliases_table(pmu, perf_pmu__default_core_events_table());
+
 	pmu->cpu_aliases_added = true;
 }
 
@@ -1738,10 +1772,14 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 		return alias;
 
 	/* Alias doesn't exist, try to get it from the json events. */
-	if (pmu->events_table &&
-	    pmu_events_table__find_event(pmu->events_table, pmu, name,
-				         pmu_add_cpu_aliases_map_callback,
-				         pmu) == 0) {
+	if ((pmu_events_table__find_event(pmu->events_table, pmu, name,
+					  pmu_add_cpu_aliases_map_callback,
+					  pmu) == 0) ||
+	    (pmu->is_core &&
+	     pmu_events_table__find_event(perf_pmu__default_core_events_table(),
+					  pmu, name,
+					  pmu_add_cpu_aliases_map_callback,
+					  pmu) == 0)) {
 		alias = perf_pmu__find_alias(pmu, name, /*load=*/ false);
 	}
 	return alias;
@@ -1865,6 +1903,20 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		if (ret)
 			return ret;
 
+		if (alias->legacy_terms) {
+			struct perf_event_attr attr = {.config = 0,};
+
+			ret = perf_pmu__parse_terms_to_attr(pmu, alias->legacy_terms, &attr);
+			if (ret) {
+				parse_events_error__handle(err, term->err_term,
+							strdup("Error evaluating legacy terms"),
+							NULL);
+				return ret;
+			}
+			if (attr.type == PERF_TYPE_HARDWARE)
+				*alternate_hw_config = attr.config;
+		}
+
 		if (alias->per_pkg)
 			info->per_pkg = true;
 
@@ -2035,7 +2087,11 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
 		return false;
-	return pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0;
+	if (pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0)
+		return true;
+	return pmu->is_core &&
+		pmu_events_table__find_event(perf_pmu__default_core_events_table(),
+					     pmu, name, NULL, NULL) == 0;
 }
 
 size_t perf_pmu__num_events(struct perf_pmu *pmu)
@@ -2052,13 +2108,18 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
-	if (pmu->cpu_aliases_added)
-		 nr += pmu->cpu_json_aliases;
-	else if (pmu->events_table)
-		nr += pmu_events_table__num_events(pmu->events_table, pmu) -
-			pmu->cpu_common_json_aliases;
-	else
+	if (pmu->cpu_aliases_added) {
+		nr += pmu->cpu_json_aliases;
+	} else if (pmu->events_table || pmu->is_core) {
+		nr += pmu_events_table__num_events(pmu->events_table, pmu);
+		if (pmu->is_core) {
+			nr += pmu_events_table__num_events(
+				perf_pmu__default_core_events_table(), pmu);
+		}
+		nr -= pmu->cpu_common_json_aliases;
+	} else {
 		assert(pmu->cpu_json_aliases == 0 && pmu->cpu_common_json_aliases == 0);
+	}
 
 	if (perf_pmu__is_tool(pmu))
 		nr -= tool_pmu__num_skip_events();
@@ -2120,6 +2181,42 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	return buf;
 }
 
+static bool perf_pmu_alias__check_deprecated(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+{
+	struct perf_event_attr attr = {.config = 0,};
+	const char *check_terms;
+	bool has_legacy_config;
+
+	if (alias->legacy_deprecated_checked)
+		return alias->deprecated;
+
+	alias->legacy_deprecated_checked = true;
+	if (alias->deprecated)
+		return true;
+
+	check_terms = alias->terms;
+	has_legacy_config =
+		strstr(check_terms, "legacy-hardware-config=") != NULL ||
+		strstr(check_terms, "legacy-cache-config=") != NULL;
+	if (!has_legacy_config && alias->legacy_terms) {
+		check_terms = alias->legacy_terms;
+		has_legacy_config =
+			strstr(check_terms, "legacy-hardware-config=") != NULL ||
+			strstr(check_terms, "legacy-cache-config=") != NULL;
+	}
+	if (!has_legacy_config)
+		return false;
+
+	if (perf_pmu__parse_terms_to_attr(pmu, check_terms, &attr) != 0) {
+		/* Parsing failed, set as deprecated. */
+		alias->deprecated = true;
+	} else if (attr.type < PERF_TYPE_MAX) {
+		/* Flag unsupported legacy events as deprecated. */
+		alias->deprecated = !is_event_supported(attr.type, attr.config);
+	}
+	return alias->deprecated;
+}
+
 int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 			     void *state, pmu_event_callback cb)
 {
@@ -2177,7 +2274,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 				"%.*s/%s/", (int)pmu_name_len, info.pmu_name, event->terms) + 1;
 		info.str = event->terms;
 		info.topic = event->topic;
-		info.deprecated = event->deprecated;
+		info.deprecated = perf_pmu_alias__check_deprecated(pmu, event);
 		ret = cb(state, &info);
 		if (ret)
 			goto out;
-- 
2.51.0.268.g9569e192d0-goog


