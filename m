Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F0D6F23E7
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjD2Jlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Apr 2023 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjD2Jld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Apr 2023 05:41:33 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5010D7;
        Sat, 29 Apr 2023 02:41:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q7kxz1GYJz4f3v4r;
        Sat, 29 Apr 2023 17:41:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBA5kxkK36NIQ--.13426S10;
        Sat, 29 Apr 2023 17:41:28 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC bpf-next v3 6/6] selftests/bpf: Add benchmark for bpf memory allocator
Date:   Sat, 29 Apr 2023 18:12:15 +0800
Message-Id: <20230429101215.111262-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230429101215.111262-1-houtao@huaweicloud.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBA5kxkK36NIQ--.13426S10
X-Coremail-Antispam: 1UD129KBjvAXoWftr47WFyfXw13Cr4fCw4Durg_yoW8tF4rWo
        Z3CFW5Jr18Jr12vrWvkas7A3WfuF4kKFyUXw15Xan8Jay8Ar1F9ry7Cw4furyxXFWfK34x
        XFZay34fAFW8WF93n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYu7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
        67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

The benchmark could be used to compare the performance of hash map
operations and the memory usage between different flavors of bpf memory
allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
could be used to check the performance improvement or the memory saving
provided by optimization.

The benchmark creates a non-preallocated hash map which uses bpf memory
allocator and shows the operation performance and the memory usage of
the hash map under different use cases:
(1) no_op
Only create the hash map and there is no operations on hash map. It is
used as the baseline. When each CPU completes the iteration of
nr_entries / nr_threads elements in hash map, the loop count is
increased.
(2) overwrite
Each CPU overwrites nonoverlapping part of hash map. When each CPU
completes overwriting of nr_entries / nr_threads elements in hash map,
the loop count is increased.
(3) batch_add_batch_del
Each CPU adds then deletes nonoverlapping part of hash map in batch.
When each CPU adds and deletes nr_entries / nr_threads elements in hash
map, the loop count is increased.
(4) add_del_on_diff_cpu
Each two CPUs add and delete nonoverlapping part of map cooperatively
When each CPU adds and deletes nr_entries / nr_threads * 2 elements in
hash map, the loop count is increased twice.

The following are the benchmark results when comparing between different
flavors of bpf memory allocator. These tests are conducted on a KVM guest
with 8 CPUs and 16 GB memory. The command line below is used to do all
the following benchmarks:

  ./bench htab-mem --use-case $name --max-entries 16384 ${OPTS} \
          --full 50 -d 9 --producers=8 --prod-affinity=0-7

These results show:
* preallocated case has both better performance and better memory
  efficiency.
* normal bpf memory doesn't add_del_on_diff_cpu very well. The larger
  memory is due to the slow tasks trace RCU grace period.
* free-after-rcu-gp has fewer memory usage compared with
  reuse-after-rcu-gp, but its performance is bad than
  reuse-after-rcu-gp. Both free-after-rcu-gp and reuse-after-rcu-gp have
  larger memory usage than normal bpf memory allocator due to the delay
  of reuse.
* for extra call_rcu + bpf_memory_allocator, its memory usage is much
  bigger than free-after-rcu-gp and reuse-after-rcu-gp.

(1) non-preallocated + no bpf memory allocator (v6.0.19)
use kmalloc() + call_rcu

| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1214.42    | 0.92                 | 0.92              |
| overwrite           | 3.21       | 40.47                | 67.98             |
| batch_add_batch_del | 2.32       | 24.31                | 49.33             |
| add_del_on_diff_cpu | 2.92       | 4.03                 | 6.00              |

(2) preallocated
OPTS=--preallocated

| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1156.59    | 1.88                 | 1.88              |
| overwrite           | 36.19      | 1.88                 | 1.88              |
| batch_add_batch_del | 22.27      | 1.88                 | 1.88              |
| add_del_on_diff_cpu | 4.68       | 1.95                 | 2.05              |

(3) normal bpf memory allocator
echo 0 > /sys/module/hashtab/parameters/reuse_flag
echo 0 > /sys/module/hashtab/parameters/delayed_free

| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1273.55    | 0.98                 | 0.98              |
| overwrite           | 26.57      | 2.59                 | 2.74              |
| batch_add_batch_del | 11.13      | 2.59                 | 2.99              |
| add_del_on_diff_cpu | 3.72       | 15.15                | 26.04             |

(4) reuse-after-rcu-gp bpf memory allocator
echo 2 > /sys/module/hashtab/parameters/reuse_flag
echo 0 > /sys/module/hashtab/parameters/delayed_free

| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1199.16    | 0.97                 | 0.99              |
| overwrite           | 16.37      | 24.01                | 31.76             |
| batch_add_batch_del | 9.61       | 16.71                | 19.95             |
| add_del_on_diff_cpu | 3.62       | 22.93                | 37.02             |

(5) free-after-rcu-gp bpf memory allocator
echo 4 > /sys/module/hashtab/parameters/reuse_flag
echo 0 > /sys/module/hashtab/parameters/delayed_free

| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1274.59    | 0.99                 | 0.99              |
| overwrite           | 11.02      | 13.48                | 21.85             |
| batch_add_batch_del | 7.43       | 10.58                | 16.14             |
| add_del_on_diff_cpu | 3.15       | 6.36                 | 9.65              |

(6) extra call_rcu + bpf memory allocator
echo 0 > /sys/module/hashtab/parameters/reuse_flag
echo 1 > /sys/module/hashtab/parameters/delayed_free

| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1276.85    | 0.99                 | 0.99              |
| overwrite           | 12.57      | 372.01               | 676.56            |
| batch_add_batch_del | 9.31       | 276.14               | 431.04            |
| add_del_on_diff_cpu | 3.29       | 18.73                | 35.13             |

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |   3 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_htab_mem.c     | 352 ++++++++++++++++++
 .../bpf/benchs/run_bench_htab_mem.sh          |  64 ++++
 .../selftests/bpf/progs/htab_mem_bench.c      | 135 +++++++
 5 files changed, 558 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7a196a87152c..b5baa23dfb98 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -647,11 +647,13 @@ $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
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
@@ -664,6 +666,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
 		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
+		 $(OUTPUT)/bench_htab_mem.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index d9c080ac1796..d3d9ae321b74 100644
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
 
@@ -518,6 +520,7 @@ extern const struct bench bench_local_storage_cache_hashmap_control;
 extern const struct bench bench_local_storage_tasks_trace;
 extern const struct bench bench_bpf_hashmap_lookup;
 extern const struct bench bench_local_storage_create;
+extern const struct bench bench_htab_mem;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -559,6 +562,7 @@ static const struct bench *benchs[] = {
 	&bench_local_storage_tasks_trace,
 	&bench_bpf_hashmap_lookup,
 	&bench_local_storage_create,
+	&bench_htab_mem,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
new file mode 100644
index 000000000000..f0c2505c0868
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -0,0 +1,352 @@
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
+	u32 max_entries;
+	u32 value_size;
+	u32 full;
+	const char *use_case;
+	bool preallocated;
+} args = {
+	.max_entries = 16384,
+	.full = 50,
+	.value_size = 8,
+	.use_case = "overwrite",
+	.preallocated = false,
+};
+
+enum {
+	ARG_MAX_ENTRIES = 10000,
+	ARG_FULL_PERCENT = 10001,
+	ARG_VALUE_SIZE = 10002,
+	ARG_USE_CASE = 10003,
+	ARG_PREALLOCATED = 10004,
+};
+
+static const struct argp_option opts[] = {
+	{ "max-entries", ARG_MAX_ENTRIES, "MAX_ENTRIES", 0,
+	  "Set the max entries of hash map (default 16384)" },
+	{ "full", ARG_FULL_PERCENT, "FULL", 0,
+	  "Set the full percent of hash map (default 50)" },
+	{ "value-size", ARG_VALUE_SIZE, "VALUE_SIZE", 0,
+	  "Set the value size of hash map (default 8)" },
+	{ "use-case", ARG_USE_CASE, "USE_CASE", 0,
+	  "Set the use case of hash map: no_op|overwrite|batch_add_batch_del|add_del_on_diff_cpu" },
+	{ "preallocated", ARG_PREALLOCATED, NULL, 0, "use preallocated hash map" },
+	{},
+};
+
+static error_t htab_mem_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_MAX_ENTRIES:
+		args.max_entries = strtoul(arg, NULL, 10);
+		break;
+	case ARG_FULL_PERCENT:
+		args.full = strtoul(arg, NULL, 10);
+		if (!args.full || args.full > 100) {
+			fprintf(stderr, "invalid full percent %u\n", args.full);
+			argp_usage(state);
+		}
+		break;
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
+	if (env.consumer_cnt != 1) {
+		fprintf(stderr, "htab mem benchmark doesn't support multi-consumer!\n");
+		exit(1);
+	}
+}
+
+static int setup_and_join_cgroup(const char *path)
+{
+	int err, fd;
+
+	err = setup_cgroup_environment();
+	if (err) {
+		fprintf(stderr, "setup cgroup env failed\n");
+		return -1;
+	}
+
+	err = create_and_get_cgroup(path);
+	if (err < 0) {
+		fprintf(stderr, "create cgroup %s failed\n", path);
+		goto out;
+	}
+	fd = err;
+
+	err = join_cgroup(path);
+	if (err) {
+		fprintf(stderr, "join cgroup %s failed\n", path);
+		close(fd);
+		goto out;
+	}
+
+	return fd;
+out:
+	cleanup_cgroup_environment();
+	return -1;
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
+	err = setup_and_join_cgroup("/htab_mem");
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
+	bpf_map__set_max_entries(map, args.max_entries);
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
+	ctx.skel->bss->nr_entries = (uint64_t)args.max_entries * args.full / 100;
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
+static void *htab_mem_consumer(void *arg)
+{
+	return NULL;
+}
+
+static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
+{
+	char buf[32];
+	int fd;
+
+	fd = openat(ctx.fd, name, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "no %s\n", name);
+		*value = 0;
+		return;
+	}
+
+	buf[sizeof(buf) - 1] = 0;
+	read(fd, buf, sizeof(buf) - 1);
+	*value = strtoull(buf, NULL, 0);
+
+	close(fd);
+}
+
+static void htab_mem_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->loop_cnt, 0);
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
+	printf("loop %7.2lfk/s, memory usage %7.2lfMiB\n", loop, mem);
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
+	printf("Summary: loop %7.2lf \u00B1 %7.2lfk/s, memory usage %7.2lf \u00B1 %7.2lfMiB, "
+	       "peak memory usage %7.2lfMiB\n",
+	       loop_mean, loop_stddev, mem_mean, mem_stddev, peak_mem / 1048576.0);
+}
+
+const struct bench bench_htab_mem = {
+	.name = "htab-mem",
+	.argp = &bench_htab_mem_argp,
+	.validate = htab_mem_validate,
+	.setup = htab_mem_setup,
+	.producer_thread = htab_mem_producer,
+	.consumer_thread = htab_mem_consumer,
+	.measure = htab_mem_measure,
+	.report_progress = htab_mem_report_progress,
+	.report_final = htab_mem_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh b/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
new file mode 100755
index 000000000000..8f9458889a17
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
@@ -0,0 +1,64 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+DELAYED=/sys/module/hashtab/parameters/delayed_free
+REUSE=/sys/module/hashtab/parameters/reuse_flag
+
+htab_mem()
+{
+	echo -n "loop : "
+	echo -n "$*" | sed -E "s/.* loop\s+([0-9]+\.[0-9]+ ± [0-9]+\.[0-9]+k\/s).*/\1/"
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
+	for name in no_op overwrite batch_add_batch_del add_del_on_diff_cpu
+	do
+		summarize_htab_mem "$name" "$(sudo ./bench htab-mem --use-case $name \
+			--max-entries 16384 --full 50 -d 1 \
+			--producers=8 --prod-affinity=0-7 "$@")"
+	done
+}
+
+header "preallocated"
+echo 0 > $DELAYED
+echo 0 > $REUSE
+htab_mem_bench "--preallocated"
+
+header "normal bpf ma"
+echo 0 > $DELAYED
+echo 0 > $REUSE
+htab_mem_bench
+
+header "reuse-after-rcu-gp bpf ma"
+echo 0 > $DELAYED
+echo 2 > $REUSE
+htab_mem_bench
+
+header "free-after-rcu-gp bpf ma"
+echo 0 > $DELAYED
+echo 4 > $REUSE
+htab_mem_bench
+
+header "extra call_rcu + normal bpf ma"
+echo 1 > $DELAYED
+echo 0 > $REUSE
+htab_mem_bench
diff --git a/tools/testing/selftests/bpf/progs/htab_mem_bench.c b/tools/testing/selftests/bpf/progs/htab_mem_bench.c
new file mode 100644
index 000000000000..fe5c0edb262e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_mem_bench.c
@@ -0,0 +1,135 @@
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
+	unsigned int max;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, 4);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} htab SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+unsigned char zeroed_value[4096];
+unsigned int nr_entries = 0;
+unsigned int nr_thread = 0;
+long loop_cnt = 0;
+
+static int noop_htab(unsigned int i, struct update_ctx *ctx)
+{
+	if (ctx->from >= ctx->max)
+		return 1;
+
+	ctx->from += ctx->step;
+	return 0;
+}
+
+static int write_htab(unsigned int i, struct update_ctx *ctx, unsigned int flags)
+{
+	if (ctx->from >= ctx->max)
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
+	if (ctx->from >= ctx->max)
+		return 1;
+
+	bpf_map_delete_elem(&htab, &ctx->from);
+	ctx->from += ctx->step;
+
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_getpgid")
+int no_op(void *ctx)
+{
+	struct update_ctx update;
+
+	update.from = bpf_get_smp_processor_id();
+	update.step = nr_thread;
+	update.max = nr_entries;
+	bpf_loop(update.max, noop_htab, &update, 0);
+	__sync_fetch_and_add(&loop_cnt, 1);
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
+	update.max = nr_entries;
+	bpf_loop(update.max, overwrite_htab, &update, 0);
+	/* Increase when nr_entries / nr_thread elements are deleted and then added */
+	__sync_fetch_and_add(&loop_cnt, 1);
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
+	update.max = nr_entries;
+	bpf_loop(update.max, overwrite_htab, &update, 0);
+
+	update.from = bpf_get_smp_processor_id();
+	bpf_loop(update.max, del_htab, &update, 0);
+
+	/* Increase when nr_entries / nr_thread elements are added and then deleted */
+	__sync_fetch_and_add(&loop_cnt, 1);
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
+	update.max = nr_entries;
+
+	if (from & 1)
+		bpf_loop(update.max, newwrite_htab, &update, 0);
+	else
+		bpf_loop(update.max, del_htab, &update, 0);
+
+	/* Increase when nr_entries / nr_thread * 2 elements are added or deleted */
+	__sync_fetch_and_add(&loop_cnt, 1);
+	return 0;
+}
-- 
2.29.2

