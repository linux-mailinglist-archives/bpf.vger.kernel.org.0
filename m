Return-Path: <bpf+bounces-50750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9EA2BD74
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 09:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0993AAB4D
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 08:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A03233D86;
	Fri,  7 Feb 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZBaek1B"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45037233D64
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915502; cv=none; b=IxOJGTN/oLwt6rcB87S6vSMFGkx1jRdYsi/KPfVTE51MLyKopiGYAbIfUduMyq6VJ4Zm7IYD2oWcbg7tRb8ceY+C1yXwF3LHqOrcqJK6W2BG4TvgjBXsKOepo7kVOgMKUNMjaqP/PWLMeuvDJySgM6VMufVcYDRnwaSaur066sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915502; c=relaxed/simple;
	bh=8Dg1edHtzpGjPoUJj1U8Rm0XiMWeIXtGAvfeQc0xIyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PExIrnKBi7NvffV1MSQaxPi4wJhM64015f2SdkMwa7iJAQS+tohonsYO3zb2P7DvOd93cUb5DC/0k6u6CpKKq7Np7mem9BMmqCJ8V7lMGOSUmlt/j4cnUdvoE6vTwuWlBwkyACykG23EVkiLwpCeTGxxwPAFtJXwpLwL8QcQrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZBaek1B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738915499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CY4Wvi20EGqS3EzyUzAA1xdoQD2kiUj7fdKbqPTL8ds=;
	b=XZBaek1BeeRDwILzLJUQaY34nRNWl6zZviZwox9wbtXJUPyEeAVewBLHHNbmQXR8cTGQzc
	BfSxEMykpNl1nuJHd6gj74Dt1mILMx7sCbtGQVhXmFpVZq/hti9dvffJpqvzuHWb0mwOSH
	sACY5g9TnHSro8Ni+BkIsJBAN1OZIk0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-R6Q2vGL-PlmbOlAOfY5kyw-1; Fri,
 07 Feb 2025 03:04:57 -0500
X-MC-Unique: R6Q2vGL-PlmbOlAOfY5kyw-1
X-Mimecast-MFC-AGG-ID: R6Q2vGL-PlmbOlAOfY5kyw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A55A1801A10;
	Fri,  7 Feb 2025 08:04:56 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1BA118004A7;
	Fri,  7 Feb 2025 08:04:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 1/2] perf ftrace latency: variable histogram buckets
Date: Fri,  7 Feb 2025 09:04:44 +0100
Message-ID: <20250207080446.77630-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The max-latency value can make the histogram smaller, but not larger, we
have a maximum of 22 buckets and specifying a max-latency that would
require more buckets has no effect.

Dynamically allocate the buckets and compute the bucket number from the
max latency as (max-min) / range + 2

If the maximum is not specified, we still set the bucket number to 22
and compute the maximum accordingly.

Fail if the maximum is smaller than min+range, this way we make sure we
always have 3 buckets: those below min, those above max and one in the
middle.

Since max-latency is not available in log2 mode, always use 22 buckets.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/perf/builtin-ftrace.c                 | 57 +++++++++++++++------
 tools/perf/util/bpf_ftrace.c                |  6 ++-
 tools/perf/util/bpf_skel/func_latency.bpf.c |  7 +--
 tools/perf/util/ftrace.h                    |  1 +
 4 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index cfd770ec72867..4f76094ea06d4 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -733,6 +733,7 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 {
 	int min_latency = ftrace->min_latency;
 	int max_latency = ftrace->max_latency;
+	unsigned int bucket_num = ftrace->bucket_num;
 	char *p, *q;
 	char *unit;
 	double num;
@@ -797,10 +798,10 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 			if (num > 0) // 1st entry: [ 1 unit .. bucket_range units ]
 				i = num / ftrace->bucket_range + 1;
 			if (num >= max_latency - min_latency)
-				i = NUM_BUCKET -1;
+				i = bucket_num -1;
 		}
-		if (i >= NUM_BUCKET)
-			i = NUM_BUCKET - 1;
+		if ((unsigned)i >= bucket_num)
+			i = bucket_num - 1;
 
 		num += min_latency;
 do_inc:
@@ -820,13 +821,14 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 {
 	int min_latency = ftrace->min_latency;
 	bool use_nsec = ftrace->use_nsec;
-	int i;
+	unsigned int bucket_num = ftrace->bucket_num;
+	unsigned int i;
 	int total = 0;
 	int bar_total = 46;  /* to fit in 80 column */
 	char bar[] = "###############################################";
 	int bar_len;
 
-	for (i = 0; i < NUM_BUCKET; i++)
+	for (i = 0; i < bucket_num; i++)
 		total += buckets[i];
 
 	if (total == 0) {
@@ -843,7 +845,7 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	       0, min_latency ?: 1, use_nsec ? "ns" : "us",
 	       buckets[0], bar_len, bar, bar_total - bar_len, "");
 
-	for (i = 1; i < NUM_BUCKET - 1; i++) {
+	for (i = 1; i < bucket_num - 1; i++) {
 		unsigned int start, stop;
 		const char *unit = use_nsec ? "ns" : "us";
 
@@ -881,11 +883,11 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 		       bar_total - bar_len, "");
 	}
 
-	bar_len = buckets[NUM_BUCKET - 1] * bar_total / total;
+	bar_len = buckets[bucket_num - 1] * bar_total / total;
 	if (!ftrace->bucket_range) {
 		printf("  %4d - %-4s %s", 1, "...", use_nsec ? "ms" : "s ");
 	} else {
-		unsigned int upper_outlier = (NUM_BUCKET - 2) * ftrace->bucket_range + min_latency;
+		unsigned int upper_outlier = (bucket_num - 2) * ftrace->bucket_range + min_latency;
 		if (upper_outlier > ftrace->max_latency)
 			upper_outlier = ftrace->max_latency;
 
@@ -897,7 +899,7 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 			printf("  %4d - %4s %s", upper_outlier, "...", use_nsec ? "ns" : "us");
 		}
 	}
-	printf(" | %10d | %.*s%*s |\n", buckets[NUM_BUCKET - 1],
+	printf(" | %10d | %.*s%*s |\n", buckets[bucket_num - 1],
 	       bar_len, bar, bar_total - bar_len, "");
 
 	printf("\n# statistics  (in %s)\n", ftrace->use_nsec ? "nsec" : "usec");
@@ -997,7 +999,7 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 	struct pollfd pollfd = {
 		.events = POLLIN,
 	};
-	int buckets[NUM_BUCKET] = { };
+	int *buckets;
 
 	trace_fd = prepare_func_latency(ftrace);
 	if (trace_fd < 0)
@@ -1011,6 +1013,12 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 
 	evlist__start_workload(ftrace->evlist);
 
+	buckets = calloc(ftrace->bucket_num, sizeof(*buckets));
+	if (buckets == NULL) {
+		pr_err("failed to allocate memory for the buckets\n");
+		goto out;
+	}
+
 	line[0] = '\0';
 	while (!done) {
 		if (poll(&pollfd, 1, -1) < 0)
@@ -1030,7 +1038,7 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 	if (workload_exec_errno) {
 		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
 		pr_err("workload failed: %s\n", emsg);
-		goto out;
+		goto out_free_buckets;
 	}
 
 	/* read remaining buffer contents */
@@ -1045,6 +1053,8 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 
 	display_histogram(ftrace, buckets);
 
+out_free_buckets:
+	free(buckets);
 out:
 	close(trace_fd);
 	cleanup_func_latency(ftrace);
@@ -1634,7 +1644,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_UINTEGER(0, "min-latency", &ftrace.min_latency,
 		    "Minimum latency (1st bucket). Works only with --bucket-range."),
 	OPT_UINTEGER(0, "max-latency", &ftrace.max_latency,
-		    "Maximum latency (last bucket). Works only with --bucket-range and total buckets less than 22."),
+		    "Maximum latency (last bucket). Works only with --bucket-range."),
 	OPT_PARENT(common_options),
 	};
 	const struct option profile_options[] = {
@@ -1751,10 +1761,25 @@ int cmd_ftrace(int argc, const char **argv)
 			ret = -EINVAL;
 			goto out_delete_filters;
 		}
-		if (ftrace.bucket_range && !ftrace.max_latency) {
-			/* default max latency should depend on bucket range and num_buckets */
-			ftrace.max_latency = (NUM_BUCKET - 2) * ftrace.bucket_range +
-						ftrace.min_latency;
+		if (ftrace.bucket_range && ftrace.max_latency &&
+		    ftrace.max_latency < ftrace.min_latency + ftrace.bucket_range) {
+			/* we need at least 1 bucket excluding min and max buckets */
+			pr_err("--max-latency must be larger than min-latency + bucket-range\n");
+			parse_options_usage(ftrace_usage, options,
+					    "max-latency", /*short_opt=*/false);
+			ret = -EINVAL;
+			goto out_delete_filters;
+		}
+		/* set default unless max_latency is set and valid */
+		ftrace.bucket_num = NUM_BUCKET;
+		if (ftrace.bucket_range) {
+			if (ftrace.max_latency)
+				ftrace.bucket_num = (ftrace.max_latency - ftrace.min_latency) /
+							ftrace.bucket_range + 2;
+			else
+				/* default max latency should depend on bucket range and num_buckets */
+				ftrace.max_latency = (NUM_BUCKET - 2) * ftrace.bucket_range +
+							ftrace.min_latency;
 		}
 		cmd_func = __cmd_latency;
 		break;
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 25fc280e414ac..51f407a782d6c 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -39,6 +39,10 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 
 	skel->rodata->bucket_range = ftrace->bucket_range;
 	skel->rodata->min_latency = ftrace->min_latency;
+	skel->rodata->bucket_num = ftrace->bucket_num;
+	if (ftrace->bucket_range && ftrace->bucket_num) {
+		bpf_map__set_max_entries(skel->maps.latency, ftrace->bucket_num);
+	}
 
 	/* don't need to set cpu filter for system-wide mode */
 	if (ftrace->target.cpu_list) {
@@ -138,7 +142,7 @@ int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
 	if (hist == NULL)
 		return -ENOMEM;
 
-	for (idx = 0; idx < NUM_BUCKET; idx++) {
+	for (idx = 0; idx < skel->rodata->bucket_num; idx++) {
 		err = bpf_map_lookup_elem(fd, &idx, hist);
 		if (err) {
 			buckets[idx] = 0;
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index fb144811b34fc..09e70d40a0f4d 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -50,6 +50,7 @@ const volatile int use_nsec = 0;
 const volatile unsigned int bucket_range;
 const volatile unsigned int min_latency;
 const volatile unsigned int max_latency;
+const volatile unsigned int bucket_num = NUM_BUCKET;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
@@ -124,16 +125,16 @@ int BPF_PROG(func_end)
 			if (delta > 0) { // 1st entry: [ 1 unit .. bucket_range units )
 				// clang 12 doesn't like s64 / u32 division
 				key = (__u64)delta / bucket_range + 1;
-				if (key >= NUM_BUCKET ||
+				if (key >= bucket_num ||
 					delta >= max_latency - min_latency)
-					key = NUM_BUCKET - 1;
+					key = bucket_num - 1;
 			}
 
 			delta += min_latency;
 			goto do_lookup;
 		}
 		// calculate index using delta
-		for (key = 0; key < (NUM_BUCKET - 1); key++) {
+		for (key = 0; key < (bucket_num - 1); key++) {
 			if (delta < (cmp_base << key))
 				break;
 		}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 5dee2caba0fe4..395f97b203ead 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -24,6 +24,7 @@ struct perf_ftrace {
 	unsigned int		bucket_range;
 	unsigned int		min_latency;
 	unsigned int		max_latency;
+	unsigned int		bucket_num;
 	int			graph_depth;
 	int			func_stack_trace;
 	int			func_irq_info;

base-commit: 92514ef226f511f2ca1fb1b8752966097518edc0
-- 
2.48.1


