Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F000DF3B15
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 23:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfKGWPJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 17:15:09 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43978 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfKGWPJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 17:15:09 -0500
Received: by mail-pl1-f201.google.com with SMTP id a3so2685344pls.10
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RO+dD7fMF+loxfMI95W5obH94+g4tEmZJjELHIr1A/8=;
        b=J9/+NcEb0Kb22BIyBkNY+7VwZg9woXWFrvaMZFXW85+MhBiG237bWw1U0ZhvE8xkuN
         bNr2VuzYW+ew5V5jklCSScPNQjj70HUYaNX8L4d1UOyOS0g+EOxIYN6j3Re58QUUV8eP
         teu7dwsBfLX+xYzJRCUGzwrFeFcSffK/OhTTPV2bH6SUYxP/nKt9618kzrRIexYrJH2E
         UjU7ID9nyDhDZrFQzuM2pAtcOUe3P77rJUO3GsKLVlEG2HU1kJRY1fTfN4a8ZljQPCaD
         ZKR0Mp34IE519REzY3ql2LBG1nqaEsrkMQ2kD+scZReMhb7bk63w6wXeYNr0R+LxdzIV
         uRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RO+dD7fMF+loxfMI95W5obH94+g4tEmZJjELHIr1A/8=;
        b=qOB3LzHRNuCV8vw5By5T0kxB1F9aaiEK6oIUm79sYTThVksPwfAMOctY1k+FuQebhs
         VTSwh4EVpOk1Buz7Jd0dbYanx24JMg2fTCeQ05oMo0ul/cBnIE7NHVxjBjkDntJ42shu
         bBy6Ez9efWkm03EKdCabputyzwkYwRV/qgxE0ppgq1KDqHCzAcX50EMNMJSguBXWGnOX
         38shhFyI8O8DTL/mThRHwe91sxP5EODnmeidl/Zm08kRbVSaokQF9m9vo7uZEVVgS09o
         OA1CQavh2NeNhsk2ql/lA9925cjlF+wxZUff2J1+cIFPSijdafwO2MtxEom/1ZRQJjyA
         t11A==
X-Gm-Message-State: APjAAAUEfKFgS7zhyilAvoc5pGiVbnWJqlAiEP/W/IV5U9ymIeZTz2oo
        T2Woyu1l68+m5lGSu9YrSky9s7GBF5NI
X-Google-Smtp-Source: APXvYqybHLhQQANdsiyCaIR+0YTtQxwGzUhA+4YkjjUdck1HuzvRr+BhLHgukin1TNbdrakC56GGGTV+97Wd
X-Received: by 2002:a65:624e:: with SMTP id q14mr7431914pgv.277.1573164905944;
 Thu, 07 Nov 2019 14:15:05 -0800 (PST)
Date:   Thu,  7 Nov 2019 14:14:27 -0800
In-Reply-To: <20191107221428.168286-1-irogers@google.com>
Message-Id: <20191107221428.168286-10-irogers@google.com>
Mime-Version: 1.0
References: <20191030223448.12930-1-irogers@google.com> <20191107221428.168286-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v6 09/10] perf tools: add a deep delete for parse event terms
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a parse_events_term deep delete function so that owned strings and
arrays are freed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 +++++++++++++---
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.y | 12 ++----------
 tools/perf/util/pmu.c          |  2 +-
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a0a80f4e7038..6d18ff9bce49 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2812,6 +2812,18 @@ int parse_events_term__clone(struct parse_events_term **new,
 	return new_term(new, &temp, str, 0);
 }
 
+void parse_events_term__delete(struct parse_events_term *term)
+{
+	if (term->array.nr_ranges)
+		zfree(&term->array.ranges);
+
+	if (term->type_val != PARSE_EVENTS__TERM_TYPE_NUM)
+		zfree(&term->val.str);
+
+	zfree(&term->config);
+	free(term);
+}
+
 int parse_events_copy_term_list(struct list_head *old,
 				 struct list_head **new)
 {
@@ -2842,10 +2854,8 @@ void parse_events_terms__purge(struct list_head *terms)
 	struct parse_events_term *term, *h;
 
 	list_for_each_entry_safe(term, h, terms, list) {
-		if (term->array.nr_ranges)
-			zfree(&term->array.ranges);
 		list_del_init(&term->list);
-		free(term);
+		parse_events_term__delete(term);
 	}
 }
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 34f58d24a06a..5ee8ac93840c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -139,6 +139,7 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 			      char *config, unsigned idx);
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term);
+void parse_events_term__delete(struct parse_events_term *term);
 void parse_events_terms__delete(struct list_head *terms);
 void parse_events_terms__purge(struct list_head *terms);
 void parse_events__clear_array(struct parse_events_array *a);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 376b19855470..4cac830015be 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -49,14 +49,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 	free(list_evsel);
 }
 
-static void free_term(struct parse_events_term *term)
-{
-	if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
-		free(term->val.str);
-	zfree(&term->array.ranges);
-	free(term);
-}
-
 static void inc_group_count(struct list_head *list,
 		       struct parse_events_state *parse_state)
 {
@@ -99,7 +91,7 @@ static void inc_group_count(struct list_head *list,
 %type <str> PE_DRV_CFG_TERM
 %destructor { free ($$); } <str>
 %type <term> event_term
-%destructor { free_term ($$); } <term>
+%destructor { parse_events_term__delete ($$); } <term>
 %type <list_terms> event_config
 %type <list_terms> opt_event_config
 %type <list_terms> opt_pmu_config
@@ -694,7 +686,7 @@ event_config ',' event_term
 	struct parse_events_term *term = $3;
 
 	if (!head) {
-		free_term(term);
+		parse_events_term__delete(term);
 		YYABORT;
 	}
 	list_add_tail(&term->list, head);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f9f427d4c313..db1e57113f4b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1260,7 +1260,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 		info->metric_name = alias->metric_name;
 
 		list_del_init(&term->list);
-		free(term);
+		parse_events_term__delete(term);
 	}
 
 	/*
-- 
2.24.0.432.g9d3f5f5b63-goog

