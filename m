Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8B5E8D0B
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIXNSe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 09:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiIXNS3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 09:18:29 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F79B5E76
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 06:18:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MZV083rSFz6S2yk
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 21:16:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOXAy9jXzpPBQ--.3282S16;
        Sat, 24 Sep 2022 21:18:25 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 12/13] selftests/bpf: Add benchmark for qp-trie map
Date:   Sat, 24 Sep 2022 21:36:19 +0800
Message-Id: <20220924133620.4147153-13-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOXAy9jXzpPBQ--.3282S16
X-Coremail-Antispam: 1UD129KBjvAXoWfWF1UKw1fKw15uw18GF1xZrb_yoW5Ary3Go
        WfWF47tF4kGr1UZry5K3Z5WFyfZFZrWasxJ39avwnxXFyjyrs093ykCw4fCr12vFs3Jw1U
        ZFZ0qw1fJrW8KFn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYu7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
        67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
        Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Add a benchmark for qp-trie map to compare lookup, update/delete
performance and memory usage with hash table.

When the content of keys are uniformly distributed and there are large
differencies between key length, qp-trie will be dense and has low
height, but the lookup overhead of htab increases due to unnecessary
memory comparison, so the lookup performance of qp-trie will be much
better than hash-table as shown below:

Randomly-generated binary data (key size=255, max entries=16K, key length range:[1, 255])
htab lookup      (1  thread)    4.968 ± 0.009M/s (drops 0.002 ± 0.000M/s mem 8.169 MiB)
htab lookup      (2  thread)   10.118 ± 0.010M/s (drops 0.007 ± 0.000M/s mem 8.169 MiB)
htab lookup      (4  thread)   20.084 ± 0.022M/s (drops 0.007 ± 0.000M/s mem 8.168 MiB)
htab lookup      (8  thread)   39.866 ± 0.047M/s (drops 0.010 ± 0.000M/s mem 8.168 MiB)
htab lookup      (16 thread)   79.412 ± 0.065M/s (drops 0.049 ± 0.000M/s mem 8.169 MiB)
htab update      (1  thread)    2.122 ± 0.021M/s (drops 0.000 ± 0.000M/s mem 8.169 MiB)
htab update      (2  thread)    4.248 ± 0.197M/s (drops 0.000 ± 0.000M/s mem 8.168 MiB)
htab update      (4  thread)    8.475 ± 0.348M/s (drops 0.000 ± 0.000M/s mem 8.180 MiB)
htab update      (8  thread)   16.725 ± 0.633M/s (drops 0.000 ± 0.000M/s mem 8.208 MiB)
htab update      (16 thread)   30.246 ± 0.611M/s (drops 0.000 ± 0.000M/s mem 8.190 MiB)

qp-trie lookup   (1  thread)   10.291 ± 0.007M/s (drops 0.004 ± 0.000M/s mem 4.899 MiB)
qp-trie lookup   (2  thread)   20.797 ± 0.009M/s (drops 0.006 ± 0.000M/s mem 4.879 MiB)
qp-trie lookup   (4  thread)   41.943 ± 0.019M/s (drops 0.015 ± 0.000M/s mem 4.262 MiB)
qp-trie lookup   (8  thread)   81.985 ± 0.032M/s (drops 0.025 ± 0.000M/s mem 4.215 MiB)
qp-trie lookup   (16 thread)  164.681 ± 0.051M/s (drops 0.050 ± 0.000M/s mem 4.261 MiB)
qp-trie update   (1  thread)    1.622 ± 0.016M/s (drops 0.000 ± 0.000M/s mem 4.918 MiB)
qp-trie update   (2  thread)    2.688 ± 0.021M/s (drops 0.000 ± 0.000M/s mem 4.874 MiB)
qp-trie update   (4  thread)    4.062 ± 0.128M/s (drops 0.000 ± 0.000M/s mem 4.218 MiB)
qp-trie update   (8  thread)    7.037 ± 0.247M/s (drops 0.000 ± 0.000M/s mem 4.900 MiB)
qp-trie update   (16 thread)   11.024 ± 0.295M/s (drops 0.000 ± 0.000M/s mem 4.830 MiB)

For the strings in /proc/kallsyms, single-thread lookup performance is
about ~27% slower compared with hash table. When number of threads
increase, lookup performance is almost the same. But update and deletion
performance of qp-trie are much worsed compared with hash table as shown
below:

Strings in /proc/kallsyms (key size=83, max entries=170958)
htab lookup      (1  thread)    5.686 ± 0.008M/s (drops 0.345 ± 0.002M/s mem 30.840 MiB)
htab lookup      (2  thread)   10.147 ± 0.067M/s (drops 0.616 ± 0.005M/s mem 30.841 MiB)
htab lookup      (4  thread)   16.503 ± 0.025M/s (drops 1.002 ± 0.004M/s mem 30.841 MiB)
htab lookup      (8  thread)   33.429 ± 0.146M/s (drops 2.028 ± 0.020M/s mem 30.848 MiB)
htab lookup      (16 thread)   67.249 ± 0.577M/s (drops 4.085 ± 0.032M/s mem 30.841 MiB)
htab update      (1  thread)    3.135 ± 0.355M/s (drops 0.000 ± 0.000M/s mem 30.842 MiB)
htab update      (2  thread)    6.269 ± 0.686M/s (drops 0.000 ± 0.000M/s mem 30.841 MiB)
htab update      (4  thread)   11.607 ± 1.632M/s (drops 0.000 ± 0.000M/s mem 30.840 MiB)
htab update      (8  thread)   23.041 ± 0.806M/s (drops 0.000 ± 0.000M/s mem 30.842 MiB)
htab update      (16 thread)   31.393 ± 0.307M/s (drops 0.000 ± 0.000M/s mem 30.835 MiB)

qp-trie lookup   (1  thread)    4.122 ± 0.010M/s (drops 0.250 ± 0.002M/s mem 30.108 MiB)
qp-trie lookup   (2  thread)    9.119 ± 0.057M/s (drops 0.554 ± 0.004M/s mem 17.422 MiB)
qp-trie lookup   (4  thread)   16.605 ± 0.032M/s (drops 1.008 ± 0.006M/s mem 17.203 MiB)
qp-trie lookup   (8  thread)   33.461 ± 0.058M/s (drops 2.032 ± 0.004M/s mem 16.977 MiB)
qp-trie lookup   (16 thread)   67.466 ± 0.145M/s (drops 4.097 ± 0.019M/s mem 17.452 MiB)
qp-trie update   (1  thread)    1.191 ± 0.093M/s (drops 0.000 ± 0.000M/s mem 17.170 MiB)
qp-trie update   (2  thread)    2.057 ± 0.041M/s (drops 0.000 ± 0.000M/s mem 17.058 MiB)
qp-trie update   (4  thread)    2.975 ± 0.035M/s (drops 0.000 ± 0.000M/s mem 17.411 MiB)
qp-trie update   (8  thread)    3.596 ± 0.031M/s (drops 0.000 ± 0.000M/s mem 17.110 MiB)
qp-trie update   (16 thread)    4.200 ± 0.048M/s (drops 0.000 ± 0.000M/s mem 17.228 MiB)

For strings in BTF string section, the results are similar:

Sorted strings in BTF string sections (key size=71, max entries=115980)
htab lookup      (1  thread)    6.990 ± 0.050M/s (drops 0.000 ± 0.000M/s mem 22.227 MiB)
htab lookup      (2  thread)   12.729 ± 0.059M/s (drops 0.000 ± 0.000M/s mem 22.224 MiB)
htab lookup      (4  thread)   21.202 ± 0.099M/s (drops 0.000 ± 0.000M/s mem 22.218 MiB)
htab lookup      (8  thread)   43.418 ± 0.169M/s (drops 0.000 ± 0.000M/s mem 22.225 MiB)
htab lookup      (16 thread)   88.745 ± 0.410M/s (drops 0.000 ± 0.000M/s mem 22.224 MiB)
htab update      (1  thread)    3.238 ± 0.271M/s (drops 0.000 ± 0.000M/s mem 22.228 MiB)
htab update      (2  thread)    6.483 ± 0.821M/s (drops 0.000 ± 0.000M/s mem 22.227 MiB)
htab update      (4  thread)   12.702 ± 0.924M/s (drops 0.000 ± 0.000M/s mem 22.226 MiB)
htab update      (8  thread)   22.167 ± 1.269M/s (drops 0.000 ± 0.000M/s mem 22.229 MiB)
htab update      (16 thread)   31.225 ± 0.475M/s (drops 0.000 ± 0.000M/s mem 22.239 MiB)

qp-trie lookup   (1  thread)    6.729 ± 0.006M/s (drops 0.000 ± 0.000M/s mem 11.335 MiB)
qp-trie lookup   (2  thread)   13.417 ± 0.010M/s (drops 0.000 ± 0.000M/s mem 11.287 MiB)
qp-trie lookup   (4  thread)   26.399 ± 0.043M/s (drops 0.000 ± 0.000M/s mem 11.111 MiB)
qp-trie lookup   (8  thread)   52.910 ± 0.049M/s (drops 0.000 ± 0.000M/s mem 11.131 MiB)
qp-trie lookup   (16 thread)  105.444 ± 0.064M/s (drops 0.000 ± 0.000M/s mem 11.060 MiB)
qp-trie update   (1  thread)    1.508 ± 0.102M/s (drops 0.000 ± 0.000M/s mem 10.979 MiB)
qp-trie update   (2  thread)    2.877 ± 0.034M/s (drops 0.000 ± 0.000M/s mem 10.843 MiB)
qp-trie update   (4  thread)    5.111 ± 0.083M/s (drops 0.000 ± 0.000M/s mem 10.938 MiB)
qp-trie update   (8  thread)    9.229 ± 0.046M/s (drops 0.000 ± 0.000M/s mem 11.042 MiB)
qp-trie update   (16 thread)   11.625 ± 0.147M/s (drops 0.000 ± 0.000M/s mem 10.930 MiB)

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |   5 +-
 tools/testing/selftests/bpf/bench.c           |  10 +
 .../selftests/bpf/benchs/bench_qp_trie.c      | 511 ++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_qp_trie.sh |  55 ++
 .../selftests/bpf/progs/qp_trie_bench.c       | 236 ++++++++
 5 files changed, 816 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_qp_trie.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d881a23adc84..4cb301bd4204 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -586,11 +586,13 @@ $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
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
@@ -600,7 +602,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
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
index 000000000000..9585e9c83fe8
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_qp_trie.c
@@ -0,0 +1,511 @@
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
+struct qp_trie_key {
+	__u32 len;
+	unsigned char data[0];
+};
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
+static int parse_data_set(const char *name, struct qp_trie_key ***set, unsigned int *nr,
+			  unsigned int *max_len)
+{
+#define INT_MAX_DATA_SIZE 1024
+	unsigned int i, nr_items, item_max_len;
+	char line[INT_MAX_DATA_SIZE + 1];
+	struct qp_trie_key **items;
+	struct qp_trie_key *cur;
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
+	items = (struct qp_trie_key **)calloc(nr_items, sizeof(*items) + INT_MAX_DATA_SIZE);
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
+static int gen_data_set(struct qp_trie_key ***set, unsigned int *nr, unsigned int *max_len)
+{
+#define RND_MAX_DATA_SIZE 255
+	struct qp_trie_key **items;
+	size_t ptr_size, data_size;
+	struct qp_trie_key *cur;
+	unsigned int i, nr_items;
+	ssize_t got;
+	int err = 0;
+
+	ptr_size = *nr * sizeof(*items);
+	data_size = *nr * (sizeof(*cur) + RND_MAX_DATA_SIZE);
+	items = (struct qp_trie_key **)malloc(ptr_size + data_size);
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
+	bpf_map__set_value_size(skel->maps.htab_array, data_size);
+	bpf_map__set_max_entries(skel->maps.htab_array, nr);
+
+	bpf_map__set_key_size(skel->maps.htab, data_size);
+	bpf_map__set_max_entries(skel->maps.htab, nr);
+
+	bpf_map__set_value_size(skel->maps.trie_array, sizeof(struct qp_trie_key) + data_size);
+	bpf_map__set_max_entries(skel->maps.trie_array, nr);
+
+	bpf_map__set_map_extra(skel->maps.qp_trie, data_size);
+	bpf_map__set_max_entries(skel->maps.qp_trie, nr);
+}
+
+static void qp_trie_setup_key_map(struct bpf_map *map, unsigned int map_type,
+				  struct qp_trie_key **set, unsigned int nr)
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
+		fprintf(stdout, "no %s (cgroup v1 ?)\n", name);
+		return 0;
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
+				     struct qp_trie_key **set, unsigned int nr)
+{
+	int fd = bpf_map__fd(map);
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		int err;
+
+		if (map_type == FOR_HTAB) {
+			void *key;
+
+			key = set[i]->data;
+			err = bpf_map_update_elem(fd, key, &i, 0);
+		} else {
+			struct bpf_dynptr_user dynptr;
+
+			bpf_dynptr_user_init(set[i]->data, set[i]->len, &dynptr);
+			err = bpf_map_update_elem(fd, &dynptr, &i, 0);
+		}
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
+	struct qp_trie_key **set = NULL;
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
+	skel->rodata->qp_trie_key_size = max_len;
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
index 000000000000..303cad7e01d6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/qp_trie_bench.c
@@ -0,0 +1,236 @@
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
+struct qp_trie_key {
+	__u32 len;
+	unsigned char data[0];
+};
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
+/* map_extra will be set by benchmark */
+struct {
+	__uint(type, BPF_MAP_TYPE_QP_TRIE);
+	__type(key, struct bpf_dynptr);
+	__type(value, unsigned int);
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
+volatile const unsigned int qp_trie_key_size;
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
+	struct qp_trie_key *qp_trie_key = value;
+	struct bpf_dynptr dynptr;
+	__u32 *index;
+
+	if (qp_trie_key->len > qp_trie_key_size)
+		return 0;
+
+	bpf_dynptr_from_mem(qp_trie_key->data, qp_trie_key->len, 0, &dynptr);
+	index = bpf_map_lookup_elem(&qp_trie, &dynptr);
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
+	struct qp_trie_key *value;
+	struct bpf_dynptr dynptr;
+	int err;
+
+	if (update->from >= update->max)
+		update->from = 0;
+	value = bpf_map_lookup_elem(&trie_array, &update->from);
+	if (!value || value->len > qp_trie_key_size)
+		return 1;
+
+	bpf_dynptr_from_mem(value->data, value->len, 0, &dynptr);
+	err = bpf_map_update_elem(&qp_trie, &dynptr, &update->from, 0);
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
+	struct qp_trie_key *value;
+	struct bpf_dynptr dynptr;
+	int err;
+
+	if (update->from >= update->max)
+		update->from = 0;
+	value = bpf_map_lookup_elem(&trie_array, &update->from);
+	if (!value || value->len > qp_trie_key_size)
+		return 1;
+
+	bpf_dynptr_from_mem(value->data, value->len, 0, &dynptr);
+	err = bpf_map_delete_elem(&qp_trie, &dynptr);
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

