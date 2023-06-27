Return-Path: <bpf+bounces-3588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF87402E9
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C240D281134
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D41ACC4;
	Tue, 27 Jun 2023 18:10:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C171990D
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:10:58 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA992976
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565d1b86a64so52610077b3.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889455; x=1690481455;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=fJ/k7mucYzBMSvs1vvV15ie93EM0pdSvxSUdAibrdcK8Xlo3QJke/WMQV3YHip6PPd
         L8Cd8nJEThKRdGQ2VTW41re3ZnkIycotbObtvgaoqLFhCNpiEFkiQeN6l4fYZ7prWdt8
         uV5Shhvouyj7E1gCloG+G40JhxYFGkEvI2ecrkyEtmkLXzoh1msQmywG5djMLzyl75C7
         /Ru0IM92CtF1HiniTaMAMp+6bztbSXOudj3AHphKfyuYYcYl2qIEmt4G88gKrzzlHNTS
         6DbTTYUpAslWcs3bdKbSUEId2GOodNlFw954jDc501bIdNf44FhQG39rCNeLO/V14Gd3
         NeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889455; x=1690481455;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=BU1twFNIWYJnkYnKnmX11ltnOA2zuOzOAaIGl2CmN/Xb5D0VOMm6zwFpAMtQozZZ6V
         EkJRvvK6bu0l5rI8ykbn5QgEahL2wQhd/8R5+7jyTWDKPbYdaTVTmaLr3kiHOZM24vXu
         6vXwgCWc4rvi9HvK3kNriyGdR9l4G9DHs132AiWST/v9Xd0o3ADeE9AzuL9KL4Uua18L
         QDUuNapuhm4NedCYFBRtmPogWNidHzYK4dJZTF9zklFTlZLBllIEaWv8MWli+ziTfCRM
         8oXfsexVhjpy+6GT7apQXrW+q+es2KTGfc0Y/jNJX1GDKVC+cY72z52LItsIbGs91X0G
         w9eA==
X-Gm-Message-State: AC+VfDwNWlsktV8Wbo+lm20s5USIOeVAhZFQADaTe9gf6HM1b70kKLjr
	/N+wF8i6CLcpTVRtViF/5CjAOS6/GsqS
X-Google-Smtp-Source: ACHHUZ7hCPGedLA3hDk85YPuzkka3hqhshJtOMTfnuxOsm7D9+OdRd8J3ECgi1iIpw1Da0GndXH8fW2VN2e5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a25:d658:0:b0:bbb:8c13:ce26 with SMTP id
 n85-20020a25d658000000b00bbb8c13ce26mr15119569ybg.11.1687889455645; Tue, 27
 Jun 2023 11:10:55 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:23 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 06/13] perf parse-event: Add memory allocation test for
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


