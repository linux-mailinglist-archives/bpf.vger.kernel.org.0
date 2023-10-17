Return-Path: <bpf+bounces-12421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00617CC3C7
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E191C20B71
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8128542BFD;
	Tue, 17 Oct 2023 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D642BE9
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:56:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A51BE
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 05:56:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S8v9h2Nyxz4f3lX2
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 20:56:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgB3BdVihC5lIwrSDA--.31244S6;
	Tue, 17 Oct 2023 20:56:09 +0800 (CST)
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
Subject: [PATCH bpf 2/2] selftests/bpf: Test race between map uref release and bpf timer init
Date: Tue, 17 Oct 2023 20:57:17 +0800
Message-Id: <20231017125717.241101-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231017125717.241101-1-houtao@huaweicloud.com>
References: <20231017125717.241101-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3BdVihC5lIwrSDA--.31244S6
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW8Gw1kKF47Ar1kJF1kZrb_yoWxtF48pa
	ySk345Gr48ZrsxGr48ta1UurWftF4kuF4UJrZYg34UZF1xWFnxJF1xKFyjyFW3CFWvvrWf
	Zrs5tFWYyw4UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 000000000000..7bd57459e504
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
index 000000000000..ba67cb178639
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


