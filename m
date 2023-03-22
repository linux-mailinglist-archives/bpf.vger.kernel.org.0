Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB486C5905
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCVVxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCVVxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:53:09 -0400
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F1334006
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:53:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679521983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odAj0u2w5qNmHwbfptsSVALSwl+/RaJXqw/hIUlRxuE=;
        b=tG6JWHLETzly2r5pcDhY79Om6u4tMaU7CesmPy6uGIX5ZQ5W+JKNmb0pMzexurfW0gg9D0
        TaKioVw616exaYzUHBADaZUd1xnvJ+QmIAPeDmqSTtX9B5Hyc5Pot2F1rnsOK0BzcmzWqp
        F0wDkmavhYEsltAKaSL1vWD/4tcN9y0=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v3 bpf-next 5/5] selftests/bpf: Add bench for task storage creation
Date:   Wed, 22 Mar 2023 14:52:46 -0700
Message-Id: <20230322215246.1675516-6-martin.lau@linux.dev>
In-Reply-To: <20230322215246.1675516-1-martin.lau@linux.dev>
References: <20230322215246.1675516-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds a task storage benchmark to the existing
local-storage-create benchmark.

For task storage,
./bench --storage-type task --batch-size 32:
   bpf_ma: Summary: creates   30.456 ± 0.507k/s ( 30.456k/prod), 6.08 kmallocs/create
no bpf_ma: Summary: creates   31.962 ± 0.486k/s ( 31.962k/prod), 6.13 kmallocs/create

./bench --storage-type task --batch-size 64:
   bpf_ma: Summary: creates   30.197 ± 1.476k/s ( 30.197k/prod), 6.08 kmallocs/create
no bpf_ma: Summary: creates   31.103 ± 0.297k/s ( 31.103k/prod), 6.13 kmallocs/create

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../bpf/benchs/bench_local_storage_create.c   | 151 ++++++++++++++++--
 .../bpf/progs/bench_local_storage_create.c    |  25 +++
 3 files changed, 164 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index dc3827c1f139..d9c080ac1796 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -278,6 +278,7 @@ extern struct argp bench_local_storage_argp;
 extern struct argp bench_local_storage_rcu_tasks_trace_argp;
 extern struct argp bench_strncmp_argp;
 extern struct argp bench_hashmap_lookup_argp;
+extern struct argp bench_local_storage_create_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -288,6 +289,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_local_storage_rcu_tasks_trace_argp, 0,
 		"local_storage RCU Tasks Trace slowdown benchmark", 0 },
 	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
+	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
 	{},
 };
 
diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
index f8b2a640ccbe..abb0321d4f34 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -3,19 +3,71 @@
 
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <pthread.h>
+#include <argp.h>
 
 #include "bench.h"
 #include "bench_local_storage_create.skel.h"
 
-#define BATCH_SZ 32
-
 struct thread {
-	int fds[BATCH_SZ];
+	int *fds;
+	pthread_t *pthds;
+	int *pthd_results;
 };
 
 static struct bench_local_storage_create *skel;
 static struct thread *threads;
-static long socket_errs;
+static long create_owner_errs;
+static int storage_type = BPF_MAP_TYPE_SK_STORAGE;
+static int batch_sz = 32;
+
+enum {
+	ARG_BATCH_SZ = 9000,
+	ARG_STORAGE_TYPE = 9001,
+};
+
+static const struct argp_option opts[] = {
+	{ "batch-size", ARG_BATCH_SZ, "BATCH_SIZE", 0,
+	  "The number of storage creations in each batch" },
+	{ "storage-type", ARG_STORAGE_TYPE, "STORAGE_TYPE", 0,
+	  "The type of local storage to test (socket or task)" },
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	int ret;
+
+	switch (key) {
+	case ARG_BATCH_SZ:
+		ret = atoi(arg);
+		if (ret < 1) {
+			fprintf(stderr, "invalid batch-size\n");
+			argp_usage(state);
+		}
+		batch_sz = ret;
+		break;
+	case ARG_STORAGE_TYPE:
+		if (!strcmp(arg, "task")) {
+			storage_type = BPF_MAP_TYPE_TASK_STORAGE;
+		} else if (!strcmp(arg, "socket")) {
+			storage_type = BPF_MAP_TYPE_SK_STORAGE;
+		} else {
+			fprintf(stderr, "invalid storage-type (socket or task)\n");
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
+const struct argp bench_local_storage_create_argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
 
 static void validate(void)
 {
@@ -28,6 +80,8 @@ static void validate(void)
 
 static void setup(void)
 {
+	int i;
+
 	skel = bench_local_storage_create__open_and_load();
 	if (!skel) {
 		fprintf(stderr, "error loading skel\n");
@@ -35,10 +89,16 @@ static void setup(void)
 	}
 
 	skel->bss->bench_pid = getpid();
-
-	if (!bpf_program__attach(skel->progs.socket_post_create)) {
-		fprintf(stderr, "Error attaching bpf program\n");
-		exit(1);
+	if (storage_type == BPF_MAP_TYPE_SK_STORAGE) {
+		if (!bpf_program__attach(skel->progs.socket_post_create)) {
+			fprintf(stderr, "Error attaching bpf program\n");
+			exit(1);
+		}
+	} else {
+		if (!bpf_program__attach(skel->progs.fork)) {
+			fprintf(stderr, "Error attaching bpf program\n");
+			exit(1);
+		}
 	}
 
 	if (!bpf_program__attach(skel->progs.kmalloc)) {
@@ -52,6 +112,29 @@ static void setup(void)
 		fprintf(stderr, "cannot alloc thread_res\n");
 		exit(1);
 	}
+
+	for (i = 0; i < env.producer_cnt; i++) {
+		struct thread *t = &threads[i];
+
+		if (storage_type == BPF_MAP_TYPE_SK_STORAGE) {
+			t->fds = malloc(batch_sz * sizeof(*t->fds));
+			if (!t->fds) {
+				fprintf(stderr, "cannot alloc t->fds\n");
+				exit(1);
+			}
+		} else {
+			t->pthds = malloc(batch_sz * sizeof(*t->pthds));
+			if (!t->pthds) {
+				fprintf(stderr, "cannot alloc t->pthds\n");
+				exit(1);
+			}
+			t->pthd_results = malloc(batch_sz * sizeof(*t->pthd_results));
+			if (!t->pthd_results) {
+				fprintf(stderr, "cannot alloc t->pthd_results\n");
+				exit(1);
+			}
+		}
+	}
 }
 
 static void measure(struct bench_res *res)
@@ -65,20 +148,20 @@ static void *consumer(void *input)
 	return NULL;
 }
 
-static void *producer(void *input)
+static void *sk_producer(void *input)
 {
 	struct thread *t = &threads[(long)(input)];
 	int *fds = t->fds;
 	int i;
 
 	while (true) {
-		for (i = 0; i < BATCH_SZ; i++) {
+		for (i = 0; i < batch_sz; i++) {
 			fds[i] = socket(AF_INET6, SOCK_DGRAM, 0);
 			if (fds[i] == -1)
-				atomic_inc(&socket_errs);
+				atomic_inc(&create_owner_errs);
 		}
 
-		for (i = 0; i < BATCH_SZ; i++) {
+		for (i = 0; i < batch_sz; i++) {
 			if (fds[i] != -1)
 				close(fds[i]);
 		}
@@ -87,6 +170,42 @@ static void *producer(void *input)
 	return NULL;
 }
 
+static void *thread_func(void *arg)
+{
+	return NULL;
+}
+
+static void *task_producer(void *input)
+{
+	struct thread *t = &threads[(long)(input)];
+	pthread_t *pthds = t->pthds;
+	int *pthd_results = t->pthd_results;
+	int i;
+
+	while (true) {
+		for (i = 0; i < batch_sz; i++) {
+			pthd_results[i] = pthread_create(&pthds[i], NULL, thread_func, NULL);
+			if (pthd_results[i])
+				atomic_inc(&create_owner_errs);
+		}
+
+		for (i = 0; i < batch_sz; i++) {
+			if (!pthd_results[i])
+				pthread_join(pthds[i], NULL);;
+		}
+	}
+
+	return NULL;
+}
+
+static void *producer(void *input)
+{
+	if (storage_type == BPF_MAP_TYPE_SK_STORAGE)
+		return sk_producer(input);
+	else
+		return task_producer(input);
+}
+
 static void report_progress(int iter, struct bench_res *res, long delta_ns)
 {
 	double creates_per_sec, kmallocs_per_create;
@@ -123,14 +242,18 @@ static void report_final(struct bench_res res[], int res_cnt)
 	printf("Summary: creates %8.3lf \u00B1 %5.3lfk/s (%7.3lfk/prod), ",
 	       creates_mean, creates_stddev, creates_mean / env.producer_cnt);
 	printf("%4.2lf kmallocs/create\n", (double)total_kmallocs / total_creates);
-	if (socket_errs || skel->bss->create_errs)
-		printf("socket() errors %ld create_errs %ld\n", socket_errs,
+	if (create_owner_errs || skel->bss->create_errs)
+		printf("%s() errors %ld create_errs %ld\n",
+		       storage_type == BPF_MAP_TYPE_SK_STORAGE ?
+		       "socket" : "pthread_create",
+		       create_owner_errs,
 		       skel->bss->create_errs);
 }
 
 /* Benchmark performance of creating bpf local storage  */
 const struct bench bench_local_storage_create = {
 	.name = "local-storage-create",
+	.argp = &bench_local_storage_create_argp,
 	.validate = validate,
 	.setup = setup,
 	.producer_thread = producer,
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
index 2814bab54d28..7c851c9d5e47 100644
--- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -22,6 +22,13 @@ struct {
 	__type(value, struct storage);
 } sk_storage_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct storage);
+} task_storage_map SEC(".maps");
+
 SEC("raw_tp/kmalloc")
 int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
 	     size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags,
@@ -32,6 +39,24 @@ int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
 	return 0;
 }
 
+SEC("tp_btf/sched_process_fork")
+int BPF_PROG(fork, struct task_struct *parent, struct task_struct *child)
+{
+	struct storage *stg;
+
+	if (parent->tgid != bench_pid)
+		return 0;
+
+	stg = bpf_task_storage_get(&task_storage_map, child, NULL,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (stg)
+		__sync_fetch_and_add(&create_cnts, 1);
+	else
+		__sync_fetch_and_add(&create_errs, 1);
+
+	return 0;
+}
+
 SEC("lsm.s/socket_post_create")
 int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	     int protocol, int kern)
-- 
2.34.1

