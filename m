Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7062C5A3666
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiH0Jnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiH0Jnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 05:43:31 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A7A97528
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 02:43:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MFBYW03Rcz6S9c9
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 17:41:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHsb085wljpJSmAw--.1436S6;
        Sat, 27 Aug 2022 17:43:27 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>
Cc:     Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: add test cases for htab update
Date:   Sat, 27 Aug 2022 18:01:34 +0800
Message-Id: <20220827100134.1621137-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220827100134.1621137-1-houtao@huaweicloud.com>
References: <20220827100134.1621137-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHsb085wljpJSmAw--.1436S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8Gr17Jry8Kr17Gr4xXrb_yoWrtw48pa
        48Ca4xtr4ftw1DXw1rta17KFWYkF4rXr4Yyrs5WF15Ar4j9rnaqr1xKFyrtF4fJrZ5Zr1r
        Z3sxtF4UW3yxZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

One test demonstrates the reentrancy of hash map update fails, and
another one shows concureently updates of the same hash map bucket
succeed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/htab_update.c    | 126 ++++++++++++++++++
 .../testing/selftests/bpf/progs/htab_update.c |  29 ++++
 2 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_update.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_update.c

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
new file mode 100644
index 000000000000..e2a4034daa79
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdbool.h>
+#include <test_progs.h>
+#include "htab_update.skel.h"
+
+struct htab_update_ctx {
+	int fd;
+	int loop;
+	bool stop;
+};
+
+static void test_reenter_update(void)
+{
+	struct htab_update *skel;
+	unsigned int key, value;
+	int err;
+
+	skel = htab_update__open();
+	if (!ASSERT_OK_PTR(skel, "htab_update__open"))
+		return;
+
+	/* lookup_elem_raw() may be inlined and find_kernel_btf_id() will return -ESRCH */
+	bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
+	err = htab_update__load(skel);
+	if (!ASSERT_TRUE(!err || err == -ESRCH, "htab_update__load") || err)
+		goto out;
+
+	skel->bss->pid = getpid();
+	err = htab_update__attach(skel);
+	if (!ASSERT_OK(err, "htab_update__attach"))
+		goto out;
+
+	/* Will trigger the reentrancy of bpf_map_update_elem() */
+	key = 0;
+	value = 0;
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, 0);
+	if (!ASSERT_OK(err, "add element"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
+out:
+	htab_update__destroy(skel);
+}
+
+static void *htab_update_thread(void *arg)
+{
+	struct htab_update_ctx *ctx = arg;
+	cpu_set_t cpus;
+	int i;
+
+	/* Pin on CPU 0 */
+	CPU_ZERO(&cpus);
+	CPU_SET(0, &cpus);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
+
+	i = 0;
+	while (i++ < ctx->loop && !ctx->stop) {
+		unsigned int key = 0, value = 0;
+		int err;
+
+		err = bpf_map_update_elem(ctx->fd, &key, &value, 0);
+		if (err) {
+			ctx->stop = true;
+			return (void *)(long)err;
+		}
+	}
+
+	return NULL;
+}
+
+static void test_concurrent_update(void)
+{
+	struct htab_update_ctx ctx;
+	struct htab_update *skel;
+	unsigned int i, nr;
+	pthread_t *tids;
+	int err;
+
+	skel = htab_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "htab_update__open_and_load"))
+		return;
+
+	ctx.fd = bpf_map__fd(skel->maps.htab);
+	ctx.loop = 1000;
+	ctx.stop = false;
+
+	nr = 4;
+	tids = calloc(nr, sizeof(*tids));
+	if (!ASSERT_NEQ(tids, NULL, "no mem"))
+		goto out;
+
+	for (i = 0; i < nr; i++) {
+		err = pthread_create(&tids[i], NULL, htab_update_thread, &ctx);
+		if (!ASSERT_OK(err, "pthread_create")) {
+			unsigned int j;
+
+			ctx.stop = true;
+			for (j = 0; j < i; j++)
+				pthread_join(tids[j], NULL);
+			goto out;
+		}
+	}
+
+	for (i = 0; i < nr; i++) {
+		void *thread_err = NULL;
+
+		pthread_join(tids[i], &thread_err);
+		ASSERT_EQ(thread_err, NULL, "update error");
+	}
+
+out:
+	if (tids)
+		free(tids);
+	htab_update__destroy(skel);
+}
+
+void test_htab_update(void)
+{
+	if (test__start_subtest("reenter_update"))
+		test_reenter_update();
+	if (test__start_subtest("concurrent_update"))
+		test_concurrent_update();
+}
diff --git a/tools/testing/selftests/bpf/progs/htab_update.c b/tools/testing/selftests/bpf/progs/htab_update.c
new file mode 100644
index 000000000000..7481bb30b29b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/htab_update.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} htab SEC(".maps");
+
+int pid = 0;
+int update_err = 0;
+
+SEC("?fentry/lookup_elem_raw")
+int lookup_elem_raw(void *ctx)
+{
+	__u32 key = 0, value = 1;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+
+	update_err = bpf_map_update_elem(&htab, &key, &value, 0);
+	return 0;
+}
-- 
2.29.2

