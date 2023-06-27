Return-Path: <bpf+bounces-3524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5108A73F371
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633481C20A87
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6510F9;
	Tue, 27 Jun 2023 04:35:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6110EF
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:22 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333E1716
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56938733c13so52791597b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840520; x=1690432520;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRovkRSYzzjqItxtlGi5Ku78WYBIH4P5/AOwfUisZaE=;
        b=y7XhmE6qt1wChXjoDS+amZuWN+3tzf72jlmLxYvuJ85fONhTQPUIb/F+mszvVP069K
         RYCJ6hp9Yn1ZbUDyTRc/BasJ06VeZkEb/64XvzUxBFQSqn2nOUzey0B11GQ6pt88MDq1
         iWkPGM4lVO3ItKcsgzX6wKjz66an+RwYxpMp+4wySxFgY4pgpyfHsbr5+N+AxlNyygEM
         wDz0YkNfXg6oPie74s4LC/3PxiSj+htPxLiPMiUwYbAV2l9wcAHOr43JQAqIwOz4SmwA
         bvmpEZYkoFxOxg0FibSun4dRq7PpyEsXscRED19dPk/sht5NHf/2tcmCohIkmQKgkWkU
         1Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840520; x=1690432520;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRovkRSYzzjqItxtlGi5Ku78WYBIH4P5/AOwfUisZaE=;
        b=YlgQdqUjU+tkR7sEUCLP2GzyM4AJSz/4O9rrv++zWDNsMWl6YxdKC02jahd06XBV+y
         nqV+NMSM5bZdac1QAF1TWcyiebJJbNK7uQbeIx9YI99XrDfqDPo3p3EKiHpNEgrMmyZ6
         C9lC4t9RSJHb0q2nRdvAZXnhXJes7rNl8Y6Suoza4TW/h5s6yRzEdaz30EpdKLN0ZrBQ
         rVw0PCz9YIiLKORbobaDohmWAY498tlR8aM2l++wQuTEMSfuVewCREaJA2Tf5MlrwrcQ
         rVYmlAqEHKYn5TsUP+e/t1KTq/KTLuanXfd59v1sZ9/4m3zu+tWGfjz7yzFQDVRao7+r
         XyNg==
X-Gm-Message-State: AC+VfDxZfbaBjRVapZ5/g9roCKR8hnbAaamMFsR9oCqW327N5IpZlWq2
	gaJBL+weG3gXQi9R4D6e806256udEC5D
X-Google-Smtp-Source: ACHHUZ5adrH9QxrfVpGnVbiCFm0ZVbLk8evGNPERtoi+luU3p2+mWKg7qpZ0o1EVh6dmty6SQXsFqvRcHw2H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:b647:0:b0:56c:f8b7:d4fa with SMTP id
 h7-20020a81b647000000b0056cf8b7d4famr12901202ywk.7.1687840520655; Mon, 26 Jun
 2023 21:35:20 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:46 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 01/13] perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
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

Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
PMUs before parsing").

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 42 ++--------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 9f28d4b5502f..64755f9cd600 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -63,7 +63,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%token PE_KERNEL_PMU_EVENT
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
@@ -81,7 +81,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%type <str> PE_KERNEL_PMU_EVENT
 %type <str> PE_DRV_CFG_TERM
 %type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
@@ -394,44 +394,6 @@ PE_KERNEL_PMU_EVENT opt_pmu_config
 		YYABORT;
 	$$ = list;
 }
-|
-PE_PMU_EVENT_FAKE sep_dc
-{
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYABORT;
-
-	err = parse_events_add_pmu(_parse_state, list, $1, /*head_config=*/NULL,
-				   /*auto_merge_stats=*/false);
-	free($1);
-	if (err < 0) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_PMU_EVENT_FAKE opt_pmu_config
-{
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYABORT;
-
-	err = parse_events_add_pmu(_parse_state, list, $1, $2, /*auto_merge_stats=*/false);
-	free($1);
-	parse_events_terms__delete($2);
-	if (err < 0) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
 
 value_sym:
 PE_VALUE_SYM_HW
-- 
2.41.0.162.gfafddb0af9-goog


