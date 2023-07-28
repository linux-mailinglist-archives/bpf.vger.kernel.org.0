Return-Path: <bpf+bounces-6114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC3876609A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99C12824C3
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8E15C1;
	Fri, 28 Jul 2023 00:13:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874BB15A7
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:13:01 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ACE26B8
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:12:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d05883d850fso1420971276.3
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503178; x=1691107978;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2X6P0O3eO5DQvKAy3ylMNjel4qFpAR57C+PYmMuzQU=;
        b=Y58fZa/86hus7myw8y86G52HiOjYIdlaYA635qPWRhwD2vNtngQenxs9RIRvQMrUgc
         NRC27Iscw9fdzF7djOURbiRmfnafMR/LbEzenpccF2wZLu9JiYcPLldpTnkQZhgwklMN
         J9I5bpiMOo08+jJyWmqAfjUtJ802yYQZxtDQNufCu8ph4jbYYkoNVj9sK8hLGoJuKWJ2
         Ee/tmyAWBEA9qXiEX9b1SGDZpTFdV4IL65VFg/AHzH96x3hSAtN6eH6D9Cowo2uyE5KS
         S9VRcVtciLxXshxUVod7FYAGujCcTk99A3IRq37Dy6R0TJTOAHQAeOevmh+oT9LRSFc5
         qYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503178; x=1691107978;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2X6P0O3eO5DQvKAy3ylMNjel4qFpAR57C+PYmMuzQU=;
        b=HDhGDRqybFvpP65CSZvDW2JrU7IJlhvQAjDI+82wf1pYxFPxOk+HJLYcXMN3PuQXah
         u55601V96KwueAFifrPmlztyb8FWzTgJeM6NDy5vkSxJaXviRDVJ4gW4PhxSriJZT0Xe
         l0TgmIlxkjQoK13mDWjqA471HDs0llQ5/7REJQN0ZenuYrFn7+bVUBDZzy+8HQXiSQIo
         uvuoV63U1J5Jav8jysbTTZhPvFp5UVIU88DLetgv4NdpUrC9mo34ZYPJMnm/5uqhF+PU
         kNseLTLGQtmldlz361sUsGKQvCL3P7iZxcjJycbXAwtI50+kK12y00fCcUsgx0C1XtPw
         cc6Q==
X-Gm-Message-State: ABy/qLY/pCCUzdOzNz8PN8t/2DORS6leTpuR9XKmeWzbs39ruQIfTxBi
	ETaDzI5jxRUYUvVKKPpZlO8kLxCk8eUW
X-Google-Smtp-Source: APBJJlGSAV/rnlFF9CkbzbttCzE5bHg41Ew3k+XBgmlwzxDfboXGQ6bbIaw0qztWoGPiL3DK8LPTakkE2IqH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a05:6902:1804:b0:d07:cb52:a3cf with SMTP
 id cf4-20020a056902180400b00d07cb52a3cfmr917ybb.5.1690503178333; Thu, 27 Jul
 2023 17:12:58 -0700 (PDT)
Date: Thu, 27 Jul 2023 17:12:11 -0700
In-Reply-To: <20230728001212.457900-1-irogers@google.com>
Message-Id: <20230728001212.457900-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728001212.457900-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 2/3] perf tools: Revert enable indices setting syntax for
 BPF map
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

This reverts commit e571e029bdbf ("perf tools: Enable indices setting
syntax for BPF map").

The reverted commit added a notion of arrays that could be set as
event terms for BPF events. The parsing hasn't worked over multiple
Linux releases. Given the broken nature of the parsing it appears the
code isn't in use, nor could I find a way for it to be used to add a
test.

The original commit contains a test in the commit message,
however, running it yields:
```
$ perf record -e './test_bpf_map_3.c/map:channel.value[0,1,2,3...5]=101/' usleep 2
event syntax error: '..pf_map_3.c/map:channel.value[0,1,2,3...5]=101/'
                                  \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Given the code can't be used this commit reverts and removes it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |   8 +--
 tools/perf/util/parse-events.l |  11 ---
 tools/perf/util/parse-events.y | 122 ---------------------------------
 3 files changed, 1 insertion(+), 140 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 02647313c918..0e2004511cf5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -800,13 +800,7 @@ parse_events_config_bpf(struct parse_events_state *parse_state,
 
 			parse_events_error__handle(parse_state->error, idx,
 						strdup(errbuf),
-						strdup(
-"Hint:\tValid config terms:\n"
-"     \tmap:[<arraymap>].value<indices>=[value]\n"
-"     \tmap:[<eventmap>].event<indices>=[event]\n"
-"\n"
-"     \twhere <indices> is something like [0,3...5] or [all]\n"
-"     \t(add -v to see detail)"));
+						NULL);
 			return err;
 		}
 	}
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 99335ec586ae..d7d084cc4140 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -175,7 +175,6 @@ do {							\
 %x mem
 %s config
 %x event
-%x array
 
 group		[^,{}/]*[{][^}]*[}][^,{}/]*
 event_pmu	[^,{}/]+[/][^/]*[/][^,{}/]*
@@ -251,14 +250,6 @@ non_digit	[^0-9]
 		}
 }
 
-<array>{
-"]"			{ BEGIN(config); return ']'; }
-{num_dec}		{ return value(yyscanner, 10); }
-{num_hex}		{ return value(yyscanner, 16); }
-,			{ return ','; }
-"\.\.\."		{ return PE_ARRAY_RANGE; }
-}
-
 <config>{
 	/*
 	 * Please update config_term_names when new static term is added.
@@ -302,8 +293,6 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 {lc_type}-{lc_op_result}	{ return lc_str(yyscanner, _parse_state); }
 {lc_type}-{lc_op_result}-{lc_op_result}	{ return lc_str(yyscanner, _parse_state); }
 {name_minus}		{ return str(yyscanner, PE_NAME); }
-\[all\]			{ return PE_ARRAY_ALL; }
-"["			{ BEGIN(array); return '['; }
 @{drv_cfg_term}		{ return drv_str(yyscanner, PE_DRV_CFG_TERM); }
 }
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 454577f7aff6..5a90e7874c59 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -64,7 +64,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM
 %token PE_ERROR
-%token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
 %type <num> PE_VALUE
@@ -108,11 +107,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <list_evsel> groups
 %destructor { free_list_evsel ($$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
-%destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
-%type <array> array
-%type <array> array_term
-%type <array> array_terms
-%destructor { free ($$.ranges); } <array>
 %type <hardware_term> PE_TERM_HW
 %destructor { free ($$.str); } <hardware_term>
 
@@ -127,7 +121,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 		char *sys;
 		char *event;
 	} tracepoint_name;
-	struct parse_events_array array;
 	struct hardware_term {
 		char *str;
 		u64 num;
@@ -878,121 +871,6 @@ PE_TERM
 
 	$$ = term;
 }
-|
-name_or_raw array '=' name_or_legacy
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER, $1, $4, &@1, &@4);
-
-	if (err) {
-		free($1);
-		free($4);
-		free($2.ranges);
-		PE_ABORT(err);
-	}
-	term->array = $2;
-	$$ = term;
-}
-|
-name_or_raw array '=' PE_VALUE
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER, $1, $4, false, &@1, &@4);
-
-	if (err) {
-		free($1);
-		free($2.ranges);
-		PE_ABORT(err);
-	}
-	term->array = $2;
-	$$ = term;
-}
-|
-PE_DRV_CFG_TERM
-{
-	struct parse_events_term *term;
-	char *config = strdup($1);
-	int err;
-
-	if (!config)
-		YYNOMEM;
-	err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG, config, $1, &@1, NULL);
-	if (err) {
-		free($1);
-		free(config);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-
-array:
-'[' array_terms ']'
-{
-	$$ = $2;
-}
-|
-PE_ARRAY_ALL
-{
-	$$.nr_ranges = 0;
-	$$.ranges = NULL;
-}
-
-array_terms:
-array_terms ',' array_term
-{
-	struct parse_events_array new_array;
-
-	new_array.nr_ranges = $1.nr_ranges + $3.nr_ranges;
-	new_array.ranges = realloc($1.ranges,
-				sizeof(new_array.ranges[0]) *
-				new_array.nr_ranges);
-	if (!new_array.ranges)
-		YYNOMEM;
-	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
-	       $3.nr_ranges * sizeof(new_array.ranges[0]));
-	free($3.ranges);
-	$$ = new_array;
-}
-|
-array_term
-
-array_term:
-PE_VALUE
-{
-	struct parse_events_array array;
-
-	array.nr_ranges = 1;
-	array.ranges = malloc(sizeof(array.ranges[0]));
-	if (!array.ranges)
-		YYNOMEM;
-	array.ranges[0].start = $1;
-	array.ranges[0].length = 1;
-	$$ = array;
-}
-|
-PE_VALUE PE_ARRAY_RANGE PE_VALUE
-{
-	struct parse_events_array array;
-
-	if ($3 < $1) {
-		struct parse_events_state *parse_state = _parse_state;
-		struct parse_events_error *error = parse_state->error;
-		char *err_str;
-
-		if (asprintf(&err_str, "Expected '%ld' to be less-than '%ld'", $3, $1) < 0)
-			err_str = NULL;
-
-		parse_events_error__handle(error, @1.first_column, err_str, NULL);
-		YYABORT;
-	}
-	array.nr_ranges = 1;
-	array.ranges = malloc(sizeof(array.ranges[0]));
-	if (!array.ranges)
-		YYNOMEM;
-	array.ranges[0].start = $1;
-	array.ranges[0].length = $3 - $1 + 1;
-	$$ = array;
-}
 
 sep_dc: ':' |
 
-- 
2.41.0.487.g6d72f3e995-goog


