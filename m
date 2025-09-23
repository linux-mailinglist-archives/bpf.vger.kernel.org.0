Return-Path: <bpf+bounces-69328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE1B94302
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BA5188E660
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0367F28312B;
	Tue, 23 Sep 2025 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ju1h7V5e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D7280CF6
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601146; cv=none; b=pRRS/NQXredyjXxlI3ZzdCO+R/+GPQqexb/T6WwZZYLp3rlvanuw90lP5wiE5mnkaIbBB7kE89v1610SCju6VPj9zy1n+WytGZLdZ2rHD9ZT5WZ0bRyOHfPzRmOnlLcU/qcCo82Z06dln2D4Q7m7fynvKrl2j5P18NDO84YThUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601146; c=relaxed/simple;
	bh=WPp5sf3QDHsYUJNf2dAHXr6uoG+XA9EmqP0/w3J4dIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P5dc1WlNf3Duq8Bz6cyn+qO0EuiEttg45UOhqNUVsFZQvnG79H4mMw4iXuKKzWGXYg6T9zVo04A9+2fO9kIZy9oTXDNFM4md3tmBeH2jYRQLUbTpZxk5B/w4OJbp/VLAp1AuHA+H7i1gwTSGg3DCPiwzywBcCILtcvEIZyTA0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ju1h7V5e; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso6256328a91.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601144; x=1759205944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmw42+29yvJvKrw6/kjNexq41QLy8ypEjcJ8nXeA0Rw=;
        b=ju1h7V5e8qLmqYHESVAZvTLI+3LL86W8MFJXKwY60HSng6TOs3Bh2YLlZMvMYRPG7X
         DlyczBg9uWa1q/djTAAEpCA/MZObzO9llekxw4t28/co4GrHyN7S3J+TI7v7KyNCIbUg
         OA+9C6he05aP9cYE1NJDidfEmQxRHKMHeiZtroInCcBfk/vr8yEu/8RtDcuy32BVcE/Z
         GVCZo10lfXt1jWwPptx6P/sGqJ9mF87Euz9OWhuSytniCTncc5pSJ3sq9nZ/L/OQzDcX
         VUDTqgbKfpv2FEL+qDnh/ngBXDY2FXA+dOuHA4p4EM6cIs13n8JqWr79JdSOpWKpocWe
         R2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601144; x=1759205944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmw42+29yvJvKrw6/kjNexq41QLy8ypEjcJ8nXeA0Rw=;
        b=pnXVmCWvN0sjWA+AOpSVbH960y4S9D2cdAz71uofh199o35mnzJ3FJBhx7u//2ax3O
         FkvqrxLhuTWONxbPpWEDYCbJgcyBa0d5cEz5tY9GOsTh8BEORpHc2RzCGvIOqageo/Y0
         AdDyDlsKIxgfjqfenG1WhuTA2bpylUuDvqG+5fBGq90tYmP6dUfYisRYk9ZDb/JbqeH8
         4gM5P5TZAdRLgAkL7+NgIgooqThPMHZmBeXbbV1bd9XXZ98pQYXtGuG8yrYf4jC/hGgr
         Mmks4BSxyPaVMjr0dDa3bxYx0dYbDMsF3IGdZQoE/K3c1zcyskxU4FBjbS6ycfKS+o9/
         1nFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3DPjBLK7xDTv10ITwQSFMkNWezvW/cbAhn/Q+37+3be82KQvNZ08CfuPPvXs1owdt7mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUxxFg7eZzoz6DaXBuDLBYstQo7Est0Cxp6jdhuUqOhWGZspK
	wnu72S3qHJ38joo10N//hrj6tdCrFlrvW0VF8jZCweAnvcqTXKokliHztcGzT0XEBHYHxcsfg1u
	bkB/5Ezu6VA==
X-Google-Smtp-Source: AGHT+IGA/2mgErFsMQoA+NQARW6rJ/VHPoqH8jP1mQD4KUexHrrlLlC3cJSOSpTSnZ24xwOlTG9AZC+S8BXM
X-Received: from pjj4.prod.google.com ([2002:a17:90b:5544:b0:327:d54a:8c93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d09:b0:32d:17ce:49de
 with SMTP id 98e67ed59e1d1-332a92e3dcbmr1523589a91.4.1758601144045; Mon, 22
 Sep 2025 21:19:04 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:26 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-8-irogers@google.com>
Subject: [PATCH v5 07/25] perf parse-events: Remove unused FILE input argument
 to scanner
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Now the events file isn't directly parsed from a FILE but stored in a
string prior to parsing, remove the FILE argument to the associated
scanner functions as they only ever pass NULL.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c |  2 +-
 tools/perf/tests/parse-events.c     |  2 +-
 tools/perf/tests/pmu.c              |  3 +--
 tools/perf/util/parse-events.c      | 18 ++++++------------
 tools/perf/util/parse-events.h      |  3 +--
 tools/perf/util/pmu.c               |  6 +++---
 6 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index add33cb5d1da..2d7c0dec86b0 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -72,7 +72,7 @@ static int intel_pt_parse_terms_with_default(const struct perf_pmu *pmu,
 	int err;
 
 	parse_events_terms__init(&terms);
-	err = parse_events_terms(&terms, str, /*input=*/ NULL);
+	err = parse_events_terms(&terms, str);
 	if (err)
 		goto out_free;
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index bb8004397650..4e55b0d295bd 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2556,7 +2556,7 @@ static int test_term(const struct terms_test *t)
 
 
 	parse_events_terms__init(&terms);
-	ret = parse_events_terms(&terms, t->str, /*input=*/ NULL);
+	ret = parse_events_terms(&terms, t->str);
 	if (ret) {
 		pr_debug("failed to parse terms '%s', err %d\n",
 			 t->str , ret);
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 4a9f8e090cf4..cbded2c6faa4 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -169,8 +169,7 @@ static int test__pmu_format(struct test_suite *test __maybe_unused, int subtest
 	parse_events_terms__init(&terms);
 	if (parse_events_terms(&terms,
 				"krava01=15,krava02=170,krava03=1,krava11=27,krava12=1,"
-				"krava13=2,krava21=119,krava22=11,krava23=2",
-				NULL)) {
+				"krava13=2,krava21=119,krava22=11,krava23=2")) {
 		pr_err("Term parsing failed\n");
 		goto err_out;
 	}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9ec1738a5a64..c3c934da6083 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1962,7 +1962,6 @@ int parse_events__set_default_name(struct list_head *list, char *name)
 }
 
 static int parse_events__scanner(const char *str,
-				 FILE *input,
 				 struct parse_events_state *parse_state)
 {
 	YY_BUFFER_STATE buffer;
@@ -1973,10 +1972,7 @@ static int parse_events__scanner(const char *str,
 	if (ret)
 		return ret;
 
-	if (str)
-		buffer = parse_events__scan_string(str, scanner);
-	else
-	        parse_events_set_in(input, scanner);
+	buffer = parse_events__scan_string(str, scanner);
 
 #ifdef PARSER_DEBUG
 	parse_events_debug = 1;
@@ -1984,10 +1980,8 @@ static int parse_events__scanner(const char *str,
 #endif
 	ret = parse_events_parse(parse_state, scanner);
 
-	if (str) {
-		parse_events__flush_buffer(buffer, scanner);
-		parse_events__delete_buffer(buffer, scanner);
-	}
+	parse_events__flush_buffer(buffer, scanner);
+	parse_events__delete_buffer(buffer, scanner);
 	parse_events_lex_destroy(scanner);
 	return ret;
 }
@@ -1995,7 +1989,7 @@ static int parse_events__scanner(const char *str,
 /*
  * parse event config string, return a list of event terms.
  */
-int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input)
+int parse_events_terms(struct parse_events_terms *terms, const char *str)
 {
 	struct parse_events_state parse_state = {
 		.terms  = NULL,
@@ -2003,7 +1997,7 @@ int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, input, &parse_state);
+	ret = parse_events__scanner(str, &parse_state);
 	if (!ret)
 		list_splice(&parse_state.terms->terms, &terms->terms);
 
@@ -2307,7 +2301,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	};
 	int ret, ret2;
 
-	ret = parse_events__scanner(str, /*input=*/ NULL, &parse_state);
+	ret = parse_events__scanner(str, &parse_state);
 
 	if (!ret && list_empty(&parse_state.list)) {
 		WARN_ONCE(true, "WARNING: event parser found nothing\n");
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 9c975bb09fe8..048b38e476f3 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -9,7 +9,6 @@
 #include <stdbool.h>
 #include <linux/types.h>
 #include <linux/perf_event.h>
-#include <stdio.h>
 #include <string.h>
 #include <sys/types.h>
 
@@ -198,7 +197,7 @@ void parse_events_term__delete(struct parse_events_term *term);
 void parse_events_terms__delete(struct parse_events_terms *terms);
 void parse_events_terms__init(struct parse_events_terms *terms);
 void parse_events_terms__exit(struct parse_events_terms *terms);
-int parse_events_terms(struct parse_events_terms *terms, const char *str, FILE *input);
+int parse_events_terms(struct parse_events_terms *terms, const char *str);
 
 struct parse_events_modifier {
 	u8 precise;	/* Number of repeated 'p' for precision. */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ddcd4918832d..b44dfe4c73fc 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -777,7 +777,7 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms
 	int ret;
 
 	parse_events_terms__init(&alias_terms);
-	ret = parse_events_terms(&alias_terms, alias->terms, /*input=*/NULL);
+	ret = parse_events_terms(&alias_terms, alias->terms);
 	if (ret) {
 		pr_err("Cannot parse '%s' terms '%s': %d\n",
 		       alias->name, alias->terms, ret);
@@ -2045,7 +2045,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	}
 
 	parse_events_terms__init(&terms);
-	ret = parse_events_terms(&terms, alias->terms, /*input=*/NULL);
+	ret = parse_events_terms(&terms, alias->terms);
 	if (ret) {
 		pr_err("Failure to parse '%s' terms '%s': %d\n",
 			alias->name, alias->terms, ret);
@@ -2602,7 +2602,7 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 		int ret;
 
 		parse_events_terms__init(&terms);
-		ret = parse_events_terms(&terms, event->terms, /*input=*/NULL);
+		ret = parse_events_terms(&terms, event->terms);
 		if (ret) {
 			pr_debug("Failed to parse '%s' terms '%s': %d\n",
 				event->name, event->terms, ret);
-- 
2.51.0.534.gc79095c0ca-goog


