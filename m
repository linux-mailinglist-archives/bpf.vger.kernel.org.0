Return-Path: <bpf+bounces-65521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3781B24D7F
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 17:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904F63B6D92
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC2238D57;
	Wed, 13 Aug 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEQXGTFa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739923E34C;
	Wed, 13 Aug 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098980; cv=none; b=RgHthG5BgFaQjQgUN1eAefIl2QuEGRj7nhf+t728W/7XQfQ3MrzdjvUO168LGus9nQX8RrDPxxY+GRysuvaqw3jqSjnQpg+m09hDqt7Y0HPYGnuhglnrNweUr2qbLjTWSUY9IIZMK1B7dgphbeMWCukRi9Dv3q5Dcmn81djtlcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098980; c=relaxed/simple;
	bh=vVOCJgaHKyUCzgdtn29YJraw+cF8Ru8lcOrX2Ex+Zgs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEuHrmX4rtCwKfTZj6k/fK5EDe2a1G9mtvP8YApfLluoDHJQVl95bmk79B3LXGoNyb6UZLSO4jM3ckkybMsCKhhppEEnj02X+vlRL5PixAABu69GQxHlpcqB3DRaAC+b2Vi45ARjvkGOCGLTMB4kxZEJYtaadU6QqipYC9MxWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEQXGTFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D86C4CEEB;
	Wed, 13 Aug 2025 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755098979;
	bh=vVOCJgaHKyUCzgdtn29YJraw+cF8Ru8lcOrX2Ex+Zgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JEQXGTFa2FvdpbYW2QuoWYMksA4fkGWQc/m8FiodcYA4RCw9pQCTxxf/C17bWVoIY
	 jZByEPYcPtdzHINsJloatWhUY1tS5yoarTIOliGmAHFNkYctkxC8Rq0TSUWrFauhEf
	 /fXDz0HhiiPhmiEtDqDfB78E0nkLLzsBwU8+wPcu0A7gRGvEAokUTVca8/lnD9V1Oh
	 7MN4M94qRYGpHC9HzfnRS7IsiJvSVtfB7TVlEzBQsc22Yx//bj1K4o2r7ggh4EXuNY
	 pu7+GLEoZ6Bwx6V47ueevGCHkyKMR8q3aFgr2HQL9K6zjq5NntWI+SOrVpi9chsxAA
	 szC1nJ7qgnCUg==
Subject: [PATCH RFC bpf-next] selftests/bpf: Extend bench for LPM trie with
 noop and baseline
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: matt@readmodwrite.com, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, mfleming@cloudflare.com,
 Daniel Borkmann <borkmann@iogearbox.net>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com
Date: Wed, 13 Aug 2025 17:29:35 +0200
Message-ID: <175509897596.2755384.18413775753563966331.stgit@firesoul>
In-Reply-To: <20250722150152.1158205-1-matt@readmodwrite.com>
References: <20250722150152.1158205-1-matt@readmodwrite.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This patch is extending[0] with some adjustments[1].
 [0] https://lore.kernel.org/all/20250722150152.1158205-1-matt@readmodwrite.com/
 [1] https://github.com/xdp-project/xdp-project/blob/main/areas/bench/patches/bench-lpm-trie-V3-adjusted.patch

The 'noop' bench measures the overhead of the harness.
Meaning the bpf_prog_test_run that calls bpf_loop with 10000
(NR_LOOPS) iterations in the lpm_producer loop.

CPU: AMD EPYC 9684X
sudo ./bench lpm-trie-noop  --nr_entries=1 --producers=1 --affinity
Setting up benchmark 'lpm-trie-noop'...
Benchmark 'lpm-trie-noop' started.
Iter   0 ( 42.501us): hits   74.567M/s ( 74.567M/prod)
Iter   1 ( -5.155us): hits   74.630M/s ( 74.630M/prod)
Iter   2 (  0.123us): hits   74.620M/s ( 74.620M/prod)
Iter   3 ( -7.127us): hits   74.611M/s ( 74.611M/prod)
Iter   4 (  7.334us): hits   74.609M/s ( 74.609M/prod)
Iter   5 (  0.163us): hits   74.620M/s ( 74.620M/prod)
Iter   6 (  0.213us): hits   74.610M/s ( 74.610M/prod)
Summary: throughput   74.617 ± 0.008 M ops/s ( 74.617M ops/prod), latency   13.402 ns/op

The baseline measures overhead of getting a random number
and modulo, which can be used as a baseline comparsion
against lpm-trie-lookup and lpm-trie-update.

sudo ./bench lpm-trie-baseline  --nr_entries=1 --producers=1 --affinity
Setting up benchmark 'lpm-trie-baseline'...
Benchmark 'lpm-trie-baseline' started.
Iter   0 ( 44.996us): hits   36.308M/s ( 36.308M/prod)
Iter   1 ( -1.535us): hits   36.330M/s ( 36.330M/prod)
Iter   2 ( -3.919us): hits   36.310M/s ( 36.310M/prod)
Iter   3 ( -1.004us): hits   36.330M/s ( 36.330M/prod)
Iter   4 ( -1.476us): hits   36.320M/s ( 36.320M/prod)
Iter   5 (  0.468us): hits   36.330M/s ( 36.330M/prod)
Iter   6 ( -0.304us): hits   36.330M/s ( 36.330M/prod)
Summary: throughput   36.325 ± 0.008 M ops/s ( 36.325M ops/prod), latency   27.529 ns/op

Thus, the overhead of bpf_get_prandom_u32() is 14.1 nanosec.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 tools/testing/selftests/bpf/bench.c                |    4 ++
 .../selftests/bpf/benchs/bench_lpm_trie_map.c      |   40 +++++++++++++++++++-
 tools/testing/selftests/bpf/progs/lpm_trie_bench.c |   31 ++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index fd15f60fd5a8..8a41aec89479 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -560,6 +560,8 @@ extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
 extern const struct bench bench_sockmap;
+extern const struct bench bench_lpm_trie_noop;
+extern const struct bench bench_lpm_trie_baseline;
 extern const struct bench bench_lpm_trie_lookup;
 extern const struct bench bench_lpm_trie_update;
 extern const struct bench bench_lpm_trie_delete;
@@ -631,6 +633,8 @@ static const struct bench *benchs[] = {
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
 	&bench_sockmap,
+	&bench_lpm_trie_noop,
+	&bench_lpm_trie_baseline,
 	&bench_lpm_trie_lookup,
 	&bench_lpm_trie_update,
 	&bench_lpm_trie_delete,
diff --git a/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c b/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
index 32a46c2402ea..4e0f12e359ba 100644
--- a/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
@@ -87,7 +87,7 @@ static void __lpm_validate(void)
 	};
 }
 
-enum { OP_LOOKUP = 1, OP_UPDATE, OP_DELETE, OP_FREE };
+enum { OP_NOOP=0, OP_BASELINE, OP_LOOKUP, OP_UPDATE, OP_DELETE, OP_FREE };
 
 static void lpm_delete_validate(void)
 {
@@ -175,6 +175,18 @@ static void lpm_setup(void)
 	fill_map(fd);
 }
 
+static void lpm_noop_setup(void)
+{
+	__lpm_setup();
+	ctx.bench->bss->op = OP_NOOP;
+}
+
+static void lpm_baseline_setup(void)
+{
+	__lpm_setup();
+	ctx.bench->bss->op = OP_BASELINE;
+}
+
 static void lpm_lookup_setup(void)
 {
 	lpm_setup();
@@ -208,7 +220,7 @@ static void lpm_measure(struct bench_res *res)
 	res->duration_ns = atomic_swap(&ctx.bench->bss->duration_ns, 0);
 }
 
-/* For LOOKUP, UPDATE, and DELETE */
+/* For NOOP, BASELINE, LOOKUP, UPDATE, and DELETE */
 static void *lpm_producer(void *unused __always_unused)
 {
 	int err;
@@ -310,6 +322,30 @@ static void free_ops_report_final(struct bench_res res[], int res_cnt)
 	       latency / lat_divisor / env.producer_cnt, unit);
 }
 
+/* noop bench measures harness-overhead */
+const struct bench bench_lpm_trie_noop = {
+	.name = "lpm-trie-noop",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = __lpm_validate,
+	.setup = lpm_noop_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+/* baseline overhead for lookup and update */
+const struct bench bench_lpm_trie_baseline = {
+	.name = "lpm-trie-baseline",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = __lpm_validate,
+	.setup = lpm_baseline_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
 const struct bench bench_lpm_trie_lookup = {
 	.name = "lpm-trie-lookup",
 	.argp = &bench_lpm_trie_map_argp,
diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
index 522e1cbef490..e4a5cecd6560 100644
--- a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
+++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
+#include "bpf_atomic.h"
 
 #define BPF_OBJ_NAME_LEN 16U
 #define MAX_ENTRIES 100000000
@@ -84,12 +85,30 @@ int BPF_PROG(trie_free_exit, struct work_struct *work)
 	return 0;
 }
 
-static void gen_random_key(struct trie_key *key)
+static __always_inline void gen_random_key(struct trie_key *key)
 {
 	key->prefixlen = prefixlen;
 	key->data = bpf_get_prandom_u32() % nr_entries;
 }
 
+static int noop(__u32 index, __u32 *unused)
+{
+	return 0;
+}
+
+static int baseline(__u32 index, __u32 *unused)
+{
+	struct trie_key key;
+	__s64 blackbox;
+
+	gen_random_key(&key);
+	/* Avoid compiler optimizing out the modulo */
+	barrier_var(blackbox);
+	blackbox = READ_ONCE(key.data);
+
+	return 0;
+}
+
 static int lookup(__u32 index, __u32 *unused)
 {
 	struct trie_key key;
@@ -148,13 +167,19 @@ int BPF_PROG(run_bench)
 	start = bpf_ktime_get_ns();
 
 	switch (op) {
+	case 0:
+		loops = bpf_loop(NR_LOOPS, noop, NULL, 0);
+		break;
 	case 1:
-		loops = bpf_loop(NR_LOOPS, lookup, NULL, 0);
+		loops = bpf_loop(NR_LOOPS, baseline, NULL, 0);
 		break;
 	case 2:
-		loops = bpf_loop(NR_LOOPS, update, NULL, 0);
+		loops = bpf_loop(NR_LOOPS, lookup, NULL, 0);
 		break;
 	case 3:
+		loops = bpf_loop(NR_LOOPS, update, NULL, 0);
+		break;
+	case 4:
 		loops = bpf_loop(NR_LOOPS, delete, &need_refill, 0);
 		break;
 	default:



