Return-Path: <bpf+bounces-2488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681EA72DB1C
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBCD280EE2
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 07:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966268BE0;
	Tue, 13 Jun 2023 07:37:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E68494
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 07:37:18 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81B21701;
	Tue, 13 Jun 2023 00:37:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgL3m1ffcz4f3mHv;
	Tue, 13 Jun 2023 15:37:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3X7OdHIhkfcdhLg--.52188S9;
	Tue, 13 Jun 2023 15:37:08 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org,
	houtao1@huawei.com
Subject: [PATCH bpf-next v6 5/5] selftests/bpf: Add benchmark for bpf memory allocator
Date: Tue, 13 Jun 2023 16:09:21 +0800
Message-Id: <20230613080921.1623219-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230613080921.1623219-1-houtao@huaweicloud.com>
References: <20230613080921.1623219-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3X7OdHIhkfcdhLg--.52188S9
X-Coremail-Antispam: 1UD129KBjvAXoWfGw13tr18Jw1rJFy8XrWUJwb_yoW8AFWfWo
	Z3CFs8JF18XrnFv3ykCas7J3WfuF4q9ryUXr1UXan8AFy8Cr1FvFyUCw4fZryxXFWfG34x
	XFZay343ArWkXF97n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

The benchmark could be used to compare the performance of hash map
operations and the memory usage between different flavors of bpf memory
allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
could be used to check the performance improvement or the memory saving
provided by optimization.

The benchmark creates a non-preallocated hash map which uses bpf memory
allocator and shows the operation performance and the memory usage of
the hash map under different use cases:
(1) overwrite
Each CPU overwrites nonoverlapping part of hash map. When each CPU
completes overwriting of 64 elements in hash map, it increases the
op_count.
(2) batch_add_batch_del
Each CPU adds then deletes nonoverlapping part of hash map in batch.
When each CPU adds and deletes 64 elements in hash map, it increases
the op_count twice.
(3) add_del_on_diff_cpu
Each two-CPUs pair adds and deletes nonoverlapping part of map
cooperatively. When each CPU adds or deletes 64 elements in hash map,
it will increase the op_count.

The following is the benchmark results when comparing between different
flavors of bpf memory allocator. These tests are conducted on a KVM guest
with 8 CPUs and 16 GB memory. The command line below is used to do all
the following benchmarks:

  ./bench htab-mem --use-case $name ${OPTS} -w3 -d10 -a -p8

These results show that preallocated hash map has both better performance
and smaller memory usage.

(1) non-preallocated + no bpf memory allocator (v6.0.19)
use kmalloc() + call_rcu

overwrite            per-prod-op :  8.54 ± 0.07k/s, avg mem: 48.11 ± 14.83MiB, peak mem: 91.84MiB
batch_add_batch_del  per-prod-op : 12.99 ± 0.12k/s, avg mem: 32.88 ± 5.42MiB, peak mem: 67.50MiB
add_del_on_diff_cpu  per-prod-op :  9.19 ± 0.07k/s, avg mem:  3.19 ± 0.40MiB, peak mem:  5.11MiB

(2) preallocated
OPTS=--preallocated

overwrite            per-prod-op : 93.56 ± 0.03k/s, avg mem: 1.23 ± 0.00MiB, peak mem: 1.24MiB
batch_add_batch_del  per-prod-op : 139.67 ± 0.08k/s, avg mem: 1.23 ± 0.00MiB, peak mem: 1.49MiB
add_del_on_diff_cpu  per-prod-op : 15.51 ± 0.07k/s, avg mem: 1.77 ± 0.12MiB, peak mem: 1.95MiB

(3) normal bpf memory allocator

overwrite            per-prod-op : 89.45 ± 0.27k/s, avg mem: 2.26 ± 0.00MiB, peak mem: 2.74MiB
batch_add_batch_del  per-prod-op : 59.17 ± 0.11k/s, avg mem: 2.34 ± 0.14MiB, peak mem: 2.74MiB
add_del_on_diff_cpu  per-prod-op : 15.60 ± 0.20k/s, avg mem: 14.75 ± 2.77MiB, peak mem: 23.05MiB

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |   3 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_htab_mem.c     | 303 ++++++++++++++++++
 .../bpf/benchs/run_bench_htab_mem.sh          |  40 +++
 .../selftests/bpf/progs/htab_mem_bench.c      | 107 +++++++
 5 files changed, 457 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 538df8fb8c42..add018823ebd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -644,11 +644,13 @@ $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
 $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.skel.h
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
+$(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(TESTING_HELPERS) \
 		 $(TRACE_HELPERS) \
+		 $(CGROUP_HELPERS) \
 		 $(OUTPUT)/bench_count.o \
 		 $(OUTPUT)/bench_rename.o \
 		 $(OUTPUT)/bench_trigger.o \
@@ -661,6 +663,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
 		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
+		 $(OUTPUT)/bench_htab_mem.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 41fe5a82b88b..73ce11b0547d 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -279,6 +279,7 @@ extern struct argp bench_local_storage_rcu_tasks_trace_argp;
 extern struct argp bench_strncmp_argp;
 extern struct argp bench_hashmap_lookup_argp;
 extern struct argp bench_local_storage_create_argp;
+extern struct argp bench_htab_mem_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -290,6 +291,7 @@ static const struct argp_child bench_parsers[] = {
 		"local_storage RCU Tasks Trace slowdown benchmark", 0 },
 	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
 	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
+	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
 	{},
 };
 
@@ -520,6 +522,7 @@ extern const struct bench bench_local_storage_cache_hashmap_control;
 extern const struct bench bench_local_storage_tasks_trace;
 extern const struct bench bench_bpf_hashmap_lookup;
 extern const struct bench bench_local_storage_create;
+extern const struct bench bench_htab_mem;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -561,6 +564,7 @@ static const struct bench *benchs[] = {
 	&bench_local_storage_tasks_trace,
 	&bench_bpf_hashmap_lookup,
 	&bench_local_storage_create,
+	&bench_htab_mem,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
new file mode 100644
index 000000000000..f0b57e66c1eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <argp.h>
+#include <stdbool.h>
+#include <pthread.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "bench.h"
+#include "cgroup_helpers.h"
+#include "htab_mem_bench.skel.h"
+
+static struct htab_mem_ctx {
+	struct htab_mem_bench *skel;
+	pthread_barrier_t *notify;
+	int fd;
+	bool do_notify_wait;
+} ctx;
+
+static struct htab_mem_args {
+	u32 value_size;
+	const char *use_case;
+	bool preallocated;
+} args = {
+	.value_size = 8,
+	.use_case = "overwrite",
+	.preallocated = false,
+};
+
+enum {
+	ARG_VALUE_SIZE = 10000,
+	ARG_USE_CASE = 10001,
+	ARG_PREALLOCATED = 10002,
+};
+
+static const struct argp_option opts[] = {
+	{ "value-size", ARG_VALUE_SIZE, "VALUE_SIZE", 0,
+	  "Set the value size of hash map (default 8)" },
+	{ "use-case", ARG_USE_CASE, "USE_CASE", 0,
+	  "Set the use case of hash map: overwrite|batch_add_batch_del|add_del_on_diff_cpu" },
+	{ "preallocated", ARG_PREALLOCATED, NULL, 0, "use preallocated hash map" },
+	{},
+};
+
+static error_t htab_mem_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_VALUE_SIZE:
+		args.value_size = strtoul(arg, NULL, 10);
+		if (args.value_size > 4096) {
+			fprintf(stderr, "too big value size %u\n", args.value_size);
+			argp_usage(state);
+		}
+		break;
+	case ARG_USE_CASE:
+		args.use_case = strdup(arg);
+		break;
+	case ARG_PREALLOCATED:
+		args.preallocated = true;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_htab_mem_argp = {
+	.options = opts,
+	.parser = htab_mem_parse_arg,
+};
+
+static void htab_mem_validate(void)
+{
+	if (!strcmp("add_del_on_diff_cpu", args.use_case) && env.producer_cnt % 2) {
+		fprintf(stderr, "%s needs an even number of producers\n", args.use_case);
+		exit(1);
+	}
+}
+
+static int htab_mem_bench_init_barriers(void)
+{
+	unsigned int i, nr = (env.producer_cnt + 1) / 2;
+	pthread_barrier_t *barriers;
+
+	barriers = calloc(nr, sizeof(*barriers));
+	if (!barriers)
+		return -1;
+
+	/* Used for synchronization between two threads */
+	for (i = 0; i < nr; i++)
+		pthread_barrier_init(&barriers[i], NULL, 2);
+
+	ctx.notify = barriers;
+	return 0;
+}
+
+static void htab_mem_bench_exit_barriers(void)
+{
+	unsigned int i, nr;
+
+	if (!ctx.notify)
+		return;
+
+	nr = (env.producer_cnt + 1) / 2;
+	for (i = 0; i < nr; i++)
+		pthread_barrier_destroy(&ctx.notify[i]);
+	free(ctx.notify);
+}
+
+static void htab_mem_setup(void)
+{
+	struct bpf_program *prog;
+	struct bpf_map *map;
+	int err;
+
+	setup_libbpf();
+
+	err = cgroup_setup_and_join("/htab_mem");
+	if (err < 0)
+		exit(1);
+	ctx.fd = err;
+
+	ctx.skel = htab_mem_bench__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		goto cleanup;
+	}
+
+	err = htab_mem_bench_init_barriers();
+	if (err) {
+		fprintf(stderr, "failed to init barrier\n");
+		goto cleanup;
+	}
+
+	map = ctx.skel->maps.htab;
+	bpf_map__set_value_size(map, args.value_size);
+	if (args.preallocated)
+		bpf_map__set_map_flags(map, bpf_map__map_flags(map) & ~BPF_F_NO_PREALLOC);
+
+	/* Do synchronization between addition thread and deletion thread */
+	if (!strcmp("add_del_on_diff_cpu", args.use_case))
+		ctx.do_notify_wait = true;
+
+	prog = bpf_object__find_program_by_name(ctx.skel->obj, args.use_case);
+	if (!prog) {
+		fprintf(stderr, "no such use-case: %s\n", args.use_case);
+		fprintf(stderr, "available use case:");
+		bpf_object__for_each_program(prog, ctx.skel->obj)
+			fprintf(stderr, " %s", bpf_program__name(prog));
+		fprintf(stderr, "\n");
+		goto cleanup;
+	}
+	bpf_program__set_autoload(prog, true);
+
+	ctx.skel->bss->nr_thread = env.producer_cnt;
+
+	err = htab_mem_bench__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		goto cleanup;
+	}
+	err = htab_mem_bench__attach(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to attach skeleton\n");
+		goto cleanup;
+	}
+	return;
+cleanup:
+	close(ctx.fd);
+	cleanup_cgroup_environment();
+	htab_mem_bench_exit_barriers();
+	htab_mem_bench__destroy(ctx.skel);
+	exit(1);
+}
+
+static void htab_mem_notify_wait_producer(pthread_barrier_t *notify)
+{
+	while (true) {
+		(void)syscall(__NR_getpgid);
+		/* Notify for start */
+		pthread_barrier_wait(notify);
+		/* Wait for completion */
+		pthread_barrier_wait(notify);
+	}
+}
+
+static void htab_mem_wait_notify_producer(pthread_barrier_t *notify)
+{
+	while (true) {
+		/* Wait for start */
+		pthread_barrier_wait(notify);
+		(void)syscall(__NR_getpgid);
+		/* Notify for completion */
+		pthread_barrier_wait(notify);
+	}
+}
+
+static void *htab_mem_producer(void *arg)
+{
+	pthread_barrier_t *notify;
+	int seq;
+
+	if (!ctx.do_notify_wait) {
+		while (true)
+			(void)syscall(__NR_getpgid);
+		return NULL;
+	}
+
+	seq = (long)arg;
+	notify = &ctx.notify[seq / 2];
+	if (seq & 1)
+		htab_mem_notify_wait_producer(notify);
+	else
+		htab_mem_wait_notify_producer(notify);
+	return NULL;
+}
+
+static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
+{
+	char buf[32];
+	ssize_t got;
+	int fd;
+
+	fd = openat(ctx.fd, name, O_RDONLY);
+	if (fd < 0) {
+		/* cgroup v1 ? */
+		fprintf(stderr, "no %s\n", name);
+		*value = 0;
+		return;
+	}
+
+	got = read(fd, buf, sizeof(buf) - 1);
+	if (got <= 0) {
+		*value = 0;
+		return;
+	}
+	buf[got] = 0;
+
+	*value = strtoull(buf, NULL, 0);
+
+	close(fd);
+}
+
+static void htab_mem_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->op_cnt, 0) / env.producer_cnt;
+	htab_mem_read_mem_cgrp_file("memory.current", &res->gp_ct);
+}
+
+static void htab_mem_report_progress(int iter, struct bench_res *res, long delta_ns)
+{
+	double loop, mem;
+
+	loop = res->hits / 1000.0 / (delta_ns / 1000000000.0);
+	mem = res->gp_ct / 1048576.0;
+	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0);
+	printf("per-prod-op %7.2lfk/s, memory usage %7.2lfMiB\n", loop, mem);
+}
+
+static void htab_mem_report_final(struct bench_res res[], int res_cnt)
+{
+	double mem_mean = 0.0, mem_stddev = 0.0;
+	double loop_mean = 0.0, loop_stddev = 0.0;
+	unsigned long peak_mem;
+	int i;
+
+	for (i = 0; i < res_cnt; i++) {
+		loop_mean += res[i].hits / 1000.0 / (0.0 + res_cnt);
+		mem_mean += res[i].gp_ct / 1048576.0 / (0.0 + res_cnt);
+	}
+	if (res_cnt > 1)  {
+		for (i = 0; i < res_cnt; i++) {
+			loop_stddev += (loop_mean - res[i].hits / 1000.0) *
+				       (loop_mean - res[i].hits / 1000.0) /
+				       (res_cnt - 1.0);
+			mem_stddev += (mem_mean - res[i].gp_ct / 1048576.0) *
+				      (mem_mean - res[i].gp_ct / 1048576.0) /
+				      (res_cnt - 1.0);
+		}
+		loop_stddev = sqrt(loop_stddev);
+		mem_stddev = sqrt(mem_stddev);
+	}
+
+	htab_mem_read_mem_cgrp_file("memory.peak", &peak_mem);
+	printf("Summary: per-prod-op %7.2lf \u00B1 %7.2lfk/s, memory usage %7.2lf \u00B1 %7.2lfMiB,"
+	       " peak memory usage %7.2lfMiB\n",
+	       loop_mean, loop_stddev, mem_mean, mem_stddev, peak_mem / 1048576.0);
+
+	cleanup_cgroup_environment();
+}
+
+const struct bench bench_htab_mem = {
+	.name = "htab-mem",
+	.argp = &bench_htab_mem_argp,
+	.validate = htab_mem_validate,
+	.setup = htab_mem_setup,
+	.producer_thread = htab_mem_producer,
+	.measure = htab_mem_measure,
+	.report_progress = htab_mem_report_progress,
+	.report_final = htab_mem_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh b/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
new file mode 100755
index 000000000000..516f46e57898
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+htab_mem()
+{
+	echo -n "per-prod-op : "
+	echo -n "$*" | sed -E "s/.* per-prod-op\s+([0-9]+\.[0-9]+ ± [0-9]+\.[0-9]+k\/s).*/\1/"
+	echo -n -e ", avg mem: "
+	echo -n "$*" | sed -E "s/.* memory usage\s+([0-9]+\.[0-9]+ ± [0-9]+\.[0-9]+MiB).*/\1/"
+	echo -n ", peak mem: "
+	echo "$*" | sed -E "s/.* peak memory usage\s+([0-9]+\.[0-9]+MiB).*/\1/"
+}
+
+summarize_htab_mem()
+{
+	local bench="$1"
+	local summary=$(echo $2 | tail -n1)
+
+	printf "%-20s %s\n" "$bench" "$(htab_mem $summary)"
+}
+
+htab_mem_bench()
+{
+	local name
+
+	for name in overwrite batch_add_batch_del add_del_on_diff_cpu
+	do
+		summarize_htab_mem "$name" "$($RUN_BENCH htab-mem --use-case $name -p8 "$@")"
+	done
+}
+
+header "preallocated"
+htab_mem_bench "--preallocated"
+
+header "normal bpf ma"
+htab_mem_bench
diff --git a/tools/testing/selftests/bpf/progs/htab_mem_bench.c b/tools/testing/selftests/bpf/progs/htab_mem_bench.c
new file mode 100644
index 000000000000..a9b3d90f90ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_mem_bench.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <stdbool.h>
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct update_ctx {
+	unsigned int from;
+	unsigned int step;
+};
+
+#define MAX_ENTRIES 8192
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, 4);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, MAX_ENTRIES);
+} htab SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+unsigned char zeroed_value[4096];
+unsigned int nr_thread = 0;
+long op_cnt = 0;
+
+static int write_htab(unsigned int i, struct update_ctx *ctx, unsigned int flags)
+{
+	if (ctx->from >= MAX_ENTRIES)
+		return 1;
+
+	bpf_map_update_elem(&htab, &ctx->from, zeroed_value, flags);
+	ctx->from += ctx->step;
+
+	return 0;
+}
+
+static int overwrite_htab(unsigned int i, struct update_ctx *ctx)
+{
+	return write_htab(i, ctx, 0);
+}
+
+static int newwrite_htab(unsigned int i, struct update_ctx *ctx)
+{
+	return write_htab(i, ctx, BPF_NOEXIST);
+}
+
+static int del_htab(unsigned int i, struct update_ctx *ctx)
+{
+	if (ctx->from >= MAX_ENTRIES)
+		return 1;
+
+	bpf_map_delete_elem(&htab, &ctx->from);
+	ctx->from += ctx->step;
+
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_getpgid")
+int overwrite(void *ctx)
+{
+	struct update_ctx update;
+
+	update.from = bpf_get_smp_processor_id();
+	update.step = nr_thread;
+	bpf_loop(64, overwrite_htab, &update, 0);
+	__sync_fetch_and_add(&op_cnt, 1);
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_getpgid")
+int batch_add_batch_del(void *ctx)
+{
+	struct update_ctx update;
+
+	update.from = bpf_get_smp_processor_id();
+	update.step = nr_thread;
+	bpf_loop(64, overwrite_htab, &update, 0);
+
+	update.from = bpf_get_smp_processor_id();
+	bpf_loop(64, del_htab, &update, 0);
+
+	__sync_fetch_and_add(&op_cnt, 2);
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_getpgid")
+int add_del_on_diff_cpu(void *ctx)
+{
+	struct update_ctx update;
+	unsigned int from;
+
+	from = bpf_get_smp_processor_id();
+	update.from = from / 2;
+	update.step = nr_thread / 2;
+
+	if (from & 1)
+		bpf_loop(64, newwrite_htab, &update, 0);
+	else
+		bpf_loop(64, del_htab, &update, 0);
+
+	__sync_fetch_and_add(&op_cnt, 1);
+	return 0;
+}
-- 
2.29.2


