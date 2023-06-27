Return-Path: <bpf+bounces-3525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6073F372
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE9A280FCA
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D00C1111;
	Tue, 27 Jun 2023 04:35:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4B10EF
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:24 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F33A171A
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bf34588085bso5545703276.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840523; x=1690432523;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWCGE0gvk+pE+CmFQOT3NcABG9fSPb9UJ3AYuKosiSs=;
        b=2Jn/3eS5PxyyQnamzxRI6RjMyYVpdcyI00HwvxuiINbYigj65DQNk54DcCPLXQ1CkL
         aV5hbe0G9kzAJK7q/rrehTSfNKBA9solwsuMX0Yc8FbWiUsTMYFtYSedqBBbkIZCvfEk
         /qb3ehecptdg8oawr/mUOjF20uwONq3gmzUUUKhoOVlWpw8qa0sHY1gBylF9cAG+zUrF
         PPszeHwdWspAQfcuki0tedenET8k/rV4nu42V/Nd26FThAHozlDydfIZ0UEEu035u/Eg
         +DMxVeSRShN3AUXP88ruhaabmjc7GSiyeEtIzE1sMAO4CO0ClLIy254CrCo5bdoim9yc
         gaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840523; x=1690432523;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWCGE0gvk+pE+CmFQOT3NcABG9fSPb9UJ3AYuKosiSs=;
        b=Fwoat5A5oc8R6YiDJ59oTK+s5hYRLyxvQ+OVEZHX44kAZ+qV8YWTTbTJ9k1SRJaSaI
         Tatuiqq+EegVD/u+G5nMmPRZsMRVDwRZpkDJZZwSyPqGLUEQCIIL17cXiTP3Vv2pBcq+
         rNgpP8y5HhJu0uPHr9mj10R66Kb1Xe6GXYikjNKMs5r6gq5LFMry+yFA0omtvCgXHIYJ
         667VlW04thgyAh1XFw8D94fRgsKWqERtJgeG0GyU1vlgpiixYBlkx+oLRlbPYX6jz3TC
         nxeL9tz55KEPl9NWWLRxaluFoL2f2soA0kk11rMNUVlcYxQkM6cDKKfkjo7EIoQLjq+l
         i7NA==
X-Gm-Message-State: AC+VfDx97XTGlJKnoLkZyxD6sHe50HNDkdmkkhM1Q4JGtt/qITuq3JHS
	qUMpznJd2lCwqCWescwc4WlpB2ybpNt5
X-Google-Smtp-Source: ACHHUZ5L4BiUBOJjf+avwMOmOIAytu8fXGtgMaH/uVfAhmb9Gx/TXTrJF2s+gprOCKEnxgaJ5h3D6CV9M6vT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:ae22:0:b0:bc0:bfa7:7647 with SMTP id
 a34-20020a25ae22000000b00bc0bfa77647mr13096016ybj.0.1687840522861; Mon, 26
 Jun 2023 21:35:22 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:47 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 02/13] perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
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
 tools/perf/util/parse-events.y | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 64755f9cd600..4ee6c6865655 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -63,7 +63,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_KERNEL_PMU_EVENT
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
@@ -81,7 +80,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_KERNEL_PMU_EVENT
 %type <str> PE_DRV_CFG_TERM
 %type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
@@ -358,18 +356,6 @@ PE_NAME opt_pmu_config
 #undef CLEANUP_YYABORT
 }
 |
-PE_KERNEL_PMU_EVENT sep_dc
-{
-	struct list_head *list;
-	int err;
-
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
-|
 PE_NAME sep_dc
 {
 	struct list_head *list;
@@ -381,19 +367,6 @@ PE_NAME sep_dc
 		YYABORT;
 	$$ = list;
 }
-|
-PE_KERNEL_PMU_EVENT opt_pmu_config
-{
-	struct list_head *list;
-	int err;
-
-	/* frees $2 */
-	err = parse_events_multi_pmu_add(_parse_state, $1, $2, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
 
 value_sym:
 PE_VALUE_SYM_HW
-- 
2.41.0.162.gfafddb0af9-goog


