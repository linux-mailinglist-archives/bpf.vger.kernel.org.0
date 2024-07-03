Return-Path: <bpf+bounces-33827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF2926B8E
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C102C282DFC
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8CB19412E;
	Wed,  3 Jul 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHJ2AoUz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D0191F70;
	Wed,  3 Jul 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045837; cv=none; b=E5ibfQsG6RpaPdg40CS5Suxp/rXfLeeercqBf0NdmcWpDvSuEtKZ0SQKzRnYhca62Fvl6zgLJWin3L7YHnuETl3Y084s4ew2f5SWem83n5/w6sIC7bmDTcdjg7nl7TbrgnoumS/A7d6b/pQX6msm/UQNXzrwfWKtMMvoUeIVS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045837; c=relaxed/simple;
	bh=nndiyJer93s+jzwVVuO+Yfa6ZgVjNDXW/14wUZXaLpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s42K7udvYeugXJOLmpHLgJiJVeZvzcOTkBP366MKCdGo+RviuTe2mlqMYMSF4lhFuqQf2ZL7Pg0EiLha57/9WS5p6m5g6ITOPIC3PjXt7RvTXRDlJOVrOROk+yl7/h0f6MrEJFksvKbZiSAPk2md7z8DhA8g7AQaxO1vsjqoND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHJ2AoUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C3BC4AF0F;
	Wed,  3 Jul 2024 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045837;
	bh=nndiyJer93s+jzwVVuO+Yfa6ZgVjNDXW/14wUZXaLpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHJ2AoUz6xU6M27ml3hFeQBSb1QGJnSXZHFaRug1qfPlZ7o8/PnnjZObJasvp+fPj
	 RC4mBZMCVK6TKWGdH0d7SlcshhfxxdL0Wm1nfXqpdVPcB3LioyPqjjPqNrodhln9l2
	 nM3eIuBos6hrysxnvvVvHZvAJsnQ9E7P+kAnnaFrvFY4/O0tOXHIXoRkBFlVv/piwJ
	 AS2Go8I2T/IoRgJaBOMsXtAQF/HaCRA6mXCx2DLj84DG4VU8JBz/D7yafIC4aFZMg4
	 /1ffTvM7gzs7Tftwbk6i/tjNrP8c12xqNs9dvGt2OZCOq6mhYNG/gAkHh0vW+HctR2
	 EjyRIUyqdkU6g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 1/8] perf bpf-filter: Make filters map a single entry hashmap
Date: Wed,  3 Jul 2024 15:30:28 -0700
Message-ID: <20240703223035.2024586-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240703223035.2024586-1-namhyung@kernel.org>
References: <20240703223035.2024586-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And the value is now an array.  This is to support multiple filter
entries in the map later.

No functional changes intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c                 | 81 ++++++++++++++------
 tools/perf/util/bpf_skel/sample-filter.h     |  1 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 39 +++++-----
 3 files changed, 78 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 04f98b6bb291..2510832d83f9 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -93,71 +93,102 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 
 int perf_bpf_filter__prepare(struct evsel *evsel)
 {
-	int i, x, y, fd;
+	int i, x, y, fd, ret;
 	struct sample_filter_bpf *skel;
 	struct bpf_program *prog;
 	struct bpf_link *link;
 	struct perf_bpf_filter_expr *expr;
+	struct perf_bpf_filter_entry *entry;
+
+	entry = calloc(MAX_FILTERS, sizeof(*entry));
+	if (entry == NULL)
+		return -1;
 
 	skel = sample_filter_bpf__open_and_load();
 	if (!skel) {
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
-		return -1;
+		ret = -EPERM;
+		goto err;
 	}
 
 	i = 0;
 	fd = bpf_map__fd(skel->maps.filters);
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
-		struct perf_bpf_filter_entry entry = {
-			.op = expr->op,
-			.part = expr->part,
-			.term = expr->term,
-			.value = expr->val,
-		};
+		if (check_sample_flags(evsel, expr) < 0) {
+			ret = -EINVAL;
+			goto err;
+		}
 
-		if (check_sample_flags(evsel, expr) < 0)
-			return -1;
+		if (i == MAX_FILTERS) {
+			ret = -E2BIG;
+			goto err;
+		}
 
-		bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
+		entry[i].op = expr->op;
+		entry[i].part = expr->part;
+		entry[i].term = expr->term;
+		entry[i].value = expr->val;
 		i++;
 
 		if (expr->op == PBF_OP_GROUP_BEGIN) {
 			struct perf_bpf_filter_expr *group;
 
 			list_for_each_entry(group, &expr->groups, list) {
-				struct perf_bpf_filter_entry group_entry = {
-					.op = group->op,
-					.part = group->part,
-					.term = group->term,
-					.value = group->val,
-				};
-				bpf_map_update_elem(fd, &i, &group_entry, BPF_ANY);
+				if (i == MAX_FILTERS) {
+					ret = -E2BIG;
+					goto err;
+				}
+
+				entry[i].op = group->op;
+				entry[i].part = group->part;
+				entry[i].term = group->term;
+				entry[i].value = group->val;
 				i++;
 			}
 
-			memset(&entry, 0, sizeof(entry));
-			entry.op = PBF_OP_GROUP_END;
-			bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
+			if (i == MAX_FILTERS) {
+				ret = -E2BIG;
+				goto err;
+			}
+
+			entry[i].op = PBF_OP_GROUP_END;
 			i++;
 		}
 	}
 
-	if (i > MAX_FILTERS) {
-		pr_err("Too many filters: %d (max = %d)\n", i, MAX_FILTERS);
-		return -1;
+	if (i < MAX_FILTERS) {
+		/* to terminate the loop early */
+		entry[i].op = PBF_OP_DONE;
+		i++;
+	}
+
+	/* The filters map has only one entry for now */
+	i = 0;
+	if (bpf_map_update_elem(fd, &i, entry, BPF_ANY) < 0) {
+		ret = -errno;
+		pr_err("Failed to update the filter map\n");
+		goto err;
 	}
+
 	prog = skel->progs.perf_sample_filter;
 	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
 		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
 			link = bpf_program__attach_perf_event(prog, FD(evsel, x, y));
 			if (IS_ERR(link)) {
 				pr_err("Failed to attach perf sample-filter program\n");
-				return PTR_ERR(link);
+				ret = PTR_ERR(link);
+				goto err;
 			}
 		}
 	}
+	free(entry);
 	evsel->bpf_skel = skel;
 	return 0;
+
+err:
+	free(entry);
+	sample_filter_bpf__destroy(skel);
+	return ret;
 }
 
 int perf_bpf_filter__destroy(struct evsel *evsel)
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 350efa121026..bb6a1b91f1df 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -14,6 +14,7 @@ enum perf_bpf_filter_op {
 	PBF_OP_AND,
 	PBF_OP_GROUP_BEGIN,
 	PBF_OP_GROUP_END,
+	PBF_OP_DONE,
 };
 
 enum perf_bpf_filter_term {
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index f59985101973..0d56e52b922c 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -9,10 +9,10 @@
 
 /* BPF map that will be filled by user space */
 struct filters {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
-	__type(value, struct perf_bpf_filter_entry);
-	__uint(max_entries, MAX_FILTERS);
+	__type(value, struct perf_bpf_filter_entry[MAX_FILTERS]);
+	__uint(max_entries, 1);
 } filters SEC(".maps");
 
 int dropped;
@@ -179,39 +179,39 @@ int perf_sample_filter(void *ctx)
 	__u64 sample_data;
 	int in_group = 0;
 	int group_result = 0;
-	int i;
+	int i, k;
 
 	kctx = bpf_cast_to_kern_ctx(ctx);
 
-	for (i = 0; i < MAX_FILTERS; i++) {
-		int key = i; /* needed for verifier :( */
+	k = 0;
+	entry = bpf_map_lookup_elem(&filters, &k);
+	if (entry == NULL)
+		goto drop;
 
-		entry = bpf_map_lookup_elem(&filters, &key);
-		if (entry == NULL)
-			break;
-		sample_data = perf_get_sample(kctx, entry);
+	for (i = 0; i < MAX_FILTERS; i++) {
+		sample_data = perf_get_sample(kctx, &entry[i]);
 
-		switch (entry->op) {
+		switch (entry[i].op) {
 		case PBF_OP_EQ:
-			CHECK_RESULT(sample_data, ==, entry->value)
+			CHECK_RESULT(sample_data, ==, entry[i].value)
 			break;
 		case PBF_OP_NEQ:
-			CHECK_RESULT(sample_data, !=, entry->value)
+			CHECK_RESULT(sample_data, !=, entry[i].value)
 			break;
 		case PBF_OP_GT:
-			CHECK_RESULT(sample_data, >, entry->value)
+			CHECK_RESULT(sample_data, >, entry[i].value)
 			break;
 		case PBF_OP_GE:
-			CHECK_RESULT(sample_data, >=, entry->value)
+			CHECK_RESULT(sample_data, >=, entry[i].value)
 			break;
 		case PBF_OP_LT:
-			CHECK_RESULT(sample_data, <, entry->value)
+			CHECK_RESULT(sample_data, <, entry[i].value)
 			break;
 		case PBF_OP_LE:
-			CHECK_RESULT(sample_data, <=, entry->value)
+			CHECK_RESULT(sample_data, <=, entry[i].value)
 			break;
 		case PBF_OP_AND:
-			CHECK_RESULT(sample_data, &, entry->value)
+			CHECK_RESULT(sample_data, &, entry[i].value)
 			break;
 		case PBF_OP_GROUP_BEGIN:
 			in_group = 1;
@@ -222,6 +222,9 @@ int perf_sample_filter(void *ctx)
 				goto drop;
 			in_group = 0;
 			break;
+		case PBF_OP_DONE:
+			/* no failures so far, accept it */
+			return 1;
 		}
 	}
 	/* generate sample data */
-- 
2.45.2.803.g4e1b14247a-goog


