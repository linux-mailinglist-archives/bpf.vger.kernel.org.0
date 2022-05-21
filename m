Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E652F8C8
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 07:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbiEUFAN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 May 2022 01:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiEUFAM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 May 2022 01:00:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74A16D13E
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 22:00:09 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24L3Y0v0013951
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 22:00:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=RKavV8KCrhYDTAVVfP0qjPcpJr9GGSIDZ3vhY/33ji4=;
 b=Al3FpUVz3Ynf1C1f2eqFIarT4TCNy3Youp8yDem5JH8ArMIwJ6SL3bNWodKgHvQf/ET5
 IrQ4CG+fyx0E0l25CRBGsXpKL3r5EDQjUA7SJH/660gUcQsr1apxfRX5C+PJYznfHtW0
 PSvuiifuhMeCnN8n2AaJt/nLXjV5N1T+xbk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g59tc06t1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 22:00:09 -0700
Received: from twshared24024.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 20 May 2022 22:00:06 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id A582B7F27952; Fri, 20 May 2022 21:59:59 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next] selftests/bpf: Add benchmark for local_storage get
Date:   Fri, 20 May 2022 21:59:58 -0700
Message-ID: <20220521045958.3405148-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: H5hssHHgJxAA8o62p0ihsvTDaXjLYXRN
X-Proofpoint-GUID: H5hssHHgJxAA8o62p0ihsvTDaXjLYXRN
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_08,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
hashmap (control) sequential    get:  hits throughput: 69.649 =C2=B1 1.207 =
M ops/s, hits latency: 14.358 ns/op, important_hits throughput: 0.139 =C2=
=B1 0.002 M ops/s

        num_maps: 1
local_storage cache sequential  get:  hits throughput: 3.849 =C2=B1 0.035 M=
 ops/s, hits latency: 259.803 ns/op, important_hits throughput: 3.849 =C2=
=B1 0.035 M ops/s
local_storage cache interleaved get:  hits throughput: 6.881 =C2=B1 0.110 M=
 ops/s, hits latency: 145.324 ns/op, important_hits throughput: 6.881 =C2=
=B1 0.110 M ops/s

        num_maps: 10
local_storage cache sequential  get:  hits throughput: 20.339 =C2=B1 0.442 =
M ops/s, hits latency: 49.167 ns/op, important_hits throughput: 2.034 =C2=
=B1 0.044 M ops/s
local_storage cache interleaved get:  hits throughput: 22.408 =C2=B1 0.606 =
M ops/s, hits latency: 44.627 ns/op, important_hits throughput: 8.003 =C2=
=B1 0.217 M ops/s

        num_maps: 16
local_storage cache sequential  get:  hits throughput: 24.428 =C2=B1 1.120 =
M ops/s, hits latency: 40.937 ns/op, important_hits throughput: 1.527 =C2=
=B1 0.070 M ops/s
local_storage cache interleaved get:  hits throughput: 26.853 =C2=B1 0.825 =
M ops/s, hits latency: 37.240 ns/op, important_hits throughput: 8.544 =C2=
=B1 0.262 M ops/s

        num_maps: 17
local_storage cache sequential  get:  hits throughput: 24.158 =C2=B1 0.222 =
M ops/s, hits latency: 41.394 ns/op, important_hits throughput: 1.421 =C2=
=B1 0.013 M ops/s
local_storage cache interleaved get:  hits throughput: 26.223 =C2=B1 0.201 =
M ops/s, hits latency: 38.134 ns/op, important_hits throughput: 7.981 =C2=
=B1 0.061 M ops/s

        num_maps: 24
local_storage cache sequential  get:  hits throughput: 16.820 =C2=B1 0.294 =
M ops/s, hits latency: 59.451 ns/op, important_hits throughput: 0.701 =C2=
=B1 0.012 M ops/s
local_storage cache interleaved get:  hits throughput: 19.185 =C2=B1 0.212 =
M ops/s, hits latency: 52.125 ns/op, important_hits throughput: 5.396 =C2=
=B1 0.060 M ops/s

        num_maps: 32
local_storage cache sequential  get:  hits throughput: 11.998 =C2=B1 0.310 =
M ops/s, hits latency: 83.347 ns/op, important_hits throughput: 0.375 =C2=
=B1 0.010 M ops/s
local_storage cache interleaved get:  hits throughput: 14.233 =C2=B1 0.265 =
M ops/s, hits latency: 70.259 ns/op, important_hits throughput: 3.972 =C2=
=B1 0.074 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 5.780 =C2=B1 0.250 M=
 ops/s, hits latency: 173.003 ns/op, important_hits throughput: 0.058 =C2=
=B1 0.002 M ops/s
local_storage cache interleaved get:  hits throughput: 7.175 =C2=B1 0.312 M=
 ops/s, hits latency: 139.381 ns/op, important_hits throughput: 1.874 =C2=
=B1 0.081 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 0.456 =C2=B1 0.011 M=
 ops/s, hits latency: 2192.982 ns/op, important_hits throughput: 0.000 =C2=
=B1 0.000 M ops/s
local_storage cache interleaved get:  hits throughput: 0.539 =C2=B1 0.005 M=
 ops/s, hits latency: 1855.508 ns/op, important_hits throughput: 0.135 =C2=
=B1 0.001 M ops/s

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

As evidenced by the unintuitive-looking results for smaller num_maps
benchmark runs, overhead which is amortized across larger num_maps runs
dominates when there are fewer maps. To get a sense of the overhead, I
commented out bpf_task_storage_get/bpf_map_lookup_elem in
local_storage_bench.h and ran the benchmark on the same host as the
'real' run. Results:

Local Storage
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        Hashmap Control w/ 500 maps
hashmap (control) sequential    get:  hits throughput: 128.699 =C2=B1 1.267=
 M ops/s, hits latency: 7.770 ns/op, important_hits throughput: 0.257 =C2=
=B1 0.003 M ops/s

        num_maps: 1
local_storage cache sequential  get:  hits throughput: 4.135 =C2=B1 0.069 M=
 ops/s, hits latency: 241.831 ns/op, important_hits throughput: 4.135 =C2=
=B1 0.069 M ops/s
local_storage cache interleaved get:  hits throughput: 7.693 =C2=B1 0.039 M=
 ops/s, hits latency: 129.982 ns/op, important_hits throughput: 7.693 =C2=
=B1 0.039 M ops/s

        num_maps: 10
local_storage cache sequential  get:  hits throughput: 33.044 =C2=B1 0.232 =
M ops/s, hits latency: 30.262 ns/op, important_hits throughput: 3.304 =C2=
=B1 0.023 M ops/s
local_storage cache interleaved get:  hits throughput: 36.525 =C2=B1 1.545 =
M ops/s, hits latency: 27.378 ns/op, important_hits throughput: 13.045 =C2=
=B1 0.552 M ops/s

        num_maps: 16
local_storage cache sequential  get:  hits throughput: 45.502 =C2=B1 1.429 =
M ops/s, hits latency: 21.977 ns/op, important_hits throughput: 2.844 =C2=
=B1 0.089 M ops/s
local_storage cache interleaved get:  hits throughput: 47.741 =C2=B1 1.115 =
M ops/s, hits latency: 20.946 ns/op, important_hits throughput: 15.190 =C2=
=B1 0.355 M ops/s

        num_maps: 17
local_storage cache sequential  get:  hits throughput: 47.177 =C2=B1 0.617 =
M ops/s, hits latency: 21.197 ns/op, important_hits throughput: 2.775 =C2=
=B1 0.036 M ops/s
local_storage cache interleaved get:  hits throughput: 50.005 =C2=B1 0.463 =
M ops/s, hits latency: 19.998 ns/op, important_hits throughput: 15.219 =C2=
=B1 0.141 M ops/s

        num_maps: 24
local_storage cache sequential  get:  hits throughput: 58.076 =C2=B1 0.507 =
M ops/s, hits latency: 17.219 ns/op, important_hits throughput: 2.420 =C2=
=B1 0.021 M ops/s
local_storage cache interleaved get:  hits throughput: 57.731 =C2=B1 0.500 =
M ops/s, hits latency: 17.322 ns/op, important_hits throughput: 16.237 =C2=
=B1 0.141 M ops/s

        num_maps: 32
local_storage cache sequential  get:  hits throughput: 68.266 =C2=B1 0.234 =
M ops/s, hits latency: 14.649 ns/op, important_hits throughput: 2.133 =C2=
=B1 0.007 M ops/s
local_storage cache interleaved get:  hits throughput: 62.138 =C2=B1 2.695 =
M ops/s, hits latency: 16.093 ns/op, important_hits throughput: 17.341 =C2=
=B1 0.752 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 103.735 =C2=B1 2.874=
 M ops/s, hits latency: 9.640 ns/op, important_hits throughput: 1.037 =C2=
=B1 0.029 M ops/s
local_storage cache interleaved get:  hits throughput: 85.950 =C2=B1 1.619 =
M ops/s, hits latency: 11.635 ns/op, important_hits throughput: 22.450 =C2=
=B1 0.423 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 133.551 =C2=B1 1.915=
 M ops/s, hits latency: 7.488 ns/op, important_hits throughput: 0.134 =C2=
=B1 0.002 M ops/s
local_storage cache interleaved get:  hits throughput: 97.579 =C2=B1 1.415 =
M ops/s, hits latency: 10.248 ns/op, important_hits throughput: 24.505 =C2=
=B1 0.355 M ops/s

Adjusting for overhead, latency numbers for "hashmap control" and "sequenti=
al get" are:

hashmap_control:     ~6.6ns
sequential_get_1:    ~17.9ns
sequential_get_10:   ~18.9ns
sequential_get_16:   ~19.0ns
sequential_get_17:   ~20.2ns
sequential_get_24:   ~42.2ns
sequential_get_32:   ~68.7ns
sequential_get_100:  ~163.3ns
sequential_get_1000: ~2200ns

Clearly demonstrating a cliff.

When running the benchmarks it may be necessary to bump 'open files'
ulimit for a successful run.

  [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@=
fb.com

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
Changelog:

v2 -> v3:
  * Accessing 1k maps in ARRAY_OF_MAPS doesn't hit MAX_USED_MAPS limit,
	  so just use 1 program (Alexei)

v1 -> v2:
  * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
    configurable # of maps (Andrii)
  * Add hashmap benchmark (Alexei)
	* Add discussion of overhead

 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/bench.c           |  57 +++
 tools/testing/selftests/bpf/bench.h           |   5 +
 .../bpf/benchs/bench_local_storage.c          | 332 ++++++++++++++++++
 .../bpf/benchs/run_bench_local_storage.sh     |  21 ++
 .../selftests/bpf/benchs/run_common.sh        |  17 +
 .../selftests/bpf/progs/local_storage_bench.h |  63 ++++
 .../bpf/progs/local_storage_bench__get_int.c  |  12 +
 .../bpf/progs/local_storage_bench__get_seq.c  |  12 +
 .../bpf/progs/local_storage_bench__hashmap.c  |  13 +
 10 files changed, 537 insertions(+), 1 deletion(-)
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
index 000000000000..96bc91f1f994
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
@@ -0,0 +1,332 @@
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
+
+static struct {
+	void (*destroy_skel)(void *obj);
+	int (*load_skel)(void *obj);
+	long *important_hits;
+	long *hits;
+	void *progs;
+	void *skel;
+	struct bpf_map *array_of_maps;
+	struct bpf_link *attached_prog;
+	int created_maps[MAX_NR_MAPS];
+} ctx;
+
+static void teardown(void)
+{
+	int i;
+
+	bpf_link__detach(ctx.attached_prog);
+
+	if (ctx.destroy_skel && ctx.skel)
+		ctx.destroy_skel(ctx.skel);
+
+	for (i =3D 0; i < MAX_NR_MAPS; i++) {
+		if (!ctx.created_maps[i])
+			break;
+		close(ctx.created_maps[i]);
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
+static void __setup(struct bpf_program *prog, bool hashmap)
+{
+	int i, fd, mim_fd, err;
+	int btf_fd =3D 0;
+
+	LIBBPF_OPTS(bpf_map_create_opts, create_opts);
+
+	memset(&ctx.created_maps, 0, MAX_NR_MAPS * sizeof(int));
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
+					    sizeof(int), 65536, &create_opts);
+		else
+			fd =3D bpf_map_create(BPF_MAP_TYPE_TASK_STORAGE, NULL, sizeof(int),
+					    sizeof(int), 0, &create_opts);
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
+		ctx.created_maps[i] =3D fd;
+	}
+	close(btf_fd);
+
+	ctx.attached_prog =3D bpf_program__attach(prog);
+	if (!ctx.attached_prog) {
+		fprintf(stderr, "Error attaching bpf program\n");
+		goto err_out;
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
+	__setup(skel->progs.get_local, true);
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
+	__setup(skel->progs.get_local, false);
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
+	__setup(skel->progs.get_local, false);
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
index 000000000000..88ccfe178641
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench.h
@@ -0,0 +1,63 @@
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
+#define TASK_STORAGE_GET_LOOP_PROG(interleave)			\
+SEC("fentry/" SYS_PREFIX "sys_getpgid")			\
+int get_local(void *ctx)					\
+{								\
+	struct task_struct *task;				\
+	unsigned int i;						\
+	void *map;						\
+								\
+	task =3D bpf_get_current_task_btf();			\
+	for (i =3D 0; i < 1000; i++) {				\
+		if (do_lookup(i, task))				\
+			return 0;				\
+		if (interleave && i % 3 =3D=3D 0)			\
+			do_lookup(0, task);			\
+	}							\
+	return 0;						\
+}
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get_int=
.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get_int.c
new file mode 100644
index 000000000000..c45da01c026d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get_int.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#include "local_storage_bench.h"
+
+TASK_STORAGE_GET_LOOP_PROG(true);
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__get_seq=
.c b/tools/testing/selftests/bpf/progs/local_storage_bench__get_seq.c
new file mode 100644
index 000000000000..076d54e5dbdf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__get_seq.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#include "local_storage_bench.h"
+
+TASK_STORAGE_GET_LOOP_PROG(false);
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench__hashmap=
.c b/tools/testing/selftests/bpf/progs/local_storage_bench__hashmap.c
new file mode 100644
index 000000000000..4e199479bc9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench__hashmap.c
@@ -0,0 +1,13 @@
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
+TASK_STORAGE_GET_LOOP_PROG(false);
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

