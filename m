Return-Path: <bpf+bounces-8246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC6784190
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AD3280EAF
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C071CA03;
	Tue, 22 Aug 2023 13:06:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17A1C9FF
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:06:16 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92810CDD
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:06:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RVV325MxJz4f3mJy
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:06:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBH16m+suRk0ldIBQ--.4082S7;
	Tue, 22 Aug 2023 21:06:09 +0800 (CST)
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test preemption between bpf_obj_new() and bpf_obj_drop()
Date: Tue, 22 Aug 2023 21:38:07 +0800
Message-Id: <20230822133807.3198625-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230822133807.3198625-1-houtao@huaweicloud.com>
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBH16m+suRk0ldIBQ--.4082S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKr47WFW7Xw1fGw4kXr4kXrb_yoWxWw1Upa
	yfAry0kwn2qw17G34Sqan7Cr4rtrW8X3W8JryfWFy5Zr17Wr95tr1xKFyYqF93KrWvqw4r
	uFn8tFWkArWkJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

The test case creates 4 threads and then pins these 4 threads in CPU 0.
These 4 threads will run different bpf program through
bpf_prog_test_run_opts() and these bpf program will use bpf_obj_new()
and bpf_obj_drop() to allocate and free local kptrs concurrently.

Under preemptible kernel, bpf_obj_new() and bpf_obj_drop() may preempt
each other, bpf_obj_new() may return NULL and the test will fail before
the fixes are applied as shown below:

  test_preempted_bpf_ma_op:PASS:open_and_load 0 nsec
  test_preempted_bpf_ma_op:PASS:attach 0 nsec
  test_preempted_bpf_ma_op:PASS:no test prog 0 nsec
  test_preempted_bpf_ma_op:PASS:no test prog 0 nsec
  test_preempted_bpf_ma_op:PASS:no test prog 0 nsec
  test_preempted_bpf_ma_op:PASS:no test prog 0 nsec
  test_preempted_bpf_ma_op:PASS:pthread_create 0 nsec
  test_preempted_bpf_ma_op:PASS:pthread_create 0 nsec
  test_preempted_bpf_ma_op:PASS:pthread_create 0 nsec
  test_preempted_bpf_ma_op:PASS:pthread_create 0 nsec
  test_preempted_bpf_ma_op:PASS:run prog err 0 nsec
  test_preempted_bpf_ma_op:PASS:run prog err 0 nsec
  test_preempted_bpf_ma_op:PASS:run prog err 0 nsec
  test_preempted_bpf_ma_op:PASS:run prog err 0 nsec
  test_preempted_bpf_ma_op:FAIL:ENOMEM unexpected ENOMEM: got TRUE
  #168     preempted_bpf_ma_op:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/prog_tests/preempted_bpf_ma_op.c      |  89 +++++++++++++++
 .../selftests/bpf/progs/preempted_bpf_ma_op.c | 106 ++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempted_bpf_ma_op.c

diff --git a/tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c b/tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
new file mode 100644
index 000000000000..9ac7210af4c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <test_progs.h>
+
+#include "preempted_bpf_ma_op.skel.h"
+
+#define ALLOC_THREAD_NR 4
+#define ALLOC_LOOP_NR 512
+
+struct alloc_ctx {
+	/* output */
+	int run_err;
+	/* input */
+	int fd;
+	bool *nomem_err;
+};
+
+static void *run_alloc_prog(void *data)
+{
+	struct alloc_ctx *ctx = data;
+	cpu_set_t cpu_set;
+	int i;
+
+	CPU_ZERO(&cpu_set);
+	CPU_SET(0, &cpu_set);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
+
+	for (i = 0; i < ALLOC_LOOP_NR && !*ctx->nomem_err; i++) {
+		LIBBPF_OPTS(bpf_test_run_opts, topts);
+		int err;
+
+		err = bpf_prog_test_run_opts(ctx->fd, &topts);
+		ctx->run_err |= err | topts.retval;
+	}
+
+	return NULL;
+}
+
+void test_preempted_bpf_ma_op(void)
+{
+	struct alloc_ctx ctx[ALLOC_THREAD_NR];
+	struct preempted_bpf_ma_op *skel;
+	pthread_t tid[ALLOC_THREAD_NR];
+	int i, err;
+
+	skel = preempted_bpf_ma_op__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = preempted_bpf_ma_op__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(ctx); i++) {
+		struct bpf_program *prog;
+		char name[8];
+
+		snprintf(name, sizeof(name), "test%d", i);
+		prog = bpf_object__find_program_by_name(skel->obj, name);
+		if (!ASSERT_OK_PTR(prog, "no test prog"))
+			goto out;
+
+		ctx[i].run_err = 0;
+		ctx[i].fd = bpf_program__fd(prog);
+		ctx[i].nomem_err = &skel->bss->nomem_err;
+	}
+
+	memset(tid, 0, sizeof(tid));
+	for (i = 0; i < ARRAY_SIZE(tid); i++) {
+		err = pthread_create(&tid[i], NULL, run_alloc_prog, &ctx[i]);
+		if (!ASSERT_OK(err, "pthread_create"))
+			break;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tid); i++) {
+		if (!tid[i])
+			continue;
+		pthread_join(tid[i], NULL);
+		ASSERT_EQ(ctx[i].run_err, 0, "run prog err");
+	}
+
+	ASSERT_FALSE(skel->bss->nomem_err, "ENOMEM");
+out:
+	preempted_bpf_ma_op__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/preempted_bpf_ma_op.c b/tools/testing/selftests/bpf/progs/preempted_bpf_ma_op.c
new file mode 100644
index 000000000000..55907ef961bf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/preempted_bpf_ma_op.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_experimental.h"
+
+struct bin_data {
+	char data[256];
+	struct bpf_spin_lock lock;
+};
+
+struct map_value {
+	struct bin_data __kptr * data;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 2048);
+} array SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+bool nomem_err = false;
+
+static int del_array(unsigned int i, int *from)
+{
+	struct map_value *value;
+	struct bin_data *old;
+
+	value = bpf_map_lookup_elem(&array, from);
+	if (!value)
+		return 1;
+
+	old = bpf_kptr_xchg(&value->data, NULL);
+	if (old)
+		bpf_obj_drop(old);
+
+	(*from)++;
+	return 0;
+}
+
+static int add_array(unsigned int i, int *from)
+{
+	struct bin_data *old, *new;
+	struct map_value *value;
+
+	value = bpf_map_lookup_elem(&array, from);
+	if (!value)
+		return 1;
+
+	new = bpf_obj_new(typeof(*new));
+	if (!new) {
+		nomem_err = true;
+		return 1;
+	}
+
+	old = bpf_kptr_xchg(&value->data, new);
+	if (old)
+		bpf_obj_drop(old);
+
+	(*from)++;
+	return 0;
+}
+
+static void del_then_add_array(int from)
+{
+	int i;
+
+	i = from;
+	bpf_loop(512, del_array, &i, 0);
+
+	i = from;
+	bpf_loop(512, add_array, &i, 0);
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG2(test0, int, a)
+{
+	del_then_add_array(0);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test2")
+int BPF_PROG2(test1, int, a, u64, b)
+{
+	del_then_add_array(512);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test3")
+int BPF_PROG2(test2, char, a, int, b, u64, c)
+{
+	del_then_add_array(1024);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test4")
+int BPF_PROG2(test3, void *, a, char, b, int, c, u64, d)
+{
+	del_then_add_array(1536);
+	return 0;
+}
-- 
2.29.2


