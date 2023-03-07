Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4819E6AFA80
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCGXeY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjCGXdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:33:54 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BB296631;
        Tue,  7 Mar 2023 15:33:27 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 132so8605075pgh.13;
        Tue, 07 Mar 2023 15:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678232007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHzEdCPWpaY/eH0Xx+geXzySB0PiK8eElCruHy6sF1Y=;
        b=RpH6elTpz9hGiTv7ncZWQN1s8eoMpj3qIDx275tZO76SsohweHvL3GzuXuefV0d/6Q
         5VtmH2WMbZc7Uh3ghj16co0AoB8HVCarO0l2wFAO05iQYFkSpkW2czzxJSR5QVa6Hb3m
         LGibe0QSPAfNV0BiIEO/Dd8dKbiWnMLjHa6HawPtvPaOCKvCOpP9tamGvHFSg0Fp3ctU
         URhOeWuVTKpfmOMnwVnO0HTS3aowIDCiUqlsb46gEfKEbzMNpGDChIZTS5L5cwNOYpqT
         2wZ+B/TsoGqN2sSKjUQbfd6XMASjaWjYg29U+cxfxWnC4DKl1ij0egF8nH3zArfXyAC6
         FJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHzEdCPWpaY/eH0Xx+geXzySB0PiK8eElCruHy6sF1Y=;
        b=EHdKksBEflC/zo3ef5kMK0l/K+QyuZR3Nz2emqi9d7dqmvnchvAdP8jIW3Np84BIiv
         QbFXlFImcEkWznf4sxCVXoCcCRljenbVdpmXB6t9l9lItV+3ph5N7asx0k2JAS32117/
         KTl12I2vsbsx0vz5TuLAuTUY9PtAi5wKHfJVyWhRK4wxMUOg/6WxuqIs/WRdhNZYijwh
         RGKLsh0PLvE4bJSRREKtqbSvD8aLoF5yvjL8MlWQHBqstQOyVgNx9iCsel9GKZw1CfM+
         AReFWns+GGL7/yrxaqQIgkzayRPlc+N0EZU9eXal6ND+dzPxeHgQcZeJXg6EWtVcMItZ
         /RBw==
X-Gm-Message-State: AO0yUKUGcK51p82Vp+4C+iRI3hEO3Bga4cnQIYpOQIqRDm7BGjFJilCh
        xRAJT1PtdH/RRbT9KkayiZ8=
X-Google-Smtp-Source: AK7set+CY0K+zNXyDHZNN1NQK8IkjEcXB+Z8otPqUvW1Gvyx+oa6sr2658LTKXUk6jzXBoR9DEQQ6w==
X-Received: by 2002:a62:1748:0:b0:5dc:6dec:e9b9 with SMTP id 69-20020a621748000000b005dc6dece9b9mr15896744pfx.21.1678232007135;
        Tue, 07 Mar 2023 15:33:27 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:15e8:b801:cd55:a496])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b005da23d8cbffsm8342217pff.158.2023.03.07.15.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:33:26 -0800 (PST)
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
Subject: [PATCH 8/9] perf bpf filter: Add logical OR operator
Date:   Tue,  7 Mar 2023 15:33:08 -0800
Message-Id: <20230307233309.3546160-9-namhyung@kernel.org>
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

It supports two or more expressions connected as a group and the group
result is considered true when one of them returns true.  The new group
operators (GROUP_BEGIN and GROUP_END) are added to setup and check the
condition.  As it doesn't allow nested groups, the condition is saved
in local variables.

For example, the following is to get samples only if the data source
memory level is L2 cache or the weight value is greater than 30.

  $ sudo ./perf record -adW -e cpu/mem-loads/pp \
  > --filter 'mem_lvl == l2 || weight > 30' -- sleep 1

  $ sudo ./perf script -F data_src,weight
     10668100842 |OP LOAD|LVL L3 or L3 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A		    47
     11868100242 |OP LOAD|LVL LFB/MAB or LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A      57
     10668100842 |OP LOAD|LVL L3 or L3 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A                56
     10650100842 |OP LOAD|LVL L3 or L3 hit|SNP None|TLB L2 miss|LCK No|BLK  N/A                    144
     10468100442 |OP LOAD|LVL L2 or L2 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A                16
     10468100442 |OP LOAD|LVL L2 or L2 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A                20
     11868100242 |OP LOAD|LVL LFB/MAB or LFB/MAB hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A     189
     1026a100142 |OP LOAD|LVL L1 or L1 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A              193
     10468100442 |OP LOAD|LVL L2 or L2 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A                18
     ...

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c                 | 25 +++++++++++++
 tools/perf/util/bpf-filter.h                 |  1 +
 tools/perf/util/bpf-filter.l                 |  1 +
 tools/perf/util/bpf-filter.y                 | 25 +++++++++++--
 tools/perf/util/bpf_skel/sample-filter.h     |  6 ++--
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 38 +++++++++++++-------
 6 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 743c69fd6cd4..bd638737e12f 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -42,8 +42,32 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 		};
 		bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
 		i++;
+
+		if (expr->op == PBF_OP_GROUP_BEGIN) {
+			struct perf_bpf_filter_expr *group;
+
+			list_for_each_entry(group, &expr->groups, list) {
+				struct perf_bpf_filter_entry group_entry = {
+					.op = group->op,
+					.part = group->part,
+					.flags = group->sample_flags,
+					.value = group->val,
+				};
+				bpf_map_update_elem(fd, &i, &group_entry, BPF_ANY);
+				i++;
+			}
+
+			memset(&entry, 0, sizeof(entry));
+			entry.op = PBF_OP_GROUP_END;
+			bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
+			i++;
+		}
 	}
 
+	if (i > MAX_FILTERS) {
+		pr_err("Too many filters: %d (max = %d)\n", i, MAX_FILTERS);
+		return -1;
+	}
 	prog = skel->progs.perf_sample_filter;
 	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
 		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
@@ -89,6 +113,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
 		expr->part = part;
 		expr->op = op;
 		expr->val = val;
+		INIT_LIST_HEAD(&expr->groups);
 	}
 	return expr;
 }
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 3f8827bd965f..7afd159411b8 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -8,6 +8,7 @@
 
 struct perf_bpf_filter_expr {
 	struct list_head list;
+	struct list_head groups;
 	enum perf_bpf_filter_op op;
 	int part;
 	unsigned long sample_flags;
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 3e66b7a0215e..d4ff0f1345cd 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -151,6 +151,7 @@ hops2		{ return constant(PERF_MEM_HOPS_2); }
 hops3		{ return constant(PERF_MEM_HOPS_3); }
 
 ","		{ return ','; }
+"||"		{ return BFT_LOGICAL_OR; }
 
 {ident}		{ return error("ident"); }
 .		{ return error("input"); }
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 0ca6532afd8d..07d6c7926c13 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -28,8 +28,8 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 	struct perf_bpf_filter_expr *expr;
 }
 
-%token BFT_SAMPLE BFT_OP BFT_ERROR BFT_NUM
-%type <expr> filter_term
+%token BFT_SAMPLE BFT_OP BFT_ERROR BFT_NUM BFT_LOGICAL_OR
+%type <expr> filter_term filter_expr
 %destructor { free ($$); } <expr>
 %type <sample> BFT_SAMPLE
 %type <op> BFT_OP
@@ -49,6 +49,27 @@ filter_term
 }
 
 filter_term:
+filter_term BFT_LOGICAL_OR filter_expr
+{
+	struct perf_bpf_filter_expr *expr;
+
+	if ($1->op == PBF_OP_GROUP_BEGIN) {
+		expr = $1;
+	} else {
+		expr = perf_bpf_filter_expr__new(0, 0, PBF_OP_GROUP_BEGIN, 1);
+		list_add_tail(&$1->list, &expr->groups);
+	}
+	expr->val++;
+	list_add_tail(&$3->list, &expr->groups);
+	$$ = expr;
+}
+|
+filter_expr
+{
+	$$ = $1;
+}
+
+filter_expr:
 BFT_SAMPLE BFT_OP BFT_NUM
 {
 	$$ = perf_bpf_filter_expr__new($1.type, $1.part, $2, $3);
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 6b9fd554ad7b..2e96e1ab084a 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -1,7 +1,7 @@
 #ifndef PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
 #define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
 
-#define MAX_FILTERS  32
+#define MAX_FILTERS  64
 
 /* supported filter operations */
 enum perf_bpf_filter_op {
@@ -11,7 +11,9 @@ enum perf_bpf_filter_op {
 	PBF_OP_GE,
 	PBF_OP_LT,
 	PBF_OP_LE,
-	PBF_OP_AND
+	PBF_OP_AND,
+	PBF_OP_GROUP_BEGIN,
+	PBF_OP_GROUP_END,
 };
 
 /* BPF map entry for filtering */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 88dbc788d257..57e3c67d6d37 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -99,6 +99,14 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 	return 0;
 }
 
+#define CHECK_RESULT(data, op, val)			\
+	if (!(data op val)) {				\
+		if (!in_group)				\
+			goto drop;			\
+	} else if (in_group) {				\
+		group_result = 1;			\
+	}
+
 /* BPF program to be called from perf event overflow handler */
 SEC("perf_event")
 int perf_sample_filter(void *ctx)
@@ -106,6 +114,8 @@ int perf_sample_filter(void *ctx)
 	struct bpf_perf_event_data_kern *kctx;
 	struct perf_bpf_filter_entry *entry;
 	__u64 sample_data;
+	int in_group = 0;
+	int group_result = 0;
 	int i;
 
 	kctx = bpf_cast_to_kern_ctx(ctx);
@@ -120,32 +130,34 @@ int perf_sample_filter(void *ctx)
 
 		switch (entry->op) {
 		case PBF_OP_EQ:
-			if (!(sample_data == entry->value))
-				goto drop;
+			CHECK_RESULT(sample_data, ==, entry->value)
 			break;
 		case PBF_OP_NEQ:
-			if (!(sample_data != entry->value))
-				goto drop;
+			CHECK_RESULT(sample_data, !=, entry->value)
 			break;
 		case PBF_OP_GT:
-			if (!(sample_data > entry->value))
-				goto drop;
+			CHECK_RESULT(sample_data, >, entry->value)
 			break;
 		case PBF_OP_GE:
-			if (!(sample_data >= entry->value))
-				goto drop;
+			CHECK_RESULT(sample_data, >=, entry->value)
 			break;
 		case PBF_OP_LT:
-			if (!(sample_data < entry->value))
-				goto drop;
+			CHECK_RESULT(sample_data, <, entry->value)
 			break;
 		case PBF_OP_LE:
-			if (!(sample_data <= entry->value))
-				goto drop;
+			CHECK_RESULT(sample_data, <=, entry->value)
 			break;
 		case PBF_OP_AND:
-			if (!(sample_data & entry->value))
+			CHECK_RESULT(sample_data, &, entry->value)
+			break;
+		case PBF_OP_GROUP_BEGIN:
+			in_group = 1;
+			group_result = 0;
+			break;
+		case PBF_OP_GROUP_END:
+			if (group_result == 0)
 				goto drop;
+			in_group = 0;
 			break;
 		}
 	}
-- 
2.40.0.rc1.284.g88254d51c5-goog

