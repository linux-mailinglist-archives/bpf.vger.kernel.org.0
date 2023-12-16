Return-Path: <bpf+bounces-18079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0323815723
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 04:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7AB1C2497C
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABBB107B2;
	Sat, 16 Dec 2023 03:54:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAE10793
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SsXJW646hz4f3jMC
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 11:54:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E47DD1A05FB
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 11:54:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAnKQ9cH31lN48ZDw--.3025S4;
	Sat, 16 Dec 2023 11:54:06 +0800 (CST)
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
Subject: [PATCH RESEND bpf-next v2] selftests/bpf: Test the release of map btf
Date: Sat, 16 Dec 2023 11:55:10 +0800
Message-Id: <20231216035510.4030605-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnKQ9cH31lN48ZDw--.3025S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4rXr4fAF1rXFW7Wr4kWFg_yoWfGFWkpa
	yrKr1Ykr1vgwsrWrW8Ja1YkFySyw4rZ34UtrnYg34YvrWUZryfXr4IgFW7tFnIkrZ7KF4Y
	v3ZIqF18C397AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When there is bpf_list_head or bpf_rb_root field in map value, the free
of map btf and the free of map value may run concurrently and there may
be use-after-free problem, so add two test cases to demonstrate it. And
the use-after-free problem can been easily reproduced by using bpf_next
tree and a KASAN-enabled kernel.

The first test case tests the racing between the free of map btf and the
free of array map. It constructs the racing by releasing the array map in
the end after other ref-counter of map btf has been released. To delay
the free of array map and make it be invoked after btf_free_rcu() is
invoked, it stresses system_unbound_wq by closing multiple percpu array
maps before it closes the array map.

The second case tests the racing between the free of map btf and the
free of inner map. Beside using the similar method as the first one
does, it uses bpf_map_delete_elem() to delete the inner map and to defer
the release of inner map after one RCU grace period.

The reason for using two skeletons is to prevent the release of outer
map and inner map in map_in_map_btf.c interfering the release of bpf
map in normal_map_btf.c.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
Hi,

Considering the commit 59e5791f59dd ("bpf: Fix a race condition between
btf_put() and map_free()") has been landed in bpf-next tree, so I resend
the reproducible test case after adding ack from Yonghong.

Change log:
v2:
  * make map_btf/array_btf to reproduce the UAF problem reliably
  * update comment in do_test_map_in_map_btf()
  * check done in add_to_list_in_{array,inner_array}()

v1: https://lore.kernel.org/bpf/81c277e9-856c-7763-8e76-7b76aa39d1dc@huaweicloud.com

 .../selftests/bpf/prog_tests/map_btf.c        | 98 +++++++++++++++++++
 .../selftests/bpf/progs/map_in_map_btf.c      | 73 ++++++++++++++
 .../selftests/bpf/progs/normal_map_btf.c      | 56 +++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_in_map_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/normal_map_btf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_btf.c b/tools/testing/selftests/bpf/prog_tests/map_btf.c
new file mode 100644
index 000000000000..2c4ef6037573
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_btf.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <test_progs.h>
+
+#include "normal_map_btf.skel.h"
+#include "map_in_map_btf.skel.h"
+
+static void do_test_normal_map_btf(void)
+{
+	struct normal_map_btf *skel;
+	int i, err, new_fd = -1;
+	int map_fd_arr[64];
+
+	skel = normal_map_btf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+
+	err = normal_map_btf__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	skel->bss->pid = getpid();
+	usleep(1);
+	ASSERT_TRUE(skel->bss->done, "done");
+
+	/* Use percpu_array to slow bpf_map_free_deferred() down.
+	 * The memory allocation may fail, so doesn't check the returned fd.
+	 */
+	for (i = 0; i < ARRAY_SIZE(map_fd_arr); i++)
+		map_fd_arr[i] = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, NULL, 4, 4, 256, NULL);
+
+	/* Close array fd later */
+	new_fd = dup(bpf_map__fd(skel->maps.array));
+out:
+	normal_map_btf__destroy(skel);
+	if (new_fd < 0)
+		return;
+	/* Use kern_sync_rcu() to wait for the start of the free of the bpf
+	 * program and use an assumed delay to wait for the release of the map
+	 * btf which is held by other maps (e.g, bss). After that, array map
+	 * holds the last reference of map btf.
+	 */
+	kern_sync_rcu();
+	usleep(4000);
+	/* Spawn multiple kworkers to delay the invocation of
+	 * bpf_map_free_deferred() for array map.
+	 */
+	for (i = 0; i < ARRAY_SIZE(map_fd_arr); i++) {
+		if (map_fd_arr[i] < 0)
+			continue;
+		close(map_fd_arr[i]);
+	}
+	close(new_fd);
+}
+
+static void do_test_map_in_map_btf(void)
+{
+	int err, zero = 0, new_fd = -1;
+	struct map_in_map_btf *skel;
+
+	skel = map_in_map_btf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+
+	err = map_in_map_btf__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	skel->bss->pid = getpid();
+	usleep(1);
+	ASSERT_TRUE(skel->bss->done, "done");
+
+	/* Close inner_array fd later */
+	new_fd = dup(bpf_map__fd(skel->maps.inner_array));
+	/* Defer the free of inner_array */
+	err = bpf_map__delete_elem(skel->maps.outer_array, &zero, sizeof(zero), 0);
+	ASSERT_OK(err, "delete inner map");
+out:
+	map_in_map_btf__destroy(skel);
+	if (new_fd < 0)
+		return;
+	/* Use kern_sync_rcu() to wait for the start of the free of the bpf
+	 * program and use an assumed delay to wait for the free of the outer
+	 * map and the release of map btf. After that, inner map holds the last
+	 * reference of map btf.
+	 */
+	kern_sync_rcu();
+	usleep(10000);
+	close(new_fd);
+}
+
+void test_map_btf(void)
+{
+	if (test__start_subtest("array_btf"))
+		do_test_normal_map_btf();
+	if (test__start_subtest("inner_array_btf"))
+		do_test_map_in_map_btf();
+}
diff --git a/tools/testing/selftests/bpf/progs/map_in_map_btf.c b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
new file mode 100644
index 000000000000..7a1336d7b16a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct node_data {
+	__u64 data;
+	struct bpf_list_node node;
+};
+
+struct map_value {
+	struct bpf_list_head head __contains(node_data, node);
+	struct bpf_spin_lock lock;
+};
+
+struct inner_array_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} inner_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(key_size, 4);
+	__uint(value_size, 4);
+	__uint(max_entries, 1);
+	__array(values, struct inner_array_type);
+} outer_array SEC(".maps") = {
+	.values = {
+		[0] = &inner_array,
+	},
+};
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+bool done = false;
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int add_to_list_in_inner_array(void *ctx)
+{
+	struct map_value *value;
+	struct node_data *new;
+	struct bpf_map *map;
+	int zero = 0;
+
+	if (done || (u32)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	map = bpf_map_lookup_elem(&outer_array, &zero);
+	if (!map)
+		return 0;
+
+	value = bpf_map_lookup_elem(map, &zero);
+	if (!value)
+		return 0;
+
+	new = bpf_obj_new(typeof(*new));
+	if (!new)
+		return 0;
+
+	bpf_spin_lock(&value->lock);
+	bpf_list_push_back(&value->head, &new->node);
+	bpf_spin_unlock(&value->lock);
+	done = true;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/normal_map_btf.c b/tools/testing/selftests/bpf/progs/normal_map_btf.c
new file mode 100644
index 000000000000..66cde82aa86d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/normal_map_btf.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct node_data {
+	__u64 data;
+	struct bpf_list_node node;
+};
+
+struct map_value {
+	struct bpf_list_head head __contains(node_data, node);
+	struct bpf_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} array SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+bool done = false;
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int add_to_list_in_array(void *ctx)
+{
+	struct map_value *value;
+	struct node_data *new;
+	int zero = 0;
+
+	if (done || (u32)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	value = bpf_map_lookup_elem(&array, &zero);
+	if (!value)
+		return 0;
+
+	new = bpf_obj_new(typeof(*new));
+	if (!new)
+		return 0;
+
+	bpf_spin_lock(&value->lock);
+	bpf_list_push_back(&value->head, &new->node);
+	bpf_spin_unlock(&value->lock);
+	done = true;
+
+	return 0;
+}
-- 
2.29.2


