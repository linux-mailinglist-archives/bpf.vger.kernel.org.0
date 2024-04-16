Return-Path: <bpf+bounces-26900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4118A6396
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85F71F21F60
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45184E17;
	Tue, 16 Apr 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxdiMkSt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A784D26
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248171; cv=none; b=FomL8haQRZkFnScdlTdcadIK5HvwqXRilMBEMbf4HHl7qoPAEQakBscedaLa+wgwMazXrIKK0wqQSQpBf+qGTpvAMknE8q0rwyOlGGylLkuIYrmtW2bLwwg46R+jz00nxt0lofavowV8hp9ZVar1b6Qo8uBqxZjEaigcOIpe24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248171; c=relaxed/simple;
	bh=O8OUGtb6bTGqfSyRVlfSK5T8OB2WkT+9dGZAqdqh/Cs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dHrB8kxnXl3H4yT6qiXqn95il3Bv00CNWiBEqPXFzcdjqEk5wGNSsYTJ/wzDVj8WtSqx3I1hGY46s0iqH0k5zMpFHjD3TBpi2CzJ1vgBfNp6vucygvkfWWVCKDnxY4fzVGlOZi12ti0LIpSsVxVODP2qWBq5nLtvmSKA635o+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxdiMkSt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61891efba06so53600917b3.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248168; x=1713852968; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PPi7agW0cdqI/eav98kRS0rctCNoN8MXcmmiJuSnV8=;
        b=MxdiMkStihO7e4lTLn3RbwoirBdNzvt5ov3NOwHLmnM6Z91/xTBJKXWNvoeS+ww1lM
         BQJJIzlhPn+/OSHvtMeiKwoZmM/mQnXovIH8xqJvZigGu9sJ8/lPhwEGSwqJJVeHA8k3
         CkRBlZQTUUHlpgFW3SYk0PlIIjAPULZO9FatnbmNRJzTdEcPNmF+DOI0URQjkbQPDvzK
         wW9NKS9EwnLNOR3ISpRNw725sg9H+9B9ONerKHIDoLjyWr3XjjNJhbOcpHzX+DQqKJWI
         oJcwIMCFVyshepxMkdBFoGSXyC9GSPaR+DJrTVfPygsJc7nF/a43CtmXc+gM94DrdI63
         gOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248168; x=1713852968;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PPi7agW0cdqI/eav98kRS0rctCNoN8MXcmmiJuSnV8=;
        b=KuobJkep5ep5vuV8ZIek1ZnuHIvotjnmkZDZjD8SMyt5ZQ5L7gid5NlD643wzg08jT
         8aGgUUnw9e+j6b8ka1P9cyFWIThwqhZMpUfh+njASkVC8u2XJ2rqBYCOGNH8fMUskSBY
         LA405ISFl4mBoA2wNsx6ZmaAZFzSQGLUQ2ik6PPqeEEC6i8r08U3CZW6NZ3i9bk7Y6Nr
         UwiRaXQrts2LNY79LpeBgxMiHUvd1aX3bLwOYm+lUSDmV8FKTfJg5wmKRomE7r4BA4W+
         J1WyTNyc6G2+jUtWa1ggu3RpeIxyz9x2lqJL8+thgK8unfoOnUdrGQOdI8JSm7fzOZQ2
         Mjtw==
X-Forwarded-Encrypted: i=1; AJvYcCWEFFfIExuvmLazf1q9IjgzkBviUdPhFc1K+IQ38dglEv28PttVZqGEsYVWNRL5nck9AcoOHZvRAwRA0gsxqd36awDN
X-Gm-Message-State: AOJu0Yx9ClMFDSAgmFUHsnLZC4oIYqx10nKK920CGAS7uu/EhEX6WsED
	sgfKbi30yxulOZqkkp3pKigoWluNIw8qa+b3LMoNDQMGsPEAlvP1CbVhgTvREDjm7ttwO+rKQCa
	qkxblwQ==
X-Google-Smtp-Source: AGHT+IH2niG4HLP7/x+KA0mPGPOc5Cee9M3cvuF12USU8FSK8dwpi2y2t4/mArka5E1ZbdSzG8VUZRYDDFLw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1501:b0:dd9:1b94:edb5 with SMTP
 id q1-20020a056902150100b00dd91b94edb5mr1355225ybu.10.1713248167928; Mon, 15
 Apr 2024 23:16:07 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:26 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 10/16] perf parse-events: Inline parse_events_update_lists
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

The helper function just wraps a splice and free. Making the free
inline removes a comment, so then it just wraps a splice which we can
make inline too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 13 -----------
 tools/perf/util/parse-events.h |  2 --
 tools/perf/util/parse-events.y | 41 +++++++++++++++++++++-------------
 3 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 805872c90a3e..7eba714f0d73 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1720,19 +1720,6 @@ void parse_events__set_leader(char *name, struct list_head *list)
 	leader->group_name = name;
 }
 
-/* list_event is assumed to point to malloc'ed memory */
-void parse_events_update_lists(struct list_head *list_event,
-			       struct list_head *list_all)
-{
-	/*
-	 * Called for single event definition. Update the
-	 * 'all event' list, and reinit the 'single event'
-	 * list, for next event definition.
-	 */
-	list_splice_tail(list_event, list_all);
-	free(list_event);
-}
-
 struct event_modifier {
 	int eu;
 	int ek;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 7e5afad3feb8..e8f2aebea10f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -226,8 +226,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 					void *loc_);
 
 void parse_events__set_leader(char *name, struct list_head *list);
-void parse_events_update_lists(struct list_head *list_event,
-			       struct list_head *list_all);
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 31fe8cf428ff..51490f0f8c50 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -125,6 +125,10 @@ static void free_list_evsel(struct list_head* list_evsel)
 }
 %%
 
+ /*
+  * Entry points. We are either parsing events or terminals. Just terminal
+  * parsing is used for parsing events in sysfs.
+  */
 start:
 PE_START_EVENTS start_events
 |
@@ -132,31 +136,36 @@ PE_START_TERMS  start_terms
 
 start_events: groups
 {
+	/* Take the parsed events, groups.. and place into parse_state. */
+	struct list_head *groups  = $1;
 	struct parse_events_state *parse_state = _parse_state;
 
-	/* frees $1 */
-	parse_events_update_lists($1, &parse_state->list);
+	list_splice_tail(groups, &parse_state->list);
+	free(groups);
 }
 
-groups:
+groups: /* A list of groups or events. */
 groups ',' group
 {
-	struct list_head *list  = $1;
-	struct list_head *group = $3;
+	/* Merge group into the list of events/groups. */
+	struct list_head *groups  = $1;
+	struct list_head *group  = $3;
 
-	/* frees $3 */
-	parse_events_update_lists(group, list);
-	$$ = list;
+	list_splice_tail(group, groups);
+	free(group);
+	$$ = groups;
 }
 |
 groups ',' event
 {
-	struct list_head *list  = $1;
+	/* Merge event into the list of events/groups. */
+	struct list_head *groups  = $1;
 	struct list_head *event = $3;
 
-	/* frees $3 */
-	parse_events_update_lists(event, list);
-	$$ = list;
+
+	list_splice_tail(event, groups);
+	free(event);
+	$$ = groups;
 }
 |
 group
@@ -206,12 +215,12 @@ PE_NAME '{' events '}'
 events:
 events ',' event
 {
+	struct list_head *events  = $1;
 	struct list_head *event = $3;
-	struct list_head *list  = $1;
 
-	/* frees $3 */
-	parse_events_update_lists(event, list);
-	$$ = list;
+	list_splice_tail(event, events);
+	free(event);
+	$$ = events;
 }
 |
 event
-- 
2.44.0.683.g7961c838ac-goog


