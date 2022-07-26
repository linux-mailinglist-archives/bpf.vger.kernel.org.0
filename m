Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD43581345
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 14:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiGZMmC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 08:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbiGZMmA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 08:42:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343A248C2
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 05:41:58 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lsc191SBXzkXkN;
        Tue, 26 Jul 2022 20:39:25 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Jul
 2022 20:41:56 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, <houtao1@huawei.com>
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: add benchmark for qp-trie map
Date:   Tue, 26 Jul 2022 21:00:05 +0800
Message-ID: <20220726130005.3102470-4-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220726130005.3102470-1-houtao1@huawei.com>
References: <20220726130005.3102470-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a benchmark for qp-trie map to compare lookup, update/delete
performance and memory usage with hash table.

When jhash() of bpf htab creates too much hash collisions, lookup or update
of qp-trie may performance better than htab as shown below:

Randomly-generated binary data (length range: [1, 256], entries=16K)
htab lookup      (1  thread)    5.062 ± 0.004M/s (drops 0.002 ± 0.000M/s mem 8.125 MiB)
htab lookup      (2  thread)   10.256 ± 0.017M/s (drops 0.006 ± 0.000M/s mem 8.114 MiB)
htab lookup      (4  thread)   20.383 ± 0.006M/s (drops 0.009 ± 0.000M/s mem 8.117 MiB)
htab lookup      (8  thread)   40.727 ± 0.093M/s (drops 0.010 ± 0.000M/s mem 8.123 MiB)
htab lookup      (16 thread)   81.333 ± 0.311M/s (drops 0.020 ± 0.000M/s mem 8.122 MiB)
htab update      (1  thread)    2.404 ± 0.012M/s (drops 0.000 ± 0.000M/s mem 8.117 MiB)
htab update      (2  thread)    3.874 ± 0.010M/s (drops 0.000 ± 0.000M/s mem 8.106 MiB)
htab update      (4  thread)    5.895 ± 0.062M/s (drops 0.000 ± 0.000M/s mem 8.118 MiB)
htab update      (8  thread)    7.000 ± 0.088M/s (drops 0.000 ± 0.000M/s mem 8.116 MiB)
htab update      (16 thread)    7.076 ± 0.043M/s (drops 0.000 ± 0.000M/s mem 8.120 MiB)
qp-trie lookup   (1  thread)   10.161 ± 0.008M/s (drops 0.006 ± 0.000M/s mem 4.847 MiB)
qp-trie lookup   (2  thread)   20.287 ± 0.024M/s (drops 0.007 ± 0.000M/s mem 4.828 MiB)
qp-trie lookup   (4  thread)   40.784 ± 0.020M/s (drops 0.015 ± 0.000M/s mem 4.071 MiB)
qp-trie lookup   (8  thread)   81.165 ± 0.013M/s (drops 0.040 ± 0.000M/s mem 4.045 MiB)
qp-trie lookup   (16 thread)  159.955 ± 0.014M/s (drops 0.108 ± 0.000M/s mem 4.495 MiB)
qp-trie update   (1  thread)    1.621 ± 0.017M/s (drops 0.000 ± 0.000M/s mem 3.939 MiB)
qp-trie update   (2  thread)    2.615 ± 0.003M/s (drops 0.000 ± 0.000M/s mem 3.914 MiB)
qp-trie update   (4  thread)    4.017 ± 0.070M/s (drops 0.000 ± 0.000M/s mem 3.585 MiB)
qp-trie update   (8  thread)    6.857 ± 0.146M/s (drops 0.000 ± 0.000M/s mem 4.490 MiB)
qp-trie update   (16 thread)    9.871 ± 0.527M/s (drops 0.000 ± 0.000M/s mem 4.209 MiB)

But for the strings in /proc/kallsyms, lookup & update/delete performance
of qp-trie is 40% or more slower compare with hash table:

Strings in /proc/kallsyms (entries=186898)
htab lookup      (1  thread)    6.684 ± 0.005M/s (drops 0.458 ± 0.002M/s mem 33.614 MiB)
htab lookup      (2  thread)   12.644 ± 0.006M/s (drops 0.867 ± 0.003M/s mem 33.563 MiB)
htab lookup      (4  thread)   22.505 ± 0.012M/s (drops 1.542 ± 0.007M/s mem 33.565 MiB)
htab lookup      (8  thread)   45.302 ± 0.048M/s (drops 3.105 ± 0.015M/s mem 33.599 MiB)
htab lookup      (16 thread)   90.828 ± 0.069M/s (drops 6.225 ± 0.021M/s mem 33.564 MiB)
htab update      (1  thread)    2.850 ± 0.129M/s (drops 0.000 ± 0.000M/s mem 33.564 MiB)
htab update      (2  thread)    4.363 ± 0.031M/s (drops 0.000 ± 0.000M/s mem 33.563 MiB)
htab update      (4  thread)    6.306 ± 0.096M/s (drops 0.000 ± 0.000M/s mem 33.718 MiB)
htab update      (8  thread)    6.611 ± 0.026M/s (drops 0.000 ± 0.000M/s mem 33.627 MiB)
htab update      (16 thread)    6.390 ± 0.015M/s (drops 0.000 ± 0.000M/s mem 33.564 MiB)
qp-trie lookup   (1  thread)    4.122 ± 0.004M/s (drops 0.282 ± 0.001M/s mem 18.579 MiB)
qp-trie lookup   (2  thread)    8.280 ± 0.011M/s (drops 0.568 ± 0.004M/s mem 18.388 MiB)
qp-trie lookup   (4  thread)   15.927 ± 0.013M/s (drops 1.092 ± 0.007M/s mem 18.613 MiB)
qp-trie lookup   (8  thread)   31.412 ± 0.026M/s (drops 2.153 ± 0.008M/s mem 18.475 MiB)
qp-trie lookup   (16 thread)   63.807 ± 0.071M/s (drops 4.375 ± 0.025M/s mem 18.276 MiB)
qp-trie update   (1  thread)    1.157 ± 0.099M/s (drops 0.000 ± 0.000M/s mem 18.333 MiB)
qp-trie update   (2  thread)    1.920 ± 0.062M/s (drops 0.000 ± 0.000M/s mem 18.293 MiB)
qp-trie update   (4  thread)    2.630 ± 0.050M/s (drops 0.000 ± 0.000M/s mem 18.472 MiB)
qp-trie update   (8  thread)    3.171 ± 0.027M/s (drops 0.000 ± 0.000M/s mem 18.301 MiB)
qp-trie update   (16 thread)    3.782 ± 0.036M/s (drops 0.000 ± 0.000M/s mem 19.040 MiB)

For strings in BTF string section, the result is similar except the memory
saving of qp-trie decreases:

Sorted strings in BTF string sections (entries=115980)
htab lookup      (1  thread)    9.792 ± 0.017M/s (drops 0.000 ± 0.000M/s mem 15.069 MiB)
htab lookup      (2  thread)   19.581 ± 0.008M/s (drops 0.000 ± 0.000M/s mem 15.069 MiB)
htab lookup      (4  thread)   36.652 ± 0.022M/s (drops 0.000 ± 0.000M/s mem 15.069 MiB)
htab lookup      (8  thread)   73.799 ± 0.053M/s (drops 0.000 ± 0.000M/s mem 15.068 MiB)
htab lookup      (16 thread)  146.957 ± 0.054M/s (drops 0.000 ± 0.000M/s mem 15.067 MiB)
htab update      (1  thread)    3.497 ± 0.051M/s (drops 0.000 ± 0.000M/s mem 15.069 MiB)
htab update      (2  thread)    4.976 ± 0.039M/s (drops 0.000 ± 0.000M/s mem 15.067 MiB)
htab update      (4  thread)    6.550 ± 0.025M/s (drops 0.000 ± 0.000M/s mem 15.068 MiB)
htab update      (8  thread)    6.821 ± 0.015M/s (drops 0.000 ± 0.000M/s mem 15.067 MiB)
htab update      (16 thread)    7.163 ± 0.057M/s (drops 0.000 ± 0.000M/s mem 15.069 MiB)
qp-trie lookup   (1  thread)    6.144 ± 0.003M/s (drops 0.000 ± 0.000M/s mem 11.361 MiB)
qp-trie lookup   (2  thread)   12.461 ± 0.003M/s (drops 0.000 ± 0.000M/s mem 11.031 MiB)
qp-trie lookup   (4  thread)   25.098 ± 0.008M/s (drops 0.000 ± 0.000M/s mem 11.082 MiB)
qp-trie lookup   (8  thread)   49.734 ± 0.015M/s (drops 0.000 ± 0.000M/s mem 11.187 MiB)
qp-trie lookup   (16 thread)   97.829 ± 0.033M/s (drops 0.000 ± 0.000M/s mem 10.803 MiB)
qp-trie update   (1  thread)    1.473 ± 0.112M/s (drops 0.000 ± 0.000M/s mem 10.848 MiB)
qp-trie update   (2  thread)    2.649 ± 0.033M/s (drops 0.000 ± 0.000M/s mem 10.817 MiB)
qp-trie update   (4  thread)    5.129 ± 0.071M/s (drops 0.000 ± 0.000M/s mem 10.901 MiB)
qp-trie update   (8  thread)    9.191 ± 0.049M/s (drops 0.000 ± 0.000M/s mem 10.753 MiB)
qp-trie update   (16 thread)   11.095 ± 0.167M/s (drops 0.000 ± 0.000M/s mem 10.918 MiB)

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/bench.c           |  10 +
 .../selftests/bpf/benchs/bench_qp_trie.c      | 499 ++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_qp_trie.sh |  55 ++
 .../selftests/bpf/progs/qp_trie_bench.c       | 218 ++++++++
 5 files changed, 786 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_qp_trie.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1d1a9f15c140..67a1a79f460d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -575,11 +575,13 @@ $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
 $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_update_bench.skel.h
 $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
+$(OUTPUT)/bench_qp_trie.o: $(OUTPUT)/qp_trie_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(TESTING_HELPERS) \
 		 $(TRACE_HELPERS) \
+		 $(CGROUP_HELPERS) \
 		 $(OUTPUT)/bench_count.o \
 		 $(OUTPUT)/bench_rename.o \
 		 $(OUTPUT)/bench_trigger.o \
@@ -589,7 +591,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_strncmp.o \
 		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
 		 $(OUTPUT)/bench_local_storage.o \
-		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o
+		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
+		 $(OUTPUT)/bench_qp_trie.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index c1f20a147462..618f45fbe6e2 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -275,6 +275,7 @@ extern struct argp bench_bpf_loop_argp;
 extern struct argp bench_local_storage_argp;
 extern struct argp bench_local_storage_rcu_tasks_trace_argp;
 extern struct argp bench_strncmp_argp;
+extern struct argp bench_qp_trie_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -284,6 +285,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_strncmp_argp, 0, "bpf_strncmp helper benchmark", 0 },
 	{ &bench_local_storage_rcu_tasks_trace_argp, 0,
 		"local_storage RCU Tasks Trace slowdown benchmark", 0 },
+	{ &bench_qp_trie_argp, 0, "qp-trie benchmark", 0 },
 	{},
 };
 
@@ -490,6 +492,10 @@ extern const struct bench bench_local_storage_cache_seq_get;
 extern const struct bench bench_local_storage_cache_interleaved_get;
 extern const struct bench bench_local_storage_cache_hashmap_control;
 extern const struct bench bench_local_storage_tasks_trace;
+extern const struct bench bench_htab_lookup;
+extern const struct bench bench_qp_trie_lookup;
+extern const struct bench bench_htab_update;
+extern const struct bench bench_qp_trie_update;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -529,6 +535,10 @@ static const struct bench *benchs[] = {
 	&bench_local_storage_cache_interleaved_get,
 	&bench_local_storage_cache_hashmap_control,
 	&bench_local_storage_tasks_trace,
+	&bench_htab_lookup,
+	&bench_qp_trie_lookup,
+	&bench_htab_update,
+	&bench_qp_trie_update,
 };
 
 static void setup_benchmark()
diff --git a/tools/testing/selftests/bpf/benchs/bench_qp_trie.c b/tools/testing/selftests/bpf/benchs/bench_qp_trie.c
new file mode 100644
index 000000000000..35359e5e442b
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_qp_trie.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include <argp.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "bench.h"
+#include "bpf_util.h"
+#include "cgroup_helpers.h"
+
+#include "qp_trie_bench.skel.h"
+
+enum {
+	FOR_HTAB = 0,
+	FOR_TRIE,
+};
+
+static struct qp_trie_ctx {
+	struct qp_trie_bench *skel;
+	int cgrp_dfd;
+	u64 map_slab_mem;
+} ctx;
+
+static struct {
+	const char *file;
+	__u32 entries;
+} args;
+
+struct run_stat {
+	__u64 stats[2];
+};
+
+enum {
+	ARG_DATA_FILE = 8001,
+	ARG_DATA_ENTRIES = 8002,
+};
+
+static const struct argp_option opts[] = {
+	{ "file", ARG_DATA_FILE, "DATA-FILE", 0, "Set data file" },
+	{ "entries", ARG_DATA_ENTRIES, "DATA-ENTRIES", 0, "Set data entries" },
+	{},
+};
+
+static error_t qp_trie_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_DATA_FILE:
+		args.file = strdup(arg);
+		break;
+	case ARG_DATA_ENTRIES:
+		args.entries = strtoul(arg, NULL, 10);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_qp_trie_argp = {
+	.options = opts,
+	.parser = qp_trie_parse_arg,
+};
+
+static int parse_data_set(const char *name, struct bpf_qp_trie_key ***set, unsigned int *nr,
+			  unsigned int *max_len)
+{
+#define INT_MAX_DATA_SIZE 1024
+	unsigned int i, nr_items, item_max_len;
+	char line[INT_MAX_DATA_SIZE + 1];
+	struct bpf_qp_trie_key **items;
+	struct bpf_qp_trie_key *cur;
+	int err = 0;
+	FILE *file;
+	char *got;
+
+	file = fopen(name, "rb");
+	if (!file) {
+		fprintf(stderr, "open %s err %s\n", name, strerror(errno));
+		return -1;
+	}
+
+	got = fgets(line, sizeof(line), file);
+	if (!got) {
+		fprintf(stderr, "empty file ?\n");
+		err = -1;
+		goto out;
+	}
+	if (sscanf(line, "%u", &nr_items) != 1) {
+		fprintf(stderr, "the first line must be the number of items\n");
+		err = -1;
+		goto out;
+	}
+
+	fprintf(stdout, "item %u\n", nr_items);
+
+	items = (struct bpf_qp_trie_key **)calloc(nr_items, sizeof(*items) + INT_MAX_DATA_SIZE);
+	if (!items) {
+		fprintf(stderr, "no mem for items\n");
+		err = -1;
+		goto out;
+	}
+
+	i = 0;
+	item_max_len = 0;
+	cur = (void *)items + sizeof(*items) * nr_items;
+	while (true) {
+		unsigned int len;
+
+		got = fgets(line, sizeof(line), file);
+		if (!got) {
+			if (!feof(file)) {
+				fprintf(stderr, "read file %s error\n", name);
+				err = -1;
+			}
+			break;
+		}
+
+		len = strlen(got);
+		if (len && got[len - 1] == '\n') {
+			got[len - 1] = 0;
+			len -= 1;
+		}
+		if (!len) {
+			fprintf(stdout, "#%u empty line\n", i + 2);
+			continue;
+		}
+
+		if (i >= nr_items) {
+			fprintf(stderr, "too many line in %s\n", name);
+			break;
+		}
+
+		if (len > item_max_len)
+			item_max_len = len;
+		cur->len = len;
+		memcpy(cur->data, got, len);
+		items[i++] = cur;
+		cur = (void *)cur + INT_MAX_DATA_SIZE;
+	}
+
+	if (!err) {
+		if (i != nr_items)
+			fprintf(stdout, "few lines in %s (exp %u got %u)\n", name, nr_items, i);
+		*nr = i;
+		*set = items;
+		*max_len = item_max_len;
+	} else {
+		free(items);
+	}
+
+out:
+	fclose(file);
+	return err;
+}
+
+static int gen_data_set(struct bpf_qp_trie_key ***set, unsigned int *nr, unsigned int *max_len)
+{
+#define RND_MAX_DATA_SIZE 256
+	struct bpf_qp_trie_key **items;
+	struct bpf_qp_trie_key *cur;
+	size_t ptr_size, data_size;
+	unsigned int i, nr_items;
+	ssize_t got;
+	int err = 0;
+
+	ptr_size = *nr * sizeof(*items);
+	data_size = *nr * (sizeof(*cur) + RND_MAX_DATA_SIZE);
+	items = (struct bpf_qp_trie_key **)malloc(ptr_size + data_size);
+	if (!items) {
+		fprintf(stderr, "no mem for items\n");
+		err = -1;
+		goto out;
+	}
+
+	cur = (void *)items + ptr_size;
+	got = syscall(__NR_getrandom, cur, data_size, 0);
+	if (got != data_size) {
+		fprintf(stderr, "getrandom error %s\n", strerror(errno));
+		err = -1;
+		goto out;
+	}
+
+	nr_items = 0;
+	for (i = 0; i < *nr; i++) {
+		cur->len &= 0xff;
+		if (cur->len) {
+			items[nr_items++] = cur;
+			memset(cur->data + cur->len, 0, RND_MAX_DATA_SIZE - cur->len);
+		}
+		cur = (void *)cur + (sizeof(*cur) + RND_MAX_DATA_SIZE);
+	}
+	if (!nr_items) {
+		fprintf(stderr, "no valid key in random data\n");
+		err = -1;
+		goto out;
+	}
+	fprintf(stdout, "generate %u random keys\n", nr_items);
+
+	*nr = nr_items;
+	*set = items;
+	*max_len = RND_MAX_DATA_SIZE;
+out:
+	if (err && items)
+		free(items);
+	return err;
+}
+
+static void qp_trie_validate(void)
+{
+	if (env.consumer_cnt != 1) {
+		fprintf(stderr, "qp_trie_map benchmark doesn't support multi-consumer!\n");
+		exit(1);
+	}
+
+	if (!args.file && !args.entries) {
+		fprintf(stderr, "must specify entries when use random generated data set\n");
+		exit(1);
+	}
+
+	if (args.file && access(args.file, R_OK)) {
+		fprintf(stderr, "data file is un-accessible\n");
+		exit(1);
+	}
+}
+
+static void qp_trie_init_map_opts(struct qp_trie_bench *skel, unsigned int data_size,
+				  unsigned int nr)
+{
+	unsigned int key_size = data_size + sizeof(struct bpf_qp_trie_key);
+
+	bpf_map__set_value_size(skel->maps.htab_array, data_size);
+	bpf_map__set_max_entries(skel->maps.htab_array, nr);
+
+	bpf_map__set_key_size(skel->maps.htab, data_size);
+	bpf_map__set_max_entries(skel->maps.htab, nr);
+
+	bpf_map__set_value_size(skel->maps.trie_array, key_size);
+	bpf_map__set_max_entries(skel->maps.trie_array, nr);
+
+	bpf_map__set_key_size(skel->maps.qp_trie, key_size);
+	bpf_map__set_max_entries(skel->maps.qp_trie, nr);
+}
+
+static void qp_trie_setup_key_map(struct bpf_map *map, unsigned int map_type,
+				  struct bpf_qp_trie_key **set, unsigned int nr)
+{
+	int fd = bpf_map__fd(map);
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		void *value;
+		int err;
+
+		value = (map_type != FOR_HTAB) ? (void *)set[i] : (void *)set[i]->data;
+		err = bpf_map_update_elem(fd, &i, value, 0);
+		if (err) {
+			fprintf(stderr, "add #%u key (%s) on %s error %d\n",
+				i, set[i]->data, bpf_map__name(map), err);
+			exit(1);
+		}
+	}
+}
+
+static u64 qp_trie_get_slab_mem(int dfd)
+{
+	const char *magic = "slab ";
+	const char *name = "memory.stat";
+	int fd;
+	ssize_t nr;
+	char buf[4096];
+	char *from;
+
+	fd = openat(dfd, name, 0);
+	if (fd < 0) {
+		fprintf(stderr, "no %s\n", name);
+		exit(1);
+	}
+
+	nr = read(fd, buf, sizeof(buf));
+	if (nr <= 0) {
+		fprintf(stderr, "empty %s ?\n", name);
+		exit(1);
+	}
+	buf[nr - 1] = 0;
+
+	close(fd);
+
+	from = strstr(buf, magic);
+	if (!from) {
+		fprintf(stderr, "no slab in %s\n", name);
+		exit(1);
+	}
+
+	return strtoull(from + strlen(magic), NULL, 10);
+}
+
+static void qp_trie_setup_lookup_map(struct bpf_map *map, unsigned int map_type,
+				     struct bpf_qp_trie_key **set, unsigned int nr)
+{
+	int fd = bpf_map__fd(map);
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		void *key;
+		int err;
+
+		key = (map_type != FOR_HTAB) ? (void *)set[i] : (void *)set[i]->data;
+		err = bpf_map_update_elem(fd, key, &i, 0);
+		if (err) {
+			fprintf(stderr, "add #%u key (%s) on %s error %d\n",
+				i, set[i]->data, bpf_map__name(map), err);
+			exit(1);
+		}
+	}
+}
+
+static void qp_trie_setup(unsigned int map_type)
+{
+	struct bpf_qp_trie_key **set = NULL;
+	struct qp_trie_bench *skel;
+	unsigned int nr = 0, max_len = 0;
+	struct bpf_map *map;
+	u64 before, after;
+	int dfd;
+	int err;
+
+	if (!args.file) {
+		nr = args.entries;
+		err = gen_data_set(&set, &nr, &max_len);
+	} else {
+		err = parse_data_set(args.file, &set, &nr, &max_len);
+	}
+	if (err < 0)
+		exit(1);
+
+	if (args.entries && args.entries < nr)
+		nr = args.entries;
+
+	dfd = cgroup_setup_and_join("/qp_trie");
+	if (dfd < 0) {
+		fprintf(stderr, "failed to setup cgroup env\n");
+		exit(1);
+	}
+
+	setup_libbpf();
+
+	before = qp_trie_get_slab_mem(dfd);
+
+	skel = qp_trie_bench__open();
+	if (!skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	qp_trie_init_map_opts(skel, max_len, nr);
+
+	skel->bss->update_nr = nr;
+	skel->bss->update_chunk = nr / env.producer_cnt;
+
+	err = qp_trie_bench__load(skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	map = (map_type == FOR_HTAB) ? skel->maps.htab_array : skel->maps.trie_array;
+	qp_trie_setup_key_map(map, map_type, set, nr);
+
+	map = (map_type == FOR_HTAB) ? skel->maps.htab : skel->maps.qp_trie;
+	qp_trie_setup_lookup_map(map, map_type, set, nr);
+
+	after = qp_trie_get_slab_mem(dfd);
+
+	ctx.skel = skel;
+	ctx.cgrp_dfd = dfd;
+	ctx.map_slab_mem = after - before;
+}
+
+static void qp_trie_attach_prog(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void htab_lookup_setup(void)
+{
+	qp_trie_setup(FOR_HTAB);
+	qp_trie_attach_prog(ctx.skel->progs.htab_lookup);
+}
+
+static void qp_trie_lookup_setup(void)
+{
+	qp_trie_setup(FOR_TRIE);
+	qp_trie_attach_prog(ctx.skel->progs.qp_trie_lookup);
+}
+
+static void htab_update_setup(void)
+{
+	qp_trie_setup(FOR_HTAB);
+	qp_trie_attach_prog(ctx.skel->progs.htab_update);
+}
+
+static void qp_trie_update_setup(void)
+{
+	qp_trie_setup(FOR_TRIE);
+	qp_trie_attach_prog(ctx.skel->progs.qp_trie_update);
+}
+
+static void *qp_trie_producer(void *ctx)
+{
+	while (true)
+		(void)syscall(__NR_getpgid);
+	return NULL;
+}
+
+static void *qp_trie_consumer(void *ctx)
+{
+	return NULL;
+}
+
+static void qp_trie_measure(struct bench_res *res)
+{
+	static __u64 last_hits, last_drops;
+	__u64 total_hits = 0, total_drops = 0;
+	unsigned int i, nr_cpus;
+
+	nr_cpus = bpf_num_possible_cpus();
+	for (i = 0; i < nr_cpus; i++) {
+		struct run_stat *s = (void *)&ctx.skel->bss->percpu_stats[i & 255];
+
+		total_hits += s->stats[0];
+		total_drops += s->stats[1];
+	}
+
+	res->hits = total_hits - last_hits;
+	res->drops = total_drops - last_drops;
+
+	last_hits = total_hits;
+	last_drops = total_drops;
+}
+
+static void qp_trie_report_final(struct bench_res res[], int res_cnt)
+{
+	close(ctx.cgrp_dfd);
+	cleanup_cgroup_environment();
+
+	fprintf(stdout, "Slab: %.3f MiB\n", (float)ctx.map_slab_mem / 1024 / 1024);
+	hits_drops_report_final(res, res_cnt);
+}
+
+const struct bench bench_htab_lookup = {
+	.name = "htab-lookup",
+	.validate = qp_trie_validate,
+	.setup = htab_lookup_setup,
+	.producer_thread = qp_trie_producer,
+	.consumer_thread = qp_trie_consumer,
+	.measure = qp_trie_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = qp_trie_report_final,
+};
+
+const struct bench bench_qp_trie_lookup = {
+	.name = "qp-trie-lookup",
+	.validate = qp_trie_validate,
+	.setup = qp_trie_lookup_setup,
+	.producer_thread = qp_trie_producer,
+	.consumer_thread = qp_trie_consumer,
+	.measure = qp_trie_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = qp_trie_report_final,
+};
+
+const struct bench bench_htab_update = {
+	.name = "htab-update",
+	.validate = qp_trie_validate,
+	.setup = htab_update_setup,
+	.producer_thread = qp_trie_producer,
+	.consumer_thread = qp_trie_consumer,
+	.measure = qp_trie_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = qp_trie_report_final,
+};
+
+const struct bench bench_qp_trie_update = {
+	.name = "qp-trie-update",
+	.validate = qp_trie_validate,
+	.setup = qp_trie_update_setup,
+	.producer_thread = qp_trie_producer,
+	.consumer_thread = qp_trie_consumer,
+	.measure = qp_trie_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = qp_trie_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh b/tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh
new file mode 100755
index 000000000000..0cbcb5bc9292
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022. Huawei Technologies Co., Ltd
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+mem()
+{
+	echo "$*" | sed -E "s/.*Slab: ([0-9]+\.[0-9]+ MiB).*/\1/"
+}
+
+run_qp_trie_bench()
+{
+	local title=$1
+	local summary
+
+	shift 1
+	summary=$($RUN_BENCH "$@" | grep "Summary\|Slab:")
+	printf "%s %20s (drops %-16s mem %s)\n" "$title" "$(hits $summary)" \
+		"$(drops $summary)" "$(mem $summary)"
+}
+
+run_qp_trie_benchs()
+{
+	local p
+	local m
+	local b
+	local title
+
+	for m in htab qp-trie
+	do
+		for b in lookup update
+		do
+			for p in 1 2 4 8 16
+			do
+				title=$(printf "%-16s (%-2d thread)" "$m $b" $p)
+				run_qp_trie_bench "$title" ${m}-${b} -p $p "$@"
+			done
+		done
+	done
+	echo
+}
+
+echo "Randomly-generated binary data (16K)"
+run_qp_trie_benchs --entries 16384
+
+echo "Strings in /proc/kallsyms"
+TMP_FILE=/tmp/kallsyms.txt
+SRC_FILE=/proc/kallsyms
+trap 'rm -f $TMP_FILE' EXIT
+wc -l $SRC_FILE | awk '{ print $1}' > $TMP_FILE
+awk '{ print $3 }' $SRC_FILE >> $TMP_FILE
+run_qp_trie_benchs --file $TMP_FILE
diff --git a/tools/testing/selftests/bpf/progs/qp_trie_bench.c b/tools/testing/selftests/bpf/progs/qp_trie_bench.c
new file mode 100644
index 000000000000..21202c578105
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/qp_trie_bench.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct bpf_map;
+
+/* value_size will be set by benchmark */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, 4);
+} htab_array SEC(".maps");
+
+/* value_size will be set by benchmark */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, 4);
+} trie_array SEC(".maps");
+
+/* key_size will be set by benchmark */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(value_size, 4);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} htab SEC(".maps");
+
+/* key_size will be set by benchmark */
+struct {
+	__uint(type, BPF_MAP_TYPE_QP_TRIE);
+	__uint(value_size, 4);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} qp_trie SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__u64 stats[2];
+} __attribute__((__aligned__(128))) percpu_stats[256];
+
+struct update_ctx {
+	unsigned int max;
+	unsigned int from;
+};
+
+unsigned int update_nr;
+unsigned int update_chunk;
+
+static __always_inline void update_stats(int idx)
+{
+	__u32 cpu = bpf_get_smp_processor_id();
+
+	percpu_stats[cpu & 255].stats[idx]++;
+}
+
+static int lookup_htab(struct bpf_map *map, __u32 *key, void *value, void *data)
+{
+	__u32 *index;
+
+	index = bpf_map_lookup_elem(&htab, value);
+	if (index && *index == *key)
+		update_stats(0);
+	else
+		update_stats(1);
+	return 0;
+}
+
+static int update_htab_loop(unsigned int i, void *ctx)
+{
+	struct update_ctx *update = ctx;
+	void *value;
+	int err;
+
+	if (update->from >= update->max)
+		update->from = 0;
+	value = bpf_map_lookup_elem(&htab_array, &update->from);
+	if (!value)
+		return 1;
+
+	err = bpf_map_update_elem(&htab, value, &update->from, 0);
+	if (!err)
+		update_stats(0);
+	else
+		update_stats(1);
+	update->from++;
+
+	return 0;
+}
+
+static int delete_htab_loop(unsigned int i, void *ctx)
+{
+	struct update_ctx *update = ctx;
+	void *value;
+	int err;
+
+	if (update->from >= update->max)
+		update->from = 0;
+	value = bpf_map_lookup_elem(&htab_array, &update->from);
+	if (!value)
+		return 1;
+
+	err = bpf_map_delete_elem(&htab, value);
+	if (!err)
+		update_stats(0);
+	update->from++;
+
+	return 0;
+}
+
+static int lookup_qp_trie(struct bpf_map *map, __u32 *key, void *value, void *data)
+{
+	__u32 *index;
+
+	index = bpf_map_lookup_elem(&qp_trie, value);
+	if (index && *index == *key)
+		update_stats(0);
+	else
+		update_stats(1);
+	return 0;
+}
+
+static int update_qp_trie_loop(unsigned int i, void *ctx)
+{
+	struct update_ctx *update = ctx;
+	void *value;
+	int err;
+
+	if (update->from >= update->max)
+		update->from = 0;
+	value = bpf_map_lookup_elem(&trie_array, &update->from);
+	if (!value)
+		return 1;
+
+	err = bpf_map_update_elem(&qp_trie, value, &update->from, 0);
+	if (!err)
+		update_stats(0);
+	else
+		update_stats(1);
+	update->from++;
+
+	return 0;
+}
+
+static int delete_qp_trie_loop(unsigned int i, void *ctx)
+{
+	struct update_ctx *update = ctx;
+	void *value;
+	int err;
+
+	if (update->from >= update->max)
+		update->from = 0;
+	value = bpf_map_lookup_elem(&trie_array, &update->from);
+	if (!value)
+		return 1;
+
+	err = bpf_map_delete_elem(&qp_trie, value);
+	if (!err)
+		update_stats(0);
+	update->from++;
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int htab_lookup(void *ctx)
+{
+	bpf_for_each_map_elem(&htab_array, lookup_htab, NULL, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int qp_trie_lookup(void *ctx)
+{
+	bpf_for_each_map_elem(&trie_array, lookup_qp_trie, NULL, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int htab_update(void *ctx)
+{
+	unsigned int index = bpf_get_smp_processor_id() * update_chunk;
+	struct update_ctx update;
+
+	update.max = update_nr;
+	if (update.max && index >= update.max)
+		index %= update.max;
+
+	/* Only operate part of keys according to cpu id */
+	update.from = index;
+	bpf_loop(update_chunk, update_htab_loop, &update, 0);
+
+	update.from = index;
+	bpf_loop(update_chunk, delete_htab_loop, &update, 0);
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int qp_trie_update(void *ctx)
+{
+	unsigned int index = bpf_get_smp_processor_id() * update_chunk;
+	struct update_ctx update;
+
+	update.max = update_nr;
+	if (update.max && index >= update.max)
+		index %= update.max;
+
+	/* Only operate part of keys according to cpu id */
+	update.from = index;
+	bpf_loop(update_chunk, update_qp_trie_loop, &update, 0);
+
+	update.from = index;
+	bpf_loop(update_chunk, delete_qp_trie_loop, &update, 0);
+
+	return 0;
+}
-- 
2.29.2

