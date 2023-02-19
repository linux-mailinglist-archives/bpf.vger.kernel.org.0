Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FED69BEC4
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 07:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBSGNs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 01:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBSGNn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 01:13:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C25412BF3;
        Sat, 18 Feb 2023 22:13:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id r12so1114550pjm.0;
        Sat, 18 Feb 2023 22:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvBzyJp5JUt5lxUZzAVd0BD4XNS6WODCu5AtEhqsRE8=;
        b=Q1a/Bn1+ipdX/nqaweP3MC07JTdLIqCsSp4d1RYl3Lmpr/4zfsmoVKymD2JbUTH2Es
         f52Z6j/wI1t2sFGm5iW6aH16iVI3ZYpXrLtvmA1ISW7KQPnlIv3sD9nhqdoczjEO8INr
         Ltqa25eOfxnzdt5mu83PFGPTleiWwO1Qs6bXPzu8WaKLOwDtlqSG4igWMSJEHcVDvKhm
         Icv4Gz77iynxc9OX8ybIQ+nvRl76RYGxk3pnoHApbaHnqO6A+PGD7GGaqR8UrREkhmsV
         KXx4f3CeACvUZLo7JmRCFFfjDkOp3mw5VaNs9H0y+a93mT4kfPb4R/KI+DzG5N+lq/S3
         03OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvBzyJp5JUt5lxUZzAVd0BD4XNS6WODCu5AtEhqsRE8=;
        b=yBB1HRqtQ00cJHLGsktAt/9qAaEnrjG0bGWnOovUV3CoL+MRpg0I3Re9agAX+uckcv
         WCP61WQFjUcEiYkOOZQuo0ZULD+/bxKbW4tE7e4CR2vAKMIzk8hV5IZ5kZ5WLTLw5Eln
         Zkt7UC8RJP0y788Va25t5dSMnlXdoaql0+Hu1Y4gdkh0kKjf247hwsaOhWDbJMqdid6s
         lgR0b2QVKgEhfiLYsBswFzGT+gV5mhKC1qtQT7Q3HBfKjusnRUPiG/Txz77wMOo5Ouvf
         c1Wuon4OllOGCdHQ6TZMWyhxtD4QsqfGenZ78Tsa/CQ/dD1+bglbPTh1gXfIAI4rt4Ew
         Wb/w==
X-Gm-Message-State: AO0yUKWOirK1OQihczH4zFVe0ZqS9JIt+rQhw8EUnt1GrxdSIB17otpB
        L99DgzMHBGoL0aUQxoCJhcA=
X-Google-Smtp-Source: AK7set+dsGC7lV7b7GZ5138UVbrgYNMIuIW4Olf493RfGlBvRy/FCek4UJ83zcuRc8XKWonYIMw4hQ==
X-Received: by 2002:a17:902:fac3:b0:198:f145:504f with SMTP id ld3-20020a170902fac300b00198f145504fmr2904222plb.30.1676787221801;
        Sat, 18 Feb 2023 22:13:41 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:70ac:ab5:11d3:d785])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00189ac5a2340sm1182140plx.124.2023.02.18.22.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 22:13:41 -0800 (PST)
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
Date:   Sat, 18 Feb 2023 22:13:26 -0800
Message-Id: <20230219061329.1001079-6-namhyung@kernel.org>
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
index 510e944a6fa2..0c6035937a6e 100644
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
@@ -47,7 +50,7 @@ filter_term
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
2.39.2.637.g21b0678d19-goog

