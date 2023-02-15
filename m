Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639FF69779E
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 08:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjBOHxS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 02:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjBOHxR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 02:53:17 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D7629E25
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 23:53:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PGr0k52gHz4f3l1j
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 15:53:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7Jjj+xjJrigDg--.18949S6;
        Wed, 15 Feb 2023 15:53:12 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        houtao1@huawei.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test case for element reuse in htab map
Date:   Wed, 15 Feb 2023 16:21:32 +0800
Message-Id: <20230215082132.3856544-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230215082132.3856544-1-houtao@huaweicloud.com>
References: <20230215082132.3856544-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7Jjj+xjJrigDg--.18949S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1fCw4xJFyDGw1UAFy7ZFb_yoWrGr4fpa
        yru34UKrWxXw1DWw15Ja1xKF4ft3WrZw45AFn3Ww1avr1jvr93Zr1xKFW7tF1S9rZ3Zryr
        Zayftw45Xr48Cw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

The reinitialization of spin-lock in map value after immediate reuse may
corrupt lookup with BPF_F_LOCK flag and result in hard lock-up, so add
one test case to demonstrate the problem.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/htab_reuse.c     | 101 ++++++++++++++++++
 .../testing/selftests/bpf/progs/htab_reuse.c  |  19 ++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_reuse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_reuse.c b/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
new file mode 100644
index 000000000000..a742dd994d60
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdbool.h>
+#include <test_progs.h>
+#include "htab_reuse.skel.h"
+
+struct htab_op_ctx {
+	int fd;
+	int loop;
+	bool stop;
+};
+
+struct htab_val {
+	unsigned int lock;
+	unsigned int data;
+};
+
+static void *htab_lookup_fn(void *arg)
+{
+	struct htab_op_ctx *ctx = arg;
+	int i = 0;
+
+	while (i++ < ctx->loop && !ctx->stop) {
+		struct htab_val value;
+		unsigned int key;
+
+		/* Use BPF_F_LOCK to use spin-lock in map value. */
+		key = 7;
+		bpf_map_lookup_elem_flags(ctx->fd, &key, &value, BPF_F_LOCK);
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
+		struct htab_val value;
+		unsigned int key;
+
+		key = 7;
+		value.lock = 0;
+		value.data = key;
+		bpf_map_update_elem(ctx->fd, &key, &value, BPF_F_LOCK);
+		bpf_map_delete_elem(ctx->fd, &key);
+
+		key = 24;
+		value.lock = 0;
+		value.data = key;
+		bpf_map_update_elem(ctx->fd, &key, &value, BPF_F_LOCK);
+		bpf_map_delete_elem(ctx->fd, &key);
+	}
+
+	return NULL;
+}
+
+void test_htab_reuse(void)
+{
+	unsigned int i, wr_nr = 1, rd_nr = 4;
+	pthread_t tids[wr_nr + rd_nr];
+	struct htab_reuse *skel;
+	struct htab_op_ctx ctx;
+	int err;
+
+	skel = htab_reuse__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "htab_reuse__open_and_load"))
+		return;
+
+	ctx.fd = bpf_map__fd(skel->maps.htab);
+	ctx.loop = 500;
+	ctx.stop = false;
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
+		if (!tids[i])
+			continue;
+		pthread_join(tids[i], NULL);
+	}
+	htab_reuse__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_reuse.c b/tools/testing/selftests/bpf/progs/htab_reuse.c
new file mode 100644
index 000000000000..7f7368cb3095
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_reuse.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct htab_val {
+	struct bpf_spin_lock lock;
+	unsigned int data;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, unsigned int);
+	__type(value, struct htab_val);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} htab SEC(".maps");
-- 
2.29.2

