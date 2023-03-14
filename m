Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926C76BA3BB
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCNXoh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCNXnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:43:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E903E0A2;
        Tue, 14 Mar 2023 16:42:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso98891pjs.3;
        Tue, 14 Mar 2023 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHzEdCPWpaY/eH0Xx+geXzySB0PiK8eElCruHy6sF1Y=;
        b=VC+99Y96mFnic9n2ZvesSjmc+5Pttiidqj3a+wnqCBbtJ50H5zshgsPHjFnL55vOAE
         CvVzJYNsILY2TLlKptUlSS5TjP1l1PMhQfxVTnge4te50kKy5S0QB8UZ04aioiPhHH2M
         v7YnGAHpST/h3fg/apkYnZ4LQhI4iuX8WAFwLx4j6AJ/vSOjSn0KBrAfowDvsqW7M2Zq
         jyDBr92Ng1Fduk8Vhi/XG1x1RljHU3cyGn0P7Hzc4bZtAKQwRjKrFdVUvjDTjgYcmPCe
         6o9BOvJvTYj6lHbYHjK7WJM9/cdD0hi22PVrAXI3fta017nc8TBn2jd6aUF+cnt15xnQ
         Do/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHzEdCPWpaY/eH0Xx+geXzySB0PiK8eElCruHy6sF1Y=;
        b=4y+P8sjKL9V+yN241LB1XRCaStIYkJtUw15e1yrgrROjm3lShL38gW5GATgd0Sf4ju
         FkpK7v8o7jvzI0gKWECj5Qojew7N4R+04YQwDW2YGcfak/C3qwSWC2j2ZgmPPKAtiKLs
         hf0VY0pUCsgPZ/7ylY0KimEgAm7CawGPm6NB7XvZy2UfHvVuObIrP/+SPBI6VKw0Q561
         pvz9UnLoesnw2ULZIs122hAdUVS0WnwtRBV32GOZMFIUXfp/VzvparsNHOoYCyeLOMoD
         9EZqVInK+Bfp6OFfQU79xMWuCURREKwUUO4zOc2/hraneLMXt0crpG1HJ7fQ9xsjuDJv
         0fRQ==
X-Gm-Message-State: AO0yUKVSc57t97zda3UXr2YEFBqoHaecv5/A3TXEcT9hxu5IZthXJBFB
        Shb9T0AYwr39qz3MHZZvQjw=
X-Google-Smtp-Source: AK7set9JcTu+d89Ca3QQhqyQyZiQ3LafJGqfZwwBWTWJrFdpAorX7s4Uw3UG6lDQR4GAkGdmNDGfiw==
X-Received: by 2002:a17:903:2441:b0:19c:e405:4446 with SMTP id l1-20020a170903244100b0019ce4054446mr780141pls.30.1678837370362;
        Tue, 14 Mar 2023 16:42:50 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3826:a5cd:1f1d:6c85])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm2280806plb.18.2023.03.14.16.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:42:50 -0700 (PDT)
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
Subject: [PATCH 08/10] perf bpf filter: Add logical OR operator
Date:   Tue, 14 Mar 2023 16:42:35 -0700
Message-Id: <20230314234237.3008956-9-namhyung@kernel.org>
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

