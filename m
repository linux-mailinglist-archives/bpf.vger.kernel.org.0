Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85295463618
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 15:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhK3OKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 09:10:23 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27322 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbhK3OKW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 09:10:22 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J3PCy0pyqzbjDP;
        Tue, 30 Nov 2021 22:06:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 22:07:00 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH bpf-next 4/5] selftests/bpf: add benchmark for bpf_strncmp() helper
Date:   Tue, 30 Nov 2021 22:22:14 +0800
Message-ID: <20211130142215.1237217-5-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211130142215.1237217-1-houtao1@huawei.com>
References: <20211130142215.1237217-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add benchmark to compare the performance between home-made strncmp()
in bpf program and bpf_strncmp() helper. In summary, the performance
win of bpf_strncmp() under x86-64 is greater than 18% when the compared
string length is greater than 64, and is 179% when the length is 4095.
Under arm64 the performance win is even bigger: 33% when the length
is greater than 64 and 600% when the length is 4095.

The following is the details:

no-helper-X: use home-made strncmp() to compare X-sized string
helper-Y: use bpf_strncmp() to compare Y-sized string

Under x86-64:

no-helper-1          3.504 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-1             3.347 ± 0.001M/s (drops 0.000 ± 0.000M/s)

no-helper-8          3.357 ± 0.001M/s (drops 0.000 ± 0.000M/s)
helper-8             3.307 ± 0.001M/s (drops 0.000 ± 0.000M/s)

no-helper-32         3.064 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-32            3.253 ± 0.001M/s (drops 0.000 ± 0.000M/s)

no-helper-64         2.563 ± 0.001M/s (drops 0.000 ± 0.000M/s)
helper-64            3.040 ± 0.001M/s (drops 0.000 ± 0.000M/s)

no-helper-128        1.975 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-128           2.641 ± 0.000M/s (drops 0.000 ± 0.000M/s)

no-helper-512        0.759 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-512           1.574 ± 0.000M/s (drops 0.000 ± 0.000M/s)

no-helper-2048       0.329 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-2048          0.602 ± 0.000M/s (drops 0.000 ± 0.000M/s)

no-helper-4095       0.117 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-4095          0.327 ± 0.000M/s (drops 0.000 ± 0.000M/s)

Under arm64:

no-helper-1          2.806 ± 0.004M/s (drops 0.000 ± 0.000M/s)
helper-1             2.819 ± 0.002M/s (drops 0.000 ± 0.000M/s)

no-helper-8          2.797 ± 0.109M/s (drops 0.000 ± 0.000M/s)
helper-8             2.786 ± 0.025M/s (drops 0.000 ± 0.000M/s)

no-helper-32         2.399 ± 0.011M/s (drops 0.000 ± 0.000M/s)
helper-32            2.703 ± 0.002M/s (drops 0.000 ± 0.000M/s)

no-helper-64         2.020 ± 0.015M/s (drops 0.000 ± 0.000M/s)
helper-64            2.702 ± 0.073M/s (drops 0.000 ± 0.000M/s)

no-helper-128        1.604 ± 0.001M/s (drops 0.000 ± 0.000M/s)
helper-128           2.516 ± 0.002M/s (drops 0.000 ± 0.000M/s)

no-helper-512        0.699 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-512           2.106 ± 0.003M/s (drops 0.000 ± 0.000M/s)

no-helper-2048       0.215 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-2048          1.223 ± 0.003M/s (drops 0.000 ± 0.000M/s)

no-helper-4095       0.112 ± 0.000M/s (drops 0.000 ± 0.000M/s)
helper-4095          0.796 ± 0.000M/s (drops 0.000 ± 0.000M/s)

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../selftests/bpf/benchs/bench_strncmp.c      | 150 ++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_strncmp.sh |  12 ++
 .../selftests/bpf/progs/strncmp_bench.c       |  50 ++++++
 5 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_strncmp.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_strncmp.sh
 create mode 100644 tools/testing/selftests/bpf/progs/strncmp_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8ff7060fe754..7719924b01a3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -531,6 +531,7 @@ $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
 			    $(OUTPUT)/perfbuf_bench.skel.h
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
+$(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -540,7 +541,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_rename.o \
 		 $(OUTPUT)/bench_trigger.o \
 		 $(OUTPUT)/bench_ringbufs.o \
-		 $(OUTPUT)/bench_bloom_filter_map.o
+		 $(OUTPUT)/bench_bloom_filter_map.o \
+		 $(OUTPUT)/bench_strncmp.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 681db8175fe1..8f1a4351fb18 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -184,10 +184,12 @@ static const struct argp_option opts[] = {
 
 extern struct argp bench_ringbufs_argp;
 extern struct argp bench_bloom_map_argp;
+extern struct argp strncmp_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
 	{ &bench_bloom_map_argp, 0, "Bloom filter map benchmark", 0 },
+	{ &strncmp_argp, 0, "Strncmp benchmark", 0 },
 	{},
 };
 
@@ -386,6 +388,8 @@ extern const struct bench bench_bloom_update;
 extern const struct bench bench_bloom_false_positive;
 extern const struct bench bench_hashmap_without_bloom;
 extern const struct bench bench_hashmap_with_bloom;
+extern const struct bench bench_strncmp_no_helper;
+extern const struct bench bench_strncmp_helper;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -417,6 +421,8 @@ static const struct bench *benchs[] = {
 	&bench_bloom_false_positive,
 	&bench_hashmap_without_bloom,
 	&bench_hashmap_with_bloom,
+	&bench_strncmp_no_helper,
+	&bench_strncmp_helper,
 };
 
 static void setup_benchmark()
diff --git a/tools/testing/selftests/bpf/benchs/bench_strncmp.c b/tools/testing/selftests/bpf/benchs/bench_strncmp.c
new file mode 100644
index 000000000000..57dea095e27a
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_strncmp.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021. Huawei Technologies Co., Ltd */
+#include <argp.h>
+#include "bench.h"
+#include "strncmp_bench.skel.h"
+
+struct strncmp_ctx {
+	struct strncmp_bench *skel;
+};
+
+struct strncmp_args {
+	u32 cmp_str_len;
+};
+
+static struct strncmp_args args = {
+	.cmp_str_len = 32,
+};
+
+static struct strncmp_ctx ctx;
+
+enum {
+	ARG_CMP_STR_LEN = 4000,
+};
+
+static const struct argp_option opts[] = {
+	{ "cmp-str-len", ARG_CMP_STR_LEN, "CMP_STR_LEN", 0,
+	  "Set the length of compared string" },
+	{},
+};
+
+static error_t strncmp_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_CMP_STR_LEN:
+		args.cmp_str_len = strtoul(arg, NULL, 10);
+		if (!args.cmp_str_len ||
+		    args.cmp_str_len >= sizeof(ctx.skel->bss->str)) {
+			fprintf(stderr, "Invalid cmp str len (limit %zu)\n",
+				sizeof(ctx.skel->bss->str));
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
+const struct argp strncmp_argp = {
+	.options = opts,
+	.parser = strncmp_parse_arg,
+};
+
+static void strncmp_validate(void)
+{
+	assert_single_consumer("strncmp");
+}
+
+static void strncmp_setup(void)
+{
+	int err;
+	char *target;
+	size_t i, sz;
+
+	sz = sizeof(ctx.skel->rodata->target);
+	if (!sz || sz < sizeof(ctx.skel->bss->str)) {
+		fprintf(stderr, "invalid string size (target %zu, src %zu)\n",
+			sz, sizeof(ctx.skel->bss->str));
+		exit(1);
+	}
+
+	setup_libbpf();
+
+	ctx.skel = strncmp_bench__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	srandom(time(NULL));
+	target = ctx.skel->rodata->target;
+	for (i = 0; i < sz - 1; i++)
+		target[i] = '1' + random() % 9;
+	target[sz - 1] = '\0';
+
+	ctx.skel->rodata->cmp_str_len = args.cmp_str_len;
+
+	memcpy(ctx.skel->bss->str, target, args.cmp_str_len);
+	ctx.skel->bss->str[args.cmp_str_len] = '\0';
+	/* Make bss->str < rodata->target */
+	ctx.skel->bss->str[args.cmp_str_len - 1] -= 1;
+
+	err = strncmp_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		strncmp_bench__destroy(ctx.skel);
+		exit(1);
+	}
+}
+
+static void strncmp_attach_prog(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void strncmp_no_helper_setup(void)
+{
+	strncmp_setup();
+	strncmp_attach_prog(ctx.skel->progs.strncmp_no_helper);
+}
+
+static void strncmp_helper_setup(void)
+{
+	strncmp_setup();
+	strncmp_attach_prog(ctx.skel->progs.strncmp_helper);
+}
+
+static void strncmp_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+const struct bench bench_strncmp_no_helper = {
+	.name = "strncmp-no-helper",
+	.validate = strncmp_validate,
+	.setup = strncmp_no_helper_setup,
+	.producer_thread = getpgid_loop_producer,
+	.consumer_thread = noop_consumer,
+	.measure = strncmp_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
+const struct bench bench_strncmp_helper = {
+	.name = "strncmp-helper",
+	.validate = strncmp_validate,
+	.setup = strncmp_helper_setup,
+	.producer_thread = getpgid_loop_producer,
+	.consumer_thread = noop_consumer,
+	.measure = strncmp_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_strncmp.sh b/tools/testing/selftests/bpf/benchs/run_bench_strncmp.sh
new file mode 100755
index 000000000000..142697284b45
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_strncmp.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+for s in 1 8 64 512 2048 4095; do
+	for b in no-helper helper; do
+		summarize ${b}-${s} "$($RUN_BENCH --cmp-str-len=$s strncmp-${b})"
+	done
+done
diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c b/tools/testing/selftests/bpf/progs/strncmp_bench.c
new file mode 100644
index 000000000000..18373a7df76e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021. Huawei Technologies Co., Ltd */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define STRNCMP_STR_SZ 4096
+
+/* Will be updated by benchmark before program loading */
+const volatile unsigned int cmp_str_len = 1;
+const char target[STRNCMP_STR_SZ];
+
+long hits = 0;
+char str[STRNCMP_STR_SZ];
+
+char _license[] SEC("license") = "GPL";
+
+static __always_inline int local_strncmp(const char *s1, unsigned int sz,
+					 const char *s2)
+{
+	int ret = 0;
+	unsigned int i;
+
+	for (i = 0; i < sz; i++) {
+		/* E.g. 0xff > 0x31 */
+		ret = (unsigned char)s1[i] - (unsigned char)s2[i];
+		if (ret || !s1[i])
+			break;
+	}
+
+	return ret;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strncmp_no_helper(void *ctx)
+{
+	if (local_strncmp(str, cmp_str_len + 1, target) < 0)
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int strncmp_helper(void *ctx)
+{
+	if (bpf_strncmp(str, cmp_str_len + 1, target) < 0)
+		__sync_add_and_fetch(&hits, 1);
+	return 0;
+}
+
-- 
2.29.2

