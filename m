Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2732C45AB55
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbhKWShr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:37:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239912AbhKWShr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 13:37:47 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANG8PkP004858
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:34:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=PgmW00J/Dx8btHzU46i8Eu2rnfgkytXvwaQYYkUH/P0=;
 b=e3SxpQxTwJGAuuS/NpyW94iYbCK1Ze8mOCwwqcQAbaP/qZpSRkZnRzAfA4QvjU6QGjqa
 HTVG6n1T1T42w0I/Ckb/ZaviVhTcR3lDvXMxEuR0ykp8XLF9I/Cp2UK4+tQvC0nfZJEK
 aQqL/547Y2GtIZjh1SDn228oLErAe/XJIyo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch3jah59b-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:34:38 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 23 Nov 2021 10:34:36 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 9A454533D337; Tue, 23 Nov 2021 10:34:26 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop benchmark
Date:   Tue, 23 Nov 2021 10:34:09 -0800
Message-ID: <20211123183409.3599979-5-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123183409.3599979-1-joannekoong@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: qPkxAn4fhhpc8F1awOQagcCO08nmRfj0
X-Proofpoint-GUID: qPkxAn4fhhpc8F1awOQagcCO08nmRfj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_06,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add benchmark to measure the throughput and latency of the bpf_loop
call.

Testing this on qemu on my dev machine on 1 thread, the data is
as follows:

        nr_loops: 1
bpf_loop - throughput: 43.350 =C2=B1 0.864 M ops/s, latency: 23.068 ns/op

        nr_loops: 10
bpf_loop - throughput: 69.586 =C2=B1 1.722 M ops/s, latency: 14.371 ns/op

        nr_loops: 100
bpf_loop - throughput: 72.046 =C2=B1 1.352 M ops/s, latency: 13.880 ns/op

        nr_loops: 500
bpf_loop - throughput: 71.677 =C2=B1 1.316 M ops/s, latency: 13.951 ns/op

        nr_loops: 1000
bpf_loop - throughput: 69.435 =C2=B1 1.219 M ops/s, latency: 14.402 ns/op

        nr_loops: 5000
bpf_loop - throughput: 72.624 =C2=B1 1.162 M ops/s, latency: 13.770 ns/op

        nr_loops: 10000
bpf_loop - throughput: 75.417 =C2=B1 1.446 M ops/s, latency: 13.260 ns/op

        nr_loops: 50000
bpf_loop - throughput: 77.400 =C2=B1 2.214 M ops/s, latency: 12.920 ns/op

        nr_loops: 100000
bpf_loop - throughput: 78.636 =C2=B1 2.107 M ops/s, latency: 12.717 ns/op

        nr_loops: 500000
bpf_loop - throughput: 76.909 =C2=B1 2.035 M ops/s, latency: 13.002 ns/op

        nr_loops: 1000000
bpf_loop - throughput: 77.636 =C2=B1 1.748 M ops/s, latency: 12.881 ns/op

From this data, we can see that the latency per loop decreases as the
number of loops increases. On this particular machine, each loop had an
overhead of about ~13 ns, and we were able to run ~70 million loops
per second.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |  26 +++++
 tools/testing/selftests/bpf/bench.h           |   1 +
 .../selftests/bpf/benchs/bench_bpf_loop.c     | 105 ++++++++++++++++++
 .../bpf/benchs/run_bench_bpf_loop.sh          |  15 +++
 .../selftests/bpf/benchs/run_common.sh        |  15 +++
 .../selftests/bpf/progs/bpf_loop_bench.c      |  26 +++++
 7 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_loop=
.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_loop_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 35684d61aaeb..a6c0e92c86a1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -531,6 +531,7 @@ $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.sk=
el.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
 			    $(OUTPUT)/perfbuf_bench.skel.h
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
+$(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS +=3D -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -540,7 +541,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_rename.o \
 		 $(OUTPUT)/bench_trigger.o \
 		 $(OUTPUT)/bench_ringbufs.o \
-		 $(OUTPUT)/bench_bloom_filter_map.o
+		 $(OUTPUT)/bench_bloom_filter_map.o \
+		 $(OUTPUT)/bench_bpf_loop.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
=20
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
index c75e7ee28746..bfd969e0424f 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -134,6 +134,28 @@ void hits_drops_report_final(struct bench_res res[],=
 int res_cnt)
 	       total_ops_mean, total_ops_stddev);
 }
=20
+void ops_report_final(struct bench_res res[], int res_cnt)
+{
+	double hits_mean =3D 0.0, hits_stddev =3D 0.0;
+	int i;
+
+	for (i =3D 0; i < res_cnt; i++)
+		hits_mean +=3D res[i].hits / 1000000.0 / (0.0 + res_cnt);
+
+	if (res_cnt > 1)  {
+		for (i =3D 0; i < res_cnt; i++)
+			hits_stddev +=3D (hits_mean - res[i].hits / 1000000.0) *
+				       (hits_mean - res[i].hits / 1000000.0) /
+				       (res_cnt - 1.0);
+
+		hits_stddev =3D sqrt(hits_stddev);
+	}
+	printf("Summary: throughput %8.3lf \u00B1 %5.3lf M ops/s (%7.3lfM ops/p=
rod), ",
+	       hits_mean, hits_stddev, hits_mean / env.producer_cnt);
+	printf("latency %8.3lf ns/op (%7.3lf ns/op /prod)\n",
+	       1000.0 / hits_mean, 1000.0 / hits_mean / env.producer_cnt);
+}
+
 const char *argp_program_version =3D "benchmark";
 const char *argp_program_bug_address =3D "<bpf@vger.kernel.org>";
 const char argp_program_doc[] =3D
@@ -171,10 +193,12 @@ static const struct argp_option opts[] =3D {
=20
 extern struct argp bench_ringbufs_argp;
 extern struct argp bench_bloom_map_argp;
+extern struct argp bench_bpf_loop_argp;
=20
 static const struct argp_child bench_parsers[] =3D {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
 	{ &bench_bloom_map_argp, 0, "Bloom filter map benchmark", 0 },
+	{ &bench_bpf_loop_argp, 0, "bpf_loop helper benchmark", 0 },
 	{},
 };
=20
@@ -373,6 +397,7 @@ extern const struct bench bench_bloom_update;
 extern const struct bench bench_bloom_false_positive;
 extern const struct bench bench_hashmap_without_bloom;
 extern const struct bench bench_hashmap_with_bloom;
+extern const struct bench bench_bpf_loop;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -404,6 +429,7 @@ static const struct bench *benchs[] =3D {
 	&bench_bloom_false_positive,
 	&bench_hashmap_without_bloom,
 	&bench_hashmap_with_bloom,
+	&bench_bpf_loop,
 };
=20
 static void setup_benchmark()
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftest=
s/bpf/bench.h
index 624c6b11501f..f0895de9aad0 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -59,6 +59,7 @@ void hits_drops_report_progress(int iter, struct bench_=
res *res, long delta_ns);
 void hits_drops_report_final(struct bench_res res[], int res_cnt);
 void false_hits_report_progress(int iter, struct bench_res *res, long de=
lta_ns);
 void false_hits_report_final(struct bench_res res[], int res_cnt);
+void ops_report_final(struct bench_res res[], int res_cnt);
=20
 static inline __u64 get_time_ns() {
 	struct timespec t;
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c b/tools/=
testing/selftests/bpf/benchs/bench_bpf_loop.c
new file mode 100644
index 000000000000..809a51d7be66
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_loop.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <argp.h>
+#include "bench.h"
+#include "bpf_loop_bench.skel.h"
+
+/* BPF triggering benchmarks */
+static struct ctx {
+	struct bpf_loop_bench *skel;
+} ctx;
+
+static struct {
+	__u32 nr_loops;
+} args =3D {
+	.nr_loops =3D 10,
+};
+
+enum {
+	ARG_NR_LOOPS =3D 4000,
+};
+
+static const struct argp_option opts[] =3D {
+	{ "nr_loops", ARG_NR_LOOPS, "nr_loops", 0,
+		"Set number of loops for the bpf_loop helper"},
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_NR_LOOPS:
+		args.nr_loops =3D strtol(arg, NULL, 10);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+/* exported into benchmark runner */
+const struct argp bench_bpf_loop_argp =3D {
+	.options =3D opts,
+	.parser =3D parse_arg,
+};
+
+static void validate(void)
+{
+	if (env.consumer_cnt !=3D 1) {
+		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+		exit(1);
+	}
+}
+
+static void *producer(void *input)
+{
+	while (true)
+		/* trigger the bpf program */
+		syscall(__NR_getpgid);
+
+	return NULL;
+}
+
+static void *consumer(void *input)
+{
+	return NULL;
+}
+
+static void measure(struct bench_res *res)
+{
+	res->hits =3D atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+static void setup(void)
+{
+	struct bpf_link *link;
+
+	setup_libbpf();
+
+	ctx.skel =3D bpf_loop_bench__open_and_load();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	link =3D bpf_program__attach(ctx.skel->progs.benchmark);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+
+	ctx.skel->bss->nr_loops =3D args.nr_loops;
+}
+
+const struct bench bench_bpf_loop =3D {
+	.name =3D "bpf-loop",
+	.validate =3D validate,
+	.setup =3D setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D ops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bpf_loop.sh b/t=
ools/testing/selftests/bpf/benchs/run_bench_bpf_loop.sh
new file mode 100755
index 000000000000..ff740e80ba84
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_bpf_loop.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+for t in 1 4 8 12 16; do
+for i in 1 10 100 500 1000 5000 10000 50000 100000 500000 1000000; do
+subtitle "nr_loops: $i, nr_threads: $t"
+	summarize_ops "bpf_loop: " \
+	    "$($RUN_BENCH -p $t --nr_loops $i bpf-loop)"
+	printf "\n"
+done
+done
diff --git a/tools/testing/selftests/bpf/benchs/run_common.sh b/tools/tes=
ting/selftests/bpf/benchs/run_common.sh
index 9a16be78b180..6c5e6023a69f 100644
--- a/tools/testing/selftests/bpf/benchs/run_common.sh
+++ b/tools/testing/selftests/bpf/benchs/run_common.sh
@@ -33,6 +33,14 @@ function percentage()
 	echo "$*" | sed -E "s/.*Percentage\s=3D\s+([0-9]+\.[0-9]+).*/\1/"
 }
=20
+function ops()
+{
+	echo -n "throughput: "
+	echo -n "$*" | sed -E "s/.*throughput\s+([0-9]+\.[0-9]+ =C2=B1 [0-9]+\.=
[0-9]+\sM\sops\/s).*/\1/"
+	echo -n -e ", latency: "
+	echo "$*" | sed -E "s/.*latency\s+([0-9]+\.[0-9]+\sns\/op).*/\1/"
+}
+
 function total()
 {
 	echo "$*" | sed -E "s/.*total operations\s+([0-9]+\.[0-9]+ =C2=B1 [0-9]=
+\.[0-9]+M\/s).*/\1/"
@@ -52,6 +60,13 @@ function summarize_percentage()
 	printf "%-20s %s%%\n" "$bench" "$(percentage $summary)"
 }
=20
+function summarize_ops()
+{
+	bench=3D"$1"
+	summary=3D$(echo $2 | tail -n1)
+	printf "%-20s %s\n" "$bench" "$(ops $summary)"
+}
+
 function summarize_total()
 {
 	bench=3D"$1"
diff --git a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c b/tools/t=
esting/selftests/bpf/progs/bpf_loop_bench.c
new file mode 100644
index 000000000000..ff00621858c0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2021 Facebook
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+u32 nr_loops;
+long hits;
+
+static int empty_callback(__u32 index, void *data)
+{
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int benchmark(void *ctx)
+{
+	for (int i =3D 0; i < 1000; i++) {
+		bpf_loop(nr_loops, empty_callback, NULL, 0);
+
+		__sync_add_and_fetch(&hits, nr_loops);
+	}
+	return 0;
+}
--=20
2.30.2

