Return-Path: <bpf+bounces-15122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937E17ECCC0
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 20:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5599A2810BA
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7DD41223;
	Wed, 15 Nov 2023 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4KpT/be"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05341A81;
	Wed, 15 Nov 2023 19:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D8BC433C7;
	Wed, 15 Nov 2023 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700076741;
	bh=rAsmqsTaQIAgAUi/vKnMBZhkAEWhtoD02GWkqmUksj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4KpT/beXeJLGNQXs/g4gmKq1TtmgyMbxx8Q+3lenAxvQnVJaDlLXklxuoQDn+pd9
	 CWiRMSWqW8yDNoxMqqTNyMMXZLLVT+9hrXfbJHO8Dq0+xmql9J90yvBDhJAYsENM9a
	 j2rde08plZnAuR0sfFWTE0tGVkRaYIiWLqPOQKmI=
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
Subject: [PATCH 6.5 387/550] perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
Date: Wed, 15 Nov 2023 14:16:11 -0500
Message-ID: <20231115191627.668324833@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

[ Upstream commit 84efbdb7fb8e0844a3f9c67a6bdcc89db1012e1c ]

Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
PMUs before parsing").

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
Link: https://lore.kernel.org/r/20230627181030.95608-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: ede72dca45b1 ("perf parse-events: Fix tracepoint name memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 42 ++--------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index c590cf7f02a45..43557f20d0989 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -70,7 +70,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%token PE_KERNEL_PMU_EVENT
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
@@ -88,7 +88,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%type <str> PE_KERNEL_PMU_EVENT
 %type <str> PE_DRV_CFG_TERM
 %type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
@@ -421,44 +421,6 @@ PE_KERNEL_PMU_EVENT opt_pmu_config
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
2.42.0




