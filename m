Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51411D5694
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgEOQue (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbgEOQu1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 12:50:27 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54589C05BD0C
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 09:50:26 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ce16so3175106qvb.15
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PApc4N7DWM1EQI/FQ6y/Y4K4jLWdqmZmtVqcmkgpzOA=;
        b=TAjDazskR69FseRyKuPCXa3r1dpccHrjDDD2uuA7gG2N+DfkdupUa0ys5uRwp1XpFF
         yGLV8zFjA0+POlIkmubRoERa3Jpnw8Ee4XbluwmntYOcdoD/9pNL7mO3ve6U/c1bjhh7
         rCYCFDJkQFT6DDip+1csKDP//IIJtLss3rJnHQwmZ3Iv9t56ki+lBQZ3tuwGcwc2oQJ5
         lLo094FChvhqFm6tz0mw1d7iWyBn6RCGunOh2GYaFY6uZH4FW51DVE2/TGtiZd04XGa0
         3QR76/eSvuDAGSvj2nvewoahvXvyuvSOVOcl7aBFG2AWYwtygu/xHYnXPVQ57UewGka5
         w1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PApc4N7DWM1EQI/FQ6y/Y4K4jLWdqmZmtVqcmkgpzOA=;
        b=S6vnc5b7fY2NORDkOwY0Gzu/5T46NW4yTAVavWJHpZoQlE+D/X/SSUO7CoTT4m1XHi
         seo+pR0OXH4JwWPzoa5xJlIw5HKOsHVniIfjXTMeLpzfVKdY8wgY1nQqOdZihspkJzXp
         dadwnDZXMZaQW8s1UbcreruJ/WKuuDDrJnhFcdYiWjcZ63bK2k6GObokPN28QVn0ZIQR
         7NuD7PIkoOAysSqdAXKeI2C36gFAYl3xs7IZE9ocvPCh8YWyeWLybfHHsylN3Pa10Jcy
         //4q6DoBo5pstqeytJrwG+BUOd+00pPLFVjlZUGN2Mb0G3SWJwt+iqQbpLbnIvgvIErn
         ZBGw==
X-Gm-Message-State: AOAM532gMtaNbtU46B5tC9UIdLBhesysD7AhVDxM51C2DmPbREHgTkZQ
        e9PdXXM2k3/7Yc6mbv+ucNJZ5up18gpV
X-Google-Smtp-Source: ABdhPJz3oQ17mISkU7AD/SvGotduqRzPF+J/j6A5VfWugMJUhfFLvGQ0OwMAONi+JSgnxiL31AyQ0NPVfn9Q
X-Received: by 2002:ad4:4e4d:: with SMTP id eb13mr4278927qvb.169.1589561425404;
 Fri, 15 May 2020 09:50:25 -0700 (PDT)
Date:   Fri, 15 May 2020 09:50:07 -0700
In-Reply-To: <20200515165007.217120-1-irogers@google.com>
Message-Id: <20200515165007.217120-8-irogers@google.com>
Mime-Version: 1.0
References: <20200515165007.217120-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2 7/7] perf expr: Migrate expr ids table to a hashmap
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
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use a hashmap between a char* string and a double* value. While bpf's
hashmap entries are size_t in size, we can't guarantee sizeof(size_t) >=
sizeof(double). Avoid a memory allocation when gathering ids by making 0.0
a special value encoded as NULL.

Original map suggestion by Andi Kleen:
https://lore.kernel.org/lkml/20200224210308.GQ160988@tassilo.jf.intel.com/
and seconded by Jiri Olsa:
https://lore.kernel.org/lkml/20200423112915.GH1136647@krava/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       |  40 ++++++-----
 tools/perf/tests/pmu-events.c |  25 +++----
 tools/perf/util/expr.c        | 129 +++++++++++++++++++---------------
 tools/perf/util/expr.h        |  26 +++----
 tools/perf/util/expr.y        |  22 +-----
 tools/perf/util/metricgroup.c |  87 +++++++++++------------
 tools/perf/util/stat-shadow.c |  49 ++++++++-----
 7 files changed, 197 insertions(+), 181 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 3f742612776a..5e606fd5a2c6 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -19,11 +19,9 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	const char *p;
-	const char **other;
-	double val;
-	int i, ret;
+	double val, *val_ptr;
+	int ret;
 	struct expr_parse_ctx ctx;
-	int num_other;
 
 	expr__ctx_init(&ctx);
 	expr__add_id(&ctx, "FOO", 1);
@@ -52,25 +50,29 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	ret = expr__parse(&val, &ctx, p, 1);
 	TEST_ASSERT_VAL("missing operand", ret == -1);
 
+	hashmap__clear(&ctx.ids);
 	TEST_ASSERT_VAL("find other",
-			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other, 1) == 0);
-	TEST_ASSERT_VAL("find other", num_other == 3);
-	TEST_ASSERT_VAL("find other", !strcmp(other[0], "BAR"));
-	TEST_ASSERT_VAL("find other", !strcmp(other[1], "BAZ"));
-	TEST_ASSERT_VAL("find other", !strcmp(other[2], "BOZO"));
-	TEST_ASSERT_VAL("find other", other[3] == NULL);
+			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO",
+					 &ctx, 1) == 0);
+	TEST_ASSERT_VAL("find other", hashmap__size(&ctx.ids) == 3);
+	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "BAR",
+						    (void **)&val_ptr));
+	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "BAZ",
+						    (void **)&val_ptr));
+	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "BOZO",
+						    (void **)&val_ptr));
 
+	hashmap__clear(&ctx.ids);
 	TEST_ASSERT_VAL("find other",
-			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@", NULL,
-				   &other, &num_other, 3) == 0);
-	TEST_ASSERT_VAL("find other", num_other == 2);
-	TEST_ASSERT_VAL("find other", !strcmp(other[0], "EVENT1,param=3/"));
-	TEST_ASSERT_VAL("find other", !strcmp(other[1], "EVENT2,param=3/"));
-	TEST_ASSERT_VAL("find other", other[2] == NULL);
+			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
+					 NULL, &ctx, 3) == 0);
+	TEST_ASSERT_VAL("find other", hashmap__size(&ctx.ids) == 2);
+	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "EVENT1,param=3/",
+						    (void **)&val_ptr));
+	TEST_ASSERT_VAL("find other", hashmap__find(&ctx.ids, "EVENT2,param=3/",
+						    (void **)&val_ptr));
 
-	for (i = 0; i < num_other; i++)
-		zfree(&other[i]);
-	free((void *)other);
+	expr__ctx_clear(&ctx);
 
 	return 0;
 }
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index e21f0addcfbb..3de59564deb0 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -433,8 +433,6 @@ static int test_parsing(void)
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
 	int i, j, k;
-	const char **ids;
-	int idnum;
 	int ret = 0;
 	struct expr_parse_ctx ctx;
 	double result;
@@ -446,29 +444,34 @@ static int test_parsing(void)
 			break;
 		j = 0;
 		for (;;) {
+			struct hashmap_entry *cur;
+			size_t bkt;
+
 			pe = &map->table[j++];
 			if (!pe->name && !pe->metric_group && !pe->metric_name)
 				break;
 			if (!pe->metric_expr)
 				continue;
-			if (expr__find_other(pe->metric_expr, NULL,
-						&ids, &idnum, 0) < 0) {
+			expr__ctx_init(&ctx);
+			if (expr__find_other(pe->metric_expr, NULL, &ctx, 0)
+				  < 0) {
 				expr_failure("Parse other failed", map, pe);
 				ret++;
 				continue;
 			}
-			expr__ctx_init(&ctx);
 
 			/*
 			 * Add all ids with a made up value. The value may
 			 * trigger divide by zero when subtracted and so try to
 			 * make them unique.
 			 */
-			for (k = 0; k < idnum; k++)
-				expr__add_id(&ctx, ids[k], k + 1);
+			k = 1;
+			hashmap__for_each_entry((&ctx.ids), cur, bkt)
+				expr__add_id(&ctx, strdup(cur->key), k++);
 
-			for (k = 0; k < idnum; k++) {
-				if (check_parse_id(ids[k], map == cpus_map, pe))
+			hashmap__for_each_entry((&ctx.ids), cur, bkt) {
+				if (check_parse_id(cur->key, map == cpus_map,
+						   pe))
 					ret++;
 			}
 
@@ -476,9 +479,7 @@ static int test_parsing(void)
 				expr_failure("Parse failed", map, pe);
 				ret++;
 			}
-			for (k = 0; k < idnum; k++)
-				zfree(&ids[k]);
-			free(ids);
+			expr__ctx_clear(&ctx);
 		}
 	}
 	/* TODO: fail when not ok */
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 8b4ce704a68d..f64ab91c432b 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -4,25 +4,76 @@
 #include "expr.h"
 #include "expr-bison.h"
 #include "expr-flex.h"
+#include <linux/kernel.h>
 
 #ifdef PARSER_DEBUG
 extern int expr_debug;
 #endif
 
+static size_t key_hash(const void *key, void *ctx __maybe_unused)
+{
+	const char *str = (const char *)key;
+	size_t hash = 0;
+
+	while (*str != '\0') {
+		hash *= 31;
+		hash += *str;
+		str++;
+	}
+	return hash;
+}
+
+static bool key_equal(const void *key1, const void *key2,
+		    void *ctx __maybe_unused)
+{
+	return !strcmp((const char *)key1, (const char *)key2);
+}
+
 /* Caller must make sure id is allocated */
-void expr__add_id(struct expr_parse_ctx *ctx, const char *name, double val)
+int expr__add_id(struct expr_parse_ctx *ctx, const char *name, double val)
 {
-	int idx;
+	double *val_ptr = NULL, *old_val = NULL;
+	char *old_key = NULL;
+	int ret;
+
+	if (val != 0.0) {
+		val_ptr = malloc(sizeof(double));
+		if (!val_ptr)
+			return -ENOMEM;
+		*val_ptr = val;
+	}
+	ret = hashmap__set(&ctx->ids, name, val_ptr,
+			   (const void **)&old_key, (void **)&old_val);
+	free(old_key);
+	free(old_val);
+	return ret;
+}
+
+int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
+{
+	double *data;
 
-	assert(ctx->num_ids < MAX_PARSE_ID);
-	idx = ctx->num_ids++;
-	ctx->ids[idx].name = name;
-	ctx->ids[idx].val = val;
+	if (!hashmap__find(&ctx->ids, id, (void **)&data))
+		return -1;
+	*val_ptr = (data == NULL) ?  0.0 : *data;
+	return 0;
 }
 
 void expr__ctx_init(struct expr_parse_ctx *ctx)
 {
-	ctx->num_ids = 0;
+	hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
+}
+
+void expr__ctx_clear(struct expr_parse_ctx *ctx)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
+		free((char *)cur->key);
+		free(cur->value);
+	}
+	hashmap__clear(&ctx->ids);
 }
 
 static int
@@ -56,61 +107,25 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	return ret;
 }
 
-int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr, int runtime)
+int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
+		const char *expr, int runtime)
 {
 	return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
 }
 
-static bool
-already_seen(const char *val, const char *one, const char **other,
-	     int num_other)
-{
-	int i;
-
-	if (one && !strcasecmp(one, val))
-		return true;
-	for (i = 0; i < num_other; i++)
-		if (!strcasecmp(other[i], val))
-			return true;
-	return false;
-}
-
-int expr__find_other(const char *expr, const char *one, const char ***other,
-		     int *num_other, int runtime)
+int expr__find_other(const char *expr, const char *one,
+		     struct expr_parse_ctx *ctx, int runtime)
 {
-	int err, i = 0, j = 0;
-	struct expr_parse_ctx ctx;
-
-	expr__ctx_init(&ctx);
-	err = __expr__parse(NULL, &ctx, expr, EXPR_OTHER, runtime);
-	if (err)
-		return -1;
-
-	*other = malloc((ctx.num_ids + 1) * sizeof(char *));
-	if (!*other)
-		return -ENOMEM;
-
-	for (i = 0, j = 0; i < ctx.num_ids; i++) {
-		const char *str = ctx.ids[i].name;
-
-		if (already_seen(str, one, *other, j))
-			continue;
-
-		str = strdup(str);
-		if (!str)
-			goto out;
-		(*other)[j++] = str;
-	}
-	(*other)[j] = NULL;
-
-out:
-	if (i != ctx.num_ids) {
-		while (--j)
-			free((char *) (*other)[i]);
-		free(*other);
-		err = -1;
+	double *old_val = NULL;
+	char *old_key = NULL;
+	int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
+
+	if (one) {
+		hashmap__delete(&ctx->ids, one,
+				(const void **)&old_key, (void **)&old_val);
+		free(old_key);
+		free(old_val);
 	}
 
-	*num_other = j;
-	return err;
+	return ret;
 }
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 40fc452b0f2b..d60a8feaf50b 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,17 +2,14 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 64
-#define MAX_PARSE_ID EXPR_MAX_OTHER
-
-struct expr_parse_id {
-	const char *name;
-	double val;
-};
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/hashmap.h>
+#else
+#include "hashmap.h"
+#endif
 
 struct expr_parse_ctx {
-	int num_ids;
-	struct expr_parse_id ids[MAX_PARSE_ID];
+	struct hashmap ids;
 };
 
 struct expr_scanner_ctx {
@@ -21,9 +18,12 @@ struct expr_scanner_ctx {
 };
 
 void expr__ctx_init(struct expr_parse_ctx *ctx);
-void expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
-int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr, int runtime);
-int expr__find_other(const char *expr, const char *one, const char ***other,
-		int *num_other, int runtime);
+void expr__ctx_clear(struct expr_parse_ctx *ctx);
+int expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
+int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
+int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
+		const char *expr, int runtime);
+int expr__find_other(const char *expr, const char *one,
+		struct expr_parse_ctx *ids, int runtime);
 
 #endif
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 21e82a1e11a2..ec5a48bf5f34 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -46,19 +46,6 @@ static void expr_error(double *final_val __maybe_unused,
 	pr_debug("%s\n", s);
 }
 
-static int lookup_id(struct expr_parse_ctx *ctx, char *id, double *val)
-{
-	int i;
-
-	for (i = 0; i < ctx->num_ids; i++) {
-		if (!strcasecmp(ctx->ids[i].name, id)) {
-			*val = ctx->ids[i].val;
-			return 0;
-		}
-	}
-	return -1;
-}
-
 %}
 %%
 
@@ -72,12 +59,7 @@ all_other: all_other other
 
 other: ID
 {
-	if (ctx->num_ids + 1 >= EXPR_MAX_OTHER) {
-		pr_err("failed: way too many variables");
-		YYABORT;
-	}
-
-	ctx->ids[ctx->num_ids++].name = $1;
+	expr__add_id(ctx, $1, 0.0);
 }
 |
 MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
@@ -92,7 +74,7 @@ if_expr:
 	;
 
 expr:	  NUMBER
-	| ID			{ if (lookup_id(ctx, $1, &$$) < 0) {
+	| ID			{ if (expr__get_id(ctx, $1, &$$)) {
 					pr_debug("%s not found\n", $1);
 					YYABORT;
 				  }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b071df373f8b..37be5a368d6e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -85,8 +85,7 @@ static void metricgroup__rblist_init(struct rblist *metric_events)
 
 struct egroup {
 	struct list_head nd;
-	int idnum;
-	const char **ids;
+	struct expr_parse_ctx pctx;
 	const char *metric_name;
 	const char *metric_expr;
 	const char *metric_unit;
@@ -94,19 +93,21 @@ struct egroup {
 };
 
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
-				      const char **ids,
-				      int idnum,
+				      struct expr_parse_ctx *pctx,
 				      struct evsel **metric_events,
 				      bool *evlist_used)
 {
 	struct evsel *ev;
-	int i = 0, j = 0;
 	bool leader_found;
+	const size_t idnum = hashmap__size(&pctx->ids);
+	size_t i = 0;
+	int j = 0;
+	double *val_ptr;
 
 	evlist__for_each_entry (perf_evlist, ev) {
 		if (evlist_used[j++])
 			continue;
-		if (!strcmp(ev->name, ids[i])) {
+		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
 			i++;
@@ -118,7 +119,8 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			memset(metric_events, 0,
 				sizeof(struct evsel *) * idnum);
 
-			if (!strcmp(ev->name, ids[i])) {
+			if (hashmap__find(&pctx->ids, ev->name,
+					  (void **)&val_ptr)) {
 				if (!metric_events[i])
 					metric_events[i] = ev;
 				i++;
@@ -175,19 +177,20 @@ static int metricgroup__setup_events(struct list_head *groups,
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
 
-		metric_events = calloc(sizeof(void *), eg->idnum + 1);
+		metric_events = calloc(sizeof(void *),
+				hashmap__size(&eg->pctx.ids) + 1);
 		if (!metric_events) {
 			ret = -ENOMEM;
 			break;
 		}
-		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
-					 metric_events, evlist_used);
+		evsel = find_evsel_group(perf_evlist, &eg->pctx, metric_events,
+					evlist_used);
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					eg->metric_name, eg->metric_expr);
 			continue;
 		}
-		for (i = 0; i < eg->idnum; i++)
+		for (i = 0; metric_events[i]; i++)
 			metric_events[i]->collect_stat = true;
 		me = metricgroup__lookup(metric_events_list, evsel, true);
 		if (!me) {
@@ -415,20 +418,20 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 }
 
 static void metricgroup__add_metric_weak_group(struct strbuf *events,
-					       const char **ids,
-					       int idnum)
+					       struct expr_parse_ctx *ctx)
 {
+	struct hashmap_entry *cur;
+	size_t bkt, i = 0;
 	bool no_group = false;
-	int i;
 
-	for (i = 0; i < idnum; i++) {
-		pr_debug("found event %s\n", ids[i]);
+	hashmap__for_each_entry((&ctx->ids), cur, bkt) {
+		pr_debug("found event %s\n", (const char *)cur->key);
 		/*
 		 * Duration time maps to a software event and can make
 		 * groups not count. Always use it outside a
 		 * group.
 		 */
-		if (!strcmp(ids[i], "duration_time")) {
+		if (!strcmp(cur->key, "duration_time")) {
 			if (i > 0)
 				strbuf_addf(events, "}:W,");
 			strbuf_addf(events, "duration_time");
@@ -437,21 +440,22 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 		}
 		strbuf_addf(events, "%s%s",
 			i == 0 || no_group ? "{" : ",",
-			ids[i]);
+			(const char *)cur->key);
 		no_group = false;
+		i++;
 	}
 	if (!no_group)
 		strbuf_addf(events, "}:W");
 }
 
 static void metricgroup__add_metric_non_group(struct strbuf *events,
-					      const char **ids,
-					      int idnum)
+					      struct expr_parse_ctx *ctx)
 {
-	int i;
+	struct hashmap_entry *cur;
+	size_t bkt;
 
-	for (i = 0; i < idnum; i++)
-		strbuf_addf(events, ",%s", ids[i]);
+	hashmap__for_each_entry((&ctx->ids), cur, bkt)
+		strbuf_addf(events, ",%s", (const char *)cur->key);
 }
 
 static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
@@ -495,32 +499,32 @@ int __weak arch_get_runtimeparam(void)
 static int __metricgroup__add_metric(struct strbuf *events,
 		struct list_head *group_list, struct pmu_event *pe, int runtime)
 {
-
-	const char **ids;
-	int idnum;
 	struct egroup *eg;
 
-	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, runtime) < 0)
-		return -EINVAL;
-
-	if (events->len > 0)
-		strbuf_addf(events, ",");
-
-	if (metricgroup__has_constraint(pe))
-		metricgroup__add_metric_non_group(events, ids, idnum);
-	else
-		metricgroup__add_metric_weak_group(events, ids, idnum);
-
 	eg = malloc(sizeof(*eg));
 	if (!eg)
 		return -ENOMEM;
 
-	eg->ids = ids;
-	eg->idnum = idnum;
+	expr__ctx_init(&eg->pctx);
 	eg->metric_name = pe->metric_name;
 	eg->metric_expr = pe->metric_expr;
 	eg->metric_unit = pe->unit;
 	eg->runtime = runtime;
+
+	if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
+		expr__ctx_clear(&eg->pctx);
+		free(eg);
+		return -EINVAL;
+	}
+
+	if (events->len > 0)
+		strbuf_addf(events, ",");
+
+	if (metricgroup__has_constraint(pe))
+		metricgroup__add_metric_non_group(events, &eg->pctx);
+	else
+		metricgroup__add_metric_weak_group(events, &eg->pctx);
+
 	list_add_tail(&eg->nd, group_list);
 
 	return 0;
@@ -603,12 +607,9 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
 static void metricgroup__free_egroups(struct list_head *group_list)
 {
 	struct egroup *eg, *egtmp;
-	int i;
 
 	list_for_each_entry_safe (eg, egtmp, group_list, nd) {
-		for (i = 0; i < eg->idnum; i++)
-			zfree(&eg->ids[i]);
-		zfree(&eg->ids);
+		expr__ctx_clear(&eg->pctx);
 		list_del_init(&eg->nd);
 		free(eg);
 	}
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9bd7a8d2a858..c44dc814b377 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -323,35 +323,46 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 {
 	struct evsel *counter, *leader, **metric_events, *oc;
 	bool found;
-	const char **metric_names;
+	struct expr_parse_ctx ctx;
+	struct hashmap_entry *cur;
+	size_t bkt;
 	int i;
-	int num_metric_names;
 
+	expr__ctx_init(&ctx);
 	evlist__for_each_entry(evsel_list, counter) {
 		bool invalid = false;
 
 		leader = counter->leader;
 		if (!counter->metric_expr)
 			continue;
+
+		expr__ctx_clear(&ctx);
 		metric_events = counter->metric_events;
 		if (!metric_events) {
-			if (expr__find_other(counter->metric_expr, counter->name,
-						&metric_names, &num_metric_names, 1) < 0)
+			if (expr__find_other(counter->metric_expr,
+					     counter->name,
+					     &ctx, 1) < 0)
 				continue;
 
 			metric_events = calloc(sizeof(struct evsel *),
-					       num_metric_names + 1);
-			if (!metric_events)
+					       hashmap__size(&ctx.ids) + 1);
+			if (!metric_events) {
+				expr__ctx_clear(&ctx);
 				return;
+			}
 			counter->metric_events = metric_events;
 		}
 
-		for (i = 0; i < num_metric_names; i++) {
+		i = 0;
+		hashmap__for_each_entry((&ctx.ids), cur, bkt) {
+			const char *metric_name = (const char *)cur->key;
+
 			found = false;
 			if (leader) {
 				/* Search in group */
 				for_each_group_member (oc, leader) {
-					if (!strcasecmp(oc->name, metric_names[i]) &&
+					if (!strcasecmp(oc->name,
+							metric_name) &&
 						!oc->collect_stat) {
 						found = true;
 						break;
@@ -360,7 +371,8 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 			}
 			if (!found) {
 				/* Search ignoring groups */
-				oc = perf_stat__find_event(evsel_list, metric_names[i]);
+				oc = perf_stat__find_event(evsel_list,
+							   metric_name);
 			}
 			if (!oc) {
 				/* Deduping one is good enough to handle duplicated PMUs. */
@@ -373,27 +385,28 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 				 * of events. So we ask the user instead to add the missing
 				 * events.
 				 */
-				if (!printed || strcasecmp(printed, metric_names[i])) {
+				if (!printed ||
+				    strcasecmp(printed, metric_name)) {
 					fprintf(stderr,
 						"Add %s event to groups to get metric expression for %s\n",
-						metric_names[i],
+						metric_name,
 						counter->name);
-					printed = strdup(metric_names[i]);
+					printed = strdup(metric_name);
 				}
 				invalid = true;
 				continue;
 			}
-			metric_events[i] = oc;
+			metric_events[i++] = oc;
 			oc->collect_stat = true;
 		}
 		metric_events[i] = NULL;
-		free(metric_names);
 		if (invalid) {
 			free(metric_events);
 			counter->metric_events = NULL;
 			counter->metric_expr = NULL;
 		}
 	}
+	expr__ctx_clear(&ctx);
 }
 
 static double runtime_stat_avg(struct runtime_stat *st,
@@ -738,7 +751,10 @@ static void generic_metric(struct perf_stat_config *config,
 
 	expr__ctx_init(&pctx);
 	/* Must be first id entry */
-	expr__add_id(&pctx, name, avg);
+	n = strdup(name);
+	if (!n)
+		return;
+	expr__add_id(&pctx, n, avg);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
@@ -814,8 +830,7 @@ static void generic_metric(struct perf_stat_config *config,
 			     (metric_name ? metric_name : name) : "", 0);
 	}
 
-	for (i = 1; i < pctx.num_ids; i++)
-		zfree(&pctx.ids[i].name);
+	expr__ctx_clear(&pctx);
 }
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
-- 
2.26.2.761.g0e0b3e54be-goog

