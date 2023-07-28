Return-Path: <bpf+bounces-6115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A448476609B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5947B2824A5
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32915DA;
	Fri, 28 Jul 2023 00:13:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A3800
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:13:04 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E4C26A0
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:13:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c0f35579901so1394741276.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503180; x=1691107980;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWz7XL7DQKS0EfsO7HA2MTsxrytCVyGHUhFfdbWDZ6s=;
        b=IuvFR8BF5x1tWF1G6W+CDSQZV/ETHOkjlt5JLQdNIV3O6uadOqnLA7xXftF9bM1JRJ
         on3qOQgxzN77vfUrqRid2baZtPRCfB9sIRH5BCkItKwFeqszmlmOn5YSBgft7bE7z/6Q
         optwoMN3KaiZrIGku9DTaf4OIfHXFoNsmZF0uQ3EIckjvyynrnwAtaa58wWI+6s2Ig65
         wVEfTqaXWXIyKp8vHk3ROuUMRureFKatzpizPZ6FYru+IrCB8wbfKnL/ZJRjTP7f7J7m
         PGqB7U2SoXoG1l6H6j360dMT4DCVrFFPBUho6CaHWZEJrgfmiER5JUHJS/YwGAZN4WIF
         wB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503180; x=1691107980;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWz7XL7DQKS0EfsO7HA2MTsxrytCVyGHUhFfdbWDZ6s=;
        b=CY7pKE3V+6oDapfgl//4yaj7BUk1tMjgjYn/HnB3IpOyJ0WkLsOMcIEub7dUYbENw3
         zQ//FytLaxJdENg6yEGIidINIFlWNLXYM9sreEf9aIvDceADRw9FmX3EusssHy9EatcM
         MBZ66heZR3MnnOPVjqSi6q3UJX8SAM363x3q9G9wT8NU8oxpAjDZo19yEOBRCOYTEFA6
         7/VQmRSJtb0Z0wVRWJgrC6i5RbBTSuY1Kugaq0XO1eqsAp3NXy41/kWyAbjSexnvqG74
         wkEIP697l0u2S365I3Ug/WtitcCXEyGBFJuikQnp1Ea+QdDNo84msgy67YkY+0cnC2e6
         Di5w==
X-Gm-Message-State: ABy/qLZ1H1E/uXbje3bW9dIu64NSjufHEwIEyATknLY4ZRDu7PQhf0mC
	nbl/xAzCgujYjPXDsWHW41RUFdaGYLx8
X-Google-Smtp-Source: APBJJlFpuxfDhuyA9wPq1j8ekeU8floVzkUu1hEuEp9+trKyCpF1P2gF/EEdIZPyXLG7MeOx8eR5n175A9UL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a05:6902:569:b0:d11:3c58:2068 with SMTP id
 a9-20020a056902056900b00d113c582068mr1077ybt.2.1690503180537; Thu, 27 Jul
 2023 17:13:00 -0700 (PDT)
Date: Thu, 27 Jul 2023 17:12:12 -0700
In-Reply-To: <20230728001212.457900-1-irogers@google.com>
Message-Id: <20230728001212.457900-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728001212.457900-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 3/3] perf parse-events: Remove array remnants
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Wang Nan <wangnan0@huawei.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, 
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

parse_events_array was set up by event term parsing, which no longer
exists. Remove this struct and references to it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-loader.c   | 101 ---------------------------------
 tools/perf/util/parse-events.c |   8 ---
 tools/perf/util/parse-events.h |  10 ----
 3 files changed, 119 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 44cde27d6389..108eca9ddad4 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1091,16 +1091,12 @@ enum bpf_map_op_type {
 
 enum bpf_map_key_type {
 	BPF_MAP_KEY_ALL,
-	BPF_MAP_KEY_RANGES,
 };
 
 struct bpf_map_op {
 	struct list_head list;
 	enum bpf_map_op_type op_type;
 	enum bpf_map_key_type key_type;
-	union {
-		struct parse_events_array array;
-	} k;
 	union {
 		u64 value;
 		struct evsel *evsel;
@@ -1116,8 +1112,6 @@ bpf_map_op__delete(struct bpf_map_op *op)
 {
 	if (!list_empty(&op->list))
 		list_del_init(&op->list);
-	if (op->key_type == BPF_MAP_KEY_RANGES)
-		parse_events__clear_array(&op->k.array);
 	free(op);
 }
 
@@ -1196,18 +1190,6 @@ bpf_map_op_setkey(struct bpf_map_op *op, struct parse_events_term *term)
 	if (!term)
 		return 0;
 
-	if (term->array.nr_ranges) {
-		size_t memsz = term->array.nr_ranges *
-				sizeof(op->k.array.ranges[0]);
-
-		op->k.array.ranges = memdup(term->array.ranges, memsz);
-		if (!op->k.array.ranges) {
-			pr_debug("Not enough memory to alloc indices for map\n");
-			return -ENOMEM;
-		}
-		op->key_type = BPF_MAP_KEY_RANGES;
-		op->k.array.nr_ranges = term->array.nr_ranges;
-	}
 	return 0;
 }
 
@@ -1244,18 +1226,6 @@ bpf_map_op__clone(struct bpf_map_op *op)
 	}
 
 	INIT_LIST_HEAD(&newop->list);
-	if (op->key_type == BPF_MAP_KEY_RANGES) {
-		size_t memsz = op->k.array.nr_ranges *
-			       sizeof(op->k.array.ranges[0]);
-
-		newop->k.array.ranges = memdup(op->k.array.ranges, memsz);
-		if (!newop->k.array.ranges) {
-			pr_debug("Failed to alloc indices for map\n");
-			free(newop);
-			return NULL;
-		}
-	}
-
 	return newop;
 }
 
@@ -1456,40 +1426,6 @@ struct bpf_obj_config__map_func bpf_obj_config__map_funcs[] = {
 	{"event", bpf_map__config_event},
 };
 
-static int
-config_map_indices_range_check(struct parse_events_term *term,
-			       struct bpf_map *map,
-			       const char *map_name)
-{
-	struct parse_events_array *array = &term->array;
-	unsigned int i;
-
-	if (!array->nr_ranges)
-		return 0;
-	if (!array->ranges) {
-		pr_debug("ERROR: map %s: array->nr_ranges is %d but range array is NULL\n",
-			 map_name, (int)array->nr_ranges);
-		return -BPF_LOADER_ERRNO__INTERNAL;
-	}
-
-	if (!map) {
-		pr_debug("Map '%s' is invalid\n", map_name);
-		return -BPF_LOADER_ERRNO__INTERNAL;
-	}
-
-	for (i = 0; i < array->nr_ranges; i++) {
-		unsigned int start = array->ranges[i].start;
-		size_t length = array->ranges[i].length;
-		unsigned int idx = start + length - 1;
-
-		if (idx >= bpf_map__max_entries(map)) {
-			pr_debug("ERROR: index %d too large\n", idx);
-			return -BPF_LOADER_ERRNO__OBJCONF_MAP_IDX2BIG;
-		}
-	}
-	return 0;
-}
-
 static int
 bpf__obj_config_map(struct bpf_object *obj,
 		    struct parse_events_term *term,
@@ -1525,12 +1461,6 @@ bpf__obj_config_map(struct bpf_object *obj,
 		goto out;
 	}
 
-	*key_scan_pos += strlen(map_opt);
-	err = config_map_indices_range_check(term, map, map_name);
-	if (err)
-		goto out;
-	*key_scan_pos -= strlen(map_opt);
-
 	for (i = 0; i < ARRAY_SIZE(bpf_obj_config__map_funcs); i++) {
 		struct bpf_obj_config__map_func *func =
 				&bpf_obj_config__map_funcs[i];
@@ -1579,7 +1509,6 @@ typedef int (*map_config_func_t)(const char *name, int map_fd,
 				 const struct bpf_map *map,
 				 struct bpf_map_op *op,
 				 void *pkey, void *arg);
-
 static int
 foreach_key_array_all(map_config_func_t func,
 		      void *arg, const char *name,
@@ -1600,32 +1529,6 @@ foreach_key_array_all(map_config_func_t func,
 	return 0;
 }
 
-static int
-foreach_key_array_ranges(map_config_func_t func, void *arg,
-			 const char *name, int map_fd,
-			 const struct bpf_map *map,
-			 struct bpf_map_op *op)
-{
-	unsigned int i, j;
-	int err;
-
-	for (i = 0; i < op->k.array.nr_ranges; i++) {
-		unsigned int start = op->k.array.ranges[i].start;
-		size_t length = op->k.array.ranges[i].length;
-
-		for (j = 0; j < length; j++) {
-			unsigned int idx = start + j;
-
-			err = func(name, map_fd, map, op, &idx, arg);
-			if (err) {
-				pr_debug("ERROR: failed to insert value to %s[%u]\n",
-					 name, idx);
-				return err;
-			}
-		}
-	}
-	return 0;
-}
 
 static int
 bpf_map_config_foreach_key(struct bpf_map *map,
@@ -1666,10 +1569,6 @@ bpf_map_config_foreach_key(struct bpf_map *map,
 				err = foreach_key_array_all(func, arg, name,
 							    map_fd, map, op);
 				break;
-			case BPF_MAP_KEY_RANGES:
-				err = foreach_key_array_ranges(func, arg, name,
-							       map_fd, map, op);
-				break;
 			default:
 				pr_debug("ERROR: keytype for map '%s' invalid\n",
 					 name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0e2004511cf5..70841b0febf3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2717,9 +2717,6 @@ int parse_events_term__clone(struct parse_events_term **new,
 
 void parse_events_term__delete(struct parse_events_term *term)
 {
-	if (term->array.nr_ranges)
-		zfree(&term->array.ranges);
-
 	if (term->type_val != PARSE_EVENTS__TERM_TYPE_NUM)
 		zfree(&term->val.str);
 
@@ -2770,11 +2767,6 @@ void parse_events_terms__delete(struct list_head *terms)
 	free(terms);
 }
 
-void parse_events__clear_array(struct parse_events_array *a)
-{
-	zfree(&a->ranges);
-}
-
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e59b33805886..b77ff619a623 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -81,17 +81,8 @@ enum {
 	__PARSE_EVENTS__TERM_TYPE_NR,
 };
 
-struct parse_events_array {
-	size_t nr_ranges;
-	struct {
-		unsigned int start;
-		size_t length;
-	} *ranges;
-};
-
 struct parse_events_term {
 	char *config;
-	struct parse_events_array array;
 	union {
 		char *str;
 		u64  num;
@@ -162,7 +153,6 @@ int parse_events_term__clone(struct parse_events_term **new,
 void parse_events_term__delete(struct parse_events_term *term);
 void parse_events_terms__delete(struct list_head *terms);
 void parse_events_terms__purge(struct list_head *terms);
-void parse_events__clear_array(struct parse_events_array *a);
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
 int parse_events_name(struct list_head *list, const char *name);
-- 
2.41.0.487.g6d72f3e995-goog


