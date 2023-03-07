Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98366AFA73
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCGXdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCGXdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:33:23 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B97C76F54;
        Tue,  7 Mar 2023 15:33:22 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z10so8620708pgr.8;
        Tue, 07 Mar 2023 15:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678232001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSYFKW/f4cBllB72XD0Anmg2JAAmUIvfnX1lH/HWE8g=;
        b=PXqbxPmcykJazCAipqVop4Vgq8LFaDno2vr4y2dpXqgZLGMST1LwAAKXtuauhxZkJ9
         e6WqoK7uW8mwFtLjywvT8CYkLGlkYacHiJ4vnEQg97U7q4lPZbpj4nTWWB3AJG6j9/XF
         icw9rojoLATo22XQv0BjhFOilzpu/B5lIWmY33ltkUXtF+kPmu7fqnyF6O7jZcHfZmPN
         2/Q9HM1Ra4bT6iCCy5ZzsY+D7IDtgq9bXPkSoeVRAZOBnDuXXtrySJuqRTB7GttMKMEi
         +7zpfdQPW35xe7FT7fnhuejXIYWFYKTSgbhm2hWcnflbNkkU1O9gE9lPPQkNCxx+ZypK
         4DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSYFKW/f4cBllB72XD0Anmg2JAAmUIvfnX1lH/HWE8g=;
        b=G2GOD2XagFFs80oWuvfS9iaJu6/tBxaTOY7N/BbLIfodeHj7JZDCYNt3lAVi7GO+oY
         Gfe4ut3CkUIxBlZqak8xEWJiZRFbE7uOZRV0ydL2RM9yS9upfH9xIZ/8sjszrkmLVQUN
         N+9EvxGzsKw95OYkbc7QXDa1rzNrBOt4n9oL4nVbgdbRNnQPtNcIXNc24hlhkcOat2l8
         l/Qx5QJxAI8JbwNAgr9qQ0Q7T5YGlk777PWq6HBlaWns2NkmY+FL+zO7XizaME4XA8HU
         GJ2Q0OIFv/+9DDSlwP3mKwsRApLtiiiVJTrrSNVbcRvqCV7At853CBjmoFHGfxdi04nH
         BRQQ==
X-Gm-Message-State: AO0yUKXWL8V8t8WZQiO2CbydhiKQCSs5pJNCMz++CjKmoZ28E3GGLH6n
        HjokW+Q++pp3yUpI2ZxpmG4=
X-Google-Smtp-Source: AK7set/yygdmTl2Ud7hNbNr8heUCT5ybTO6ZS2vMDtheV59zz2PQDvMkTyDGtoXM8bOHMPfehAnlfQ==
X-Received: by 2002:aa7:941d:0:b0:5f1:f57a:b0c3 with SMTP id x29-20020aa7941d000000b005f1f57ab0c3mr14936637pfo.5.1678232001457;
        Tue, 07 Mar 2023 15:33:21 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:15e8:b801:cd55:a496])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b005da23d8cbffsm8342217pff.158.2023.03.07.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:33:20 -0800 (PST)
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
Subject: [PATCH 5/9] perf bpf filter: Add 'pid' sample data support
Date:   Tue,  7 Mar 2023 15:33:05 -0800
Message-Id: <20230307233309.3546160-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230307233309.3546160-1-namhyung@kernel.org>
References: <20230307233309.3546160-1-namhyung@kernel.org>
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

The pid is special because it's saved in the PERF_SAMPLE_TID together.
So it needs to differenciate tid and pid using the 'part' field in the
perf bpf filter entry struct.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c                 |  4 +++-
 tools/perf/util/bpf-filter.h                 |  3 ++-
 tools/perf/util/bpf-filter.l                 | 11 ++++++++++-
 tools/perf/util/bpf-filter.y                 |  7 +++++--
 tools/perf/util/bpf_skel/sample-filter.h     |  3 ++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  5 ++++-
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 7bd6f2e41513..743c69fd6cd4 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -36,6 +36,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
 		struct perf_bpf_filter_entry entry = {
 			.op = expr->op,
+			.part = expr->part,
 			.flags = expr->sample_flags,
 			.value = expr->val,
 		};
@@ -76,7 +77,7 @@ u64 perf_bpf_filter__lost_count(struct evsel *evsel)
 	return skel ? skel->bss->dropped : 0;
 }
 
-struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags, int part,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val)
 {
@@ -85,6 +86,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
 	expr = malloc(sizeof(*expr));
 	if (expr != NULL) {
 		expr->sample_flags = sample_flags;
+		expr->part = part;
 		expr->op = op;
 		expr->val = val;
 	}
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index f0c66764c6d0..3f8827bd965f 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -9,6 +9,7 @@
 struct perf_bpf_filter_expr {
 	struct list_head list;
 	enum perf_bpf_filter_op op;
+	int part;
 	unsigned long sample_flags;
 	unsigned long val;
 };
@@ -16,7 +17,7 @@ struct perf_bpf_filter_expr {
 struct evsel;
 
 #ifdef HAVE_BPF_SKEL
-struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags, int part,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val);
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index f6c0b74ea285..ec12fc4d2ab8 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -11,7 +11,15 @@
 
 static int sample(unsigned long sample_flag)
 {
-	perf_bpf_filter_lval.sample = sample_flag;
+	perf_bpf_filter_lval.sample.type = sample_flag;
+	perf_bpf_filter_lval.sample.part = 0;
+	return BFT_SAMPLE;
+}
+
+static int sample_part(unsigned long sample_flag, int part)
+{
+	perf_bpf_filter_lval.sample.type = sample_flag;
+	perf_bpf_filter_lval.sample.part = part;
 	return BFT_SAMPLE;
 }
 
@@ -56,6 +64,7 @@ ident		[_a-zA-Z][_a-zA-Z0-9]+
 ip		{ return sample(PERF_SAMPLE_IP); }
 id		{ return sample(PERF_SAMPLE_ID); }
 tid		{ return sample(PERF_SAMPLE_TID); }
+pid		{ return sample_part(PERF_SAMPLE_TID, 1); }
 cpu		{ return sample(PERF_SAMPLE_CPU); }
 time		{ return sample(PERF_SAMPLE_TIME); }
 addr		{ return sample(PERF_SAMPLE_ADDR); }
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 13eca612ecca..0ca6532afd8d 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -20,7 +20,10 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 %union
 {
 	unsigned long num;
-	unsigned long sample;
+	struct {
+		unsigned long type;
+		int part;
+	} sample;
 	enum perf_bpf_filter_op op;
 	struct perf_bpf_filter_expr *expr;
 }
@@ -48,7 +51,7 @@ filter_term
 filter_term:
 BFT_SAMPLE BFT_OP BFT_NUM
 {
-	$$ = perf_bpf_filter_expr__new($1, $2, $3);
+	$$ = perf_bpf_filter_expr__new($1.type, $1.part, $2, $3);
 }
 
 %%
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 862060bfda14..6b9fd554ad7b 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -17,7 +17,8 @@ enum perf_bpf_filter_op {
 /* BPF map entry for filtering */
 struct perf_bpf_filter_entry {
 	enum perf_bpf_filter_op op;
-	__u64 flags;
+	__u32 part; /* sub-sample type info when it has multiple values */
+	__u64 flags; /* perf sample type flags */
 	__u64 value;
 };
 
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index c07256279c3e..dddf38c27bb7 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -40,7 +40,10 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 	case PERF_SAMPLE_ID:
 		return kctx->data->id;
 	case PERF_SAMPLE_TID:
-		return kctx->data->tid_entry.tid;
+		if (entry->part)
+			return kctx->data->tid_entry.pid;
+		else
+			return kctx->data->tid_entry.tid;
 	case PERF_SAMPLE_CPU:
 		return kctx->data->cpu_entry.cpu;
 	case PERF_SAMPLE_TIME:
-- 
2.40.0.rc1.284.g88254d51c5-goog

