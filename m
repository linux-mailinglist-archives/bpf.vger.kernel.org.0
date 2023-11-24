Return-Path: <bpf+bounces-15810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59617F72BB
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7C3B21388
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8641D694;
	Fri, 24 Nov 2023 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3EC10EC
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 03:29:33 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ScCS82frhz4f3jM3
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 19:29:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 240DF1A071C
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 19:29:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xEUiWBloME3Bw--.31197S9;
	Fri, 24 Nov 2023 19:29:30 +0800 (CST)
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
Subject: [PATCH bpf v3 5/6] selftests/bpf: Add test cases for inner map
Date: Fri, 24 Nov 2023 19:30:32 +0800
Message-Id: <20231124113033.503338-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231124113033.503338-1-houtao@huaweicloud.com>
References: <20231124113033.503338-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xEUiWBloME3Bw--.31197S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry8uw1fGw15KrWkGrWUtwb_yoWftry5pF
	WrCry3CrW8JrWUXw4Uta17uFW8Krs5Ww1UtanYkr15ZF1DWr9xXrZ7WFWUXF13urWkAryF
	93ZFyay8G3ykAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add test cases to test the race between the destroy of inner map due to
map-in-map update and the access of inner map in bpf program. The
following 4 combinations are added:
(1) array map in map array + bpf program
(2) array map in map array + sleepable bpf program
(3) array map in map htab + bpf program
(4) array map in map htab + sleepable bpf program

Before applying the fixes, when running `./test_prog -a map_in_map`, the
following error was reported:

  ==================================================================
  BUG: KASAN: slab-use-after-free in array_map_update_elem+0x48/0x3e0
  Read of size 4 at addr ffff888114f33824 by task test_progs/1858

  CPU: 1 PID: 1858 Comm: test_progs Tainted: G           O     6.6.0+ #7
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4a/0x90
   print_report+0xd2/0x620
   kasan_report+0xd1/0x110
   __asan_load4+0x81/0xa0
   array_map_update_elem+0x48/0x3e0
   bpf_prog_be94a9f26772f5b7_access_map_in_array+0xe6/0xf6
   trace_call_bpf+0x1aa/0x580
   kprobe_perf_func+0xdd/0x430
   kprobe_dispatcher+0xa0/0xb0
   kprobe_ftrace_handler+0x18b/0x2e0
   0xffffffffc02280f7
  RIP: 0010:__x64_sys_getpgid+0x1/0x30
  ......
   </TASK>

  Allocated by task 1857:
   kasan_save_stack+0x26/0x50
   kasan_set_track+0x25/0x40
   kasan_save_alloc_info+0x1e/0x30
   __kasan_kmalloc+0x98/0xa0
   __kmalloc_node+0x6a/0x150
   __bpf_map_area_alloc+0x141/0x170
   bpf_map_area_alloc+0x10/0x20
   array_map_alloc+0x11f/0x310
   map_create+0x28a/0xb40
   __sys_bpf+0x753/0x37c0
   __x64_sys_bpf+0x44/0x60
   do_syscall_64+0x36/0xb0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76

  Freed by task 11:
   kasan_save_stack+0x26/0x50
   kasan_set_track+0x25/0x40
   kasan_save_free_info+0x2b/0x50
   __kasan_slab_free+0x113/0x190
   slab_free_freelist_hook+0xd7/0x1e0
   __kmem_cache_free+0x170/0x260
   kfree+0x9b/0x160
   kvfree+0x2d/0x40
   bpf_map_area_free+0xe/0x20
   array_map_free+0x120/0x2c0
   bpf_map_free_deferred+0xd7/0x1e0
   process_one_work+0x462/0x990
   worker_thread+0x370/0x670
   kthread+0x1b0/0x200
   ret_from_fork+0x3a/0x70
   ret_from_fork_asm+0x1b/0x30

  Last potentially related work creation:
   kasan_save_stack+0x26/0x50
   __kasan_record_aux_stack+0x94/0xb0
   kasan_record_aux_stack_noalloc+0xb/0x20
   __queue_work+0x331/0x950
   queue_work_on+0x75/0x80
   bpf_map_put+0xfa/0x160
   bpf_map_fd_put_ptr+0xe/0x20
   bpf_fd_array_map_update_elem+0x174/0x1b0
   bpf_map_update_value+0x2b7/0x4a0
   __sys_bpf+0x2551/0x37c0
   __x64_sys_bpf+0x44/0x60
   do_syscall_64+0x36/0xb0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/map_in_map.c     | 141 ++++++++++++++++++
 .../selftests/bpf/progs/access_map_in_map.c   |  93 ++++++++++++
 2 files changed, 234 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_in_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/access_map_in_map.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_in_map.c b/tools/testing/selftests/bpf/prog_tests/map_in_map.c
new file mode 100644
index 000000000000..d2a10eb4e5b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_in_map.c
@@ -0,0 +1,141 @@
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
+	pthread_barrier_wait(&ctx->barrier);
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
+	pthread_barrier_wait(&ctx->barrier);
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
+	ctx.loop = 4;
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
+
diff --git a/tools/testing/selftests/bpf/progs/access_map_in_map.c b/tools/testing/selftests/bpf/progs/access_map_in_map.c
new file mode 100644
index 000000000000..1126871c2ebd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/access_map_in_map.c
@@ -0,0 +1,93 @@
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
+	int i, key, value = 0xdeadbeef;
+	void *inner_map;
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
+	for (i = 0; i < 2048; i++)
+		bpf_map_update_elem(inner_map, &key, &value, 0);
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


