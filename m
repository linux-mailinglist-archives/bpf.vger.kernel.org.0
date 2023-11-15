Return-Path: <bpf+bounces-15120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098397ECCA4
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 20:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A27CB20C72
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45323364BE;
	Wed, 15 Nov 2023 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZPr2wdkK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71EE2837A;
	Wed, 15 Nov 2023 19:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B46C433C8;
	Wed, 15 Nov 2023 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700076694;
	bh=rVXS/lzMij99wDcGs6aFveFzNcjcqPW7RWrvhuR+5kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPr2wdkK7Hry2tp8fSyxO501L4sLSyXRj9tWmwRpsQo1+g9i4liXQEXih4TWh42Pu
	 wFwBU1BS8VZ7k3CNtmEDJLFBpN+hkIm8uP0IELDnjCUVhIo9hKuuoK8UYvSGMPafMJ
	 02Fz34PVT1vzoOn5NYjtEhszll8q60H3Q7AeCRAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	He Kuang <hekuang@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh@kernel.org>,
	Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	YueHaibing <yuehaibing@huawei.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 390/550] perf tools: Revert enable indices setting syntax for BPF map
Date: Wed, 15 Nov 2023 14:16:14 -0500
Message-ID: <20231115191627.878222623@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 30f4ade33d649aa0e8603386721f184ad9d3cb55 ]

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
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230728001212.457900-3-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: ede72dca45b1 ("perf parse-events: Fix tracepoint name memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.c |   8 +--
 tools/perf/util/parse-events.l |  11 ---
 tools/perf/util/parse-events.y | 122 ---------------------------------
 3 files changed, 1 insertion(+), 140 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 30311844eea7b..979fc92c2f47d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -793,13 +793,7 @@ parse_events_config_bpf(struct parse_events_state *parse_state,
 
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
index 99335ec586ae8..d7d084cc4140d 100644
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
index 24c9af561cf9d..8b25b964d6962 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -64,7 +64,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
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
2.42.0




