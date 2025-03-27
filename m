Return-Path: <bpf+bounces-54797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99084A72B65
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F43B89E4
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400E205AB4;
	Thu, 27 Mar 2025 08:23:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004A20551B
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063786; cv=none; b=sfOM8C6//VONGn5kErwgS1u74J9VLwGWaRqb8Am8Zcw7DOQ9W94fDi+EBLClbUomKByA55HHEztClAijw3qjUWbjMBWxvueGiSNegOtEn1wJZbVuh2mqaJFfDkvOe/xBDamtWbRhYuz5VQI4t7IXub6I6nSiUCcUUMmdTIlTm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063786; c=relaxed/simple;
	bh=jsHcPvzAgEZzjh5ScCzVPZ0vTANFXgVeGakCQ0LWmzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nu4lGvQaH86nm1eb+fU0ykqzaKAJZBHzEITdCX4BPzQi1y2/kGdrrY5P4jC4zmJkH5aN4OpNmQ+90WVFT7dl7gEdnGo7BGhDIvlmsRRtPcxm+S3QYd2fV1GmBAVvcLgi9WRHHz+vI2DtCKITe8pT8kqk6Z3gYRLgxPC7rWuFGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8s2FVyz4f3jdF
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 42F1A1A0A1D
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:23:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S20;
	Thu, 27 Mar 2025 16:22:59 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 16/16] selftests/bpf: Add benchmark for dynptr key support in hash map
Date: Thu, 27 Mar 2025 16:34:55 +0800
Message-Id: <20250327083455.848708-17-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S20
X-Coremail-Antispam: 1UD129KBjvAXoWfAFWxtw4kKFW8Xw1DuF45ZFb_yoW5urW3Co
	WfWFsxA3yrCr1UA3s8Gw1kC3Z3Z3yDGa47J39YvwnxXFyUtw43urykCw4fCw42vrW5tw17
	ZFZ8t34Sq3yjgFn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The patch adds a benchmark test to compare the lookup and update/delete
performance between normal hash map and dynptr-keyed hash map. It also
compares the memory usage of these two maps after fill up these two
maps.

The benchmark simulates the case when the map key is composed of a
8-bytes integer and a variable-size string. Now the integer just saves
the length of the string. These strings will be randomly generated by
default, and they can also be specified by a external file (e.g., the
output from awk '{print $3}' /proc/kallsyms).

The key definitions for dynptr-keyed and normal hash map are defined as
shown below:

struct dynptr_key {
	__u64 cookie;
	struct bpf_dynptr desc;
}

struct norm_key {
	__u64 cookie;
	char desc[MAX_STR_SIZE];
};

The lookup or update procedure will first lookup an array to get the key
of hash map. The returned value from the array is the same as norm_key
definition. For normal hash map, it will use the returned value to
manipulate the hash map directly. For dynptr-keyed hash map, it will
construct a bpf_dynptr object from the returned value (the value of
cookie is the same as the string length), then passes the key to
dynptr-keyed hash map. Because the lookup procedure is lockless,
therefore, each producer during lookup test will lookup the whole hash
map. However, update and deletion procedures have lock, therefore, each
producer during update test only updates different part of the hash map.

The following is the benchmark results when running the benchmark under a
8-CPUs VM:

(1) Randomly generate 128K strings (max_size=256, entries=128K)

ENTRIES=131072 ./benchs/run_bench_dynptr_key.sh

normal hash map
===============
htab-lookup-p1-131072     2.779 ± 0.091M/s (drops 0.006 ± 0.000M/s, mem 64.984 MiB)
htab-lookup-p2-131072     5.504 ± 0.060M/s (drops 0.013 ± 0.000M/s, mem 64.966 MiB)
htab-lookup-p4-131072     10.791 ± 0.054M/s (drops 0.025 ± 0.000M/s, mem 64.984 MiB)
htab-lookup-p8-131072     20.947 ± 0.053M/s (drops 0.046 ± 0.000M/s, mem 64.984 MiB)
htab-neg-lookup-p1-131072 0.000 ± 0.000M/s (drops 3.464 ± 0.088M/s, mem 64.984 MiB)
htab-neg-lookup-p2-131072 0.000 ± 0.000M/s (drops 6.731 ± 0.063M/s, mem 64.984 MiB)
htab-neg-lookup-p4-131072 0.000 ± 0.000M/s (drops 13.380 ± 0.174M/s, mem 64.984 MiB)
htab-neg-lookup-p8-131072 0.000 ± 0.000M/s (drops 26.433 ± 0.398M/s, mem 64.966 MiB)
htab-update-p1-131072     1.988 ± 0.025M/s (drops 0.000 ± 0.000M/s, mem 64.968 MiB)
htab-update-p2-131072     3.225 ± 0.032M/s (drops 0.000 ± 0.000M/s, mem 64.986 MiB)
htab-update-p4-131072     6.982 ± 0.084M/s (drops 0.000 ± 0.000M/s, mem 64.986 MiB)
htab-update-p8-131072     13.103 ± 0.180M/s (drops 0.000 ± 0.000M/s, mem 64.986 MiB)

dynptr-keyed hash map
=====================
htab-lookup-p1-131072     3.477 ± 0.045M/s (drops 0.007 ± 0.000M/s, mem 34.905 MiB)
htab-lookup-p2-131072     6.798 ± 0.056M/s (drops 0.015 ± 0.000M/s, mem 34.969 MiB)
htab-lookup-p4-131072     13.600 ± 0.161M/s (drops 0.029 ± 0.000M/s, mem 34.911 MiB)
htab-lookup-p8-131072     25.831 ± 0.559M/s (drops 0.055 ± 0.001M/s, mem 34.907 MiB)
htab-neg-lookup-p1-131072 0.000 ± 0.000M/s (drops 4.748 ± 0.067M/s, mem 34.957 MiB)
htab-neg-lookup-p2-131072 0.000 ± 0.000M/s (drops 9.420 ± 0.049M/s, mem 34.975 MiB)
htab-neg-lookup-p4-131072 0.000 ± 0.000M/s (drops 19.186 ± 0.326M/s, mem 34.953 MiB)
htab-neg-lookup-p8-131072 0.000 ± 0.000M/s (drops 38.055 ± 0.613M/s, mem 34.995 MiB)
htab-update-p1-131072     2.072 ± 0.046M/s (drops 0.000 ± 0.000M/s, mem 34.950 MiB)
htab-update-p2-131072     2.935 ± 0.066M/s (drops 0.000 ± 0.000M/s, mem 34.946 MiB)
htab-update-p4-131072     6.371 ± 0.113M/s (drops 0.000 ± 0.000M/s, mem 34.949 MiB)
htab-update-p8-131072     11.646 ± 0.330M/s (drops 0.000 ± 0.000M/s, mem 34.924 MiB)

(2) Use strings in /proc/kallsyms (max_size=82, entries=150K)

STR_FILE=kallsyms.txt ./benchs/run_bench_dynptr_key.sh

normal hash map
===============
htab-lookup-p1-kallsyms.txt 6.508 ± 0.186M/s (drops 0.000 ± 0.000M/s, mem 31.026 MiB)
htab-lookup-p2-kallsyms.txt 13.381 ± 0.270M/s (drops 0.000 ± 0.000M/s, mem 31.026 MiB)
htab-lookup-p4-kallsyms.txt 26.838 ± 0.465M/s (drops 0.000 ± 0.000M/s, mem 31.026 MiB)
htab-lookup-p8-kallsyms.txt 51.290 ± 0.880M/s (drops 0.000 ± 0.000M/s, mem 31.026 MiB)
htab-neg-lookup-p1-kallsyms.txt 0.000 ± 0.000M/s (drops 7.771 ± 0.242M/s, mem 31.026 MiB)
htab-neg-lookup-p2-kallsyms.txt 0.000 ± 0.000M/s (drops 15.626 ± 0.155M/s, mem 31.026 MiB)
htab-neg-lookup-p4-kallsyms.txt 0.000 ± 0.000M/s (drops 31.766 ± 0.442M/s, mem 31.026 MiB)
htab-neg-lookup-p8-kallsyms.txt 0.000 ± 0.000M/s (drops 63.766 ± 1.379M/s, mem 31.026 MiB)
htab-update-p1-kallsyms.txt 3.240 ± 0.152M/s (drops 0.000 ± 0.000M/s, mem 31.028 MiB)
htab-update-p2-kallsyms.txt 5.268 ± 0.078M/s (drops 0.000 ± 0.000M/s, mem 31.028 MiB)
htab-update-p4-kallsyms.txt 11.192 ± 0.201M/s (drops 0.000 ± 0.000M/s, mem 31.028 MiB)
htab-update-p8-kallsyms.txt 21.098 ± 0.179M/s (drops 0.000 ± 0.000M/s, mem 31.028 MiB)

dynptr-keyed hash map
=====================
htab-lookup-p1-kallsyms.txt 6.366 ± 0.247M/s (drops 0.000 ± 0.000M/s, mem 24.572 MiB)
htab-lookup-p2-kallsyms.txt 12.477 ± 0.223M/s (drops 0.000 ± 0.000M/s, mem 24.572 MiB)
htab-lookup-p4-kallsyms.txt 25.797 ± 0.593M/s (drops 0.000 ± 0.000M/s, mem 24.572 MiB)
htab-lookup-p8-kallsyms.txt 51.070 ± 1.471M/s (drops 0.000 ± 0.000M/s, mem 24.572 MiB)
htab-neg-lookup-p1-kallsyms.txt 0.000 ± 0.000M/s (drops 7.600 ± 0.183M/s, mem 24.572 MiB)
htab-neg-lookup-p2-kallsyms.txt 0.000 ± 0.000M/s (drops 15.182 ± 0.193M/s, mem 24.572 MiB)
htab-neg-lookup-p4-kallsyms.txt 0.000 ± 0.000M/s (drops 30.680 ± 0.496M/s, mem 24.572 MiB)
htab-neg-lookup-p8-kallsyms.txt 0.000 ± 0.000M/s (drops 60.880 ± 0.754M/s, mem 24.572 MiB)
htab-update-p1-kallsyms.txt 2.868 ± 0.078M/s (drops 0.000 ± 0.000M/s, mem 24.574 MiB)
htab-update-p2-kallsyms.txt 4.357 ± 0.039M/s (drops 0.000 ± 0.000M/s, mem 24.574 MiB)
htab-update-p4-kallsyms.txt 9.149 ± 0.131M/s (drops 0.000 ± 0.000M/s, mem 24.574 MiB)
htab-update-p8-kallsyms.txt 16.804 ± 0.425M/s (drops 0.000 ± 0.000M/s, mem 24.574 MiB)

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  14 +
 .../selftests/bpf/benchs/bench_dynptr_key.c   | 648 ++++++++++++++++++
 .../bpf/benchs/run_bench_dynptr_key.sh        |  51 ++
 .../selftests/bpf/progs/dynptr_key_bench.c    | 249 +++++++
 5 files changed, 964 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_dynptr_key.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_dynptr_key.sh
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_key_bench.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c0a8207a50d94..4a212845dce25 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -812,6 +812,7 @@ $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.ske
 $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
+$(OUTPUT)/bench_dynptr_key.o: $(OUTPUT)/dynptr_key_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -832,6 +833,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_local_storage_create.o \
 		 $(OUTPUT)/bench_htab_mem.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
+		 $(OUTPUT)/bench_dynptr_key.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b3..a47077154ff0f 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -283,6 +283,7 @@ extern struct argp bench_local_storage_create_argp;
 extern struct argp bench_htab_mem_argp;
 extern struct argp bench_trigger_batch_argp;
 extern struct argp bench_crypto_argp;
+extern struct argp bench_dynptr_key_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -297,6 +298,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
 	{ &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
 	{ &bench_crypto_argp, 0, "bpf crypto benchmark", 0 },
+	{ &bench_dynptr_key_argp, 0, "dynptr key benchmark", 0 },
 	{},
 };
 
@@ -549,6 +551,12 @@ extern const struct bench bench_local_storage_create;
 extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
+extern const struct bench bench_norm_htab_lookup;
+extern const struct bench bench_dynkey_htab_lookup;
+extern const struct bench bench_norm_htab_neg_lookup;
+extern const struct bench bench_dynkey_htab_neg_lookup;
+extern const struct bench bench_norm_htab_update;
+extern const struct bench bench_dynkey_htab_update;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -609,6 +617,12 @@ static const struct bench *benchs[] = {
 	&bench_htab_mem,
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
+	&bench_norm_htab_lookup,
+	&bench_dynkey_htab_lookup,
+	&bench_norm_htab_neg_lookup,
+	&bench_dynkey_htab_neg_lookup,
+	&bench_norm_htab_update,
+	&bench_dynkey_htab_update,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_dynptr_key.c b/tools/testing/selftests/bpf/benchs/bench_dynptr_key.c
new file mode 100644
index 0000000000000..4dd83c52a4d11
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_dynptr_key.c
@@ -0,0 +1,648 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <argp.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "bench.h"
+#include "bpf_util.h"
+#include "cgroup_helpers.h"
+#include "testing_helpers.h"
+
+#include "dynptr_key_bench.skel.h"
+
+enum {
+	NORM_HTAB = 0,
+	DYNPTR_KEY_HTAB,
+};
+
+static struct dynptr_key_ctx {
+	struct dynptr_key_bench *skel;
+	int cgrp_dfd;
+	u64 map_slab_mem;
+} ctx;
+
+static struct {
+	const char *file;
+	__u32 entries;
+	__u32 max_size;
+} args = {
+	.max_size = 256,
+};
+
+struct run_stat {
+	__u64 stats[2];
+};
+
+struct dynkey_key {
+	/* prevent unnecessary hole */
+	__u64 cookie;
+	struct bpf_dynptr desc;
+};
+
+struct var_size_str {
+	/* the same size as cookie */
+	__u64 len;
+	unsigned char data[];
+};
+
+enum {
+	ARG_DATA_FILE = 11001,
+	ARG_DATA_ENTRIES = 11002,
+	ARG_MAX_SIZE = 11003,
+};
+
+static const struct argp_option opts[] = {
+	{ "file", ARG_DATA_FILE, "DATA-FILE", 0, "Set data file" },
+	{ "entries", ARG_DATA_ENTRIES, "DATA-ENTRIES", 0, "Set data entries" },
+	{ "max_size", ARG_MAX_SIZE, "MAX-SIZE", 0, "Set data max size" },
+	{},
+};
+
+static error_t dynptr_key_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_DATA_FILE:
+		args.file = strdup(arg);
+		if (!args.file) {
+			fprintf(stderr, "no mem for file name\n");
+			argp_usage(state);
+		}
+		break;
+	case ARG_DATA_ENTRIES:
+		args.entries = strtoul(arg, NULL, 10);
+		break;
+	case ARG_MAX_SIZE:
+		args.max_size = strtoul(arg, NULL, 10);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+const struct argp bench_dynptr_key_argp = {
+	.options = opts,
+	.parser = dynptr_key_parse_arg,
+};
+
+static int count_nr_item(const char *name, char *buf, size_t size, unsigned int *nr_items)
+{
+	unsigned int i = 0;
+	FILE *file;
+	int err;
+
+	file = fopen(name, "rb");
+	if (!file) {
+		fprintf(stderr, "open %s err %s\n", name, strerror(errno));
+		return -1;
+	}
+
+	err = 0;
+	while (true) {
+		unsigned int len;
+		char *got;
+
+		got = fgets(buf, size, file);
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
+		if (!len)
+			continue;
+		i++;
+	}
+	fclose(file);
+
+	if (!err)
+		*nr_items = i;
+
+	return err;
+}
+
+static int parse_data_set(const char *name, struct var_size_str ***set, unsigned int *nr,
+			  unsigned int *max_len)
+{
+#define FILE_DATA_MAX_SIZE 4096
+	unsigned int i, nr_items, item_max_len;
+	char line[FILE_DATA_MAX_SIZE + 1];
+	struct var_size_str **items;
+	struct var_size_str *cur;
+	int err = 0;
+	FILE *file;
+	char *got;
+
+	if (count_nr_item(name, line, sizeof(line), &nr_items))
+		return -1;
+	if (!nr_items) {
+		fprintf(stderr, "empty file ?\n");
+		return -1;
+	}
+	fprintf(stdout, "%u items in %s\n", nr_items, name);
+	/* Only use part of data in the file */
+	if (*nr && nr_items > *nr)
+		nr_items = *nr;
+
+	file = fopen(name, "rb");
+	if (!file) {
+		fprintf(stderr, "open %s err %s\n", name, strerror(errno));
+		return -1;
+	}
+
+	items = (struct var_size_str **)calloc(nr_items, sizeof(*items) + FILE_DATA_MAX_SIZE);
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
+		if (!len)
+			continue;
+
+		if (i >= nr_items)
+			break;
+
+		if (len > item_max_len)
+			item_max_len = len;
+		cur->len = len;
+		memcpy(cur->data, got, len);
+		items[i++] = cur;
+		cur = (void *)cur + FILE_DATA_MAX_SIZE;
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
+static int gen_data_set(unsigned int max_size, unsigned int nr, struct var_size_str ***set,
+			unsigned int *max_len)
+{
+/* Due to the limitation of bpf memory allocator */
+#define GEN_DATA_MAX_SIZE 4088
+	struct var_size_str **items;
+	size_t ptr_size, data_size;
+	struct var_size_str *cur;
+	unsigned int i;
+	size_t left;
+	ssize_t got;
+	int err = 0;
+	void *dst;
+
+	ptr_size = nr * sizeof(*items);
+	data_size = nr * (sizeof(*cur) + max_size);
+	items = (struct var_size_str **)malloc(ptr_size + data_size);
+	if (!items) {
+		fprintf(stderr, "no mem for items\n");
+		err = -1;
+		goto out;
+	}
+
+	cur = (void *)items + ptr_size;
+	dst = cur;
+	left = data_size;
+	while (left > 0) {
+		got = syscall(__NR_getrandom, dst, left, 0);
+		if (got <= 0) {
+			fprintf(stderr, "getrandom error %s got %zd\n", strerror(errno), got);
+			err = -1;
+			goto out;
+		}
+		left -= got;
+		dst += got;
+	}
+
+	for (i = 0; i < nr; i++) {
+		cur->len &= (max_size - 1);
+		cur->len += 1;
+		if (cur->len > GEN_DATA_MAX_SIZE)
+			cur->len = GEN_DATA_MAX_SIZE;
+		items[i] = cur;
+		memset(cur->data + cur->len, 0, max_size - cur->len);
+		cur = (void *)cur + (sizeof(*cur) + max_size);
+	}
+	fprintf(stdout, "generate %u random keys (max size %u)\n", nr, max_size);
+
+	*set = items;
+	*max_len = max_size <= GEN_DATA_MAX_SIZE ? max_size : GEN_DATA_MAX_SIZE;
+out:
+	if (err && items)
+		free(items);
+	return err;
+}
+
+static inline bool is_pow_of_2(size_t x)
+{
+	return x && (x & (x - 1)) == 0;
+}
+
+static void dynptr_key_validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "dynptr_key benchmark doesn't support consumer!\n");
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
+
+	if (args.entries && !is_pow_of_2(args.max_size)) {
+		fprintf(stderr, "invalid max size %u (should be power-of-two)\n", args.max_size);
+		exit(1);
+	}
+}
+
+static void dynptr_key_init_map_opts(struct dynptr_key_bench *skel, unsigned int data_size,
+				     unsigned int nr)
+{
+	/* The value will be used as the key for hash map */
+	bpf_map__set_value_size(skel->maps.array,
+				offsetof(struct dynkey_key, desc) + data_size);
+	bpf_map__set_max_entries(skel->maps.array, nr);
+
+	bpf_map__set_key_size(skel->maps.htab, offsetof(struct dynkey_key, desc) + data_size);
+	bpf_map__set_max_entries(skel->maps.htab, nr);
+
+	bpf_map__set_max_entries(skel->maps.dynkey_htab, nr);
+}
+
+static void dynptr_key_setup_key_map(struct bpf_map *map, struct var_size_str **set,
+				     unsigned int nr)
+{
+	int fd = bpf_map__fd(map);
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		void *value;
+		int err;
+
+		value = (void *)set[i];
+		err = bpf_map_update_elem(fd, &i, value, 0);
+		if (err) {
+			fprintf(stderr, "add #%u key (%s) on %s error %d\n",
+				i, set[i]->data, bpf_map__name(map), err);
+			exit(1);
+		}
+	}
+}
+
+static u64 dynptr_key_get_slab_mem(int dfd)
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
+static void dynptr_key_setup_lookup_map(struct bpf_map *map, unsigned int map_type,
+					struct var_size_str **set, unsigned int nr)
+{
+	int fd = bpf_map__fd(map);
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		struct dynkey_key dynkey;
+		void *key;
+		int err;
+
+		if (map_type == NORM_HTAB) {
+			key = set[i];
+		} else {
+			dynkey.cookie = set[i]->len;
+			bpf_dynptr_user_init(set[i]->data, set[i]->len, &dynkey.desc);
+			key = &dynkey;
+		}
+		/* May have duplicated keys */
+		err = bpf_map_update_elem(fd, key, &i, 0);
+		if (err) {
+			fprintf(stderr, "add #%u key (%s) on %s error %d\n",
+				i, set[i]->data, bpf_map__name(map), err);
+			exit(1);
+		}
+	}
+}
+
+static void dump_data_set_metric(struct var_size_str **set, unsigned int nr)
+{
+	double mean = 0.0, stddev = 0.0;
+	unsigned int max = 0;
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		if (set[i]->len > max)
+			max = set[i]->len;
+		mean += set[i]->len / (0.0 + nr);
+	}
+
+	if (nr > 1)  {
+		for (i = 0; i < nr; i++)
+			stddev += (mean - set[i]->len) * (mean - set[i]->len) / (nr - 1.0);
+		stddev = sqrt(stddev);
+	}
+
+	fprintf(stdout, "str length: max %u mean %.0f stdev %.0f\n", max, mean, stddev);
+}
+
+static inline unsigned int roundup_pow_of_2(unsigned int n)
+{
+	return 1U << (n > 1 ? 32 - __builtin_clz(n - 1) : 0);
+}
+
+static void dynptr_key_setup(unsigned int map_type, const char *prog_name, bool neg_test)
+{
+	struct var_size_str **set = NULL, **neg_set = NULL;
+	unsigned int nr, max_len, neg_max_len;
+	struct dynptr_key_bench *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	struct bpf_map *map;
+	u64 before, after;
+	int dfd;
+	int err;
+
+	nr = args.entries;
+	if (!args.file)
+		err = gen_data_set(args.max_size, nr, &set, &max_len);
+	else
+		err = parse_data_set(args.file, &set, &nr, &max_len);
+	if (err < 0)
+		exit(1);
+
+	dump_data_set_metric(set, nr);
+
+	if (neg_test) {
+		err = gen_data_set(roundup_pow_of_2(max_len), nr, &neg_set, &neg_max_len);
+		if (err)
+			goto free_str_set;
+	}
+
+	dfd = cgroup_setup_and_join("/dynptr_key");
+	if (dfd < 0) {
+		fprintf(stderr, "failed to setup cgroup env\n");
+		goto free_str_set;
+	}
+
+	setup_libbpf();
+
+	before = dynptr_key_get_slab_mem(dfd);
+
+	skel = dynptr_key_bench__open();
+	if (!skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		goto leave_cgroup;
+	}
+
+	dynptr_key_init_map_opts(skel, max_len, nr);
+
+	skel->rodata->max_dynkey_size = max_len;
+	skel->bss->update_nr = nr;
+	skel->bss->update_chunk = nr / env.producer_cnt;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!prog) {
+		fprintf(stderr, "no such prog %s\n", prog_name);
+		goto destroy_skel;
+	}
+	bpf_program__set_autoload(prog, true);
+
+	err = dynptr_key_bench__load(skel);
+	if (err) {
+		fprintf(stderr, "failed to load skeleton\n");
+		goto destroy_skel;
+	}
+
+	dynptr_key_setup_key_map(skel->maps.array, neg_test ? neg_set : set, nr);
+
+	map = (map_type == NORM_HTAB) ? skel->maps.htab : skel->maps.dynkey_htab;
+	dynptr_key_setup_lookup_map(map, map_type, set, nr);
+
+	after = dynptr_key_get_slab_mem(dfd);
+
+	link = bpf_program__attach(prog);
+	if (!link) {
+		fprintf(stderr, "failed to attach %s\n", prog_name);
+		goto destroy_skel;
+	}
+
+	ctx.skel = skel;
+	ctx.cgrp_dfd = dfd;
+	ctx.map_slab_mem = after - before;
+	free(neg_set);
+	free(set);
+	return;
+
+destroy_skel:
+	dynptr_key_bench__destroy(skel);
+leave_cgroup:
+	close(dfd);
+	cleanup_cgroup_environment();
+free_str_set:
+	free(neg_set);
+	free(set);
+	exit(1);
+}
+
+static void dynkey_htab_lookup_setup(void)
+{
+	dynptr_key_setup(DYNPTR_KEY_HTAB, "dynkey_htab_lookup", false);
+}
+
+static void norm_htab_lookup_setup(void)
+{
+	dynptr_key_setup(NORM_HTAB, "htab_lookup", false);
+}
+
+static void dynkey_htab_neg_lookup_setup(void)
+{
+	dynptr_key_setup(DYNPTR_KEY_HTAB, "dynkey_htab_lookup", true);
+}
+
+static void norm_htab_neg_lookup_setup(void)
+{
+	dynptr_key_setup(NORM_HTAB, "htab_lookup", true);
+}
+
+static void dynkey_htab_update_setup(void)
+{
+	dynptr_key_setup(DYNPTR_KEY_HTAB, "dynkey_htab_update", false);
+}
+
+static void norm_htab_update_setup(void)
+{
+	dynptr_key_setup(NORM_HTAB, "htab_update", false);
+}
+
+static void *dynptr_key_producer(void *ctx)
+{
+	while (true)
+		(void)syscall(__NR_getpgid);
+	return NULL;
+}
+
+static void dynptr_key_measure(struct bench_res *res)
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
+static void dynptr_key_report_final(struct bench_res res[], int res_cnt)
+{
+	close(ctx.cgrp_dfd);
+	cleanup_cgroup_environment();
+
+	fprintf(stdout, "Slab: %.3f MiB\n", (float)ctx.map_slab_mem / 1024 / 1024);
+	hits_drops_report_final(res, res_cnt);
+}
+
+const struct bench bench_dynkey_htab_lookup = {
+	.name = "dynkey-htab-lookup",
+	.argp = &bench_dynptr_key_argp,
+	.validate = dynptr_key_validate,
+	.setup = dynkey_htab_lookup_setup,
+	.producer_thread = dynptr_key_producer,
+	.measure = dynptr_key_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = dynptr_key_report_final,
+};
+
+const struct bench bench_norm_htab_lookup = {
+	.name = "norm-htab-lookup",
+	.argp = &bench_dynptr_key_argp,
+	.validate = dynptr_key_validate,
+	.setup = norm_htab_lookup_setup,
+	.producer_thread = dynptr_key_producer,
+	.measure = dynptr_key_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = dynptr_key_report_final,
+};
+
+const struct bench bench_dynkey_htab_neg_lookup = {
+	.name = "dynkey-htab-neg-lookup",
+	.argp = &bench_dynptr_key_argp,
+	.validate = dynptr_key_validate,
+	.setup = dynkey_htab_neg_lookup_setup,
+	.producer_thread = dynptr_key_producer,
+	.measure = dynptr_key_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = dynptr_key_report_final,
+};
+
+const struct bench bench_norm_htab_neg_lookup = {
+	.name = "norm-htab-neg-lookup",
+	.argp = &bench_dynptr_key_argp,
+	.validate = dynptr_key_validate,
+	.setup = norm_htab_neg_lookup_setup,
+	.producer_thread = dynptr_key_producer,
+	.measure = dynptr_key_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = dynptr_key_report_final,
+};
+
+const struct bench bench_dynkey_htab_update = {
+	.name = "dynkey-htab-update",
+	.argp = &bench_dynptr_key_argp,
+	.validate = dynptr_key_validate,
+	.setup = dynkey_htab_update_setup,
+	.producer_thread = dynptr_key_producer,
+	.measure = dynptr_key_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = dynptr_key_report_final,
+};
+
+const struct bench bench_norm_htab_update = {
+	.name = "norm-htab-update",
+	.argp = &bench_dynptr_key_argp,
+	.validate = dynptr_key_validate,
+	.setup = norm_htab_update_setup,
+	.producer_thread = dynptr_key_producer,
+	.measure = dynptr_key_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = dynptr_key_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_dynptr_key.sh b/tools/testing/selftests/bpf/benchs/run_bench_dynptr_key.sh
new file mode 100755
index 0000000000000..a15e1a9f7ab02
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/run_bench_dynptr_key.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./benchs/run_common.sh
+
+set -eufo pipefail
+
+prod_list=${PROD_LIST:-"1 2 4 8"}
+entries=${ENTRIES:-8192}
+max_size=${MAX_SIZE:-256}
+str_file=${STR_FILE:-}
+
+summarize_rate_and_mem()
+{
+	local bench="$1"
+	local mem=$(echo $2 | grep Slab: | \
+		sed -E "s/.*Slab:\s+([0-9]+\.[0-9]+ MiB).*/\1/")
+	local summary=$(echo $2 | tail -n1)
+
+	printf "%-25s %s (drops %s, mem %s)\n" "$bench" "$(hits $summary)" \
+		"$(drops $summary)" "$mem"
+}
+
+htab_bench()
+{
+	local opts="--entries ${entries} --max_size ${max_size}"
+	local desc="${entries}"
+	local name
+	local prod
+
+	if test -n "${str_file}" && test -f "${str_file}"
+	then
+		opts="--file ${str_file}"
+		desc="${str_file}"
+	fi
+
+	for name in htab-lookup htab-neg-lookup htab-update
+	do
+		for prod in ${prod_list}
+		do
+			summarize_rate_and_mem "${name}-p${prod}-${desc}" \
+				"$($RUN_BENCH -p${prod} ${1}-${name} ${opts})"
+		done
+	done
+}
+
+header "normal hash map"
+htab_bench norm
+
+header "dynptr-keyed hash map"
+htab_bench dynkey
diff --git a/tools/testing/selftests/bpf/progs/dynptr_key_bench.c b/tools/testing/selftests/bpf/progs/dynptr_key_bench.c
new file mode 100644
index 0000000000000..8bd81f53e610a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dynptr_key_bench.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct bpf_map;
+
+struct dynkey_key {
+	/* Use 8 bytes to prevent unnecessary hole */
+	__u64 cookie;
+	struct bpf_dynptr desc;
+};
+
+struct var_size_key {
+	__u64 len;
+	unsigned char data[];
+};
+
+/* Its value will be used as the key of hash map. The size of value is fixed,
+ * however, the first 8 bytes denote the length of valid data in the value.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, 4);
+} array SEC(".maps");
+
+/* key_size will be set by benchmark */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(value_size, 4);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} htab SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, struct dynkey_key);
+	__type(value, unsigned int);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} dynkey_htab SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__u64 stats[2];
+} __attribute__((__aligned__(256))) percpu_stats[256];
+
+struct update_ctx {
+	unsigned int max;
+	unsigned int from;
+};
+
+volatile const unsigned int max_dynkey_size;
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
+static int lookup_dynkey_htab(struct bpf_map *map, __u32 *key, void *value, void *data)
+{
+	struct var_size_key *var_size_key = value;
+	struct dynkey_key dynkey;
+	__u32 *index;
+	__u64 len;
+
+	len = var_size_key->len;
+	if (len > max_dynkey_size)
+		return 0;
+
+	dynkey.cookie = len;
+	bpf_dynptr_from_mem(var_size_key->data, len, 0, &dynkey.desc);
+	index = bpf_map_lookup_elem(&dynkey_htab, &dynkey);
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
+	value = bpf_map_lookup_elem(&array, &update->from);
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
+	value = bpf_map_lookup_elem(&array, &update->from);
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
+static int update_dynkey_htab_loop(unsigned int i, void *ctx)
+{
+	struct update_ctx *update = ctx;
+	struct var_size_key *value;
+	struct dynkey_key dynkey;
+	__u64 len;
+	int err;
+
+	if (update->from >= update->max)
+		update->from = 0;
+	value = bpf_map_lookup_elem(&array, &update->from);
+	if (!value)
+		return 1;
+	len = value->len;
+	if (len > max_dynkey_size)
+		return 1;
+
+	dynkey.cookie = len;
+	bpf_dynptr_from_mem(value->data, len, 0, &dynkey.desc);
+	err = bpf_map_update_elem(&dynkey_htab, &dynkey, &update->from, 0);
+	if (!err)
+		update_stats(0);
+	else
+		update_stats(1);
+	update->from++;
+
+	return 0;
+}
+
+static int delete_dynkey_htab_loop(unsigned int i, void *ctx)
+{
+	struct update_ctx *update = ctx;
+	struct var_size_key *value;
+	struct dynkey_key dynkey;
+	__u64 len;
+	int err;
+
+	if (update->from >= update->max)
+		update->from = 0;
+	value = bpf_map_lookup_elem(&array, &update->from);
+	if (!value)
+		return 1;
+	len = value->len;
+	if (len > max_dynkey_size)
+		return 1;
+
+	dynkey.cookie = len;
+	bpf_dynptr_from_mem(value->data, len, 0, &dynkey.desc);
+	err = bpf_map_delete_elem(&dynkey_htab, &dynkey);
+	if (!err)
+		update_stats(0);
+	update->from++;
+
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_getpgid")
+int htab_lookup(void *ctx)
+{
+	bpf_for_each_map_elem(&array, lookup_htab, NULL, 0);
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_getpgid")
+int dynkey_htab_lookup(void *ctx)
+{
+	bpf_for_each_map_elem(&array, lookup_dynkey_htab, NULL, 0);
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_getpgid")
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
+SEC("?tp/syscalls/sys_enter_getpgid")
+int dynkey_htab_update(void *ctx)
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
+	bpf_loop(update_chunk, update_dynkey_htab_loop, &update, 0);
+
+	update.from = index;
+	bpf_loop(update_chunk, delete_dynkey_htab_loop, &update, 0);
+
+	return 0;
+}
-- 
2.29.2


