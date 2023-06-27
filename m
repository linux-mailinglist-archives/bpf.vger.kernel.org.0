Return-Path: <bpf+bounces-3533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BA73F387
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B333D1C20A71
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DFD46A8;
	Tue, 27 Jun 2023 04:35:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87591291C
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:43 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BC1BF8
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5706641dda9so54534527b3.3
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840540; x=1690432540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmcwCCrzohBexPPxiwkNS29383WCu9lx0QPsW2KVyZ4=;
        b=dX0nzwKDmwRLRzUElRbb/ZUhU8CqDyxurklThpje/xh9AZe7uPANzlcnjMfd3Nphxa
         Feqs7E72EoJkDBbOEX4ndFRoShyAYkJujZwyfhO1l0BBwA3Gs2u84tlmKI2znvCpOvp/
         vCcjREuJgs2pJyJlWRCpukXwBO1MPUhGPrdg4gHR/QMtKMD6FsrCfo+0PU6C3sAzWV+h
         zZxLMQMNDhyZ6p9vVplVkJdASPfquPFGTb7pVzuvBqIZLNvhD94Og/PMKu8UPtxgdudB
         6fjGTRzje7pmiDFVUrksxcOstqsnJ2L4AE5B3/lV6jQBMF+ctiJPrlDEsfkLzv215Rse
         00OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840540; x=1690432540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmcwCCrzohBexPPxiwkNS29383WCu9lx0QPsW2KVyZ4=;
        b=PSqUSGM2fGm9XjzFmtf+PX655Lmba/BJiCMbj/FB97xYLmEDS/YgfHfHNWKC6L/fs9
         geMeAV+BsHkHWEr+KanY4Tqi/xJpXcpLtBo2pjwfxZ4xqeh394vYo9wO0O0Lpttna3DS
         MRGiYTZKTzVcBX2PTGpsgAOYy3feB64rjPMsr/QRD9df/FHFybvqg8tImxj6EaUtayrj
         C7bjuOsrzODzV85FM/1GE4adIxAa+42JTL343pWe3SLL1GVld/PFYNL1d1JeymolSSyi
         wTgTZpgXc0jjZ4bqnSF5tT0WTYw/rbWiBpFmJBshh0ugvFRftPmSbAvsazUz4SLL6SwO
         DVjg==
X-Gm-Message-State: AC+VfDzeCx2A9brg9T2swg5rj9ZU5ijA9JEvxEBZilMjFLTfoFy78ACf
	bQN/FP/CUYWzgqTcAjkRVlp3UDhVlkGg
X-Google-Smtp-Source: ACHHUZ6Ij9UVX+Y1eE/fAeD49qeUrfoIUY5V8xWSHMepARTJgN2SMH/Cpx4WFc7JhU4gPkhTdXdvWdR9wDWu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:e0c6:0:b0:bc7:f6af:8cff with SMTP id
 x189-20020a25e0c6000000b00bc7f6af8cffmr14521026ybg.2.1687840540338; Mon, 26
 Jun 2023 21:35:40 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:55 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 10/13] perf parse-events: Additional error reporting
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

When no events or PMUs match report an error for event_pmu:

Before:
```
$ perf stat -e 'asdfasdf' -a sleep 1
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

After:
```
$ perf stat -e 'asdfasdf' -a sleep 1
event syntax error: 'asdfasdf'
                     \___ Bad event name

Unabled to find PMU or event on a PMU of 'asdfasdf'
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Fixes the inadvertent removal when hybrid parsing was modified.

Fixes: ("70c90e4a6b2f perf parse-events: Avoid scanning PMUs before parsing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f090a85c4518..a636a7db6e6f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -291,7 +291,6 @@ PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
-	struct parse_events_error *error = parse_state->error;
 	char *pattern = NULL;
 
 #define CLEANUP						\
@@ -303,9 +302,6 @@ PE_NAME opt_pmu_config
 		free(pattern);				\
 	} while(0)
 
-	if (error)
-		error->idx = @1.first_column;
-
 	if (parse_events_copy_term_list($2, &orig_terms)) {
 		CLEANUP;
 		YYNOMEM;
@@ -360,6 +356,14 @@ PE_NAME opt_pmu_config
 			$2 = NULL;
 		}
 		if (!ok) {
+			struct parse_events_error *error = parse_state->error;
+			char *help;
+
+			if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+				help = NULL;
+			parse_events_error__handle(error, @1.first_column,
+						   strdup("Bad event or PMU"),
+						   help);
 			CLEANUP;
 			YYABORT;
 		}
@@ -376,9 +380,18 @@ PE_NAME sep_dc
 	int err;
 
 	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
-	free($1);
-	if (err < 0)
+	if (err < 0) {
+		struct parse_events_state *parse_state = _parse_state;
+		struct parse_events_error *error = parse_state->error;
+		char *help;
+
+		if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+			help = NULL;
+		parse_events_error__handle(error, @1.first_column, strdup("Bad event name"), help);
+		free($1);
 		PE_ABORT(err);
+	}
+	free($1);
 	$$ = list;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog


