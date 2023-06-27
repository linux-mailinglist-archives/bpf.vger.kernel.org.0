Return-Path: <bpf+bounces-3535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223473F38A
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6464280792
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230E4A26;
	Tue, 27 Jun 2023 04:35:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B894A23
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:50 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE82108
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942442eb0so52811657b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840545; x=1690432545;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFXjOGQUuRL/6Lf/qhHtjD4wLyWg5SPpnyU6+2nAMFU=;
        b=WuzxF4hiC134VQthgbEQwiSQJ7Ssgcg+mMbUKJzZP62pLb+9TsBeOV1/RsS6C9p20m
         wE3eSW7aLPghlDc8f/QiGz7fCKCmgiNodA4Zdzc3yUfIBpdXjzbAfQyai2Ufubgv7vh/
         //L5QISuq82uO+fWFgg55dds2XDlvms0SjwykGX8Py1y/ksgnDtj8PHCL/HTJAfL4p6/
         SAJtQ0S355Hdw/TDxIY7W3nymKHV+BYgjDnlM2tG8jsYHozdwNGGmK7YzZQWhXjjg9ke
         tPUOSjMNDH4LrpUZ1FU2AgQaU57l/jkUf41g9xNWBGrG87slOTNiYJwLyAR93hpvV1Mv
         hnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840545; x=1690432545;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFXjOGQUuRL/6Lf/qhHtjD4wLyWg5SPpnyU6+2nAMFU=;
        b=Xtln+q743jMIuIQoIu1U3QW70LLL5ZxYsQ80ljJ3xKhKyj34IRgdI79MpcsVLwXvGU
         8sJ2HemIsmc0LVgSj24Cfuoa6BhtxczxFcTRwAKV/BMx285ai1Bx0fePRO3y4kKL8+qA
         bH3MubOsvvTkWYKAkc4pkoduosw1xNyQfBgN9vHsPNh9CeL3VFdtc9WxVzm1Nq0cJ5Bl
         a7olfPCeX6Dqe0uC5VtRZsqql9+Bll15zv76cdX/BRi3rwa928BNOiSjZpZLuNDWEMjA
         hIpCmammCdV4xWmzQ1MLvmK6b5ixQ9ugnug/hvQWe/k71bt0keJbQJ5VraKP8trKjaFW
         ID7g==
X-Gm-Message-State: AC+VfDyD25PSnYXqH7d8cqSZO+Z4nX7bLTF4HJnXm5W98C609UBTRCs5
	ChcP1XbFRYhGcgPk5OBH4TeVP96YHlg2
X-Google-Smtp-Source: ACHHUZ5V6kpYqAE9w966HoP/tbn8OzhGrmerxYboNRZvOVEgWJy+GuW6GPPWYQmaTpLKG9938psz7F119P3b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:4505:0:b0:576:af04:3495 with SMTP id
 s5-20020a814505000000b00576af043495mr2838921ywa.9.1687840544829; Mon, 26 Jun
 2023 21:35:44 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:57 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 12/13] perf parse-events: Improve location for add pmu
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

Improve the location for add PMU for cases when PMUs aren't found.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 12 +++++++-----
 tools/perf/util/parse-events.h |  4 ++--
 tools/perf/util/parse-events.y |  8 ++++----
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a92545908626..473746c9f3c4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1566,13 +1566,14 @@ static bool config_term_percore(struct list_head *config_terms)
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
-			 bool auto_merge_stats)
+			 bool auto_merge_stats, void *loc_)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
 	struct perf_pmu *pmu;
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
+	YYLTYPE *loc = loc_;
 	LIST_HEAD(config_terms);
 
 	pmu = parse_state->fake_pmu ?: perf_pmus__find(name);
@@ -1596,7 +1597,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		if (asprintf(&err_str,
 				"Cannot find PMU `%s'. Missing kernel support?",
 				name) >= 0)
-			parse_events_error__handle(err, 0, err_str, NULL);
+			parse_events_error__handle(err, loc->first_column, err_str, NULL);
 		return -EINVAL;
 	}
 	if (head_config)
@@ -1682,12 +1683,13 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str, struct list_head *head,
-			       struct list_head **listp)
+			       struct list_head **listp, void *loc_)
 {
 	struct parse_events_term *term;
 	struct list_head *list = NULL;
 	struct list_head *orig_head = NULL;
 	struct perf_pmu *pmu = NULL;
+	YYLTYPE *loc = loc_;
 	int ok = 0;
 	char *config;
 
@@ -1734,7 +1736,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 				parse_events_copy_term_list(head, &orig_head);
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, orig_head,
-							  auto_merge_stats)) {
+							  auto_merge_stats, loc)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					parse_state->wild_card_pmus = true;
@@ -1747,7 +1749,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_state->fake_pmu) {
 		if (!parse_events_add_pmu(parse_state, list, str, head,
-					  /*auto_merge_stats=*/true)) {
+					  /*auto_merge_stats=*/true, loc)) {
 			pr_debug("%s -> %s/%s/\n", str, "fake_pmu", str);
 			ok++;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index cabbe70adb82..e59b33805886 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -202,7 +202,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config,
-			 bool auto_merge_stats);
+			bool auto_merge_stats, void *loc);
 
 struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      const char *name, const char *metric_id,
@@ -211,7 +211,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str,
 			       struct list_head *head_config,
-			       struct list_head **listp);
+			       struct list_head **listp, void *loc);
 
 int parse_events_copy_term_list(struct list_head *old,
 				 struct list_head **new);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 50f5b819de37..844646752462 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -313,7 +313,7 @@ PE_NAME opt_pmu_config
 		YYNOMEM;
 	}
 	/* Attempt to add to list assuming $1 is a PMU name. */
-	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
+	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false, &@1)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
@@ -341,7 +341,7 @@ PE_NAME opt_pmu_config
 					YYNOMEM;
 				}
 				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
-							  auto_merge_stats)) {
+							  auto_merge_stats, &@1)) {
 					ok++;
 					parse_state->wild_card_pmus = true;
 				}
@@ -352,7 +352,7 @@ PE_NAME opt_pmu_config
 		if (!ok) {
 			/* Failure to add, assume $1 is an event name. */
 			zfree(&list);
-			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list);
+			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list, &@1);
 			$2 = NULL;
 		}
 		if (!ok) {
@@ -379,7 +379,7 @@ PE_NAME sep_dc
 	struct list_head *list;
 	int err;
 
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
+	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list, &@1);
 	if (err < 0) {
 		struct parse_events_state *parse_state = _parse_state;
 		struct parse_events_error *error = parse_state->error;
-- 
2.41.0.162.gfafddb0af9-goog


