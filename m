Return-Path: <bpf+bounces-12779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE137D0634
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45701C20F95
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 01:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7820819;
	Fri, 20 Oct 2023 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497564E
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 01:41:25 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D76D6F
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 18:41:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBS3K0rFDz4f3lfV
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 09:41:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnt9ar2jFlqF+2DQ--.48939S6;
	Fri, 20 Oct 2023 09:41:03 +0800 (CST)
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
	Hsin-Wei Hung <hsinweih@uci.edu>,
	houtao1@huawei.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test race between map uref release and bpf timer init
Date: Fri, 20 Oct 2023 09:42:14 +0800
Message-Id: <20231020014214.2471419-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231020014214.2471419-1-houtao@huaweicloud.com>
References: <20231020014214.2471419-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnt9ar2jFlqF+2DQ--.48939S6
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW8Gw1kKF47Ar1kJF1kZrb_yoWxtF4xpa
	ySk345Gr4rZrsxGr48ta1UurWftF4kuF4UJrZYg34UZF1xWFnxJF1xKFyjyFW3CFWvvrWf
	Zrs5tFWYyw4UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

From: Hou Tao <houtao1@huawei.com>

Test race between the release of map ref and bpf_timer_init():
1) create one thread to add array map with bpf_timer into array of
   arrays map repeatedly.
2) create another thread to call getpgid() and call bpf_timer_init()
   in the attached bpf program repeatedly.
3) synchronize these two threads through pthread barrier.

It is a bit hard to trigger the kmemleak by only running the test. I
managed to reproduce the kmemleak by injecting a delay between
t->timer.function = bpf_timer_cb and timer->timer = t in
bpf_timer_init().

The following is the output of kmemleak after reproducing:

unreferenced object 0xffff8881163d3780 (size 96):
  comm "test_progs", pid 539, jiffies 4295358164 (age 23.276s)
  hex dump (first 32 bytes):
    80 37 3d 16 81 88 ff ff 00 00 00 00 00 00 00 00  .7=.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000bbc3f059>] __kmem_cache_alloc_node+0x3b1/0x4a0
    [<00000000a24ddf4d>] __kmalloc_node+0x57/0x140
    [<000000004d577dbf>] bpf_map_kmalloc_node+0x5f/0x180
    [<00000000bd8428d3>] bpf_timer_init+0xf6/0x1b0
    [<0000000086d87323>] 0xffffffffc000c94e
    [<000000005a09e655>] trace_call_bpf+0xc5/0x1c0
    [<0000000051ab837b>] kprobe_perf_func+0x51/0x260
    [<000000000069bbd1>] kprobe_dispatcher+0x61/0x70
    [<000000007dceb75b>] kprobe_ftrace_handler+0x168/0x240
    [<00000000d8721bd7>] 0xffffffffc02010f7
    [<00000000e885b809>] __x64_sys_getpgid+0x1/0x20
    [<000000007be835d8>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/prog_tests/timer_init_race.c          | 138 ++++++++++++++++++
 .../selftests/bpf/progs/timer_init_race.c     |  56 +++++++
 2 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_init_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_init_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_init_race.c b/tools/testing/selftests/bpf/prog_tests/timer_init_race.c
new file mode 100644
index 0000000000000..7bd57459e5048
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_init_race.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "timer_init_race.skel.h"
+
+struct thread_ctx {
+	struct bpf_map_create_opts opts;
+	pthread_barrier_t barrier;
+	int outer_map_fd;
+	int start, abort;
+	int loop, err;
+};
+
+static int wait_for_start_or_abort(struct thread_ctx *ctx)
+{
+	while (!ctx->start && !ctx->abort)
+		usleep(1);
+	return ctx->abort ? -1 : 0;
+}
+
+static void *close_map_fn(void *data)
+{
+	struct thread_ctx *ctx = data;
+	int loop = ctx->loop, err = 0;
+
+	if (wait_for_start_or_abort(ctx) < 0)
+		return NULL;
+
+	while (loop-- > 0) {
+		int fd, zero = 0, i;
+		volatile int s = 0;
+
+		fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, sizeof(struct bpf_timer),
+				    1, &ctx->opts);
+		if (fd < 0) {
+			err |= 1;
+			pthread_barrier_wait(&ctx->barrier);
+			continue;
+		}
+
+		if (bpf_map_update_elem(ctx->outer_map_fd, &zero, &fd, 0) < 0)
+			err |= 2;
+
+		pthread_barrier_wait(&ctx->barrier);
+		/* let bpf_timer_init run first */
+		for (i = 0; i < 5000; i++)
+			s++;
+		close(fd);
+	}
+
+	ctx->err = err;
+
+	return NULL;
+}
+
+static void *init_timer_fn(void *data)
+{
+	struct thread_ctx *ctx = data;
+	int loop = ctx->loop;
+
+	if (wait_for_start_or_abort(ctx) < 0)
+		return NULL;
+
+	while (loop-- > 0) {
+		pthread_barrier_wait(&ctx->barrier);
+		syscall(SYS_getpgid);
+	}
+
+	return NULL;
+}
+
+void test_timer_init_race(void)
+{
+	struct timer_init_race *skel;
+	struct thread_ctx ctx;
+	pthread_t tid[2];
+	struct btf *btf;
+	int err;
+
+	skel = timer_init_race__open();
+	if (!ASSERT_OK_PTR(skel, "timer_init_race open"))
+		return;
+
+	err = timer_init_race__load(skel);
+	if (!ASSERT_EQ(err, 0, "timer_init_race load"))
+		goto out;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	btf = bpf_object__btf(skel->obj);
+	if (!ASSERT_OK_PTR(btf, "timer_init_race btf"))
+		goto out;
+
+	LIBBPF_OPTS_RESET(ctx.opts);
+	ctx.opts.btf_fd = bpf_object__btf_fd(skel->obj);
+	if (!ASSERT_GE((int)ctx.opts.btf_fd, 0, "btf_fd"))
+		goto out;
+	ctx.opts.btf_key_type_id = btf__find_by_name(btf, "int");
+	if (!ASSERT_GT(ctx.opts.btf_key_type_id, 0, "key_type_id"))
+		goto out;
+	ctx.opts.btf_value_type_id = btf__find_by_name_kind(btf, "inner_value", BTF_KIND_STRUCT);
+	if (!ASSERT_GT(ctx.opts.btf_value_type_id, 0, "value_type_id"))
+		goto out;
+
+	err = timer_init_race__attach(skel);
+	if (!ASSERT_EQ(err, 0, "timer_init_race attach"))
+		goto out;
+
+	skel->bss->tgid = getpid();
+
+	pthread_barrier_init(&ctx.barrier, NULL, 2);
+	ctx.outer_map_fd = bpf_map__fd(skel->maps.outer_map);
+	ctx.loop = 8;
+
+	err = pthread_create(&tid[0], NULL, close_map_fn, &ctx);
+	if (!ASSERT_OK(err, "close_thread"))
+		goto out;
+
+	err = pthread_create(&tid[1], NULL, init_timer_fn, &ctx);
+	if (!ASSERT_OK(err, "init_thread")) {
+		ctx.abort = 1;
+		pthread_join(tid[0], NULL);
+		goto out;
+	}
+
+	ctx.start = 1;
+	pthread_join(tid[0], NULL);
+	pthread_join(tid[1], NULL);
+
+	ASSERT_EQ(ctx.err, 0, "error");
+	ASSERT_EQ(skel->bss->cnt, 8, "cnt");
+out:
+	timer_init_race__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_init_race.c b/tools/testing/selftests/bpf/progs/timer_init_race.c
new file mode 100644
index 0000000000000..ba67cb1786399
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_init_race.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <time.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+struct inner_value {
+	struct bpf_timer timer;
+};
+
+struct inner_map_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct inner_value);
+	__uint(max_entries, 1);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+	__array(values, struct inner_map_type);
+} outer_map SEC(".maps") = {
+	.values = {
+		[0] = &inner_map,
+	},
+};
+
+char _license[] SEC("license") = "GPL";
+
+int tgid = 0, cnt = 0;
+
+SEC("kprobe/" SYS_PREFIX "sys_getpgid")
+int do_timer_init(void *ctx)
+{
+	struct inner_map_type *map;
+	struct inner_value *value;
+	int zero = 0;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != tgid)
+		return 0;
+
+	map = bpf_map_lookup_elem(&outer_map, &zero);
+	if (!map)
+		return 0;
+	value = bpf_map_lookup_elem(map, &zero);
+	if (!value)
+		return 0;
+	bpf_timer_init(&value->timer, map, CLOCK_MONOTONIC);
+	cnt++;
+
+	return 0;
+}
-- 
2.29.2


