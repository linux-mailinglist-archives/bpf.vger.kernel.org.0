Return-Path: <bpf+bounces-3591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC5B7402F5
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D8C1C20A4F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AAA1ACD5;
	Tue, 27 Jun 2023 18:11:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6A1308B
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:11:05 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E1110C9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:11:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c0f35579901so5393265276.0
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889462; x=1690481462;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Y44TOA7IP5InT6TRlpHuOEgaV2HfkPV6BhBGubei/8=;
        b=c9gurYrQqRSFvo7zJ8m414du8P7eJ9NkSzT6aLXKB4BfMI5WawStXka9WiRq5JOw/v
         oWqKg0C7YBaR/KnfK3/kJLT2e5oOiWG8IJcE5OvD3w0UcHc+tQLB/MgoG3l3XRfNonyz
         Q6m5AUjEjI7GgkUeVjIBIdy9xOOJa2vINIxBQ71BK6X4BpMC8236R9alITgBf+5A105M
         eSxP1no+WzzdpjnS3uxuZlGFHkye//BZTsa6vkU1p2zsWrnznmfNncam/YJle49naEk4
         FNAXi2ur3RVloIqgfmIae+74ELhIPp53/EQ66tT5z3/0JSjRef+MZQqcj82/9xG6R7h8
         ZHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889462; x=1690481462;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y44TOA7IP5InT6TRlpHuOEgaV2HfkPV6BhBGubei/8=;
        b=I9v93j+zq+ZN5ti3JNNUJklV28BE16yphP+yA27sZ2ARTgBqa3snNJvec4lj11kHz9
         /uK3Dc+oQQtvi1L/ZmDWBA++nq8/oUWzj/sfkao7xE2qT5aLARVf3SolMD0SX6COam/L
         uvnf8NJ2331JOb4W9Y9We0GOkxtZXyT/QSQgyOauPxJ/grqMjbxSnpaZ7RwkJARW1fMl
         CtOyWoKKMAnYQxcrh51r8QmFHMdX69wMoj3hcTh59m90Tru6omZYreRPKOeoi6ApKgRy
         HXRRy/TWE1SMLwoUiofRAZYaUdbVxxerG5kn92SUqRsBZcJ+22OWypQGVKB/cCVAAmg0
         fZUg==
X-Gm-Message-State: AC+VfDwVxONvuhw/PVTkSc8KolW0cQ3NAC7gYF9xJcy5DRhxBKtRbu0Q
	/QXbsSbN9WMVH+B/9VQTXWvkAZlBAG+P
X-Google-Smtp-Source: ACHHUZ45eWIOcww9XvJdH9Wpn9yaGfgwtvCYiA4KW5mMlaVQdVSQEelhhiHH1vPrJCsS/CFFJGoTZsCrIf9p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a25:2144:0:b0:be4:7214:7aef with SMTP id
 h65-20020a252144000000b00be472147aefmr14974748ybh.10.1687889462624; Tue, 27
 Jun 2023 11:11:02 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:26 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 09/13] perf parse-events: Separate ENOMEM memory handling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add PE_ABORT that will YYNOMEM or YYABORT accordingly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 134 ++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 52 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index eaf43bd8fe3f..f090a85c4518 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -28,6 +28,13 @@ do { \
 		YYABORT; \
 } while (0)
 
+#define PE_ABORT(val) \
+do { \
+	if (val == -ENOMEM) \
+		YYNOMEM; \
+	YYABORT; \
+} while (0)
+
 static struct list_head* alloc_list(void)
 {
 	struct list_head *list;
@@ -371,7 +378,7 @@ PE_NAME sep_dc
 	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
 	free($1);
 	if (err < 0)
-		YYABORT;
+		PE_ABORT(err);
 	$$ = list;
 }
 
@@ -396,7 +403,7 @@ value_sym '/' event_config '/'
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -407,23 +414,28 @@ value_sym sep_slash_slash_dc
 	int type = $1 >> 16;
 	int config = $1 & 255;
 	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
+	int err;
 
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config,
-					  /*head_config=*/NULL, wildcard));
+	err = parse_events_add_numeric(_parse_state, list, type, config, /*head_config=*/NULL, wildcard);
+	if (err)
+		PE_ABORT(err);
 	$$ = list;
 }
 |
 PE_VALUE_SYM_TOOL sep_slash_slash_dc
 {
 	struct list_head *list;
+	int err;
 
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	ABORT_ON(parse_events_add_tool(_parse_state, list, $1));
+	err = parse_events_add_tool(_parse_state, list, $1);
+	if (err)
+		YYNOMEM;
 	$$ = list;
 }
 
@@ -444,7 +456,7 @@ PE_LEGACY_CACHE opt_event_config
 	free($1);
 	if (err) {
 		free_list_evsel(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -465,7 +477,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	free($6);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -484,7 +496,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	parse_events_terms__delete($5);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -504,7 +516,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	free($4);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -522,7 +534,7 @@ PE_PREFIX_MEM PE_VALUE opt_event_config
 	parse_events_terms__delete($3);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -549,7 +561,7 @@ tracepoint_name opt_event_config
 	free($1.event);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -576,7 +588,7 @@ PE_VALUE ':' PE_VALUE opt_event_config
 	parse_events_terms__delete($4);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -600,7 +612,7 @@ PE_RAW opt_event_config
 	parse_events_terms__delete($2);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -620,7 +632,7 @@ PE_BPF_OBJECT opt_event_config
 	free($1);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -637,7 +649,7 @@ PE_BPF_SOURCE opt_event_config
 	parse_events_terms__delete($2);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -712,11 +724,12 @@ event_term:
 PE_RAW
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_RAW,
+					 strdup("raw"), $1, &@1, &@1);
 
-	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_RAW,
-					strdup("raw"), $1, &@1, &@1)) {
+	if (err) {
 		free($1);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -724,12 +737,12 @@ PE_RAW
 name_or_raw '=' name_or_legacy
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER, $1, $3, &@1, &@3);
 
-	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3, &@1, &@3)) {
+	if (err) {
 		free($1);
 		free($3);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -737,11 +750,12 @@ name_or_raw '=' name_or_legacy
 name_or_raw '=' PE_VALUE
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					 $1, $3, false, &@1, &@3);
 
-	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3, false, &@1, &@3)) {
+	if (err) {
 		free($1);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -749,12 +763,13 @@ name_or_raw '=' PE_VALUE
 name_or_raw '=' PE_TERM_HW
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					 $1, $3.str, &@1, &@3);
 
-	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3.str, &@1, &@3)) {
+	if (err) {
 		free($1);
 		free($3.str);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -762,11 +777,12 @@ name_or_raw '=' PE_TERM_HW
 PE_LEGACY_CACHE
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
+					 $1, 1, true, &@1, NULL);
 
-	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
-					$1, 1, true, &@1, NULL)) {
+	if (err) {
 		free($1);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -774,11 +790,12 @@ PE_LEGACY_CACHE
 PE_NAME
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					 $1, 1, true, &@1, NULL);
 
-	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, 1, true, &@1, NULL)) {
+	if (err) {
 		free($1);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -786,11 +803,12 @@ PE_NAME
 PE_TERM_HW
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_HARDWARE,
+					 $1.str, $1.num & 255, false, &@1, NULL);
 
-	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_HARDWARE,
-				   $1.str, $1.num & 255, false, &@1, NULL)) {
+	if (err) {
 		free($1.str);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -798,10 +816,11 @@ PE_TERM_HW
 PE_TERM '=' name_or_legacy
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__str(&term, (int)$1, NULL, $3, &@1, &@3);
 
-	if (parse_events_term__str(&term, (int)$1, NULL, $3, &@1, &@3)) {
+	if (err) {
 		free($3);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -809,10 +828,11 @@ PE_TERM '=' name_or_legacy
 PE_TERM '=' PE_TERM_HW
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__str(&term, (int)$1, NULL, $3.str, &@1, &@3);
 
-	if (parse_events_term__str(&term, (int)$1, NULL, $3.str, &@1, &@3)) {
+	if (err) {
 		free($3.str);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
@@ -820,37 +840,46 @@ PE_TERM '=' PE_TERM_HW
 PE_TERM '=' PE_TERM
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__term(&term, (int)$1, (int)$3, &@1, &@3);
+
+	if (err)
+		PE_ABORT(err);
 
-	ABORT_ON(parse_events_term__term(&term, (int)$1, (int)$3, &@1, &@3));
 	$$ = term;
 }
 |
 PE_TERM '=' PE_VALUE
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__num(&term, (int)$1, NULL, $3, false, &@1, &@3);
+
+	if (err)
+		PE_ABORT(err);
 
-	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, $3, false, &@1, &@3));
 	$$ = term;
 }
 |
 PE_TERM
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__num(&term, (int)$1, NULL, 1, true, &@1, NULL);
+
+	if (err)
+		PE_ABORT(err);
 
-	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, 1, true, &@1, NULL));
 	$$ = term;
 }
 |
 name_or_raw array '=' name_or_legacy
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER, $1, $4, &@1, &@4);
 
-	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $4, &@1, &@4)) {
+	if (err) {
 		free($1);
 		free($4);
 		free($2.ranges);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	term->array = $2;
 	$$ = term;
@@ -859,12 +888,12 @@ name_or_raw array '=' name_or_legacy
 name_or_raw array '=' PE_VALUE
 {
 	struct parse_events_term *term;
+	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER, $1, $4, false, &@1, &@4);
 
-	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $4, false, &@1, &@4)) {
+	if (err) {
 		free($1);
 		free($2.ranges);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	term->array = $2;
 	$$ = term;
@@ -874,14 +903,15 @@ PE_DRV_CFG_TERM
 {
 	struct parse_events_term *term;
 	char *config = strdup($1);
+	int err;
 
 	if (!config)
 		YYNOMEM;
-	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
-					config, $1, &@1, NULL)) {
+	err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG, config, $1, &@1, NULL);
+	if (err) {
 		free($1);
 		free(config);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = term;
 }
-- 
2.41.0.162.gfafddb0af9-goog


