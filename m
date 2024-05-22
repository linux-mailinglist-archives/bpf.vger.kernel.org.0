Return-Path: <bpf+bounces-30335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2358CC852
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2AD1F21E4E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C2146D5B;
	Wed, 22 May 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAudHEua"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920D146A84;
	Wed, 22 May 2024 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414979; cv=none; b=iORrN7MASLscuqjGcFbxNrvhgSKue7dezSDqD0ImFwYhYnhEzG43TJ+tAjCRVG5R9VcBPS96lhNCLGp/Tu1rNPVegT5/EnnelNX5os/HwjxXy9SVs8hjPtTFO5XJCXcJCiAueKCOOeMRqc8cX5yzU1UPv9toRV0A0x2tiDTDZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414979; c=relaxed/simple;
	bh=JtuRxcCvglFcfjf50Tet8nXRDQxwrVBlbIJSMK5vXig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/KaW255hX/kcovZRFlE6V1kweG2xWztZlT2kw86HLJL3aXGKB3uXhv3L5fUfAmTHiLGTkfXQ2+wRKBzkmTvbJe2RfnWPT2ndJQ4iFUDvJ2807CM0jG/uSaAorpB1Zi9TtAD1Rqx4kEF6kiRLCZbXQekIbB6Er3MQ0MiORjOhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAudHEua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACD2C4AF08;
	Wed, 22 May 2024 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716414978;
	bh=JtuRxcCvglFcfjf50Tet8nXRDQxwrVBlbIJSMK5vXig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iAudHEua+RG/yoSgYXxU/MothI/bnwiRRNq1aeOcQOGHR0mK52i4cCJIJWbSit3vs
	 yW0fEE6nOnnzYeLA0fqgHvEzMQEmdbCHLrN0/7h391fSk6pi8oJXramn3vBYU5Ih8/
	 W/7lS1pUaK5G59KTitSugn5wi9mVUHQItXdSfG6dDCCyvZ+t7PWVCcZo0wKd1kjzVs
	 QPQhHAknv8xMqoJdoPKWB4huW/LdEDg927g9lyTXaThMW+tFRRdwXswWFxfvlxhr7I
	 gKLHyL83KOB/MpYERZ/CCvYfUpTSvpMv0EjtpaVqR19k7VpYNhmUqR2oHw1fBYb/7T
	 Logz6RQFc2k3Q==
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
	Stephane Eranian <eranian@google.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 1/6] perf bpf-filter: Make filters map a single entry hashmap
Date: Wed, 22 May 2024 14:56:11 -0700
Message-ID: <20240522215616.762195-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240522215616.762195-1-namhyung@kernel.org>
References: <20240522215616.762195-1-namhyung@kernel.org>
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
 tools/perf/util/bpf_skel/sample-filter.h     |  3 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 37 +++++----
 3 files changed, 78 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index b51544996046..12e9c7dbb4dd 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -87,71 +87,102 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 
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
-			.flags = expr->sample_flags,
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
+		entry[i].flags = expr->sample_flags;
+		entry[i].value = expr->val;
 		i++;
 
 		if (expr->op == PBF_OP_GROUP_BEGIN) {
 			struct perf_bpf_filter_expr *group;
 
 			list_for_each_entry(group, &expr->groups, list) {
-				struct perf_bpf_filter_entry group_entry = {
-					.op = group->op,
-					.part = group->part,
-					.flags = group->sample_flags,
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
+				entry[i].flags = group->sample_flags;
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
index 2e96e1ab084a..cf18f570eef4 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -14,6 +14,7 @@ enum perf_bpf_filter_op {
 	PBF_OP_AND,
 	PBF_OP_GROUP_BEGIN,
 	PBF_OP_GROUP_END,
+	PBF_OP_DONE,
 };
 
 /* BPF map entry for filtering */
@@ -24,4 +25,4 @@ struct perf_bpf_filter_entry {
 	__u64 value;
 };
 
-#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
\ No newline at end of file
+#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index fb94f5280626..5f17cd6458b7 100644
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
@@ -144,35 +144,35 @@ int perf_sample_filter(void *ctx)
 
 	kctx = bpf_cast_to_kern_ctx(ctx);
 
-	for (i = 0; i < MAX_FILTERS; i++) {
-		int key = i; /* needed for verifier :( */
+	i = 0;
+	entry = bpf_map_lookup_elem(&filters, &i);
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
@@ -183,6 +183,9 @@ int perf_sample_filter(void *ctx)
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
2.45.1.288.g0e0cd299f1-goog


