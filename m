Return-Path: <bpf+bounces-3583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34EB7402DF
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7835728113B
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B3E1ACA2;
	Tue, 27 Jun 2023 18:10:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991C19BB9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:10:48 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9502D48
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb0d11a56abso5275746276.2
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889444; x=1690481444;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRovkRSYzzjqItxtlGi5Ku78WYBIH4P5/AOwfUisZaE=;
        b=mktcZKTvm+CfN0JW4AvDl8oygIn6bzPzZawPM5hdf+WJkmtuRsNrICW/opE8vUBxgd
         1a/EXVix8Ulb+ogBvqfInmdkMyBRlTtNG29j5TGLMHe3TE1xBOfDz4jiLjnMpKCLQkzN
         Wq69og/SBsSy9Xn0T9aOYTUnKIgxmZE0C99UIvMeQUGYpvviUYa0MDmrKJXQ4a4ryyw9
         sLGm/ZGKb3ivDzc4I8IidumsiP7Z/MR3f/JRGsLVgQlIUGyM40O4Ylmiw7rTYqwtmuJO
         KwbKhwgbNE3ZepJZRXcU3QFNm6IbDFOKa5fixWHcVATfWTzK4ngnn0zKRU0Ct59z60Fl
         JWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889444; x=1690481444;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRovkRSYzzjqItxtlGi5Ku78WYBIH4P5/AOwfUisZaE=;
        b=Sx1NmZ6O/NN1x22FlkxvwWvelwE+mFV5r8T5wxHhZYFcbje323EzeEKA8ln+zuiBsV
         ey4LSDqawiYwG6cXDHpU+2D4YIrJxYN9LHBDxA/U7BQR7EHPtSfcfJFF0dAEkZnCQqaD
         3CN+DnMIugNH6ZKHcp5ZBw0SWD007lk4XJjBhCqegUrlqXafPSdG91T7NBLkjfdyeLmx
         X0oNsrkc8hln+Qu3jG6VOE+iaGoLB1x/ZojZHBXjeX5lc+jkAlrh67ygewgdfznMu/UL
         NObPADHyetOen+5fslUyLnQqwM8XUk2aZXy3X9ZtrGmP53d5SScTnHGllIoeMTBMOOEi
         6/eA==
X-Gm-Message-State: AC+VfDwMpPtQAcRXBXepiseml+8RudCJN/ODClIEedTD6LZL5WriV6ne
	W8GGAPbEXJTJpY5O0AYtob6oP1BqLIQP
X-Google-Smtp-Source: ACHHUZ4dCuXkazspQAeZywR+p2lXLl1x/iMDL5zaSkGcydnwubuqOiZR2nx8V7EWC/UfGvGDnGGBsylcGjVi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a25:ce8e:0:b0:ba8:4ff5:4671 with SMTP id
 x136-20020a25ce8e000000b00ba84ff54671mr14764241ybe.9.1687889443701; Tue, 27
 Jun 2023 11:10:43 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:18 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 01/13] perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
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


