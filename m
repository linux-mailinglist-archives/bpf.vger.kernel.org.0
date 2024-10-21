Return-Path: <bpf+bounces-42615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2979A6839
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFD9282D69
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA61FAC44;
	Mon, 21 Oct 2024 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1AYD7oA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164831FAC3A;
	Mon, 21 Oct 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513330; cv=none; b=TNEfMSUeHXE07YFMjJ/pBOw78/iqXfS97isKb1xprpO43JDlV8HyeOmdVDEqg5NJ+ahT1/Ig1eBl/PwR3d4zSn5gsfi4ZyO89rt8suwJbDKfH+TTMHLUSuZV5yuCgND4sYz03dkNxViGxVTmKsbD1pNYeIow3WHrijIML+wAk2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513330; c=relaxed/simple;
	bh=Hoeel4AJqQq2OzQsQRr98YOviBg6J0xi4VZmo07O8iI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/38qtquV04nKMQ36SflvWh9Cg3IqT//g72ltcfyEz5+pr63JbVzmw8EeZoPaAWYwxQgMCkxU1TnGQNnPrPKfL47YUU+8glMlhZmZ6sY79iQ1ArAJW5KC3Rk4j01fRmByQJWos/9ZqiJ+17emc487rVFPaC5lAOoO7tbDQgjOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1AYD7oA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E900C4CEE4;
	Mon, 21 Oct 2024 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513329;
	bh=Hoeel4AJqQq2OzQsQRr98YOviBg6J0xi4VZmo07O8iI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D1AYD7oAoLtZtsFdvDU5FzWG4lsH1F/PM+Cdwy1cUfzVb3WYM4HMfuct2zqZy07z6
	 eksC6bLBWZaNPzqH7Bj+smPXujXXYwNn5GcPJyXqQfWhO3qOwnXVGJ1F1mVdv7bnNK
	 lm03s8xuAuNaCx1t3HQjDMb2g+kwuzV1owdQ3c67TjrKEhgiQcqofWaM9+sdrG86uJ
	 nTBsN9NKPAXFY0CxKMZARZijQLSvb+nGvVyChjPgtFiX+KdZnZfgijuyhlGYpwNbcY
	 r4gqdSt+53SPeZtaN582mtK8arN455hJ+/aywirgG4X6sqlj9URJbha0fBv4ANYc/e
	 VYkr8ABbyYz6Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Helge Deller <deller@gmx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 4/5] selftests/bpf: Add benchmark for bpf_csum_diff() helper
Date: Mon, 21 Oct 2024 12:21:11 +0000
Message-Id: <20241021122112.101513-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241021122112.101513-1-puranjay@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a microbenchmark for bpf_csum_diff() helper. This benchmark works by
filling a 4KB buffer with random data and calculating the internet
checksum on different parts of this buffer using bpf_csum_diff().

Example run using ./benchs/run_bench_csum_diff.sh on x86_64:

[bpf]$ ./benchs/run_bench_csum_diff.sh
4                    2.296 ± 0.066M/s (drops 0.000 ± 0.000M/s)
8                    2.320 ± 0.003M/s (drops 0.000 ± 0.000M/s)
16                   2.315 ± 0.001M/s (drops 0.000 ± 0.000M/s)
20                   2.318 ± 0.001M/s (drops 0.000 ± 0.000M/s)
32                   2.308 ± 0.003M/s (drops 0.000 ± 0.000M/s)
40                   2.300 ± 0.029M/s (drops 0.000 ± 0.000M/s)
64                   2.286 ± 0.001M/s (drops 0.000 ± 0.000M/s)
128                  2.250 ± 0.001M/s (drops 0.000 ± 0.000M/s)
256                  2.173 ± 0.001M/s (drops 0.000 ± 0.000M/s)
512                  2.023 ± 0.055M/s (drops 0.000 ± 0.000M/s)

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_csum_diff.c    | 164 ++++++++++++++++++
 .../bpf/benchs/run_bench_csum_diff.sh         |  10 ++
 .../selftests/bpf/progs/csum_diff_bench.c     |  25 +++
 5 files changed, 205 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_csum_diff.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_csum_diff.sh
 create mode 100644 tools/testing/selftests/bpf/progs/csum_diff_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 28a76baa854d3..a0d86dd453e16 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -809,6 +809,7 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
 $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
+$(OUTPUT)/bench_csum_diff.o: $(OUTPUT)/csum_diff_bench.skel.h
 $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_update_bench.skel.h
 $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
@@ -829,6 +830,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bloom_filter_map.o \
 		 $(OUTPUT)/bench_bpf_loop.o \
 		 $(OUTPUT)/bench_strncmp.o \
+		 $(OUTPUT)/bench_csum_diff.o \
 		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
 		 $(OUTPUT)/bench_local_storage.o \
 		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b3..29bd6f4498ebc 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -278,6 +278,7 @@ extern struct argp bench_bpf_loop_argp;
 extern struct argp bench_local_storage_argp;
 extern struct argp bench_local_storage_rcu_tasks_trace_argp;
 extern struct argp bench_strncmp_argp;
+extern struct argp bench_csum_diff_argp;
 extern struct argp bench_hashmap_lookup_argp;
 extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
@@ -290,6 +291,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_bpf_loop_argp, 0, "bpf_loop helper benchmark", 0 },
 	{ &bench_local_storage_argp, 0, "local_storage benchmark", 0 },
 	{ &bench_strncmp_argp, 0, "bpf_strncmp helper benchmark", 0 },
+	{ &bench_csum_diff_argp, 0, "bpf_csum_diff helper benchmark", 0 },
 	{ &bench_local_storage_rcu_tasks_trace_argp, 0,
 		"local_storage RCU Tasks Trace slowdown benchmark", 0 },
 	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
@@ -539,6 +541,7 @@ extern const struct bench bench_hashmap_with_bloom;
 extern const struct bench bench_bpf_loop;
 extern const struct bench bench_strncmp_no_helper;
 extern const struct bench bench_strncmp_helper;
+extern const struct bench bench_csum_diff;
 extern const struct bench bench_bpf_hashmap_full_update;
 extern const struct bench bench_local_storage_cache_seq_get;
 extern const struct bench bench_local_storage_cache_interleaved_get;
@@ -599,6 +602,7 @@ static const struct bench *benchs[] = {
 	&bench_bpf_loop,
 	&bench_strncmp_no_helper,
 	&bench_strncmp_helper,
+	&bench_csum_diff,
 	&bench_bpf_hashmap_full_update,
 	&bench_local_storage_cache_seq_get,
 	&bench_local_storage_cache_interleaved_get,
diff --git a/tools/testing/selftests/bpf/benchs/bench_csum_diff.c b/tools/testing/selftests/bpf/benchs/bench_csum_diff.c
new file mode 100644
index 0000000000000..2c30c8b54d9bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_csum_diff.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates */
+#include <argp.h>
+#include "bench.h"
+#include "csum_diff_bench.skel.h"
+
+static struct csum_diff_ctx {
+	struct csum_diff_bench *skel;
+	int pfd;
+} ctx;
+
+static struct csum_diff_args {
+	u32 buff_len;
+} args = {
+	.buff_len = 32,
+};
+
+enum {
+	ARG_BUFF_LEN = 5000,
+};
+
+static const struct argp_option opts[] = {
+	{ "buff-len", ARG_BUFF_LEN, "BUFF_LEN", 0,
+	  "Set the length of the buffer" },
+	{},
+};
+
+static error_t csum_diff_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_BUFF_LEN:
+		args.buff_len = strtoul(arg, NULL, 10);
+		if (!args.buff_len ||
+		    args.buff_len >= sizeof(ctx.skel->rodata->buff)) {
+			fprintf(stderr, "Invalid buff len (limit %zu)\n",
+				sizeof(ctx.skel->rodata->buff));
+			argp_usage(state);
+		}
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_csum_diff_argp = {
+	.options = opts,
+	.parser = csum_diff_parse_arg,
+};
+
+static void csum_diff_validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "csum_diff benchmark doesn't support consumer!\n");
+		exit(1);
+	}
+}
+
+static void csum_diff_setup(void)
+{
+	int err;
+	char *buff;
+	size_t i, sz;
+
+	sz = sizeof(ctx.skel->rodata->buff);
+
+	setup_libbpf();
+
+	ctx.skel = csum_diff_bench__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	srandom(time(NULL));
+	buff = ctx.skel->rodata->buff;
+
+	/*
+	 * Set first 8 bytes of buffer to 0xdeadbeefdeadbeef, this is later used to verify the
+	 * correctness of the helper by comparing the checksum result for 0xdeadbeefdeadbeef that
+	 * should be 0x3b3b
+	 */
+
+	*(u64 *)buff = 0xdeadbeefdeadbeef;
+
+	for (i = 8; i < sz; i++)
+		buff[i] = '1' + random() % 9;
+
+	ctx.skel->rodata->buff_len = args.buff_len;
+
+	err = csum_diff_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		csum_diff_bench__destroy(ctx.skel);
+		exit(1);
+	}
+}
+
+static void csum_diff_helper_setup(void)
+{
+	u8 tmp_out[64 << 2] = {};
+	u8 tmp_in[64] = {};
+	int err, saved_errno;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = tmp_in,
+		.data_size_in = sizeof(tmp_in),
+		.data_out = tmp_out,
+		.data_size_out = sizeof(tmp_out),
+		.repeat = 1,
+	);
+	csum_diff_setup();
+	ctx.pfd = bpf_program__fd(ctx.skel->progs.compute_checksum);
+
+	err = bpf_prog_test_run_opts(ctx.pfd, &topts);
+	saved_errno = errno;
+
+	if (err) {
+		fprintf(stderr, "failed to run setup prog: err %d, result %d, serror %d\n",
+			err, ctx.skel->bss->result, saved_errno);
+		csum_diff_bench__destroy(ctx.skel);
+		exit(1);
+	}
+
+	/* Sanity check for correctness of helper */
+	if (args.buff_len == 8 && ctx.skel->bss->result != 0x3b3b) {
+		fprintf(stderr, "csum_diff helper broken: buff: %lx, result: %x, expected: %x\n",
+			*(u64 *)ctx.skel->rodata->buff, ctx.skel->bss->result, 0x3b3b);
+	}
+}
+
+static void *csum_diff_producer(void *unused)
+{
+	u8 tmp_out[64 << 2] = {};
+	u8 tmp_in[64] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = tmp_in,
+		.data_size_in = sizeof(tmp_in),
+		.data_out = tmp_out,
+		.data_size_out = sizeof(tmp_out),
+		.repeat = 64,
+	);
+	while (true)
+		(void)bpf_prog_test_run_opts(ctx.pfd, &topts);
+	return NULL;
+}
+
+static void csum_diff_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+const struct bench bench_csum_diff = {
+	.name = "csum-diff-helper",
+	.argp = &bench_csum_diff_argp,
+	.validate = csum_diff_validate,
+	.setup = csum_diff_helper_setup,
+	.producer_thread = csum_diff_producer,
+	.measure = csum_diff_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_csum_diff.sh b/tools/testing/selftests/bpf/benchs/run_bench_csum_diff.sh
new file mode 100755
index 0000000000000..c4e147fbf2f98
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_csum_diff.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+for s in 4 8 16 20 32 40 64 128 256 512; do
+	summarize ${s} "$($RUN_BENCH --buff-len=$s csum-diff-helper)"
+done
diff --git a/tools/testing/selftests/bpf/progs/csum_diff_bench.c b/tools/testing/selftests/bpf/progs/csum_diff_bench.c
new file mode 100644
index 0000000000000..85245edd6f9dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/csum_diff_bench.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define BUFF_SZ 4096
+
+/* Will be updated by benchmark before program loading */
+const char buff[BUFF_SZ];
+const volatile unsigned int buff_len = 4;
+
+long hits = 0;
+short result;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("tc")
+int compute_checksum(void *ctx)
+{
+	result = bpf_csum_diff(0, 0, (void *)buff, buff_len, 0);
+	__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
-- 
2.40.1


