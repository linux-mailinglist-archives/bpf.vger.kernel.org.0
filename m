Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB89852B0E9
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 05:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiERDwF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 23:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiERDvz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 23:51:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B878E182
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 20:51:46 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24I0JDqC007863
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 20:51:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=9Z9pQZrtmCjnUm3zIFNeRpxz1xNzrxKZFYNX6hde2fc=;
 b=L34+ZDdtBX85bn2kG04R/091uDIcEquwF96mrJo3pbYbwg5fqOVfDebEIIguVazch6oH
 HqU+Bngi9elABKTJuMUF5sRshqQ3+RO9TOBNEA3YrS/oyrie3J3owFkS6nzfSzwW/O6Y
 zyUevPlfvFJwMZLG0z+FpUrbHNqYaKhP25Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g4836pye4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 20:51:44 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 20:51:44 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 5EB217CCE1F5; Tue, 17 May 2022 20:51:35 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: Add benchmark for local_storage get
Date:   Tue, 17 May 2022 20:51:31 -0700
Message-ID: <20220518035131.725193-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: BwMuKx503UNluB4IV2hJqVwLiHln8M7S
X-Proofpoint-ORIG-GUID: BwMuKx503UNluB4IV2hJqVwLiHln8M7S
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_01,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
which do many bpf_task_storage_get calls on sets of task local_storage
maps of various counts, while considering a single specific map to be
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

A "hashmap control" benchmark is also included for easy comparison of
standard bpf hashmap lookup vs local_storage get. The benchmark is
identical to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
instead of local storage.

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
        Hashmap Control w/ 500 maps
hashmap (control) sequential    get:  hits throughput: 64.689 =C2=B1 2.806 =
M ops/s, hits latency: 15.459 ns/op, important_hits throughput: 0.129 =C2=
=B1 0.006 M ops/s

        num_maps: 1
local_storage cache sequential  get:  hits throughput: 3.793 =C2=B1 0.101 M=
 ops/s, hits latency: 263.623 ns/op, important_hits throughput: 3.793 =C2=
=B1 0.101 M ops/s
local_storage cache interleaved get:  hits throughput: 6.539 =C2=B1 0.209 M=
 ops/s, hits latency: 152.938 ns/op, important_hits throughput: 6.539 =C2=
=B1 0.209 M ops/s

        num_maps: 10
local_storage cache sequential  get:  hits throughput: 20.237 =C2=B1 0.439 =
M ops/s, hits latency: 49.415 ns/op, important_hits throughput: 2.024 =C2=
=B1 0.044 M ops/s
local_storage cache interleaved get:  hits throughput: 22.421 =C2=B1 0.874 =
M ops/s, hits latency: 44.601 ns/op, important_hits throughput: 8.007 =C2=
=B1 0.312 M ops/s

        num_maps: 16
local_storage cache sequential  get:  hits throughput: 25.582 =C2=B1 0.346 =
M ops/s, hits latency: 39.090 ns/op, important_hits throughput: 1.599 =C2=
=B1 0.022 M ops/s
local_storage cache interleaved get:  hits throughput: 26.615 =C2=B1 0.601 =
M ops/s, hits latency: 37.573 ns/op, important_hits throughput: 8.468 =C2=
=B1 0.191 M ops/s

        num_maps: 17
local_storage cache sequential  get:  hits throughput: 22.932 =C2=B1 0.436 =
M ops/s, hits latency: 43.606 ns/op, important_hits throughput: 1.349 =C2=
=B1 0.026 M ops/s
local_storage cache interleaved get:  hits throughput: 24.005 =C2=B1 0.462 =
M ops/s, hits latency: 41.658 ns/op, important_hits throughput: 7.306 =C2=
=B1 0.140 M ops/s

        num_maps: 24
local_storage cache sequential  get:  hits throughput: 16.025 =C2=B1 0.821 =
M ops/s, hits latency: 62.402 ns/op, important_hits throughput: 0.668 =C2=
=B1 0.034 M ops/s
local_storage cache interleaved get:  hits throughput: 17.691 =C2=B1 0.744 =
M ops/s, hits latency: 56.526 ns/op, important_hits throughput: 4.976 =C2=
=B1 0.209 M ops/s

        num_maps: 32
local_storage cache sequential  get:  hits throughput: 11.865 =C2=B1 0.180 =
M ops/s, hits latency: 84.279 ns/op, important_hits throughput: 0.371 =C2=
=B1 0.006 M ops/s
local_storage cache interleaved get:  hits throughput: 14.383 =C2=B1 0.108 =
M ops/s, hits latency: 69.525 ns/op, important_hits throughput: 4.014 =C2=
=B1 0.030 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 6.105 =C2=B1 0.190 M=
 ops/s, hits latency: 163.798 ns/op, important_hits throughput: 0.061 =C2=
=B1 0.002 M ops/s
local_storage cache interleaved get:  hits throughput: 7.055 =C2=B1 0.129 M=
 ops/s, hits latency: 141.746 ns/op, important_hits throughput: 1.843 =C2=
=B1 0.034 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 0.433 =C2=B1 0.010 M=
 ops/s, hits latency: 2309.469 ns/op, important_hits throughput: 0.000 =C2=
=B1 0.000 M ops/s
local_storage cache interleaved get:  hits throughput: 0.499 =C2=B1 0.026 M=
 ops/s, hits latency: 2002.510 ns/op, important_hits throughput: 0.127 =C2=
=B1 0.007 M ops/s

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

Note that the test programs need to split task_storage_get calls across
multiple programs to work around the verifier's MAX_USED_MAPS
limitations. As evidenced by the unintuitive-looking results for smaller
num_maps benchmark runs, overhead which is amortized across larger
num_maps in other runs dominates when there are fewer maps. To get a
sense of the overhead, I commented out
bpf_task_storage_get/bpf_map_lookup_elem in local_storage_bench.h and
ran the benchmark on the same host as 'real' run. Results:

Local Storage
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        Hashmap Control w/ 500 maps
hashmap (control) sequential    get:  hits throughput: 115.812 =C2=B1 2.513=
 M ops/s, hits latency: 8.635 ns/op, important_hits throughput: 0.232 =C2=
=B1 0.005 M ops/s

        num_maps: 1
local_storage cache sequential  get:  hits throughput: 4.031 =C2=B1 0.033 M=
 ops/s, hits latency: 248.094 ns/op, important_hits throughput: 4.031 =C2=
=B1 0.033 M ops/s
local_storage cache interleaved get:  hits throughput: 7.997 =C2=B1 0.088 M=
 ops/s, hits latency: 125.046 ns/op, important_hits throughput: 7.997 =C2=
=B1 0.088 M ops/s

        num_maps: 10
local_storage cache sequential  get:  hits throughput: 34.000 =C2=B1 0.077 =
M ops/s, hits latency: 29.412 ns/op, important_hits throughput: 3.400 =C2=
=B1 0.008 M ops/s
local_storage cache interleaved get:  hits throughput: 37.895 =C2=B1 0.670 =
M ops/s, hits latency: 26.389 ns/op, important_hits throughput: 13.534 =C2=
=B1 0.239 M ops/s

        num_maps: 16
local_storage cache sequential  get:  hits throughput: 46.947 =C2=B1 0.283 =
M ops/s, hits latency: 21.300 ns/op, important_hits throughput: 2.934 =C2=
=B1 0.018 M ops/s
local_storage cache interleaved get:  hits throughput: 47.301 =C2=B1 1.027 =
M ops/s, hits latency: 21.141 ns/op, important_hits throughput: 15.050 =C2=
=B1 0.327 M ops/s

        num_maps: 17
local_storage cache sequential  get:  hits throughput: 45.871 =C2=B1 0.414 =
M ops/s, hits latency: 21.800 ns/op, important_hits throughput: 2.698 =C2=
=B1 0.024 M ops/s
local_storage cache interleaved get:  hits throughput: 46.591 =C2=B1 1.969 =
M ops/s, hits latency: 21.463 ns/op, important_hits throughput: 14.180 =C2=
=B1 0.599 M ops/s

        num_maps: 24
local_storage cache sequential  get:  hits throughput: 58.053 =C2=B1 1.043 =
M ops/s, hits latency: 17.226 ns/op, important_hits throughput: 2.419 =C2=
=B1 0.043 M ops/s
local_storage cache interleaved get:  hits throughput: 58.115 =C2=B1 0.377 =
M ops/s, hits latency: 17.207 ns/op, important_hits throughput: 16.345 =C2=
=B1 0.106 M ops/s

        num_maps: 32
local_storage cache sequential  get:  hits throughput: 68.548 =C2=B1 0.820 =
M ops/s, hits latency: 14.588 ns/op, important_hits throughput: 2.142 =C2=
=B1 0.026 M ops/s
local_storage cache interleaved get:  hits throughput: 63.015 =C2=B1 0.963 =
M ops/s, hits latency: 15.869 ns/op, important_hits throughput: 17.586 =C2=
=B1 0.269 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 95.375 =C2=B1 1.286 =
M ops/s, hits latency: 10.485 ns/op, important_hits throughput: 0.954 =C2=
=B1 0.013 M ops/s
local_storage cache interleaved get:  hits throughput: 76.996 =C2=B1 2.614 =
M ops/s, hits latency: 12.988 ns/op, important_hits throughput: 20.111 =C2=
=B1 0.683 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 119.965 =C2=B1 1.386=
 M ops/s, hits latency: 8.336 ns/op, important_hits throughput: 0.120 =C2=
=B1 0.001 M ops/s
local_storage cache interleaved get:  hits throughput: 92.665 =C2=B1 0.788 =
M ops/s, hits latency: 10.792 ns/op, important_hits throughput: 23.581 =C2=
=B1 0.200 M ops/s

Adjusting for overhead, latency numbers for "hashmap control" and "sequenti=
al get" are:

hashmap_control:     ~6.8ns
sequential_get_1:    ~15.5ns
sequential_get_10:   ~20ns
sequential_get_16:   ~17.8ns
sequential_get_17:   ~21.8ns
sequential_get_24:   ~45.2ns
sequential_get_32:   ~69.7ns
sequential_get_100:  ~153.3ns
sequential_get_1000: ~2300ns

Clearly demonstrating a cliff.

When running the benchmarks it may be necessary to bump 'open files'
ulimit for a successful run.

  [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@=
fb.com

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
Changelog:

v1 -> v2:
  * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
    configurable # of maps (Andrii)
  * Add hashmap benchmark (Alexei)
	* Add discussion of overhead

 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/bench.c           |  57 +++
 tools/testing/selftests/bpf/bench.h           |   5 +
 .../bpf/benchs/bench_local_storage.c          | 345 ++++++++++++++++++
 .../bpf/benchs/run_bench_local_storage.sh     |  21 ++
 .../selftests/bpf/benchs/run_common.sh        |  17 +
 .../selftests/bpf/progs/local_storage_bench.h |  69 ++++
 .../bpf/progs/local_storage_bench__get_int.c  |  31 ++
 .../bpf/progs/local_storage_bench__get_seq.c  |  31 ++
 .../bpf/progs/local_storage_bench__hashmap.c  |  32 ++
 10 files changed, 613 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_stor=
age.sh
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench.h
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
get_int.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
get_seq.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench__=
hashmap.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 4030dd6cbc34..6095f6af2ad1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -560,6 +560,9 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.ske=
l.h \
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
 $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
+$(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench__get_seq.sk=
el.h \
+				  $(OUTPUT)/local_storage_bench__get_int.skel.h \
+				  $(OUTPUT)/local_storage_bench__hashmap.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS +=3D -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -571,7 +574,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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
index f061cc20e776..71271062f68d 100644
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
@@ -396,6 +445,9 @@ extern const struct bench bench_hashmap_with_bloom;
 extern const struct bench bench_bpf_loop;
 extern const struct bench bench_strncmp_no_helper;
 extern const struct bench bench_strncmp_helper;
+extern const struct bench bench_local_storage_cache_seq_get;
+extern const struct bench bench_local_storage_cache_interleaved_get;
+extern const struct bench bench_local_storage_cache_hashmap_control;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -430,6 +482,9 @@ static const struct bench *benchs[] =3D {
 	&bench_bpf_loop,
 	&bench_strncmp_no_helper,
 	&bench_strncmp_helper,
+	&bench_local_storage_cache_seq_get,
+	&bench_local_storage_cache_interleaved_get,
+	&bench_local_storage_cache_hashmap_control,
 };
=20
 static void setup_benchmark()
@@ -547,5 +602,7 @@ int main(int argc, char **argv)
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
index 000000000000..1cf041b9448a
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <argp.h>
+#include <linux/btf.h>
+
+#include "local_storage_bench__get_int.skel.h"
+#include "local_storage_bench__get_seq.skel.h"
+#include "local_storage_bench__hashmap.skel.h"
+#include "bench.h"
+
+#include <test_btf.h>
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
+	if (args.nr_maps > 1000) {
+		fprintf(stderr, "nr_maps must be <=3D 1000\n");
+		exit(1);
+	}
+}
+
+/* Keep in sync w/ array of maps in bpf */
+#define MAX_NR_MAPS 1000
+/* Keep in sync w/ number of progs in bpf app */
+#define MAX_NR_PROGS 20
+
+static struct {
+	void (*destroy_skel)(void *obj);
+	int (*load_skel)(void *obj);
+	long *important_hits;
+	long *hits;
+	void *progs;
+	void *skel;
+	struct bpf_map *array_of_maps;
+} ctx;
+
+int created_maps[MAX_NR_MAPS];
+struct bpf_link *attached_links[MAX_NR_PROGS];
+
+static void teardown(void)
+{
+	int i;
+
+	for (i =3D 0; i < MAX_NR_PROGS; i++) {
+		if (!attached_links[i])
+			break;
+		bpf_link__detach(attached_links[i]);
+	}
+
+	if (ctx.destroy_skel && ctx.skel)
+		ctx.destroy_skel(ctx.skel);
+
+	for (i =3D 0; i < MAX_NR_MAPS; i++) {
+		if (!created_maps[i])
+			break;
+		close(created_maps[i]);
+	}
+}
+
+static int setup_inner_map_and_load(int inner_fd)
+{
+	int err, mim_fd;
+
+	err =3D bpf_map__set_inner_map_fd(ctx.array_of_maps, inner_fd);
+	if (err)
+		return -1;
+
+	err =3D ctx.load_skel(ctx.skel);
+	if (err)
+		return -1;
+
+	mim_fd =3D bpf_map__fd(ctx.array_of_maps);
+	if (mim_fd < 0)
+		return -1;
+
+	return mim_fd;
+}
+
+static int load_btf(void)
+{
+	static const char btf_str_sec[] =3D "\0";
+	__u32 btf_raw_types[] =3D {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+	};
+	struct btf_header btf_hdr =3D {
+		.magic =3D BTF_MAGIC,
+		.version =3D BTF_VERSION,
+		.hdr_len =3D sizeof(struct btf_header),
+		.type_len =3D sizeof(btf_raw_types),
+		.str_off =3D sizeof(btf_raw_types),
+		.str_len =3D sizeof(btf_str_sec),
+	};
+	__u8 raw_btf[sizeof(struct btf_header) + sizeof(btf_raw_types) +
+				sizeof(btf_str_sec)];
+
+	memcpy(raw_btf, &btf_hdr, sizeof(btf_hdr));
+	memcpy(raw_btf + sizeof(btf_hdr), btf_raw_types, sizeof(btf_raw_types));
+	memcpy(raw_btf + sizeof(btf_hdr) + sizeof(btf_raw_types),
+	       btf_str_sec, sizeof(btf_str_sec));
+
+	return bpf_btf_load(raw_btf, sizeof(raw_btf), NULL);
+}
+
+static void __setup(bool hashmap)
+{
+	struct bpf_program **prog;
+	uint32_t progs_to_attach;
+	int i, fd, mim_fd, err;
+	int btf_fd =3D 0;
+
+	LIBBPF_OPTS(bpf_map_create_opts, create_opts);
+
+	memset(&created_maps, 0, MAX_NR_MAPS * sizeof(int));
+	memset(&attached_links, 0, MAX_NR_PROGS * sizeof(void *));
+
+	btf_fd =3D load_btf();
+	create_opts.btf_fd =3D btf_fd;
+	create_opts.btf_key_type_id =3D 1;
+	create_opts.btf_value_type_id =3D 1;
+	if (!hashmap)
+		create_opts.map_flags =3D BPF_F_NO_PREALLOC;
+
+	mim_fd =3D 0;
+	for (i =3D 0; i < args.nr_maps; i++) {
+		if (hashmap)
+			fd =3D bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(int),
+							sizeof(int), 65536, &create_opts);
+		else
+			fd =3D bpf_map_create(BPF_MAP_TYPE_TASK_STORAGE, NULL, sizeof(int),
+							sizeof(int), 0, &create_opts);
+		if (fd < 0) {
+			fprintf(stderr, "Error creating map %d\n", i);
+			goto err_out;
+		}
+
+		if (i =3D=3D 0) {
+			mim_fd =3D setup_inner_map_and_load(fd);
+			if (mim_fd < 0) {
+				fprintf(stderr, "Error doing setup_inner_map_and_load\n");
+				goto err_out;
+			}
+		}
+
+		err =3D bpf_map_update_elem(mim_fd, &i, &fd, 0);
+		if (err) {
+			fprintf(stderr, "Error updating array-of-maps w/ map %d\n", i);
+			goto err_out;
+		}
+		created_maps[i] =3D fd;
+	}
+	close(btf_fd);
+
+	progs_to_attach =3D (args.nr_maps / 50);
+	if (args.nr_maps % 50)
+		progs_to_attach++;
+
+	for (i =3D 0; i < progs_to_attach; i++) {
+		prog =3D ctx.progs + i * sizeof(void *);
+		attached_links[i] =3D bpf_program__attach(*prog);
+	}
+
+	return;
+err_out:
+	if (btf_fd)
+		close(btf_fd);
+	teardown();
+	exit(1);
+}
+
+static void hashmap_setup(void)
+{
+	struct local_storage_bench__hashmap *skel;
+
+	setup_libbpf();
+
+	skel =3D local_storage_bench__hashmap__open();
+	ctx.skel =3D skel;
+	ctx.hits =3D &skel->bss->hits;
+	ctx.important_hits =3D &skel->bss->important_hits;
+	ctx.load_skel =3D (int (*)(void *))local_storage_bench__hashmap__load;
+	ctx.progs =3D (void *)&skel->progs;
+	ctx.destroy_skel =3D (void (*)(void *))local_storage_bench__hashmap__dest=
roy;
+	ctx.array_of_maps =3D skel->maps.array_of_maps;
+
+	__setup(true);
+}
+
+static void local_storage_cache_get_setup(void)
+{
+	struct local_storage_bench__get_seq *skel;
+
+	setup_libbpf();
+
+	skel =3D local_storage_bench__get_seq__open();
+	ctx.skel =3D skel;
+	ctx.hits =3D &skel->bss->hits;
+	ctx.important_hits =3D &skel->bss->important_hits;
+	ctx.load_skel =3D (int (*)(void *))local_storage_bench__get_seq__load;
+	ctx.progs =3D (void *)&skel->progs;
+	ctx.destroy_skel =3D (void (*)(void *))local_storage_bench__get_seq__dest=
roy;
+	ctx.array_of_maps =3D skel->maps.array_of_maps;
+
+	__setup(false);
+}
+
+static void local_storage_cache_get_interleaved_setup(void)
+{
+	struct local_storage_bench__get_int *skel;
+
+	setup_libbpf();
+
+	skel =3D local_storage_bench__get_int__open();
+	ctx.skel =3D skel;
+	ctx.hits =3D &skel->bss->hits;
+	ctx.important_hits =3D &skel->bss->important_hits;
+	ctx.load_skel =3D (int (*)(void *))local_storage_bench__get_int__load;
+	ctx.progs =3D (void *)&skel->progs;
+	ctx.destroy_skel =3D (void (*)(void *))local_storage_bench__get_int__dest=
roy;
+	ctx.array_of_maps =3D skel->maps.array_of_maps;
+
+	__setup(false);
+}
+
+static void measure(struct bench_res *res)
+{
+	if (ctx.hits)
+		res->hits =3D atomic_swap(ctx.hits, 0);
+	if (ctx.important_hits)
+		res->important_hits =3D atomic_swap(ctx.important_hits, 0);
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
+ *	'important' map (idx 0 in array_of_maps) for every 10 calls. Goal
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
+	.name =3D "local-storage-cache-int-get",
+	.validate =3D validate,
+	.setup =3D local_storage_cache_get_interleaved_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D local_storage_report_progress,
+	.report_final =3D local_storage_report_final,
+	.teardown =3D teardown,
+};
+
+const struct bench bench_local_storage_cache_hashmap_control =3D {
+	.name =3D "local-storage-cache-hashmap-control",
+	.validate =3D validate,
+	.setup =3D hashmap_setup,
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
index 000000000000..479096c47c93
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_local_storage.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+header "Local Storage"
+subtitle "Hashmap Control w/ 500 maps"
+	summarize_local_storage "hashmap (control) sequential    get: "\
+		"$(./bench --nr_maps 500 local-storage-cache-hashmap-control)"
+	printf "\n"
+
+for i in 1 10 16 17 24 32 100 1000; do
+subtitle "num_maps: $i"
+	summarize_local_storage "local_storage cache sequential  get: "\
+		"$(./bench --nr_maps $i local-storage-cache-seq-get)"
+	summarize_local_storage "local_storage cache interleaved get: "\
+		"$(./bench --nr_maps $i local-storage-cache-int-get)"
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
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench.h b/tool=
s/testing/selftests/bpf/progs/local_storage_bench.h
new file mode 100644
index 000000000000..b5e358dee245
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, int);
+} array_of_maps SEC(".maps");
+
+long important_hits;
+long hits;
+
+#ifdef LOOKUP_HASHMAP
+static int do_lookup(unsigned int elem, struct task_struct *task /* unused=
 */)
+{
+	void *map;
+	int zero =3D 0;
+
+	map =3D bpf_map_lookup_elem(&array_of_maps, &elem);
+	if (!map)
+		return -1;
+
+	bpf_map_lookup_elem(map, &zero);
+	__sync_add_and_fetch(&hits, 1);
+	if (!elem)
+		__sync_add_and_fetch(&important_hits, 1);
+	return 0;
+}
+#else
+static int do_lookup(unsigned int elem, struct task_struct *task)
+{
+	void *map;
+
+	map =3D bpf_map_lookup_elem(&array_of_maps, &elem);
+	if (!map)
+		return -1;
+
+	bpf_task_storage_get(map, task, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	__sync_add_and_fetch(&hits, 1);
+	if (!elem)
+		__sync_add_and_fetch(&important_hits, 1);
+	return 0;
+}
+#endif /* LOOKUP_HASHMAP */
+
+#define __TASK_STORAGE_GET_LOOP_PROG(array, start, interleave) \
+SEC("fentry/" SYS_PREFIX "sys_getpgid")			\
+int get_local_ ## start(void *ctx)				\
+{								\
+	struct task_struct *task;				\
+	unsigned int i, elem;					\
+	void *map;						\
+								\
+	task =3D bpf_get_current_task_btf();			\
+	for (i =3D 0; i < 50; i++) {				\
+		elem =3D start + i;				\
+		if (do_lookup(elem, task))			\
+			return 0;				\
+		if (interleave && i % 3 =3D=3D 0)			\
+			do_lookup(0, task);			\
+	}							\
+	return 0;						\
+}
+
+#define TASK_STORAGE_GET_LOOP_PROG_SEQ(array, start) \
+	__TASK_STORAGE_GET_LOOP_PROG(array, start, false)
+#define TASK_STORAGE_GET_LOOP_PROG_INT(array, start) \
+	__TASK_STORAGE_GET_LOOP_PROG(array, start, true)
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get_int=
.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get_int.c
new file mode 100644
index 000000000000..498f0c81014b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get_int.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#include "local_storage_bench.h"
+
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 0);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 50);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 100);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 150);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 200);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 250);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 300);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 350);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 400);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 450);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 500);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 550);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 600);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 650);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 700);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 750);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 800);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 850);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 900);
+TASK_STORAGE_GET_LOOP_PROG_INT(array_of_maps, 950);
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get_seq=
.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get_seq.c
new file mode 100644
index 000000000000..71514576a05d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get_seq.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#include "local_storage_bench.h"
+
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 0);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 50);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 100);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 150);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 200);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 250);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 300);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 350);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 400);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 450);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 500);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 550);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 600);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 650);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 700);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 750);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 800);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 850);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 900);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 950);
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__hashmap=
.c b/tools/testing/selftests/bpf/progs/local_storage_bench__hashmap.c
new file mode 100644
index 000000000000..15e4fe13d0b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__hashmap.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define LOOKUP_HASHMAP
+#include "local_storage_bench.h"
+
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 0);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 50);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 100);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 150);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 200);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 250);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 300);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 350);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 400);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 450);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 500);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 550);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 600);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 650);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 700);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 750);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 800);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 850);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 900);
+TASK_STORAGE_GET_LOOP_PROG_SEQ(array_of_maps, 950);
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

