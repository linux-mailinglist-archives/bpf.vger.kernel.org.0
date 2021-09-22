Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55778415170
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhIVUeM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Sep 2021 16:34:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38890 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237309AbhIVUeM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 16:34:12 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MIlMSh022555
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b86h0tj2d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:41 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 13:32:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D691A4B04ECE; Wed, 22 Sep 2021 13:32:35 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kafai@fb.com>, <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC bpf-next 4/4] selftests/bpf: integrate custom Bloom filter impl into benchs
Date:   Wed, 22 Sep 2021 13:32:24 -0700
Message-ID: <20210922203224.912809-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922203224.912809-1-andrii@kernel.org>
References: <20210922203224.912809-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 00hB6rqB0fh8-Bg6Vb5JCJuWIKML8LPU
X-Proofpoint-ORIG-GUID: 00hB6rqB0fh8-Bg6Vb5JCJuWIKML8LPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_08,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add user-space integration parts.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 121 +++++++++++++++++-
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  22 ++--
 .../selftests/bpf/benchs/run_common.sh        |   2 +-
 4 files changed, 135 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 7da1589a9fe0..ab03b259b76f 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -363,9 +363,12 @@ extern const struct bench bench_rb_custom;
 extern const struct bench bench_pb_libbpf;
 extern const struct bench bench_pb_custom;
 extern const struct bench bench_bloom_filter_map;
+extern const struct bench bench_custom_bloom_filter_map;
 extern const struct bench bench_bloom_filter_false_positive;
+extern const struct bench bench_custom_bloom_filter_false_positive;
 extern const struct bench bench_hashmap_without_bloom_filter;
 extern const struct bench bench_hashmap_with_bloom_filter;
+extern const struct bench bench_hashmap_with_custom_bloom_filter;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -388,9 +391,12 @@ static const struct bench *benchs[] = {
 	&bench_pb_libbpf,
 	&bench_pb_custom,
 	&bench_bloom_filter_map,
+	&bench_custom_bloom_filter_map,
 	&bench_bloom_filter_false_positive,
+	&bench_custom_bloom_filter_false_positive,
 	&bench_hashmap_without_bloom_filter,
 	&bench_hashmap_with_bloom_filter,
+	&bench_hashmap_with_custom_bloom_filter,
 };
 
 static void setup_benchmark()
diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 4f53cd9fb099..c0ccfbaacef7 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -95,11 +95,18 @@ static void *map_prepare_thread(void *arg)
 {
 	int err, random_data_fd, bloom_filter_fd, hashmap_fd;
 	__u64 i, val;
+	struct bpf_link *link;
 
 	bloom_filter_fd = bpf_map__fd(ctx.skel->maps.map_bloom_filter);
 	random_data_fd = bpf_map__fd(ctx.skel->maps.map_random_data);
 	hashmap_fd = bpf_map__fd(ctx.skel->maps.hashmap);
 
+	link = bpf_program__attach(ctx.skel->progs.prog_custom_bloom_filter_add);
+	if (libbpf_get_error(link)) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+
 	while (true) {
 		i = __atomic_add_fetch(&ctx.next_map_idx, 1, __ATOMIC_RELAXED);
 		if (i > args.nr_entries)
@@ -135,8 +142,13 @@ static void *map_prepare_thread(void *arg)
 			fprintf(stderr, "failed to add elem to bloom_filter: %d\n", -errno);
 			break;
 		}
+
+		ctx.skel->bss->bloom_val = val;
+		trigger_bpf_program();
 	}
 
+	bpf_link__destroy(link);
+
 	pthread_mutex_lock(&ctx.map_done_mtx);
 	pthread_cond_signal(&ctx.map_done);
 	pthread_mutex_unlock(&ctx.map_done_mtx);
@@ -146,7 +158,7 @@ static void *map_prepare_thread(void *arg)
 
 static void populate_maps(void)
 {
-	unsigned int nr_cpus = bpf_num_possible_cpus();
+	unsigned int nr_cpus = 1; // bpf_num_possible_cpus();
 	pthread_t map_thread;
 	int i, err;
 
@@ -167,10 +179,10 @@ static void populate_maps(void)
 		exit(1);
 }
 
-static struct bloom_filter_map *setup_skeleton(void)
+static struct bloom_filter_map *setup_skeleton()
 {
 	struct bloom_filter_map *skel;
-	int err;
+	int err, i, bloom_sz;
 
 	setup_libbpf();
 
@@ -204,10 +216,17 @@ static struct bloom_filter_map *setup_skeleton(void)
 		exit(1);
 	}
 
-	if (bloom_filter_map__load(skel)) {
-		fprintf(stderr, "failed to load skeleton\n");
-		exit(1);
+	skel->rodata->bloom_hash_cnt = args.nr_hash_funcs;
+	skel->rodata->bloom_seed = /* 0; */ rand();
+
+	bloom_sz = (long)args.nr_hash_funcs * args.nr_entries / 5 * 7;
+	for (i = 64; i < bloom_sz; i *= 2) {
 	}
+	bloom_sz = i / 64;
+	skel->rodata->bloom_mask = bloom_sz - 1;
+
+	//printf("SET BLOOM SZ TO %d NR_ENTRIES %d HASH CNT %d \n", bloom_sz, args.nr_entries, args.nr_hash_funcs);
+
 
 	return skel;
 }
@@ -218,6 +237,11 @@ static void bloom_filter_map_setup(void)
 
 	ctx.skel = setup_skeleton();
 
+	if (bloom_filter_map__load(ctx.skel)) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.prog_bloom_filter);
@@ -227,12 +251,59 @@ static void bloom_filter_map_setup(void)
 	}
 }
 
+static void custom_bloom_filter_map_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.skel = setup_skeleton();
+
+	if (bloom_filter_map__load(ctx.skel)) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	populate_maps();
+
+	link = bpf_program__attach(ctx.skel->progs.prog_custom_bloom_filter);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
 static void hashmap_lookup_setup(void)
 {
 	struct bpf_link *link;
 
 	ctx.skel = setup_skeleton();
 
+	if (bloom_filter_map__load(ctx.skel)) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	populate_maps();
+
+	link = bpf_program__attach(ctx.skel->progs.prog_bloom_filter_hashmap_lookup);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+static void hashmap_lookup_custom_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.skel = setup_skeleton();
+
+	ctx.skel->rodata->hashmap_use_bloom_filter = false;
+	ctx.skel->rodata->hashmap_use_custom_bloom_filter = true;
+
+	if (bloom_filter_map__load(ctx.skel)) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.prog_bloom_filter_hashmap_lookup);
@@ -250,6 +321,11 @@ static void hashmap_no_bloom_filter_setup(void)
 
 	ctx.skel->rodata->hashmap_use_bloom_filter = false;
 
+	if (bloom_filter_map__load(ctx.skel)) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
 	populate_maps();
 
 	link = bpf_program__attach(ctx.skel->progs.prog_bloom_filter_hashmap_lookup);
@@ -378,6 +454,17 @@ const struct bench bench_bloom_filter_map = {
 	.report_final = hits_drops_report_final,
 };
 
+const struct bench bench_custom_bloom_filter_map = {
+	.name = "custom-bloom-filter-map",
+	.validate = validate,
+	.setup = custom_bloom_filter_map_setup,
+	.producer_thread = producer,
+	.consumer_thread = consumer,
+	.measure = measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
 const struct bench bench_bloom_filter_false_positive = {
 	.name = "bloom-filter-false-positive",
 	.validate = validate,
@@ -389,6 +476,17 @@ const struct bench bench_bloom_filter_false_positive = {
 	.report_final = false_hits_report_final,
 };
 
+const struct bench bench_custom_bloom_filter_false_positive = {
+	.name = "custom-bloom-filter-false-positive",
+	.validate = validate,
+	.setup = hashmap_lookup_custom_setup,
+	.producer_thread = producer,
+	.consumer_thread = consumer,
+	.measure = measure,
+	.report_progress = false_hits_report_progress,
+	.report_final = false_hits_report_final,
+};
+
 const struct bench bench_hashmap_without_bloom_filter = {
 	.name = "hashmap-without-bloom-filter",
 	.validate = validate,
@@ -410,3 +508,14 @@ const struct bench bench_hashmap_with_bloom_filter = {
 	.report_progress = hits_drops_report_progress,
 	.report_final = hits_drops_report_final,
 };
+
+const struct bench bench_hashmap_with_custom_bloom_filter = {
+	.name = "hashmap-with-custom-bloom-filter",
+	.validate = validate,
+	.setup = hashmap_lookup_custom_setup,
+	.producer_thread = producer,
+	.consumer_thread = consumer,
+	.measure = measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
index 239c040b7aaa..ea2c2fff3f40 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
@@ -7,9 +7,9 @@ set -eufo pipefail
 
 header "Bloom filter map"
 for t in 1 4 8; do
-for h in {1..10}; do
+for h in 1 3 5 10; do
 subtitle "# threads: $t, # hashes: $h"
-	for e in 10000 50000 75000 100000 250000 500000 750000 1000000 2500000 5000000; do
+	for e in 10000 100000 1000000; do
 		printf "%'d entries -\n" $e
 		printf "\t"
 		summarize "Total operations: " \
@@ -17,20 +17,21 @@ subtitle "# threads: $t, # hashes: $h"
 		printf "\t"
 		summarize_percentage "False positive rate: " \
 			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e bloom-filter-false-positive)"
+		printf "\t"
+		summarize "[CUSTOM] Total operations: " \
+			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e custom-bloom-filter-map)"
+		printf "\t"
+		summarize_percentage "[CUSTOM] False positive rate: " \
+			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e custom-bloom-filter-false-positive)"
 	done
 	printf "\n"
 done
 done
 
-header "Bloom filter map, multi-producer contention"
-for t in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
-	summarize "$t threads - " "$($RUN_BENCH -p $t bloom-filter-map)"
-done
-
 header "Hashmap without bloom filter vs. hashmap with bloom filter (throughput, 8 threads)"
-for h in {1..10}; do
+for h in 1 3 5 10; do
 subtitle "# hashes: $h"
-	for e in 10000 50000 75000 100000 250000 500000 750000 1000000 2500000 5000000; do
+	for e in 10000 100000 1000000; do
 		printf "%'d entries -\n" $e
 		printf "\t"
 		summarize_total "Hashmap without bloom filter: " \
@@ -38,6 +39,9 @@ subtitle "# hashes: $h"
 		printf "\t"
 		summarize_total "Hashmap with bloom filter: " \
 			"$($RUN_BENCH --nr_hash_funcs $h --nr_entries $e -p 8 hashmap-with-bloom-filter)"
+		printf "\t"
+		summarize_total "[CUSTOM] Hashmap with bloom filter: " \
+			"$($RUN_BENCH --nr_hash_funcs $h --nr_entries $e -p 8 hashmap-with-custom-bloom-filter)"
 	done
 	printf "\n"
 done
diff --git a/tools/testing/selftests/bpf/benchs/run_common.sh b/tools/testing/selftests/bpf/benchs/run_common.sh
index 9a16be78b180..961d25374150 100644
--- a/tools/testing/selftests/bpf/benchs/run_common.sh
+++ b/tools/testing/selftests/bpf/benchs/run_common.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-RUN_BENCH="sudo ./bench -w3 -d10 -a"
+RUN_BENCH="sudo ./bench -w1 -d5 -a"
 
 function header()
 {
-- 
2.30.2

