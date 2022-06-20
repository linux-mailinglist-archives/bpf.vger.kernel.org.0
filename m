Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FCF5526F3
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiFTW0H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 18:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiFTW0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 18:26:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B584413EB2
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 15:26:01 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KM21fk002899
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 15:26:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=PAphrrDm/CoKJ2UkckC0MBt7g83Ix/YwC5Mv8R4KCAc=;
 b=ev7ASktLqoU6ApwgP3nzlyorEIoI8vOxRhQWR8Iw65A+myGH3bpdRg8ZEyhrbeFEtjn8
 j0PbWfq1jvVX9qjP6s/qCkRT/2iSV1b9cREVAKLgxohyG9tnoCm8jNxWnoXx5ZaM2IJT
 G35xRDBgkmSMbxa+ekZmjLXKh3dkadP0W8o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gsc7wuxe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 15:26:00 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 20 Jun 2022 15:25:58 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 4FB8993D76F6; Mon, 20 Jun 2022 15:25:55 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for local_storage get
Date:   Mon, 20 Jun 2022 15:25:54 -0700
Message-ID: <20220620222554.270578-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: PlV8IY-TqKfLoNAmtFRFeej5KfJZrSrf
X-Proofpoint-ORIG-GUID: PlV8IY-TqKfLoNAmtFRFeej5KfJZrSrf
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
similar to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
instead of local storage. Only one inner map is created - a hashmap
meant to hold tid -> data mapping for all tasks. Size of the hashmap is
hardcoded to my system's PID_MAX_LIMIT (4,194,304). The number of these
keys which are actually fetched as part of the benchmark is
configurable.

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

Hashmap Control
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        num keys: 10
hashmap (control) sequential    get:  hits throughput: 20.900 =C2=B1 0.334 =
M ops/s, hits latency: 47.847 ns/op, important_hits throughput: 20.900 =C2=
=B1 0.334 M ops/s

        num keys: 1000
hashmap (control) sequential    get:  hits throughput: 13.758 =C2=B1 0.219 =
M ops/s, hits latency: 72.683 ns/op, important_hits throughput: 13.758 =C2=
=B1 0.219 M ops/s

        num keys: 10000
hashmap (control) sequential    get:  hits throughput: 6.995 =C2=B1 0.034 M=
 ops/s, hits latency: 142.959 ns/op, important_hits throughput: 6.995 =C2=
=B1 0.034 M ops/s

        num keys: 100000
hashmap (control) sequential    get:  hits throughput: 4.452 =C2=B1 0.371 M=
 ops/s, hits latency: 224.635 ns/op, important_hits throughput: 4.452 =C2=
=B1 0.371 M ops/s

        num keys: 4194304
hashmap (control) sequential    get:  hits throughput: 3.043 =C2=B1 0.033 M=
 ops/s, hits latency: 328.587 ns/op, important_hits throughput: 3.043 =C2=
=B1 0.033 M ops/s

Local Storage
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        num_maps: 1
local_storage cache sequential  get:  hits throughput: 47.298 =C2=B1 0.180 =
M ops/s, hits latency: 21.142 ns/op, important_hits throughput: 47.298 =C2=
=B1 0.180 M ops/s
local_storage cache interleaved get:  hits throughput: 55.277 =C2=B1 0.888 =
M ops/s, hits latency: 18.091 ns/op, important_hits throughput: 55.277 =C2=
=B1 0.888 M ops/s

        num_maps: 10
local_storage cache sequential  get:  hits throughput: 40.240 =C2=B1 0.802 =
M ops/s, hits latency: 24.851 ns/op, important_hits throughput: 4.024 =C2=
=B1 0.080 M ops/s
local_storage cache interleaved get:  hits throughput: 48.701 =C2=B1 0.722 =
M ops/s, hits latency: 20.533 ns/op, important_hits throughput: 17.393 =C2=
=B1 0.258 M ops/s

        num_maps: 16
local_storage cache sequential  get:  hits throughput: 44.515 =C2=B1 0.708 =
M ops/s, hits latency: 22.464 ns/op, important_hits throughput: 2.782 =C2=
=B1 0.044 M ops/s
local_storage cache interleaved get:  hits throughput: 49.553 =C2=B1 2.260 =
M ops/s, hits latency: 20.181 ns/op, important_hits throughput: 15.767 =C2=
=B1 0.719 M ops/s

        num_maps: 17
local_storage cache sequential  get:  hits throughput: 38.778 =C2=B1 0.302 =
M ops/s, hits latency: 25.788 ns/op, important_hits throughput: 2.284 =C2=
=B1 0.018 M ops/s
local_storage cache interleaved get:  hits throughput: 43.848 =C2=B1 1.023 =
M ops/s, hits latency: 22.806 ns/op, important_hits throughput: 13.349 =C2=
=B1 0.311 M ops/s

        num_maps: 24
local_storage cache sequential  get:  hits throughput: 19.317 =C2=B1 0.568 =
M ops/s, hits latency: 51.769 ns/op, important_hits throughput: 0.806 =C2=
=B1 0.024 M ops/s
local_storage cache interleaved get:  hits throughput: 24.397 =C2=B1 0.272 =
M ops/s, hits latency: 40.989 ns/op, important_hits throughput: 6.863 =C2=
=B1 0.077 M ops/s

        num_maps: 32
local_storage cache sequential  get:  hits throughput: 13.333 =C2=B1 0.135 =
M ops/s, hits latency: 75.000 ns/op, important_hits throughput: 0.417 =C2=
=B1 0.004 M ops/s
local_storage cache interleaved get:  hits throughput: 16.898 =C2=B1 0.383 =
M ops/s, hits latency: 59.178 ns/op, important_hits throughput: 4.717 =C2=
=B1 0.107 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 6.360 =C2=B1 0.107 M=
 ops/s, hits latency: 157.233 ns/op, important_hits throughput: 0.064 =C2=
=B1 0.001 M ops/s
local_storage cache interleaved get:  hits throughput: 7.303 =C2=B1 0.362 M=
 ops/s, hits latency: 136.930 ns/op, important_hits throughput: 1.907 =C2=
=B1 0.094 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 0.452 =C2=B1 0.010 M=
 ops/s, hits latency: 2214.022 ns/op, important_hits throughput: 0.000 =C2=
=B1 0.000 M ops/s
local_storage cache interleaved get:  hits throughput: 0.542 =C2=B1 0.007 M=
 ops/s, hits latency: 1843.341 ns/op, important_hits throughput: 0.136 =C2=
=B1 0.002 M ops/s

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

Hashmap Control
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        num keys: 10
hashmap (control) sequential    get:  hits throughput: 54.288 =C2=B1 0.655 =
M ops/s, hits latency: 18.420 ns/op, important_hits throughput: 54.288 =C2=
=B1 0.655 M ops/s

        num keys: 1000
hashmap (control) sequential    get:  hits throughput: 52.913 =C2=B1 0.519 =
M ops/s, hits latency: 18.899 ns/op, important_hits throughput: 52.913 =C2=
=B1 0.519 M ops/s

        num keys: 10000
hashmap (control) sequential    get:  hits throughput: 53.480 =C2=B1 1.235 =
M ops/s, hits latency: 18.699 ns/op, important_hits throughput: 53.480 =C2=
=B1 1.235 M ops/s

        num keys: 100000
hashmap (control) sequential    get:  hits throughput: 54.982 =C2=B1 1.902 =
M ops/s, hits latency: 18.188 ns/op, important_hits throughput: 54.982 =C2=
=B1 1.902 M ops/s

        num keys: 4194304
hashmap (control) sequential    get:  hits throughput: 50.858 =C2=B1 0.707 =
M ops/s, hits latency: 19.662 ns/op, important_hits throughput: 50.858 =C2=
=B1 0.707 M ops/s

Local Storage
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        num_maps: 1
local_storage cache sequential  get:  hits throughput: 110.990 =C2=B1 4.828=
 M ops/s, hits latency: 9.010 ns/op, important_hits throughput: 110.990 =C2=
=B1 4.828 M ops/s
local_storage cache interleaved get:  hits throughput: 161.057 =C2=B1 4.090=
 M ops/s, hits latency: 6.209 ns/op, important_hits throughput: 161.057 =C2=
=B1 4.090 M ops/s

        num_maps: 10
local_storage cache sequential  get:  hits throughput: 112.930 =C2=B1 1.079=
 M ops/s, hits latency: 8.855 ns/op, important_hits throughput: 11.293 =C2=
=B1 0.108 M ops/s
local_storage cache interleaved get:  hits throughput: 115.841 =C2=B1 2.088=
 M ops/s, hits latency: 8.633 ns/op, important_hits throughput: 41.372 =C2=
=B1 0.746 M ops/s

        num_maps: 16
local_storage cache sequential  get:  hits throughput: 115.653 =C2=B1 0.416=
 M ops/s, hits latency: 8.647 ns/op, important_hits throughput: 7.228 =C2=
=B1 0.026 M ops/s
local_storage cache interleaved get:  hits throughput: 138.717 =C2=B1 1.649=
 M ops/s, hits latency: 7.209 ns/op, important_hits throughput: 44.137 =C2=
=B1 0.525 M ops/s

        num_maps: 17
local_storage cache sequential  get:  hits throughput: 112.020 =C2=B1 1.649=
 M ops/s, hits latency: 8.927 ns/op, important_hits throughput: 6.598 =C2=
=B1 0.097 M ops/s
local_storage cache interleaved get:  hits throughput: 128.089 =C2=B1 1.960=
 M ops/s, hits latency: 7.807 ns/op, important_hits throughput: 38.995 =C2=
=B1 0.597 M ops/s

        num_maps: 24
local_storage cache sequential  get:  hits throughput: 92.447 =C2=B1 5.170 =
M ops/s, hits latency: 10.817 ns/op, important_hits throughput: 3.855 =C2=
=B1 0.216 M ops/s
local_storage cache interleaved get:  hits throughput: 128.844 =C2=B1 2.808=
 M ops/s, hits latency: 7.761 ns/op, important_hits throughput: 36.245 =C2=
=B1 0.790 M ops/s

        num_maps: 32
local_storage cache sequential  get:  hits throughput: 102.042 =C2=B1 1.462=
 M ops/s, hits latency: 9.800 ns/op, important_hits throughput: 3.194 =C2=
=B1 0.046 M ops/s
local_storage cache interleaved get:  hits throughput: 126.577 =C2=B1 1.818=
 M ops/s, hits latency: 7.900 ns/op, important_hits throughput: 35.332 =C2=
=B1 0.507 M ops/s

        num_maps: 100
local_storage cache sequential  get:  hits throughput: 111.327 =C2=B1 1.401=
 M ops/s, hits latency: 8.983 ns/op, important_hits throughput: 1.113 =C2=
=B1 0.014 M ops/s
local_storage cache interleaved get:  hits throughput: 131.327 =C2=B1 1.339=
 M ops/s, hits latency: 7.615 ns/op, important_hits throughput: 34.302 =C2=
=B1 0.350 M ops/s

        num_maps: 1000
local_storage cache sequential  get:  hits throughput: 101.978 =C2=B1 0.563=
 M ops/s, hits latency: 9.806 ns/op, important_hits throughput: 0.102 =C2=
=B1 0.001 M ops/s
local_storage cache interleaved get:  hits throughput: 141.084 =C2=B1 1.098=
 M ops/s, hits latency: 7.088 ns/op, important_hits throughput: 35.430 =C2=
=B1 0.276 M ops/s

Adjusting for overhead, latency numbers for "hashmap control" and
"sequential get" are:

hashmap_control_1k:   ~53.8ns
hashmap_control_10k:  ~124.2ns
hashmap_control_100k: ~206.5ns
sequential_get_1:     ~12.1ns
sequential_get_10:    ~16.0ns
sequential_get_16:    ~13.8ns
sequential_get_17:    ~16.8ns
sequential_get_24:    ~40.9ns
sequential_get_32:    ~65.2ns
sequential_get_100:   ~148.2ns
sequential_get_1000:  ~2204ns

Clearly demonstrating a cliff.

In the discussion for v1 of this patch, Alexei noted that local_storage
was 2.5x faster than a large hashmap when initially implemented [1]. The
benchmark results show that local_storage is 5-10x faster: a
long-running BPF application putting some pid-specific info into a
hashmap for each pid it sees will probably see on the order of 10-100k
pids. Bench numbers for hashmaps of this size are ~10x slower than
sequential_get_16, but as the number of local_storage maps grows far
past local_storage cache size the performance advantage shrinks and
eventually reverses.

When running the benchmarks it may be necessary to bump 'open files'
ulimit for a successful run.

  [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@=
fb.com
  [1]: https://lore.kernel.org/bpf/20220511173305.ftldpn23m4ski3d3@MBP-98dd=
607d3435.dhcp.thefacebook.com/

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
Changelog:

v5 -> v6:
  * Prepopulate hashmap before benchmarking (Martin, Alexei)

v4 -> v5:
  * Remove 2nd patch refactoring mean/stddev calculations (Andrii)
  * Change "hashmap control" benchmark to use one big hashmap w/
    configurable number of keys accessed (Andrii)
    * Add discussion of "hashmap control" vs "sequential get" numbers

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
 .../bpf/benchs/bench_local_storage.c          | 287 ++++++++++++++++++
 .../bpf/benchs/run_bench_local_storage.sh     |  24 ++
 .../selftests/bpf/benchs/run_common.sh        |  17 ++
 .../selftests/bpf/progs/local_storage_bench.c | 104 +++++++
 7 files changed, 494 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_stor=
age.sh
 create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index cb8e552e1418..4fbd88a8ed9e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -571,6 +571,7 @@ $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_fil=
ter_bench.skel.h
 $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
 $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_upda=
te_bench.skel.h
+$(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS +=3D -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -583,7 +584,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bloom_filter_map.o \
 		 $(OUTPUT)/bench_bpf_loop.o \
 		 $(OUTPUT)/bench_strncmp.o \
-		 $(OUTPUT)/bench_bpf_hashmap_full_update.o
+		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
+		 $(OUTPUT)/bench_local_storage.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
=20
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/=
bpf/bench.c
index d8aa62be996b..1e7b5d4b1f11 100644
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
@@ -397,6 +446,9 @@ extern const struct bench bench_bpf_loop;
 extern const struct bench bench_strncmp_no_helper;
 extern const struct bench bench_strncmp_helper;
 extern const struct bench bench_bpf_hashmap_full_update;
+extern const struct bench bench_local_storage_cache_seq_get;
+extern const struct bench bench_local_storage_cache_interleaved_get;
+extern const struct bench bench_local_storage_cache_hashmap_control;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -432,6 +484,9 @@ static const struct bench *benchs[] =3D {
 	&bench_strncmp_no_helper,
 	&bench_strncmp_helper,
 	&bench_bpf_hashmap_full_update,
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
index 000000000000..5a378c84e81f
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage.c
@@ -0,0 +1,287 @@
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
+	__u32 hashmap_nr_keys_used;
+} args =3D {
+	.nr_maps =3D 1000,
+	.hashmap_nr_keys_used =3D 1000,
+};
+
+enum {
+	ARG_NR_MAPS =3D 6000,
+	ARG_HASHMAP_NR_KEYS_USED =3D 6001,
+};
+
+static const struct argp_option opts[] =3D {
+	{ "nr_maps", ARG_NR_MAPS, "NR_MAPS", 0,
+		"Set number of local_storage maps"},
+	{ "hashmap_nr_keys_used", ARG_HASHMAP_NR_KEYS_USED, "NR_KEYS",
+		0, "When doing hashmap test, set number of hashmap keys test uses"},
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
+	case ARG_HASHMAP_NR_KEYS_USED:
+		ret =3D strtol(arg, NULL, 10);
+		if (ret < 1 || ret > UINT_MAX) {
+			fprintf(stderr, "invalid hashmap_nr_keys_used");
+			argp_usage(state);
+		}
+		args.hashmap_nr_keys_used =3D ret;
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
+/* keep in sync w/ same define in bpf */
+#define HASHMAP_SZ 4194304
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
+
+	if (args.hashmap_nr_keys_used > HASHMAP_SZ) {
+		fprintf(stderr, "hashmap_nr_keys_used must be <=3D %u\n", HASHMAP_SZ);
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
+static void prepopulate_hashmap(int fd)
+{
+	int i, key, val;
+
+	/* local_storage gets will have BPF_LOCAL_STORAGE_GET_F_CREATE flag set, =
so
+	 * populate the hashmap for a similar comparison
+	 */
+	for (i =3D 0; i < HASHMAP_SZ; i++) {
+		key =3D val =3D i;
+		if (bpf_map_update_elem(fd, &key, &val, 0)) {
+			fprintf(stderr, "Error prepopulating hashmap (key %d)\n", key);
+			exit(1);
+		}
+	}
+}
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
+	ctx.skel->rodata->hashmap_num_keys =3D args.hashmap_nr_keys_used;
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
+	create_opts.btf_fd =3D bpf_object__btf_fd(ctx.skel->obj);
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
+					    sizeof(int), HASHMAP_SZ, &create_opts);
+		else
+			fd =3D bpf_map_create(BPF_MAP_TYPE_TASK_STORAGE, NULL, sizeof(int),
+					    sizeof(int), 0, &create_opts);
+		if (fd < 0) {
+			fprintf(stderr, "Error creating map %d: %d\n", i, fd);
+			goto err_out;
+		}
+
+		if (hashmap)
+			prepopulate_hashmap(fd);
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
index 000000000000..2eb2b513a173
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_local_storage.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+header "Hashmap Control"
+for i in 10 1000 10000 100000 4194304; do
+subtitle "num keys: $i"
+	summarize_local_storage "hashmap (control) sequential    get: "\
+		"$(./bench --nr_maps 1 --hashmap_nr_keys_used=3D$i local-storage-cache-h=
ashmap-control)"
+	printf "\n"
+done
+
+header "Local Storage"
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
index 000000000000..2c3234c5b73a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_bench.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define HASHMAP_SZ 4194304
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
+		__uint(max_entries, HASHMAP_SZ);
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
+const volatile unsigned int hashmap_num_keys;
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
+	int idx =3D 0;
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
+	if (use_hashmap) {
+		idx =3D bpf_get_prandom_u32() % hashmap_num_keys;
+		bpf_map_lookup_elem(inner_map, &idx);
+	} else {
+		bpf_task_storage_get(inner_map, lctx->task, &idx,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	}
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

