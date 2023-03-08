Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B446AFF61
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCHHAk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCHHAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:33 -0500
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA087A2F00
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:30 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/pYLHWncR6EokqtdAYwSWuBGF4YY9uw0o73HE4yqZg=;
        b=G0QG8OHZtE60VlNIFFuuMqU48gsZBI93mQ9jYW3tFmD1RbbXuV+XCRKV17tZ36tOKivkvF
        OSnXsf/hhX4qdybjDpAgXArRg4CZViD1Ae86iWoJFmtomcCLOge2SV65wihuCoDCnXic6G
        SBdKvrhyr/W7hO2zXq3nWVqWVhHiBwQ=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 17/17] selftests/bpf: Add local-storage-create benchmark
Date:   Tue,  7 Mar 2023 22:59:36 -0800
Message-Id: <20230308065936.1550103-18-martin.lau@linux.dev>
In-Reply-To: <20230308065936.1550103-1-martin.lau@linux.dev>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch tests how many kmallocs is needed to create and free
a batch of UDP sockets and each socket has a 64bytes bpf storage.
It also measures how fast the UDP sockets can be created.

The result is from my qemu setup.

Before bpf_mem_cache_alloc/free:
./bench -p 1 local-storage-create
Setting up benchmark 'local-storage-create'...
Benchmark 'local-storage-create' started.
Iter   0 ( 73.193us): creates  213.552k/s (213.552k/prod), 3.09 kmallocs/create
Iter   1 (-20.724us): creates  211.908k/s (211.908k/prod), 3.09 kmallocs/create
Iter   2 (  9.280us): creates  212.574k/s (212.574k/prod), 3.12 kmallocs/create
Iter   3 ( 11.039us): creates  213.209k/s (213.209k/prod), 3.12 kmallocs/create
Iter   4 (-11.411us): creates  213.351k/s (213.351k/prod), 3.12 kmallocs/create
Iter   5 ( -7.915us): creates  214.754k/s (214.754k/prod), 3.12 kmallocs/create
Iter   6 ( 11.317us): creates  210.942k/s (210.942k/prod), 3.12 kmallocs/create
Summary: creates  212.789 ± 1.310k/s (212.789k/prod), 3.12 kmallocs/create

After bpf_mem_cache_alloc/free:
./bench -p 1 local-storage-create
Setting up benchmark 'local-storage-create'...
Benchmark 'local-storage-create' started.
Iter   0 ( 68.265us): creates  243.984k/s (243.984k/prod), 1.04 kmallocs/create
Iter   1 ( 30.357us): creates  238.424k/s (238.424k/prod), 1.04 kmallocs/create
Iter   2 (-18.712us): creates  232.963k/s (232.963k/prod), 1.04 kmallocs/create
Iter   3 (-15.885us): creates  238.879k/s (238.879k/prod), 1.04 kmallocs/create
Iter   4 (  5.590us): creates  237.490k/s (237.490k/prod), 1.04 kmallocs/create
Iter   5 (  8.577us): creates  237.521k/s (237.521k/prod), 1.04 kmallocs/create
Iter   6 ( -6.263us): creates  238.508k/s (238.508k/prod), 1.04 kmallocs/create
Summary: creates  237.298 ± 2.198k/s (237.298k/prod), 1.04 kmallocs/create

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../bpf/benchs/bench_local_storage_create.c   | 141 ++++++++++++++++++
 .../bpf/progs/bench_local_storage_create.c    |  57 +++++++
 4 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
 create mode 100644 tools/testing/selftests/bpf/progs/bench_local_storage_create.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 16f404aa1b23..545fff0a6dfc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -639,6 +639,7 @@ $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
 $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_update_bench.skel.h
 $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
+$(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.skel.h
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
@@ -656,6 +657,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_local_storage.o \
 		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
 		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
+		 $(OUTPUT)/bench_local_storage_create.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 0b2a53bb8460..dc3827c1f139 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -515,6 +515,7 @@ extern const struct bench bench_local_storage_cache_interleaved_get;
 extern const struct bench bench_local_storage_cache_hashmap_control;
 extern const struct bench bench_local_storage_tasks_trace;
 extern const struct bench bench_bpf_hashmap_lookup;
+extern const struct bench bench_local_storage_create;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -555,6 +556,7 @@ static const struct bench *benchs[] = {
 	&bench_local_storage_cache_hashmap_control,
 	&bench_local_storage_tasks_trace,
 	&bench_bpf_hashmap_lookup,
+	&bench_local_storage_create,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
new file mode 100644
index 000000000000..f8b2a640ccbe
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include "bench.h"
+#include "bench_local_storage_create.skel.h"
+
+#define BATCH_SZ 32
+
+struct thread {
+	int fds[BATCH_SZ];
+};
+
+static struct bench_local_storage_create *skel;
+static struct thread *threads;
+static long socket_errs;
+
+static void validate(void)
+{
+	if (env.consumer_cnt > 1) {
+		fprintf(stderr,
+			"local-storage-create benchmark does not need consumer\n");
+		exit(1);
+	}
+}
+
+static void setup(void)
+{
+	skel = bench_local_storage_create__open_and_load();
+	if (!skel) {
+		fprintf(stderr, "error loading skel\n");
+		exit(1);
+	}
+
+	skel->bss->bench_pid = getpid();
+
+	if (!bpf_program__attach(skel->progs.socket_post_create)) {
+		fprintf(stderr, "Error attaching bpf program\n");
+		exit(1);
+	}
+
+	if (!bpf_program__attach(skel->progs.kmalloc)) {
+		fprintf(stderr, "Error attaching bpf program\n");
+		exit(1);
+	}
+
+	threads = calloc(env.producer_cnt, sizeof(*threads));
+
+	if (!threads) {
+		fprintf(stderr, "cannot alloc thread_res\n");
+		exit(1);
+	}
+}
+
+static void measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&skel->bss->create_cnts, 0);
+	res->drops = atomic_swap(&skel->bss->kmalloc_cnts, 0);
+}
+
+static void *consumer(void *input)
+{
+	return NULL;
+}
+
+static void *producer(void *input)
+{
+	struct thread *t = &threads[(long)(input)];
+	int *fds = t->fds;
+	int i;
+
+	while (true) {
+		for (i = 0; i < BATCH_SZ; i++) {
+			fds[i] = socket(AF_INET6, SOCK_DGRAM, 0);
+			if (fds[i] == -1)
+				atomic_inc(&socket_errs);
+		}
+
+		for (i = 0; i < BATCH_SZ; i++) {
+			if (fds[i] != -1)
+				close(fds[i]);
+		}
+	}
+
+	return NULL;
+}
+
+static void report_progress(int iter, struct bench_res *res, long delta_ns)
+{
+	double creates_per_sec, kmallocs_per_create;
+
+	creates_per_sec = res->hits / 1000.0 / (delta_ns / 1000000000.0);
+	kmallocs_per_create = (double)res->drops / res->hits;
+
+	printf("Iter %3d (%7.3lfus): ",
+	       iter, (delta_ns - 1000000000) / 1000.0);
+	printf("creates %8.3lfk/s (%7.3lfk/prod), ",
+	       creates_per_sec, creates_per_sec / env.producer_cnt);
+	printf("%3.2lf kmallocs/create\n", kmallocs_per_create);
+}
+
+static void report_final(struct bench_res res[], int res_cnt)
+{
+	double creates_mean = 0.0, creates_stddev = 0.0;
+	long total_creates = 0, total_kmallocs = 0;
+	int i;
+
+	for (i = 0; i < res_cnt; i++) {
+		creates_mean += res[i].hits / 1000.0 / (0.0 + res_cnt);
+		total_creates += res[i].hits;
+		total_kmallocs += res[i].drops;
+	}
+
+	if (res_cnt > 1)  {
+		for (i = 0; i < res_cnt; i++)
+			creates_stddev += (creates_mean - res[i].hits / 1000.0) *
+				       (creates_mean - res[i].hits / 1000.0) /
+				       (res_cnt - 1.0);
+		creates_stddev = sqrt(creates_stddev);
+	}
+	printf("Summary: creates %8.3lf \u00B1 %5.3lfk/s (%7.3lfk/prod), ",
+	       creates_mean, creates_stddev, creates_mean / env.producer_cnt);
+	printf("%4.2lf kmallocs/create\n", (double)total_kmallocs / total_creates);
+	if (socket_errs || skel->bss->create_errs)
+		printf("socket() errors %ld create_errs %ld\n", socket_errs,
+		       skel->bss->create_errs);
+}
+
+/* Benchmark performance of creating bpf local storage  */
+const struct bench bench_local_storage_create = {
+	.name = "local-storage-create",
+	.validate = validate,
+	.setup = setup,
+	.producer_thread = producer,
+	.consumer_thread = consumer,
+	.measure = measure,
+	.report_progress = report_progress,
+	.report_final = report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
new file mode 100644
index 000000000000..2814bab54d28
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+long create_errs = 0;
+long create_cnts = 0;
+long kmalloc_cnts = 0;
+__u32 bench_pid = 0;
+
+struct storage {
+	__u8 data[64];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct storage);
+} sk_storage_map SEC(".maps");
+
+SEC("raw_tp/kmalloc")
+int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
+	     size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags,
+	     int node)
+{
+	__sync_fetch_and_add(&kmalloc_cnts, 1);
+
+	return 0;
+}
+
+SEC("lsm.s/socket_post_create")
+int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
+	     int protocol, int kern)
+{
+	struct storage *stg;
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != bench_pid)
+		return 0;
+
+	stg = bpf_sk_storage_get(&sk_storage_map, sock->sk, NULL,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+
+	if (stg)
+		__sync_fetch_and_add(&create_cnts, 1);
+	else
+		__sync_fetch_and_add(&create_errs, 1);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.34.1

