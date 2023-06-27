Return-Path: <bpf+bounces-3589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E837402F2
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D7E1C20ACD
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D61ACCC;
	Tue, 27 Jun 2023 18:11:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD821990D
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:11:00 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359510D8
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57325434999so67283487b3.1
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889458; x=1690481458;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhrU9btQvSNouRLprL5042Ez2uv0eRQsGm9r0lF36Cc=;
        b=zKLf44jyj+39w0a+bqNc2dgv2dREdGSzeZe+HP7YGWzKAptuBUBeZ3HLubfQN8ktPU
         J/hVxrzpmJEmMjxDDA9hWXUMzGcGE88LvOStfYcQ73rvV3KcYSj4TpSDt+CfNC3o/MDo
         K2iNVrUgK79UQZCfMhBpEczFI7xMJ2cAOvmILBvuaZruCBVWk5uTuRzPtbVK5ofATVTi
         q0Sr4j/plwsl+/pQMnChcyl8ujz1LD6ZCyUY6kBfmtDsM3zvtQaL7hGNpdcCriEo8EY5
         Gd0m4In8QsXo2VAV5mtg9f1sdi/vJeRaLPGQ2ndAFHfF5X0FFUit8aymAZ29aNcjUIjA
         asDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889458; x=1690481458;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhrU9btQvSNouRLprL5042Ez2uv0eRQsGm9r0lF36Cc=;
        b=EwKAx8Ee4rzj1EoqpaiyVUBlkF29B+OB2rJ1LVYedYI68YZm2RNsYgn6NGXFZF0W1f
         n+i9H1bbIc1fDYXwRILEOEKRWVDVy2RnoPY2Eo00ONNdYY1L3gYW4OYOYQDlLnXnM7nl
         ovLFvi/AtsDy2WE0r+p89h6dADMpWsPDyaAc4Y2J5NtNVxBal6fDQkTqY6ZqfcN2wNIQ
         AxzCypXhDHOmAbhjejsgKVQEGDFA8hnoaWpfys4lBAnl2lhmHLMmjX5f9IeGaKQTlva9
         oJohJdDPFkd18kddL7/SDKT7OuCMSXgpheE5z4DXbnpOjdihpWmg8C3IiJTrfQyJvKy2
         Okxw==
X-Gm-Message-State: AC+VfDzoTlSkzg7Jaw/urXgPC3ybE37ahmnVT+gPx2nM/hVo2cruP/0f
	uYIVU2/X/zN7U7tY8eWHNET3OJAS4Ijq
X-Google-Smtp-Source: ACHHUZ4uaQfEAiZp9PqQDuN7pzOeygiYoEJNc87GGRVD0DwY9bbSmv0eS8WjGE+vlBe01swDXklrQzCsdz5u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a81:b710:0:b0:565:9f59:664f with SMTP id
 v16-20020a81b710000000b005659f59664fmr14322906ywh.6.1687889457830; Tue, 27
 Jun 2023 11:10:57 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:24 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 07/13] perf parse-events: Separate YYABORT and YYNOMEM cases
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

Split cases in event_pmu for greater accuracy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 45 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 3ee351768433..d22866b97b76 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -283,37 +283,42 @@ event_pmu:
 PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
 	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
+	struct parse_events_error *error = parse_state->error;
 	char *pattern = NULL;
 
-#define CLEANUP_YYABORT					\
+#define CLEANUP						\
 	do {						\
 		parse_events_terms__delete($2);		\
 		parse_events_terms__delete(orig_terms);	\
 		free(list);				\
 		free($1);				\
 		free(pattern);				\
-		YYABORT;				\
 	} while(0)
 
-	if (parse_events_copy_term_list($2, &orig_terms))
-		CLEANUP_YYABORT;
-
 	if (error)
 		error->idx = @1.first_column;
 
+	if (parse_events_copy_term_list($2, &orig_terms)) {
+		CLEANUP;
+		YYNOMEM;
+	}
+
 	list = alloc_list();
-	if (!list)
-		CLEANUP_YYABORT;
+	if (!list) {
+		CLEANUP;
+		YYNOMEM;
+	}
 	/* Attempt to add to list assuming $1 is a PMU name. */
 	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
 		/* Failure to add, try wildcard expansion of $1 as a PMU name. */
-		if (asprintf(&pattern, "%s*", $1) < 0)
-			CLEANUP_YYABORT;
+		if (asprintf(&pattern, "%s*", $1) < 0) {
+			CLEANUP;
+			YYNOMEM;
+		}
 
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 			char *name = pmu->name;
@@ -328,8 +333,10 @@ PE_NAME opt_pmu_config
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
-				if (parse_events_copy_term_list(orig_terms, &terms))
-					CLEANUP_YYABORT;
+				if (parse_events_copy_term_list(orig_terms, &terms)) {
+					CLEANUP;
+					YYNOMEM;
+				}
 				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
 							  auto_merge_stats)) {
 					ok++;
@@ -345,15 +352,15 @@ PE_NAME opt_pmu_config
 			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list);
 			$2 = NULL;
 		}
-		if (!ok)
-			CLEANUP_YYABORT;
+		if (!ok) {
+			CLEANUP;
+			YYABORT;
+		}
 	}
-	parse_events_terms__delete($2);
-	parse_events_terms__delete(orig_terms);
-	free(pattern);
-	free($1);
 	$$ = list;
-#undef CLEANUP_YYABORT
+	list = NULL;
+	CLEANUP;
+#undef CLEANUP
 }
 |
 PE_NAME sep_dc
-- 
2.41.0.162.gfafddb0af9-goog


