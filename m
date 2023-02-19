Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC169BECA
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 07:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBSGOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 01:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBSGOG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 01:14:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050C013D57;
        Sat, 18 Feb 2023 22:13:47 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f8-20020a17090ac28800b00233d7314c1cso103797pjt.5;
        Sat, 18 Feb 2023 22:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gN8E44qYK1VjzQVWIb3XOtq2U8NR24vawLMGmfvkdw=;
        b=peHhq0bBQU6unbUIMfKArDPXNRFcTtvWLekxgi+j8mPTvRJ/oy9iEF4JWteo1c4rPZ
         3Kd7jTFFYtqNL1e52uLjjiUjtSUzil4lzmR0xCJIKweY/8WkbQODKBFYTOY9dcTgjsfb
         zlLC36MglbzkIvJyu3gVpxuNN1OQEGtD2veyg6XUOpToymvcF2BBpdt3WY/rVJqVESOH
         ohQFD819cHPDEluOUIkqxxiCF8HT+l3fV/+fbwCUSBw5fkIvz648DwaN+z6N/fJd1MVG
         S40NPZut0891qlG94ZUqEKyhqkM0k2cYzjd0Tz8kszgEYcQRVW1Ceh4XyZKN1aQnun8D
         BGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5gN8E44qYK1VjzQVWIb3XOtq2U8NR24vawLMGmfvkdw=;
        b=PtwAWqzAiNfK6zOAKisMAFqpIfpvoFEEainEvCUaEb1ToNhQECm+/OAWRgXIoRvEKk
         WyCJJfMy/n/v2Kem8HeHoB4iXo38tuX6V8OsKSPoRTTC0v0TdTMHiGYyAYSB2fjMt4yA
         T5qGVjEKtjno91w+5pBwPBCCeo2p1+be3EZBL6gL17cu8L+igtfX4eAiBkpg0xVjXx/M
         Zt6UxDLmLiela4xHcWJJ6Fo7dcP92/jLMfxz308wrbH3h0eK+tncdbGLQThAq2Z3vtWH
         syZp0Sq8BWmt9YZQcfxeyHz30df9EiRepDigtmN4Iljk+bsVPe8v/rlouwFGYRnbWibP
         sdwA==
X-Gm-Message-State: AO0yUKW1CdBII8mmF5sEdL10NWUEfhXFoGui2rrzrXP6EWK5kHNGP7uf
        Fi9UIA60FAluoR6jdeuDw5E=
X-Google-Smtp-Source: AK7set8nrZEmfhRfOGcDXg3CfnLVJmhbff8KTZFyP0etwiBZ9WnuunKZCCuwdvlKYN14OrrcxieRzQ==
X-Received: by 2002:a17:903:228a:b0:19b:33c0:4092 with SMTP id b10-20020a170903228a00b0019b33c04092mr631255plh.24.1676787226966;
        Sat, 18 Feb 2023 22:13:46 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:70ac:ab5:11d3:d785])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00189ac5a2340sm1182140plx.124.2023.02.18.22.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 22:13:46 -0800 (PST)
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
Subject: [PATCH 8/8] perf bpf filter: Add logical OR operator
Date:   Sat, 18 Feb 2023 22:13:29 -0800
Message-Id: <20230219061329.1001079-9-namhyung@kernel.org>
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
index 2e02dc965dd9..79d79992e608 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -49,8 +49,32 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
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
@@ -96,6 +120,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
 		expr->part = part;
 		expr->op = op;
 		expr->val = val;
+		INIT_LIST_HEAD(&expr->groups);
 	}
 	return expr;
 }
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 4fb33d296d9c..cf2b605e9121 100644
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
index 3af9331302cf..817531428530 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -141,6 +141,7 @@ hops2		{ return constant(PERF_MEM_HOPS_2); }
 hops3		{ return constant(PERF_MEM_HOPS_3); }
 
 ","		{ return ','; }
+"||"		{ return BFT_LOGICAL_OR; }
 .		{ }
 
 %%
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 0c6035937a6e..19de79131ad3 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -27,8 +27,8 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 	struct perf_bpf_filter_expr *expr;
 }
 
-%token BFT_SAMPLE BFT_OP BFT_ERROR BFT_NUM
-%type <expr> filter_term
+%token BFT_SAMPLE BFT_OP BFT_ERROR BFT_NUM BFT_LOGICAL_OR
+%type <expr> filter_term filter_expr
 %destructor { free ($$); } <expr>
 %type <sample> BFT_SAMPLE
 %type <op> BFT_OP
@@ -48,6 +48,27 @@ filter_term
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
index 0148b47de7b9..4b4269054ed8 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -91,6 +91,14 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
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
@@ -98,6 +106,8 @@ int perf_sample_filter(void *ctx)
 	struct bpf_perf_event_data_kern *kctx;
 	struct perf_bpf_filter_entry *entry;
 	__u64 sample_data;
+	int in_group = 0;
+	int group_result = 0;
 	int i;
 
 	kctx = bpf_cast_to_kern_ctx(ctx);
@@ -112,32 +122,34 @@ int perf_sample_filter(void *ctx)
 
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
2.39.2.637.g21b0678d19-goog

