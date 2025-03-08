Return-Path: <bpf+bounces-53651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8BA57A92
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 14:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C5F18957EB
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE2C1D4356;
	Sat,  8 Mar 2025 13:39:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A431CEAC8
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441160; cv=none; b=lQaYuqybNPhrpll++YYZnJMNEGbcv8MEjpW2P0eNsnn/HNt/lWalt4+h4xtd3RQRxDcElnSEdxmsIWDIAhsj7cGulh0yNYQFc9aTnQ7jBGFCXx/qLAIFUEYAmvtsXyPOe8Jeadfje0yjBK91gazIeSIUZes3vfIKcDC8vwemERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441160; c=relaxed/simple;
	bh=l5UYfsEA3zI4DlBCMA8prNw6DLYPp4X/SjSDeOb/mdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0CpYxpOwPfu0ilmNMmIhL5TxYibrzPAj8oD8uRg9PlY/RDBgqzetfdl4SXBorPs+OsMJLIdGjXSCAZhgZ9bTjk7ulrvTmXYbVHxQMlnrRT14NWpDG9ps6vW31jbmdCM8D2dGrxw5CVtSkkPrX64ezzaXHec9hVNNeVC6fL7EoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z944X4CKrz4f3jtq
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:38:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 776F31A07C0
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:39:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl91SMxn+YeeFw--.42876S10;
	Sat, 08 Mar 2025 21:39:09 +0800 (CST)
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Zvi Effron <zeffron@riotgames.com>,
	Cody Haas <chaas@riotgames.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Add test case for atomic update of fd htab
Date: Sat,  8 Mar 2025 21:51:10 +0800
Message-Id: <20250308135110.953269-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250308135110.953269-1-houtao@huaweicloud.com>
References: <20250308135110.953269-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl91SMxn+YeeFw--.42876S10
X-Coremail-Antispam: 1UD129KBjvJXoWxKry7WF4xKr4fArW5CrW5Awb_yoWxZw1xpa
	yrGayUtFW8XrW7Xw1rtan7KFW5KFsYqr47Ar95Wry5AF18X3WSqF4xKFW5tFyfurZYqF4F
	vw43tFW5u3y7XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add a test case to verify the atomic update of existing elements in the
htab of maps. The test proceeds in three steps:

1) fill the outer map with keys in the range [0, 8]
For each inner array map, the value of its first element is set as the
key used to lookup the inner map.

2) create 16 threads to lookup these keys concurrently
Each lookup thread first lookups the inner map, then it checks whether
the first value of the inner array map is the same as the key used to
lookup the inner map.

3) create 8 threads to overwrite these keys concurrently
Each update thread first creates an inner array, it sets the first value
of the array to the key used to update the outer map, then it uses the
key and the inner map to update the outer map.

Without atomic update support, the lookup operation may return -ENOENT
during the lookup of outer map, or return -EINVAL during the comparison
of the first value in the inner map and the key used for inner map, and
the test will fail. After the atomic update change, both the lookup and
the comparison will succeed.

Given that the update of outer map is slow, the test case sets the loop
number for each thread as 5 to reduce the total running time. However,
the loop number could also be adjusted through FD_HTAB_LOOP_NR
environment variable.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/fd_htab_lookup.c | 192 ++++++++++++++++++
 .../selftests/bpf/progs/fd_htab_lookup.c      |  25 +++
 2 files changed, 217 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/fd_htab_lookup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c b/tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c
new file mode 100644
index 0000000000000..ca46fdd6e1ae7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fd_htab_lookup.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <test_progs.h>
+#include "fd_htab_lookup.skel.h"
+
+struct htab_op_ctx {
+	int fd;
+	int loop;
+	unsigned int entries;
+	bool stop;
+};
+
+#define ERR_TO_RETVAL(where, err) ((void *)(long)(((where) << 12) | (-err)))
+
+static void *htab_lookup_fn(void *arg)
+{
+	struct htab_op_ctx *ctx = arg;
+	int i = 0;
+
+	while (i++ < ctx->loop && !ctx->stop) {
+		unsigned int j;
+
+		for (j = 0; j < ctx->entries; j++) {
+			unsigned int key = j, zero = 0, value;
+			int inner_fd, err;
+
+			err = bpf_map_lookup_elem(ctx->fd, &key, &value);
+			if (err) {
+				ctx->stop = true;
+				return ERR_TO_RETVAL(1, err);
+			}
+
+			inner_fd = bpf_map_get_fd_by_id(value);
+			if (inner_fd < 0) {
+				/* The old map has been freed */
+				if (inner_fd == -ENOENT)
+					continue;
+				ctx->stop = true;
+				return ERR_TO_RETVAL(2, inner_fd);
+			}
+
+			err = bpf_map_lookup_elem(inner_fd, &zero, &value);
+			if (err) {
+				close(inner_fd);
+				ctx->stop = true;
+				return ERR_TO_RETVAL(3, err);
+			}
+			close(inner_fd);
+
+			if (value != key) {
+				ctx->stop = true;
+				return ERR_TO_RETVAL(4, -EINVAL);
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static void *htab_update_fn(void *arg)
+{
+	struct htab_op_ctx *ctx = arg;
+	int i = 0;
+
+	while (i++ < ctx->loop && !ctx->stop) {
+		unsigned int j;
+
+		for (j = 0; j < ctx->entries; j++) {
+			unsigned int key = j, zero = 0;
+			int inner_fd, err;
+
+			inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 4, 1, NULL);
+			if (inner_fd < 0) {
+				ctx->stop = true;
+				return ERR_TO_RETVAL(1, inner_fd);
+			}
+
+			err = bpf_map_update_elem(inner_fd, &zero, &key, 0);
+			if (err) {
+				close(inner_fd);
+				ctx->stop = true;
+				return ERR_TO_RETVAL(2, err);
+			}
+
+			err = bpf_map_update_elem(ctx->fd, &key, &inner_fd, BPF_EXIST);
+			if (err) {
+				close(inner_fd);
+				ctx->stop = true;
+				return ERR_TO_RETVAL(3, err);
+			}
+			close(inner_fd);
+		}
+	}
+
+	return NULL;
+}
+
+static int setup_htab(int fd, unsigned int entries)
+{
+	unsigned int i;
+
+	for (i = 0; i < entries; i++) {
+		unsigned int key = i, zero = 0;
+		int inner_fd, err;
+
+		inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 4, 1, NULL);
+		if (!ASSERT_OK_FD(inner_fd, "new array"))
+			return -1;
+
+		err = bpf_map_update_elem(inner_fd, &zero, &key, 0);
+		if (!ASSERT_OK(err, "init array")) {
+			close(inner_fd);
+			return -1;
+		}
+
+		err = bpf_map_update_elem(fd, &key, &inner_fd, 0);
+		if (!ASSERT_OK(err, "init outer")) {
+			close(inner_fd);
+			return -1;
+		}
+		close(inner_fd);
+	}
+
+	return 0;
+}
+
+static int get_int_from_env(const char *name, int dft)
+{
+	const char *value;
+
+	value = getenv(name);
+	if (!value)
+		return dft;
+
+	return atoi(value);
+}
+
+void test_fd_htab_lookup(void)
+{
+	unsigned int i, wr_nr = 8, rd_nr = 16;
+	pthread_t tids[wr_nr + rd_nr];
+	struct fd_htab_lookup *skel;
+	struct htab_op_ctx ctx;
+	int err;
+
+	skel = fd_htab_lookup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fd_htab_lookup__open_and_load"))
+		return;
+
+	ctx.fd = bpf_map__fd(skel->maps.outer_map);
+	ctx.loop = get_int_from_env("FD_HTAB_LOOP_NR", 5);
+	ctx.stop = false;
+	ctx.entries = 8;
+
+	err = setup_htab(ctx.fd, ctx.entries);
+	if (err)
+		goto destroy;
+
+	memset(tids, 0, sizeof(tids));
+	for (i = 0; i < wr_nr; i++) {
+		err = pthread_create(&tids[i], NULL, htab_update_fn, &ctx);
+		if (!ASSERT_OK(err, "pthread_create")) {
+			ctx.stop = true;
+			goto reap;
+		}
+	}
+	for (i = 0; i < rd_nr; i++) {
+		err = pthread_create(&tids[i + wr_nr], NULL, htab_lookup_fn, &ctx);
+		if (!ASSERT_OK(err, "pthread_create")) {
+			ctx.stop = true;
+			goto reap;
+		}
+	}
+
+reap:
+	for (i = 0; i < wr_nr + rd_nr; i++) {
+		void *ret = NULL;
+		char desc[32];
+
+		if (!tids[i])
+			continue;
+
+		snprintf(desc, sizeof(desc), "thread %u", i + 1);
+		err = pthread_join(tids[i], &ret);
+		ASSERT_OK(err, desc);
+		ASSERT_EQ(ret, NULL, desc);
+	}
+destroy:
+	fd_htab_lookup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fd_htab_lookup.c b/tools/testing/selftests/bpf/progs/fd_htab_lookup.c
new file mode 100644
index 0000000000000..a4a9e1db626fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fd_htab_lookup.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
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
+	__uint(max_entries, 64);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct inner_map_type);
+} outer_map SEC(".maps") = {
+	.values = {
+		[0] = &inner_map,
+	},
+};
-- 
2.29.2


