Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0E679C18
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjAXOhp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjAXOho (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:37:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38282474FD
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 06:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B89D5B810D9
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 14:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7109EC4339B;
        Tue, 24 Jan 2023 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674571044;
        bh=wK1wxVCZrXpil9rS3IyRNYconFhEkt1Ap4s1NYhurtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZtkWFHVOD0UHcjD+GWYj7d5tr12S/d05B4QW1Q9Zf7Ng+NXAqvwtgQO6uv1MkF+T
         lAYlEZZFtumBfklCmeAu4xY+fDLag7oggJd4FjhSqtw/Lc2J5rCO9zJIsvsVuojVea
         rfe+Dq4w0NAmiCr4F4Hyajw3oH+B80sKqzLr62B2vif17STpeTWskARY3hYApOk/NL
         A1leLPqz10bOO36tkBvrxhZNPfZ2tVUYZqAQGYMWS/EpIHJyO6mgT/Afly7GTL1ewx
         b4WEIR2C/lzNeir2MxmbZlPZQXF63mrVxwxBhnJybwFJ/I8lNcb4JmCE37fB4ZTc/s
         tf+S4Rs5X1MPg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 5/5] bpf: Move kernel test kfuncs to bpf_testmod
Date:   Tue, 24 Jan 2023 15:36:26 +0100
Message-Id: <20230124143626.250719-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124143626.250719-1-jolsa@kernel.org>
References: <20230124143626.250719-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving kernel test kfuncs into bpf_testmod kernel module,
and adding necessary init calls and BTF IDs records.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 net/bpf/test_run.c                            | 253 +-----------------
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 191 ++++++++++++-
 2 files changed, 191 insertions(+), 253 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8da0d73b368e..6e203fcbc016 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -535,201 +535,6 @@ int noinline bpf_modify_return_test(int a, int *b)
 	return a + *b;
 }
 
-u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
-{
-	return a + b + c + d;
-}
-
-int noinline bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
-{
-	return a + b;
-}
-
-struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
-{
-	return sk;
-}
-
-struct prog_test_member1 {
-	int a;
-};
-
-struct prog_test_member {
-	struct prog_test_member1 m;
-	int c;
-};
-
-struct prog_test_ref_kfunc {
-	int a;
-	int b;
-	struct prog_test_member memb;
-	struct prog_test_ref_kfunc *next;
-	refcount_t cnt;
-};
-
-static struct prog_test_ref_kfunc prog_test_struct = {
-	.a = 42,
-	.b = 108,
-	.next = &prog_test_struct,
-	.cnt = REFCOUNT_INIT(1),
-};
-
-noinline struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
-{
-	refcount_inc(&prog_test_struct.cnt);
-	return &prog_test_struct;
-}
-
-noinline struct prog_test_member *
-bpf_kfunc_call_memb_acquire(void)
-{
-	WARN_ON_ONCE(1);
-	return NULL;
-}
-
-noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
-{
-	if (!p)
-		return;
-
-	refcount_dec(&p->cnt);
-}
-
-noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
-{
-}
-
-noinline void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
-{
-	WARN_ON_ONCE(1);
-}
-
-static int *__bpf_kfunc_call_test_get_mem(struct prog_test_ref_kfunc *p, const int size)
-{
-	if (size > 2 * sizeof(int))
-		return NULL;
-
-	return (int *)p;
-}
-
-noinline int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size)
-{
-	return __bpf_kfunc_call_test_get_mem(p, rdwr_buf_size);
-}
-
-noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
-{
-	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
-}
-
-/* the next 2 ones can't be really used for testing expect to ensure
- * that the verifier rejects the call.
- * Acquire functions must return struct pointers, so these ones are
- * failing.
- */
-noinline int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
-{
-	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
-}
-
-noinline void bpf_kfunc_call_int_mem_release(int *p)
-{
-}
-
-noinline struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
-{
-	struct prog_test_ref_kfunc *p = READ_ONCE(*pp);
-
-	if (!p)
-		return NULL;
-	refcount_inc(&p->cnt);
-	return p;
-}
-
-struct prog_test_pass1 {
-	int x0;
-	struct {
-		int x1;
-		struct {
-			int x2;
-			struct {
-				int x3;
-			};
-		};
-	};
-};
-
-struct prog_test_pass2 {
-	int len;
-	short arr1[4];
-	struct {
-		char arr2[4];
-		unsigned long arr3[8];
-	} x;
-};
-
-struct prog_test_fail1 {
-	void *p;
-	int x;
-};
-
-struct prog_test_fail2 {
-	int x8;
-	struct prog_test_pass1 x;
-};
-
-struct prog_test_fail3 {
-	int len;
-	char arr1[2];
-	char arr2[];
-};
-
-noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
-{
-}
-
-noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
-{
-}
-
-noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
-{
-}
-
-noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
-{
-}
-
-noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
-{
-}
-
-noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
-{
-}
-
-noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
-{
-}
-
-noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
-{
-}
-
-noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
-{
-}
-
-noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
-{
-}
-
-noinline void bpf_kfunc_call_test_destructive(void)
-{
-}
-
 __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
@@ -742,33 +547,6 @@ static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
 	.set   = &bpf_test_modify_return_ids,
 };
 
-BTF_SET8_START(test_sk_check_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_memb_acquire, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_memb1_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdwr_mem, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdonly_mem, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_acq_rdonly_mem, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_kptr_get, KF_ACQUIRE | KF_RET_NULL | KF_KPTR_GET)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
-BTF_SET8_END(test_sk_check_kfunc_ids)
-
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 			   u32 size, u32 headroom, u32 tailroom)
 {
@@ -1651,37 +1429,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 	return err;
 }
 
-static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set = {
-	.owner = THIS_MODULE,
-	.set   = &test_sk_check_kfunc_ids,
-};
-
-BTF_ID_LIST(bpf_prog_test_dtor_kfunc_ids)
-BTF_ID(struct, prog_test_ref_kfunc)
-BTF_ID(func, bpf_kfunc_call_test_release)
-BTF_ID(struct, prog_test_member)
-BTF_ID(func, bpf_kfunc_call_memb_release)
-
 static int __init bpf_prog_test_run_init(void)
 {
-	const struct btf_id_dtor_kfunc bpf_prog_test_dtor_kfunc[] = {
-		{
-		  .btf_id       = bpf_prog_test_dtor_kfunc_ids[0],
-		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[1]
-		},
-		{
-		  .btf_id	= bpf_prog_test_dtor_kfunc_ids[2],
-		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[3],
-		},
-	};
-	int ret;
-
-	ret = register_btf_fmodret_id_set(&bpf_test_modify_return_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_prog_test_kfunc_set);
-	return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
-						  ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
-						  THIS_MODULE);
+	return register_btf_fmodret_id_set(&bpf_test_modify_return_set);
 }
 late_initcall(bpf_prog_test_run_init);
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 5085fea3cac5..53c2615f4308 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -9,6 +9,8 @@
 #include <linux/sysfs.h>
 #include <linux/tracepoint.h>
 #include "bpf_testmod.h"
+#define __ksym
+#include "bpf_testmod_kfunc.h"
 
 #define CREATE_TRACE_POINTS
 #include "bpf_testmod-events.h"
@@ -220,7 +222,173 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 	.write = bpf_testmod_test_write,
 };
 
+noinline u64 bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
+{
+	return a + b + c + d;
+}
+
+noinline int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
+{
+	return a + b;
+}
+
+struct sock *noinline bpf_kfunc_call_test3(struct sock *sk)
+{
+	return sk;
+}
+
+static struct prog_test_ref_kfunc prog_test_struct = {
+	.a = 42,
+	.b = 108,
+	.next = &prog_test_struct,
+	.cnt = REFCOUNT_INIT(1),
+};
+
+noinline struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
+{
+	refcount_inc(&prog_test_struct.cnt);
+	return &prog_test_struct;
+}
+
+noinline struct prog_test_member *
+bpf_kfunc_call_memb_acquire(void)
+{
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
+{
+	if (!p)
+		return;
+
+	refcount_dec(&p->cnt);
+}
+
+noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
+{
+}
+
+noinline void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
+{
+	WARN_ON_ONCE(1);
+}
+
+static int *__bpf_kfunc_call_test_get_mem(struct prog_test_ref_kfunc *p, const int size)
+{
+	if (size > 2 * sizeof(int))
+		return NULL;
+
+	return (int *)p;
+}
+
+noinline int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size)
+{
+	return __bpf_kfunc_call_test_get_mem(p, rdwr_buf_size);
+}
+
+noinline int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
+{
+	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
+}
+
+/* the next 2 ones can't be really used for testing expect to ensure
+ * that the verifier rejects the call.
+ * Acquire functions must return struct pointers, so these ones are
+ * failing.
+ */
+noinline int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size)
+{
+	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
+}
+
+noinline void bpf_kfunc_call_int_mem_release(int *p)
+{
+}
+
+noinline struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
+{
+	struct prog_test_ref_kfunc *p = READ_ONCE(*pp);
+
+	if (!p)
+		return NULL;
+	refcount_inc(&p->cnt);
+	return p;
+}
+
+noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
+{
+}
+
+noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
+{
+}
+
+noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
+{
+}
+
+noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
+{
+}
+
+noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
+{
+}
+
+noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
+{
+}
+
+noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
+{
+}
+
+noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
+{
+}
+
+noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
+{
+}
+
+noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
+{
+}
+
+noinline void bpf_kfunc_call_test_destructive(void)
+{
+}
+
+__diag_pop();
+
 BTF_SET8_START(bpf_testmod_check_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_memb_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_memb1_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdwr_mem, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdonly_mem, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_acq_rdonly_mem, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_kptr_get, KF_ACQUIRE | KF_RET_NULL | KF_KPTR_GET)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
@@ -229,13 +397,34 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 	.set   = &bpf_testmod_check_kfunc_ids,
 };
 
+BTF_ID_LIST(bpf_prog_test_dtor_kfunc_ids)
+BTF_ID(struct, prog_test_ref_kfunc)
+BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(struct, prog_test_member)
+BTF_ID(func, bpf_kfunc_call_memb_release)
+
 extern int bpf_fentry_test1(int a);
 
-static int bpf_testmod_init(void)
+static int __init bpf_testmod_init(void)
 {
+	const struct btf_id_dtor_kfunc bpf_prog_test_dtor_kfunc[] = {
+		{
+		  .btf_id       = bpf_prog_test_dtor_kfunc_ids[0],
+		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[1]
+		},
+		{
+		  .btf_id	= bpf_prog_test_dtor_kfunc_ids[2],
+		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[3],
+		},
+	};
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
+						  ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
+						  THIS_MODULE);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
-- 
2.39.1

