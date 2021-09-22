Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4670F41516D
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhIVUeG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Sep 2021 16:34:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12944 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237309AbhIVUeF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 16:34:05 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18MIlIEl025899
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b7q4nyxmx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:35 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 13:32:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BBD314B04EBE; Wed, 22 Sep 2021 13:32:31 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kafai@fb.com>, <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC bpf-next 2/4] selftests/bpf: fix and optimize bloom filter bench
Date:   Wed, 22 Sep 2021 13:32:22 -0700
Message-ID: <20210922203224.912809-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922203224.912809-1-andrii@kernel.org>
References: <20210922203224.912809-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: MX5_nYSIGaUVH_DznNsptsVR9jaXwPmP
X-Proofpoint-ORIG-GUID: MX5_nYSIGaUVH_DznNsptsVR9jaXwPmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_08,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109200000 definitions=main-2109220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix inconsistent and highly-variable measurement logic by using always
increasing counters. Also reduce the amount of accounting by doing
increment once after the entire loop. Also use rodata for bloom filter
flag. And build bench files in optimized mode.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../bpf/benchs/bench_bloom_filter_map.c       | 32 +++++++++++++-
 .../selftests/bpf/progs/bloom_filter_map.c    | 44 ++++++++++++++-----
 3 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5dbaf7f512fd..f36f49e4d0f2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -515,7 +515,7 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 7adf80be7292..4f53cd9fb099 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -248,7 +248,7 @@ static void hashmap_no_bloom_filter_setup(void)
 
 	ctx.skel = setup_skeleton();
 
-	ctx.skel->data->hashmap_use_bloom_filter = false;
+	ctx.skel->rodata->hashmap_use_bloom_filter = false;
 
 	populate_maps();
 
@@ -259,16 +259,26 @@ static void hashmap_no_bloom_filter_setup(void)
 	}
 }
 
+struct stat { __u32 stats[3]; };
+
 static void measure(struct bench_res *res)
 {
+	static long last_hits, last_drops, last_false_hits;
 	long total_hits = 0, total_drops = 0, total_false_hits = 0;
 	unsigned int nr_cpus = bpf_num_possible_cpus();
+	/*
 	BPF_DECLARE_PERCPU(__u64, zeroed_values);
 	BPF_DECLARE_PERCPU(__u64, false_hits);
 	BPF_DECLARE_PERCPU(__u64, drops);
 	BPF_DECLARE_PERCPU(__u64, hits);
 	int err, i, percpu_array_fd;
 	__u32 key;
+	*/
+	int i;
+	int hit_key, drop_key, false_hit_key;
+	hit_key = ctx.skel->rodata->hit_key;
+	drop_key = ctx.skel->rodata->drop_key;
+	false_hit_key = ctx.skel->rodata->false_hit_key;
 
 	if (ctx.skel->bss->error != 0) {
 		fprintf(stderr, "error (%d) when searching the bloom filter\n",
@@ -276,6 +286,7 @@ static void measure(struct bench_res *res)
 		exit(1);
 	}
 
+	/*
 	key = ctx.skel->rodata->hit_key;
 	percpu_array_fd = bpf_map__fd(ctx.skel->maps.percpu_array);
 	err = bpf_map_lookup_elem(percpu_array_fd, &key, hits);
@@ -300,20 +311,36 @@ static void measure(struct bench_res *res)
 			-errno);
 		exit(1);
 	}
+	*/
 
 	for (i = 0; i < nr_cpus; i++) {
+		struct stat *s = (void *)&ctx.skel->bss->percpu_stats[i];
+
+		total_hits += s->stats[hit_key];
+		total_drops += s->stats[drop_key];
+		total_false_hits += s->stats[false_hit_key];
+		/*
 		total_hits += bpf_percpu(hits, i);
 		total_drops += bpf_percpu(drops, i);
 		total_false_hits += bpf_percpu(false_hits, i);
+		*/
 	}
 
+	res->hits = total_hits - last_hits;
+	res->drops = total_drops - last_drops;
+	res->false_hits = total_false_hits - last_false_hits;
+
+	last_hits = total_hits;
+	last_drops = total_drops;
+	last_false_hits = total_false_hits;
+
+	/*
 	res->hits = total_hits;
 	res->drops = total_drops;
 	res->false_hits = total_false_hits;
 
 	memset(zeroed_values, 0, sizeof(zeroed_values));
 
-	/* zero out the percpu array */
 	key = ctx.skel->rodata->hit_key;
 	err = bpf_map_update_elem(percpu_array_fd, &key, zeroed_values, BPF_ANY);
 	if (err) {
@@ -332,6 +359,7 @@ static void measure(struct bench_res *res)
 		fprintf(stderr, "zeroing the percpu array failed: %d\n", -errno);
 		exit(1);
 	}
+	*/
 }
 
 static void *consumer(void *input)
diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
index 05f9706a5ba6..3ae2f9bb5968 100644
--- a/tools/testing/selftests/bpf/progs/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
@@ -23,6 +23,7 @@ struct map_bloom_filter_type {
 	__uint(value_size, sizeof(__u64));
 	__uint(max_entries, 1000);
 	__uint(nr_hash_funcs, 3);
+//	__uint(map_flags, BPF_F_ZERO_SEED);
 } map_bloom_filter SEC(".maps");
 
 struct {
@@ -37,13 +38,19 @@ struct callback_ctx {
 	struct map_bloom_filter_type *map;
 };
 
+struct {
+	__u32 stats[3];
+} __attribute__((aligned(256))) percpu_stats[256];
+
 /* Tracks the number of hits, drops, and false hits */
+/*
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(max_entries, 3);
 	__type(key, __u32);
 	__type(value, __u64);
 } percpu_array SEC(".maps");
+*/
 
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -56,17 +63,23 @@ const __u32 hit_key  = 0;
 const __u32 drop_key  = 1;
 const __u32 false_hit_key = 2;
 
-bool hashmap_use_bloom_filter = true;
+const volatile bool hashmap_use_bloom_filter = true;
 
 int error = 0;
 
-static __always_inline void log_result(__u32 key)
+static __always_inline void log_result(__u32 key, __u32 val)
 {
+	__u32 cpu = bpf_get_smp_processor_id();
+
+	percpu_stats[cpu & 255].stats[key] += val;
+
+	/*
 	__u64 *count;
 
 	count = bpf_map_lookup_elem(&percpu_array, &key);
 	if (count)
-		*count += 1;
+		*count += val;
+	*/
 }
 
 static __u64
@@ -81,7 +94,7 @@ check_elem(struct bpf_map *map, __u32 *key, __u64 *val,
 		return 1; /* stop the iteration */
 	}
 
-	log_result(hit_key);
+	log_result(hit_key, 1);
 
 	return 0;
 }
@@ -121,37 +134,44 @@ int prog_bloom_filter_hashmap_lookup(void *ctx)
 {
 	__u64 *result;
 	int i, err;
-
 	union {
 		__u64 data64;
 		__u32 data32[2];
 	} val;
+	int hits = 0, drops = 0, false_hits = 0;
+	//bool custom_hit = false, noncustom_hit = false;
 
 	for (i = 0; i < 512; i++) {
-		val.data32[0] = bpf_get_prandom_u32();
-		val.data32[1] = bpf_get_prandom_u32();
+		val.data32[0] = /*i; */ bpf_get_prandom_u32();
+		val.data32[1] = /*i + 1;*/ bpf_get_prandom_u32();
 
-		if (hashmap_use_bloom_filter) {
+		if (hashmap_use_bloom_filter)
+		{
 			err = bpf_map_peek_elem(&map_bloom_filter, &val);
 			if (err) {
 				if (err != -ENOENT) {
 					error |= 3;
 					return 0;
 				}
-				log_result(drop_key);
+				hits++;
+				//noncustom_hit = true;
+				//__sync_fetch_and_add(&bloom_noncustom_hit, 1);
 				continue;
 			}
 		}
 
 		result = bpf_map_lookup_elem(&hashmap, &val);
 		if (result) {
-			log_result(hit_key);
+			hits++;
 		} else {
 			if (hashmap_use_bloom_filter)
-				log_result(false_hit_key);
-			log_result(drop_key);
+				false_hits++;
+			drops++;
 		}
 	}
+	log_result(hit_key, hits);
+	log_result(drop_key, drops);
+	log_result(false_hit_key, false_hits);
 
 	return 0;
 }
-- 
2.30.2

