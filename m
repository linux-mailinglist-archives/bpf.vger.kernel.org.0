Return-Path: <bpf+bounces-29833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE78C70DE
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 06:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31942284339
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 04:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E73B297;
	Thu, 16 May 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gc18Ja6c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0332829CE5
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833206; cv=none; b=IRhzUm3VCwEqAlzIJK034ECMvOUj6Yk6zRfJ+vOyaRNVo3t4n/ZcrH50Uib4Yk1+CfXyX9k0MMIBUD4/3EHpbWJ0Kphy1NdNS0sVEf49S3lVr9JqKi2UB7bhM4sg03gAeRWHrjOr5OABnDHdqcXBB650L3bI9mqNYQpSPViEA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833206; c=relaxed/simple;
	bh=3eQTWjo/mUq9UI9znNISRc8GLjjXboHk30qS5oiw23U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DgTVixOSl241HlVXOHMhQCaEHCtLadNNlY+auYexHwAciT27zAwY/kxzmEEou/dz0MFwSxzExwcv0Vghmvi31/9oREoq27T3CxCb/F5efNspBQEtjkE2begeAcA/5l3qx7kKlHQ3Bxp6Wi4UpZow3kJ1moDEeAD6MPOalni+bQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gc18Ja6c; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be530d024so135127537b3.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 21:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715833204; x=1716438004; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xV54L732c7h1tIY4U/q/4ubjZGCtUOuB0mNZ1nh606I=;
        b=Gc18Ja6cqoXvpCPr60Hjyf7u/HyuFaG0Q8N6PQY4EqRjAcVrxBd797HnsOs4ANAbFr
         jEnhHIiHL1oRuD6W7GJSCPFj/VTomxGxuliosBQODsUdxvkoRHydVWZcHCJY+8qJIn7y
         iEvHHHVfM8IFyhMTCFPgKR7ug3BH+62O/ZJLqK9uMKpbA05c9BYG5M+vLQ7BdPmZOd2e
         cNn94saHLYyPsBZMyuMJv9rjYunV0uEIJY+3ZXXWtD6yjvWfsJXkotG9oKaALTfD5AT7
         A9QBX88SkfzwwED5PHHC2PGIUB+W195mxgd87IE7GcbXVb2NQJKzah1DfOyRzO7i2I0r
         wRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833204; x=1716438004;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xV54L732c7h1tIY4U/q/4ubjZGCtUOuB0mNZ1nh606I=;
        b=ZwRuS4M9i247JLtDvkwqGCPco8Q6jWIzfrI3bH6phyaQaa28OeE8wEf1LmCszSAeTp
         8Mgoet8iYMCydK4/aM/O1iRe+iYWlUFVz+fEpVZjHO1Xudrn5U6YF0G471QZU7y6/09D
         V+AFljvv6UO60oV4BnTkkdv7Hs2MOoXyUSgj/IbrI2nGuVbo9RebnOu0JNMnnT/zuuCw
         UddyZee0+EoEk757062dnUfNTdp9M11rikRdfFKmJmlfvTCMP2DM/0GDj9Qp6oKKbz3T
         H98+064T8Gj3+n0S9VW/LLnoj442SsWCp8eEUiye7gUjZknr+pTDHQ06/q/fSoJvxzNv
         By/A==
X-Forwarded-Encrypted: i=1; AJvYcCUgOZeMopfWhkpUS7m232oQASsNHcf3PR83p7CC8xfSZkwshrTj9l/JEGAasolmluGO1Tcpm9k7kVytc+gujm2TRwPn
X-Gm-Message-State: AOJu0YyE45ooY0mK6Tt8A6yyeSndKXMo0GhxAnGjefxqa4rkkxZexm2v
	nGiEvMIOBH18XHD7m9Z41wvnlVvjYVUvUgHzmQU4JuXZ/sF8WypDGKzcTRqALbMxzM78BqxLMFb
	0udwlHQ==
X-Google-Smtp-Source: AGHT+IFtud8s4aGISJM7vbOFLnQNC9CcaTFhfPiItTTlpZ7BVA0AGrl4oZwsKhyHtK9e2Tih5Cb6VK+N2+vZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b93:b0:de5:bc2f:72bb with SMTP
 id 3f1490d57ef6-dee4f531f3bmr1620548276.12.1715833203327; Wed, 15 May 2024
 21:20:03 -0700 (PDT)
Date: Wed, 15 May 2024 21:19:46 -0700
In-Reply-To: <20240516041948.3546553-1-irogers@google.com>
Message-Id: <20240516041948.3546553-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 1/3] perf bpf filter: Give terms their own enum
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Give the term types their own enum so that additional terms can be
added that don't correspond to a PERF_SAMPLE_xx flag. The term values
are numerically ascending rather than bit field positions, this means
they need translating to a PERF_SAMPLE_xx bit field in certain places
and they are more densely encoded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c                 | 53 +++++++++++-----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 64 ++++++++++----------
 tools/perf/util/bpf-filter.y                 |  7 ++-
 tools/perf/util/bpf_skel/sample-filter.h     | 24 +++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 63 +++++++++++++------
 6 files changed, 146 insertions(+), 70 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index b51544996046..7e8d179f03dc 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -17,11 +17,11 @@
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
-#define __PERF_SAMPLE_TYPE(st, opt)	{ st, #st, opt }
-#define PERF_SAMPLE_TYPE(_st, opt)	__PERF_SAMPLE_TYPE(PERF_SAMPLE_##_st, opt)
+#define __PERF_SAMPLE_TYPE(tt, st, opt)	{ tt, #st, opt }
+#define PERF_SAMPLE_TYPE(_st, opt)	__PERF_SAMPLE_TYPE(PBF_TERM_##_st, PERF_SAMPLE_##_st, opt)
 
 static const struct perf_sample_info {
-	u64 type;
+	enum perf_bpf_filter_term type;
 	const char *name;
 	const char *option;
 } sample_table[] = {
@@ -44,12 +44,12 @@ static const struct perf_sample_info {
 	PERF_SAMPLE_TYPE(DATA_PAGE_SIZE, "--data-page-size"),
 };
 
-static const struct perf_sample_info *get_sample_info(u64 flags)
+static const struct perf_sample_info *get_sample_info(enum perf_bpf_filter_term type)
 {
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(sample_table); i++) {
-		if (sample_table[i].type == flags)
+		if (sample_table[i].type == type)
 			return &sample_table[i];
 	}
 	return NULL;
@@ -59,8 +59,32 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 {
 	const struct perf_sample_info *info;
 
-	if (evsel->core.attr.sample_type & expr->sample_flags)
-		return 0;
+#define CHECK_TERM(x) \
+	case PBF_TERM_##x:						\
+		if (evsel->core.attr.sample_type & PERF_SAMPLE_##x)	\
+			return 0;					\
+		break
+
+	switch (expr->term) {
+		CHECK_TERM(IP);
+		CHECK_TERM(ID);
+		CHECK_TERM(TID);
+		CHECK_TERM(CPU);
+		CHECK_TERM(TIME);
+		CHECK_TERM(ADDR);
+		CHECK_TERM(PERIOD);
+		CHECK_TERM(TRANSACTION);
+		CHECK_TERM(WEIGHT);
+		CHECK_TERM(PHYS_ADDR);
+		CHECK_TERM(CODE_PAGE_SIZE);
+		CHECK_TERM(DATA_PAGE_SIZE);
+		CHECK_TERM(WEIGHT_STRUCT);
+		CHECK_TERM(DATA_SRC);
+	case PBF_TERM_NONE:
+	default:
+		break;
+	}
+#undef CHECK_TERM
 
 	if (expr->op == PBF_OP_GROUP_BEGIN) {
 		struct perf_bpf_filter_expr *group;
@@ -72,10 +96,10 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 		return 0;
 	}
 
-	info = get_sample_info(expr->sample_flags);
+	info = get_sample_info(expr->term);
 	if (info == NULL) {
-		pr_err("Error: %s event does not have sample flags %lx\n",
-		       evsel__name(evsel), expr->sample_flags);
+		pr_err("Error: %s event does not have sample flags %d\n",
+		       evsel__name(evsel), expr->term);
 		return -1;
 	}
 
@@ -105,7 +129,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 		struct perf_bpf_filter_entry entry = {
 			.op = expr->op,
 			.part = expr->part,
-			.flags = expr->sample_flags,
+			.term = expr->term,
 			.value = expr->val,
 		};
 
@@ -122,7 +146,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 				struct perf_bpf_filter_entry group_entry = {
 					.op = group->op,
 					.part = group->part,
-					.flags = group->sample_flags,
+					.term = group->term,
 					.value = group->val,
 				};
 				bpf_map_update_elem(fd, &i, &group_entry, BPF_ANY);
@@ -173,7 +197,8 @@ u64 perf_bpf_filter__lost_count(struct evsel *evsel)
 	return skel ? skel->bss->dropped : 0;
 }
 
-struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags, int part,
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term term,
+						       int part,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val)
 {
@@ -181,7 +206,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
 
 	expr = malloc(sizeof(*expr));
 	if (expr != NULL) {
-		expr->sample_flags = sample_flags;
+		expr->term = term,
 		expr->part = part;
 		expr->op = op;
 		expr->val = val;
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 7afd159411b8..cd6764442c16 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -11,14 +11,15 @@ struct perf_bpf_filter_expr {
 	struct list_head groups;
 	enum perf_bpf_filter_op op;
 	int part;
-	unsigned long sample_flags;
+	enum perf_bpf_filter_term term;
 	unsigned long val;
 };
 
 struct evsel;
 
 #ifdef HAVE_BPF_SKEL
-struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags, int part,
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term term,
+						       int part,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val);
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index d4ff0f1345cd..62c959813466 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -9,16 +9,16 @@
 #include "bpf-filter.h"
 #include "bpf-filter-bison.h"
 
-static int sample(unsigned long sample_flag)
+static int sample(enum perf_bpf_filter_term term)
 {
-	perf_bpf_filter_lval.sample.type = sample_flag;
+	perf_bpf_filter_lval.sample.term = term;
 	perf_bpf_filter_lval.sample.part = 0;
 	return BFT_SAMPLE;
 }
 
-static int sample_part(unsigned long sample_flag, int part)
+static int sample_part(enum perf_bpf_filter_term term, int part)
 {
-	perf_bpf_filter_lval.sample.type = sample_flag;
+	perf_bpf_filter_lval.sample.term = term;
 	perf_bpf_filter_lval.sample.part = part;
 	return BFT_SAMPLE;
 }
@@ -67,34 +67,34 @@ ident		[_a-zA-Z][_a-zA-Z0-9]+
 {num_hex}	{ return value(16); }
 {space}		{ }
 
-ip		{ return sample(PERF_SAMPLE_IP); }
-id		{ return sample(PERF_SAMPLE_ID); }
-tid		{ return sample(PERF_SAMPLE_TID); }
-pid		{ return sample_part(PERF_SAMPLE_TID, 1); }
-cpu		{ return sample(PERF_SAMPLE_CPU); }
-time		{ return sample(PERF_SAMPLE_TIME); }
-addr		{ return sample(PERF_SAMPLE_ADDR); }
-period		{ return sample(PERF_SAMPLE_PERIOD); }
-txn		{ return sample(PERF_SAMPLE_TRANSACTION); }
-weight		{ return sample(PERF_SAMPLE_WEIGHT); }
-weight1		{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 1); }
-weight2		{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 2); }
-weight3		{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 3); }
-ins_lat		{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 2); } /* alias for weight2 */
-p_stage_cyc	{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 3); } /* alias for weight3 */
-retire_lat	{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 3); } /* alias for weight3 */
-phys_addr	{ return sample(PERF_SAMPLE_PHYS_ADDR); }
-code_pgsz	{ return sample(PERF_SAMPLE_CODE_PAGE_SIZE); }
-data_pgsz	{ return sample(PERF_SAMPLE_DATA_PAGE_SIZE); }
-mem_op		{ return sample_part(PERF_SAMPLE_DATA_SRC, 1); }
-mem_lvlnum	{ return sample_part(PERF_SAMPLE_DATA_SRC, 2); }
-mem_lvl		{ return sample_part(PERF_SAMPLE_DATA_SRC, 2); } /* alias for mem_lvlnum */
-mem_snoop	{ return sample_part(PERF_SAMPLE_DATA_SRC, 3); } /* include snoopx */
-mem_remote	{ return sample_part(PERF_SAMPLE_DATA_SRC, 4); }
-mem_lock	{ return sample_part(PERF_SAMPLE_DATA_SRC, 5); }
-mem_dtlb	{ return sample_part(PERF_SAMPLE_DATA_SRC, 6); }
-mem_blk		{ return sample_part(PERF_SAMPLE_DATA_SRC, 7); }
-mem_hops	{ return sample_part(PERF_SAMPLE_DATA_SRC, 8); }
+ip		{ return sample(PBF_TERM_IP); }
+id		{ return sample(PBF_TERM_ID); }
+tid		{ return sample(PBF_TERM_TID); }
+pid		{ return sample_part(PBF_TERM_TID, 1); }
+cpu		{ return sample(PBF_TERM_CPU); }
+time		{ return sample(PBF_TERM_TIME); }
+addr		{ return sample(PBF_TERM_ADDR); }
+period		{ return sample(PBF_TERM_PERIOD); }
+txn		{ return sample(PBF_TERM_TRANSACTION); }
+weight		{ return sample(PBF_TERM_WEIGHT); }
+weight1		{ return sample_part(PBF_TERM_WEIGHT_STRUCT, 1); }
+weight2		{ return sample_part(PBF_TERM_WEIGHT_STRUCT, 2); }
+weight3		{ return sample_part(PBF_TERM_WEIGHT_STRUCT, 3); }
+ins_lat		{ return sample_part(PBF_TERM_WEIGHT_STRUCT, 2); } /* alias for weight2 */
+p_stage_cyc	{ return sample_part(PBF_TERM_WEIGHT_STRUCT, 3); } /* alias for weight3 */
+retire_lat	{ return sample_part(PBF_TERM_WEIGHT_STRUCT, 3); } /* alias for weight3 */
+phys_addr	{ return sample(PBF_TERM_PHYS_ADDR); }
+code_pgsz	{ return sample(PBF_TERM_CODE_PAGE_SIZE); }
+data_pgsz	{ return sample(PBF_TERM_DATA_PAGE_SIZE); }
+mem_op		{ return sample_part(PBF_TERM_DATA_SRC, 1); }
+mem_lvlnum	{ return sample_part(PBF_TERM_DATA_SRC, 2); }
+mem_lvl		{ return sample_part(PBF_TERM_DATA_SRC, 2); } /* alias for mem_lvlnum */
+mem_snoop	{ return sample_part(PBF_TERM_DATA_SRC, 3); } /* include snoopx */
+mem_remote	{ return sample_part(PBF_TERM_DATA_SRC, 4); }
+mem_lock	{ return sample_part(PBF_TERM_DATA_SRC, 5); }
+mem_dtlb	{ return sample_part(PBF_TERM_DATA_SRC, 6); }
+mem_blk		{ return sample_part(PBF_TERM_DATA_SRC, 7); }
+mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
 
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 0e4d6de3c2ad..0c56fccb8874 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -27,7 +27,7 @@ static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 {
 	unsigned long num;
 	struct {
-		unsigned long type;
+		enum perf_bpf_filter_term term;
 		int part;
 	} sample;
 	enum perf_bpf_filter_op op;
@@ -62,7 +62,8 @@ filter_term BFT_LOGICAL_OR filter_expr
 	if ($1->op == PBF_OP_GROUP_BEGIN) {
 		expr = $1;
 	} else {
-		expr = perf_bpf_filter_expr__new(0, 0, PBF_OP_GROUP_BEGIN, 1);
+		expr = perf_bpf_filter_expr__new(PBF_TERM_NONE, /*part=*/0,
+						 PBF_OP_GROUP_BEGIN, /*val=*/1);
 		list_add_tail(&$1->list, &expr->groups);
 	}
 	expr->val++;
@@ -78,7 +79,7 @@ filter_expr
 filter_expr:
 BFT_SAMPLE BFT_OP BFT_NUM
 {
-	$$ = perf_bpf_filter_expr__new($1.type, $1.part, $2, $3);
+	$$ = perf_bpf_filter_expr__new($1.term, $1.part, $2, $3);
 }
 
 %%
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 2e96e1ab084a..161d5ff49cb6 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -16,12 +16,32 @@ enum perf_bpf_filter_op {
 	PBF_OP_GROUP_END,
 };
 
+enum perf_bpf_filter_term {
+	/* No term is in use. */
+	PBF_TERM_NONE,
+	/* Terms that correspond to PERF_SAMPLE_xx values. */
+	PBF_TERM_IP,
+	PBF_TERM_ID,
+	PBF_TERM_TID,
+	PBF_TERM_CPU,
+	PBF_TERM_TIME,
+	PBF_TERM_ADDR,
+	PBF_TERM_PERIOD,
+	PBF_TERM_TRANSACTION,
+	PBF_TERM_WEIGHT,
+	PBF_TERM_PHYS_ADDR,
+	PBF_TERM_CODE_PAGE_SIZE,
+	PBF_TERM_DATA_PAGE_SIZE,
+	PBF_TERM_WEIGHT_STRUCT,
+	PBF_TERM_DATA_SRC,
+};
+
 /* BPF map entry for filtering */
 struct perf_bpf_filter_entry {
 	enum perf_bpf_filter_op op;
 	__u32 part; /* sub-sample type info when it has multiple values */
-	__u64 flags; /* perf sample type flags */
+	enum perf_bpf_filter_term term;
 	__u64 value;
 };
 
-#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
\ No newline at end of file
+#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index fb94f5280626..8666c85e9333 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -48,31 +48,50 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 {
 	struct perf_sample_data___new *data = (void *)kctx->data;
 
-	if (!bpf_core_field_exists(data->sample_flags) ||
-	    (data->sample_flags & entry->flags) == 0)
+	if (!bpf_core_field_exists(data->sample_flags))
 		return 0;
 
-	switch (entry->flags) {
-	case PERF_SAMPLE_IP:
+	switch (entry->term) {
+	case PBF_TERM_NONE:
+		return 0;
+	case PBF_TERM_IP:
+		if ((data->sample_flags & PERF_SAMPLE_IP) == 0)
+			return 0;
 		return kctx->data->ip;
-	case PERF_SAMPLE_ID:
+	case PBF_TERM_ID:
+		if ((data->sample_flags & PERF_SAMPLE_ID) == 0)
+			return 0;
 		return kctx->data->id;
-	case PERF_SAMPLE_TID:
+	case PBF_TERM_TID:
+		if ((data->sample_flags & PERF_SAMPLE_TID) == 0)
+			return 0;
 		if (entry->part)
 			return kctx->data->tid_entry.pid;
 		else
 			return kctx->data->tid_entry.tid;
-	case PERF_SAMPLE_CPU:
+	case PBF_TERM_CPU:
+		if ((data->sample_flags & PERF_SAMPLE_CPU) == 0)
+			return 0;
 		return kctx->data->cpu_entry.cpu;
-	case PERF_SAMPLE_TIME:
+	case PBF_TERM_TIME:
+		if ((data->sample_flags & PERF_SAMPLE_TIME) == 0)
+			return 0;
 		return kctx->data->time;
-	case PERF_SAMPLE_ADDR:
+	case PBF_TERM_ADDR:
+		if ((data->sample_flags & PERF_SAMPLE_ADDR) == 0)
+			return 0;
 		return kctx->data->addr;
-	case PERF_SAMPLE_PERIOD:
+	case PBF_TERM_PERIOD:
+		if ((data->sample_flags & PERF_SAMPLE_PERIOD) == 0)
+			return 0;
 		return kctx->data->period;
-	case PERF_SAMPLE_TRANSACTION:
+	case PBF_TERM_TRANSACTION:
+		if ((data->sample_flags & PERF_SAMPLE_TRANSACTION) == 0)
+			return 0;
 		return kctx->data->txn;
-	case PERF_SAMPLE_WEIGHT_STRUCT:
+	case PBF_TERM_WEIGHT_STRUCT:
+		if ((data->sample_flags & PERF_SAMPLE_WEIGHT_STRUCT) == 0)
+			return 0;
 		if (entry->part == 1)
 			return kctx->data->weight.var1_dw;
 		if (entry->part == 2)
@@ -80,15 +99,25 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		if (entry->part == 3)
 			return kctx->data->weight.var3_w;
 		/* fall through */
-	case PERF_SAMPLE_WEIGHT:
+	case PBF_TERM_WEIGHT:
+		if ((data->sample_flags & PERF_SAMPLE_WEIGHT) == 0)
+			return 0;
 		return kctx->data->weight.full;
-	case PERF_SAMPLE_PHYS_ADDR:
+	case PBF_TERM_PHYS_ADDR:
+		if ((data->sample_flags & PERF_SAMPLE_PHYS_ADDR) == 0)
+			return 0;
 		return kctx->data->phys_addr;
-	case PERF_SAMPLE_CODE_PAGE_SIZE:
+	case PBF_TERM_CODE_PAGE_SIZE:
+		if ((data->sample_flags & PERF_SAMPLE_CODE_PAGE_SIZE) == 0)
+			return 0;
 		return kctx->data->code_page_size;
-	case PERF_SAMPLE_DATA_PAGE_SIZE:
+	case PBF_TERM_DATA_PAGE_SIZE:
+		if ((data->sample_flags & PERF_SAMPLE_DATA_PAGE_SIZE) == 0)
+			return 0;
 		return kctx->data->data_page_size;
-	case PERF_SAMPLE_DATA_SRC:
+	case PBF_TERM_DATA_SRC:
+		if ((data->sample_flags & PERF_SAMPLE_DATA_SRC) == 0)
+			return 0;
 		if (entry->part == 1)
 			return kctx->data->data_src.mem_op;
 		if (entry->part == 2)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


