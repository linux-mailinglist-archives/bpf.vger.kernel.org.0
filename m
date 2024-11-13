Return-Path: <bpf+bounces-44705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557809C6698
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150DD283C49
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCEDBA34;
	Wed, 13 Nov 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykwxqRhh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2C80604
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460823; cv=none; b=medT+d57juy7758Gn5cD27pZwMfyAvVi+tWYyYcAgt7sUY01us4kcEuFE2gSI7/c68h+zNlOuMnm1PZnUIqAwUfJM+slaPmeEvx30gRCh1KLSshfrratGnWo3NI2oyPf7/gnwgK5DbB2pkGTzTzg3ZtetuQ4ir2m8omQsHIiSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460823; c=relaxed/simple;
	bh=+Lm1lk2ojRHMndTBXy55UFr2AEhBMQgtf2uZbGZJmBw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=YrtN5BafLH1l3afc6Kri3cZvsMha5G1r6aiw8I8veq4HdLQXYpovVhH0t43Klug2iJlcMBJtpmwJeNiL0/i0yWLnPUJ6fKSlhAvsghH7gp18vLVpw7Va5dDahQryLu0/0UaSTVa+wTr6dvo1QSkfphMiBvAmVtJlVeld3uXyw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykwxqRhh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eaa08a6fdbso115370377b3.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 17:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731460821; x=1732065621; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Sp3nDU0mDR5SRD5ss1zBlGy5OD7J9sKfSHPRnVivaE=;
        b=ykwxqRhhy6HQh548bdExOvnOPyl8VekSFjBAtqTZd476mr9o9JxgCKTIToyxtGEC2M
         JU7NqLZFPT+1tLnggSrlZgruuSW2eycvy+/aAjBcQRNjH4uKOJwa35G97QXZ/I3bM8BB
         opglgret4Wt3+ghUkwjeMVcTmABmWMfIceIgsSGQHsfWt9vQoWP38FPcUFwbmP+Y7PmO
         oP2XGsfWXcMpFkEKfyrIjdQSq4IrtieGANQ3GEcFi2U7E2VvWtxfrJvdghIx71SvSclR
         /pOAHLnpcm83H6+sJivihZeJQm2YyOqLeVRzDkaCibQT4TQkFPjY+xEy5OjeHzG8Bv2E
         zBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460821; x=1732065621;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Sp3nDU0mDR5SRD5ss1zBlGy5OD7J9sKfSHPRnVivaE=;
        b=LAF9LsKGqvC/zN7R4KDW0YJcfpmfGLnHwqV4O2eDT1LkZwCcFGo61uR86itk2+SX2r
         aDpQ9/ueCbEeFPxQAsf8mBpMNh4s5aUn8oxiCtj9aKSdI6ZOlhYpReCrSRKxGajMPAos
         83iKWBjmqUnYZ15ilSoxvhYJ5zW1i1xEmwdB6GVU4wF8POurk2aEgPhLVYBnoywgnV5t
         subMj2Ve8L2t7xWhH6ga8CLXcnSGHE+eDe3CnNrbBc9ryXJA6ZwICSIA0ET1PICPIPf8
         5PfeupJt0GD2mMNZbPTvtIxax1na9U3q64xXPZXMN8cDl4iROobhq9Gcos3rnqD8qRip
         Vmyg==
X-Forwarded-Encrypted: i=1; AJvYcCW7HZ6M8xU7OTdd7JguPR4n30LgcFZFSMlws9g6k3GolybMLO2GGLIqs3pMuh7QOQb8FWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOsg01gd5dsgN1oMoAq8bRV6Jhh/Eo7c6p2VXSuk0G9ebBJXr
	wW9jm0BAYg4W2rGtWIbitu9Xu5Yhu9F18IizsgB/u9HQTxBYu3LlHNIbDavob3zv5UyFjxACFJU
	1e/hRXA==
X-Google-Smtp-Source: AGHT+IHJ26lAxcgh4XitezTF+niuKUFBil76R5ovFZ+AktT4YYXqgSrwUwgCRVSA2m29R3EDUarLXQ8h3jPT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a25:b301:0:b0:e28:ee84:e4d8 with SMTP id
 3f1490d57ef6-e35dc4b9494mr4023276.3.1731460820699; Tue, 12 Nov 2024 17:20:20
 -0800 (PST)
Date: Tue, 12 Nov 2024 17:19:56 -0800
In-Reply-To: <20241113011956.402096-1-irogers@google.com>
Message-Id: <20241113011956.402096-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113011956.402096-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v2 4/4] perf parse-events: Reapply "Prefer sysfs/JSON hardware
 events over legacy"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Originally posted and merged from:
https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
This reverts commit 4f1b067359ac8364cdb7f9fda41085fa85789d0f although
the patch is now smaller due to related fixes being applied in commit
22a4db3c3603 ("perf evsel: Add alternate_hw_config and use in
evsel__match").
The original commit message was:

It was requested that RISC-V be able to add events to the perf tool so
the PMU driver didn't need to map legacy events to config encodings:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/

This change makes the priority of events specified without a PMU the
same as those specified with a PMU, namely sysfs and JSON events are
checked first before using the legacy encoding.

The hw_term is made more generic as a hardware_event that encodes a
pair of string and int value, allowing parse_events_multi_pmu_add to
fall back on a known encoding when the sysfs/JSON adding fails for
core events. As this covers PE_VALUE_SYM_HW, that token is removed and
related code simplified.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Beeman Strong <beeman@rivosinc.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 3 files changed, 98 insertions(+), 64 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index afeb8d815bbf..fd33e2b4860b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1549,8 +1549,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	struct list_head *list = NULL;
 	struct perf_pmu *pmu = NULL;
 	YYLTYPE *loc = loc_;
-	int ok = 0;
-	const char *config;
+	int ok = 0, core_ok = 0;
+	const char *tmp;
 	struct parse_events_terms parsed_terms;
 
 	*listp = NULL;
@@ -1563,15 +1563,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			return ret;
 	}
 
-	config = strdup(event_name);
-	if (!config)
+	tmp = strdup(event_name);
+	if (!tmp)
 		goto out_err;
 
 	if (parse_events_term__num(&term,
 				   PARSE_EVENTS__TERM_TYPE_USER,
-				   config, /*num=*/1, /*novalue=*/true,
+				   tmp, /*num=*/1, /*novalue=*/true,
 				   loc, /*loc_val=*/NULL) < 0) {
-		zfree(&config);
+		zfree(&tmp);
 		goto out_err;
 	}
 	list_add_tail(&term->list, &parsed_terms.terms);
@@ -1602,6 +1602,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			pr_debug("%s -> %s/%s/\n", event_name, pmu->name, sb.buf);
 			strbuf_release(&sb);
 			ok++;
+			if (pmu->is_core)
+				core_ok++;
 		}
 	}
 
@@ -1618,6 +1620,18 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 		}
 	}
 
+	if (hw_config != PERF_COUNT_HW_MAX && !core_ok) {
+		/*
+		 * The event wasn't found on core PMUs but it has a hardware
+		 * config version to try.
+		 */
+		if (!parse_events_add_numeric(parse_state, list,
+						PERF_TYPE_HARDWARE, hw_config,
+						const_parsed_terms,
+						/*wildcard=*/true))
+			ok++;
+	}
+
 out_err:
 	parse_events_terms__exit(&parsed_terms);
 	if (ok)
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 14e5bd856a18..7c2641cf9b79 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -113,12 +113,12 @@ do {								\
 	yyless(0);						\
 } while (0)
 
-static int sym(yyscan_t scanner, int type, int config)
+static int sym(yyscan_t scanner, int config)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 
-	yylval->num = (type << 16) + config;
-	return type == PERF_TYPE_HARDWARE ? PE_VALUE_SYM_HW : PE_VALUE_SYM_SW;
+	yylval->num = config;
+	return PE_VALUE_SYM_SW;
 }
 
 static int term(yyscan_t scanner, enum parse_events__term_type type)
@@ -129,13 +129,13 @@ static int term(yyscan_t scanner, enum parse_events__term_type type)
 	return PE_TERM;
 }
 
-static int hw_term(yyscan_t scanner, int config)
+static int hw(yyscan_t scanner, int config)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
-	yylval->hardware_term.str = strdup(text);
-	yylval->hardware_term.num = PERF_TYPE_HARDWARE + config;
+	yylval->hardware_event.str = strdup(text);
+	yylval->hardware_event.num = config;
 	return PE_TERM_HW;
 }
 
@@ -323,16 +323,16 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
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
+cpu-cycles|cycles				{ return hw(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
+stalled-cycles-frontend|idle-cycles-frontend	{ return hw(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
+stalled-cycles-backend|idle-cycles-backend	{ return hw(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
+instructions					{ return hw(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
+cache-references				{ return hw(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
+cache-misses					{ return hw(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
+branch-instructions|branches			{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
+branch-misses					{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
+bus-cycles					{ return hw(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
+ref-cycles					{ return hw(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
 r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 ,			{ return ','; }
@@ -376,28 +376,28 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 <<EOF>>			{ BEGIN(INITIAL); }
 }
 
-cpu-cycles|cycles				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES); }
-stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
-stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-instructions					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS); }
-cache-references				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES); }
-cache-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES); }
-branch-instructions|branches			{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
-branch-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES); }
-bus-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BUS_CYCLES); }
-ref-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_REF_CPU_CYCLES); }
-cpu-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_CLOCK); }
-task-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_TASK_CLOCK); }
-page-faults|faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS); }
-minor-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
-major-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
-context-switches|cs				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CONTEXT_SWITCHES); }
-cpu-migrations|migrations			{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_MIGRATIONS); }
-alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
-emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
-dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
-bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
-cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
+cpu-cycles|cycles				{ return hw(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
+stalled-cycles-frontend|idle-cycles-frontend	{ return hw(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
+stalled-cycles-backend|idle-cycles-backend	{ return hw(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
+instructions					{ return hw(yyscanner, PERF_COUNT_HW_INSTRUCTIONS); }
+cache-references				{ return hw(yyscanner, PERF_COUNT_HW_CACHE_REFERENCES); }
+cache-misses					{ return hw(yyscanner, PERF_COUNT_HW_CACHE_MISSES); }
+branch-instructions|branches			{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
+branch-misses					{ return hw(yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
+bus-cycles					{ return hw(yyscanner, PERF_COUNT_HW_BUS_CYCLES); }
+ref-cycles					{ return hw(yyscanner, PERF_COUNT_HW_REF_CPU_CYCLES); }
+cpu-clock					{ return sym(yyscanner, PERF_COUNT_SW_CPU_CLOCK); }
+task-clock					{ return sym(yyscanner, PERF_COUNT_SW_TASK_CLOCK); }
+page-faults|faults				{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS); }
+minor-faults					{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
+major-faults					{ return sym(yyscanner, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
+context-switches|cs				{ return sym(yyscanner, PERF_COUNT_SW_CONTEXT_SWITCHES); }
+cpu-migrations|migrations			{ return sym(yyscanner, PERF_COUNT_SW_CPU_MIGRATIONS); }
+alignment-faults				{ return sym(yyscanner, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
+emulation-faults				{ return sym(yyscanner, PERF_COUNT_SW_EMULATION_FAULTS); }
+dummy						{ return sym(yyscanner, PERF_COUNT_SW_DUMMY); }
+bpf-output					{ return sym(yyscanner, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sym(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
 {lc_type}			{ return str(yyscanner, PE_LEGACY_CACHE); }
 {lc_type}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f888cbb076d6..d2ef1890007e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -55,7 +55,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
-%token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_TERM
+%token PE_VALUE PE_VALUE_SYM_SW PE_TERM
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
@@ -65,11 +65,9 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
 %type <num> PE_VALUE
-%type <num> PE_VALUE_SYM_HW
 %type <num> PE_VALUE_SYM_SW
 %type <mod> PE_MODIFIER_EVENT
 %type <term_type> PE_TERM
-%type <num> value_sym
 %type <str> PE_RAW
 %type <str> PE_NAME
 %type <str> PE_LEGACY_CACHE
@@ -85,6 +83,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <list_terms> opt_pmu_config
 %destructor { parse_events_terms__delete ($$); } <list_terms>
 %type <list_evsel> event_pmu
+%type <list_evsel> event_legacy_hardware
 %type <list_evsel> event_legacy_symbol
 %type <list_evsel> event_legacy_cache
 %type <list_evsel> event_legacy_mem
@@ -102,8 +101,8 @@ static void free_list_evsel(struct list_head* list_evsel)
 %destructor { free_list_evsel ($$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
 %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
-%type <hardware_term> PE_TERM_HW
-%destructor { free ($$.str); } <hardware_term>
+%type <hardware_event> PE_TERM_HW
+%destructor { free ($$.str); } <hardware_event>
 
 %union
 {
@@ -118,10 +117,10 @@ static void free_list_evsel(struct list_head* list_evsel)
 		char *sys;
 		char *event;
 	} tracepoint_name;
-	struct hardware_term {
+	struct hardware_event {
 		char *str;
 		u64 num;
-	} hardware_term;
+	} hardware_event;
 }
 %%
 
@@ -264,6 +263,7 @@ PE_EVENT_NAME event_def
 event_def
 
 event_def: event_pmu |
+	   event_legacy_hardware |
 	   event_legacy_symbol |
 	   event_legacy_cache sep_dc |
 	   event_legacy_mem sep_dc |
@@ -306,24 +306,45 @@ PE_NAME sep_dc
 	$$ = list;
 }
 
-value_sym:
-PE_VALUE_SYM_HW
+event_legacy_hardware:
+PE_TERM_HW opt_pmu_config
+{
+	/* List of created evsels. */
+	struct list_head *list = NULL;
+	int err = parse_events_multi_pmu_add(_parse_state, $1.str, $1.num, $2, &list, &@1);
+
+	free($1.str);
+	parse_events_terms__delete($2);
+	if (err)
+		PE_ABORT(err);
+
+	$$ = list;
+}
 |
-PE_VALUE_SYM_SW
+PE_TERM_HW sep_dc
+{
+	struct list_head *list;
+	int err;
+
+	err = parse_events_multi_pmu_add(_parse_state, $1.str, $1.num, NULL, &list, &@1);
+	free($1.str);
+	if (err)
+		PE_ABORT(err);
+	$$ = list;
+}
 
 event_legacy_symbol:
-value_sym '/' event_config '/'
+PE_VALUE_SYM_SW '/' event_config '/'
 {
 	struct list_head *list;
-	int type = $1 >> 16;
-	int config = $1 & 255;
 	int err;
-	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	err = parse_events_add_numeric(_parse_state, list, type, config, $3, wildcard);
+	err = parse_events_add_numeric(_parse_state, list,
+				/*type=*/PERF_TYPE_SOFTWARE, /*config=*/$1,
+				$3, /*wildcard=*/false);
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(list);
@@ -332,18 +353,17 @@ value_sym '/' event_config '/'
 	$$ = list;
 }
 |
-value_sym sep_slash_slash_dc
+PE_VALUE_SYM_SW sep_slash_slash_dc
 {
 	struct list_head *list;
-	int type = $1 >> 16;
-	int config = $1 & 255;
-	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 	int err;
 
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	err = parse_events_add_numeric(_parse_state, list, type, config, /*head_config=*/NULL, wildcard);
+	err = parse_events_add_numeric(_parse_state, list,
+				/*type=*/PERF_TYPE_SOFTWARE, /*config=*/$1,
+				/*head_config=*/NULL, /*wildcard=*/false);
 	if (err)
 		PE_ABORT(err);
 	$$ = list;
-- 
2.47.0.277.g8800431eea-goog


