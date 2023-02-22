Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC11D69FF27
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjBVXCZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjBVXBy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:01:54 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA5474FB;
        Wed, 22 Feb 2023 15:01:52 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n20so5337899pfu.12;
        Wed, 22 Feb 2023 15:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRl1UrmRc0k6nczgeQ+qFQlCGsQR+PutlE0FJs3eeVI=;
        b=mfpgcaeGHeVoXZKv0ZvjcEGUoZgJ8CrkwzKi6IXOcJtxcOMP3w59VqsmKoQB8e/tUQ
         Qn3Ko456MkXu08KnTdr8Is7+8lTxC5cGEEx69rmYbAMvCA5BDSkhGN0Z8qu7NcOrR5+L
         FTd+mDjWabjdgHIWzYKPEXqIu0e/P+SDlCIORcoHJ3GDI9lRH0PuHFiiTqanCAiVPiBq
         Zyq7P8SqglZxxs7mN1GBxDPpWyUP1q+SunxPefZY0dba84eVGfJyzuUWYTXGuCINwW+s
         0H0gGpUx8BTdNVhY7d4dqOyyWiA2ZyswT3xSKg2XYx75h2QJTin4Wl/Juj12Ith3EpAJ
         8NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRl1UrmRc0k6nczgeQ+qFQlCGsQR+PutlE0FJs3eeVI=;
        b=ZOAebT5xewtcjlJguE9nscJ6I8roo1oXrpKEObsxjZUCuNn3/2xo59dbBe4Qrd8GiQ
         QqOUFYB4C2JaceE3lHvZ7pDEG0l8xGp20MUBtWcmTQrmK1p20Zoee9a2TTGP22sYnEB+
         wnMur2Gt96YNw5Z6Xc9jEiYog8tHaNkBFbEUv3LtT3LCA6GClJXMKo9G5NxvARl1nS5e
         9xLl11ktDPxEDM5O9/Nm/XM8LHPrS9WZf3RdP9GV3PkSGX6ZwL01Xx0Ay1yJHf9oEN54
         8ChvYopZ3fMB1psiMIB1eO7u/MHzuJHiZXF51GKrPoSqpNxrrrxRY/ZfaHgFyBGNJ5hr
         uNXA==
X-Gm-Message-State: AO0yUKVASThWG0uVMSEyjms8MUUSRlJWC3ClxHR8dY0nsNlOXBPoEQbj
        J4p0brPqKy5l8q1NDTL1KNg=
X-Google-Smtp-Source: AK7set8Z+V2madmoRSJpOJtUjdFlH5hKfPg5j5Dibd5HpFpF22G0IkC1kbA9oE/4wYOQY/WeSSWD/w==
X-Received: by 2002:aa7:8ecc:0:b0:5a8:bcf2:125 with SMTP id b12-20020aa78ecc000000b005a8bcf20125mr7713837pfr.21.1677106912105;
        Wed, 22 Feb 2023 15:01:52 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:8f76:587d:f250:fecf])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b005ccbe5346ebsm3895127pfm.163.2023.02.22.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:01:51 -0800 (PST)
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
Subject: [PATCH 5/8] perf bpf filter: Add 'pid' sample data support
Date:   Wed, 22 Feb 2023 15:01:38 -0800
Message-Id: <20230222230141.1729048-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230222230141.1729048-1-namhyung@kernel.org>
References: <20230222230141.1729048-1-namhyung@kernel.org>
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
index 660db5ccd3da..3501c7cc4d32 100644
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
index 36b44c8188ab..4fb33d296d9c 100644
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
2.39.2.637.g21b0678d19-goog

