Return-Path: <bpf+bounces-3584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1CC7402E1
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629FD1C209CE
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A971ACAD;
	Tue, 27 Jun 2023 18:10:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445DE19BB9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:10:50 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7743EE71
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:46 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-66872889417so2058274b3a.1
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889446; x=1690481446;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWCGE0gvk+pE+CmFQOT3NcABG9fSPb9UJ3AYuKosiSs=;
        b=U3tszF3iEnPlISAxvRgLQh2yAsfBXVo/Q6PsnR8CoF2tEFqxSBVSBaD/G6Pm6Cajnz
         aQ4XGOH4k9El84pkqkaI76GE6uJ3psK5/29cFwc9AT9tJ0m8tAFK7+Xup/A2reI81n96
         wPh32LcU2PSJ38NBnw3EifrTE5J7lYjzK/tvFFhsSwTOJh0hR8p061/PfLA9EeiBrAWn
         f3YBVRP3D9stcaMoLY8zd/yQdE/4vZRNkOGfqG4A8hU+Wzhq9+shpWzmiAmwTJntc0h3
         q9sKKT8u+w0OgGX1a2RMJvyThaU3d8/esnfAlURWDJq4i0smQ24u6vUoVwrace9wRXjl
         oqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889446; x=1690481446;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWCGE0gvk+pE+CmFQOT3NcABG9fSPb9UJ3AYuKosiSs=;
        b=Zatq1EaHHUVk3Ko9ZlBznB5wvOZlLPcLgDgjMV5weoT1SUWyz+cIAl2RIIz8pW1kvn
         sH36hgtwu1USHMyeKQPtZ5IauBUJVdTUyXlwAx2QpRgJN5YbAK4lhrBvGr48o+3TnBVq
         FvhKAU6eRbhVAR5W7VJsD26kwDHm4CX+/SQ/Cpd1zYK7lF4z/4CTyc5eZVDugXBTiAyI
         c8gUzSTqVToV0KJxij7F5aETnUgojgVH2i1UB5zJ0iAbSeBWDgGWb/5t0r3ykWZecwwT
         UFCEhdRehIM4vqoq0JGTaZK4ZdK6/FSq1cpgbs/GaRlw/pSU6fDE+TdKtgGxXnGFeBzj
         nbzA==
X-Gm-Message-State: AC+VfDwBmjKCI9vxoPMEb/bHXlNQ2wfbjf3lVHG22O9xl8VWVFbd3ra/
	ZaTierbhGTODY3xiqMkw5WIJrDMaOO9M
X-Google-Smtp-Source: ACHHUZ7eXpeYFLZxfraqt2sq94LXekMZYj8K3lgYRHv1M1aPEVN24PTbJvBtf5w1JuRlH1u8acu24npK7HSM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1504:b0:668:7377:1fe3 with SMTP
 id q4-20020a056a00150400b0066873771fe3mr7745734pfu.2.1687889446028; Tue, 27
 Jun 2023 11:10:46 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:19 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 02/13] perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
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


