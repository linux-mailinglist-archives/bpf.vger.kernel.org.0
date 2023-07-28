Return-Path: <bpf+bounces-6172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90CF766486
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED731C217E6
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088EC8C0;
	Fri, 28 Jul 2023 06:50:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE659BE78
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:50:01 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695F3A99
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so1647503276.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526994; x=1691131794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kv5zMq7Gf+E/mq3KI9mmBvkyfhWn6r0mf6FnCBupmRU=;
        b=l4MYYbki/hukDreSiqPgSSi7kqT1I0MQAIIMZIRxKVi/gAKLP++vvsd3ohOTx5Peii
         fqJRbuy+r7VsxO2l6XzHudVyls1bul7gFWrwlg4Rytz7DH8HyH9gSFhKJaR9boqxH5vf
         tQfuU5hcGl/o9sWuVE9WVfiAGOTqTKTExEQBqUE387gTXbEcKWPa8knk8egaau1z8RJ5
         vo6VhoZfucWIvZZld14uFMpRpXPex78nOuYY+HlH6yuU4IhsIMPIUUG5/GjQBsL95wLy
         W8JKCHqR1HtA8ERSKiqVL7z9rAR1bnYFcooC/jmcbIeA1w6HhuY7zkKABT+erQaA7juD
         1jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526994; x=1691131794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv5zMq7Gf+E/mq3KI9mmBvkyfhWn6r0mf6FnCBupmRU=;
        b=VoKhGjNbZGSzEEOuFp1jYcgVKumN6vPsVN/qI7gFg2BV2g2zQRwA11RzL2j8HOFLN1
         Vsv5f6m9pwZcbhAAmlT5WjcZyAOtEyP+Od+YywBFGJqYQ7KBom5WU0nfweedPifFW3Xi
         zUYW+uaNdEvu9NfQoTE/ss/ghjDeZV7YqeJUWDlxMihs4tQBWwxqATOM5faWjUsvOq/w
         gF6PTTIwqcsRPwq9Bdo1t5mEOAocs8eenXFtQluj+QCxf6AbkDgRhBk6PMWrWo7KPxKr
         t3mi2jop5gt3YN0W9kulirFic6pU7Tz8NO0KUqErMqLD+5YRMwJgC5Os5isWC5L5G71Z
         9PsA==
X-Gm-Message-State: ABy/qLZ0gYsYDH9tUt/w0FY0eGF4oqP7pkaCzTWTXOa38lGOepaRiqPw
	f2hAj/1vIJP//iCn8Z2Y04Av0XI2ynrE
X-Google-Smtp-Source: APBJJlHSjc/IT1qlh3DupBROZRiA34CttLjbZ/ikQplvXR7TLxlgSKa9DNC7fbAHgw/FKUsK9regMJwIlwEM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:d613:0:b0:d12:d6e4:a08d with SMTP id
 n19-20020a25d613000000b00d12d6e4a08dmr4686ybg.7.1690526993885; Thu, 27 Jul
 2023 23:49:53 -0700 (PDT)
Date: Thu, 27 Jul 2023 23:49:16 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 5/6] perf build: Disable fewer bison warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Gaosheng Cui <cuigaosheng1@huawei.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If bison is version 3.8.2, reduce the number of bison C warnings
disabled. Earlier bison versions have all C warnings disabled. Avoid
implicit declarations of yylex by adding the declaration in the C
file. A header can't be included as a circular dependency would occur
due to the lexer using the bison defined tokens.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build          | 6 +++---
 tools/perf/util/bpf-filter.y   | 2 ++
 tools/perf/util/expr.y         | 4 +++-
 tools/perf/util/parse-events.y | 1 +
 tools/perf/util/pmu.y          | 3 +++
 5 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 32239c4b0393..20aa8545b127 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -291,9 +291,9 @@ CFLAGS_expr-flex.o          += $(flex_flags)
 CFLAGS_bpf-filter-flex.o    += $(flex_flags)
 
 bison_flags := -DYYENABLE_NLS=0
-BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
-ifeq ($(BISON_GE_35),1)
-  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable -Wno-unknown-warning-option
+BISON_GE_382 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 382)
+ifeq ($(BISON_GE_382),1)
+  bison_flags += -Wno-switch-enum
 else
   bison_flags += -w
 endif
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 07d6c7926c13..5dfa948fc986 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -9,6 +9,8 @@
 #include <linux/list.h>
 #include "bpf-filter.h"
 
+int perf_bpf_filter_lex(void);
+
 static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 				  char const *msg)
 {
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index dd504afd8f36..65d54a6f29ad 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -7,6 +7,8 @@
 #include "util/debug.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
+#include "expr-bison.h"
+int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
 %}
 
 %define api.pure full
@@ -56,7 +58,7 @@
 static void expr_error(double *final_val __maybe_unused,
 		       struct expr_parse_ctx *ctx __maybe_unused,
 		       bool compute_ids __maybe_unused,
-		       void *scanner,
+		       void *scanner __maybe_unused,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 454577f7aff6..251b7d2fde32 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -20,6 +20,7 @@
 #include "parse-events.h"
 #include "parse-events-bison.h"
 
+int parse_events_lex(YYSTYPE * yylval_param, YYLTYPE * yylloc_param , void *yyscanner);
 void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
 
 #define PE_ABORT(val) \
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index dff4e892ac4d..3d46cca3bb94 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -11,6 +11,9 @@
 #include <linux/bitmap.h>
 #include <string.h>
 #include "pmu.h"
+#include "pmu-bison.h"
+
+int perf_pmu_lex(YYSTYPE * yylval_param , void *yyscanner);
 
 #define ABORT_ON(val) \
 do { \
-- 
2.41.0.487.g6d72f3e995-goog


