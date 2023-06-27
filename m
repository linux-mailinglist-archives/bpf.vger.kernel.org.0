Return-Path: <bpf+bounces-3594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723047402FA
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24AE1C20A10
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057D01B902;
	Tue, 27 Jun 2023 18:11:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86291308B
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:11:12 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D809297E
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:11:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-262dc227ca9so2530273a91.1
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889469; x=1690481469;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsQdXnzAIiBdOVv7YXiT/yMeAfvTF44QJmtH1jnvKyU=;
        b=V6MFh8t05RNKCKRaCyI+bwGnMYj4Vf7/14+gVHDl5oBQPkA8a9ovHrm3DBudUNtGg4
         s9JjJ+BMUhZ/nhvHDKy66J4cZW4WNJBBwPG5AaP5B19tJmii4o5pJwrTNxutm3Uf9Ek1
         yuxH7tSvlX8B2EZ+aH4AeinD52jClkt4kkA9quoTQ0o29Qq4j9TFvVRvM3sOPNFakYS+
         OwQQpCWuPzonR2120gRiqMpjG2EKzojkWeilof/J68+ePCpBxn/D+IYq2snLXG3SHGk2
         Xf3JlDD0S3+ODBGcifpN++iKUsptql3aU8lMJcRMQLV/fl2IzI/xKOGNbLpc6l5JTX9B
         ZWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889469; x=1690481469;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsQdXnzAIiBdOVv7YXiT/yMeAfvTF44QJmtH1jnvKyU=;
        b=FKPZxstD8hOoJDWMxTylnuF5nVkttkiMpO8V70beCkC0bg9VgycbNIu/8NZsnQt9ES
         RAsEl4Did0u3WHG6SebstAOa1F4AjDBI3mXt1NTE5FwBkloYyxO4b6NrdZRxUaSKripU
         raDFFONReq4/ZCDg+k169wSuQ+LzKUw2c46aws3Bq11VIdlkWUNZMkKGNqY+X77yZtB2
         Ha6VjC/+HFJEf5/TulLihfUxhuqek4/3NP1gFn/N+DzCGj+5JfR/IPVLWisl6H+lUYj8
         BAj1piv7DQRa7EazgXt36/tXlxgc0N6NUbntxno1QnjwFqoXSHeilfakPEEtXu+NheN6
         fPaw==
X-Gm-Message-State: AC+VfDxWyAJASe62m1Hgx0cOl/UgOUenGFaQdMvkbk88ouUdVlhcoJqm
	9nHHzWC++cLpGjrxEea9zovMM8je+gmd
X-Google-Smtp-Source: ACHHUZ6MjQuQeqq9PKCC4v3qfuiB37nqIjkuxyWR9iVnQ2dzQXIbLIDTJFSeM5vQsIpNIp0VuLCJ3HrkmEXU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a17:90a:d483:b0:263:2f09:20c3 with SMTP id
 s3-20020a17090ad48300b002632f0920c3mr160538pju.9.1687889469588; Tue, 27 Jun
 2023 11:11:09 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:29 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 12/13] perf parse-events: Improve location for add pmu
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

Improve the location for add PMU for cases when PMUs aren't found.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 12 +++++++-----
 tools/perf/util/parse-events.h |  4 ++--
 tools/perf/util/parse-events.y |  8 ++++----
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fdd304fbed7c..58fcfff99ec4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1567,13 +1567,14 @@ static bool config_term_percore(struct list_head *config_terms)
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
@@ -1597,7 +1598,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		if (asprintf(&err_str,
 				"Cannot find PMU `%s'. Missing kernel support?",
 				name) >= 0)
-			parse_events_error__handle(err, 0, err_str, NULL);
+			parse_events_error__handle(err, loc->first_column, err_str, NULL);
 		return -EINVAL;
 	}
 	if (head_config)
@@ -1683,12 +1684,13 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
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
 
@@ -1735,7 +1737,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 				parse_events_copy_term_list(head, &orig_head);
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, orig_head,
-							  auto_merge_stats)) {
+							  auto_merge_stats, loc)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					parse_state->wild_card_pmus = true;
@@ -1748,7 +1750,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
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


