Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF669BEBA
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 07:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjBSGNh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 01:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBSGNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 01:13:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513E812850;
        Sat, 18 Feb 2023 22:13:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f8-20020a17090ac28800b00233d7314c1cso103603pjt.5;
        Sat, 18 Feb 2023 22:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/31nC6nJWHDS43hfvHU7fiiMCUQrL1H/oi4PCHAzdIw=;
        b=oTpR/b0OE4gDLfh1ngxjbmz/l57o9wy43PXJq5Qpy9NUMLqw8a3LO7LAFIT5Fl5Esz
         YcZ/V077CD6fdMUi3qB3tn9POMlnxEco1X6TX0+HSf0VeGPDiBiIv6StIbmXWXYQyMIm
         jecXOH9KhiyJCMMURX6l3sRlWFmJ62YcUqOag/JlYIEOyefJ5GrwOLthEGO3ucYunEVI
         jHEvf1zRPFQCvn9BeO0dmqpcQme/pibpguobpqiXizp18Mdaw17p6F2O2uIS5iOSOvrW
         sM41CZ0uJyqeOv6WczbRIw5lASH56RXRMs4JMrGOOo9RvHzJPsuITb20X/EftWzpsfbB
         D4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/31nC6nJWHDS43hfvHU7fiiMCUQrL1H/oi4PCHAzdIw=;
        b=cmALiELB13Q3PlA6JZzG8YajEWhPE34BAnX37Qgomb+HwMeNVhiR6NerdJm1guVpg2
         KF3uvpzJfx2eVIo0zo4qbJ3mlMIrZIceICSeFqQ/uP/r12iRq21r9MhnEQdV4zBM0VDR
         ZXtRC0D8GWlvAx/fz5fBVVAE7COdAoFs4ZqWGTJcpHZdcQfAvCjDPD8Q/tKTvaS771+g
         vnDYO6f14gfwVQ7AuryoZo8l1999NxJu67XT9E6mAtiAmY2TKYxSvQ1gVSFn26DcpD65
         q87JraZc5sNY4+DWexr6DaTQmQV4yWYtFc8+Q/VvSHB2YI6snbYVj6ZOekjr8RBvMlQd
         vlmg==
X-Gm-Message-State: AO0yUKVnsmOwEwXrs1RuulmpFMG2cmgDVGBn8liRTaPXCm41oNcs75N4
        Fl09Z8KQV8i3teHWcqL/bnxtUMpD0Dg=
X-Google-Smtp-Source: AK7set9j4xsjefwbWm/c1pvYJZDSxsY7R+oEu/3aTxzY17zYPsu1AGLVxDS1AfVuoftRSqR6SGS6/A==
X-Received: by 2002:a17:902:e5c9:b0:19a:80b2:e94b with SMTP id u9-20020a170902e5c900b0019a80b2e94bmr2463556plf.33.1676787214845;
        Sat, 18 Feb 2023 22:13:34 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:70ac:ab5:11d3:d785])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00189ac5a2340sm1182140plx.124.2023.02.18.22.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 22:13:34 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 1/8] perf bpf filter: Introduce basic BPF filter expression
Date:   Sat, 18 Feb 2023 22:13:22 -0800
Message-Id: <20230219061329.1001079-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230219061329.1001079-1-namhyung@kernel.org>
References: <20230219061329.1001079-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This implements a tiny parser for the filter expressions used for BPF.
Each expression will be converted to struct perf_bpf_filter_expr and
be passed to a BPF map.

For now, I'd like to start with the very basic comparisons like EQ or
GT.  The LHS should be a term for sample data and the RHS is a number.
The expressions are connected by a comma.  For example,

    period > 10000
    ip < 0x1000000000000, cpu == 3

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/Build        | 16 +++++++++
 tools/perf/util/bpf-filter.c | 37 +++++++++++++++++++
 tools/perf/util/bpf-filter.h | 36 +++++++++++++++++++
 tools/perf/util/bpf-filter.l | 70 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-filter.y | 53 +++++++++++++++++++++++++++
 5 files changed, 212 insertions(+)
 create mode 100644 tools/perf/util/bpf-filter.c
 create mode 100644 tools/perf/util/bpf-filter.h
 create mode 100644 tools/perf/util/bpf-filter.l
 create mode 100644 tools/perf/util/bpf-filter.y

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 918b501f9bd8..6af73fb5c797 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -154,6 +154,9 @@ perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
+perf-$(CONFIG_PERF_BPF_SKEL) += bpf-filter.o
+perf-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-flex.o
+perf-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-bison.o
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
@@ -266,6 +269,16 @@ $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
 
+$(OUTPUT)util/bpf-filter-flex.c $(OUTPUT)util/bpf-filter-flex.h: util/bpf-filter.l $(OUTPUT)util/bpf-filter-bison.c
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/bpf-filter-flex.c \
+		--header-file=$(OUTPUT)util/bpf-filter-flex.h $(PARSER_DEBUG_FLEX) $<
+
+$(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-filter-bison.h: util/bpf-filter.y
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
+		-o $(OUTPUT)util/bpf-filter-bison.c -p perf_bpf_filter_
+
 FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
 ifeq ($(FLEX_GE_26),1)
   flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter -Wno-missing-prototypes -Wno-missing-declarations
@@ -279,6 +292,7 @@ endif
 CFLAGS_parse-events-flex.o  += $(flex_flags)
 CFLAGS_pmu-flex.o           += $(flex_flags)
 CFLAGS_expr-flex.o          += $(flex_flags)
+CFLAGS_bpf-filter-flex.o    += $(flex_flags)
 
 bison_flags := -DYYENABLE_NLS=0
 BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
@@ -290,10 +304,12 @@ endif
 CFLAGS_parse-events-bison.o += $(bison_flags)
 CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
+CFLAGS_bpf-filter-bison.o   += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
 $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
 $(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
 $(OUTPUT)util/expr.o: $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-bison.c
+$(OUTPUT)util/bpf-filter.o: $(OUTPUT)util/bpf-filter-flex.c $(OUTPUT)util/bpf-filter-bison.c
 
 CFLAGS_bitmap.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
new file mode 100644
index 000000000000..6b1148fcfb0e
--- /dev/null
+++ b/tools/perf/util/bpf-filter.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+
+#include "util/bpf-filter.h"
+#include "util/bpf-filter-flex.h"
+#include "util/bpf-filter-bison.h"
+
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
+						       enum perf_bpf_filter_op op,
+						       unsigned long val)
+{
+	struct perf_bpf_filter_expr *expr;
+
+	expr = malloc(sizeof(*expr));
+	if (expr != NULL) {
+		expr->sample_flags = sample_flags;
+		expr->op = op;
+		expr->val = val;
+	}
+	return expr;
+}
+
+int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
+{
+	YY_BUFFER_STATE buffer;
+	int ret;
+
+	buffer = perf_bpf_filter__scan_string(str);
+
+	ret = perf_bpf_filter_parse(expr_head);
+
+	perf_bpf_filter__flush_buffer(buffer);
+	perf_bpf_filter__delete_buffer(buffer);
+	perf_bpf_filter_lex_destroy();
+
+	return ret;
+}
\ No newline at end of file
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
new file mode 100644
index 000000000000..fd5b1164a322
--- /dev/null
+++ b/tools/perf/util/bpf-filter.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef PERF_UTIL_BPF_FILTER_H
+#define PERF_UTIL_BPF_FILTER_H
+
+#include <linux/list.h>
+
+enum perf_bpf_filter_op {
+	PBF_OP_EQ,
+	PBF_OP_NEQ,
+	PBF_OP_GT,
+	PBF_OP_GE,
+	PBF_OP_LT,
+	PBF_OP_LE,
+	PBF_OP_AND,
+};
+
+struct perf_bpf_filter_expr {
+	struct list_head list;
+	enum perf_bpf_filter_op op;
+	unsigned long sample_flags;
+	unsigned long val;
+};
+
+#ifdef HAVE_BPF_SKEL
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
+						       enum perf_bpf_filter_op op,
+						       unsigned long val);
+int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
+#else /* !HAVE_BPF_SKEL */
+static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unused,
+					 const char *str __maybe_unused)
+{
+	return -ENOSYS;
+}
+#endif /* HAVE_BPF_SKEL*/
+#endif /* PERF_UTIL_BPF_FILTER_H */
\ No newline at end of file
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
new file mode 100644
index 000000000000..34c6a9fd4fa4
--- /dev/null
+++ b/tools/perf/util/bpf-filter.l
@@ -0,0 +1,70 @@
+%option prefix="perf_bpf_filter_"
+%option noyywrap
+
+%{
+#include <stdlib.h>
+#include <linux/perf_event.h>
+
+#include "bpf-filter.h"
+#include "bpf-filter-bison.h"
+
+static int sample(unsigned long sample_flag)
+{
+	perf_bpf_filter_lval.sample = sample_flag;
+	return BFT_SAMPLE;
+}
+
+static int operator(enum perf_bpf_filter_op op)
+{
+	perf_bpf_filter_lval.op = op;
+	return BFT_OP;
+}
+
+static int value(int base)
+{
+	long num;
+
+	errno = 0;
+	num = strtoul(perf_bpf_filter_text, NULL, base);
+	if (errno)
+		return BFT_ERROR;
+
+	perf_bpf_filter_lval.num = num;
+	return BFT_NUM;
+}
+
+%}
+
+num_dec		[0-9]+
+num_hex		0[Xx][0-9a-fA-F]+
+
+%%
+
+{num_dec}	{ return value(10); }
+{num_hex}	{ return value(16); }
+
+ip		{ return sample(PERF_SAMPLE_IP); }
+id		{ return sample(PERF_SAMPLE_ID); }
+tid		{ return sample(PERF_SAMPLE_TID); }
+cpu		{ return sample(PERF_SAMPLE_CPU); }
+time		{ return sample(PERF_SAMPLE_TIME); }
+addr		{ return sample(PERF_SAMPLE_ADDR); }
+period		{ return sample(PERF_SAMPLE_PERIOD); }
+txn		{ return sample(PERF_SAMPLE_TRANSACTION); }
+weight		{ return sample(PERF_SAMPLE_WEIGHT); }
+phys_addr	{ return sample(PERF_SAMPLE_PHYS_ADDR); }
+code_pgsz	{ return sample(PERF_SAMPLE_CODE_PAGE_SIZE); }
+data_pgsz	{ return sample(PERF_SAMPLE_DATA_PAGE_SIZE); }
+
+"=="		{ return operator(PBF_OP_EQ); }
+"!="		{ return operator(PBF_OP_NEQ); }
+">"		{ return operator(PBF_OP_GT); }
+"<"		{ return operator(PBF_OP_LT); }
+">="		{ return operator(PBF_OP_GE); }
+"<="		{ return operator(PBF_OP_LE); }
+"&"		{ return operator(PBF_OP_AND); }
+
+","		{ return ','; }
+.		{ }
+
+%%
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
new file mode 100644
index 000000000000..510e944a6fa2
--- /dev/null
+++ b/tools/perf/util/bpf-filter.y
@@ -0,0 +1,53 @@
+%parse-param {struct list_head *expr_head}
+
+%{
+
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+#include <linux/list.h>
+#include "bpf-filter.h"
+
+static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
+				  char const *msg)
+{
+	printf("perf_bpf_filter: %s\n", msg);
+}
+
+%}
+
+%union
+{
+	unsigned long num;
+	unsigned long sample;
+	enum perf_bpf_filter_op op;
+	struct perf_bpf_filter_expr *expr;
+}
+
+%token BFT_SAMPLE BFT_OP BFT_ERROR BFT_NUM
+%type <expr> filter_term
+%destructor { free ($$); } <expr>
+%type <sample> BFT_SAMPLE
+%type <op> BFT_OP
+%type <num> BFT_NUM
+
+%%
+
+filter:
+filter ',' filter_term
+{
+	list_add_tail(&$3->list, expr_head);
+}
+|
+filter_term
+{
+	list_add_tail(&$1->list, expr_head);
+}
+
+filter_term:
+BFT_SAMPLE BFT_OP BFT_NUM
+{
+	$$ = perf_bpf_filter_expr__new($1, $2, $3);
+}
+
+%%
-- 
2.39.2.637.g21b0678d19-goog

