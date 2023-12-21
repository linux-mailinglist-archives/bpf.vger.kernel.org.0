Return-Path: <bpf+bounces-18538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E89A81B95B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3094B28373F
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140CA6D6E2;
	Thu, 21 Dec 2023 14:14:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78836084
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwsqV4Ng8z4f3jqy
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:13:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0724C1A08B4
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:14:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhAkSIRl5A8DEQ--.16750S6;
	Thu, 21 Dec 2023 22:13:59 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add benchmark for bpf memory allocator
Date: Thu, 21 Dec 2023 22:15:01 +0800
Message-Id: <20231221141501.3588586-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231221141501.3588586-1-houtao@huaweicloud.com>
References: <20231221141501.3588586-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhAkSIRl5A8DEQ--.16750S6
X-Coremail-Antispam: 1UD129KBjvAXoW3Zry8WF1fuFykCry5Wr18AFb_yoW8CryrAo
	Wfuw45X3W0grySvrs8Wrn5KF43urWkKryDXr4aq3Z8AFyjkrWYya48Ca1fA347ZFWrt347
	ZFW2v343CrZ7Jrn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add a benchmark to test the performance and memory usage for
bpf_obj_new/bpf_obj_drop() and its percpu variant. The benchmark tests
the performance of bpf_obj_new() or bpf_percpu_obj_new() through the
following steps:
1) find the inner array by using the cpu number as key
2) allocate at most 64 128-bytes-sized objects through bpf_obj_new()
3) stash these objectes into the inner array through bpf_kptr_xchg()
4) account the time used in step 1)~3)
5) calculate the performance in M/s: alloc_cnt * 1000 / alloc_tim_ns
6) calculate the memory usage by reading slub field in memory.stat file
   and get the final value after subtracting the base value.

The performance test for bpf_obj_drop() or bpf_percpu_obj_drop() is
similar. For simplicity, both the number of allocated object in each
batch and the size of the allocated object are fixed as 64 and 128
respectively. When increasing the value of batch, the performance will
degrade a bit but not too much. When increasing the size of the object,
the allocation performance will degraded a lot, and the total used
memory will also increase for per-cpu allocation, but the free
performance doesn't change too much.

The following is the test results conducted on a 8-CPU VM with 16GB memory:

$ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a; done |grep Summary
Summary: per-prod alloc 11.29 ± 0.14M/s free 33.76 ± 0.33M/s, total memory usage    0.01 ± 0.00MiB
Summary: per-prod alloc  7.49 ± 0.12M/s free 34.42 ± 0.56M/s, total memory usage    0.03 ± 0.00MiB
Summary: per-prod alloc  6.66 ± 0.08M/s free 34.27 ± 0.41M/s, total memory usage    0.06 ± 0.00MiB

$ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a --percpu; done |grep Summary
Summary: per-prod alloc 14.64 ± 0.60M/s free 36.94 ± 0.35M/s, total memory usage  188.02 ± 7.43MiB
Summary: per-prod alloc 12.39 ± 1.32M/s free 36.40 ± 0.38M/s, total memory usage  808.90 ± 25.56MiB
Summary: per-prod alloc 10.80 ± 0.17M/s free 35.45 ± 0.25M/s, total memory usage 2330.24 ± 480.56MiB

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 tools/testing/selftests/bpf/bench.h           |   7 +
 .../selftests/bpf/benchs/bench_bpf_ma.c       | 273 ++++++++++++++++++
 .../selftests/bpf/progs/bench_bpf_ma.c        | 222 ++++++++++++++
 5 files changed, 508 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_ma.c
 create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_ma.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d5d781f5427a..05e079f2f7ee 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -692,6 +692,7 @@ $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tas
 $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.skel.h
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
+$(OUTPUT)/bench_bpf_ma.o: $(OUTPUT)/bench_bpf_ma.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -711,6 +712,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
 		 $(OUTPUT)/bench_htab_mem.o \
+		 $(OUTPUT)/bench_bpf_ma.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 4832cd4b1c3d..3bb19b719ac3 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -281,6 +281,7 @@ extern struct argp bench_strncmp_argp;
 extern struct argp bench_hashmap_lookup_argp;
 extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
+extern struct argp bench_bpf_mem_alloc_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -293,6 +294,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
 	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
 	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
+	{ &bench_bpf_mem_alloc_argp, 0, "bpf memory allocator benchmark", 0 },
 	{},
 };
 
@@ -524,6 +526,7 @@ extern const struct bench bench_local_storage_tasks_trace;
 extern const struct bench bench_bpf_hashmap_lookup;
 extern const struct bench bench_local_storage_create;
 extern const struct bench bench_htab_mem;
+extern const struct bench bench_bpf_mem_alloc;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -566,6 +569,7 @@ static const struct bench *benchs[] = {
 	&bench_bpf_hashmap_lookup,
 	&bench_local_storage_create,
 	&bench_htab_mem,
+	&bench_bpf_mem_alloc,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index a6fcf111221f..206cf3de5df2 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -53,6 +53,13 @@ struct bench_res {
 			unsigned long gp_ct;
 			unsigned int stime;
 		} rcu;
+		struct {
+			unsigned long alloc;
+			unsigned long free;
+			unsigned long alloc_ns;
+			unsigned long free_ns;
+			unsigned long mem_bytes;
+		} ma;
 	};
 };
 
diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_ma.c b/tools/testing/selftests/bpf/benchs/bench_bpf_ma.c
new file mode 100644
index 000000000000..35d3a5c80cda
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_ma.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <argp.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <pthread.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/param.h>
+#include <fcntl.h>
+
+#include "bench.h"
+#include "bpf_util.h"
+#include "bench_bpf_ma.skel.h"
+
+static struct bpf_ma_ctx {
+	struct bench_bpf_ma *skel;
+	u64 base_bytes;
+} ctx;
+
+static struct bpf_ma_args {
+	bool percpu;
+} args = {
+	.percpu = false,
+};
+
+enum {
+	ARG_PERCPU = 20000,
+};
+
+static const struct argp_option opts[] = {
+	{ "percpu", ARG_PERCPU, NULL, 0, "percpu alloc/free" },
+	{},
+};
+
+static error_t bpf_ma_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_PERCPU:
+		args.percpu = true;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_bpf_mem_alloc_argp = {
+	.options = opts,
+	.parser = bpf_ma_parse_arg,
+};
+
+static void read_field_in_mem_stat(const char *field, u64 *value)
+{
+	size_t field_len;
+	char line[256];
+	FILE *file;
+
+	*value = 0;
+
+	file = fopen("/sys/fs/cgroup/memory.stat", "r");
+	if (!file) {
+		/* cgroup v1 ? */
+		return;
+	}
+
+	field_len = strlen(field);
+	while (fgets(line, sizeof(line), file)) {
+		if (!strncmp(line, field, field_len)) {
+			*value = strtoull(line + field_len, NULL, 0);
+			break;
+		}
+	}
+
+	fclose(file);
+}
+
+static void bpf_ma_validate(void)
+{
+}
+
+static int bpf_ma_update_outer_map(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct bpf_map *outer_map, *inner_map;
+	unsigned int i, ksize, vsize, max_nr;
+	int fd, err;
+
+	if (env.nr_cpus <= 1)
+		return 0;
+
+	fd = bpf_object__btf_fd(ctx.skel->obj);
+	if (fd < 0) {
+		fprintf(stderr, "no btf_fd error %d\n", fd);
+		return -1;
+	}
+	opts.btf_fd = fd;
+
+	inner_map = args.percpu ? ctx.skel->maps.percpu_inner_array : ctx.skel->maps.inner_array;
+	opts.btf_key_type_id = bpf_map__btf_key_type_id(inner_map);
+	opts.btf_value_type_id = bpf_map__btf_value_type_id(inner_map);
+
+	ksize = bpf_map__key_size(inner_map);
+	vsize = bpf_map__value_size(inner_map);
+	max_nr = bpf_map__max_entries(inner_map);
+
+	outer_map = args.percpu ? ctx.skel->maps.percpu_outer_array : ctx.skel->maps.outer_array;
+	for (i = 1; i < env.nr_cpus; i++) {
+		char name[32];
+
+		snprintf(name, sizeof(name), "inner_array_%u", i);
+		fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, name, ksize, vsize, max_nr, &opts);
+		if (fd < 0) {
+			fprintf(stderr, "create #%d array error %d\n", i, fd);
+			return -1;
+		}
+
+		err = bpf_map_update_elem(bpf_map__fd(outer_map), &i, &fd, 0);
+		if (err) {
+			fprintf(stderr, "add #%d array error %d\n", i, err);
+			close(fd);
+			return -1;
+		}
+		close(fd);
+	}
+
+	return 0;
+}
+
+static void bpf_ma_setup(void)
+{
+	struct bpf_program *prog;
+	struct bpf_map *outer_map;
+	int err;
+
+	setup_libbpf();
+
+	ctx.skel = bench_bpf_ma__open();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		goto cleanup;
+	}
+
+	outer_map = args.percpu ? ctx.skel->maps.percpu_outer_array : ctx.skel->maps.outer_array;
+	bpf_map__set_max_entries(outer_map, env.nr_cpus);
+
+	prog = args.percpu ? ctx.skel->progs.bench_batch_percpu_alloc_free :
+			     ctx.skel->progs.bench_batch_alloc_free;
+	bpf_program__set_autoload(prog, true);
+
+	err = bench_bpf_ma__load(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		goto cleanup;
+	}
+
+	if (bpf_ma_update_outer_map())
+		goto cleanup;
+
+	err = bench_bpf_ma__attach(ctx.skel);
+	if (err) {
+		fprintf(stderr, "failed to attach skeleton\n");
+		goto cleanup;
+	}
+
+	read_field_in_mem_stat(args.percpu ? "percpu " : "slab ", &ctx.base_bytes);
+	return;
+
+cleanup:
+	bench_bpf_ma__destroy(ctx.skel);
+	exit(1);
+}
+
+static void *bpf_ma_producer(void *arg)
+{
+	while (true)
+		(void)syscall(__NR_getpgid, 0);
+	return NULL;
+}
+
+static void bpf_ma_measure(struct bench_res *res)
+{
+	u64 bytes;
+
+	res->ma.alloc = atomic_swap(&ctx.skel->bss->alloc_cnt, 0);
+	res->ma.alloc_ns = atomic_swap(&ctx.skel->bss->alloc_ns, 0);
+	res->ma.free = atomic_swap(&ctx.skel->bss->free_cnt, 0);
+	res->ma.free_ns = atomic_swap(&ctx.skel->bss->free_ns, 0);
+
+	if (args.percpu)
+		read_field_in_mem_stat("percpu ", &bytes);
+	else
+		read_field_in_mem_stat("slab ", &bytes);
+	/* Is memory reclamation in-progress ? */
+	if (bytes < ctx.base_bytes)
+		ctx.base_bytes = bytes;
+	res->ma.mem_bytes = bytes - ctx.base_bytes;
+}
+
+static void bpf_ma_report_progress(int iter, struct bench_res *res, long delta_ns)
+{
+	double alloc = 0.0, free = 0.0, mem;
+
+	if (res->ma.alloc_ns)
+		alloc = res->ma.alloc * 1000.0 / res->ma.alloc_ns;
+	if (res->ma.free_ns)
+		free = res->ma.free * 1000.0 / res->ma.free_ns;
+	mem = res->ma.mem_bytes / 1048576.0;
+
+	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0);
+	printf("per-prod alloc %7.2lfM/s free %7.2lfM/s, total memory usage %7.2lfMiB\n",
+	       alloc, free, mem);
+}
+
+static void bpf_ma_report_final(struct bench_res res[], int res_cnt)
+{
+	double mem_mean = 0.0, mem_stddev = 0.0;
+	double alloc_mean = 0.0, alloc_stddev = 0.0;
+	double free_mean = 0.0, free_stddev = 0.0;
+	double alloc_ns = 0.0, free_ns = 0.0;
+	int i;
+
+	for (i = 0; i < res_cnt; i++) {
+		alloc_ns += res[i].ma.alloc_ns;
+		free_ns += res[i].ma.free_ns;
+	}
+	for (i = 0; i < res_cnt; i++) {
+		if (alloc_ns)
+			alloc_mean += res[i].ma.alloc * 1000.0 / alloc_ns;
+		if (free_ns)
+			free_mean += res[i].ma.free * 1000.0 / free_ns;
+		mem_mean += res[i].ma.mem_bytes / 1048576.0 / (0.0 + res_cnt);
+	}
+	if (res_cnt > 1) {
+		for (i = 0; i < res_cnt; i++) {
+			double sample;
+
+			sample = res[i].ma.alloc_ns ? res[i].ma.alloc * 1000.0 /
+						      res[i].ma.alloc_ns : 0.0;
+			alloc_stddev += (alloc_mean - sample) * (alloc_mean - sample) /
+					(res_cnt - 1.0);
+
+			sample = res[i].ma.free_ns ? res[i].ma.free * 1000.0 /
+						     res[i].ma.free_ns : 0.0;
+			free_stddev += (free_mean - sample) * (free_mean - sample) /
+				       (res_cnt - 1.0);
+
+			sample = res[i].ma.mem_bytes / 1048576.0;
+			mem_stddev += (mem_mean - sample) * (mem_mean - sample) /
+				      (res_cnt - 1.0);
+		}
+		alloc_stddev = sqrt(alloc_stddev);
+		free_stddev = sqrt(free_stddev);
+		mem_stddev = sqrt(mem_stddev);
+	}
+
+	printf("Summary: per-prod alloc %7.2lf \u00B1 %3.2lfM/s free %7.2lf \u00B1 %3.2lfM/s, "
+	       "total memory usage %7.2lf \u00B1 %3.2lfMiB\n",
+	       alloc_mean, alloc_stddev, free_mean, free_stddev,
+	       mem_mean, mem_stddev);
+}
+
+const struct bench bench_bpf_mem_alloc = {
+	.name = "bpf_ma",
+	.argp = &bench_bpf_mem_alloc_argp,
+	.validate = bpf_ma_validate,
+	.setup = bpf_ma_setup,
+	.producer_thread = bpf_ma_producer,
+	.measure = bpf_ma_measure,
+	.report_progress = bpf_ma_report_progress,
+	.report_final = bpf_ma_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/bench_bpf_ma.c b/tools/testing/selftests/bpf/progs/bench_bpf_ma.c
new file mode 100644
index 000000000000..d936fd6a76b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bench_bpf_ma.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+#define ALLOC_OBJ_SIZE 128
+#define ALLOC_BATCH_CNT 64
+
+char _license[] SEC("license") = "GPL";
+
+long alloc_cnt = 0, free_cnt = 0;
+long alloc_ns = 0, free_ns = 0;
+
+struct bin_data {
+	char data[ALLOC_OBJ_SIZE - sizeof(void *)];
+};
+
+struct percpu_bin_data {
+	char data[ALLOC_OBJ_SIZE - sizeof(void *)];
+};
+
+struct percpu_map_value {
+	struct percpu_bin_data __percpu_kptr * data;
+};
+
+struct map_value {
+	struct bin_data __kptr * data;
+};
+
+struct inner_array_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, ALLOC_BATCH_CNT);
+} inner_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(key_size, 4);
+	__uint(value_size, 4);
+	/* benchmark will update max_entries accordingly */
+	__uint(max_entries, 1);
+	__array(values, struct inner_array_type);
+} outer_array SEC(".maps") = {
+	.values = {
+		[0] = &inner_array,
+	},
+};
+
+struct percpu_inner_array_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct percpu_map_value);
+	__uint(max_entries, ALLOC_BATCH_CNT);
+} percpu_inner_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(key_size, 4);
+	__uint(value_size, 4);
+	/* benchmark will update max_entries accordingly */
+	__uint(max_entries, 1);
+	__array(values, struct percpu_inner_array_type);
+} percpu_outer_array SEC(".maps") = {
+	.values = {
+		[0] = &percpu_inner_array,
+	},
+};
+
+/* Return the number of allocated objects */
+static __always_inline unsigned int batch_alloc(struct bpf_map *map)
+{
+	struct bin_data *old, *new;
+	struct map_value *value;
+	unsigned int i, key;
+
+	for (i = 0; i < ALLOC_BATCH_CNT; i++) {
+		key = i;
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value)
+			return i;
+
+		new = bpf_obj_new(typeof(*new));
+		if (!new)
+			return i;
+
+		old = bpf_kptr_xchg(&value->data, new);
+		if (old)
+			bpf_obj_drop(old);
+	}
+
+	return ALLOC_BATCH_CNT;
+}
+
+/* Return the number of freed objects */
+static __always_inline unsigned int batch_free(struct bpf_map *map)
+{
+	struct map_value *value;
+	unsigned int i, key;
+	void *old;
+
+	for (i = 0; i < ALLOC_BATCH_CNT; i++) {
+		key = i;
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value)
+			return i;
+
+		old = bpf_kptr_xchg(&value->data, NULL);
+		if (!old)
+			return i;
+		bpf_obj_drop(old);
+	}
+
+	return ALLOC_BATCH_CNT;
+}
+
+/* Return the number of allocated objects */
+static __always_inline unsigned int batch_percpu_alloc(struct bpf_map *map)
+{
+	struct percpu_bin_data *old, *new;
+	struct percpu_map_value *value;
+	unsigned int i, key;
+
+	for (i = 0; i < ALLOC_BATCH_CNT; i++) {
+		key = i;
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value)
+			return i;
+
+		new = bpf_percpu_obj_new(typeof(*new));
+		if (!new)
+			return i;
+
+		old = bpf_kptr_xchg(&value->data, new);
+		if (old)
+			bpf_percpu_obj_drop(old);
+	}
+
+	return ALLOC_BATCH_CNT;
+}
+
+/* Return the number of freed objects */
+static __always_inline unsigned int batch_percpu_free(struct bpf_map *map)
+{
+	struct percpu_map_value *value;
+	unsigned int i, key;
+	void *old;
+
+	for (i = 0; i < ALLOC_BATCH_CNT; i++) {
+		key = i;
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value)
+			return i;
+
+		old = bpf_kptr_xchg(&value->data, NULL);
+		if (!old)
+			return i;
+		bpf_percpu_obj_drop(old);
+	}
+
+	return ALLOC_BATCH_CNT;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int bench_batch_alloc_free(void *ctx)
+{
+	u64 start, delta;
+	unsigned int cnt;
+	void *map;
+	int key;
+
+	key = bpf_get_smp_processor_id();
+	map = bpf_map_lookup_elem((void *)&outer_array, &key);
+	if (!map)
+		return 0;
+
+	start = bpf_ktime_get_boot_ns();
+	cnt = batch_alloc(map);
+	delta = bpf_ktime_get_boot_ns() - start;
+	__sync_fetch_and_add(&alloc_cnt, cnt);
+	__sync_fetch_and_add(&alloc_ns, delta);
+
+	start = bpf_ktime_get_boot_ns();
+	cnt = batch_free(map);
+	delta = bpf_ktime_get_boot_ns() - start;
+	__sync_fetch_and_add(&free_cnt, cnt);
+	__sync_fetch_and_add(&free_ns, delta);
+
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int bench_batch_percpu_alloc_free(void *ctx)
+{
+	u64 start, delta;
+	unsigned int cnt;
+	void *map;
+	int key;
+
+	key = bpf_get_smp_processor_id();
+	map = bpf_map_lookup_elem((void *)&percpu_outer_array, &key);
+	if (!map)
+		return 0;
+
+	start = bpf_ktime_get_boot_ns();
+	cnt = batch_percpu_alloc(map);
+	delta = bpf_ktime_get_boot_ns() - start;
+	__sync_fetch_and_add(&alloc_cnt, cnt);
+	__sync_fetch_and_add(&alloc_ns, delta);
+
+	start = bpf_ktime_get_boot_ns();
+	cnt = batch_percpu_free(map);
+	delta = bpf_ktime_get_boot_ns() - start;
+	__sync_fetch_and_add(&free_cnt, cnt);
+	__sync_fetch_and_add(&free_ns, delta);
+
+	return 0;
+}
-- 
2.29.2


