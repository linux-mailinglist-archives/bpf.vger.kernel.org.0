Return-Path: <bpf+bounces-30529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095688CEB84
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F019B23459
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745512F368;
	Fri, 24 May 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbSDgvoH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD698627C
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583969; cv=none; b=lf9ComCNmytWAQWVkz3k/e4liJk96C+jn8TRVoyW712MCJqthNXy9AZxBSDugQHLDewIlYWwBrboEaiwxZ8PZtWk45PyOZ/PYSJmbJkd/Sv6DqWgGKfryiq1odAP614IL569uU+B5Xcp29LdlZk1amql/bDm2khxDYNHkjXb9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583969; c=relaxed/simple;
	bh=ZnGq+U2OIJc8CFOxYnwHINc8fAzFLeXXKEEzqgA1xQ4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HSt5s4TVHl36i+CWKGByoAd/X190zWYtSSrwq36DF6uE6FXkKwxh2mQ63rL2ASo1nndk+eZcgJeMKnHaPP4QhttpO8VC0Q8vDZ+8nwQChkYOlhef9eq29pQyLUdNL2wWXsPdt0j0Bm1mRjvHi6BjJrASwCV16UwcG+JBOx+W5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbSDgvoH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df771bdded1so1179261276.3
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716583966; x=1717188766; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tdgyhrssiD6flV8LyTViKC4JwWvZK4NlD2rV/pZIIc=;
        b=tbSDgvoHUAE+w8xNEOO420ZAstTKN1YkLe66YKOd1+RyyI1fgq7tdWOE+/YgIR3sNK
         j1H/hLM52x602A+orJW6wFnAKMVwY5GyyXVMSDZjHpJlytlXgrdalZrRqlfm41xq0n9A
         LrgxBZDZ4hZWLk5Eqef20LGzGQKKamH1phh0L3SqqXdPTNbjGb1k4KivWX2W1qjs3KJM
         VzvNmEVjllrpL7itaHvrXAQj4FtgrrflJoLSjzyLlwJkxNXckvtqibNCl0iZdksz/5cM
         UAiHbMeXefQOgVoohwVzc7zN7QiqFLO7EKeH3BlyEpNJUWPsw5IsQjGQje/sZ78zMu4g
         0kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583966; x=1717188766;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tdgyhrssiD6flV8LyTViKC4JwWvZK4NlD2rV/pZIIc=;
        b=JS0wCEHJofsCra7PnU3/Ak7Pql1LVsQDzMjIME5ffVGh/7Lu37zCDSAKn/aTPNom/K
         1bALbDbiEyfLB4Ruao1x1FQUnpNU6tvj7F7ojMri7LHG51c8XZ5eTzXZwwdyt1ZW056E
         ItcGnOIOz1+fx1+xM8T9M+a+8Q+hsOtCZuOSDjET5TEet3lShBKommBb4fwJuSK9Z9/d
         +oWpjn/PZ/6/kq1K1hqeahFZmStKnJnQHzG60LayrN1iRVy1d1uZIsSvH8mGSD/W6m1G
         eDHXc5a3u7aMrONHiaD7xXdNFF3h/E+Ug65XS1rw/JUGHQ7TtJO+5BpqO2wtY91rwpis
         hYhg==
X-Forwarded-Encrypted: i=1; AJvYcCX0c7wUrmdrst6dqnnTyRCbGzjF0lRZJ5jE1YwCKqvBwA1/Pk9Fo70ab90Aw9xEH3B53G1FpLLX1X4CylKLL2fiq3B/
X-Gm-Message-State: AOJu0YwDLDShD5e49eH3qfNChZrmOqij9UNuw4KTjdR8C5VcbUjkxyHH
	2arTpt32VP9TTNqObldyjelUwtE7eKn+tVm/ONyYEbgXuSFsi9WjaN/5SdUWKS0/9Lw82sn10Zt
	tSOYj4Q==
X-Google-Smtp-Source: AGHT+IHRrkrhfOHz727Jq54EC9Dwhu9S0ve/jiPvYQIW2Phs3meGo3PT1Jured7gyKHKyacvfszbEe01A4Zz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b04:b0:de5:2694:45ba with SMTP
 id 3f1490d57ef6-df772051f6dmr924326276.0.1716583966720; Fri, 24 May 2024
 13:52:46 -0700 (PDT)
Date: Fri, 24 May 2024 13:52:25 -0700
In-Reply-To: <20240524205227.244375-1-irogers@google.com>
Message-Id: <20240524205227.244375-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524205227.244375-1-irogers@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v3 1/3] perf bpf filter: Give terms their own enum
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Give the term types their own enum so that additional terms can be
added that don't correspond to a PERF_SAMPLE_xx flag. The term values
are numerically ascending rather than bit field positions, this means
they need translating to a PERF_SAMPLE_xx bit field in certain places
using a shift.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c                 | 28 ++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 64 +++++++++---------
 tools/perf/util/bpf-filter.y                 |  7 +-
 tools/perf/util/bpf_skel/sample-filter.h     | 37 ++++++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 69 +++++++++++++++-----
 6 files changed, 141 insertions(+), 69 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index b51544996046..f10148623a8e 100644
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
@@ -59,7 +59,8 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 {
 	const struct perf_sample_info *info;
 
-	if (evsel->core.attr.sample_type & expr->sample_flags)
+	if (expr->term >= PBF_TERM_SAMPLE_START && expr->term <= PBF_TERM_SAMPLE_END &&
+	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
 		return 0;
 
 	if (expr->op == PBF_OP_GROUP_BEGIN) {
@@ -72,10 +73,10 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
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
 
@@ -105,7 +106,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 		struct perf_bpf_filter_entry entry = {
 			.op = expr->op,
 			.part = expr->part,
-			.flags = expr->sample_flags,
+			.term = expr->term,
 			.value = expr->val,
 		};
 
@@ -122,7 +123,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 				struct perf_bpf_filter_entry group_entry = {
 					.op = group->op,
 					.part = group->part,
-					.flags = group->sample_flags,
+					.term = group->term,
 					.value = group->val,
 				};
 				bpf_map_update_elem(fd, &i, &group_entry, BPF_ANY);
@@ -173,7 +174,8 @@ u64 perf_bpf_filter__lost_count(struct evsel *evsel)
 	return skel ? skel->bss->dropped : 0;
 }
 
-struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags, int part,
+struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term term,
+						       int part,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val)
 {
@@ -181,7 +183,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flag
 
 	expr = malloc(sizeof(*expr));
 	if (expr != NULL) {
-		expr->sample_flags = sample_flags;
+		expr->term = term;
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
index 2e96e1ab084a..25f780022951 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -16,12 +16,45 @@ enum perf_bpf_filter_op {
 	PBF_OP_GROUP_END,
 };
 
+enum perf_bpf_filter_term {
+	/* No term is in use. */
+	PBF_TERM_NONE = 0,
+	/* Terms that correspond to PERF_SAMPLE_xx values. */
+	PBF_TERM_SAMPLE_START	= PBF_TERM_NONE + 1,
+	PBF_TERM_IP		= PBF_TERM_SAMPLE_START + 0, /* SAMPLE_IP = 1U << 0 */
+	PBF_TERM_TID		= PBF_TERM_SAMPLE_START + 1, /* SAMPLE_TID = 1U << 1 */
+	PBF_TERM_TIME		= PBF_TERM_SAMPLE_START + 2, /* SAMPLE_TIME = 1U << 2 */
+	PBF_TERM_ADDR		= PBF_TERM_SAMPLE_START + 3, /* SAMPLE_ADDR = 1U << 3 */
+	__PBF_UNUSED_TERM4	= PBF_TERM_SAMPLE_START + 4, /* SAMPLE_READ = 1U << 4 */
+	__PBF_UNUSED_TERM5	= PBF_TERM_SAMPLE_START + 5, /* SAMPLE_CALLCHAIN = 1U << 5 */
+	PBF_TERM_ID		= PBF_TERM_SAMPLE_START + 6, /* SAMPLE_ID = 1U << 6 */
+	PBF_TERM_CPU		= PBF_TERM_SAMPLE_START + 7, /* SAMPLE_CPU = 1U << 7 */
+	PBF_TERM_PERIOD		= PBF_TERM_SAMPLE_START + 8, /* SAMPLE_PERIOD = 1U << 8 */
+	__PBF_UNUSED_TERM9	= PBF_TERM_SAMPLE_START + 9, /* SAMPLE_STREAM_ID = 1U << 9 */
+	__PBF_UNUSED_TERM10	= PBF_TERM_SAMPLE_START + 10, /* SAMPLE_RAW = 1U << 10 */
+	__PBF_UNUSED_TERM11	= PBF_TERM_SAMPLE_START + 11, /* SAMPLE_BRANCH_STACK = 1U << 11 */
+	__PBF_UNUSED_TERM12	= PBF_TERM_SAMPLE_START + 12, /* SAMPLE_REGS_USER = 1U << 12 */
+	__PBF_UNUSED_TERM13	= PBF_TERM_SAMPLE_START + 13, /* SAMPLE_STACK_USER = 1U << 13 */
+	PBF_TERM_WEIGHT		= PBF_TERM_SAMPLE_START + 14, /* SAMPLE_WEIGHT = 1U << 14 */
+	PBF_TERM_DATA_SRC	= PBF_TERM_SAMPLE_START + 15, /* SAMPLE_DATA_SRC = 1U << 15 */
+	__PBF_UNUSED_TERM16	= PBF_TERM_SAMPLE_START + 16, /* SAMPLE_IDENTIFIER = 1U << 16 */
+	PBF_TERM_TRANSACTION	= PBF_TERM_SAMPLE_START + 17, /* SAMPLE_TRANSACTION = 1U << 17 */
+	__PBF_UNUSED_TERM18	= PBF_TERM_SAMPLE_START + 18, /* SAMPLE_REGS_INTR = 1U << 18 */
+	PBF_TERM_PHYS_ADDR	= PBF_TERM_SAMPLE_START + 19, /* SAMPLE_PHYS_ADDR = 1U << 19 */
+	__PBF_UNUSED_TERM20	= PBF_TERM_SAMPLE_START + 20, /* SAMPLE_AUX = 1U << 20 */
+	__PBF_UNUSED_TERM21	= PBF_TERM_SAMPLE_START + 21, /* SAMPLE_CGROUP = 1U << 21 */
+	PBF_TERM_DATA_PAGE_SIZE	= PBF_TERM_SAMPLE_START + 22, /* SAMPLE_DATA_PAGE_SIZE = 1U << 22 */
+	PBF_TERM_CODE_PAGE_SIZE	= PBF_TERM_SAMPLE_START + 23, /* SAMPLE_CODE_PAGE_SIZE = 1U << 23 */
+	PBF_TERM_WEIGHT_STRUCT	= PBF_TERM_SAMPLE_START + 24, /* SAMPLE_WEIGHT_STRUCT = 1U << 24 */
+	PBF_TERM_SAMPLE_END	= PBF_TERM_WEIGHT_STRUCT,
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
index fb94f5280626..5ac1778ff66e 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -48,31 +48,54 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 {
 	struct perf_sample_data___new *data = (void *)kctx->data;
 
-	if (!bpf_core_field_exists(data->sample_flags) ||
-	    (data->sample_flags & entry->flags) == 0)
+	if (!bpf_core_field_exists(data->sample_flags))
 		return 0;
 
-	switch (entry->flags) {
-	case PERF_SAMPLE_IP:
+#define BUILD_CHECK_SAMPLE(x)					\
+	_Static_assert((1 << (PBF_TERM_##x - PBF_TERM_SAMPLE_START)) == PERF_SAMPLE_##x, \
+		"Mismatched PBF term to sample bit " #x)
+	BUILD_CHECK_SAMPLE(IP);
+	BUILD_CHECK_SAMPLE(TID);
+	BUILD_CHECK_SAMPLE(TIME);
+	BUILD_CHECK_SAMPLE(ADDR);
+	BUILD_CHECK_SAMPLE(ID);
+	BUILD_CHECK_SAMPLE(CPU);
+	BUILD_CHECK_SAMPLE(PERIOD);
+	BUILD_CHECK_SAMPLE(WEIGHT);
+	BUILD_CHECK_SAMPLE(DATA_SRC);
+	BUILD_CHECK_SAMPLE(TRANSACTION);
+	BUILD_CHECK_SAMPLE(PHYS_ADDR);
+	BUILD_CHECK_SAMPLE(DATA_PAGE_SIZE);
+	BUILD_CHECK_SAMPLE(CODE_PAGE_SIZE);
+	BUILD_CHECK_SAMPLE(WEIGHT_STRUCT);
+#undef BUILD_CHECK_SAMPLE
+
+	/* For sample terms check the sample bit is set. */
+	if (entry->term >= PBF_TERM_SAMPLE_START && entry->term <= PBF_TERM_SAMPLE_END &&
+	    (data->sample_flags & (1 << (entry->term - PBF_TERM_SAMPLE_START))) == 0)
+		return 0;
+
+	switch (entry->term) {
+	case PBF_TERM_IP:
 		return kctx->data->ip;
-	case PERF_SAMPLE_ID:
+	case PBF_TERM_ID:
 		return kctx->data->id;
-	case PERF_SAMPLE_TID:
+	case PBF_TERM_TID:
 		if (entry->part)
 			return kctx->data->tid_entry.pid;
 		else
 			return kctx->data->tid_entry.tid;
-	case PERF_SAMPLE_CPU:
+	case PBF_TERM_CPU:
 		return kctx->data->cpu_entry.cpu;
-	case PERF_SAMPLE_TIME:
+	case PBF_TERM_TIME:
 		return kctx->data->time;
-	case PERF_SAMPLE_ADDR:
+	case PBF_TERM_ADDR:
 		return kctx->data->addr;
-	case PERF_SAMPLE_PERIOD:
+	case PBF_TERM_PERIOD:
 		return kctx->data->period;
-	case PERF_SAMPLE_TRANSACTION:
+	case PBF_TERM_TRANSACTION:
 		return kctx->data->txn;
-	case PERF_SAMPLE_WEIGHT_STRUCT:
+	case PBF_TERM_WEIGHT_STRUCT:
 		if (entry->part == 1)
 			return kctx->data->weight.var1_dw;
 		if (entry->part == 2)
@@ -80,15 +103,15 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		if (entry->part == 3)
 			return kctx->data->weight.var3_w;
 		/* fall through */
-	case PERF_SAMPLE_WEIGHT:
+	case PBF_TERM_WEIGHT:
 		return kctx->data->weight.full;
-	case PERF_SAMPLE_PHYS_ADDR:
+	case PBF_TERM_PHYS_ADDR:
 		return kctx->data->phys_addr;
-	case PERF_SAMPLE_CODE_PAGE_SIZE:
+	case PBF_TERM_CODE_PAGE_SIZE:
 		return kctx->data->code_page_size;
-	case PERF_SAMPLE_DATA_PAGE_SIZE:
+	case PBF_TERM_DATA_PAGE_SIZE:
 		return kctx->data->data_page_size;
-	case PERF_SAMPLE_DATA_SRC:
+	case PBF_TERM_DATA_SRC:
 		if (entry->part == 1)
 			return kctx->data->data_src.mem_op;
 		if (entry->part == 2)
@@ -117,6 +140,18 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		}
 		/* return the whole word */
 		return kctx->data->data_src.val;
+	case PBF_TERM_NONE:
+	case __PBF_UNUSED_TERM4:
+	case __PBF_UNUSED_TERM5:
+	case __PBF_UNUSED_TERM9:
+	case __PBF_UNUSED_TERM10:
+	case __PBF_UNUSED_TERM11:
+	case __PBF_UNUSED_TERM12:
+	case __PBF_UNUSED_TERM13:
+	case __PBF_UNUSED_TERM16:
+	case __PBF_UNUSED_TERM18:
+	case __PBF_UNUSED_TERM20:
+	case __PBF_UNUSED_TERM21:
 	default:
 		break;
 	}
-- 
2.45.1.288.g0e0cd299f1-goog


