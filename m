Return-Path: <bpf+bounces-3592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F17402F6
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0744281358
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612B1ACDC;
	Tue, 27 Jun 2023 18:11:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6F1308B
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:11:07 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5827296B
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:11:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c337c5c56ecso833538276.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889465; x=1690481465;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmcwCCrzohBexPPxiwkNS29383WCu9lx0QPsW2KVyZ4=;
        b=aei3beb4q3x++WPIPe0QnHzZckcCFW4R3vf2GZueNTS8EH1ej5AXfNxSKeKke4OnW4
         pA1YiiyKDg4RiHfInlERXtFstvo8F+W0YaAE+KQJjwrFblA/gDRz1CNUUrPC2w2JQil3
         /Wra5Ojjv9MsDQI5HT4WZil3DOlquS7Yg0g4ytIrnu96YIlrFydfvyZzAezPCh/AEdFB
         rRhqPAkPurZjCa/Bls2FsuQpCBCe+AU4YlqrMa6qVUXBaNjbpW5dfNvPrvt+gulyeI6z
         hZY6zNeqiTqUAdNOa6piRZ3r0WzZRF4/9Mff9lv3m+nnFLcYoEpQVXsLvBCl3X/F32rh
         wojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889465; x=1690481465;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmcwCCrzohBexPPxiwkNS29383WCu9lx0QPsW2KVyZ4=;
        b=e5MMaj6iEVfPe65LuYQm457qRLYYtIS5ykFS59DC4sAw1WO5D5LUzbOs96WUm17isa
         qIRyCVcgnMhXOCQb6s6RO/fjQt+FrtdyuokBoix0fvEQlqzFFqURcZvfNYY1Tb4cVs3d
         XamfWF9cPIBlPP3A+Er5x2W3M+izZxG2gQ6JiPEfNzbPtJxj22FztYoOeBjtQBP8wxKN
         8v3eyXf7e/MIX2YLbTfxYvzgYxjvTxOgfqx8FifDMj17HS1cEAM35XSSO5lDbwLuZvNk
         2iheSC36YbR7MvGD3SBm0u63GBbfWB8Qs6Yk+LaaCcadahzbIPfqMcttQMSGDkXDsfdx
         dfFA==
X-Gm-Message-State: AC+VfDzgJGOZmvnvUiBIekUha8uxqkTjrhjPjbUAqyHQ2v6hMDRo98tf
	NnJxd9sSBaV6z4ySNaiwnhCySDZCP177
X-Google-Smtp-Source: ACHHUZ4/a+LchMST3LH5uXgoZ0tXTL1BebqlP5Oj8R+ArkMhvomyHOWsaMi0FEXWPrdUw3IQVWMEMjhABDIT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a25:ad9f:0:b0:bce:5d6f:87a with SMTP id
 z31-20020a25ad9f000000b00bce5d6f087amr7873345ybi.1.1687889465014; Tue, 27 Jun
 2023 11:11:05 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:27 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 10/13] perf parse-events: Additional error reporting
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


