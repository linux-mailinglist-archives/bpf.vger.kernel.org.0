Return-Path: <bpf+bounces-3530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E721E73F37F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FAA280FE2
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F97D20F3;
	Tue, 27 Jun 2023 04:35:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150861FB3
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:36 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAE1991
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bfae0f532e4so5228763276.2
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840533; x=1690432533;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhrU9btQvSNouRLprL5042Ez2uv0eRQsGm9r0lF36Cc=;
        b=UQgWuOSPjS4w1rMPsL0J/CZjVxaM/VUd+1pMFZNBzn0srRWPnx6bPhMtbf8eXBRbh/
         AL9/KVrzAglwaIm9UyGn0hx5al4bFrYf648fJlvsQYy7tSCvxKkzs/jQI/PY61IhD1ZH
         HQsGAv5dEupLTRjuzrzDSHz27+sqoOw9LCj/u0pbyseP19a40j65KX273BseEjhA7m1w
         K2adIf2Sn5bqewB9+HvFGrA55bfsokDWkEiED5YYmKVIz1RUosPzH9OEYVRJpabz98wc
         /gYpeH37GGYxkOUD5OXEwXhpU3xbG5eNhim72EIO70e9Vib4Q+EEKuMgZiDWlAqGNFog
         YBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840533; x=1690432533;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhrU9btQvSNouRLprL5042Ez2uv0eRQsGm9r0lF36Cc=;
        b=L+wfTzFxuMAbn5PI8Mt96P8hCGVfrHe2KrYL0UqHJwQOOMvUuQw0m9jJo9eRNlxLkQ
         GKB+Tj48rvs9t4LGOaKAkGKw1/62mg6xDfTZ+l3t82vRo3yCz88GS+5KxK01jWKB9tOk
         DyZTJk8uz00n108bcYLxrC3P9c2O4kqFTCtoVwmOwsCCxyIYibiM0aUg1UORodvBs1zQ
         4a1oSZNcdKnEia9wovM1dTgudeh4tjBErhPkUqH49xqVwJwRshFMLitW2usRbAv+KF9V
         aUoVP6Bx4D1QkfS+sZhTpOEzVoK/P0BcEQCuMu5WwpjfTTJgyiIEXEdDg7gyDN+fTupW
         j2SQ==
X-Gm-Message-State: AC+VfDw/QBjDxBqo+3v0sg2Hb04baQgzlPoxjiL1TOSHGbsSkiDlIN9n
	o4lFWjDzRgdEgklc0at8jSD9GWbrFGCZ
X-Google-Smtp-Source: ACHHUZ4Ghj6Dv7mjes+yNMKxzWLRWCXGOog1H3oKSZhjBK6PXWZIIT3wWM6SDMMYOhNAb9o8tWvHSytjFt0e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:6988:0:b0:c1d:4fce:460 with SMTP id
 e130-20020a256988000000b00c1d4fce0460mr2290320ybc.4.1687840533748; Mon, 26
 Jun 2023 21:35:33 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:52 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 07/13] perf parse-events: Separate YYABORT and YYNOMEM cases
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
	autolearn=unavailable autolearn_force=no version=3.4.6
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


