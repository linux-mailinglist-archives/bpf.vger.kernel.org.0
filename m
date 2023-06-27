Return-Path: <bpf+bounces-3529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4130573F37D
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721A71C20A85
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1B31FBA;
	Tue, 27 Jun 2023 04:35:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B81FB3
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:33 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC7172E
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57003dac4a8so106053397b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840531; x=1690432531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=R/IL8Qtvta8I6gMtIPvKZfXLn9VTYmA587Tv+dTHUirDNSkyXVLPZDiit2FitWHr99
         lSTKLBRUrUspIpM71s788To4ybkNzZcGq9YzFT9kE1p7MbjjgHr9LJ82k7aqtE3GoLIq
         R46s5zrBO6zVKG+m1aJEdeDABQ9+C+Be9j3PAJCNfLhzZ70P9nZBBgtZCzLSOcQ9ELEU
         cTvehHTyprk4jPGIO/4xLBH86Fo7sqz64NRvm76MTdKX9y3ASFdsxxmyae+SpEg8JnrB
         VN4wAEtCrlRcMTDG/CNpA+q5UBt3cNAMBDDt/fbhIXmuBgKyeblyG5LJw+IlY8hPzjrR
         iFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840531; x=1690432531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=c1hgVzfPavrtdSa22HmQjAR7oB3vU+nyzl5/K7uiE2fZ7qiK1e8Mh73jVnGMAFfVer
         qNUe/Ym4DZjex8GB6iWlVMTEdrDz4icu+cGh05364KqMCB0od2yu047i3RoCa9FP/45e
         wM8zet0LDxIL6o5Vt+1EooiAgtGlnvW7sK7Jjjv1rdhR+tskhsWqC61Co1yW9YoCVp+Y
         mBFppPziEXs55SCIWewrhDH+vTo/CX+AjhXsxroQuNaOqw3hd2zLjhzMsDjtlx131rbs
         T/oeahJFJa9EmFNgJVWCBUNmTrhFZcn40LDIfTeRKuoXPJjfCm+Pwiuk1I7+9VLtIG28
         zDeA==
X-Gm-Message-State: AC+VfDz6ijJOWh/VvXzG3ZvqYs4aaM3ck6fe85YeM2DLJngmNmii8BEz
	iuLmi6CIN6jNQqHH+M55+4q/B9kIImka
X-Google-Smtp-Source: ACHHUZ6Hjnmam6yC5miKWuIWrL/VYqDWBxDrW14sUhpNBhQvwwGI3NXEDUbrFE3QZqDy02Mt5nZYzLYamadv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:a988:0:b0:568:ed75:8b2f with SMTP id
 g130-20020a81a988000000b00568ed758b2fmr14576278ywh.0.1687840531455; Mon, 26
 Jun 2023 21:35:31 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:51 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 06/13] perf parse-event: Add memory allocation test for
 name terms
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

If the name memory allocation fails then propagate to the parser.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 5 ++++-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0aa4308edb6c..f31f233e395f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1965,8 +1965,11 @@ int parse_events_name(struct list_head *list, const char *name)
 	struct evsel *evsel;
 
 	__evlist__for_each_entry(list, evsel) {
-		if (!evsel->name)
+		if (!evsel->name) {
 			evsel->name = strdup(name);
+			if (!evsel->name)
+				return -ENOMEM;
+		}
 	}
 
 	return 0;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b09a5fa92144..3ee351768433 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -263,7 +263,7 @@ PE_EVENT_NAME event_def
 	free($1);
 	if (err) {
 		free_list_evsel($2);
-		YYABORT;
+		YYNOMEM;
 	}
 	$$ = $2;
 }
-- 
2.41.0.162.gfafddb0af9-goog


