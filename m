Return-Path: <bpf+bounces-26899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B448A6393
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B351F219B4
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CCE5B699;
	Tue, 16 Apr 2024 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAUfDOcW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280C7FBB4
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248168; cv=none; b=eCUFQ6Y0g3p5npRYgh+Tviw4+REFo1HeHY1ejsE8OIHETmFhOVNoLS+tXV214UXI/zMsfzMZw0iddQundQNU7soExSfjEzVL7OuuJMMjsUVjTf2WfQX9Gp1XCsX4Sa6pjFZwGA0hubaCNlQEPwRc2QL5AhpPXkQoo+kehq3X9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248168; c=relaxed/simple;
	bh=41p271UID1U/EgM4ZyNia92qrKmgbbms7gxwSefAdeo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HWD9OohfmtjQicPm5PhuBRzjkMfDaBEPNo/wc9rJxkGQhns/UBOpQRTHT7TbjFhrws2El7Ve8M88XhQW8oIuPkvVlI6CSkgSbwE0pmC6zM2TyQGgeC/M0e9ZmLLIwYte1ltdNnANQz31b4yKu57BWNW4yNEfxh9amVO1nRzhkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAUfDOcW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ae9ff0322so13825887b3.3
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248165; x=1713852965; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C36r2tqelRWs6L7r88/GKNbOUewmK6XvJFIwgoq4Nzg=;
        b=rAUfDOcWzpre2OTYnj86uNEfgQMOLb+cTN6ch8Kd8I4G1fFs6dHMqj/1zC5NL4L3Dx
         QSID6tt4Ae806OLjYUsRYfIyHM5ZK8oVJgGdqj076qIgWjQenFU6MgVCA7wWaivfzgmI
         jiWmbSmaS1+BJ6PCqRmC1B2NeLQ2PI1RXjPeN6h/U+jJmshEdrVFspmeowc++x8ul6M6
         3EIBDtg+6MnlULtQaz+8O2CQA09VTQHE/ADKBTOx5sv1DLNn1h8luI8U4PlmmGurj5y4
         izAO46QeH1uuIjuY5gUxy1hgdNi5jKcbqK59Ig8d7udHUoY6qzM4Imbas3q7zQirhQ59
         kVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248165; x=1713852965;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C36r2tqelRWs6L7r88/GKNbOUewmK6XvJFIwgoq4Nzg=;
        b=VjbJOOgvWZXvLJJ3tAifAgHU7oAf0DR+OLoxcqU4as5cLiAvHaynq9NAVnc0ftuGLX
         T8XOA579aKIRDUTi78vRpPbEPQvBysYNB0oLjxlAATOnwzOvXJ8SH5gcngF5Tc2LH0y5
         gEw1SefS9PeZIKa5rzEHjmdkPXwXR+Mfskbs/SOgZtwxN72w3Dewj1Eyti5a8ajFvBgz
         4afZdcleR6ThNI2BDXDxxGi/TQFhzKyyQWLBANxiefgbOrkJV6/xRHMBtbrbAHxMqtjT
         3GT1SrByw2iRpYYetjB2LVzPlX+NLdsvx767XIKj9R74kKcY1q40s25UNSOEBZLaZC93
         RMnA==
X-Forwarded-Encrypted: i=1; AJvYcCWfzSKcITla2WO1mpnxXsZuMRCI6Jfxp+W5EAuBxlmGVaoa97jXbsfqOwYNYaMSJYHf8wiMkhiowkx1+RH0VHBu/qXw
X-Gm-Message-State: AOJu0YwKty6PWVtnVNkV/7jlaw3f7WndNGTOTwFIfnKSvp3qVy6TAhw5
	QN9l+5fEeKlUNmiVHBk2Bi5lweIcI+YipddFRNOio42xW5Sk4Yo8vH5qxjNBsxTDgWd173DjBf/
	tvkpfpw==
X-Google-Smtp-Source: AGHT+IGfI9hI86qBWCQ9iFMpUcMIcQ8Bvb3tiAz+gLM+yN6JgYTHeFn6UJJFxzvv6MAOCca+nbvzL+9wRP00
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a81:a056:0:b0:61a:d418:59bd with SMTP id
 x83-20020a81a056000000b0061ad41859bdmr1097020ywg.10.1713248165432; Mon, 15
 Apr 2024 23:16:05 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:25 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 09/16] perf parse-events: Prefer sysfs/json hardware events
 over legacy
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

It was requested that RISC-V be able to add events to the perf tool so
the PMU driver didn't need to map legacy events to config encodings:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/

This change makes the priority of events specified without a PMU the
same as those specified with a PMU, namely sysfs and json events are
checked first before using the legacy encoding.

The hw_term is made more generic as a hardware_event that encodes a
pair of string and int value, allowing parse_events_multi_pmu_add to
fall back on a known encoding when the sysfs/json adding fails for
core events. As this covers PE_VALUE_SYM_HW, that token is removed and
related code simplified.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 31 ++++++++++----
 tools/perf/util/parse-events.h |  2 +-
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 62 +++++++++++++++++----------
 4 files changed, 103 insertions(+), 68 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1b408e3dccc7..805872c90a3e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1543,7 +1543,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name,
+			       const char *event_name, u64 hw_config,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc_)
 {
@@ -1551,8 +1551,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	struct list_head *list = NULL;
 	struct perf_pmu *pmu = NULL;
 	YYLTYPE *loc = loc_;
-	int ok = 0;
-	const char *config;
+	int ok = 0, core_ok = 0;
+	const char *tmp;
 	struct parse_events_terms parsed_terms;
 
 	*listp = NULL;
@@ -1565,15 +1565,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
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
@@ -1604,6 +1604,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			pr_debug("%s -> %s/%s/\n", event_name, pmu->name, sb.buf);
 			strbuf_release(&sb);
 			ok++;
+			if (pmu->is_core)
+				core_ok++;
 		}
 	}
 
@@ -1620,6 +1622,18 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
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
@@ -1673,7 +1687,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	/* Failure to add, assume event_or_pmu is an event name. */
 	zfree(listp);
-	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, const_parsed_terms, listp, loc))
+	if (!parse_events_multi_pmu_add(parse_state, event_or_pmu, PERF_COUNT_HW_MAX,
+					const_parsed_terms, listp, loc))
 		return 0;
 
 	if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", event_or_pmu) < 0)
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5005782766e9..7e5afad3feb8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -215,7 +215,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      struct perf_pmu *pmu);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       const char *event_name,
+			       const char *event_name, u64 hw_config,
 			       const struct parse_events_terms *const_parsed_terms,
 			       struct list_head **listp, void *loc);
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index e86c45675e1d..6fe37003ab7b 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -100,12 +100,12 @@ do {								\
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
 
 static int tool(yyscan_t scanner, enum perf_tool_event event)
@@ -124,13 +124,13 @@ static int term(yyscan_t scanner, enum parse_events__term_type type)
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
 
@@ -246,16 +246,16 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
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
@@ -299,31 +299,31 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
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
 duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
 user_time						{ return tool(yyscanner, PERF_TOOL_USER_TIME); }
 system_time						{ return tool(yyscanner, PERF_TOOL_SYSTEM_TIME); }
-bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
-cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
+bpf-output					{ return sym(yyscanner, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sym(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
 {lc_type}			{ return str(yyscanner, PE_LEGACY_CACHE); }
 {lc_type}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 254f8aeca461..31fe8cf428ff 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -55,7 +55,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
-%token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_TERM
+%token PE_VALUE PE_VALUE_SYM_SW PE_TERM
 %token PE_VALUE_SYM_TOOL
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
@@ -66,11 +66,9 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
 %type <num> PE_VALUE
-%type <num> PE_VALUE_SYM_HW
 %type <num> PE_VALUE_SYM_SW
 %type <num> PE_VALUE_SYM_TOOL
 %type <term_type> PE_TERM
-%type <num> value_sym
 %type <str> PE_RAW
 %type <str> PE_NAME
 %type <str> PE_LEGACY_CACHE
@@ -87,6 +85,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <list_terms> opt_pmu_config
 %destructor { parse_events_terms__delete ($$); } <list_terms>
 %type <list_evsel> event_pmu
+%type <list_evsel> event_legacy_hardware
 %type <list_evsel> event_legacy_symbol
 %type <list_evsel> event_legacy_cache
 %type <list_evsel> event_legacy_mem
@@ -104,8 +103,8 @@ static void free_list_evsel(struct list_head* list_evsel)
 %destructor { free_list_evsel ($$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
 %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
-%type <hardware_term> PE_TERM_HW
-%destructor { free ($$.str); } <hardware_term>
+%type <hardware_event> PE_TERM_HW
+%destructor { free ($$.str); } <hardware_event>
 
 %union
 {
@@ -119,10 +118,10 @@ static void free_list_evsel(struct list_head* list_evsel)
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
 
@@ -263,6 +262,7 @@ PE_EVENT_NAME event_def
 event_def
 
 event_def: event_pmu |
+	   event_legacy_hardware |
 	   event_legacy_symbol |
 	   event_legacy_cache sep_dc |
 	   event_legacy_mem sep_dc |
@@ -289,7 +289,7 @@ PE_NAME sep_dc
 	struct list_head *list;
 	int err;
 
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list, &@1);
+	err = parse_events_multi_pmu_add(_parse_state, $1, PERF_COUNT_HW_MAX, NULL, &list, &@1);
 	if (err < 0) {
 		struct parse_events_state *parse_state = _parse_state;
 		struct parse_events_error *error = parse_state->error;
@@ -305,24 +305,45 @@ PE_NAME sep_dc
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
@@ -331,18 +352,17 @@ value_sym '/' event_config '/'
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
2.44.0.683.g7961c838ac-goog


