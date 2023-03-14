Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8F6BA3B7
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCNXok (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCNXnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:43:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B203D924;
        Tue, 14 Mar 2023 16:42:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cn6so4407341pjb.2;
        Tue, 14 Mar 2023 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSYFKW/f4cBllB72XD0Anmg2JAAmUIvfnX1lH/HWE8g=;
        b=iLsxORHVo+Ra5DIY7du9NDDWWr+RXz+zkIusth+YNprZkp8T+WuP/XKvbiZNAN/0Lw
         xB11nsnCpyPpUWo2c8sdkKdlwKNQlVSJS3wJIgMhdakEAV+xEOh9MqAoLRgg3F//Y9x7
         NgyXtl6LgNNAfu9bEg2Uo8CmHFgYhoiEgwVhFtuqog+abb0ibmF2lTfx9ipcOQV6hjZH
         MhYWY5ZI7/nauAErpmH0/w2g9GOJaVzYmU6OH1FA0DLQHbOwMVODS7Q7IZKeN8/rWrVp
         ES7vtv8ECazZpaGiLsYUk4cbAmFxUUunnBMbPNhDvvktOT6pLzhWFjHeYzFXQf3GAiis
         iU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSYFKW/f4cBllB72XD0Anmg2JAAmUIvfnX1lH/HWE8g=;
        b=s23L3Xd4Ay0SnhYGfyuFPXMkmpG2pIbobSNUzip3QkaR6+P4VPgjWVd5TXqDUwotpt
         a5/a1By+F10QhGugkoc+PxzzIT5VvKav4TMCdDgq3iMvca/IaVpnSMLsnmsHeaAmY1SC
         i4FL88wETqiK/T9ggn65cfQoNk2hANguhVXoJ6H2oREMQYFSnTD9xOs6ZW59ayUUC4TR
         jlnWWm/7nFOw/w81QvnArH2kiEobJ9Vy+GvJJ6yfAKsmLx08d6WdsZKb2D5gzBDLqRkU
         j7+m8wPOIchdW1y7Op9Xi9LEbBEUCytQH+WRynkUGsEgL90rQAi4aWRqSJU8GzJSufps
         09cQ==
X-Gm-Message-State: AO0yUKVrcDDCsCPFdKgClmiH4PKNFHekQvaidJ3n6+n1U8T6JtcgCiPI
        KzI8Of9OjPcpkB//p/DMwtg=
X-Google-Smtp-Source: AK7set8NWU5DOrScPYfuACfyzwjn5zb8OkIETS6ULqbmJ7/wc79kiWbNxfa/spzEl0SAnSRIJwDr3Q==
X-Received: by 2002:a17:902:d2c4:b0:1a0:7678:5e0b with SMTP id n4-20020a170902d2c400b001a076785e0bmr558305plc.22.1678837366487;
        Tue, 14 Mar 2023 16:42:46 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3826:a5cd:1f1d:6c85])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm2280806plb.18.2023.03.14.16.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:42:46 -0700 (PDT)
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
Subject: [PATCH 05/10] perf bpf filter: Add 'pid' sample data support
Date:   Tue, 14 Mar 2023 16:42:32 -0700
Message-Id: <20230314234237.3008956-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230314234237.3008956-1-namhyung@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
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

