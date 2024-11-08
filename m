Return-Path: <bpf+bounces-44336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E349C179B
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 09:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CF11F23E93
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5471DC1A2;
	Fri,  8 Nov 2024 08:15:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05488F54;
	Fri,  8 Nov 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053738; cv=none; b=R5qbXu0GtdRkGIZPhcGVyp+35YhFy/4GDxcoX053ISL88g3o6vpUZBQ+0SuCK+Tpycc+2bhj8jnoTjceKStjlX6V1JCSnhy7hnBMHuCQA/oiWmQ6C4ZQWt0N+Q4c1LjrtzM6iapGhvg9l+6WrUyg4GtoFiGxc7y1miMQIlO+ApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053738; c=relaxed/simple;
	bh=LDlI3iimsTy02GWYv8p1CRB7rP1mGSFj2bc5iei8LGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neQw1qUxOiQ6nXTTkVdGcraytVjdU/4nIzeFxiikEUhnkoHWL9Jj2/nAnYGV/l8QHLLt8RXsssNzX1kXInIYXaaJBGFFQw8S9PDpHgnMsta944BL5sNp6aaeBiirUbvh3ByD8Od6B9mxjJkQFlvWALp9I+YbALJwOyh9fDjrmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XlBZV4T7Cz4f3l8N;
	Fri,  8 Nov 2024 16:15:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9056A1A0568;
	Fri,  8 Nov 2024 16:15:27 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgAXDK6eyC1nOEOhBA--.5950S4;
	Fri, 08 Nov 2024 16:15:27 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for struct_ops map release
Date: Fri,  8 Nov 2024 16:26:33 +0800
Message-Id: <20241108082633.2338543-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108082633.2338543-1-xukuohai@huaweicloud.com>
References: <20241108082633.2338543-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXDK6eyC1nOEOhBA--.5950S4
X-Coremail-Antispam: 1UD129KBjvJXoW3uw1fZr1kJr4DWrykZr1fZwb_yoWDtw13pa
	4xAr1jkF4kJFs8WF18JF4UZF4SkrsaqF4UJFWUG3s0vry0qwn8JF18KFyjyrn5GrZ5Zr17
	Aa9agrZ8uay7JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU047K7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add a test to ensure that struct_ops map is released safely. Without
the previous fix, this test triggers kernel panic due to UAF.

The test runs multiple threads concurrently. Some threads create and
destroy struct_ops maps, while others execute progs within the maps.
Each map has two progs, one sleepable, and the other unsleepable.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  78 ++++++---
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   2 +-
 .../bpf/prog_tests/test_struct_ops_module.c   | 154 ++++++++++++++++++
 .../bpf/progs/struct_ops_map_release.c        |  30 ++++
 4 files changed, 242 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_map_release.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 987d41af71d2..72d21e8ba5d4 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1016,6 +1016,11 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 	return args->a;
 }
 
+__bpf_kfunc void bpf_kfunc_msleep(u32 msecs)
+{
+	msleep(msecs);
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -1056,6 +1061,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABL
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_msleep, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1096,6 +1102,29 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
+static int bpf_testmod_test_1(void)
+{
+	return 0;
+}
+
+static void bpf_testmod_test_2(int a, int b)
+{
+}
+
+static int bpf_testmod_ops__test_maybe_null(int dummy,
+					    struct task_struct *task__nullable)
+{
+	return 0;
+}
+
+static struct bpf_testmod_ops __bpf_testmod_ops = {
+	.test_1 = bpf_testmod_test_1,
+	.test_2 = bpf_testmod_test_2,
+	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
+};
+
+static struct bpf_testmod_ops *__bpf_dummy_ops = &__bpf_testmod_ops;
+
 static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops *ops = kdata;
@@ -1108,20 +1137,14 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 	if (ops->test_2)
 		ops->test_2(4, ops->data);
 
-	return 0;
-}
-
-static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
-{
-}
+	WRITE_ONCE(__bpf_dummy_ops, ops);
 
-static int bpf_testmod_test_1(void)
-{
 	return 0;
 }
 
-static void bpf_testmod_test_2(int a, int b)
+static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
+	WRITE_ONCE(__bpf_dummy_ops, &__bpf_testmod_ops);
 }
 
 static int bpf_testmod_tramp(int value)
@@ -1129,18 +1152,6 @@ static int bpf_testmod_tramp(int value)
 	return 0;
 }
 
-static int bpf_testmod_ops__test_maybe_null(int dummy,
-					    struct task_struct *task__nullable)
-{
-	return 0;
-}
-
-static struct bpf_testmod_ops __bpf_testmod_ops = {
-	.test_1 = bpf_testmod_test_1,
-	.test_2 = bpf_testmod_test_2,
-	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
-};
-
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.verifier_ops = &bpf_testmod_verifier_ops,
 	.init = bpf_testmod_ops_init,
@@ -1375,6 +1386,31 @@ static void bpf_testmod_exit(void)
 	unregister_bpf_testmod_uprobe();
 }
 
+static int run_struct_ops(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	unsigned int repeat;
+	struct bpf_testmod_ops *ops;
+
+	ret = kstrtouint(val, 10, &repeat);
+	if (ret)
+		return ret;
+
+	if (repeat > 10000)
+		return -ERANGE;
+
+	while (repeat-- > 0) {
+		ops = READ_ONCE(__bpf_dummy_ops);
+		if (ops->test_1)
+			ops->test_1();
+		if (ops->test_2)
+			ops->test_2(0, 0);
+	}
+
+	return 0;
+}
+
+module_param_call(run_struct_ops, run_struct_ops, NULL, NULL, 0200);
 module_init(bpf_testmod_init);
 module_exit(bpf_testmod_exit);
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index b58817938deb..260faebd5633 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -158,5 +158,5 @@ void bpf_kfunc_trusted_vma_test(struct vm_area_struct *ptr) __ksym;
 void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
 void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
 void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
-
+void bpf_kfunc_msleep(__u32 msecs) __ksym;
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 75a0dea511b3..df744d51cade 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -9,6 +9,7 @@
 #include "struct_ops_nulled_out_cb.skel.h"
 #include "struct_ops_forgotten_cb.skel.h"
 #include "struct_ops_detach.skel.h"
+#include "struct_ops_map_release.skel.h"
 #include "unsupported_ops.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
@@ -246,6 +247,157 @@ static void test_struct_ops_forgotten_cb(void)
 	struct_ops_forgotten_cb__destroy(skel);
 }
 
+struct test_context {
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+	int total_threads;
+	int wait_threads;
+	int dead_threads;
+	int repeat;
+	int loop;
+};
+
+static int wait_others(struct test_context *ctx)
+{
+	int ret = 0;
+
+	pthread_mutex_lock(&ctx->mutex);
+
+	if (ctx->dead_threads) {
+		pthread_cond_broadcast(&ctx->cond);
+		pthread_mutex_unlock(&ctx->mutex);
+		return -1;
+	}
+
+	++ctx->wait_threads;
+	if (ctx->wait_threads >= ctx->total_threads) {
+		pthread_cond_broadcast(&ctx->cond);
+		ctx->wait_threads = 0;
+	} else {
+		pthread_cond_wait(&ctx->cond, &ctx->mutex);
+		if (ctx->dead_threads)
+			ret = -1;
+	}
+
+	pthread_mutex_unlock(&ctx->mutex);
+
+	return ret;
+}
+
+static void mark_dead(struct test_context *ctx)
+{
+	pthread_mutex_lock(&ctx->mutex);
+	ctx->dead_threads++;
+	pthread_cond_broadcast(&ctx->cond);
+	pthread_mutex_unlock(&ctx->mutex);
+}
+
+static int load_release(struct test_context *ctx)
+{
+	int ret = 0;
+	struct bpf_link *link = NULL;
+	struct struct_ops_map_release *skel = NULL;
+
+	skel = struct_ops_map_release__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load")) {
+		ret = -1;
+		mark_dead(ctx);
+		goto out;
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_ops);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops")) {
+		ret = -1;
+		mark_dead(ctx);
+		goto out;
+	}
+
+	if (wait_others(ctx)) {
+		ret = -1;
+		goto out;
+	}
+
+out:
+	bpf_link__destroy(link);
+	struct_ops_map_release__destroy(skel);
+	return ret;
+}
+
+static void *thread_load_release(void *arg)
+{
+	struct test_context *ctx = (struct test_context *)arg;
+
+	for (int i = 0; i < ctx->loop; i++)
+		if (load_release(ctx))
+			break;
+	return NULL;
+}
+
+static void *thread_run_prog(void *arg)
+{
+	int fd;
+	int len;
+	char buf[8];
+	struct test_context *ctx = (struct test_context *)arg;
+
+	fd = open("/sys/module/bpf_testmod/parameters/run_struct_ops", O_WRONLY);
+	if (!ASSERT_OK_FD(fd, "open run_struct_ops for write")) {
+		mark_dead(ctx);
+		return NULL;
+	}
+
+	len = snprintf(buf, sizeof(buf), "%d", ctx->repeat);
+	if (!ASSERT_GT(len, 0, "snprintf repeat number")) {
+		mark_dead(ctx);
+		goto out;
+	}
+
+	for (int i = 0; i < ctx->loop; i++) {
+		if (wait_others(ctx))
+			goto out;
+		if (!ASSERT_EQ(write(fd, buf, len), len, "write file")) {
+			mark_dead(ctx);
+			goto out;
+		}
+	}
+
+out:
+	close(fd);
+	return NULL;
+}
+
+#define NR_REL_THREAD	2
+#define NR_RUN_THREAD	8
+#define NR_THREAD	(NR_REL_THREAD + NR_RUN_THREAD)
+#define NR_REPEAT	4
+#define NR_LOOP		5
+
+static void test_struct_ops_map_release(void)
+{
+	int i, j;
+	pthread_t t[NR_THREAD];
+	struct test_context ctx = {
+		.loop = NR_LOOP,
+		.repeat = NR_REPEAT,
+		.total_threads = NR_THREAD,
+		.wait_threads = 0,
+		.dead_threads = 0,
+	};
+
+	pthread_mutex_init(&ctx.mutex, NULL);
+	pthread_cond_init(&ctx.cond, NULL);
+
+	j = 0;
+	for (i = 0; i < NR_REL_THREAD; i++)
+		pthread_create(&t[j++], NULL, thread_load_release, &ctx);
+
+	for (i = 0; i < NR_RUN_THREAD; i++)
+		pthread_create(&t[j++], NULL, thread_run_prog, &ctx);
+
+	for (i = 0; i < NR_THREAD; i++)
+		pthread_join(t[i], NULL);
+}
+
 /* Detach a link from a user space program */
 static void test_detach_link(void)
 {
@@ -310,6 +462,8 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_nulled_out_cb();
 	if (test__start_subtest("struct_ops_forgotten_cb"))
 		test_struct_ops_forgotten_cb();
+	if (test__start_subtest("struct_ops_map_release"))
+		test_struct_ops_map_release();
 	if (test__start_subtest("test_detach_link"))
 		test_detach_link();
 	RUN_TESTS(unsupported_ops);
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_map_release.c b/tools/testing/selftests/bpf/progs/struct_ops_map_release.c
new file mode 100644
index 000000000000..78aa5e1875b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_map_release.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2024 Huawei Technologies Co., Ltd */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops.s/test_1")
+int BPF_PROG(test_1_prog)
+{
+	bpf_kfunc_msleep(100);
+	return 0;
+}
+
+SEC("struct_ops/test_2")
+int BPF_PROG(test_2_prog, int a, int b)
+{
+	return 0;
+}
+
+SEC(".struct_ops")
+struct bpf_testmod_ops testmod_ops = {
+	.test_1 = (void *)test_1_prog,
+	.test_2 = (void *)test_2_prog
+};
-- 
2.39.5


