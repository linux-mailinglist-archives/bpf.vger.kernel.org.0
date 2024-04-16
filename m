Return-Path: <bpf+bounces-26898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8094E8A6392
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C35B243D7
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161FF7F7F5;
	Tue, 16 Apr 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4SjUfhK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8271B50
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248165; cv=none; b=mumekIMY9d1VsZg1cWCLEMtEfypBHIC4no/4heubwPeVRTQIgxxCSWQpubrm7x4UgFLY5hq/Zw1RzBaIkG4+F1XP+oDlmOTlYKzXRKGmfdx8GxFhD6xBXHrM4eGGZZ5vSwi1L3hj7yvKvbWdoSLxUefbOoJ4MjSgwauqR4LJCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248165; c=relaxed/simple;
	bh=qTcWKln4Bv6yJVZEBzUGSZ6Dxr+KFG7fKA4y6PwELqs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PP5vg90+VFIZ3YqS/VrCbfWB3atsnf2GC4xlXJE3BGgOxcRNzZ9dCL4sVmRh9Ey4YvXrbyGd0rLzXa3rCfwtB+H3fH31WI7yUT0NcBZVANPiuULrv5ZtkdfrDN990Su1PoU/HGMvSSuHa7rlvsj5F2hmXJI+bfB65NeNwfJxNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s4SjUfhK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61acc68c1bdso16319767b3.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248163; x=1713852963; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OT8KC34fIpe9dV5ekpHBVAc8u9M7U+9LMtZzVFuRsJU=;
        b=s4SjUfhKJyRgAT6fUUjZdmGIc4WwhFeFWN5I5apS5tOGuGq+v/Xg+w/JIzyZ6AqNyE
         Pxvxr0+OGCENQcsegXFnbl8wg6kZKp6Mo08AuLKpXRh9BQY0woEkMT0ARk0zG/RXTq2v
         i4eN2J+w1gNsRSzc3wbEvJLXl4v/dc/fKDEgYpn4abWZ8WIPizvA3PTgqnvZQ70lAUN+
         IPtaemc2OHLIPiFb8cOl3yrvnqSIRybYpnJg9ECZz5rFj4LPJCZdCGfjz6LxzGKHmKxS
         VWRYRfzio6pUwlaLOjP6yW8FHfmlDfcmIQH1SkprjP34j6+aur3B54+0rk5agCxLoAuI
         vJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248163; x=1713852963;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OT8KC34fIpe9dV5ekpHBVAc8u9M7U+9LMtZzVFuRsJU=;
        b=LfxYofeLSXfZS7Zk6BLq5B2XRzUDzmhDGQ8WbCCBcYE8Nfx/oHK6s8HY2SaTUw3ZaV
         Qn90fzhli1sNUevVGOM0G572ZDaIu+QIHJ2XvSZ9RlBjtavrjBInVBFQwYJomlCjcMrQ
         4dapn8+MF/2CMVemDRgIgBmmo24TFxRlFwz0+cdnC9gkZh3noWN37QOibkSBpwUtq+6l
         AUR0M8xrQSGlMLi7G70bLncp4fDND83xh0lD1f6LjlBo95AW0Df8WZEvQKIfLhDDowtH
         TvIfDxJzoMbAw7ya9SpiLrzmWjHFxRjnQqEnEUsAQF8vo41cH9rFBHqBCYKBs7NJPIgM
         LH6g==
X-Forwarded-Encrypted: i=1; AJvYcCWnck1V2TOE2cl9GEHaBK9IRoFjHLQG+xE1tSNiAzJPARVFRnhYZUHnJiR+tFLFHbvNK9/NQcWtKQ7E7cx455f1JgVc
X-Gm-Message-State: AOJu0YwCJ18n0WXEZO6M9RHftw5Sa3bwVb0i1PIIc/qmnNIpWwLys0u7
	HAVobVWifbsqEIkPxZE2gL/wz4+O8OzDx+/oRctWRG/WC0/+xRYfNSGVEEiIULA/EuowOkVUh0R
	okwu7ow==
X-Google-Smtp-Source: AGHT+IFBtPJYigu1UNX+GxG1HR1ZdO9/jLJVgWPHL5U4mEa5M4iyJ8CDK6Wzt09A6xnIJAoSUf1Qycy+LsVf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:c0c:b0:dd9:20c1:85b6 with SMTP id
 fs12-20020a0569020c0c00b00dd920c185b6mr576115ybb.2.1713248162866; Mon, 15 Apr
 2024 23:16:02 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:24 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 08/16] perf parse-events: Constify parse_events_add_numeric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Allow the term list to be const so that other functions can pass const
term lists. Add const as necessary to called functions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 20 +++++++++++---------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1440a3b4b674..1b408e3dccc7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -34,7 +34,8 @@
 #ifdef PARSER_DEBUG
 extern int parse_events_debug;
 #endif
-static int get_config_terms(struct parse_events_terms *head_config, struct list_head *head_terms);
+static int get_config_terms(const struct parse_events_terms *head_config,
+			    struct list_head *head_terms);
 static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
 
@@ -154,7 +155,7 @@ const char *event_type(int type)
 	return "unknown";
 }
 
-static char *get_config_str(struct parse_events_terms *head_terms,
+static char *get_config_str(const struct parse_events_terms *head_terms,
 			    enum parse_events__term_type type_term)
 {
 	struct parse_events_term *term;
@@ -169,12 +170,12 @@ static char *get_config_str(struct parse_events_terms *head_terms,
 	return NULL;
 }
 
-static char *get_config_metric_id(struct parse_events_terms *head_terms)
+static char *get_config_metric_id(const struct parse_events_terms *head_terms)
 {
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_METRIC_ID);
 }
 
-static char *get_config_name(struct parse_events_terms *head_terms)
+static char *get_config_name(const struct parse_events_terms *head_terms)
 {
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
@@ -358,7 +359,7 @@ static int config_term_common(struct perf_event_attr *attr,
 			      struct parse_events_term *term,
 			      struct parse_events_error *err);
 static int config_attr(struct perf_event_attr *attr,
-		       struct parse_events_terms *head,
+		       const struct parse_events_terms *head,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term);
 
@@ -1108,7 +1109,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 #endif
 
 static int config_attr(struct perf_event_attr *attr,
-		       struct parse_events_terms *head,
+		       const struct parse_events_terms *head,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term)
 {
@@ -1121,7 +1122,8 @@ static int config_attr(struct perf_event_attr *attr,
 	return 0;
 }
 
-static int get_config_terms(struct parse_events_terms *head_config, struct list_head *head_terms)
+static int get_config_terms(const struct parse_events_terms *head_config,
+			    struct list_head *head_terms)
 {
 #define ADD_CONFIG_TERM(__type, __weak)				\
 	struct evsel_config_term *__t;			\
@@ -1325,7 +1327,7 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 				struct list_head *list,
 				struct perf_pmu *pmu, u32 type, u32 extended_type,
-				u64 config, struct parse_events_terms *head_config)
+				u64 config, const struct parse_events_terms *head_config)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -1361,7 +1363,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
-			     struct parse_events_terms *head_config,
+			     const struct parse_events_terms *head_config,
 			     bool wildcard)
 {
 	struct perf_pmu *pmu = NULL;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index db47913e54bc..5005782766e9 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -196,7 +196,7 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     struct list_head *list,
 			     u32 type, u64 config,
-			     struct parse_events_terms *head_config,
+			     const struct parse_events_terms *head_config,
 			     bool wildcard);
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
-- 
2.44.0.683.g7961c838ac-goog


