Return-Path: <bpf+bounces-58924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61AAC39A8
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 08:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E2E171A53
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB041D5ABA;
	Mon, 26 May 2025 06:08:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B01D63C6
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239719; cv=none; b=LevPj3WhzSF1FtinPby/8Xx9svoWH5hVNhDv3BARwoR1y4Ac4xkb3Z4QpTXYgXyuFEVyMVbRtQrmXi0r+fPge9w8uvEAuIe24r8nfFqM4xTC8z/W4MWZj7Ki9L4bX62gwf+Pmk2ShCzOu3kdnyjDGh3K76a4IboN8ymk2+bzimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239719; c=relaxed/simple;
	bh=Tj6SUxocI0aPDFNDXaKmhMXwzZpaZAi5lSqnKqPduE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nz8Ixen4w5hwQVtCQQSx09yvjbQjFdRnttDYrwDKLjuz8LAKDQzA2u+6nN1RbZN+n42x/UYuB2FAhx7mrWeW0uFb9Sk7jIMaZGLYOl+3QoczykFm4fKSaQtqznoH1xpJX1LBwx23L0ngxj/geIpPH5rx0uBWhCOBxIFSRsXJFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b5QLR20wczKHMTN
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:08:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BA5521A0359
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:08:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9aBTRoMQovNg--.11895S7;
	Mon, 26 May 2025 14:08:29 +0800 (CST)
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
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: Add test cases for the leaked special fields in map value
Date: Mon, 26 May 2025 14:25:55 +0800
Message-Id: <20250526062555.1106061-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250526062555.1106061-1-houtao@huaweicloud.com>
References: <20250526062555.1106061-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9aBTRoMQovNg--.11895S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr45ur48AFW7Zr47Zw13urg_yoW7tw4Upa
	yrGry5Gr4kWw17W3yxKw4UCr4SqwnYgay0yFZ09r1Yyr4Iqr9rtF1xKF1YyF1fJrs7Kr93
	Z34avFZ5ArWxuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbd-
	BtUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

All three cases follows the similar pattern:
1) create a new map element
2) get the value of the map element
3) delete the map element
4) try to initialize special fields in the map value
5) destroy the map

These three test cases use non-preallocated hash map, non-preallocated
per-cpu hash map and task local storage respectively.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../prog_tests/special_fields_in_map_value.c  |  34 ++++
 .../bpf/progs/special_fields_in_map_value.c   | 159 ++++++++++++++++++
 2 files changed, 193 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/special_fields_in_map_value.c
 create mode 100644 tools/testing/selftests/bpf/progs/special_fields_in_map_value.c

diff --git a/tools/testing/selftests/bpf/prog_tests/special_fields_in_map_value.c b/tools/testing/selftests/bpf/prog_tests/special_fields_in_map_value.c
new file mode 100644
index 000000000000..daff5fe83f5c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/special_fields_in_map_value.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <test_progs.h>
+
+#include "special_fields_in_map_value.skel.h"
+
+void test_special_fields_in_map_value(void)
+{
+	struct special_fields_in_map_value *skel;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	skel = special_fields_in_map_value__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open()"))
+		return;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_special_fields), &opts);
+	ASSERT_OK(err, "run");
+	ASSERT_EQ(opts.retval, 0, "retval");
+
+	LIBBPF_OPTS_RESET(opts);
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_percpu_special_fields),
+				     &opts);
+	ASSERT_OK(err, "percpu run");
+	ASSERT_EQ(opts.retval, 0, "percpu retval");
+
+	LIBBPF_OPTS_RESET(opts);
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_local_stor_special_fields),
+				     &opts);
+	ASSERT_OK(err, "local_stor run");
+	ASSERT_EQ(opts.retval, 0, "local_stor retval");
+
+	special_fields_in_map_value__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/special_fields_in_map_value.c b/tools/testing/selftests/bpf/progs/special_fields_in_map_value.c
new file mode 100644
index 000000000000..afe2f9fc27fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/special_fields_in_map_value.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct plain_value {
+	__u64 data[2];
+};
+
+struct plain_node {
+	__u64 data[8];
+	struct bpf_list_node node;
+};
+
+struct map_value {
+	struct plain_value __kptr * ptr;
+	struct bpf_timer timer;
+	struct bpf_spin_lock lock;
+	struct bpf_list_head head __contains(plain_node, node);
+};
+
+struct simple_map_value {
+	struct plain_value __kptr * ptr;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} map_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct simple_map_value);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} map_2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__type(key, int);
+	__type(value, struct simple_map_value);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} map_3 SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+int test_special_fields(void *ctx)
+{
+	struct plain_value *ptr, *old_ptr;
+	struct map_value ini = {};
+	struct plain_node *node;
+	struct map_value *v;
+	int key = 0, err;
+
+	err = bpf_map_update_elem(&map_1, &key, &ini, BPF_ANY);
+	if (err)
+		return 1;
+
+	v = bpf_map_lookup_elem(&map_1, &key);
+	if (!v)
+		return 2;
+
+	err = bpf_map_delete_elem(&map_1, &key);
+	if (err)
+		return 3;
+
+	ptr = bpf_obj_new(typeof(*ptr));
+	if (!ptr)
+		return 4;
+
+	old_ptr = bpf_kptr_xchg(&v->ptr, ptr);
+	if (old_ptr)
+		bpf_obj_drop(old_ptr);
+
+	err = bpf_timer_init(&v->timer, &map_1, 0);
+	if (err)
+		return 5;
+
+	node = bpf_obj_new(typeof(*node));
+	if (!node)
+		return 6;
+
+	bpf_spin_lock(&v->lock);
+	bpf_list_push_back(&v->head, &node->node);
+	bpf_spin_unlock(&v->lock);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_percpu_special_fields(void *ctx)
+{
+	struct plain_value *ptr, *old_ptr;
+	struct simple_map_value ini = {};
+	struct simple_map_value *v;
+	int key = 0, err;
+
+	err = bpf_map_update_elem(&map_2, &key, &ini, BPF_ANY);
+	if (err)
+		return 1;
+
+	v = bpf_map_lookup_elem(&map_2, &key);
+	if (!v)
+		return 2;
+
+	err = bpf_map_delete_elem(&map_2, &key);
+	if (err)
+		return 3;
+
+	ptr = bpf_obj_new(typeof(*ptr));
+	if (!ptr)
+		return 4;
+
+	old_ptr = bpf_kptr_xchg(&v->ptr, ptr);
+	if (old_ptr)
+		bpf_obj_drop(old_ptr);
+
+	return 0;
+}
+
+SEC("syscall")
+int test_local_stor_special_fields(void *ctx)
+{
+	struct plain_value *ptr, *old_ptr;
+	struct simple_map_value *v;
+	struct task_struct *cur;
+	int err;
+
+	cur = bpf_get_current_task_btf();
+	if (!cur)
+		return 1;
+
+	v = bpf_task_storage_get(&map_3, cur, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 2;
+
+	err = bpf_task_storage_delete(&map_3, cur);
+	if (err)
+		return 3;
+
+	ptr = bpf_obj_new(typeof(*ptr));
+	if (!ptr)
+		return 4;
+
+	old_ptr = bpf_kptr_xchg(&v->ptr, ptr);
+	if (old_ptr)
+		bpf_obj_drop(old_ptr);
+
+	return 0;
+}
-- 
2.29.2


