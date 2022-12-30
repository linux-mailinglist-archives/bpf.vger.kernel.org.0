Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477C7659499
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 05:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiL3EMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 23:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiL3EMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 23:12:09 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522A186C5;
        Thu, 29 Dec 2022 20:12:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NjsKF6DnKz4f3nqS;
        Fri, 30 Dec 2022 12:12:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMPZa5j3H4SAw--.35465S10;
        Fri, 30 Dec 2022 12:12:04 +0800 (CST)
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
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC PATCH bpf-next 6/6] selftests/bpf: Add test case for element reuse in htab map
Date:   Fri, 30 Dec 2022 12:11:51 +0800
Message-Id: <20221230041151.1231169-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221230041151.1231169-1-houtao@huaweicloud.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMPZa5j3H4SAw--.35465S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1DKw45Kr43GF1rWr13XFb_yoWrAF4Upa
        yrC34UKrWxXwn8Ww15Jan7KF4ftw1rZay5AFn3Ww1avw1UZr9avr1xKFW7tF1fCrZ3Xryr
        Zayfta15Zr48Cw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

The immediate reuse of free htab elements can lead to two problems:
1) lookup may get unexpected map value if the found element is deleted
and then reused.
2) the reinitialization of spin-lock in map value after reuse may
corrupt lookup with BPF_F_LOCK flag and result in hard lock-up.

So add one test case to demonostrate these two problems.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/htab_reuse.c     | 111 ++++++++++++++++++
 .../testing/selftests/bpf/progs/htab_reuse.c  |  19 +++
 2 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_reuse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_reuse.c b/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
new file mode 100644
index 000000000000..995972958d1d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
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
+	int ret = 0, i = 0;
+
+        while (i++ < ctx->loop && !ctx->stop) {
+		struct htab_val value;
+		unsigned int key;
+		int err;
+
+		/*
+		 * Use BPF_F_LOCK to use spin-lock in map value. And also
+		 * check whether or not an unexpected value is returned.
+		 */
+		key = 7;
+                err = bpf_map_lookup_elem_flags(ctx->fd, &key, &value, BPF_F_LOCK);
+		if (!err && key != value.data)
+			ret = EINVAL;
+        }
+
+        return (void *)(long)ret;
+}
+
+static void *htab_update_fn(void *arg)
+{
+	struct htab_op_ctx *ctx = arg;
+	int i = 0;
+
+        while (i++ < ctx->loop && !ctx->stop) {
+		struct htab_val value;
+                unsigned int key;
+
+		key = 7;
+		value.lock = 0;
+		value.data = key;
+                bpf_map_update_elem(ctx->fd, &key, &value, BPF_F_LOCK);
+		bpf_map_delete_elem(ctx->fd, &key);
+
+		key = 24;
+		value.lock = 0;
+		value.data = key;
+                bpf_map_update_elem(ctx->fd, &key, &value, BPF_F_LOCK);
+		bpf_map_delete_elem(ctx->fd, &key);
+        }
+
+        return NULL;
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
+		void *thread_err;
+
+		if (!tids[i])
+			continue;
+		thread_err = NULL;
+		pthread_join(tids[i], &thread_err);
+		ASSERT_NULL(thread_err, "thread error");
+	}
+	htab_reuse__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_reuse.c b/tools/testing/selftests/bpf/progs/htab_reuse.c
new file mode 100644
index 000000000000..e6dcc70517f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_reuse.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
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

