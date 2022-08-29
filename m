Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA285A4ED6
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 16:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiH2OJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH2OJu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 10:09:50 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727641121
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 07:09:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGXMq0qHtzKGq2
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 22:08:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOmyAxjiPRgAA--.56898S7;
        Mon, 29 Aug 2022 22:09:46 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test concurrent updates on bpf_task_storage_busy
Date:   Mon, 29 Aug 2022 22:27:52 +0800
Message-Id: <20220829142752.330094-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220829142752.330094-1-houtao@huaweicloud.com>
References: <20220829142752.330094-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOmyAxjiPRgAA--.56898S7
X-Coremail-Antispam: 1UD129KBjvJXoWxArW8XrWfGrW3GFy5GFWUtwb_yoWrJF4kpa
        yxKr15tryrt3WFvrnxGwsrZrWYgw1kZw42kr95AryfArs7Cr93Kr4xtF1jqF1fG3yrZF15
        Zr1Fqa15Cr4UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

When there are concurrent task local storage lookup operations,
if updates on per-cpu bpf_task_storage_busy is not preemption-safe,
some updates will be lost due to interleave, the final value of
bpf_task_storage_busy will not be zero and bpf_task_storage_trylock()
on specific cpu will fail forever.

So add a test case to ensure the update of per-cpu bpf_task_storage_busy
is preemption-safe.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/prog_tests/task_local_storage.c       | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 035c263aab1b..ab8ee42a19e4 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -3,6 +3,7 @@
 
 #define _GNU_SOURCE         /* See feature_test_macros(7) */
 #include <unistd.h>
+#include <sched.h>
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
 #include <test_progs.h>
@@ -10,6 +11,14 @@
 #include "task_local_storage_exit_creds.skel.h"
 #include "task_ls_recursion.skel.h"
 
+struct lookup_ctx {
+	bool start;
+	bool stop;
+	int pid_fd;
+	int map_fd;
+	int loop;
+};
+
 static void test_sys_enter_exit(void)
 {
 	struct task_local_storage *skel;
@@ -81,6 +90,86 @@ static void test_recursion(void)
 	task_ls_recursion__destroy(skel);
 }
 
+static void *lookup_fn(void *arg)
+{
+	struct lookup_ctx *ctx = arg;
+	long value;
+	int i = 0;
+
+	while (!ctx->start)
+		usleep(1);
+
+	while (!ctx->stop && i++ < ctx->loop)
+		bpf_map_lookup_elem(ctx->map_fd, &ctx->pid_fd, &value);
+	return NULL;
+}
+
+static void test_preemption(void)
+{
+	struct task_local_storage *skel;
+	struct lookup_ctx ctx;
+	unsigned int i, nr;
+	cpu_set_t old, new;
+	pthread_t *tids;
+	int err;
+
+	skel = task_local_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	/* Save the old affinity setting */
+	sched_getaffinity(getpid(), sizeof(old), &old);
+
+	/* Pinned on CPU 0 */
+	CPU_ZERO(&new);
+	CPU_SET(0, &new);
+	sched_setaffinity(getpid(), sizeof(new), &new);
+
+	nr = 256;
+	tids = calloc(nr, sizeof(*tids));
+	if (!ASSERT_NEQ(tids, NULL, "no mem"))
+		goto out;
+
+	ctx.start = false;
+	ctx.stop = false;
+	ctx.pid_fd = sys_pidfd_open(getpid(), 0);
+	ctx.map_fd = bpf_map__fd(skel->maps.enter_id);
+	ctx.loop = 8192;
+	for (i = 0; i < nr; i++) {
+		err = pthread_create(&tids[i], NULL, lookup_fn, &ctx);
+		if (err) {
+			unsigned int j;
+
+			ASSERT_OK(err, "pthread_create");
+
+			ctx.stop = true;
+			ctx.start = true;
+			for (j = 0; j < i; j++)
+				pthread_join(tids[j], NULL);
+			goto out;
+		}
+	}
+
+	ctx.start = true;
+	for (i = 0; i < nr; i++)
+		pthread_join(tids[i], NULL);
+
+	err = task_local_storage__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	skel->bss->target_pid = syscall(SYS_gettid);
+	syscall(SYS_gettid);
+
+	/* If bpf_task_storage_trylock() fails, enter_cnt will be 0 */
+	ASSERT_EQ(skel->bss->enter_cnt, 1, "enter_cnt");
+out:
+	free(tids);
+	task_local_storage__destroy(skel);
+	/* Restore affinity setting */
+	sched_setaffinity(getpid(), sizeof(old), &old);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -89,4 +178,6 @@ void test_task_local_storage(void)
 		test_exit_creds();
 	if (test__start_subtest("recursion"))
 		test_recursion();
+	if (test__start_subtest("preemption"))
+		test_preemption();
 }
-- 
2.29.2

