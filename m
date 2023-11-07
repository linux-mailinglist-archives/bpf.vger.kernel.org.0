Return-Path: <bpf+bounces-14426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876847E417A
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 15:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA30E1C20CF3
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 14:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C690315AC;
	Tue,  7 Nov 2023 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C731586
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 14:06:03 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42AFA3
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:06:01 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPqkY5BWRz4f3l2q
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C23DC1A0177
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 22:05:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhA_REpl+VkmAQ--.3051S15;
	Tue, 07 Nov 2023 22:05:58 +0800 (CST)
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
Subject: [PATCH bpf 11/11] selftests/bpf: Add test cases for inner map
Date: Tue,  7 Nov 2023 22:07:02 +0800
Message-Id: <20231107140702.1891778-12-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231107140702.1891778-1-houtao@huaweicloud.com>
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhA_REpl+VkmAQ--.3051S15
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWkWrWrCr1rXw1DCw13XFb_yoWfuF43pF
	WfGry5CrW8Jr4UXw4jqa17uFZ0gr4kWw1Utan5Kw1YvF4kWr93Xrs7WFW7XF13urWkAryF
	9wnFyay8G3ykAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add test cases to test the race between the destroy of inner map due to
map-in-map update and the access of inner map in bpf program. The
following 4 combination are added:
(1) array map in map array + bpf program
(2) array map in map array + sleepable bpf program
(3) array map in map htab + bpf program
(4) array map in map htab + sleepable bpf program

Before apply the fixes, when running "./test_prog -a map_in_map" with
net.core.bpf_jit_enable=0, the following error was reported:

  BUG: KASAN: slab-use-after-free in bpf_map_lookup_elem+0x25/0x60
  Read of size 8 at addr ffff888162fbe000 by task test_progs/3282

  CPU: 4 PID: 3282 Comm: test_progs Not tainted 6.6.0-rc5+ #21
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4b/0x80
   print_report+0xcf/0x610
   kasan_report+0x9d/0xd0
   __asan_load8+0x7e/0xb0
   bpf_map_lookup_elem+0x25/0x60
   ___bpf_prog_run+0x2569/0x3c50
   __bpf_prog_run32+0xa1/0xe0
   trace_call_bpf+0x1a9/0x5e0
   kprobe_perf_func+0xce/0x450
   kprobe_dispatcher+0xa1/0xb0
   kprobe_ftrace_handler+0x27b/0x370
   0xffffffffc02080f7
  RIP: 0010:__x64_sys_getpgid+0x1/0x30
  ......
   </TASK>

  Allocated by task 3281:
   kasan_save_stack+0x26/0x50
   kasan_set_track+0x25/0x30
   kasan_save_alloc_info+0x1b/0x30
   __kasan_kmalloc+0x84/0xa0
   __kmalloc_node+0x67/0x170
   __bpf_map_area_alloc+0x13f/0x160
   bpf_map_area_alloc+0x10/0x20
   array_map_alloc+0x11d/0x2c0
   map_create+0x285/0xc30
   __sys_bpf+0xcff/0x3350
   __x64_sys_bpf+0x45/0x60
   do_syscall_64+0x33/0x60
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8

  Freed by task 1328:
   kasan_save_stack+0x26/0x50
   kasan_set_track+0x25/0x30
   kasan_save_free_info+0x2b/0x50
   __kasan_slab_free+0x10f/0x1a0
   __kmem_cache_free+0x1df/0x460
   kfree+0x90/0x140
   kvfree+0x2c/0x40
   bpf_map_area_free+0xe/0x20
   array_map_free+0x11f/0x270
   bpf_map_free_deferred+0xda/0x200
   process_scheduled_works+0x689/0xa20
   worker_thread+0x2fd/0x5a0
   kthread+0x1bf/0x200
   ret_from_fork+0x39/0x70
   ret_from_fork_asm+0x1b/0x30

  Last potentially related work creation:
   kasan_save_stack+0x26/0x50
   __kasan_record_aux_stack+0x92/0xa0
   kasan_record_aux_stack_noalloc+0xb/0x20
   insert_work+0x2a/0xc0
   __queue_work+0x2a6/0x8d0
   queue_work_on+0x7c/0x80
   __bpf_map_put+0x103/0x140
   bpf_map_put+0x10/0x20
   bpf_map_fd_put_ptr+0x1e/0x30
   bpf_fd_array_map_update_elem+0x18a/0x1d0
   bpf_map_update_value+0x2ca/0x4b0
   __sys_bpf+0x26ba/0x3350
   __x64_sys_bpf+0x45/0x60
   do_syscall_64+0x33/0x60
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/map_in_map.c     | 138 ++++++++++++++++++
 .../selftests/bpf/progs/access_map_in_map.c   |  99 +++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/access_map_in_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_in_map.c b/tools/testing/selftests/bpf/prog_tests/map_in_map.c
new file mode 100644
index 0000000000000..b60c5ac1f0222
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_in_map.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "access_map_in_map.skel.h"
+
+struct thread_ctx {
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
+static void *update_map_fn(void *data)
+{
+	struct thread_ctx *ctx = data;
+	int loop = ctx->loop, err = 0;
+
+	if (wait_for_start_or_abort(ctx) < 0)
+		return NULL;
+
+	while (loop-- > 0) {
+		int fd, zero = 0;
+
+		fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 4, 1, NULL);
+		if (fd < 0) {
+			err |= 1;
+			pthread_barrier_wait(&ctx->barrier);
+			continue;
+		}
+
+		/* Remove the old inner map */
+		if (bpf_map_update_elem(ctx->outer_map_fd, &zero, &fd, 0) < 0)
+			err |= 2;
+		close(fd);
+		pthread_barrier_wait(&ctx->barrier);
+	}
+
+	ctx->err = err;
+
+	return NULL;
+}
+
+static void *access_map_fn(void *data)
+{
+	struct thread_ctx *ctx = data;
+	int loop = ctx->loop;
+
+	if (wait_for_start_or_abort(ctx) < 0)
+		return NULL;
+
+	while (loop-- > 0) {
+		/* Access the old inner map */
+		syscall(SYS_getpgid);
+		pthread_barrier_wait(&ctx->barrier);
+	}
+
+	return NULL;
+}
+
+static void test_map_in_map_access(const char *prog_name, const char *map_name)
+{
+	struct access_map_in_map *skel;
+	struct bpf_map *outer_map;
+	struct bpf_program *prog;
+	struct thread_ctx ctx;
+	pthread_t tid[2];
+	int err;
+
+	skel = access_map_in_map__open();
+	if (!ASSERT_OK_PTR(skel, "access_map_in_map open"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "find program"))
+		goto out;
+	bpf_program__set_autoload(prog, true);
+
+	outer_map = bpf_object__find_map_by_name(skel->obj, map_name);
+	if (!ASSERT_OK_PTR(outer_map, "find map"))
+		goto out;
+
+	err = access_map_in_map__load(skel);
+	if (!ASSERT_OK(err, "access_map_in_map load"))
+		goto out;
+
+	err = access_map_in_map__attach(skel);
+	if (!ASSERT_OK(err, "access_map_in_map attach"))
+		goto out;
+
+	skel->bss->tgid = getpid();
+
+	memset(&ctx, 0, sizeof(ctx));
+	pthread_barrier_init(&ctx.barrier, NULL, 2);
+	ctx.outer_map_fd = bpf_map__fd(outer_map);
+	ctx.loop = 8;
+
+	err = pthread_create(&tid[0], NULL, update_map_fn, &ctx);
+	if (!ASSERT_OK(err, "close_thread"))
+		goto out;
+
+	err = pthread_create(&tid[1], NULL, access_map_fn, &ctx);
+	if (!ASSERT_OK(err, "read_thread")) {
+		ctx.abort = 1;
+		pthread_join(tid[0], NULL);
+		goto out;
+	}
+
+	ctx.start = 1;
+	pthread_join(tid[0], NULL);
+	pthread_join(tid[1], NULL);
+
+	ASSERT_OK(ctx.err, "err");
+out:
+	access_map_in_map__destroy(skel);
+}
+
+void test_map_in_map(void)
+{
+	if (test__start_subtest("acc_map_in_array"))
+		test_map_in_map_access("access_map_in_array", "outer_array_map");
+	if (test__start_subtest("sleepable_acc_map_in_array"))
+		test_map_in_map_access("sleepable_access_map_in_array", "outer_array_map");
+	if (test__start_subtest("acc_map_in_htab"))
+		test_map_in_map_access("access_map_in_htab", "outer_htab_map");
+	if (test__start_subtest("sleepable_acc_map_in_htab"))
+		test_map_in_map_access("sleepable_access_map_in_htab", "outer_htab_map");
+}
diff --git a/tools/testing/selftests/bpf/progs/access_map_in_map.c b/tools/testing/selftests/bpf/progs/access_map_in_map.c
new file mode 100644
index 0000000000000..1102998ea509a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/access_map_in_map.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <time.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+struct inner_map_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, 4);
+	__uint(value_size, 4);
+	__uint(max_entries, 1);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+	__array(values, struct inner_map_type);
+} outer_array_map SEC(".maps") = {
+	.values = {
+		[0] = &inner_map,
+	},
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+	__array(values, struct inner_map_type);
+} outer_htab_map SEC(".maps") = {
+	.values = {
+		[0] = &inner_map,
+	},
+};
+
+char _license[] SEC("license") = "GPL";
+
+int tgid = 0;
+
+static int acc_map_in_map(void *outer_map)
+{
+	void *inner_map;
+	int i, key;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != tgid)
+		return 0;
+
+	/* Find nonexistent inner map */
+	key = 1;
+	inner_map = bpf_map_lookup_elem(outer_map, &key);
+	if (inner_map)
+		return 0;
+
+	/* Find the old inner map */
+	key = 0;
+	inner_map = bpf_map_lookup_elem(outer_map, &key);
+	if (!inner_map)
+		return 0;
+
+	/* Wait for the old inner map to be replaced */
+	for (i = 0; i < 256; i++) {
+		int *ptr;
+
+		ptr = bpf_map_lookup_elem(inner_map, &key);
+		if (!ptr)
+			continue;
+		*ptr = 0xdeadbeef;
+	}
+
+	return 0;
+}
+
+SEC("?kprobe/" SYS_PREFIX "sys_getpgid")
+int access_map_in_array(void *ctx)
+{
+	return acc_map_in_map(&outer_array_map);
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int sleepable_access_map_in_array(void *ctx)
+{
+	return acc_map_in_map(&outer_array_map);
+}
+
+SEC("?kprobe/" SYS_PREFIX "sys_getpgid")
+int access_map_in_htab(void *ctx)
+{
+	return acc_map_in_map(&outer_htab_map);
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int sleepable_access_map_in_htab(void *ctx)
+{
+	return acc_map_in_map(&outer_htab_map);
+}
-- 
2.29.2


