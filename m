Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7D413BF7
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 23:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhIUVHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 17:07:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46616 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232718AbhIUVHF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 17:07:05 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LHA1HE020969
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:05:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=5HVJEwo66xu+zWR8lCIY6ChIZrvLlxsIoelrdGhVTCc=;
 b=Sf8qZEJ+hDFtC9KFy+Ul7M8PQ7t+KxAuCzmSEt6tpcs9WpSx9cgGrNIK+Y1xTCUU8pnB
 TWq1SsbrVoVf7JTV4mKn6SScD9ekI2bhsbYEuEuownTj6i7+wbUXMAjhAfralpT1CPbz
 i9l58iY2Lr5rDSGKPrn4qaN2vLHozCEl7eQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b79q5nc32-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:05:35 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 14:05:24 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 285F32AC13D7; Tue, 21 Sep 2021 14:05:18 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v3 bpf-next 4/5] bpf/benchs: Add benchmark test for bloom filter maps
Date:   Tue, 21 Sep 2021 14:02:24 -0700
Message-ID: <20210921210225.4095056-5-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921210225.4095056-1-joannekoong@fb.com>
References: <20210921210225.4095056-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: _9ICv0xQ7jaEysOxWzzfvqsUY1wizhQz
X-Proofpoint-ORIG-GUID: _9ICv0xQ7jaEysOxWzzfvqsUY1wizhQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_06,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds benchmark tests for the throughput and false positive
rate of bloom filter map lookups for a given number of entries and a
given number of hash functions.

These benchmarks show that as the number of hash functions increases,
the throughput and the false positive rate of the bloom filter map
decreases. From the benchmark data, the approximate average
false-positive rates are roughly as follows:

1 hash function =3D ~30%
2 hash functions =3D ~15%
3 hash functions =3D ~5%
4 hash functions =3D ~2.5%
5 hash functions =3D ~1%
6 hash functions =3D ~0.5%
7 hash functions  =3D ~0.35%
8 hash functions =3D ~0.15%
9 hash functions =3D ~0.1%
10 hash functions =3D ~0%

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/bench.c           |  35 ++
 tools/testing/selftests/bpf/bench.h           |   3 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 345 ++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
 .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
 .../selftests/bpf/benchs/run_common.sh        |  48 +++
 .../selftests/bpf/progs/bloom_filter_map.c    |  74 ++++
 8 files changed, 538 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter=
_map.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_fi=
lter_map.sh
 create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 326ea75ce99e..5dbaf7f512fd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -520,13 +520,15 @@ $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.s=
kel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
 			    $(OUTPUT)/perfbuf_bench.skel.h
+$(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_map.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS +=3D -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 		 $(OUTPUT)/bench_count.o \
 		 $(OUTPUT)/bench_rename.o \
 		 $(OUTPUT)/bench_trigger.o \
-		 $(OUTPUT)/bench_ringbufs.o
+		 $(OUTPUT)/bench_ringbufs.o \
+		 $(OUTPUT)/bench_bloom_filter_map.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
=20
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
index 6ea15b93a2f8..0bcbdb4405a3 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -51,6 +51,35 @@ void setup_libbpf()
 		fprintf(stderr, "failed to increase RLIMIT_MEMLOCK: %d", err);
 }
=20
+void false_hits_report_progress(int iter, struct bench_res *res, long de=
lta_ns)
+{
+	long total =3D res->false_hits  + res->hits + res->drops;
+
+	printf("Iter %3d (%7.3lfus): ",
+	       iter, (delta_ns - 1000000000) / 1000.0);
+
+	printf("%ld false hits of %ld total operations. Percentage =3D %2.2f %%=
\n",
+	       res->false_hits, total, ((float)res->false_hits / total) * 100);
+}
+
+void false_hits_report_final(struct bench_res res[], int res_cnt)
+{
+	long total_hits =3D 0, total_drops =3D 0, total_false_hits =3D 0, total=
_ops =3D 0;
+	int i;
+
+	for (i =3D 0; i < res_cnt; i++) {
+		total_hits +=3D res[i].hits;
+		total_false_hits +=3D res[i].false_hits;
+		total_drops +=3D res[i].drops;
+	}
+	total_ops =3D total_hits + total_false_hits + total_drops;
+
+	printf("Summary: %ld false hits of %ld total operations. ",
+	       total_false_hits, total_ops);
+	printf("Percentage =3D  %2.2f %%\n",
+	       ((float)total_false_hits / total_ops) * 100);
+}
+
 void hits_drops_report_progress(int iter, struct bench_res *res, long de=
lta_ns)
 {
 	double hits_per_sec, drops_per_sec;
@@ -132,9 +161,11 @@ static const struct argp_option opts[] =3D {
 };
=20
 extern struct argp bench_ringbufs_argp;
+extern struct argp bench_bloom_filter_map_argp;
=20
 static const struct argp_child bench_parsers[] =3D {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
+	{ &bench_bloom_filter_map_argp, 0, "Bloom filter map benchmark", 0 },
 	{},
 };
=20
@@ -323,6 +354,8 @@ extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
 extern const struct bench bench_pb_libbpf;
 extern const struct bench bench_pb_custom;
+extern const struct bench bench_bloom_filter_map;
+extern const struct bench bench_bloom_filter_false_positive;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -344,6 +377,8 @@ static const struct bench *benchs[] =3D {
 	&bench_rb_custom,
 	&bench_pb_libbpf,
 	&bench_pb_custom,
+	&bench_bloom_filter_map,
+	&bench_bloom_filter_false_positive,
 };
=20
 static void setup_benchmark()
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftest=
s/bpf/bench.h
index c1f48a473b02..624c6b11501f 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -33,6 +33,7 @@ struct env {
 struct bench_res {
 	long hits;
 	long drops;
+	long false_hits;
 };
=20
 struct bench {
@@ -56,6 +57,8 @@ extern const struct bench *bench;
 void setup_libbpf();
 void hits_drops_report_progress(int iter, struct bench_res *res, long de=
lta_ns);
 void hits_drops_report_final(struct bench_res res[], int res_cnt);
+void false_hits_report_progress(int iter, struct bench_res *res, long de=
lta_ns);
+void false_hits_report_final(struct bench_res res[], int res_cnt);
=20
 static inline __u64 get_time_ns() {
 	struct timespec t;
diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c =
b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
new file mode 100644
index 000000000000..8b4cd9a52a88
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <argp.h>
+#include <linux/log2.h>
+#include <pthread.h>
+#include "bench.h"
+#include "bloom_filter_map.skel.h"
+#include "bpf_util.h"
+
+static struct ctx {
+	struct bloom_filter_map *skel;
+	pthread_mutex_t map_done_mtx;
+	pthread_cond_t map_done;
+	bool map_prepare_err;
+	__u32 next_map_idx;
+} ctx =3D {
+	.map_done_mtx =3D PTHREAD_MUTEX_INITIALIZER,
+	.map_done =3D PTHREAD_COND_INITIALIZER,
+};
+
+static struct {
+	__u32 nr_entries;
+	__u8 nr_hash_funcs;
+} args =3D {
+	.nr_entries =3D 1000,
+	.nr_hash_funcs =3D 3,
+};
+
+enum {
+	ARG_NR_ENTRIES =3D 3000,
+	ARG_NR_HASH_FUNCS =3D 3001,
+};
+
+static const struct argp_option opts[] =3D {
+	{ "nr_entries", ARG_NR_ENTRIES, "NR_ENTRIES", 0,
+		"Set number of entries in the bloom filter map"},
+	{ "nr_hash_funcs", ARG_NR_HASH_FUNCS, "NR_HASH_FUNCS", 0,
+		"Set number of hashes in the bloom filter map"},
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_NR_ENTRIES:
+		args.nr_entries =3D strtol(arg, NULL, 10);
+		if (args.nr_entries =3D=3D 0) {
+			fprintf(stderr, "Invalid nr_entries count.");
+			argp_usage(state);
+		}
+		break;
+	case ARG_NR_HASH_FUNCS:
+		args.nr_hash_funcs =3D strtol(arg, NULL, 10);
+		if (args.nr_hash_funcs =3D=3D 0) {
+			fprintf(stderr, "Cannot specify a bloom filter map with 0 hashes.");
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
+/* exported into benchmark runner */
+const struct argp bench_bloom_filter_map_argp =3D {
+	.options =3D opts,
+	.parser =3D parse_arg,
+};
+
+static void validate(void)
+{
+	if (env.consumer_cnt !=3D 1) {
+		fprintf(stderr, "bloom filter map benchmark doesn't support multi-cons=
umer!\n");
+		exit(1);
+	}
+}
+
+static inline void trigger_bpf_program(void)
+{
+	syscall(__NR_getpgid);
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
+static void *map_prepare_thread(void *arg)
+{
+	int err, random_data_fd, bloom_filter_fd, hashmap_fd;
+	__u64 i, val;
+
+	bloom_filter_fd =3D bpf_map__fd(ctx.skel->maps.map_bloom_filter);
+	random_data_fd =3D bpf_map__fd(ctx.skel->maps.map_random_data);
+	hashmap_fd =3D bpf_map__fd(ctx.skel->maps.hashmap);
+
+	while (true) {
+		i =3D __atomic_add_fetch(&ctx.next_map_idx, 1, __ATOMIC_RELAXED);
+		if (i > args.nr_entries)
+			break;
+again:
+		err =3D syscall(__NR_getrandom, &val, sizeof(val), 0);
+		if (err !=3D sizeof(val)) {
+			ctx.map_prepare_err =3D true;
+			fprintf(stderr, "failed to get random value\n");
+			break;
+		}
+		err =3D bpf_map_update_elem(hashmap_fd, &val, &val, BPF_NOEXIST);
+		if (err) {
+			if (err !=3D -EEXIST) {
+				ctx.map_prepare_err =3D true;
+				fprintf(stderr, "failed to add elem to hashmap: %d\n", -errno);
+				break;
+			}
+			goto again;
+		}
+
+		i--;
+		err =3D bpf_map_update_elem(random_data_fd, &i, &val, 0);
+		if (err) {
+			ctx.map_prepare_err =3D true;
+			fprintf(stderr, "failed to add elem to array: %d\n", -errno);
+			break;
+		}
+
+		err =3D bpf_map_update_elem(bloom_filter_fd, NULL, &val, 0);
+		if (err) {
+			ctx.map_prepare_err =3D true;
+			fprintf(stderr, "failed to add elem to bloom_filter: %d\n", -errno);
+			break;
+		}
+	}
+
+	pthread_mutex_lock(&ctx.map_done_mtx);
+	pthread_cond_signal(&ctx.map_done);
+	pthread_mutex_unlock(&ctx.map_done_mtx);
+
+	return NULL;
+}
+
+static void populate_maps(void)
+{
+	unsigned int nr_cpus =3D bpf_num_possible_cpus();
+	pthread_t map_thread;
+	int i, err;
+
+	for (i =3D 0; i < nr_cpus; i++) {
+		err =3D pthread_create(&map_thread, NULL, map_prepare_thread,
+				     NULL);
+		if (err) {
+			fprintf(stderr, "failed to create pthread: %d\n", -errno);
+			exit(1);
+		}
+	}
+
+	pthread_mutex_lock(&ctx.map_done_mtx);
+	pthread_cond_wait(&ctx.map_done, &ctx.map_done_mtx);
+	pthread_mutex_unlock(&ctx.map_done_mtx);
+
+	if (ctx.map_prepare_err)
+		exit(1);
+}
+
+static struct bloom_filter_map *setup_skeleton(void)
+{
+	struct bloom_filter_map *skel;
+	int err;
+
+	setup_libbpf();
+
+	skel =3D bloom_filter_map__open();
+	if (!skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	err =3D bpf_map__resize(skel->maps.map_random_data, args.nr_entries);
+	if (err) {
+		fprintf(stderr, "failed to resize map_random_data\n");
+		exit(1);
+	}
+
+	err =3D bpf_map__resize(skel->maps.hashmap, args.nr_entries);
+	if (err) {
+		fprintf(stderr, "failed to resize hashmap\n");
+		exit(1);
+	}
+
+	err =3D bpf_map__resize(skel->maps.map_bloom_filter, args.nr_entries);
+	if (err) {
+		fprintf(stderr, "failed to resize bloom filter\n");
+		exit(1);
+	}
+
+	err =3D bpf_map__set_nr_hash_funcs(skel->maps.map_bloom_filter, args.nr=
_hash_funcs);
+	if (err) {
+		fprintf(stderr, "failed to set %u hashes\n", args.nr_hash_funcs);
+		exit(1);
+	}
+
+	if (bloom_filter_map__load(skel)) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	return skel;
+}
+
+static void bloom_filter_map_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.skel =3D setup_skeleton();
+
+	populate_maps();
+
+	link =3D bpf_program__attach(ctx.skel->progs.prog_bloom_filter);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void hashmap_lookup_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.skel =3D setup_skeleton();
+
+	populate_maps();
+
+	link =3D bpf_program__attach(ctx.skel->progs.prog_bloom_filter_hashmap_=
lookup);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void measure(struct bench_res *res)
+{
+	long total_hits =3D 0, total_drops =3D 0, total_false_hits =3D 0;
+	unsigned int nr_cpus =3D bpf_num_possible_cpus();
+	BPF_DECLARE_PERCPU(__u64, zeroed_values);
+	BPF_DECLARE_PERCPU(__u64, false_hits);
+	BPF_DECLARE_PERCPU(__u64, drops);
+	BPF_DECLARE_PERCPU(__u64, hits);
+	int err, i, percpu_array_fd;
+	__u32 key;
+
+	if (ctx.skel->bss->error !=3D 0) {
+		fprintf(stderr, "error (%d) when searching the bloom filter\n",
+			ctx.skel->bss->error);
+		exit(1);
+	}
+
+	key =3D ctx.skel->rodata->hit_key;
+	percpu_array_fd =3D bpf_map__fd(ctx.skel->maps.percpu_array);
+	err =3D bpf_map_lookup_elem(percpu_array_fd, &key, hits);
+	if (err) {
+		fprintf(stderr, "lookup in the percpu array  for 'hits' failed: %d\n",
+			-errno);
+		exit(1);
+	}
+
+	key =3D ctx.skel->rodata->drop_key;
+	err =3D bpf_map_lookup_elem(percpu_array_fd, &key, drops);
+	if (err) {
+		fprintf(stderr, "lookup in the percpu array for 'drops' failed: %d\n",
+			-errno);
+		exit(1);
+	}
+
+	key =3D ctx.skel->rodata->false_hit_key;
+	err =3D bpf_map_lookup_elem(percpu_array_fd, &key, false_hits);
+	if (err) {
+		fprintf(stderr, "lookup in the percpu array for 'false hits' failed: %=
d\n",
+			-errno);
+		exit(1);
+	}
+
+	for (i =3D 0; i < nr_cpus; i++) {
+		total_hits +=3D bpf_percpu(hits, i);
+		total_drops +=3D bpf_percpu(drops, i);
+		total_false_hits +=3D bpf_percpu(false_hits, i);
+	}
+
+	res->hits =3D total_hits;
+	res->drops =3D total_drops;
+	res->false_hits =3D total_false_hits;
+
+	memset(zeroed_values, 0, sizeof(zeroed_values));
+
+	/* zero out the percpu array */
+	key =3D ctx.skel->rodata->hit_key;
+	err =3D bpf_map_update_elem(percpu_array_fd, &key, zeroed_values, BPF_A=
NY);
+	if (err) {
+		fprintf(stderr, "zeroing the percpu array failed: %d\n", -errno);
+		exit(1);
+	}
+	key =3D ctx.skel->rodata->drop_key;
+	err =3D bpf_map_update_elem(percpu_array_fd, &key, zeroed_values, BPF_A=
NY);
+	if (err) {
+		fprintf(stderr, "zeroing the percpu array failed: %d\n", -errno);
+		exit(1);
+	}
+	key =3D ctx.skel->rodata->false_hit_key;
+	err =3D bpf_map_update_elem(percpu_array_fd, &key, zeroed_values, BPF_A=
NY);
+	if (err) {
+		fprintf(stderr, "zeroing the percpu array failed: %d\n", -errno);
+		exit(1);
+	}
+}
+
+static void *consumer(void *input)
+{
+	return NULL;
+}
+
+const struct bench bench_bloom_filter_map =3D {
+	.name =3D "bloom-filter-map",
+	.validate =3D validate,
+	.setup =3D bloom_filter_map_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
+
+const struct bench bench_bloom_filter_false_positive =3D {
+	.name =3D "bloom-filter-false-positive",
+	.validate =3D validate,
+	.setup =3D hashmap_lookup_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D false_hits_report_progress,
+	.report_final =3D false_hits_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_ma=
p.sh b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
new file mode 100755
index 000000000000..0dbbd85937e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+header "Bloom filter map"
+for t in 1 4 8; do
+for h in {1..10}; do
+subtitle "# threads: $t, # hashes: $h"
+	for e in 10000 50000 75000 100000 250000 500000 750000 1000000 2500000 =
5000000; do
+		printf "%'d entries -\n" $e
+		printf "\t"
+		summarize "Total operations: " \
+			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e bloom-filter-m=
ap)"
+		printf "\t"
+		summarize_percentage "False positive rate: " \
+			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e bloom-filter-f=
alse-positive)"
+	done
+	printf "\n"
+done
+done
+
+header "Bloom filter map, multi-producer contention"
+for t in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
+	summarize "$t threads - " "$($RUN_BENCH -p $t bloom-filter-map)"
+done
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/t=
ools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
index af4aa04caba6..ada028aa9007 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
@@ -1,34 +1,8 @@
 #!/bin/bash
=20
-set -eufo pipefail
-
-RUN_BENCH=3D"sudo ./bench -w3 -d10 -a"
-
-function hits()
-{
-	echo "$*" | sed -E "s/.*hits\s+([0-9]+\.[0-9]+ =C2=B1 [0-9]+\.[0-9]+M\/=
s).*/\1/"
-}
-
-function drops()
-{
-	echo "$*" | sed -E "s/.*drops\s+([0-9]+\.[0-9]+ =C2=B1 [0-9]+\.[0-9]+M\=
/s).*/\1/"
-}
+source ./benchs/run_common.sh
=20
-function header()
-{
-	local len=3D${#1}
-
-	printf "\n%s\n" "$1"
-	for i in $(seq 1 $len); do printf '=3D'; done
-	printf '\n'
-}
-
-function summarize()
-{
-	bench=3D"$1"
-	summary=3D$(echo $2 | tail -n1)
-	printf "%-20s %s (drops %s)\n" "$bench" "$(hits $summary)" "$(drops $su=
mmary)"
-}
+set -eufo pipefail
=20
 header "Single-producer, parallel producer"
 for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
diff --git a/tools/testing/selftests/bpf/benchs/run_common.sh b/tools/tes=
ting/selftests/bpf/benchs/run_common.sh
new file mode 100644
index 000000000000..670f23b037c4
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_common.sh
@@ -0,0 +1,48 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+RUN_BENCH=3D"sudo ./bench -w3 -d10 -a"
+
+function header()
+{
+	local len=3D${#1}
+
+	printf "\n%s\n" "$1"
+	for i in $(seq 1 $len); do printf '=3D'; done
+	printf '\n'
+}
+
+function subtitle()
+{
+	local len=3D${#1}
+	printf "\t%s\n" "$1"
+}
+
+function hits()
+{
+	echo "$*" | sed -E "s/.*hits\s+([0-9]+\.[0-9]+ =C2=B1 [0-9]+\.[0-9]+M\/=
s).*/\1/"
+}
+
+function drops()
+{
+	echo "$*" | sed -E "s/.*drops\s+([0-9]+\.[0-9]+ =C2=B1 [0-9]+\.[0-9]+M\=
/s).*/\1/"
+}
+
+function percentage()
+{
+	echo "$*" | sed -E "s/.*Percentage\s=3D\s+([0-9]+\.[0-9]+).*/\1/"
+}
+
+function summarize()
+{
+	bench=3D"$1"
+	summary=3D$(echo $2 | tail -n1)
+	printf "%-20s %s (drops %s)\n" "$bench" "$(hits $summary)" "$(drops $su=
mmary)"
+}
+
+function summarize_percentage()
+{
+	bench=3D"$1"
+	summary=3D$(echo $2 | tail -n1)
+	printf "%-20s %s%%\n" "$bench" "$(percentage $summary)"
+}
diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools=
/testing/selftests/bpf/progs/bloom_filter_map.c
index 5925d8dce4ec..05f9706a5ba6 100644
--- a/tools/testing/selftests/bpf/progs/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
=20
+#include <errno.h>
 #include <linux/bpf.h>
+#include <stdbool.h>
 #include <bpf/bpf_helpers.h>
=20
 char _license[] SEC("license") =3D "GPL";
@@ -35,8 +37,38 @@ struct callback_ctx {
 	struct map_bloom_filter_type *map;
 };
=20
+/* Tracks the number of hits, drops, and false hits */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} percpu_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1000);
+	__type(key, __u64);
+	__type(value, __u64);
+} hashmap SEC(".maps");
+
+const __u32 hit_key  =3D 0;
+const __u32 drop_key  =3D 1;
+const __u32 false_hit_key =3D 2;
+
+bool hashmap_use_bloom_filter =3D true;
+
 int error =3D 0;
=20
+static __always_inline void log_result(__u32 key)
+{
+	__u64 *count;
+
+	count =3D bpf_map_lookup_elem(&percpu_array, &key);
+	if (count)
+		*count +=3D 1;
+}
+
 static __u64
 check_elem(struct bpf_map *map, __u32 *key, __u64 *val,
 	   struct callback_ctx *data)
@@ -49,6 +81,8 @@ check_elem(struct bpf_map *map, __u32 *key, __u64 *val,
 		return 1; /* stop the iteration */
 	}
=20
+	log_result(hit_key);
+
 	return 0;
 }
=20
@@ -81,3 +115,43 @@ int prog_bloom_filter_inner_map(void *ctx)
=20
 	return 0;
 }
+
+SEC("fentry/__x64_sys_getpgid")
+int prog_bloom_filter_hashmap_lookup(void *ctx)
+{
+	__u64 *result;
+	int i, err;
+
+	union {
+		__u64 data64;
+		__u32 data32[2];
+	} val;
+
+	for (i =3D 0; i < 512; i++) {
+		val.data32[0] =3D bpf_get_prandom_u32();
+		val.data32[1] =3D bpf_get_prandom_u32();
+
+		if (hashmap_use_bloom_filter) {
+			err =3D bpf_map_peek_elem(&map_bloom_filter, &val);
+			if (err) {
+				if (err !=3D -ENOENT) {
+					error |=3D 3;
+					return 0;
+				}
+				log_result(drop_key);
+				continue;
+			}
+		}
+
+		result =3D bpf_map_lookup_elem(&hashmap, &val);
+		if (result) {
+			log_result(hit_key);
+		} else {
+			if (hashmap_use_bloom_filter)
+				log_result(false_hit_key);
+			log_result(drop_key);
+		}
+	}
+
+	return 0;
+}
--=20
2.30.2

