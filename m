Return-Path: <bpf+bounces-26906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DD08A63A2
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992A51C21016
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427D15A4A6;
	Tue, 16 Apr 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQeB8gBK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158515A4A5
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248184; cv=none; b=EYfnCaIYvjq8nS56LRl07f6MfLzq/2TIXvVF5uh3lo6V3zq33i+RuRFf2qNHQbaZoZ6LYFJaGE2R7T/vPubtvYKCAOe7/Ccls1ot27kaEPvYHa/ZDxmY73n2R+DvqfBeD9jEjh175xiPYDE5uW9/fmEiEVU5gQ0/RbkYIqZrs7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248184; c=relaxed/simple;
	bh=bkVSoExev596RyG9a0xHTwh3L4XVRhShc31xUW/v3J4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RMIohMdNBY1Jp+R6xMCQnctYSJ6VserLoAPMiZhE2KG/u32WoJdCGjo2tvz3v7Hqrr8UUJ9VAea6NPacRlmXHQp7MFMkK4oxJAfOgpVGJFxhme6MfQ5B7cALgYKLWTwb476SuQ9iWhhZavUdSqOPaRRNcu4EvdZiELqaoApuOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQeB8gBK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd933a044baso5741177276.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248182; x=1713852982; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAZaI9XNl5kKuFXYgLfdboqZLBXY1vO78aqvi2rTEGA=;
        b=PQeB8gBKfWhMDRZ/+6lhtE2EhneqpHgUrmetRflVDI02OM0cF5OpOPR3TM4bT0d5Rv
         5DFX3T884cQCtYyw+/0z8E+DwQU5oDj3EMKHDi83jdiBmqExQO6GWuEUUFvLwTWv0RAU
         tRtAbHrkdpzLKTcftlCwuPSH/wGFofh0649wAXmDKdITYRSbXsWjRjfYXJCjHoQobOIj
         todwGN4EYroZn0AMgG8jKYBpWSQ6fNp+yQnJwW1HqIxi2/bFZGZ2zxx0iJQqokn3/3zj
         3C9aPwZsz6lkpxchw3UHPSguXJOhS8kStPMRSdtUN/agJu2R34quVOowYgRpUpw/wBle
         knQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248182; x=1713852982;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAZaI9XNl5kKuFXYgLfdboqZLBXY1vO78aqvi2rTEGA=;
        b=QM2gsnXf2lUUC/vNqG9XD+MgRcMKf8jr39aoMgVpu6y0w/hR+iIoGepTCzWeVAJ4DI
         3Ej7pRjK8DP/O5FAnxa3a7TTcqr8XNwtjPgMDCqFadMzQ+BmVXXbWCKDhjph28alyrnU
         5GBB/qZZjTuCopn2ArWWS3HZ9YYybk4IbIhp40LoHjWz5keJI8bnF26nLwHbw3p/dgWt
         6U0+zw30o3w5+hNH/g9lnZrV1U/6LzSQ+KNsiMY0qb8LG3KZgtbwK3PgWnjNU8HPwlOl
         ulrdgZ3uis44+jffBe3VOFfs24pICUdqlWsYUNBYwLpNvpeRfXPIZQD10t1UClT35j64
         MPyg==
X-Forwarded-Encrypted: i=1; AJvYcCX65+mBLFQAJhxmdtOgBGcxs9YT5Tsqseuwi4q8XWajWFCGk66aDBGeoWIz688xN/5AORoY6IjZDQ/U7j/4oAylW2xt
X-Gm-Message-State: AOJu0Yz1bL7GqNsDOtbIq6nYvigb+wCS29xkhr/bo6Z7n3oAiSxzQZX+
	Zy4pqpgHm1mI2sghOaOoYknXWot2RJ6nDYwwAgYyFuAdai8eH3WPkfymwBE7noYhmgvY6k2uAG2
	C21/mVQ==
X-Google-Smtp-Source: AGHT+IHU62mxVZT/57o8lZIqos+5GU3yfPQj1+CocC7s8g9X2ZXqugU/fUPUNRs0dJBS3aK51ZiyqFZ/eNM7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:154f:b0:dbe:d0a9:2be3 with SMTP
 id r15-20020a056902154f00b00dbed0a92be3mr573082ybu.3.1713248181960; Mon, 15
 Apr 2024 23:16:21 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:32 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 16/16] perf parse-events: Tidy the setting of the default
 event name
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

Add comments. Pass ownership of the event name to save on a strdup.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |  9 ++++++---
 tools/perf/util/parse-events.h |  2 +-
 tools/perf/util/parse-events.l |  5 +++++
 tools/perf/util/parse-events.y | 10 +++++++---
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1c1b1bcb78e8..0f308b4db2b9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1836,18 +1836,21 @@ int parse_events__modifier_event(struct parse_events_state *parse_state, void *l
 	return parse_events__modifier_list(parse_state, loc, list, mod, /*group=*/false);
 }
 
-int parse_events_name(struct list_head *list, const char *name)
+int parse_events__set_default_name(struct list_head *list, char *name)
 {
 	struct evsel *evsel;
+	bool used_name = false;
 
 	__evlist__for_each_entry(list, evsel) {
 		if (!evsel->name) {
-			evsel->name = strdup(name);
+			evsel->name = used_name ? strdup(name) : name;
+			used_name = true;
 			if (!evsel->name)
 				return -ENOMEM;
 		}
 	}
-
+	if (!used_name)
+		free(name);
 	return 0;
 }
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 0bb5f0c80a5e..5695308efab9 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -207,7 +207,7 @@ int parse_events__modifier_event(struct parse_events_state *parse_state, void *l
 				 struct list_head *list, struct parse_events_modifier mod);
 int parse_events__modifier_group(struct parse_events_state *parse_state, void *loc,
 				 struct list_head *list, struct parse_events_modifier mod);
-int parse_events_name(struct list_head *list, const char *name);
+int parse_events__set_default_name(struct list_head *list, char *name);
 int parse_events_add_tracepoint(struct list_head *list, int *idx,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4aaf0c53d9b6..08ea2d845dc3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -96,6 +96,11 @@ static int drv_str(yyscan_t scanner, int token)
 	return token;
 }
 
+/*
+ * Use yyless to return all the characaters to the input. Update the column for
+ * location debugging. If __alloc is non-zero set yylval to the text for the
+ * returned token's value.
+ */
 #define REWIND(__alloc)				\
 do {								\
 	YYSTYPE *__yylval = parse_events_get_lval(yyscanner);	\
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 6f1042272dda..68b3b06c7ff0 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -247,10 +247,14 @@ event_name
 event_name:
 PE_EVENT_NAME event_def
 {
-	int err;
+	/*
+	 * When an event is parsed the text is rewound and the entire text of
+	 * the event is set to the str of PE_EVENT_NAME token matched here. If
+	 * no name was on an event via a term, set the name to the entire text
+	 * taking ownership of the allocation.
+	 */
+	int err = parse_events__set_default_name($2, $1);
 
-	err = parse_events_name($2, $1);
-	free($1);
 	if (err) {
 		free_list_evsel($2);
 		YYNOMEM;
-- 
2.44.0.683.g7961c838ac-goog


