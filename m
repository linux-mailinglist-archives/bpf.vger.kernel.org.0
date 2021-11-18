Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79E4551FA
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 02:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbhKRBKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 20:10:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237831AbhKRBKA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 20:10:00 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHLeCJq006841
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:07:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=PMnMl7JHz/z5Rj3SxfUQ4Ex8WNuSbKnTnshpFFtwRNc=;
 b=B+QQD/iH9OzAFcyXVI5ghWWU98HjN0ieKc6vy7PPMhijafHWRTvGdt5agXW8R0Sm/wqm
 3GsExoBbafUL6BtMKcbCOfiV2nududcpqoghiwEbKvv4IdCbU7009bRLeACdwlYiqNvq
 /auhpnXJoMq4BEOIdiv9AgGjGvP/TJ+yizY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ccyjw5ykm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:07:01 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 17:07:00 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 13CE04F5FAE5; Wed, 17 Nov 2021 17:06:53 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 3/3] selftest/bpf/benchs: add bpf_for_each benchmark
Date:   Wed, 17 Nov 2021 17:04:04 -0800
Message-ID: <20211118010404.2415864-4-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118010404.2415864-1-joannekoong@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: TTLYnmTFuDf1ZWmf0jJNv_-26oL16gT8
X-Proofpoint-GUID: TTLYnmTFuDf1ZWmf0jJNv_-26oL16gT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add benchmark to measure the overhead of the bpf_for_each call
for a specified number of iterations.

Testing this on qemu on my dev machine on 1 thread, the data is
as follows:

        nr_iterations: 1
bpf_for_each helper - total callbacks called:  42.949 =C2=B1 1.404M/s

        nr_iterations: 10
bpf_for_each helper - total callbacks called:  73.645 =C2=B1 2.077M/s

        nr_iterations: 100
bpf_for_each helper - total callbacks called:  73.058 =C2=B1 1.256M/s

        nr_iterations: 500
bpf_for_each helper - total callbacks called:  78.255 =C2=B1 2.845M/s

        nr_iterations: 1000
bpf_for_each helper - total callbacks called:  79.439 =C2=B1 1.805M/s

        nr_iterations: 5000
bpf_for_each helper - total callbacks called:  81.639 =C2=B1 2.053M/s

        nr_iterations: 10000
bpf_for_each helper - total callbacks called:  80.577 =C2=B1 1.824M/s

        nr_iterations: 50000
bpf_for_each helper - total callbacks called:  76.773 =C2=B1 1.578M/s

        nr_iterations: 100000
bpf_for_each helper - total callbacks called:  77.073 =C2=B1 2.200M/s

        nr_iterations: 500000
bpf_for_each helper - total callbacks called:  75.136 =C2=B1 0.552M/s

        nr_iterations: 1000000
bpf_for_each helper - total callbacks called:  76.364 =C2=B1 1.690M/s

From this data, we can see that we are able to run the loop at
least 40 million times per second on an empty callback function.

From this data, we can also see that as the number of iterations
increases, the overhead per iteration decreases and steadies towards
a constant value.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_for_each.c     | 105 ++++++++++++++++++
 .../bpf/benchs/run_bench_for_each.sh          |  16 +++
 .../selftests/bpf/progs/for_each_helper.c     |  13 +++
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_for_each.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_for_each=
.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index f49cb5fc85af..b55fc72b8ef0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -537,7 +537,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_=
helpers.o \
 		 $(OUTPUT)/bench_rename.o \
 		 $(OUTPUT)/bench_trigger.o \
 		 $(OUTPUT)/bench_ringbufs.o \
-		 $(OUTPUT)/bench_bloom_filter_map.o
+		 $(OUTPUT)/bench_bloom_filter_map.o \
+		 $(OUTPUT)/bench_for_each.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
=20
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
index cc4722f693e9..d8b3d537a700 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -171,10 +171,12 @@ static const struct argp_option opts[] =3D {
=20
 extern struct argp bench_ringbufs_argp;
 extern struct argp bench_bloom_map_argp;
+extern struct argp bench_for_each_argp;
=20
 static const struct argp_child bench_parsers[] =3D {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
 	{ &bench_bloom_map_argp, 0, "Bloom filter map benchmark", 0 },
+	{ &bench_for_each_argp, 0, "bpf_for_each helper benchmark", 0 },
 	{},
 };
=20
@@ -368,6 +370,7 @@ extern const struct bench bench_bloom_update;
 extern const struct bench bench_bloom_false_positive;
 extern const struct bench bench_hashmap_without_bloom;
 extern const struct bench bench_hashmap_with_bloom;
+extern const struct bench bench_for_each_helper;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -394,6 +397,7 @@ static const struct bench *benchs[] =3D {
 	&bench_bloom_false_positive,
 	&bench_hashmap_without_bloom,
 	&bench_hashmap_with_bloom,
+	&bench_for_each_helper,
 };
=20
 static void setup_benchmark()
diff --git a/tools/testing/selftests/bpf/benchs/bench_for_each.c b/tools/=
testing/selftests/bpf/benchs/bench_for_each.c
new file mode 100644
index 000000000000..3372d5b7d67b
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_for_each.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <argp.h>
+#include "bench.h"
+#include "for_each_helper.skel.h"
+
+/* BPF triggering benchmarks */
+static struct ctx {
+	struct for_each_helper *skel;
+} ctx;
+
+static struct {
+	__u32 nr_iters;
+} args =3D {
+	.nr_iters =3D 10,
+};
+
+enum {
+	ARG_NR_ITERS =3D 4000,
+};
+
+static const struct argp_option opts[] =3D {
+	{ "nr_iters", ARG_NR_ITERS, "nr_iters", 0,
+		"Set number of iterations for the bpf_for_each helper"},
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_NR_ITERS:
+		args.nr_iters =3D strtol(arg, NULL, 10);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+/* exported into benchmark runner */
+const struct argp bench_for_each_argp =3D {
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
+	ctx.skel =3D for_each_helper__open_and_load();
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
+	ctx.skel->bss->nr_iterations =3D args.nr_iters;
+}
+
+const struct bench bench_for_each_helper =3D {
+	.name =3D "for-each-helper",
+	.validate =3D validate,
+	.setup =3D setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_for_each.sh b/t=
ools/testing/selftests/bpf/benchs/run_bench_for_each.sh
new file mode 100755
index 000000000000..5f11a1ad66d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_for_each.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+for t in 1 4 8 12 16; do
+printf "\n"
+for i in 1 10 100 500 1000 5000 10000 50000 100000 500000 1000000; do
+subtitle "nr_iterations: $i, nr_threads: $t"
+	summarize "bpf_for_each helper - total callbacks called: " \
+	    "$($RUN_BENCH -p $t --nr_iters $i for-each-helper)"
+	printf "\n"
+done
+done
diff --git a/tools/testing/selftests/bpf/progs/for_each_helper.c b/tools/=
testing/selftests/bpf/progs/for_each_helper.c
index 4404d0cb32a6..b95551d99f75 100644
--- a/tools/testing/selftests/bpf/progs/for_each_helper.c
+++ b/tools/testing/selftests/bpf/progs/for_each_helper.c
@@ -14,6 +14,8 @@ struct callback_ctx {
 u32 nr_iterations;
 u32 stop_index =3D -1;
=20
+long hits;
+
 /* Making these global variables so that the userspace program
  * can verify the output through the skeleton
  */
@@ -67,3 +69,14 @@ int prog_invalid_flags(struct __sk_buff *skb)
=20
 	return 0;
 }
+
+SEC("fentry/__x64_sys_getpgid")
+int benchmark(void *ctx)
+{
+	for (int i =3D 0; i < 1000; i++) {
+		bpf_for_each(nr_iterations, empty_callback_fn, NULL, 0);
+
+		__sync_add_and_fetch(&hits, nr_iterations);
+	}
+	return 0;
+}
--=20
2.30.2

