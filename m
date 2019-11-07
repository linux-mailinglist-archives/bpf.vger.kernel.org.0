Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D221F3B21
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 23:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfKGWPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 17:15:02 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50121 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfKGWPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 17:15:02 -0500
Received: by mail-pf1-f202.google.com with SMTP id r187so2987872pfc.16
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 14:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=laQc1zyWbEvcb3m/Ga9I37nMi3ijv6X82hzmHQHwiLk=;
        b=fctkl74iJXHIkr9kY6ZydG2QxV80SlcKHzi2U4JxyHGJXTFC8h1rhuVW/PkAMEq0Q8
         +yiIxUlanVfis5pOQivmSDEbUsWffa8Z+eEO9SU1IGWuXjvPQmWh6swfgCaNVgwn7EAF
         3qkS/VwX+WeW5r2HhK8iKUwyojR08VCDkAQPT+A8JlMRmWNyRzB42o3necLvWG62RXLP
         +8M40zyO10aCfROSQdSUuSpJfU4x7SYfXe/XzOCHrjVPDjoGqcEa1XjMUt49ukO3xbg8
         QB7zcc53YcEj0vAHXx1zVoR1w3sNQRpK+rFShTvdWtLWtachKErhTVq96dFQmcg9SBkd
         jbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=laQc1zyWbEvcb3m/Ga9I37nMi3ijv6X82hzmHQHwiLk=;
        b=X3b7vmicJXKIzf2ixA6parEdxLRTnYsZf28ERGF4Dw2X+gja3Q9ILC1drAJlc2nTAI
         NmH3zbTVXQQoFgCuu3S7yXQYW1g/HGcPXnqlFDT00VUTNjOxyb+9qHNo4+U6Ixc1SuFy
         Z0KlvKYQnFe0/HlyXIXRr1gUb1ivos78mb94PhwJnlAo+ikqhoikLwbIK6hsc6K57Qv2
         swOB0VVgcdZd6lZcfEvma4RZT3dTUGcawIsDkeUhWsOYwpzITfXT1yJrYnACSzNtGfrC
         j6ZlmliIowQeT2RircoMV8oxFHgU3Nj57SVs2CXlBz9aEqTQ1nr/idZIWf7bdbXIo3BI
         Rvcg==
X-Gm-Message-State: APjAAAUzUhFjXEUWZdA+7Hw6YkXdO0cj+XSxk110iAEacDjsuO09n3H1
        ROISigplCQxA8FvWzpogiBi9hTmN+fyM
X-Google-Smtp-Source: APXvYqx+DuLyMI4yoiaDMo8sILh/BtZxSwnNm3wqk9gFxnBhkeDrs/RcPdSUyCiUITXaCJsPn22sT1cqFQZK
X-Received: by 2002:a63:7247:: with SMTP id c7mr7556097pgn.311.1573164900492;
 Thu, 07 Nov 2019 14:15:00 -0800 (PST)
Date:   Thu,  7 Nov 2019 14:14:25 -0800
In-Reply-To: <20191107221428.168286-1-irogers@google.com>
Message-Id: <20191107221428.168286-8-irogers@google.com>
Mime-Version: 1.0
References: <20191030223448.12930-1-irogers@google.com> <20191107221428.168286-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v6 07/10] perf tools: before yyabort-ing free components
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yyabort doesn't destruct inputs and so this must be done manually before
using yyabort.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 252 ++++++++++++++++++++++++++-------
 1 file changed, 197 insertions(+), 55 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 035edfa8d42e..376b19855470 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -152,6 +152,7 @@ start_events: groups
 {
 	struct parse_events_state *parse_state = _parse_state;
 
+	/* frees $1 */
 	parse_events_update_lists($1, &parse_state->list);
 }
 
@@ -161,6 +162,7 @@ groups ',' group
 	struct list_head *list  = $1;
 	struct list_head *group = $3;
 
+	/* frees $3 */
 	parse_events_update_lists(group, list);
 	$$ = list;
 }
@@ -170,6 +172,7 @@ groups ',' event
 	struct list_head *list  = $1;
 	struct list_head *event = $3;
 
+	/* frees $3 */
 	parse_events_update_lists(event, list);
 	$$ = list;
 }
@@ -182,8 +185,14 @@ group:
 group_def ':' PE_MODIFIER_EVENT
 {
 	struct list_head *list = $1;
+	int err;
 
-	ABORT_ON(parse_events__modifier_group(list, $3));
+	err = parse_events__modifier_group(list, $3);
+	free($3);
+	if (err) {
+		free_list_evsel(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
@@ -196,6 +205,7 @@ PE_NAME '{' events '}'
 
 	inc_group_count(list, _parse_state);
 	parse_events__set_leader($1, list, _parse_state);
+	free($1);
 	$$ = list;
 }
 |
@@ -214,6 +224,7 @@ events ',' event
 	struct list_head *event = $3;
 	struct list_head *list  = $1;
 
+	/* frees $3 */
 	parse_events_update_lists(event, list);
 	$$ = list;
 }
@@ -226,13 +237,19 @@ event_mod:
 event_name PE_MODIFIER_EVENT
 {
 	struct list_head *list = $1;
+	int err;
 
 	/*
 	 * Apply modifier on all events added by single event definition
 	 * (there could be more events added for multiple tracepoint
 	 * definitions via '*?'.
 	 */
-	ABORT_ON(parse_events__modifier_event(list, $2, false));
+	err = parse_events__modifier_event(list, $2, false);
+	free($2);
+	if (err) {
+		free_list_evsel(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
@@ -241,8 +258,14 @@ event_name
 event_name:
 PE_EVENT_NAME event_def
 {
-	ABORT_ON(parse_events_name($2, $1));
+	int err;
+
+	err = parse_events_name($2, $1);
 	free($1);
+	if (err) {
+		free_list_evsel($2);
+		YYABORT;
+	}
 	$$ = $2;
 }
 |
@@ -262,23 +285,33 @@ PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct parse_events_error *error = parse_state->error;
-	struct list_head *list, *orig_terms, *terms;
+	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
+	char *pattern = NULL;
+
+#define CLEANUP_YYABORT					\
+	do {						\
+		parse_events_terms__delete($2);		\
+		parse_events_terms__delete(orig_terms);	\
+		free($1);				\
+		free(pattern);				\
+		YYABORT;				\
+	} while(0)
 
 	if (parse_events_copy_term_list($2, &orig_terms))
-		YYABORT;
+		CLEANUP_YYABORT;
 
 	if (error)
 		error->idx = @1.first_column;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		CLEANUP_YYABORT;
 	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
-		char *pattern;
 
 		if (asprintf(&pattern, "%s*", $1) < 0)
-			YYABORT;
+			CLEANUP_YYABORT;
 
 		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 			char *name = pmu->name;
@@ -287,31 +320,32 @@ PE_NAME opt_pmu_config
 			    strncmp($1, "uncore_", 7))
 				name += 7;
 			if (!fnmatch(pattern, name, 0)) {
-				if (parse_events_copy_term_list(orig_terms, &terms)) {
-					free(pattern);
-					YYABORT;
-				}
+				if (parse_events_copy_term_list(orig_terms, &terms))
+					CLEANUP_YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
 					ok++;
 				parse_events_terms__delete(terms);
 			}
 		}
 
-		free(pattern);
-
 		if (!ok)
-			YYABORT;
+			CLEANUP_YYABORT;
 	}
 	parse_events_terms__delete($2);
 	parse_events_terms__delete(orig_terms);
+	free($1);
 	$$ = list;
+#undef CLEANUP_YYABORT
 }
 |
 PE_KERNEL_PMU_EVENT sep_dc
 {
 	struct list_head *list;
+	int err;
 
-	if (parse_events_multi_pmu_add(_parse_state, $1, &list) < 0)
+	err = parse_events_multi_pmu_add(_parse_state, $1, &list);
+	free($1);
+	if (err < 0)
 		YYABORT;
 	$$ = list;
 }
@@ -322,6 +356,8 @@ PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
 	char pmu_name[128];
 
 	snprintf(&pmu_name, 128, "%s-%s", $1, $3);
+	free($1);
+	free($3);
 	if (parse_events_multi_pmu_add(_parse_state, pmu_name, &list) < 0)
 		YYABORT;
 	$$ = list;
@@ -338,11 +374,16 @@ value_sym '/' event_config '/'
 	struct list_head *list;
 	int type = $1 >> 16;
 	int config = $1 & 255;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config, $3));
+	err = parse_events_add_numeric(_parse_state, list, type, config, $3);
 	parse_events_terms__delete($3);
+	if (err) {
+		free_list_evsel(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
@@ -374,11 +415,19 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_e
 	struct parse_events_state *parse_state = _parse_state;
 	struct parse_events_error *error = parse_state->error;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_cache(list, &parse_state->idx, $1, $3, $5, error, $6));
+	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, $5, error, $6);
 	parse_events_terms__delete($6);
+	free($1);
+	free($3);
+	free($5);
+	if (err) {
+		free_list_evsel(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
@@ -387,11 +436,18 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT opt_event_config
 	struct parse_events_state *parse_state = _parse_state;
 	struct parse_events_error *error = parse_state->error;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_cache(list, &parse_state->idx, $1, $3, NULL, error, $4));
+	err = parse_events_add_cache(list, &parse_state->idx, $1, $3, NULL, error, $4);
 	parse_events_terms__delete($4);
+	free($1);
+	free($3);
+	if (err) {
+		free_list_evsel(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
@@ -400,11 +456,17 @@ PE_NAME_CACHE_TYPE opt_event_config
 	struct parse_events_state *parse_state = _parse_state;
 	struct parse_events_error *error = parse_state->error;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_cache(list, &parse_state->idx, $1, NULL, NULL, error, $2));
+	err = parse_events_add_cache(list, &parse_state->idx, $1, NULL, NULL, error, $2);
 	parse_events_terms__delete($2);
+	free($1);
+	if (err) {
+		free_list_evsel(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 
@@ -413,11 +475,17 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_breakpoint(list, &parse_state->idx,
-					     (void *) $2, $6, $4));
+	err = parse_events_add_breakpoint(list, &parse_state->idx,
+					(void *) $2, $6, $4);
+	free($6);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
@@ -428,8 +496,11 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_breakpoint(list, &parse_state->idx,
-					     (void *) $2, NULL, $4));
+	if (parse_events_add_breakpoint(list, &parse_state->idx,
+						(void *) $2, NULL, $4)) {
+		free(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
@@ -437,11 +508,17 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_breakpoint(list, &parse_state->idx,
-					     (void *) $2, $4, 0));
+	err = parse_events_add_breakpoint(list, &parse_state->idx,
+					(void *) $2, $4, 0);
+	free($4);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
@@ -452,8 +529,11 @@ PE_PREFIX_MEM PE_VALUE sep_dc
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_breakpoint(list, &parse_state->idx,
-					     (void *) $2, NULL, 0));
+	if (parse_events_add_breakpoint(list, &parse_state->idx,
+						(void *) $2, NULL, 0)) {
+		free(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 
@@ -463,29 +543,35 @@ tracepoint_name opt_event_config
 	struct parse_events_state *parse_state = _parse_state;
 	struct parse_events_error *error = parse_state->error;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
 	if (error)
 		error->idx = @1.first_column;
 
-	if (parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
-					error, $2))
-		return -1;
+	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
+					error, $2);
 
+	parse_events_terms__delete($2);
+	free($1.sys);
+	free($1.event);
+	if (err) {
+		free(list);
+		return -1;
+	}
 	$$ = list;
 }
 
 tracepoint_name:
 PE_NAME '-' PE_NAME ':' PE_NAME
 {
-	char sys_name[128];
 	struct tracepoint_name tracepoint;
 
-	snprintf(&sys_name, 128, "%s-%s", $1, $3);
-	tracepoint.sys = &sys_name;
+	ABORT_ON(asprintf(&tracepoint.sys, "%s-%s", $1, $3) < 0);
 	tracepoint.event = $5;
-
+	free($1);
+	free($3);
 	$$ = tracepoint;
 }
 |
@@ -500,11 +586,16 @@ event_legacy_numeric:
 PE_VALUE ':' PE_VALUE opt_event_config
 {
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4));
+	err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4);
 	parse_events_terms__delete($4);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 
@@ -512,11 +603,16 @@ event_legacy_raw:
 PE_RAW opt_event_config
 {
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2));
+	err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
 	parse_events_terms__delete($2);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 
@@ -525,22 +621,33 @@ PE_BPF_OBJECT opt_event_config
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_load_bpf(parse_state, list, $1, false, $2));
+	err = parse_events_load_bpf(parse_state, list, $1, false, $2);
 	parse_events_terms__delete($2);
+	free($1);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 |
 PE_BPF_SOURCE opt_event_config
 {
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_load_bpf(_parse_state, list, $1, true, $2));
+	err = parse_events_load_bpf(_parse_state, list, $1, true, $2);
 	parse_events_terms__delete($2);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
 	$$ = list;
 }
 
@@ -573,6 +680,10 @@ opt_pmu_config:
 start_terms: event_config
 {
 	struct parse_events_state *parse_state = _parse_state;
+	if (parse_state->terms) {
+		parse_events_terms__delete ($1);
+		YYABORT;
+	}
 	parse_state->terms = $1;
 }
 
@@ -582,7 +693,10 @@ event_config ',' event_term
 	struct list_head *head = $1;
 	struct parse_events_term *term = $3;
 
-	ABORT_ON(!head);
+	if (!head) {
+		free_term(term);
+		YYABORT;
+	}
 	list_add_tail(&term->list, head);
 	$$ = $1;
 }
@@ -603,8 +717,12 @@ PE_NAME '=' PE_NAME
 {
 	struct parse_events_term *term;
 
-	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3, &@1, &@3));
+	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $3, &@1, &@3)) {
+		free($1);
+		free($3);
+		YYABORT;
+	}
 	$$ = term;
 }
 |
@@ -612,8 +730,11 @@ PE_NAME '=' PE_VALUE
 {
 	struct parse_events_term *term;
 
-	ABORT_ON(parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3, false, &@1, &@3));
+	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $3, false, &@1, &@3)) {
+		free($1);
+		YYABORT;
+	}
 	$$ = term;
 }
 |
@@ -622,7 +743,10 @@ PE_NAME '=' PE_VALUE_SYM_HW
 	struct parse_events_term *term;
 	int config = $3 & 255;
 
-	ABORT_ON(parse_events_term__sym_hw(&term, $1, config));
+	if (parse_events_term__sym_hw(&term, $1, config)) {
+		free($1);
+		YYABORT;
+	}
 	$$ = term;
 }
 |
@@ -630,8 +754,11 @@ PE_NAME
 {
 	struct parse_events_term *term;
 
-	ABORT_ON(parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, 1, true, &@1, NULL));
+	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, 1, true, &@1, NULL)) {
+		free($1);
+		YYABORT;
+	}
 	$$ = term;
 }
 |
@@ -648,7 +775,10 @@ PE_TERM '=' PE_NAME
 {
 	struct parse_events_term *term;
 
-	ABORT_ON(parse_events_term__str(&term, (int)$1, NULL, $3, &@1, &@3));
+	if (parse_events_term__str(&term, (int)$1, NULL, $3, &@1, &@3)) {
+		free($3);
+		YYABORT;
+	}
 	$$ = term;
 }
 |
@@ -672,9 +802,13 @@ PE_NAME array '=' PE_NAME
 {
 	struct parse_events_term *term;
 
-	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $4, &@1, &@4));
-
+	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $4, &@1, &@4)) {
+		free($1);
+		free($4);
+		free($2.ranges);
+		YYABORT;
+	}
 	term->array = $2;
 	$$ = term;
 }
@@ -683,8 +817,12 @@ PE_NAME array '=' PE_VALUE
 {
 	struct parse_events_term *term;
 
-	ABORT_ON(parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $4, false, &@1, &@4));
+	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $4, false, &@1, &@4)) {
+		free($1);
+		free($2.ranges);
+		YYABORT;
+	}
 	term->array = $2;
 	$$ = term;
 }
@@ -695,8 +833,12 @@ PE_DRV_CFG_TERM
 	char *config = strdup($1);
 
 	ABORT_ON(!config);
-	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
-					config, $1, &@1, NULL));
+	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
+					config, $1, &@1, NULL)) {
+		free($1);
+		free(config);
+		YYABORT;
+	}
 	$$ = term;
 }
 
-- 
2.24.0.432.g9d3f5f5b63-goog

