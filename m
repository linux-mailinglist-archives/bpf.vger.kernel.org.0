Return-Path: <bpf+bounces-33831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A250926B95
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE32F282F29
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47129194C7B;
	Wed,  3 Jul 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6VT55xj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F4194AD7;
	Wed,  3 Jul 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045839; cv=none; b=PMX+PqpP1Qyq/JJYXz8eD13zm9yk78sHCq7NBbtm3PuGeFrJepwED3RdQsHSdpBw+SdTQRKii8l+LgduTv1GTC9tL0M9VJnaAGPY1ccQwIQrSV26CJdH8VQmlHTm0vvF3yDcDS8lyoXJBpew7gnD7EGvYilJ7LD/eKBeKC9tJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045839; c=relaxed/simple;
	bh=acxnBH33pEM3geRn+RlT87+ixutZtG8P8+um1GieHao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMyNyCid6quNkNWOLP2pH4UIDTvzFHV82tbvKg4QLaZBHPgd7b2u/+A/Eq8+fgkVyUP6mtbW5MD+HnXQnzm4W0yHwQB3BWCUW6+hHSDwK4z9hRvPAdecD78PcW8p7K7g44QMgYzLOOHXaganFWWHx6+Og0+2Pjz9ApxmmYGGyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6VT55xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332A3C4AF14;
	Wed,  3 Jul 2024 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045839;
	bh=acxnBH33pEM3geRn+RlT87+ixutZtG8P8+um1GieHao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6VT55xj8o20WsEyg0kSX/xJCELTFVVxzPJ92MaEmr2HCjGVkx8+sktB+HChuA9qs
	 l8ZxoSo+sLRgGZAcS2bNOOR/LLOYD+cAlEnnuuugul0CdkM6Zcg9N162ScZdkMKMRe
	 CjK9SWB1dSDPd+ppCRbt5C5gYKCjctVfyyRjZC5UZVdRL9rZJj8PqCKneqtACxqqWf
	 5A7cOkoIJcqVagqxPrtb+aO2kHSogwhx9ErNmzlhuQ9f1PF5xBINq7Xy1mAPodtF5c
	 CQJz7rQq4krgOshqN+a8ZTT1z9SD4FmnGpKfc/tWMLCBo59HIjSBMZf6jWhDwFNSiY
	 rpIiVuYorhvKw==
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
Subject: [PATCH v3 5/8] perf bpf-filter: Support separate lost counts for each filter
Date: Wed,  3 Jul 2024 15:30:32 -0700
Message-ID: <20240703223035.2024586-6-namhyung@kernel.org>
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

As the BPF filter is shared between other processes, it should have its
own counter for each invocation.  Add a new array map (lost_count) to
save the count using the same index as the filter.  It should clear the
count before running the filter.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c                 | 37 ++++++++++++++++++--
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 15 ++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 37ed6c48debf..c5eb0b7eec19 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -260,11 +260,23 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	}
 
 	if (needs_pid_hash && geteuid() != 0) {
+		int zero = 0;
+
 		/* The filters map is shared among other processes */
 		ret = update_pid_hash(evsel, entry);
 		if (ret < 0)
 			goto err;
 
+		fd = get_pinned_fd("dropped");
+		if (fd < 0) {
+			ret = fd;
+			goto err;
+		}
+
+		/* Reset the lost count */
+		bpf_map_update_elem(fd, &pinned_filter_idx, &zero, BPF_ANY);
+		close(fd);
+
 		fd = get_pinned_fd("perf_sample_filter");
 		if (fd < 0) {
 			ret = fd;
@@ -347,9 +359,25 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
 
 u64 perf_bpf_filter__lost_count(struct evsel *evsel)
 {
-	struct sample_filter_bpf *skel = evsel->bpf_skel;
+	int count = 0;
+
+	if (list_empty(&evsel->bpf_filters))
+		return 0;
+
+	if (pinned_filter_idx >= 0) {
+		int fd = get_pinned_fd("dropped");
+
+		bpf_map_lookup_elem(fd, &pinned_filter_idx, &count);
+		close(fd);
+	} else if (evsel->bpf_skel) {
+		struct sample_filter_bpf *skel = evsel->bpf_skel;
+		int fd = bpf_map__fd(skel->maps.dropped);
+		int idx = 0;
 
-	return skel ? skel->bss->dropped : 0;
+		bpf_map_lookup_elem(fd, &idx, &count);
+	}
+
+	return count;
 }
 
 struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term term,
@@ -402,6 +430,7 @@ int perf_bpf_filter__pin(void)
 	/* pinned program will use pid-hash */
 	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
 	bpf_map__set_max_entries(skel->maps.pid_hash, MAX_PIDS);
+	bpf_map__set_max_entries(skel->maps.dropped, MAX_FILTERS);
 	skel->rodata->use_pid_hash = 1;
 
 	if (sample_filter_bpf__load(skel) < 0) {
@@ -459,6 +488,10 @@ int perf_bpf_filter__pin(void)
 		pr_debug("chmod for pid_hash failed\n");
 		ret = -errno;
 	}
+	if (fchmodat(dir_fd, "dropped", 0666, 0) < 0) {
+		pr_debug("chmod for dropped failed\n");
+		ret = -errno;
+	}
 
 err_close:
 	close(dir_fd);
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index c5273f06fa45..4c75354b84fd 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -23,7 +23,14 @@ struct pid_hash {
 	__uint(max_entries, 1);
 } pid_hash SEC(".maps");
 
-int dropped;
+/* tgid to filter index */
+struct lost_count {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+} dropped SEC(".maps");
+
 volatile const int use_pid_hash;
 
 void *bpf_cast_to_kern_ctx(void *) __ksym;
@@ -189,6 +196,7 @@ int perf_sample_filter(void *ctx)
 	int in_group = 0;
 	int group_result = 0;
 	int i, k;
+	int *losts;
 
 	kctx = bpf_cast_to_kern_ctx(ctx);
 
@@ -252,7 +260,10 @@ int perf_sample_filter(void *ctx)
 	return 1;
 
 drop:
-	__sync_fetch_and_add(&dropped, 1);
+	losts = bpf_map_lookup_elem(&dropped, &k);
+	if (losts != NULL)
+		__sync_fetch_and_add(losts, 1);
+
 	return 0;
 }
 
-- 
2.45.2.803.g4e1b14247a-goog


