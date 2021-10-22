Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99EE43801B
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhJVWGT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 18:06:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234230AbhJVWGT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 18:06:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19MLCBgn007837
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:04:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=5W3xyqz53FFnTxSWqADEiS6RK4QYV02SLUKQ9n41bWM=;
 b=a56WfJh1Yd3pr9vhym71y5YKolm3DhsOEd/iFWz+kZoPM+lnWr9R9MXbLP+IeLOMb7/c
 daa5NcnhlbCYcFdq+ravvsS5QhOa5aKywze2I5esXZtoUusog7HnyoxP5bu0CsDNZTeT
 0gpcZ7A7MMqivUtJvQzqjA9ptrlE52qWXEQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3buktt8tcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:04:00 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 15:03:58 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id C16AF3EE3872; Fri, 22 Oct 2021 15:03:50 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v5 bpf-next 4/5] bpf/benchs: Add benchmark tests for bloom filter throughput + false positive
Date:   Fri, 22 Oct 2021 15:02:48 -0700
Message-ID: <20211022220249.2040337-5-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022220249.2040337-1-joannekoong@fb.com>
References: <20211022220249.2040337-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: eWeVptvs_2Tg3bmbztwXTvd58HadqYE2
X-Proofpoint-ORIG-GUID: eWeVptvs_2Tg3bmbztwXTvd58HadqYE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110220124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds benchmark tests for the throughput (for lookups + updates=
)
and the false positive rate of bloom filter lookups, as well as some
minor refactoring of the bash script for running the benchmarks.

These benchmarks show that as the number of hash functions increases,
the throughput and the false positive rate of the bloom filter decreases.
From the benchmark data, the approximate average false-positive rates for
8-byte values are roughly as follows:

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
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/bench.c           |  37 ++
 tools/testing/selftests/bpf/bench.h           |   3 +
 .../bpf/benchs/bench_bloom_filter_map.c       | 420 ++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
 .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
 .../selftests/bpf/benchs/run_common.sh        |  48 ++
 .../selftests/bpf/progs/bloom_filter_bench.c  | 153 +++++++
 8 files changed, 695 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter=
_map.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_fi=
lter_map.sh
 create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.=
c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 498222543c37..ee4f4c8b9cd4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -525,18 +525,20 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_cor=
e_extern.skel.h $(BPFOBJ)
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
 	$(call msg,CC,,$@)
-	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
 $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
 			    $(OUTPUT)/perfbuf_bench.skel.h
+$(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
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
index 6ea15b93a2f8..a1d5dffe5ef6 100644
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
+extern struct argp bench_bloom_map_argp;
=20
 static const struct argp_child bench_parsers[] =3D {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
+	{ &bench_bloom_map_argp, 0, "Bloom filter map benchmark", 0 },
 	{},
 };
=20
@@ -323,6 +354,9 @@ extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
 extern const struct bench bench_pb_libbpf;
 extern const struct bench bench_pb_custom;
+extern const struct bench bench_bloom_lookup;
+extern const struct bench bench_bloom_update;
+extern const struct bench bench_bloom_false_positive;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -344,6 +378,9 @@ static const struct bench *benchs[] =3D {
 	&bench_rb_custom,
 	&bench_pb_libbpf,
 	&bench_pb_custom,
+	&bench_bloom_lookup,
+	&bench_bloom_update,
+	&bench_bloom_false_positive,
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
index 000000000000..469d99002d6a
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <argp.h>
+#include <linux/log2.h>
+#include <pthread.h>
+#include "bench.h"
+#include "bloom_filter_bench.skel.h"
+#include "bpf_util.h"
+
+static struct ctx {
+	bool use_array_map;
+	bool use_hashmap;
+	bool hashmap_use_bloom;
+	bool count_false_hits;
+
+	struct bloom_filter_bench *skel;
+
+	int bloom_fd;
+	int hashmap_fd;
+	int array_map_fd;
+
+	pthread_mutex_t map_done_mtx;
+	pthread_cond_t map_done_cv;
+	bool map_done;
+	bool map_prepare_err;
+
+	__u32 next_map_idx;
+} ctx =3D {
+	.map_done_mtx =3D PTHREAD_MUTEX_INITIALIZER,
+	.map_done_cv =3D PTHREAD_COND_INITIALIZER,
+};
+
+struct stat {
+	__u32 stats[3];
+};
+
+static struct {
+	__u32 nr_entries;
+	__u8 nr_hash_funcs;
+	__u8 value_size;
+} args =3D {
+	.nr_entries =3D 1000,
+	.nr_hash_funcs =3D 3,
+	.value_size =3D 8,
+};
+
+enum {
+	ARG_NR_ENTRIES =3D 3000,
+	ARG_NR_HASH_FUNCS =3D 3001,
+	ARG_VALUE_SIZE =3D 3002,
+};
+
+static const struct argp_option opts[] =3D {
+	{ "nr_entries", ARG_NR_ENTRIES, "NR_ENTRIES", 0,
+		"Set number of expected unique entries in the bloom filter"},
+	{ "nr_hash_funcs", ARG_NR_HASH_FUNCS, "NR_HASH_FUNCS", 0,
+		"Set number of hash functions in the bloom filter"},
+	{ "value_size", ARG_VALUE_SIZE, "VALUE_SIZE", 0,
+		"Set value size (in bytes) of bloom filter entries"},
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
+		if (args.nr_hash_funcs =3D=3D 0 || args.nr_hash_funcs > 15) {
+			fprintf(stderr,
+				"The bloom filter must use 1 to 15 hash functions.");
+			argp_usage(state);
+		}
+		break;
+	case ARG_VALUE_SIZE:
+		args.value_size =3D strtol(arg, NULL, 10);
+		if (args.value_size < 2 || args.value_size > 256) {
+			fprintf(stderr,
+				"Invalid value size. Must be between 2 and 256 bytes");
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
+const struct argp bench_bloom_map_argp =3D {
+	.options =3D opts,
+	.parser =3D parse_arg,
+};
+
+static void validate(void)
+{
+	if (env.consumer_cnt !=3D 1) {
+		fprintf(stderr,
+			"The bloom filter benchmarks do not support multi-consumer use\n");
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
+	__u32 val_size, i;
+	void *val =3D NULL;
+	int err;
+
+	val_size =3D args.value_size;
+	val =3D malloc(val_size);
+	if (!val) {
+		ctx.map_prepare_err =3D true;
+		goto done;
+	}
+
+	while (true) {
+		i =3D __atomic_add_fetch(&ctx.next_map_idx, 1, __ATOMIC_RELAXED);
+		if (i > args.nr_entries)
+			break;
+
+again:
+		/* Populate hashmap, bloom filter map, and array map with the same
+		 * random values
+		 */
+		err =3D syscall(__NR_getrandom, val, val_size, 0);
+		if (err !=3D val_size) {
+			ctx.map_prepare_err =3D true;
+			fprintf(stderr, "failed to get random value: %d\n", -errno);
+			break;
+		}
+
+		if (ctx.use_hashmap) {
+			err =3D bpf_map_update_elem(ctx.hashmap_fd, val, val, BPF_NOEXIST);
+			if (err) {
+				if (err !=3D -EEXIST) {
+					ctx.map_prepare_err =3D true;
+					fprintf(stderr, "failed to add elem to hashmap: %d\n",
+						-errno);
+					break;
+				}
+				goto again;
+			}
+		}
+
+		i--;
+
+		if (ctx.use_array_map) {
+			err =3D bpf_map_update_elem(ctx.array_map_fd, &i, val, 0);
+			if (err) {
+				ctx.map_prepare_err =3D true;
+				fprintf(stderr, "failed to add elem to array map: %d\n", -errno);
+				break;
+			}
+		}
+
+		if (ctx.use_hashmap && !ctx.hashmap_use_bloom)
+			continue;
+
+		err =3D bpf_map_update_elem(ctx.bloom_fd, NULL, val, 0);
+		if (err) {
+			ctx.map_prepare_err =3D true;
+			fprintf(stderr,
+				"failed to add elem to bloom filter map: %d\n", -errno);
+			break;
+		}
+	}
+done:
+	pthread_mutex_lock(&ctx.map_done_mtx);
+	ctx.map_done =3D true;
+	pthread_cond_signal(&ctx.map_done_cv);
+	pthread_mutex_unlock(&ctx.map_done_mtx);
+
+	if (val)
+		free(val);
+
+	return NULL;
+}
+
+static void populate_maps(void)
+{
+	unsigned int nr_cpus =3D bpf_num_possible_cpus();
+	pthread_t map_thread;
+	int i, err, nr_rand_bytes;
+
+	ctx.bloom_fd =3D bpf_map__fd(ctx.skel->maps.bloom_map);
+	ctx.hashmap_fd =3D bpf_map__fd(ctx.skel->maps.hashmap);
+	ctx.array_map_fd =3D bpf_map__fd(ctx.skel->maps.array_map);
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
+	while (!ctx.map_done)
+		pthread_cond_wait(&ctx.map_done_cv, &ctx.map_done_mtx);
+	pthread_mutex_unlock(&ctx.map_done_mtx);
+
+	if (ctx.map_prepare_err)
+		exit(1);
+
+	nr_rand_bytes =3D syscall(__NR_getrandom, ctx.skel->bss->rand_vals,
+		      ctx.skel->rodata->nr_rand_bytes, 0);
+	if (nr_rand_bytes !=3D ctx.skel->rodata->nr_rand_bytes) {
+		fprintf(stderr, "failed to get random bytes\n");
+		exit(1);
+	}
+}
+
+static void check_args(void)
+{
+	if (args.value_size < 8)  {
+		__u64 nr_unique_entries =3D 1ULL << (args.value_size * 8);
+
+		if (args.nr_entries > nr_unique_entries) {
+			fprintf(stderr,
+				"Not enough unique values for the nr_entries requested\n");
+			exit(1);
+		}
+	}
+}
+
+static struct bloom_filter_bench *setup_skeleton(void)
+{
+	struct bloom_filter_bench *skel;
+
+	check_args();
+
+	setup_libbpf();
+
+	skel =3D bloom_filter_bench__open();
+	if (!skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	skel->rodata->hashmap_use_bloom =3D ctx.hashmap_use_bloom;
+	skel->rodata->count_false_hits =3D ctx.count_false_hits;
+
+	/* Resize number of entries */
+	bpf_map__set_max_entries(skel->maps.hashmap, args.nr_entries);
+
+	bpf_map__set_max_entries(skel->maps.array_map, args.nr_entries);
+
+	bpf_map__set_max_entries(skel->maps.bloom_map, args.nr_entries);
+
+	/* Set value size */
+	bpf_map__set_value_size(skel->maps.array_map, args.value_size);
+
+	bpf_map__set_value_size(skel->maps.bloom_map, args.value_size);
+
+	bpf_map__set_value_size(skel->maps.hashmap, args.value_size);
+
+	/* For the hashmap, we use the value as the key as well */
+	bpf_map__set_key_size(skel->maps.hashmap, args.value_size);
+
+	skel->bss->value_size =3D args.value_size;
+
+	/* Set number of hash functions */
+	bpf_map__set_map_extra(skel->maps.bloom_map, args.nr_hash_funcs);
+
+	if (bloom_filter_bench__load(skel)) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	return skel;
+}
+
+static void bloom_lookup_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.use_array_map =3D true;
+
+	ctx.skel =3D setup_skeleton();
+
+	populate_maps();
+
+	link =3D bpf_program__attach(ctx.skel->progs.bloom_lookup);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void bloom_update_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.use_array_map =3D true;
+
+	ctx.skel =3D setup_skeleton();
+
+	populate_maps();
+
+	link =3D bpf_program__attach(ctx.skel->progs.bloom_update);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void false_positive_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.use_hashmap =3D true;
+	ctx.hashmap_use_bloom =3D true;
+	ctx.count_false_hits =3D true;
+
+	ctx.skel =3D setup_skeleton();
+
+	populate_maps();
+
+	link =3D bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void measure(struct bench_res *res)
+{
+	unsigned long total_hits =3D 0, total_drops =3D 0, total_false_hits =3D=
 0;
+	static unsigned long last_hits, last_drops, last_false_hits;
+	unsigned int nr_cpus =3D bpf_num_possible_cpus();
+	int hit_key, drop_key, false_hit_key;
+	int i;
+
+	hit_key =3D ctx.skel->rodata->hit_key;
+	drop_key =3D ctx.skel->rodata->drop_key;
+	false_hit_key =3D ctx.skel->rodata->false_hit_key;
+
+	if (ctx.skel->bss->error !=3D 0) {
+		fprintf(stderr, "error (%d) when searching the bloom filter\n",
+			ctx.skel->bss->error);
+		exit(1);
+	}
+
+	for (i =3D 0; i < nr_cpus; i++) {
+		struct stat *s =3D (void *)&ctx.skel->bss->percpu_stats[i];
+
+		total_hits +=3D s->stats[hit_key];
+		total_drops +=3D s->stats[drop_key];
+		total_false_hits +=3D s->stats[false_hit_key];
+	}
+
+	res->hits =3D total_hits - last_hits;
+	res->drops =3D total_drops - last_drops;
+	res->false_hits =3D total_false_hits - last_false_hits;
+
+	last_hits =3D total_hits;
+	last_drops =3D total_drops;
+	last_false_hits =3D total_false_hits;
+}
+
+static void *consumer(void *input)
+{
+	return NULL;
+}
+
+const struct bench bench_bloom_lookup =3D {
+	.name =3D "bloom-lookup",
+	.validate =3D validate,
+	.setup =3D bloom_lookup_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
+
+const struct bench bench_bloom_update =3D {
+	.name =3D "bloom-update",
+	.validate =3D validate,
+	.setup =3D bloom_update_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
+
+const struct bench bench_bloom_false_positive =3D {
+	.name =3D "bloom-false-positive",
+	.validate =3D validate,
+	.setup =3D false_positive_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D false_hits_report_progress,
+	.report_final =3D false_hits_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_ma=
p.sh b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
new file mode 100755
index 000000000000..b2db39bd3236
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
+for v in 2, 4, 8, 16, 40; do
+for t in 1 4 8 12 16; do
+for h in {1..10}; do
+subtitle "value_size: $v bytes, # threads: $t, # hashes: $h"
+	for e in 10000 50000 75000 100000 250000 500000 750000 1000000 2500000 =
5000000; do
+		printf "%'d entries -\n" $e
+		printf "\t"
+		summarize "Lookups, total operations: " \
+			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e --value_size $=
v bloom-lookup)"
+		printf "\t"
+		summarize "Updates, total operations: " \
+			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e --value_size $=
v bloom-update)"
+		printf "\t"
+		summarize_percentage "False positive rate: " \
+			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e --value_size $=
v bloom-false-positive)"
+	done
+	printf "\n"
+done
+done
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
diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_bench.c b/too=
ls/testing/selftests/bpf/progs/bloom_filter_bench.c
new file mode 100644
index 000000000000..f02fa137bd93
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bloom_filter_bench.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <errno.h>
+#include <linux/bpf.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct bpf_map;
+
+__u8 rand_vals[2500000];
+const __u32 nr_rand_bytes =3D 2500000;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	/* max entries and value_size will be set programmatically.
+	 * They are configurable from the userspace bench program.
+	 */
+} array_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
+	/* max entries,  value_size, and # of hash functions will be set
+	 * programmatically. They are configurable from the userspace
+	 * bench program.
+	 */
+	__uint(map_extra, 3);
+} bloom_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	/* max entries, key_size, and value_size, will be set
+	 * programmatically. They are configurable from the userspace
+	 * bench program.
+	 */
+} hashmap SEC(".maps");
+
+struct callback_ctx {
+	struct bpf_map *map;
+	bool update;
+};
+
+/* Tracks the number of hits, drops, and false hits */
+struct {
+	__u32 stats[3];
+} __attribute__((__aligned__(256))) percpu_stats[256];
+
+const __u32 hit_key  =3D 0;
+const __u32 drop_key  =3D 1;
+const __u32 false_hit_key =3D 2;
+
+__u8 value_size;
+
+const volatile bool hashmap_use_bloom =3D false;
+const volatile bool count_false_hits =3D false;
+
+int error =3D 0;
+
+static __always_inline void log_result(__u32 key)
+{
+	__u32 cpu =3D bpf_get_smp_processor_id();
+
+	percpu_stats[cpu & 255].stats[key]++;
+}
+
+static __u64
+bloom_callback(struct bpf_map *map, __u32 *key, void *val,
+		      struct callback_ctx *data)
+{
+	int err;
+
+	if (data->update)
+		err =3D bpf_map_push_elem(data->map, val, 0);
+	else
+		err =3D bpf_map_peek_elem(data->map, val);
+
+	if (err) {
+		error |=3D 1;
+		return 1; /* stop the iteration */
+	}
+
+	log_result(hit_key);
+
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int bloom_lookup(void *ctx)
+{
+	struct callback_ctx data;
+
+	data.map =3D (struct bpf_map *)&bloom_map;
+	data.update =3D false;
+
+	bpf_for_each_map_elem(&array_map, bloom_callback, &data, 0);
+
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int bloom_update(void *ctx)
+{
+	struct callback_ctx data;
+
+	data.map =3D (struct bpf_map *)&bloom_map;
+	data.update =3D true;
+
+	bpf_for_each_map_elem(&array_map, bloom_callback, &data, 0);
+
+	return 0;
+}
+
+SEC("fentry/__x64_sys_getpgid")
+int bloom_hashmap_lookup(void *ctx)
+{
+	__u64 *result;
+	int i, err;
+
+	__u32 index =3D bpf_get_prandom_u32();
+
+	for (i =3D 0; i < 1024; i++, index +=3D value_size) {
+		if (index >=3D nr_rand_bytes)
+			index =3D index & ((1ULL << 21) - 1);
+
+		if (hashmap_use_bloom) {
+			err =3D bpf_map_peek_elem(&bloom_map,
+						rand_vals + index);
+			if (err) {
+				if (err !=3D -ENOENT) {
+					error |=3D 2;
+					return 0;
+				}
+				log_result(hit_key);
+				continue;
+			}
+		}
+
+		result =3D bpf_map_lookup_elem(&hashmap,
+					     rand_vals + index);
+		if (result) {
+			log_result(hit_key);
+		} else {
+			if (hashmap_use_bloom && count_false_hits)
+				log_result(false_hit_key);
+			log_result(drop_key);
+		}
+	}
+
+	return 0;
+}
--=20
2.30.2

