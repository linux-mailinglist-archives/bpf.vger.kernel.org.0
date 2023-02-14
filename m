Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5669581A
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 06:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBNFFZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 00:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjBNFFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 00:05:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119A9ED8;
        Mon, 13 Feb 2023 21:05:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso6521484pjn.5;
        Mon, 13 Feb 2023 21:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9saedHbGi5lnxDop2A9W+edZkWtcZzgvFBH7wuOD4MI=;
        b=E8dLCohNmtoOK3Woef7oGGGJaJPxRK8uU93GOQDgBpIjX59qTqKXPEZnC08nN4TNHT
         oL9IUTUCEAYYl3AUjOXLa4SJOY0x1Htj9jQQUGyYmhp+sX6LvB9EemogxP3VYwQpxvE+
         VQF2PKNIXBHV28iFx4Aluj39P/7NVEIJ2Ft1it+SsW2wHQxemcfrorv6dZXSJ3PCAM7M
         lu3QeHWL/xrqmmvgZMnCxemkdNY7NR8XrXiHgSQdXmyNtuV/pdtNu8LRmXT3stnQtjnt
         uLnFNcl289IV9i5cdwwpXcoJWfHButEJkVbLA3ROISqDkCwWdtcpJ3KkG+jJSuN4saCl
         Cc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9saedHbGi5lnxDop2A9W+edZkWtcZzgvFBH7wuOD4MI=;
        b=7fU0+ZHp8Z3JMgK5u6xEbiwD6tLKFJ9lh/kT7Hu1WHHo2AEjFRr4OAdHfj/SOTF9vS
         oYzuYjaj7s0YFOCTqlDb/IqrGAHD5vJrn2oFN4QZg1mEXe54GoOCYirR5gVBABsiYblh
         DeC4f2s4WWHNjOnT20c7+6xfeLj9bXP1ujVqwkf5iBML/HxfnIS1cHTzKUan+M7ucxQo
         WiK/NCAs6LllySY9oQvtxAWQ9csd17W3lf6gMcZo0T5b0Ut+pkKw29xF//Etu2LrJxrH
         PWM+pyNcJKuAd+z/Sen+zHA8SRybfQz+2zO7/tyF87vTeCIm7g2DLyC5TWiZbigDuXp9
         J45w==
X-Gm-Message-State: AO0yUKUYfNETvG06q2fKbwQLt7nKJfxb9rqvbZARJqFh9wWofkKn4FQs
        yrNllOUWHDG+yrHImwsxoK0=
X-Google-Smtp-Source: AK7set/YcPbahxos/SfedD9h6SLcJLvJTn6qR1uwECoaTVJDEXP/nHhpztfpzuSruozmgwiSuwyGXQ==
X-Received: by 2002:a17:902:d4ce:b0:19a:a516:ba2c with SMTP id o14-20020a170902d4ce00b0019aa516ba2cmr1704017plg.0.1676351103424;
        Mon, 13 Feb 2023 21:05:03 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:de3c:c4c2:3f15:764d])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902761200b001932a9e4f2csm9045593pll.255.2023.02.13.21.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:05:03 -0800 (PST)
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
Subject: [PATCH 5/7] perf bpf filter: Add 'pid' sample data support
Date:   Mon, 13 Feb 2023 21:04:50 -0800
Message-Id: <20230214050452.26390-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
In-Reply-To: <20230214050452.26390-1-namhyung@kernel.org>
References: <20230214050452.26390-1-namhyung@kernel.org>
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
index 11fb391c92e9..2e02dc965dd9 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -43,6 +43,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
 		struct perf_bpf_filter_entry entry = {
 			.op = expr->op,
+			.part = expr->part,
 			.flags = expr->sample_flags,
 			.value = expr->val,
 		};
@@ -83,7 +84,7 @@ u64 perf_bpf_filter__lost_count(struct evsel *evsel)
 	return skel ? skel->bss->dropped : 0;
 }
 
-struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags,
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags, int part,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val)
 {
@@ -92,6 +93,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
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
index 34c6a9fd4fa4..5117c76c7c7a 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -10,7 +10,15 @@
 
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
 
@@ -46,6 +54,7 @@ num_hex		0[Xx][0-9a-fA-F]+
 ip		{ return sample(PERF_SAMPLE_IP); }
 id		{ return sample(PERF_SAMPLE_ID); }
 tid		{ return sample(PERF_SAMPLE_TID); }
+pid		{ return sample_part(PERF_SAMPLE_TID, 1); }
 cpu		{ return sample(PERF_SAMPLE_CPU); }
 time		{ return sample(PERF_SAMPLE_TIME); }
 addr		{ return sample(PERF_SAMPLE_ADDR); }
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 0bf36ec30abf..8f307d5ffc54 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -19,7 +19,10 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
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
@@ -46,7 +49,7 @@ filter_term
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
index 1aa6a4cacd51..e9a0633d638d 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -32,7 +32,10 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
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
2.39.1.581.gbfd45094c4-goog

