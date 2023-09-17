Return-Path: <bpf+bounces-10228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CAF7A3937
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 21:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E81C20BD9
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E95F6FDD;
	Sun, 17 Sep 2023 19:46:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC56FC9;
	Sun, 17 Sep 2023 19:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36446C433C7;
	Sun, 17 Sep 2023 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1694980014;
	bh=UI1ANk2y2ql1ag9FNhRzwC521dcZPt3dRpUeo0hw6jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnRTikx3B7QKktFsdLhxrzTzwq4Qs/jUmjmg2zJ4zulxhg9ptaWhtuJta4zjVy08b
	 zpSPNWhovo8Xvl0Fg4NSw3tAAVeuvsLmHSgFOl5Wl53LK2f7pz0dXny8lkcbV3wcjX
	 0fw58DoOXRmPdBn1CuS0wqVw+OuKZ2skwZo7yWVM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 073/285] perf parse-events: Separate ENOMEM memory handling
Date: Sun, 17 Sep 2023 21:11:13 +0200
Message-ID: <20230917191054.242299866@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit b52cb995f1a559bc6e1a7cdc0ed0375503528541 ]

Add PE_ABORT that will YYNOMEM or YYABORT accordingly.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230627181030.95608-10-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: b30d4f0b6954 ("perf parse-events: Additional error reporting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 134 ++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 52 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 78c1f49d8d7e4..24274c6cf85f1 100644
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
@@ -385,7 +392,7 @@ PE_NAME sep_dc
 	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
 	free($1);
 	if (err < 0)
-		YYABORT;
+		PE_ABORT(err);
 	$$ = list;
 }
 |
@@ -461,7 +468,7 @@ value_sym '/' event_config '/'
 	parse_events_terms__delete($3);
 	if (err) {
 		free_list_evsel(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -472,23 +479,28 @@ value_sym sep_slash_slash_dc
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
 
@@ -509,7 +521,7 @@ PE_LEGACY_CACHE opt_event_config
 	free($1);
 	if (err) {
 		free_list_evsel(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -530,7 +542,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	free($6);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -549,7 +561,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	parse_events_terms__delete($5);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -569,7 +581,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	free($4);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -587,7 +599,7 @@ PE_PREFIX_MEM PE_VALUE opt_event_config
 	parse_events_terms__delete($3);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -614,7 +626,7 @@ tracepoint_name opt_event_config
 	free($1.event);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -641,7 +653,7 @@ PE_VALUE ':' PE_VALUE opt_event_config
 	parse_events_terms__delete($4);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -665,7 +677,7 @@ PE_RAW opt_event_config
 	parse_events_terms__delete($2);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -685,7 +697,7 @@ PE_BPF_OBJECT opt_event_config
 	free($1);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -702,7 +714,7 @@ PE_BPF_SOURCE opt_event_config
 	parse_events_terms__delete($2);
 	if (err) {
 		free(list);
-		YYABORT;
+		PE_ABORT(err);
 	}
 	$$ = list;
 }
@@ -777,11 +789,12 @@ event_term:
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
@@ -789,12 +802,12 @@ PE_RAW
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
@@ -802,11 +815,12 @@ name_or_raw '=' name_or_legacy
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
@@ -814,12 +828,13 @@ name_or_raw '=' PE_VALUE
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
@@ -827,11 +842,12 @@ name_or_raw '=' PE_TERM_HW
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
@@ -839,11 +855,12 @@ PE_LEGACY_CACHE
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
@@ -851,11 +868,12 @@ PE_NAME
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
@@ -863,10 +881,11 @@ PE_TERM_HW
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
@@ -874,10 +893,11 @@ PE_TERM '=' name_or_legacy
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
@@ -885,37 +905,46 @@ PE_TERM '=' PE_TERM_HW
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
@@ -924,12 +953,12 @@ name_or_raw array '=' name_or_legacy
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
@@ -939,14 +968,15 @@ PE_DRV_CFG_TERM
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
2.40.1




