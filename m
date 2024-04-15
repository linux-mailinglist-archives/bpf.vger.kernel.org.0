Return-Path: <bpf+bounces-26748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039C8A483E
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE341F226B9
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF69539FF4;
	Mon, 15 Apr 2024 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LE1BPs3L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EF1C69D
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163012; cv=none; b=FvxSolHyrCRst+QmBOIydzF0snlvkUgiwU1qJcx+6Y//pZvSaZ39yn8sBNsb2b+0K5FEWeQzKAjVWT9eGGstGlqD0XKXRRD9v3dKKhXRsSSLIjFVvEWNc+IFvvE39RtfWskUMUUju504QwNc2A9YTFdnrDuoSbiR9wKQoxJoZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163012; c=relaxed/simple;
	bh=YnUF3ceBTuEWLeyH8vOqzQm1Yqq/JnFb2jhfnx6s9QU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eAzVDG5SknwDqBbJL6IRwmUMlQLyiDT8SAc5knxr29yxT22ZF8s+QD0dE2xkpnyQQMIGD9JJkIh2WJYAPav9S7vAyvucUOMZZOP9VQzkoRHxyRPZGaWNi3WBGkxGoPqEgdjzPauwA5iUD4SPBhxkQXlXxOftut1AihpHhD6FvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LE1BPs3L; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so5317345276.0
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163010; x=1713767810; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsM8Y1cj6kmrsHpwiXYtXKur/DOQuLkG4gE86ZL8CEk=;
        b=LE1BPs3LcUYqEEl7YNf0MJSUzYbOnMtITFXjBs0w/nJE4yjQuInhXMvMerZjwquSkA
         NzX3yJwHs29EN8taGYBGLrELzTH0Kf15s2wO96zuSMMbOkZESkJyFV8rx+WaahyXYT4s
         nSqAyZySXkYbvjHkSQ+gcej82kbT3h88QPEtmqa0ymaaBLXCAfgkyD66Y/2rjcB+wI1W
         GBCHKu5luo+nuIw61j6J1P9AeKWcgR8x2AhYaUjKBxbr7YvL1GiW9Uw6pYMUzhX0OSOW
         47XT7fDOJ0BB1EniV6eEEGXl6KnDp8oZwL8qBXdwfA77OKE4R007+Bs6HFyPwcAjHOnf
         CCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163010; x=1713767810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsM8Y1cj6kmrsHpwiXYtXKur/DOQuLkG4gE86ZL8CEk=;
        b=vh1Tzod/xX7hitv8OJ462Pgnzg16WJpHk6eQa+TCX/ToUGCHjs8nJbNZOewq15K1Ym
         QZUcfrJETTIGX4RyDrDjreroKudloLkpoRN1/DnH0y2Wqs70nJ2fuDKAynhwCSGEJwma
         8eNZQPzPVSVMVYwnly3SEl6a7P5/8664VV1ewPqlxD4HkimvRSPXR/kNFpRN9cAVEzeJ
         GgtIE0lPBr7WvuFGii/lWuxYWlGQAvqC8iglLwD9Rs+oUgFUpmvK6/50sXuGmXOwkPhj
         sCExGhpmpt6LNUTuRIQKOq6GiZgSbphG9+bYu+kKGqZWvbYdp2OTr+eD9eLl8M1BhW53
         OwZw==
X-Forwarded-Encrypted: i=1; AJvYcCVNPFY3jbB1ZCIpMx4bAzUzEBMMN4DBYcVZSjMC00DgOtgp+Bo8D5PS3PQWErvKsFWOx4sMjhdeHfXZSmsqm7UdfuV/
X-Gm-Message-State: AOJu0Yw+/LMHnP7UbHddoku9Fo8+8+c6QeUmbS7u0mIEtq8kZxzmrUve
	8HlDihL7G5b4skpkS3h5apLDIhTG9/8542yZfKZnYfeYn/7kO9o0F3P2oPxsfjqDtti69IUghJ4
	YQ4WFvA==
X-Google-Smtp-Source: AGHT+IGgmCtdEtZrTu/VTbHRcGxy01TSWSnKf6exxI0DVUKXLBA7LgeFtUQlO61tu+Bc2rAGxXCSISNxPEr+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:6902:1549:b0:dc6:dfd9:d431 with SMTP
 id r9-20020a056902154900b00dc6dfd9d431mr2983582ybu.1.1713163009901; Sun, 14
 Apr 2024 23:36:49 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:25 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 8/9] perf parse-events: Constify parse_events_add_numeric
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
index f711ad9b18f0..50c4012c737e 100644
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
 
@@ -1107,7 +1108,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 #endif
 
 static int config_attr(struct perf_event_attr *attr,
-		       struct parse_events_terms *head,
+		       const struct parse_events_terms *head,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term)
 {
@@ -1120,7 +1121,8 @@ static int config_attr(struct perf_event_attr *attr,
 	return 0;
 }
 
-static int get_config_terms(struct parse_events_terms *head_config, struct list_head *head_terms)
+static int get_config_terms(const struct parse_events_terms *head_config,
+			    struct list_head *head_terms)
 {
 #define ADD_CONFIG_TERM(__type, __weak)				\
 	struct evsel_config_term *__t;			\
@@ -1324,7 +1326,7 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 				struct list_head *list,
 				struct perf_pmu *pmu, u32 type, u32 extended_type,
-				u64 config, struct parse_events_terms *head_config)
+				u64 config, const struct parse_events_terms *head_config)
 {
 	struct perf_event_attr attr;
 	LIST_HEAD(config_terms);
@@ -1360,7 +1362,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
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


