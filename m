Return-Path: <bpf+bounces-3534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3773F389
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254A81C20A88
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286B4A21;
	Tue, 27 Jun 2023 04:35:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621FF110C
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:48 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA01FCA
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c005a8ca4d9so5575716276.3
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840542; x=1690432542;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiJ8ZNCNGwHiEb8TLCiGLDomoSZXOF+wD/koznP4c2g=;
        b=7fjJC99dXgDa/DUvdZ05NUNwOn2nFf2J73fTB4QoGDSgKD7/o+iRCMPnBtQ1gfBbcK
         qhvODxU0a9aMYXSSHuqGWDhihIv91CfijR24twbkl0qiMC6bBS6TCNmeoq66oWbMB8kP
         9XVFaMffQHmVd0bTWsnP3vlICMufxFYjlQKEctH1wI5ovtimwP1LBBG4t7eEFBsyI1nz
         ae74vX4aSO8xDldBm+xDFGe/VhYyiCdD1Mw9qO3w1ls2qzKq6sOvc7z3WrFeYLvEaNi8
         zMgX9uBfIT14oj3IUefvpuaL83DAmr0Z4pgYzVAhLmTm0L+Kd6M0Sr88+vJbj0WKXtSJ
         Ayvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840542; x=1690432542;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiJ8ZNCNGwHiEb8TLCiGLDomoSZXOF+wD/koznP4c2g=;
        b=EFVkqw4zeCDwjVLcFB0Aj5aGG7UYnkwABrLcs4HfU/NIOwx3NBkFP7Mb6/aPWUlwzg
         zgsjEniGYXfDnr+9wyp6lhiqIrHASdAiW8MJ7zdadGzv+b5bnXct8q8FEe7wJnMA/1GY
         l4oeuDyR8HlE09B3ZxWMaysURZTvqzis2Hok9dEg/xPugWIXTzabJGNVt2KfEzohHMgt
         qiEKUphLHUB4pF/TMZi+lvVfNnXNEZE5KHwkzoaXtc3noHGUEzHi+9bJrRrSxe8gD1BT
         iV5OgAOSTMPPlcmI6CVNHUHaowSke1pj4UqzSqRwHBv0bbT8H8sHgybzl5QFyD/KXl5e
         QfQA==
X-Gm-Message-State: AC+VfDy5wkN1TnRISYtvWLoNc4uDOh1g5hDEUFdx5WK/mFUXcs699JmQ
	8FfpcBZPPUWzp/eH6T3P9MhprM+5JxCt
X-Google-Smtp-Source: ACHHUZ77SQjQwOLxhrHaNM0FigTNi4lEQKPe6pNfUqI9t4HXUTjKxIAHzFKYhPNv7WMxrfF92QgOi7UDKId7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:ac8d:0:b0:bc9:20c5:34a1 with SMTP id
 x13-20020a25ac8d000000b00bc920c534a1mr6696913ybi.5.1687840542707; Mon, 26 Jun
 2023 21:35:42 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:56 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 11/13] perf parse-events: Populate error column for BPF events
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

Follow convention from parse_events_terms__num/str and pass the
YYLTYPE for the location.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bpf.c         |  2 +-
 tools/perf/util/parse-events.c | 77 ++++++++++++++++++++--------------
 tools/perf/util/parse-events.h |  8 ++--
 tools/perf/util/parse-events.y |  6 +--
 4 files changed, 55 insertions(+), 38 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 8beb46066034..31796f2a80f4 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -124,7 +124,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	parse_state.error = &parse_error;
 	INIT_LIST_HEAD(&parse_state.list);
 
-	err = parse_events_load_bpf_obj(&parse_state, &parse_state.list, obj, NULL);
+	err = parse_events_load_bpf_obj(&parse_state, &parse_state.list, obj, NULL, NULL);
 	parse_events_error__exit(&parse_error);
 	if (err == -ENODATA) {
 		pr_debug("Failed to add events selected by BPF, debuginfo package not installed\n");
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f31f233e395f..a92545908626 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -499,7 +499,7 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 
 #ifdef HAVE_LIBTRACEEVENT
 static void tracepoint_error(struct parse_events_error *e, int err,
-			     const char *sys, const char *name)
+			     const char *sys, const char *name, int column)
 {
 	const char *str;
 	char help[BUFSIZ];
@@ -526,18 +526,19 @@ static void tracepoint_error(struct parse_events_error *e, int err,
 	}
 
 	tracing_path__strerror_open_tp(err, help, sizeof(help), sys, name);
-	parse_events_error__handle(e, 0, strdup(str), strdup(help));
+	parse_events_error__handle(e, column, strdup(str), strdup(help));
 }
 
 static int add_tracepoint(struct list_head *list, int *idx,
 			  const char *sys_name, const char *evt_name,
 			  struct parse_events_error *err,
-			  struct list_head *head_config)
+			  struct list_head *head_config, void *loc_)
 {
+	YYLTYPE *loc = loc_;
 	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, (*idx)++);
 
 	if (IS_ERR(evsel)) {
-		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name);
+		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
 		return PTR_ERR(evsel);
 	}
 
@@ -556,7 +557,7 @@ static int add_tracepoint(struct list_head *list, int *idx,
 static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 				      const char *sys_name, const char *evt_name,
 				      struct parse_events_error *err,
-				      struct list_head *head_config)
+				      struct list_head *head_config, YYLTYPE *loc)
 {
 	char *evt_path;
 	struct dirent *evt_ent;
@@ -565,13 +566,13 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 
 	evt_path = get_events_file(sys_name);
 	if (!evt_path) {
-		tracepoint_error(err, errno, sys_name, evt_name);
+		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
 		return -1;
 	}
 	evt_dir = opendir(evt_path);
 	if (!evt_dir) {
 		put_events_file(evt_path);
-		tracepoint_error(err, errno, sys_name, evt_name);
+		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
 		return -1;
 	}
 
@@ -588,11 +589,11 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 		found++;
 
 		ret = add_tracepoint(list, idx, sys_name, evt_ent->d_name,
-				     err, head_config);
+				     err, head_config, loc);
 	}
 
 	if (!found) {
-		tracepoint_error(err, ENOENT, sys_name, evt_name);
+		tracepoint_error(err, ENOENT, sys_name, evt_name, loc->first_column);
 		ret = -1;
 	}
 
@@ -604,19 +605,19 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 static int add_tracepoint_event(struct list_head *list, int *idx,
 				const char *sys_name, const char *evt_name,
 				struct parse_events_error *err,
-				struct list_head *head_config)
+				struct list_head *head_config, YYLTYPE *loc)
 {
 	return strpbrk(evt_name, "*?") ?
-	       add_tracepoint_multi_event(list, idx, sys_name, evt_name,
-					  err, head_config) :
-	       add_tracepoint(list, idx, sys_name, evt_name,
-			      err, head_config);
+		add_tracepoint_multi_event(list, idx, sys_name, evt_name,
+					   err, head_config, loc) :
+		add_tracepoint(list, idx, sys_name, evt_name,
+			       err, head_config, loc);
 }
 
 static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 				    const char *sys_name, const char *evt_name,
 				    struct parse_events_error *err,
-				    struct list_head *head_config)
+				    struct list_head *head_config, YYLTYPE *loc)
 {
 	struct dirent *events_ent;
 	DIR *events_dir;
@@ -624,7 +625,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 
 	events_dir = tracing_events__opendir();
 	if (!events_dir) {
-		tracepoint_error(err, errno, sys_name, evt_name);
+		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
 		return -1;
 	}
 
@@ -640,7 +641,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 			continue;
 
 		ret = add_tracepoint_event(list, idx, events_ent->d_name,
-					   evt_name, err, head_config);
+					   evt_name, err, head_config, loc);
 	}
 
 	closedir(events_dir);
@@ -653,6 +654,7 @@ struct __add_bpf_event_param {
 	struct parse_events_state *parse_state;
 	struct list_head *list;
 	struct list_head *head_config;
+	YYLTYPE *loc;
 };
 
 static int add_bpf_event(const char *group, const char *event, int fd, struct bpf_object *obj,
@@ -679,7 +681,7 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 
 	err = parse_events_add_tracepoint(&new_evsels, &parse_state->idx, group,
 					  event, parse_state->error,
-					  param->head_config);
+					  param->head_config, param->loc);
 	if (err) {
 		struct evsel *evsel, *tmp;
 
@@ -706,12 +708,14 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 			      struct list_head *list,
 			      struct bpf_object *obj,
-			      struct list_head *head_config)
+			      struct list_head *head_config,
+			      void *loc)
 {
 	int err;
 	char errbuf[BUFSIZ];
-	struct __add_bpf_event_param param = {parse_state, list, head_config};
+	struct __add_bpf_event_param param = {parse_state, list, head_config, loc};
 	static bool registered_unprobe_atexit = false;
+	YYLTYPE test_loc = {.first_column = -1};
 
 	if (IS_ERR(obj) || !obj) {
 		snprintf(errbuf, sizeof(errbuf),
@@ -742,6 +746,9 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 		goto errout;
 	}
 
+	if (!param.loc)
+		param.loc = &test_loc;
+
 	err = bpf__foreach_event(obj, add_bpf_event, &param);
 	if (err) {
 		snprintf(errbuf, sizeof(errbuf),
@@ -751,7 +758,7 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 
 	return 0;
 errout:
-	parse_events_error__handle(parse_state->error, 0,
+	parse_events_error__handle(parse_state->error, param.loc->first_column,
 				strdup(errbuf), strdup("(add -v to see detail)"));
 	return err;
 }
@@ -839,11 +846,13 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  char *bpf_file_name,
 			  bool source,
-			  struct list_head *head_config)
+			  struct list_head *head_config,
+			  void *loc_)
 {
 	int err;
 	struct bpf_object *obj;
 	LIST_HEAD(obj_head_config);
+	YYLTYPE *loc = loc_;
 
 	if (head_config)
 		split_bpf_config_terms(head_config, &obj_head_config);
@@ -863,12 +872,12 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
 						   -err, errbuf,
 						   sizeof(errbuf));
 
-		parse_events_error__handle(parse_state->error, 0,
+		parse_events_error__handle(parse_state->error, loc->first_column,
 					strdup(errbuf), strdup("(add -v to see detail)"));
 		return err;
 	}
 
-	err = parse_events_load_bpf_obj(parse_state, list, obj, head_config);
+	err = parse_events_load_bpf_obj(parse_state, list, obj, head_config, loc);
 	if (err)
 		return err;
 	err = parse_events_config_bpf(parse_state, obj, &obj_head_config);
@@ -885,9 +894,12 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
 int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 			      struct list_head *list __maybe_unused,
 			      struct bpf_object *obj __maybe_unused,
-			      struct list_head *head_config __maybe_unused)
+			      struct list_head *head_config __maybe_unused,
+			      void *loc_)
 {
-	parse_events_error__handle(parse_state->error, 0,
+	YYLTYPE *loc = loc_;
+
+	parse_events_error__handle(parse_state->error, loc->first_column,
 				   strdup("BPF support is not compiled"),
 				   strdup("Make sure libbpf-devel is available at build time."));
 	return -ENOTSUP;
@@ -897,9 +909,12 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
 			  struct list_head *list __maybe_unused,
 			  char *bpf_file_name __maybe_unused,
 			  bool source __maybe_unused,
-			  struct list_head *head_config __maybe_unused)
+			  struct list_head *head_config __maybe_unused,
+			  void *loc_)
 {
-	parse_events_error__handle(parse_state->error, 0,
+	YYLTYPE *loc = loc_;
+
+	parse_events_error__handle(parse_state->error, loc->first_column,
 				   strdup("BPF support is not compiled"),
 				   strdup("Make sure libbpf-devel is available at build time."));
 	return -ENOTSUP;
@@ -1433,7 +1448,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 int parse_events_add_tracepoint(struct list_head *list, int *idx,
 				const char *sys, const char *event,
 				struct parse_events_error *err,
-				struct list_head *head_config)
+				struct list_head *head_config, void *loc)
 {
 #ifdef HAVE_LIBTRACEEVENT
 	if (head_config) {
@@ -1446,10 +1461,10 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 
 	if (strpbrk(sys, "*?"))
 		return add_tracepoint_multi_sys(list, idx, sys, event,
-						err, head_config);
+						err, head_config, loc);
 	else
 		return add_tracepoint_event(list, idx, sys, event,
-					    err, head_config);
+					    err, head_config, loc);
 #else
 	(void)list;
 	(void)idx;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b37e5ee193a8..cabbe70adb82 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -169,18 +169,20 @@ int parse_events_name(struct list_head *list, const char *name);
 int parse_events_add_tracepoint(struct list_head *list, int *idx,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
-				struct list_head *head_config);
+				struct list_head *head_config, void *loc);
 int parse_events_load_bpf(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  char *bpf_file_name,
 			  bool source,
-			  struct list_head *head_config);
+			  struct list_head *head_config,
+			  void *loc);
 /* Provide this function for perf test */
 struct bpf_object;
 int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 			      struct list_head *list,
 			      struct bpf_object *obj,
-			      struct list_head *head_config);
+			      struct list_head *head_config,
+			      void *loc);
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index a636a7db6e6f..50f5b819de37 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -567,7 +567,7 @@ tracepoint_name opt_event_config
 		error->idx = @1.first_column;
 
 	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
-					error, $2);
+					error, $2, &@1);
 
 	parse_events_terms__delete($2);
 	free($1.sys);
@@ -640,7 +640,7 @@ PE_BPF_OBJECT opt_event_config
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	err = parse_events_load_bpf(parse_state, list, $1, false, $2);
+	err = parse_events_load_bpf(parse_state, list, $1, false, $2, &@1);
 	parse_events_terms__delete($2);
 	free($1);
 	if (err) {
@@ -658,7 +658,7 @@ PE_BPF_SOURCE opt_event_config
 	list = alloc_list();
 	if (!list)
 		YYNOMEM;
-	err = parse_events_load_bpf(_parse_state, list, $1, true, $2);
+	err = parse_events_load_bpf(_parse_state, list, $1, true, $2, &@1);
 	parse_events_terms__delete($2);
 	if (err) {
 		free(list);
-- 
2.41.0.162.gfafddb0af9-goog


