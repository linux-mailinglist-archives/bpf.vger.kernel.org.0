Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5051F1E2
	for <lists+bpf@lfdr.de>; Sun,  8 May 2022 23:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiEHV5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 May 2022 17:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiEHV5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 17:57:10 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4B5F8A
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 14:53:17 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248Kqtmq019324
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 14:53:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=xlHvPkgEfhigFfFZGXUNakpz3PgPUweEE7lwfJEuDYE=;
 b=jR8RzRzhznZmshCms0s/04Hrd6JEOFfIGVBky/Q9VHL4HYIYnBH58rBhG8yryCqUE59f
 3PMlJ7SVqly46DuqFdPBwZPxpH1zKi09yQjqCjIU03m3o6NDf9T2SWUF/9q+F6enQiUy
 Z8zbutb5e7qJW7pdsAXWTYA+glx4uYLhWF4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpgw5af0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 14:53:16 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 14:53:14 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 95EFF769CEB9; Sun,  8 May 2022 14:53:02 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Add benchmark for local_storage get
Date:   Sun, 8 May 2022 14:53:01 -0700
Message-ID: <20220508215301.110736-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: ezhwbm8qPFol8seAWXOX0rqXYwJcRqaY
X-Proofpoint-GUID: ezhwbm8qPFol8seAWXOX0rqXYwJcRqaY
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_08,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a benchmarks to demonstrate the performance cliff for local_storage
get as the number of local_storage maps increases beyond current
local_storage implementation's cache size.

"sequential get" and "interleaved get" benchmarks are added, both of
which do many bpf_task_storage_get calls on a set of {10, 100, 1000}
task local_storage maps, while considering a single specific map to be
'important' and counting task_storage_gets to the important map
separately in addition to normal 'hits' count of all gets. Goal here is
to mimic scenario where a particular program using one map - the
important one - is running on a system where many other local_storage
maps exist and are accessed often.

While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
bpf_task_storage_gets for the important map for every 10 map gets. This
is meant to highlight performance differences when important map is
accessed far more frequently than non-important maps.

Addition of this benchmark is inspired by conversation with Alexei in a
previous patchset's thread [0], which highlighted the need for such a
benchmark to motivate and validate improvements to local_storage
implementation. My approach in that series focused on improving
performance for explicitly-marked 'important' maps and was rejected
with feedback to make more generally-applicable improvements while
avoiding explicitly marking maps as important. Thus the benchmark
reports both general and important-map-focused metrics, so effect of
future work on both is clear.

Regarding the benchmark results. On a powerful system (Skylake, 20
cores, 256gb ram):

Local Storage
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        num_maps: 10
local_storage cache sequential  get:  hits throughput: 20.013 =C2=B1 0.818 =
M ops/s, hits latency: 49.967 ns/op, important_hits throughput: 2.001 =C2=
=B1 0.082 M ops/s
local_storage cache interleaved get:  hits throughput: 23.149 =C2=B1 0.342 =
M ops/s, hits latency: 43.198 ns/op, important_hits throughput: 8.268 =C2=
=B1 0.122 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 6.149 =C2=B1 0.220 M=
 ops/s, hits latency: 162.630 ns/op, important_hits throughput: 0.061 =C2=
=B1 0.002 M ops/s
local_storage cache interleaved get:  hits throughput: 7.659 =C2=B1 0.177 M=
 ops/s, hits latency: 130.565 ns/op, important_hits throughput: 2.243 =C2=
=B1 0.052 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 0.917 =C2=B1 0.029 M=
 ops/s, hits latency: 1090.711 ns/op, important_hits throughput: 0.002 =C2=
=B1 0.000 M ops/s
local_storage cache interleaved get:  hits throughput: 1.121 =C2=B1 0.016 M=
 ops/s, hits latency: 892.299 ns/op, important_hits throughput: 0.322 =C2=
=B1 0.005 M ops/s

Looking at the "sequential get" results, it's clear that as the
number of task local_storage maps grows beyond the current cache size
(16), there's a significant reduction in hits throughput. Note that
current local_storage implementation assigns a cache_idx to maps as they
are created. Since "sequential get" is creating maps 0..n in order and
then doing bpf_task_storage_get calls in the same order, the benchmark
is effectively ensuring that a map will not be in cache when the program
tries to access it.

For "interleaved get" results, important-map hits throughput is greatly
increased as the important map is more likely to be in cache by virtue
of being accessed far more frequently. Throughput still reduces as #
maps increases, though.

Note that 100- and 1000-map variants of the benchmarks need to split
task_storage_get calls across multiple programs to work around the
verifier's MAX_USED_MAPS limitation. To rule out the effect of addtional
overhead of this splitting on the results I created a version of
local_storage_bench__get100 which split the 100 gets across 8 progs
instead of 2. The __get100 results were not affected.

When running the benchmarks it may be necessary to bump 'open files'
ulimit for a successful run.

  [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@=
fb.com

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/testing/selftests/bpf/Makefile          |  10 +-
 tools/testing/selftests/bpf/bench.c           |  55 ++++
 tools/testing/selftests/bpf/bench.h           |   5 +
 .../bpf/benchs/bench_local_storage.c          | 264 ++++++++++++++++++
 .../bpf/benchs/run_bench_local_storage.sh     |  16 ++
 .../selftests/bpf/benchs/run_common.sh        |  17 ++
 .../progs/local_storage_bench__create_map.c   |  12 +
 .../bpf/progs/local_storage_bench__get10.c    |  24 ++
 .../bpf/progs/local_storage_bench__get100.c   |  42 +++
 .../bpf/progs/local_storage_bench__get1000.c  |  56 ++++
 ...local_storage_bench__get1000_interleaved.c |  56 ++++
 .../local_storage_bench__get100_interleaved.c |  42 +++
 .../local_storage_bench__get10_interleaved.c  |  24 ++
 .../bpf/progs/local_storage_bench_helpers.h   |  85 ++++++
 14 files changed, 707 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_stor=
age.sh
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
create_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
get10.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
get100.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
get1000.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
get1000_interleaved.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
get100_interleaved.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
get10_interleaved.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench_h=
elpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index bafdc5373a13..00b62ab5c932 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -558,6 +558,13 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.sk=
el.h \
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
 $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
+$(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench__create_map=
.skel.h \
+				  $(OUTPUT)/local_storage_bench__get10.skel.h \
+				  $(OUTPUT)/local_storage_bench__get100.skel.h \
+				  $(OUTPUT)/local_storage_bench__get1000.skel.h \
+				  $(OUTPUT)/local_storage_bench__get10_interleaved.skel.h \
+				  $(OUTPUT)/local_storage_bench__get100_interleaved.skel.h \
+				  $(OUTPUT)/local_storage_bench__get1000_interleaved.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS +=3D -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -569,7 +576,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_ringbufs.o \
 		 $(OUTPUT)/bench_bloom_filter_map.o \
 		 $(OUTPUT)/bench_bpf_loop.o \
-		 $(OUTPUT)/bench_strncmp.o
+		 $(OUTPUT)/bench_strncmp.o \
+		 $(OUTPUT)/bench_local_storage.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
=20
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/=
bpf/bench.c
index f061cc20e776..f88b5f264ce7 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -150,6 +150,53 @@ void ops_report_final(struct bench_res res[], int res_=
cnt)
 	printf("latency %8.3lf ns/op\n", 1000.0 / hits_mean * env.producer_cnt);
 }
=20
+void local_storage_report_progress(int iter, struct bench_res *res,
+				   long delta_ns)
+{
+	double important_hits_per_sec, hits_per_sec;
+	double delta_sec =3D delta_ns / 1000000000.0;
+
+	hits_per_sec =3D res->hits / 1000000.0 / delta_sec;
+	important_hits_per_sec =3D res->important_hits / 1000000.0 / delta_sec;
+
+	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0);
+
+	printf("hits %8.3lfM/s ", hits_per_sec);
+	printf("important_hits %8.3lfM/s\n", important_hits_per_sec);
+}
+
+void local_storage_report_final(struct bench_res res[], int res_cnt)
+{
+	double important_hits_mean =3D 0.0, important_hits_stddev =3D 0.0;
+	double hits_mean =3D 0.0, hits_stddev =3D 0.0;
+	int i;
+
+	for (i =3D 0; i < res_cnt; i++) {
+		hits_mean +=3D res[i].hits / 1000000.0 / (0.0 + res_cnt);
+		important_hits_mean +=3D res[i].important_hits / 1000000.0 / (0.0 + res_=
cnt);
+	}
+
+	if (res_cnt > 1)  {
+		for (i =3D 0; i < res_cnt; i++) {
+			hits_stddev +=3D (hits_mean - res[i].hits / 1000000.0) *
+				       (hits_mean - res[i].hits / 1000000.0) /
+				       (res_cnt - 1.0);
+			important_hits_stddev +=3D
+				       (important_hits_mean - res[i].important_hits / 1000000.0) *
+				       (important_hits_mean - res[i].important_hits / 1000000.0) /
+				       (res_cnt - 1.0);
+		}
+
+		hits_stddev =3D sqrt(hits_stddev);
+		important_hits_stddev =3D sqrt(important_hits_stddev);
+	}
+	printf("Summary: hits throughput %8.3lf \u00B1 %5.3lf M ops/s, ",
+	       hits_mean, hits_stddev);
+	printf("hits latency %8.3lf ns/op, ", 1000.0 / hits_mean);
+	printf("important_hits throughput %8.3lf \u00B1 %5.3lf M ops/s\n",
+	       important_hits_mean, important_hits_stddev);
+}
+
 const char *argp_program_version =3D "benchmark";
 const char *argp_program_bug_address =3D "<bpf@vger.kernel.org>";
 const char argp_program_doc[] =3D
@@ -188,12 +235,14 @@ static const struct argp_option opts[] =3D {
 extern struct argp bench_ringbufs_argp;
 extern struct argp bench_bloom_map_argp;
 extern struct argp bench_bpf_loop_argp;
+extern struct argp bench_local_storage_argp;
 extern struct argp bench_strncmp_argp;
=20
 static const struct argp_child bench_parsers[] =3D {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
 	{ &bench_bloom_map_argp, 0, "Bloom filter map benchmark", 0 },
 	{ &bench_bpf_loop_argp, 0, "bpf_loop helper benchmark", 0 },
+	{ &bench_local_storage_argp, 0, "local_storage benchmark", 0 },
 	{ &bench_strncmp_argp, 0, "bpf_strncmp helper benchmark", 0 },
 	{},
 };
@@ -396,6 +445,8 @@ extern const struct bench bench_hashmap_with_bloom;
 extern const struct bench bench_bpf_loop;
 extern const struct bench bench_strncmp_no_helper;
 extern const struct bench bench_strncmp_helper;
+extern const struct bench bench_local_storage_cache_seq_get;
+extern const struct bench bench_local_storage_cache_interleaved_get;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -430,6 +481,8 @@ static const struct bench *benchs[] =3D {
 	&bench_bpf_loop,
 	&bench_strncmp_no_helper,
 	&bench_strncmp_helper,
+	&bench_local_storage_cache_seq_get,
+	&bench_local_storage_cache_interleaved_get,
 };
=20
 static void setup_benchmark()
@@ -547,5 +600,7 @@ int main(int argc, char **argv)
 		bench->report_final(state.results + env.warmup_sec,
 				    state.res_cnt - env.warmup_sec);
=20
+	if (bench->teardown)
+		bench->teardown();
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/=
bpf/bench.h
index fb3e213df3dc..0a137eedc959 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -34,12 +34,14 @@ struct bench_res {
 	long hits;
 	long drops;
 	long false_hits;
+	long important_hits;
 };
=20
 struct bench {
 	const char *name;
 	void (*validate)(void);
 	void (*setup)(void);
+	void (*teardown)(void);
 	void *(*producer_thread)(void *ctx);
 	void *(*consumer_thread)(void *ctx);
 	void (*measure)(struct bench_res* res);
@@ -61,6 +63,9 @@ void false_hits_report_progress(int iter, struct bench_re=
s *res, long delta_ns);
 void false_hits_report_final(struct bench_res res[], int res_cnt);
 void ops_report_progress(int iter, struct bench_res *res, long delta_ns);
 void ops_report_final(struct bench_res res[], int res_cnt);
+void local_storage_report_progress(int iter, struct bench_res *res,
+				   long delta_ns);
+void local_storage_report_final(struct bench_res res[], int res_cnt);
=20
 static inline __u64 get_time_ns(void)
 {
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage.c b/too=
ls/testing/selftests/bpf/benchs/bench_local_storage.c
new file mode 100644
index 000000000000..fe7ccafb7f8d
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <argp.h>
+#include "local_storage_bench__create_map.skel.h"
+#include "local_storage_bench__get10.skel.h"
+#include "local_storage_bench__get100.skel.h"
+#include "local_storage_bench__get1000.skel.h"
+#include "local_storage_bench__get10_interleaved.skel.h"
+#include "local_storage_bench__get100_interleaved.skel.h"
+#include "local_storage_bench__get1000_interleaved.skel.h"
+#include "bench.h"
+
+static struct {
+	__u32 nr_maps;
+} args =3D {
+	.nr_maps =3D 100,
+};
+
+enum {
+	ARG_NR_MAPS =3D 6000,
+};
+
+static const struct argp_option opts[] =3D {
+	{ "nr_maps", ARG_NR_MAPS, "NR_MAPS", 0,
+		"Set number of local_storage maps"},
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	long ret;
+
+	switch (key) {
+	case ARG_NR_MAPS:
+		ret =3D strtol(arg, NULL, 10);
+		if (ret < 1 || ret > UINT_MAX) {
+			fprintf(stderr, "invalid nr_maps");
+			argp_usage(state);
+		}
+		args.nr_maps =3D ret;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_local_storage_argp =3D {
+	.options =3D opts,
+	.parser =3D parse_arg,
+};
+
+static void validate(void)
+{
+	if (env.producer_cnt !=3D 1) {
+		fprintf(stderr, "benchmark doesn't support multi-producer!\n");
+		exit(1);
+	}
+	if (env.consumer_cnt !=3D 1) {
+		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+		exit(1);
+	}
+
+	if (!(args.nr_maps =3D=3D 10 || args.nr_maps =3D=3D 100 || args.nr_maps =
=3D=3D 1000)) {
+		fprintf(stderr, "nr_maps must be 10, 100, or 1000\n");
+		exit(1);
+	}
+}
+
+/* Map name in _get10, _get100, etc progs must match this pattern for
+ * PIN_BY_NAME to reuse existing map
+ */
+#define MAP_PIN_PATTERN "/sys/fs/bpf/local_storage_bench_pinned"
+
+void (*destroy_skel)(void *obj);
+long *skel_bss_important_hits;
+long *skel_bss_hits;
+void *test_skel;
+
+static void teardown(void);
+
+static void local_storage_cache_get_setup(void)
+{
+	struct local_storage_bench__get1000 *get1000_skel;
+	struct local_storage_bench__get100 *get100_skel;
+	struct local_storage_bench__get10 *get10_skel;
+	struct local_storage_bench__create_map *skel;
+	char path[100];
+	int i;
+
+	setup_libbpf();
+
+	for (i =3D 0; i < args.nr_maps; i++) {
+		skel =3D local_storage_bench__create_map__open_and_load();
+
+		sprintf(path, MAP_PIN_PATTERN "_%04d", i);
+		bpf_map__pin(skel->maps.map_to_pin, path);
+
+		local_storage_bench__create_map__destroy(skel);
+	}
+
+	switch (args.nr_maps) {
+	case 10:
+		get10_skel =3D local_storage_bench__get10__open_and_load();
+		local_storage_bench__get10__attach(get10_skel);
+		destroy_skel =3D (void(*)(void *))local_storage_bench__get10__destroy;
+		test_skel =3D (void *)get10_skel;
+		skel_bss_hits =3D &get10_skel->bss->hits;
+		skel_bss_important_hits =3D &get10_skel->bss->important_hits;
+		break;
+	case 100:
+		get100_skel =3D local_storage_bench__get100__open_and_load();
+		local_storage_bench__get100__attach(get100_skel);
+		destroy_skel =3D (void(*)(void *))local_storage_bench__get100__destroy;
+		test_skel =3D (void *)get100_skel;
+		skel_bss_hits =3D &get100_skel->bss->hits;
+		skel_bss_important_hits =3D &get100_skel->bss->important_hits;
+		break;
+	case 1000:
+		get1000_skel =3D local_storage_bench__get1000__open_and_load();
+		local_storage_bench__get1000__attach(get1000_skel);
+		destroy_skel =3D (void(*)(void *))local_storage_bench__get1000__destroy;
+		test_skel =3D (void *)get1000_skel;
+		skel_bss_hits =3D &get1000_skel->bss->hits;
+		skel_bss_important_hits =3D &get1000_skel->bss->important_hits;
+		break;
+	default:
+		fprintf(stderr,
+			"got an invalid nr_maps in setup, does validate() need update?");
+		teardown();
+		exit(1);
+		break;
+	}
+}
+
+static void local_storage_cache_get_interleaved_setup(void)
+{
+	struct local_storage_bench__get1000_interleaved *get1000_skel;
+	struct local_storage_bench__get100_interleaved *get100_skel;
+	struct local_storage_bench__get10_interleaved *get10_skel;
+	struct local_storage_bench__create_map *skel;
+	char path[100];
+	int i;
+
+	setup_libbpf();
+
+	for (i =3D 0; i < args.nr_maps; i++) {
+		skel =3D local_storage_bench__create_map__open_and_load();
+
+		sprintf(path, MAP_PIN_PATTERN "_%04d", i);
+		bpf_map__pin(skel->maps.map_to_pin, path);
+
+		local_storage_bench__create_map__destroy(skel);
+	}
+
+	switch (args.nr_maps) {
+	case 10:
+		get10_skel =3D local_storage_bench__get10_interleaved__open_and_load();
+		local_storage_bench__get10_interleaved__attach(get10_skel);
+		destroy_skel =3D (void(*)(void *))local_storage_bench__get10_interleaved=
__destroy;
+		test_skel =3D (void *)get10_skel;
+		skel_bss_hits =3D &get10_skel->bss->hits;
+		skel_bss_important_hits =3D &get10_skel->bss->important_hits;
+		break;
+	case 100:
+		get100_skel =3D local_storage_bench__get100_interleaved__open_and_load();
+		local_storage_bench__get100_interleaved__attach(get100_skel);
+		destroy_skel =3D (void(*)(void *))local_storage_bench__get100_interleave=
d__destroy;
+		test_skel =3D (void *)get100_skel;
+		skel_bss_hits =3D &get100_skel->bss->hits;
+		skel_bss_important_hits =3D &get100_skel->bss->important_hits;
+		break;
+	case 1000:
+		get1000_skel =3D local_storage_bench__get1000_interleaved__open_and_load=
();
+		local_storage_bench__get1000_interleaved__attach(get1000_skel);
+		destroy_skel =3D (void(*)(void *))local_storage_bench__get1000_interleav=
ed__destroy;
+		test_skel =3D (void *)get1000_skel;
+		skel_bss_hits =3D &get1000_skel->bss->hits;
+		skel_bss_important_hits =3D &get1000_skel->bss->important_hits;
+		break;
+	default:
+		fprintf(stderr,
+			"got an invalid nr_maps in setup, does validate() need update?");
+		teardown();
+		exit(1);
+		break;
+	}
+}
+
+static void teardown(void)
+{
+	char path[100];
+	int i;
+
+	for (i =3D 0; i < args.nr_maps; i++) {
+		sprintf(path, MAP_PIN_PATTERN "_%04d", i);
+		unlink(path);
+	}
+
+	if (destroy_skel && test_skel)
+		destroy_skel(test_skel);
+}
+
+static void measure(struct bench_res *res)
+{
+	if (skel_bss_hits)
+		res->hits =3D atomic_swap(skel_bss_hits, 0);
+	if (skel_bss_important_hits)
+		res->important_hits =3D atomic_swap(skel_bss_important_hits, 0);
+}
+
+static inline void trigger_bpf_program(void)
+{
+	syscall(__NR_getpgid);
+}
+
+static void *consumer(void *input)
+{
+	return NULL;
+}
+
+static void *producer(void *input)
+{
+	while (true)
+		trigger_bpf_program();
+
+	return NULL;
+}
+
+/* cache sequential and interleaved get benchs test local_storage get
+ * performance, specifically they demonstrate performance cliff of
+ * current list-plus-cache local_storage model.
+ *
+ * cache sequential get: call bpf_task_storage_get on n maps in order
+ * cache interleaved get: like "sequential get", but interleave 4 calls to=
 the
+ *	'important' map (local_storage_bench_pinned_0000) for every 10 calls. G=
oal
+ *	is to mimic environment where many progs are accessing their local_stor=
age
+ *	maps, with 'our' prog needing to access its map more often than others
+ */
+const struct bench bench_local_storage_cache_seq_get =3D {
+	.name =3D "local-storage-cache-seq-get",
+	.validate =3D validate,
+	.setup =3D local_storage_cache_get_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D local_storage_report_progress,
+	.report_final =3D local_storage_report_final,
+	.teardown =3D teardown,
+};
+
+const struct bench bench_local_storage_cache_interleaved_get =3D {
+	.name =3D "local-storage-cache-interleaved-get",
+	.validate =3D validate,
+	.setup =3D local_storage_cache_get_interleaved_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D local_storage_report_progress,
+	.report_final =3D local_storage_report_final,
+	.teardown =3D teardown,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_local_storage.sh =
b/tools/testing/selftests/bpf/benchs/run_bench_local_storage.sh
new file mode 100755
index 000000000000..a6f6f704cb7b
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_local_storage.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+header "Local Storage"
+for i in 10 100 1000; do
+subtitle "num_maps: $i"
+	summarize_local_storage "local_storage cache sequential  get: "\
+		"$(./bench --nr_maps $i local-storage-cache-seq-get)"
+	summarize_local_storage "local_storage cache interleaved get: "\
+		"$(./bench --nr_maps $i local-storage-cache-interleaved-get)"
+	printf "\n"
+done
diff --git a/tools/testing/selftests/bpf/benchs/run_common.sh b/tools/testi=
ng/selftests/bpf/benchs/run_common.sh
index 6c5e6023a69f..d9f40af82006 100644
--- a/tools/testing/selftests/bpf/benchs/run_common.sh
+++ b/tools/testing/selftests/bpf/benchs/run_common.sh
@@ -41,6 +41,16 @@ function ops()
 	echo "$*" | sed -E "s/.*latency\s+([0-9]+\.[0-9]+\sns\/op).*/\1/"
 }
=20
+function local_storage()
+{
+	echo -n "hits throughput: "
+	echo -n "$*" | sed -E "s/.* hits throughput\s+([0-9]+\.[0-9]+ =C2=B1 [0-9=
]+\.[0-9]+\sM\sops\/s).*/\1/"
+	echo -n -e ", hits latency: "
+	echo -n "$*" | sed -E "s/.* hits latency\s+([0-9]+\.[0-9]+\sns\/op).*/\1/"
+	echo -n ", important_hits throughput: "
+	echo "$*" | sed -E "s/.*important_hits throughput\s+([0-9]+\.[0-9]+ =C2=
=B1 [0-9]+\.[0-9]+\sM\sops\/s).*/\1/"
+}
+
 function total()
 {
 	echo "$*" | sed -E "s/.*total operations\s+([0-9]+\.[0-9]+ =C2=B1 [0-9]+\=
.[0-9]+M\/s).*/\1/"
@@ -67,6 +77,13 @@ function summarize_ops()
 	printf "%-20s %s\n" "$bench" "$(ops $summary)"
 }
=20
+function summarize_local_storage()
+{
+	bench=3D"$1"
+	summary=3D$(echo $2 | tail -n1)
+	printf "%-20s %s\n" "$bench" "$(local_storage $summary)"
+}
+
 function summarize_total()
 {
 	bench=3D"$1"
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__create_=
map.c b/tools/testing/selftests/bpf/progs/local_storage_bench__create_map.c
new file mode 100644
index 000000000000..786465a79e9e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__create_map.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct { \
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE); \
+	__uint(map_flags, BPF_F_NO_PREALLOC); \
+	__type(key, int); \
+	__type(value, __u32); \
+} map_to_pin SEC(".maps");
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get10.c=
 b/tools/testing/selftests/bpf/progs/local_storage_bench__get10.c
new file mode 100644
index 000000000000..75f50f961654
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get10.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "local_storage_bench_helpers.h"
+
+long important_hits =3D 0;
+long hits =3D 0;
+
+/* Create maps local_storage_bench_pinned_{0000, .., 0009} */
+PINNED_MAP10(0, 0, 0);
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int do_map_get(void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	TASK_STORAGE_GET10(0, 0, 0);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get100.=
c b/tools/testing/selftests/bpf/progs/local_storage_bench__get100.c
new file mode 100644
index 000000000000..64b5985b275d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get100.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "local_storage_bench_helpers.h"
+
+long important_hits =3D 0;
+long hits =3D 0;
+
+/* Create maps local_storage_bench_pinned_{0000, .., 0099} */
+PINNED_MAP100(0, 0);
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int do_map_get(void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	TASK_STORAGE_GET10(0, 0, 0);
+	TASK_STORAGE_GET10(0, 0, 1);
+	TASK_STORAGE_GET10(0, 0, 2);
+	TASK_STORAGE_GET10(0, 0, 3);
+	TASK_STORAGE_GET10(0, 0, 4);
+	return 0;
+}
+
+/* Need to access maps in diff progs to work around verifier MAX_USED_MAPS=
 */
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int do_map_get2(void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	TASK_STORAGE_GET10(0, 0, 5);
+	TASK_STORAGE_GET10(0, 0, 6);
+	TASK_STORAGE_GET10(0, 0, 7);
+	TASK_STORAGE_GET10(0, 0, 8);
+	TASK_STORAGE_GET10(0, 0, 9);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get1000=
.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get1000.c
new file mode 100644
index 000000000000..0558c0063703
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get1000.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "local_storage_bench_helpers.h"
+
+#define TASK_STORAGE_GET_FUNC_FIRST50(name, thous, hun) \
+SEC("fentry/" SYS_PREFIX "sys_getpgid") \
+int name(void *ctx) \
+{ \
+	struct task_struct *task =3D bpf_get_current_task_btf(); \
+	TASK_STORAGE_GET10(thous, hun, 0); \
+	TASK_STORAGE_GET10(thous, hun, 1); \
+	TASK_STORAGE_GET10(thous, hun, 2); \
+	TASK_STORAGE_GET10(thous, hun, 3); \
+	TASK_STORAGE_GET10(thous, hun, 4); \
+	return 0; \
+}
+
+#define TASK_STORAGE_GET_FUNC_LAST50(name, thous, hun) \
+SEC("fentry/" SYS_PREFIX "sys_getpgid") \
+int name(void *ctx) \
+{ \
+	struct task_struct *task =3D bpf_get_current_task_btf(); \
+	TASK_STORAGE_GET10(thous, hun, 5); \
+	TASK_STORAGE_GET10(thous, hun, 6); \
+	TASK_STORAGE_GET10(thous, hun, 7); \
+	TASK_STORAGE_GET10(thous, hun, 8); \
+	TASK_STORAGE_GET10(thous, hun, 9); \
+	return 0; \
+}
+
+#define TASK_STORAGE_GET_FUNC_100(name, thous, hun) \
+	TASK_STORAGE_GET_FUNC_FIRST50(name ## _first, thous, hun); \
+	TASK_STORAGE_GET_FUNC_FIRST50(name ##  _last, thous, hun);
+
+long important_hits =3D 0;
+long hits =3D 0;
+
+/* Create maps local_storage_bench_pinned_{0000, .., 0999} */
+PINNED_MAP1000(0);
+
+TASK_STORAGE_GET_FUNC_100(do_map_get_000, 0, 0);
+TASK_STORAGE_GET_FUNC_100(do_map_get_100, 0, 1);
+TASK_STORAGE_GET_FUNC_100(do_map_get_200, 0, 2);
+TASK_STORAGE_GET_FUNC_100(do_map_get_300, 0, 3);
+TASK_STORAGE_GET_FUNC_100(do_map_get_400, 0, 4);
+TASK_STORAGE_GET_FUNC_100(do_map_get_500, 0, 5);
+TASK_STORAGE_GET_FUNC_100(do_map_get_600, 0, 6);
+TASK_STORAGE_GET_FUNC_100(do_map_get_700, 0, 7);
+TASK_STORAGE_GET_FUNC_100(do_map_get_800, 0, 8);
+TASK_STORAGE_GET_FUNC_100(do_map_get_900, 0, 9);
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get1000=
_interleaved.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get=
1000_interleaved.c
new file mode 100644
index 000000000000..fbcdcdfe3056
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get1000_interl=
eaved.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "local_storage_bench_helpers.h"
+
+#define TASK_STORAGE_GET_FUNC_FIRST50(name, thous, hun) \
+SEC("fentry/" SYS_PREFIX "sys_getpgid") \
+int name(void *ctx) \
+{ \
+	struct task_struct *task =3D bpf_get_current_task_btf(); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 0); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 1); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 2); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 3); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 4); \
+	return 0; \
+}
+
+#define TASK_STORAGE_GET_FUNC_LAST50(name, thous, hun) \
+SEC("fentry/" SYS_PREFIX "sys_getpgid") \
+int name(void *ctx) \
+{ \
+	struct task_struct *task =3D bpf_get_current_task_btf(); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 5); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 6); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 7); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 8); \
+	TASK_STORAGE_GET10_INTERLEAVED(thous, hun, 9); \
+	return 0; \
+}
+
+#define TASK_STORAGE_GET_FUNC_100(name, thous, hun) \
+	TASK_STORAGE_GET_FUNC_FIRST50(name ## _first, thous, hun); \
+	TASK_STORAGE_GET_FUNC_FIRST50(name ##  _last, thous, hun);
+
+long important_hits =3D 0;
+long hits =3D 0;
+
+/* Create maps local_storage_bench_pinned_{0000, .., 0999} */
+PINNED_MAP1000(0);
+
+TASK_STORAGE_GET_FUNC_100(do_map_get_000, 0, 0);
+TASK_STORAGE_GET_FUNC_100(do_map_get_100, 0, 1);
+TASK_STORAGE_GET_FUNC_100(do_map_get_200, 0, 2);
+TASK_STORAGE_GET_FUNC_100(do_map_get_300, 0, 3);
+TASK_STORAGE_GET_FUNC_100(do_map_get_400, 0, 4);
+TASK_STORAGE_GET_FUNC_100(do_map_get_500, 0, 5);
+TASK_STORAGE_GET_FUNC_100(do_map_get_600, 0, 6);
+TASK_STORAGE_GET_FUNC_100(do_map_get_700, 0, 7);
+TASK_STORAGE_GET_FUNC_100(do_map_get_800, 0, 8);
+TASK_STORAGE_GET_FUNC_100(do_map_get_900, 0, 9);
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get100_=
interleaved.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get1=
00_interleaved.c
new file mode 100644
index 000000000000..337e3fbd2663
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get100_interle=
aved.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "local_storage_bench_helpers.h"
+
+long important_hits =3D 0;
+long hits =3D 0;
+
+/* Create maps local_storage_bench_pinned_{0000, .., 0099} */
+PINNED_MAP100(0, 0);
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int do_map_get(void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 0);
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 1);
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 2);
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 3);
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 4);
+	return 0;
+}
+
+/* Need to access maps in diff progs to work around verifier MAX_USED_MAPS=
 */
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int do_map_get2(void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 5);
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 6);
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 7);
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 8);
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 9);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get10_i=
nterleaved.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get10=
_interleaved.c
new file mode 100644
index 000000000000..26af26c29738
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get10_interlea=
ved.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "local_storage_bench_helpers.h"
+
+long important_hits =3D 0;
+long hits =3D 0;
+
+/* Create maps local_storage_bench_pinned_{0000, .., 0009} */
+PINNED_MAP10(0, 0, 0);
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int do_map_get(void *ctx)
+{
+	struct task_struct *task =3D bpf_get_current_task_btf();
+
+	TASK_STORAGE_GET10_INTERLEAVED(0, 0, 0);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench_helpers.=
h b/tools/testing/selftests/bpf/progs/local_storage_bench_helpers.h
new file mode 100644
index 000000000000..25e8a0a7f9a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench_helpers.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <bpf/bpf_helpers.h>
+
+#define PINNED_MAP(thous, hun, ten, one) \
+struct { \
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE); \
+	__uint(map_flags, BPF_F_NO_PREALLOC); \
+	__type(key, int); \
+	__type(value, __u32); \
+	__uint(pinning, LIBBPF_PIN_BY_NAME); \
+} local_storage_bench_pinned_ ## thous ## hun ## ten ## one SEC(".maps");
+
+#define PINNED_MAP10(thous, hun, ten) \
+	PINNED_MAP(thous, hun, ten, 0); \
+	PINNED_MAP(thous, hun, ten, 1); \
+	PINNED_MAP(thous, hun, ten, 2); \
+	PINNED_MAP(thous, hun, ten, 3); \
+	PINNED_MAP(thous, hun, ten, 4); \
+	PINNED_MAP(thous, hun, ten, 5); \
+	PINNED_MAP(thous, hun, ten, 6); \
+	PINNED_MAP(thous, hun, ten, 7); \
+	PINNED_MAP(thous, hun, ten, 8); \
+	PINNED_MAP(thous, hun, ten, 9);
+
+#define PINNED_MAP100(thous, hun) \
+	PINNED_MAP10(thous, hun, 0); \
+	PINNED_MAP10(thous, hun, 1); \
+	PINNED_MAP10(thous, hun, 2); \
+	PINNED_MAP10(thous, hun, 3); \
+	PINNED_MAP10(thous, hun, 4); \
+	PINNED_MAP10(thous, hun, 5); \
+	PINNED_MAP10(thous, hun, 6); \
+	PINNED_MAP10(thous, hun, 7); \
+	PINNED_MAP10(thous, hun, 8); \
+	PINNED_MAP10(thous, hun, 9);
+
+#define PINNED_MAP1000(thous) \
+	PINNED_MAP100(thous, 0); \
+	PINNED_MAP100(thous, 1); \
+	PINNED_MAP100(thous, 2); \
+	PINNED_MAP100(thous, 3); \
+	PINNED_MAP100(thous, 4); \
+	PINNED_MAP100(thous, 5); \
+	PINNED_MAP100(thous, 6); \
+	PINNED_MAP100(thous, 7); \
+	PINNED_MAP100(thous, 8); \
+	PINNED_MAP100(thous, 9);
+
+#define TASK_STORAGE_GET(thous, hun, ten, one) \
+({ \
+	bpf_task_storage_get(&local_storage_bench_pinned_ ## thous ## hun ## ten =
## one, task, 0, BPF_LOCAL_STORAGE_GET_F_CREATE) ; \
+	__sync_add_and_fetch(&hits, 1); \
+	if (!thous && !hun && !ten && !one) \
+		__sync_add_and_fetch(&important_hits, 1); \
+})
+
+#define TASK_STORAGE_GET10(thous, hun, ten) \
+	TASK_STORAGE_GET(thous, hun, ten, 0); \
+	TASK_STORAGE_GET(thous, hun, ten, 1); \
+	TASK_STORAGE_GET(thous, hun, ten, 2); \
+	TASK_STORAGE_GET(thous, hun, ten, 3); \
+	TASK_STORAGE_GET(thous, hun, ten, 4); \
+	TASK_STORAGE_GET(thous, hun, ten, 5); \
+	TASK_STORAGE_GET(thous, hun, ten, 6); \
+	TASK_STORAGE_GET(thous, hun, ten, 7); \
+	TASK_STORAGE_GET(thous, hun, ten, 8); \
+	TASK_STORAGE_GET(thous, hun, ten, 9);
+
+#define TASK_STORAGE_GET10_INTERLEAVED(thous, hun, ten) \
+	TASK_STORAGE_GET(thous, hun, ten, 0); \
+	TASK_STORAGE_GET(0, 0, 0, 0); \
+	TASK_STORAGE_GET(thous, hun, ten, 1); \
+	TASK_STORAGE_GET(thous, hun, ten, 2); \
+	TASK_STORAGE_GET(0, 0, 0, 0); \
+	TASK_STORAGE_GET(thous, hun, ten, 3); \
+	TASK_STORAGE_GET(thous, hun, ten, 4); \
+	TASK_STORAGE_GET(thous, hun, ten, 5); \
+	TASK_STORAGE_GET(0, 0, 0, 0); \
+	TASK_STORAGE_GET(thous, hun, ten, 6); \
+	TASK_STORAGE_GET(thous, hun, ten, 7); \
+	TASK_STORAGE_GET(0, 0, 0, 0); \
+	TASK_STORAGE_GET(thous, hun, ten, 8); \
+	TASK_STORAGE_GET(thous, hun, ten, 9); \
--=20
2.30.2

