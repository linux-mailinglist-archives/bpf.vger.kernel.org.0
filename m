Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B4D694087
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 10:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjBMJPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 04:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBMJPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 04:15:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E1B472
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e19so1310885edz.13
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w69FNuUZ3jk27+GAKe+GEWjjeiS+CfJxSH/JqjsYVp4=;
        b=Mz7Pr2qRVbqCTBwWK+QidUDod0IXdccqEmHLS6+UGrR2tG76VL//dQBcdNBEXcDsQd
         XIhaTGEMZt01su9Yrpx3hk9SPgGMVBQqPHACVDtjCBinxydz9txs9oLv5rHedbPHi0Tq
         O3UEAiDGmcgn20Dmctn/GoLwZy3I9cHMgjWqzUY/WZ0H4iEbraLxDJXrniwq6cruASHS
         LDsSEhUwA+/BH3z/998KsbyKwR89tEBIiToUIVcYB453e+yUjYFA0FQcn2GTl0b46xDN
         /VOTAn4utxJDogi7ZOMSWMuznQEpiYj8bXITpVoBS8z7Dc5mxBeNjiIt3aEu/WwbKvn/
         wGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w69FNuUZ3jk27+GAKe+GEWjjeiS+CfJxSH/JqjsYVp4=;
        b=Ysm72SpDwwtxCHPFt/sLDnIWBnzjyHtR8MnmnrqSNSplTA9IJOwHrYuGsbdigEQ9IV
         NHpMvoTcBEtggFK/nxceakS/UE1ADnN/BIg78J9QUEQQotlAITATcteat8mkCojjF5Kk
         +h/Xq7MMvBipCzlofdPKt8OsyWcMMIdHqWM/vr/AMngaPc1kKC8cOFtqOAbXsYogvZ8i
         Hlys3vTa0ELASkvzO0HCk9U1QkRvKammlqt9qKTFtz3GXE4CDrrA4/5NxSyfk3BoPBlx
         kyRoQ87urCJjYwlatGzCVhUNc8E4Q6cXAMYw7S/hzhARpmm5GCSReuBTR/qLrSG9xkNI
         dJhA==
X-Gm-Message-State: AO0yUKUeMfxJvpGGOORJF/U8W9f7yI61FnuV3h5EVhe6lWysGvo3BX2Q
        TtZvpbx27ce7jgopKJybNQ+IF+oMvNZoZOYVEEQ=
X-Google-Smtp-Source: AK7set+B8D2ZPtYVA50U8PBC2iPLUiDnhUw5t3afm+NVCSq87zLzb2AWXtWHmBQcvupMtP51YMnZ/Q==
X-Received: by 2002:a50:8756:0:b0:4ac:b97f:214c with SMTP id 22-20020a508756000000b004acb97f214cmr6596430edv.2.1676279715355;
        Mon, 13 Feb 2023 01:15:15 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm5336587edj.22.2023.02.13.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:15:15 -0800 (PST)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next v2 7/7] selftest/bpf/benchs: Add benchmark for hashmap lookups
Date:   Mon, 13 Feb 2023 09:15:19 +0000
Message-Id: <20230213091519.1202813-8-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213091519.1202813-1-aspsk@isovalent.com>
References: <20230213091519.1202813-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new benchmark which measures hashmap lookup operations speed.  A user can
control the following parameters of the benchmark:

    * key_size (max 1024): the key size to use
    * max_entries: the hashmap max entries
    * nr_entries: the number of entries to insert/lookup
    * nr_loops: the number of loops for the benchmark
    * map_flags The hashmap flags passed to BPF_MAP_CREATE

The BPF program performing the benchmarks calls two nested bpf_loop:

    bpf_loop(nr_loops/nr_entries)
            bpf_loop(nr_entries)
                     bpf_map_lookup()

So the nr_loops determines the number of actual map lookups. All lookups are
successful.

Example (the output is generated on a AMD Ryzen 9 3950X machine):

    for nr_entries in `seq 4096 4096 65536`; do echo -n "$((nr_entries*100/65536))% full: "; sudo ./bench -d2 -a bpf-hashmap-lookup --key_size=4 --nr_entries=$nr_entries --max_entries=65536 --nr_loops=1000000 --map_flags=0x40 | grep cpu; done
    6% full: cpu01: lookup 50.739M ± 0.018M events/sec (approximated from 32 samples of ~19ms)
    12% full: cpu01: lookup 47.751M ± 0.015M events/sec (approximated from 32 samples of ~20ms)
    18% full: cpu01: lookup 45.153M ± 0.013M events/sec (approximated from 32 samples of ~22ms)
    25% full: cpu01: lookup 43.826M ± 0.014M events/sec (approximated from 32 samples of ~22ms)
    31% full: cpu01: lookup 41.971M ± 0.012M events/sec (approximated from 32 samples of ~23ms)
    37% full: cpu01: lookup 41.034M ± 0.015M events/sec (approximated from 32 samples of ~24ms)
    43% full: cpu01: lookup 39.946M ± 0.012M events/sec (approximated from 32 samples of ~25ms)
    50% full: cpu01: lookup 38.256M ± 0.014M events/sec (approximated from 32 samples of ~26ms)
    56% full: cpu01: lookup 36.580M ± 0.018M events/sec (approximated from 32 samples of ~27ms)
    62% full: cpu01: lookup 36.252M ± 0.012M events/sec (approximated from 32 samples of ~27ms)
    68% full: cpu01: lookup 35.200M ± 0.012M events/sec (approximated from 32 samples of ~28ms)
    75% full: cpu01: lookup 34.061M ± 0.009M events/sec (approximated from 32 samples of ~29ms)
    81% full: cpu01: lookup 34.374M ± 0.010M events/sec (approximated from 32 samples of ~29ms)
    87% full: cpu01: lookup 33.244M ± 0.011M events/sec (approximated from 32 samples of ~30ms)
    93% full: cpu01: lookup 32.182M ± 0.013M events/sec (approximated from 32 samples of ~31ms)
    100% full: cpu01: lookup 31.497M ± 0.016M events/sec (approximated from 32 samples of ~31ms)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../bpf/benchs/bench_bpf_hashmap_lookup.c     | 283 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_hashmap_lookup.c  |  63 ++++
 4 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_hashmap_lookup.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c4b5c44cdee2..b4385d843da8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -618,6 +618,7 @@ $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
 $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_update_bench.skel.h
 $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
+$(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -632,7 +633,9 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_strncmp.o \
 		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
 		 $(OUTPUT)/bench_local_storage.o \
-		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o
+		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
+		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
+		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 767ca679ee67..0b2a53bb8460 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -277,6 +277,7 @@ extern struct argp bench_bpf_loop_argp;
 extern struct argp bench_local_storage_argp;
 extern struct argp bench_local_storage_rcu_tasks_trace_argp;
 extern struct argp bench_strncmp_argp;
+extern struct argp bench_hashmap_lookup_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -286,6 +287,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_strncmp_argp, 0, "bpf_strncmp helper benchmark", 0 },
 	{ &bench_local_storage_rcu_tasks_trace_argp, 0,
 		"local_storage RCU Tasks Trace slowdown benchmark", 0 },
+	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
 	{},
 };
 
@@ -512,6 +514,7 @@ extern const struct bench bench_local_storage_cache_seq_get;
 extern const struct bench bench_local_storage_cache_interleaved_get;
 extern const struct bench bench_local_storage_cache_hashmap_control;
 extern const struct bench bench_local_storage_tasks_trace;
+extern const struct bench bench_bpf_hashmap_lookup;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -551,6 +554,7 @@ static const struct bench *benchs[] = {
 	&bench_local_storage_cache_interleaved_get,
 	&bench_local_storage_cache_hashmap_control,
 	&bench_local_storage_tasks_trace,
+	&bench_bpf_hashmap_lookup,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
new file mode 100644
index 000000000000..8dbb02f75cff
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+
+#include <sys/random.h>
+#include <argp.h>
+#include "bench.h"
+#include "bpf_hashmap_lookup.skel.h"
+#include "bpf_util.h"
+
+/* BPF triggering benchmarks */
+static struct ctx {
+	struct bpf_hashmap_lookup *skel;
+} ctx;
+
+/* only available to kernel, so define it here */
+#define BPF_MAX_LOOPS (1<<23)
+
+#define MAX_KEY_SIZE 1024 /* the size of the key map */
+
+static struct {
+	__u32 key_size;
+	__u32 map_flags;
+	__u32 max_entries;
+	__u32 nr_entries;
+	__u32 nr_loops;
+} args = {
+	.key_size = 4,
+	.map_flags = 0,
+	.max_entries = 1000,
+	.nr_entries = 500,
+	.nr_loops = 1000000,
+};
+
+enum {
+	ARG_KEY_SIZE = 8001,
+	ARG_MAP_FLAGS,
+	ARG_MAX_ENTRIES,
+	ARG_NR_ENTRIES,
+	ARG_NR_LOOPS,
+};
+
+static const struct argp_option opts[] = {
+	{ "key_size", ARG_KEY_SIZE, "KEY_SIZE", 0,
+	  "The hashmap key size (max 1024)"},
+	{ "map_flags", ARG_MAP_FLAGS, "MAP_FLAGS", 0,
+	  "The hashmap flags passed to BPF_MAP_CREATE"},
+	{ "max_entries", ARG_MAX_ENTRIES, "MAX_ENTRIES", 0,
+	  "The hashmap max entries"},
+	{ "nr_entries", ARG_NR_ENTRIES, "NR_ENTRIES", 0,
+	  "The number of entries to insert/lookup"},
+	{ "nr_loops", ARG_NR_LOOPS, "NR_LOOPS", 0,
+	  "The number of loops for the benchmark"},
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	long ret;
+
+	switch (key) {
+	case ARG_KEY_SIZE:
+		ret = strtol(arg, NULL, 10);
+		if (ret < 1 || ret > MAX_KEY_SIZE) {
+			fprintf(stderr, "invalid key_size");
+			argp_usage(state);
+		}
+		args.key_size = ret;
+		break;
+	case ARG_MAP_FLAGS:
+		ret = strtol(arg, NULL, 0);
+		if (ret < 0 || ret > UINT_MAX) {
+			fprintf(stderr, "invalid map_flags");
+			argp_usage(state);
+		}
+		args.map_flags = ret;
+		break;
+	case ARG_MAX_ENTRIES:
+		ret = strtol(arg, NULL, 10);
+		if (ret < 1 || ret > UINT_MAX) {
+			fprintf(stderr, "invalid max_entries");
+			argp_usage(state);
+		}
+		args.max_entries = ret;
+		break;
+	case ARG_NR_ENTRIES:
+		ret = strtol(arg, NULL, 10);
+		if (ret < 1 || ret > UINT_MAX) {
+			fprintf(stderr, "invalid nr_entries");
+			argp_usage(state);
+		}
+		args.nr_entries = ret;
+		break;
+	case ARG_NR_LOOPS:
+		ret = strtol(arg, NULL, 10);
+		if (ret < 1 || ret > BPF_MAX_LOOPS) {
+			fprintf(stderr, "invalid nr_loops: %ld (min=1 max=%u)\n",
+				ret, BPF_MAX_LOOPS);
+			argp_usage(state);
+		}
+		args.nr_loops = ret;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_hashmap_lookup_argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
+
+static void validate(void)
+{
+	if (env.consumer_cnt != 1) {
+		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
+		exit(1);
+	}
+
+	if (args.nr_entries > args.max_entries) {
+		fprintf(stderr, "args.nr_entries is too big! (max %u, got %u)\n",
+			args.max_entries, args.nr_entries);
+		exit(1);
+	}
+}
+
+static void *producer(void *input)
+{
+	while (true) {
+		/* trigger the bpf program */
+		syscall(__NR_getpgid);
+	}
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
+}
+
+static inline void patch_key(u32 i, u32 *key)
+{
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	*key = i + 1;
+#else
+	*key = __builtin_bswap32(i + 1);
+#endif
+	/* the rest of key is random */
+}
+
+static void setup(void)
+{
+	struct bpf_link *link;
+	int map_fd;
+	int ret;
+	int i;
+
+	setup_libbpf();
+
+	ctx.skel = bpf_hashmap_lookup__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	bpf_map__set_max_entries(ctx.skel->maps.hash_map_bench, args.max_entries);
+	bpf_map__set_key_size(ctx.skel->maps.hash_map_bench, args.key_size);
+	bpf_map__set_value_size(ctx.skel->maps.hash_map_bench, 8);
+	bpf_map__set_map_flags(ctx.skel->maps.hash_map_bench, args.map_flags);
+
+	ctx.skel->bss->nr_entries = args.nr_entries;
+	ctx.skel->bss->nr_loops = args.nr_loops / args.nr_entries;
+
+	if (args.key_size > 4) {
+		for (i = 1; i < args.key_size/4; i++)
+			ctx.skel->bss->key[i] = 2654435761 * i;
+	}
+
+	ret = bpf_hashmap_lookup__load(ctx.skel);
+	if (ret) {
+		bpf_hashmap_lookup__destroy(ctx.skel);
+		fprintf(stderr, "failed to load map: %s", strerror(-ret));
+		exit(1);
+	}
+
+	/* fill in the hash_map */
+	map_fd = bpf_map__fd(ctx.skel->maps.hash_map_bench);
+	for (u64 i = 0; i < args.nr_entries; i++) {
+		patch_key(i, ctx.skel->bss->key);
+		bpf_map_update_elem(map_fd, ctx.skel->bss->key, &i, BPF_ANY);
+	}
+
+	link = bpf_program__attach(ctx.skel->progs.benchmark);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static inline double events_from_time(u64 time)
+{
+	if (time)
+		return args.nr_loops * 1000000000llu / time / 1000000.0L;
+
+	return 0;
+}
+
+static int compute_events(u64 *times, double *events_mean, double *events_stddev, u64 *mean_time)
+{
+	int i, n = 0;
+
+	*events_mean = 0;
+	*events_stddev = 0;
+	*mean_time = 0;
+
+	for (i = 0; i < 32; i++) {
+		if (!times[i])
+			break;
+		*mean_time += times[i];
+		*events_mean += events_from_time(times[i]);
+		n += 1;
+	}
+	if (!n)
+		return 0;
+
+	*mean_time /= n;
+	*events_mean /= n;
+
+	if (n > 1) {
+		for (i = 0; i < n; i++) {
+			double events_i = *events_mean - events_from_time(times[i]);
+			*events_stddev += events_i * events_i / (n - 1);
+		}
+		*events_stddev = sqrt(*events_stddev);
+	}
+
+	return n;
+}
+
+static void hashmap_report_final(struct bench_res res[], int res_cnt)
+{
+	unsigned int nr_cpus = bpf_num_possible_cpus();
+	double events_mean, events_stddev;
+	u64 mean_time;
+	int i, n;
+
+	for (i = 0; i < nr_cpus; i++) {
+		n = compute_events(ctx.skel->bss->percpu_times[i], &events_mean,
+				   &events_stddev, &mean_time);
+		if (n == 0)
+			continue;
+
+		if (env.quiet) {
+			/* we expect only one cpu to be present */
+			if (env.affinity)
+				printf("%.3lf\n", events_mean);
+			else
+				printf("cpu%02d %.3lf\n", i, events_mean);
+		} else {
+			printf("cpu%02d: lookup %.3lfM ± %.3lfM events/sec"
+			       " (approximated from %d samples of ~%lums)\n",
+			       i, events_mean, 2*events_stddev,
+			       n, mean_time / 1000000);
+		}
+	}
+}
+
+const struct bench bench_bpf_hashmap_lookup = {
+	.name = "bpf-hashmap-lookup",
+	.argp = &bench_hashmap_lookup_argp,
+	.validate = validate,
+	.setup = setup,
+	.producer_thread = producer,
+	.consumer_thread = consumer,
+	.measure = measure,
+	.report_progress = NULL,
+	.report_final = hashmap_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_hashmap_lookup.c b/tools/testing/selftests/bpf/progs/bpf_hashmap_lookup.c
new file mode 100644
index 000000000000..1eb74ddca414
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_hashmap_lookup.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+} hash_map_bench SEC(".maps");
+
+/* The number of slots to store times */
+#define NR_SLOTS 32
+#define NR_CPUS 256
+#define CPU_MASK (NR_CPUS-1)
+
+/* Configured by userspace */
+u64 nr_entries;
+u64 nr_loops;
+u32 __attribute__((__aligned__(8))) key[NR_CPUS];
+
+/* Filled by us */
+u64 __attribute__((__aligned__(256))) percpu_times_index[NR_CPUS];
+u64 __attribute__((__aligned__(256))) percpu_times[NR_CPUS][NR_SLOTS];
+
+static inline void patch_key(u32 i)
+{
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	key[0] = i + 1;
+#else
+	key[0] = __builtin_bswap32(i + 1);
+#endif
+	/* the rest of key is random and is configured by userspace */
+}
+
+static int lookup_callback(__u32 index, u32 *unused)
+{
+	patch_key(index);
+	return bpf_map_lookup_elem(&hash_map_bench, key) ? 0 : 1;
+}
+
+static int loop_lookup_callback(__u32 index, u32 *unused)
+{
+	return bpf_loop(nr_entries, lookup_callback, NULL, 0) ? 0 : 1;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int benchmark(void *ctx)
+{
+	u32 cpu = bpf_get_smp_processor_id();
+	u32 times_index;
+	u64 start_time;
+
+	times_index = percpu_times_index[cpu & CPU_MASK] % NR_SLOTS;
+	start_time = bpf_ktime_get_ns();
+	bpf_loop(nr_loops, loop_lookup_callback, NULL, 0);
+	percpu_times[cpu & CPU_MASK][times_index] = bpf_ktime_get_ns() - start_time;
+	percpu_times_index[cpu & CPU_MASK] += 1;
+	return 0;
+}
-- 
2.34.1

