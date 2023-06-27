Return-Path: <bpf+bounces-3593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F947402F9
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D05E1C20492
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF61ACDE;
	Tue, 27 Jun 2023 18:11:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9441308B
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:11:12 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6E2D48
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:11:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57320c10635so61562607b3.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889467; x=1690481467;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StcgeFnI4n9LLLvk4G7O6CbzjZValP2DfB//GyhRxDI=;
        b=7fT/jL8m9VFgKdPRPOi4B5qlF4mYEdel0EQFlq0HfSkH8ap+Sk7AXUq4SgGGOkq6RF
         vfeOeoptamRzNTV5P2QRXdwht66ZNBjz8u98EcDYBkOk5W5sk81TsFV9qyXqHoaLs5sz
         E5tOga4zvvyQTk4erCcpikGhS6PUt6Oc9Xd+6YmkRck6UxZYnnUgH8A4kWHHIPYokdBQ
         W2Gu5kN7E/p20ktY0+1JrqRVWCg926kaGSbVpEx21KKT4uQeK+YXeu6Rl2a1e1EhLoGT
         LmeExdSr0MympjvgYodvQf5FrL+HMOsnsKqVhELrLn+KZ5dsnyBKiaXvhd4/xD7s7Ok3
         Okdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889467; x=1690481467;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StcgeFnI4n9LLLvk4G7O6CbzjZValP2DfB//GyhRxDI=;
        b=SZN5fE1EYAIlRvckjcEGXKwk0+EgNJFov2NM+PlBECEeBQqRCtPE5bQNUCkneUftAP
         szn1l7Pfc7O8gAwz+Dv5vbt1XdOrrp5/F4H1vgWx6Zr1cLbK9t8gCKNQtGJujWxad6p4
         HJ74ax8+ZsYvgILspx0+MiZWE58YXLTMmjlaxVNaKLX/Slkwf9owH8T0KadYJaQrd3bx
         sTYjMOJ0vJQMglUawq41/x5O+lnl6zuVWfHKzo4wtRNDQwtdxIjL41X4kgha+33Eg0hC
         9azswNjtiL5GfXyXBR8bbrOnWFeRBY3CqvRnqZV2kH+jR9fsgyaW4UxQ2dWnNIOk9wsp
         qL3g==
X-Gm-Message-State: AC+VfDxLSoh5H8l2l7c89FXaCB6a9SvPUpc23qa1+36gmL+3RoZMxu43
	BTOAGDUAD3SwVZl8076+gdW5Q0r+mA2b
X-Google-Smtp-Source: ACHHUZ5Op7YTRWS0VwHR9qRGvjW0o4XHD6oxkOBCTvBdbBFCZ4OTsZUg/zDMYyJ9dDx9txiWTt/otuxf8T0X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a0d:ec4a:0:b0:56d:21a1:16a1 with SMTP id
 r10-20020a0dec4a000000b0056d21a116a1mr13933293ywn.5.1687889467366; Tue, 27
 Jun 2023 11:11:07 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:28 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 11/13] perf parse-events: Populate error column for
 BPF/tracepoint events
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
 tools/perf/util/parse-events.c | 80 ++++++++++++++++++++--------------
 tools/perf/util/parse-events.h |  8 ++--
 tools/perf/util/parse-events.y |  6 +--
 4 files changed, 57 insertions(+), 39 deletions(-)

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
index f31f233e395f..fdd304fbed7c 100644
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
@@ -1433,8 +1448,9 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 int parse_events_add_tracepoint(struct list_head *list, int *idx,
 				const char *sys, const char *event,
 				struct parse_events_error *err,
-				struct list_head *head_config)
+				struct list_head *head_config, void *loc_)
 {
+	YYLTYPE *loc = loc_;
 #ifdef HAVE_LIBTRACEEVENT
 	if (head_config) {
 		struct perf_event_attr attr;
@@ -1446,17 +1462,17 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 
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
 	(void)sys;
 	(void)event;
 	(void)head_config;
-	parse_events_error__handle(err, 0, strdup("unsupported tracepoint"),
+	parse_events_error__handle(err, loc->first_column, strdup("unsupported tracepoint"),
 				strdup("libtraceevent is necessary for tracepoint support"));
 	return -1;
 #endif
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


