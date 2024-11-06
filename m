Return-Path: <bpf+bounces-44109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182499BDECC
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 07:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC037286D39
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE61925B6;
	Wed,  6 Nov 2024 06:23:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896641922DF
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874226; cv=none; b=Qrthg2iw/h9F8VuGMiolyTCs8BKDRsEopVLK1Xz9kIDJsUn8oGnY009IcKG3JChtaRWrhuEyNQWLjDmV3azgtnoPGLMus5HhvgWyY6360ZW7/4wHy5yA2+opo/gwHXwTHyhf3ZExhUK1WUV3ad1KvF3IFk36dQKrA6Eaf8Rj0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874226; c=relaxed/simple;
	bh=r4nAQomFsKwvKnajzBv2RlNZ4BFb6ZbUV0zuKAIRFpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxmUCs+OVMjf/R8EGE9WWXm7nQtf+T/beZT4Yv7M9F4XNNJHR4CQFFr8e/LwlU8awsZ7X4295UCJM8BA+r2LLk9JvJiZH7xrXaqaUFgGdMVqbsRJR8KmISS1nZZXa6QiQzBeZtH26/AYuUWmzDe9Tt12yLCM7I2sBKBus274O9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XjwBC5839z4f3jXt
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 14:23:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AAB841A0197
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 14:23:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVhCytn_SX4Aw--.24568S7;
	Wed, 06 Nov 2024 14:23:33 +0800 (CST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test the update operations for htab of maps
Date: Wed,  6 Nov 2024 14:35:42 +0800
Message-Id: <20241106063542.357743-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241106063542.357743-1-houtao@huaweicloud.com>
References: <20241106063542.357743-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVhCytn_SX4Aw--.24568S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry8tw1rXF1kAr45tF4ruFg_yoWxAFW3pa
	yrKw45KrW0q342q3yYqay7KrWUJr4kXw1jyw1v934qvrn7JasrXF1xGFyUtFy3ArZ5Za1F
	vw13tFW8Ga9rCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add test cases to verify the following four update operations on htab of
maps don't trigger lockdep warning:

(1) add then delete
(2) add, overwrite, then delete
(3) add, then lookup_and_delete
(4) add two elements, then lookup_and_delete_batch

Test cases are added for pre-allocated and non-preallocated htab of maps
respectively.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/map_in_map.c     | 132 +++++++++++++++++-
 .../selftests/bpf/progs/update_map_in_htab.c  |  30 ++++
 2 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/update_map_in_htab.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_in_map.c b/tools/testing/selftests/bpf/prog_tests/map_in_map.c
index d2a10eb4e5b5..286a9fb469e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_in_map.c
@@ -5,7 +5,9 @@
 #include <sys/syscall.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
+
 #include "access_map_in_map.skel.h"
+#include "update_map_in_htab.skel.h"
 
 struct thread_ctx {
 	pthread_barrier_t barrier;
@@ -127,6 +129,131 @@ static void test_map_in_map_access(const char *prog_name, const char *map_name)
 	access_map_in_map__destroy(skel);
 }
 
+static void add_del_fd_htab(int outer_fd)
+{
+	int inner_fd, err;
+	int key = 1;
+
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr1", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(inner_fd, "inner1"))
+		return;
+	err = bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_NOEXIST);
+	close(inner_fd);
+	if (!ASSERT_OK(err, "add"))
+		return;
+
+	/* Delete */
+	err = bpf_map_delete_elem(outer_fd, &key);
+	ASSERT_OK(err, "del");
+}
+
+static void overwrite_fd_htab(int outer_fd)
+{
+	int inner_fd, err;
+	int key = 1;
+
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr1", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(inner_fd, "inner1"))
+		return;
+	err = bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_NOEXIST);
+	close(inner_fd);
+	if (!ASSERT_OK(err, "add"))
+		return;
+
+	/* Overwrite */
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr2", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(inner_fd, "inner2"))
+		goto out;
+	err = bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_EXIST);
+	close(inner_fd);
+	if (!ASSERT_OK(err, "overwrite"))
+		goto out;
+
+	err = bpf_map_delete_elem(outer_fd, &key);
+	ASSERT_OK(err, "del");
+	return;
+out:
+	bpf_map_delete_elem(outer_fd, &key);
+}
+
+static void lookup_delete_fd_htab(int outer_fd)
+{
+	int key = 1, value;
+	int inner_fd, err;
+
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr1", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(inner_fd, "inner1"))
+		return;
+	err = bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_NOEXIST);
+	close(inner_fd);
+	if (!ASSERT_OK(err, "add"))
+		return;
+
+	/* lookup_and_delete is not supported for htab of maps */
+	err = bpf_map_lookup_and_delete_elem(outer_fd, &key, &value);
+	ASSERT_EQ(err, -ENOTSUPP, "lookup_del");
+
+	err = bpf_map_delete_elem(outer_fd, &key);
+	ASSERT_OK(err, "del");
+}
+
+static void batched_lookup_delete_fd_htab(int outer_fd)
+{
+	int keys[2] = {1, 2}, values[2];
+	unsigned int cnt, batch;
+	int inner_fd, err;
+
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr1", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(inner_fd, "inner1"))
+		return;
+
+	err = bpf_map_update_elem(outer_fd, &keys[0], &inner_fd, BPF_NOEXIST);
+	close(inner_fd);
+	if (!ASSERT_OK(err, "add1"))
+		return;
+
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr2", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(inner_fd, "inner2"))
+		goto out;
+	err = bpf_map_update_elem(outer_fd, &keys[1], &inner_fd, BPF_NOEXIST);
+	close(inner_fd);
+	if (!ASSERT_OK(err, "add2"))
+		goto out;
+
+	/* batched lookup_and_delete */
+	cnt = ARRAY_SIZE(keys);
+	err = bpf_map_lookup_and_delete_batch(outer_fd, NULL, &batch, keys, values, &cnt, NULL);
+	ASSERT_TRUE((!err || err == -ENOENT), "delete_batch ret");
+	ASSERT_EQ(cnt, ARRAY_SIZE(keys), "delete_batch cnt");
+
+out:
+	bpf_map_delete_elem(outer_fd, &keys[0]);
+}
+
+static void test_update_map_in_htab(bool preallocate)
+{
+	struct update_map_in_htab *skel;
+	int err, fd;
+
+	skel = update_map_in_htab__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	err = update_map_in_htab__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto out;
+
+	fd = preallocate ? bpf_map__fd(skel->maps.outer_htab_map) :
+			   bpf_map__fd(skel->maps.outer_alloc_htab_map);
+
+	add_del_fd_htab(fd);
+	overwrite_fd_htab(fd);
+	lookup_delete_fd_htab(fd);
+	batched_lookup_delete_fd_htab(fd);
+out:
+	update_map_in_htab__destroy(skel);
+}
+
 void test_map_in_map(void)
 {
 	if (test__start_subtest("acc_map_in_array"))
@@ -137,5 +264,8 @@ void test_map_in_map(void)
 		test_map_in_map_access("access_map_in_htab", "outer_htab_map");
 	if (test__start_subtest("sleepable_acc_map_in_htab"))
 		test_map_in_map_access("sleepable_access_map_in_htab", "outer_htab_map");
+	if (test__start_subtest("update_map_in_htab"))
+		test_update_map_in_htab(true);
+	if (test__start_subtest("update_map_in_alloc_htab"))
+		test_update_map_in_htab(false);
 }
-
diff --git a/tools/testing/selftests/bpf/progs/update_map_in_htab.c b/tools/testing/selftests/bpf/progs/update_map_in_htab.c
new file mode 100644
index 000000000000..c2066247cd9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/update_map_in_htab.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2024. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct inner_map_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, 4);
+	__uint(value_size, 4);
+	__uint(max_entries, 1);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 2);
+	__array(values, struct inner_map_type);
+} outer_htab_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 2);
+	__array(values, struct inner_map_type);
+} outer_alloc_htab_map SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
-- 
2.29.2


