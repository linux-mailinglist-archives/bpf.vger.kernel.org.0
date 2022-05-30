Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DD538839
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiE3U1a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 May 2022 16:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiE3U12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 16:27:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050C71DB4
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 13:27:25 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U3g7ch014378
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 13:27:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=UxEOjqn1Rx5yDl5kxyGJwUpkshHFf6fsnuX+jwONbPA=;
 b=DbICciPo0GOUWJFCHMvdTdyjyz/bUi4uWu2LkQEYJcjscI6YOm+ruTTT38+3TAewcowQ
 xJbm9XzSzDlXg4He8oxRjPJ99ym4oZhExiKvpWr4V0QFglO8jcOxYs9w857VLsOjjsUQ
 BoJrDAoc99lWTucO7zjOwyd8gOrf72fgJCw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbf2jjab9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 13:27:25 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 30 May 2022 13:27:23 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 1C57386006F0; Mon, 30 May 2022 13:27:12 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 1/2] selftests/bpf: Add benchmark for local_storage get
Date:   Mon, 30 May 2022 13:27:10 -0700
Message-ID: <20220530202711.2594486-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: cWcuzxDs4xQTqSuh4YpyL92ktdrUgE_i
X-Proofpoint-GUID: cWcuzxDs4xQTqSuh4YpyL92ktdrUgE_i
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-30_09,2022-05-30_03,2022-02-23_01
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
hashmap (control) sequential    get:  hits throughput: 48.338 =C2=B1 2.366 =
M ops/s, hits latency: 20.688 ns/op, important_hits throughput: 0.097 =C2=
=B1 0.005 M ops/s

        num_maps: 1
local_storage cache sequential  get:  hits throughput: 44.503 =C2=B1 1.080 =
M ops/s, hits latency: 22.470 ns/op, important_hits throughput: 44.503 =C2=
=B1 1.080 M ops/s
local_storage cache interleaved get:  hits throughput: 54.963 =C2=B1 0.586 =
M ops/s, hits latency: 18.194 ns/op, important_hits throughput: 54.963 =C2=
=B1 0.586 M ops/s

        num_maps: 10
local_storage cache sequential  get:  hits throughput: 43.743 =C2=B1 0.418 =
M ops/s, hits latency: 22.861 ns/op, important_hits throughput: 4.374 =C2=
=B1 0.042 M ops/s
local_storage cache interleaved get:  hits throughput: 50.073 =C2=B1 0.609 =
M ops/s, hits latency: 19.971 ns/op, important_hits throughput: 17.883 =C2=
=B1 0.217 M ops/s

        num_maps: 16
local_storage cache sequential  get:  hits throughput: 43.962 =C2=B1 0.525 =
M ops/s, hits latency: 22.747 ns/op, important_hits throughput: 2.748 =C2=
=B1 0.033 M ops/s
local_storage cache interleaved get:  hits throughput: 48.166 =C2=B1 0.825 =
M ops/s, hits latency: 20.761 ns/op, important_hits throughput: 15.326 =C2=
=B1 0.263 M ops/s

        num_maps: 17
local_storage cache sequential  get:  hits throughput: 33.207 =C2=B1 0.461 =
M ops/s, hits latency: 30.114 ns/op, important_hits throughput: 1.956 =C2=
=B1 0.027 M ops/s
local_storage cache interleaved get:  hits throughput: 43.540 =C2=B1 0.265 =
M ops/s, hits latency: 22.968 ns/op, important_hits throughput: 13.255 =C2=
=B1 0.081 M ops/s

        num_maps: 24
local_storage cache sequential  get:  hits throughput: 19.402 =C2=B1 0.348 =
M ops/s, hits latency: 51.542 ns/op, important_hits throughput: 0.809 =C2=
=B1 0.015 M ops/s
local_storage cache interleaved get:  hits throughput: 22.981 =C2=B1 0.487 =
M ops/s, hits latency: 43.514 ns/op, important_hits throughput: 6.465 =C2=
=B1 0.137 M ops/s

        num_maps: 32
local_storage cache sequential  get:  hits throughput: 13.378 =C2=B1 0.220 =
M ops/s, hits latency: 74.748 ns/op, important_hits throughput: 0.419 =C2=
=B1 0.007 M ops/s
local_storage cache interleaved get:  hits throughput: 16.894 =C2=B1 0.172 =
M ops/s, hits latency: 59.193 ns/op, important_hits throughput: 4.716 =C2=
=B1 0.048 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 6.070 =C2=B1 0.140 M=
 ops/s, hits latency: 164.745 ns/op, important_hits throughput: 0.061 =C2=
=B1 0.001 M ops/s
local_storage cache interleaved get:  hits throughput: 7.323 =C2=B1 0.149 M=
 ops/s, hits latency: 136.554 ns/op, important_hits throughput: 1.913 =C2=
=B1 0.039 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 0.438 =C2=B1 0.012 M=
 ops/s, hits latency: 2281.369 ns/op, important_hits throughput: 0.000 =C2=
=B1 0.000 M ops/s
local_storage cache interleaved get:  hits throughput: 0.522 =C2=B1 0.010 M=
 ops/s, hits latency: 1913.937 ns/op, important_hits throughput: 0.131 =C2=
=B1 0.003 M ops/s

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

To get a sense of the overhead of the benchmark program, I
commented out bpf_task_storage_get/bpf_map_lookup_elem in
local_storage_bench.c and ran the benchmark on the same host as the
'real' run. Results:

Local Storage
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        Hashmap Control w/ 500 maps
hashmap (control) sequential    get:  hits throughput: 96.965 =C2=B1 1.346 =
M ops/s, hits latency: 10.313 ns/op, important_hits throughput: 0.194 =C2=
=B1 0.003 M ops/s

        num_maps: 1
local_storage cache sequential  get:  hits throughput: 105.792 =C2=B1 1.860=
 M ops/s, hits latency: 9.453 ns/op, important_hits throughput: 105.792 =C2=
=B1 1.860 M ops/s
local_storage cache interleaved get:  hits throughput: 185.847 =C2=B1 4.014=
 M ops/s, hits latency: 5.381 ns/op, important_hits throughput: 185.847 =C2=
=B1 4.014 M ops/s

        num_maps: 10
local_storage cache sequential  get:  hits throughput: 109.867 =C2=B1 1.358=
 M ops/s, hits latency: 9.102 ns/op, important_hits throughput: 10.987 =C2=
=B1 0.136 M ops/s
local_storage cache interleaved get:  hits throughput: 144.165 =C2=B1 1.256=
 M ops/s, hits latency: 6.936 ns/op, important_hits throughput: 51.487 =C2=
=B1 0.449 M ops/s

        num_maps: 16
local_storage cache sequential  get:  hits throughput: 109.258 =C2=B1 1.902=
 M ops/s, hits latency: 9.153 ns/op, important_hits throughput: 6.829 =C2=
=B1 0.119 M ops/s
local_storage cache interleaved get:  hits throughput: 140.248 =C2=B1 1.836=
 M ops/s, hits latency: 7.130 ns/op, important_hits throughput: 44.624 =C2=
=B1 0.584 M ops/s

        num_maps: 17
local_storage cache sequential  get:  hits throughput: 116.397 =C2=B1 7.679=
 M ops/s, hits latency: 8.591 ns/op, important_hits throughput: 6.856 =C2=
=B1 0.452 M ops/s
local_storage cache interleaved get:  hits throughput: 128.411 =C2=B1 4.927=
 M ops/s, hits latency: 7.787 ns/op, important_hits throughput: 39.093 =C2=
=B1 1.500 M ops/s

        num_maps: 24
local_storage cache sequential  get:  hits throughput: 110.890 =C2=B1 0.976=
 M ops/s, hits latency: 9.018 ns/op, important_hits throughput: 4.624 =C2=
=B1 0.041 M ops/s
local_storage cache interleaved get:  hits throughput: 133.316 =C2=B1 1.889=
 M ops/s, hits latency: 7.501 ns/op, important_hits throughput: 37.503 =C2=
=B1 0.531 M ops/s

        num_maps: 32
local_storage cache sequential  get:  hits throughput: 112.900 =C2=B1 1.171=
 M ops/s, hits latency: 8.857 ns/op, important_hits throughput: 3.534 =C2=
=B1 0.037 M ops/s
local_storage cache interleaved get:  hits throughput: 132.844 =C2=B1 1.207=
 M ops/s, hits latency: 7.528 ns/op, important_hits throughput: 37.081 =C2=
=B1 0.337 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 110.025 =C2=B1 4.714=
 M ops/s, hits latency: 9.089 ns/op, important_hits throughput: 1.100 =C2=
=B1 0.047 M ops/s
local_storage cache interleaved get:  hits throughput: 131.979 =C2=B1 5.013=
 M ops/s, hits latency: 7.577 ns/op, important_hits throughput: 34.472 =C2=
=B1 1.309 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 117.850 =C2=B1 2.423=
 M ops/s, hits latency: 8.485 ns/op, important_hits throughput: 0.118 =C2=
=B1 0.002 M ops/s
local_storage cache interleaved get:  hits throughput: 141.268 =C2=B1 9.658=
 M ops/s, hits latency: 7.079 ns/op, important_hits throughput: 35.476 =C2=
=B1 2.425 M ops/s

Adjusting for overhead, latency numbers for "hashmap control" and "sequenti=
al get" are:

hashmap_control:     ~10.4ns
sequential_get_1:    ~13.0ns
sequential_get_10:   ~13.8ns
sequential_get_16:   ~13.6ns
sequential_get_17:   ~21.5ns
sequential_get_24:   ~42.5ns
sequential_get_32:   ~65.9ns
sequential_get_100:  ~155.7ns
sequential_get_1000: ~2270ns

Clearly demonstrating a cliff.

When running the benchmarks it may be necessary to bump 'open files'
ulimit for a successful run.

  [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@=
fb.com

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
Changelog:

v3 -> v4:
	* Remove ifs guarding increments in measure fn (Andrii)
	* Refactor to use 1 bpf prog for all 3 benchmarks w/ global vars set
	  from userspace before load to control behavior (Andrii)
	* Greatly reduce variance in overhead by having benchmark bpf prog
	  loop 10k times regardless of map count (Andrii)
		* Also, move sync_fetch_and_incr out of do_lookup as the guaranteed
		  second sync_fetch_and_incr call for num_maps =3D 1 was adding
		  overhead
	* Add second patch refactoring bench.c's mean/stddev calculations
	  in reporting helper fns

v2 -> v3:
  * Accessing 1k maps in ARRAY_OF_MAPS doesn't hit MAX_USED_MAPS limit,
    so just use 1 program (Alexei)

v1 -> v2:
  * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
    configurable # of maps (Andrii)
  * Add hashmap benchmark (Alexei)
  * Add discussion of overhead

 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |  55 ++++
 tools/testing/selftests/bpf/bench.h           |   4 +
 .../bpf/benchs/bench_local_storage.c          | 250 ++++++++++++++++++
 .../bpf/benchs/run_bench_local_storage.sh     |  21 ++
 .../selftests/bpf/benchs/run_common.sh        |  17 ++
 .../selftests/bpf/progs/local_storage_bench.c |  99 +++++++
 7 files changed, 449 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_stor=
age.sh
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 2d3c8c8f558a..f82f77075f67 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -560,6 +560,7 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.ske=
l.h \
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
 $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
+$(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS +=3D -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -571,7 +572,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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
index f061cc20e776..32399554f89b 100644
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
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/=
bpf/bench.h
index fb3e213df3dc..4b15286753ba 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -34,6 +34,7 @@ struct bench_res {
 	long hits;
 	long drops;
 	long false_hits;
+	long important_hits;
 };
=20
 struct bench {
@@ -61,6 +62,9 @@ void false_hits_report_progress(int iter, struct bench_re=
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
index 000000000000..93e68b589625
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <argp.h>
+#include <linux/btf.h>
+
+#include "local_storage_bench.skel.h"
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
+/* Keep in sync w/ array of maps in bpf */
+#define MAX_NR_MAPS 1000
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
+	if (args.nr_maps > MAX_NR_MAPS) {
+		fprintf(stderr, "nr_maps must be <=3D 1000\n");
+		exit(1);
+	}
+}
+
+static struct {
+	struct local_storage_bench *skel;
+	void *bpf_obj;
+	struct bpf_map *array_of_maps;
+} ctx;
+
+static void __setup(struct bpf_program *prog, bool hashmap)
+{
+	struct bpf_map *inner_map;
+	int i, fd, mim_fd, err;
+
+	LIBBPF_OPTS(bpf_map_create_opts, create_opts);
+
+	if (!hashmap)
+		create_opts.map_flags =3D BPF_F_NO_PREALLOC;
+
+	ctx.skel->rodata->num_maps =3D args.nr_maps;
+	inner_map =3D bpf_map__inner_map(ctx.array_of_maps);
+	create_opts.btf_key_type_id =3D bpf_map__btf_key_type_id(inner_map);
+	create_opts.btf_value_type_id =3D bpf_map__btf_value_type_id(inner_map);
+
+	err =3D local_storage_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "Error loading skeleton\n");
+		goto err_out;
+	}
+
+	create_opts.btf_fd =3D bpf_object__btf_fd(ctx.bpf_obj);
+
+	mim_fd =3D bpf_map__fd(ctx.array_of_maps);
+	if (mim_fd < 0) {
+		fprintf(stderr, "Error getting map_in_map fd\n");
+		goto err_out;
+	}
+
+	for (i =3D 0; i < args.nr_maps; i++) {
+		if (hashmap)
+			fd =3D bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(int),
+					    sizeof(int), 65536, &create_opts);
+		else
+			fd =3D bpf_map_create(BPF_MAP_TYPE_TASK_STORAGE, NULL, sizeof(int),
+					    sizeof(int), 0, &create_opts);
+		if (fd < 0) {
+			fprintf(stderr, "Error creating map %d: %d\n", i, fd);
+			goto err_out;
+		}
+
+		err =3D bpf_map_update_elem(mim_fd, &i, &fd, 0);
+		if (err) {
+			fprintf(stderr, "Error updating array-of-maps w/ map %d\n", i);
+			goto err_out;
+		}
+	}
+
+	if (!bpf_program__attach(prog)) {
+		fprintf(stderr, "Error attaching bpf program\n");
+		goto err_out;
+	}
+
+	return;
+err_out:
+	exit(1);
+}
+
+static void hashmap_setup(void)
+{
+	struct local_storage_bench *skel;
+
+	setup_libbpf();
+
+	skel =3D local_storage_bench__open();
+	ctx.skel =3D skel;
+	ctx.bpf_obj =3D skel->obj;
+	ctx.array_of_maps =3D skel->maps.array_of_hash_maps;
+	skel->rodata->use_hashmap =3D 1;
+	skel->rodata->interleave =3D 0;
+
+	__setup(skel->progs.get_local, true);
+}
+
+static void local_storage_cache_get_setup(void)
+{
+	struct local_storage_bench *skel;
+
+	setup_libbpf();
+
+	skel =3D local_storage_bench__open();
+	ctx.skel =3D skel;
+	ctx.bpf_obj =3D skel->obj;
+	ctx.array_of_maps =3D skel->maps.array_of_local_storage_maps;
+	skel->rodata->use_hashmap =3D 0;
+	skel->rodata->interleave =3D 0;
+
+	__setup(skel->progs.get_local, false);
+}
+
+static void local_storage_cache_get_interleaved_setup(void)
+{
+	struct local_storage_bench *skel;
+
+	setup_libbpf();
+
+	skel =3D local_storage_bench__open();
+	ctx.skel =3D skel;
+	ctx.bpf_obj =3D skel->obj;
+	ctx.array_of_maps =3D skel->maps.array_of_local_storage_maps;
+	skel->rodata->use_hashmap =3D 0;
+	skel->rodata->interleave =3D 1;
+
+	__setup(skel->progs.get_local, false);
+}
+
+static void measure(struct bench_res *res)
+{
+	res->hits =3D atomic_swap(&ctx.skel->bss->hits, 0);
+	res->important_hits =3D atomic_swap(&ctx.skel->bss->important_hits, 0);
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
diff --git a/tools/testing/selftests/bpf/progs/local_storage_bench.c b/tool=
s/testing/selftests/bpf/progs/local_storage_bench.c
new file mode 100644
index 000000000000..68a6e88e5d7c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+		__uint(map_flags, BPF_F_NO_PREALLOC);
+		__type(key, int);
+		__type(value, int);
+	});
+} array_of_local_storage_maps SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_HASH);
+		__uint(max_entries, 65536);
+		__type(key, int);
+		__type(value, int);
+	});
+} array_of_hash_maps SEC(".maps");
+
+long important_hits;
+long hits;
+
+/* set from user-space */
+const volatile unsigned int use_hashmap;
+const volatile unsigned int num_maps;
+const volatile unsigned int interleave;
+
+struct loop_ctx {
+	struct task_struct *task;
+	long loop_hits;
+	long loop_important_hits;
+};
+
+static int do_lookup(unsigned int elem, struct loop_ctx *lctx)
+{
+	void *map, *inner_map;
+	int zero =3D 0;
+
+	if (use_hashmap)
+		map =3D &array_of_hash_maps;
+	else
+		map =3D &array_of_local_storage_maps;
+
+	inner_map =3D bpf_map_lookup_elem(map, &elem);
+	if (!inner_map)
+		return -1;
+
+	if (use_hashmap)
+		bpf_map_lookup_elem(inner_map, &zero);
+	else
+		bpf_task_storage_get(inner_map, lctx->task, &zero,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+
+	lctx->loop_hits++;
+	if (!elem)
+		lctx->loop_important_hits++;
+	return 0;
+}
+
+static long loop(u32 index, void *ctx)
+{
+	struct loop_ctx *lctx =3D (struct loop_ctx *)ctx;
+	unsigned int map_idx =3D index % num_maps;
+
+	do_lookup(map_idx, lctx);
+	if (interleave && map_idx % 3 =3D=3D 0)
+		do_lookup(0, lctx);
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int get_local(void *ctx)
+{
+	struct loop_ctx lctx;
+
+	lctx.task =3D bpf_get_current_task_btf();
+	lctx.loop_hits =3D 0;
+	lctx.loop_important_hits =3D 0;
+	bpf_loop(10000, &loop, &lctx, 0);
+	__sync_add_and_fetch(&hits, lctx.loop_hits);
+	__sync_add_and_fetch(&important_hits, lctx.loop_important_hits);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

