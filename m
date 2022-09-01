Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0E5A8DE7
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiIAGBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 02:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiIAGBk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 02:01:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A3CE3C06
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 23:01:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJ9PN1lYCzlDyP
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 14:00:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXO5ShBjaMHaAA--.4132S8;
        Thu, 01 Sep 2022 14:01:34 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Test concurrent updates on bpf_task_storage_busy
Date:   Thu,  1 Sep 2022 14:19:38 +0800
Message-Id: <20220901061938.3789460-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220901061938.3789460-1-houtao@huaweicloud.com>
References: <20220901061938.3789460-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXO5ShBjaMHaAA--.4132S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary8tF4UGw4rJry3WrWktFb_yoW7tw1xpa
        yIkF90krs5J3Z5Jr1rXwsrAry5K3Z3Za17Crs5GF93Aw40qF95Xr1xKr17ZFyfWw4YqFW3
        ZrsIqF45Gr1DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Under full preemptible kernel, task local storage lookup operations on
the same CPU may update per-cpu bpf_task_storage_busy concurrently. If
the update of bpf_task_storage_busy is not preemption safe, the final
value of bpf_task_storage_busy may become not-zero forever and
bpf_task_storage_trylock() will always fail. So add a test case to
ensure the update of bpf_task_storage_busy is preemption safe.

Will skip the test case when CONFIG_PREEMPT is disabled, and it can only
reproduce the problem probabilistically. By increasing
TASK_STORAGE_MAP_NR_LOOP and running it under ARM64 VM with 4-cpus, it
takes about four rounds to reproduce:

> test_maps is modified to only run test_task_storage_map_stress_lookup()
$ export TASK_STORAGE_MAP_NR_THREAD=256
$ export TASK_STORAGE_MAP_NR_LOOP=81920
$ export TASK_STORAGE_MAP_PIN_CPU=1
$ time ./test_maps
test_task_storage_map_stress_lookup(135):FAIL:bad bpf_task_storage_busy got -2

real    0m24.743s
user    0m6.772s
sys     0m17.966s

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/map_tests/task_storage_map.c          | 122 ++++++++++++++++++
 .../bpf/progs/read_bpf_task_storage_busy.c    |  39 ++++++
 2 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
new file mode 100644
index 000000000000..1adc9c292eb2
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <string.h>
+#include <pthread.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "test_maps.h"
+#include "task_local_storage_helpers.h"
+#include "read_bpf_task_storage_busy.skel.h"
+
+struct lookup_ctx {
+	bool start;
+	bool stop;
+	int pid_fd;
+	int map_fd;
+	int loop;
+};
+
+static void *lookup_fn(void *arg)
+{
+	struct lookup_ctx *ctx = arg;
+	long value;
+	int i = 0;
+
+	while (!ctx->start)
+		usleep(1);
+
+	while (!ctx->stop && i++ < ctx->loop)
+		bpf_map_lookup_elem(ctx->map_fd, &ctx->pid_fd, &value);
+	return NULL;
+}
+
+static void abort_lookup(struct lookup_ctx *ctx, pthread_t *tids, unsigned int nr)
+{
+	unsigned int i;
+
+	ctx->stop = true;
+	ctx->start = true;
+	for (i = 0; i < nr; i++)
+		pthread_join(tids[i], NULL);
+}
+
+void test_task_storage_map_stress_lookup(void)
+{
+#define MAX_NR_THREAD 4096
+	unsigned int i, nr = 256, loop = 8192, cpu = 0;
+	struct read_bpf_task_storage_busy *skel;
+	pthread_t tids[MAX_NR_THREAD];
+	struct lookup_ctx ctx;
+	cpu_set_t old, new;
+	const char *cfg;
+	int err;
+
+	cfg = getenv("TASK_STORAGE_MAP_NR_THREAD");
+	if (cfg) {
+		nr = atoi(cfg);
+		if (nr > MAX_NR_THREAD)
+			nr = MAX_NR_THREAD;
+	}
+	cfg = getenv("TASK_STORAGE_MAP_NR_LOOP");
+	if (cfg)
+		loop = atoi(cfg);
+	cfg = getenv("TASK_STORAGE_MAP_PIN_CPU");
+	if (cfg)
+		cpu = atoi(cfg);
+
+	skel = read_bpf_task_storage_busy__open_and_load();
+	err = libbpf_get_error(skel);
+	CHECK(err, "open_and_load", "error %d\n", err);
+
+	/* Only for a fully preemptible kernel */
+	if (!skel->kconfig->CONFIG_PREEMPT)
+		return;
+
+	/* Save the old affinity setting */
+	sched_getaffinity(getpid(), sizeof(old), &old);
+
+	/* Pinned on a specific CPU */
+	CPU_ZERO(&new);
+	CPU_SET(cpu, &new);
+	sched_setaffinity(getpid(), sizeof(new), &new);
+
+	ctx.start = false;
+	ctx.stop = false;
+	ctx.pid_fd = sys_pidfd_open(getpid(), 0);
+	ctx.map_fd = bpf_map__fd(skel->maps.task);
+	ctx.loop = loop;
+	for (i = 0; i < nr; i++) {
+		err = pthread_create(&tids[i], NULL, lookup_fn, &ctx);
+		if (err) {
+			abort_lookup(&ctx, tids, i);
+			CHECK(err, "pthread_create", "error %d\n", err);
+			goto out;
+		}
+	}
+
+	ctx.start = true;
+	for (i = 0; i < nr; i++)
+		pthread_join(tids[i], NULL);
+
+	skel->bss->pid = getpid();
+	err = read_bpf_task_storage_busy__attach(skel);
+	CHECK(err, "attach", "error %d\n", err);
+
+	/* Trigger program */
+	syscall(SYS_gettid);
+	skel->bss->pid = 0;
+
+	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
+out:
+	read_bpf_task_storage_busy__destroy(skel);
+	/* Restore affinity setting */
+	sched_setaffinity(getpid(), sizeof(old), &old);
+}
diff --git a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
new file mode 100644
index 000000000000..a47bb0120719
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+extern bool CONFIG_PREEMPT __kconfig __weak;
+extern const int bpf_task_storage_busy __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+int busy = 0;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} task SEC(".maps");
+
+SEC("raw_tp/sys_enter")
+int BPF_PROG(read_bpf_task_storage_busy)
+{
+	int *value;
+	int key;
+
+	if (!CONFIG_PREEMPT)
+		return 0;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	value = bpf_this_cpu_ptr(&bpf_task_storage_busy);
+	if (value)
+		busy = *value;
+
+	return 0;
+}
-- 
2.29.2

