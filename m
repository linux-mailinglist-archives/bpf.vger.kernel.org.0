Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853B689F23
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBCQZb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBCQZ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:25:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F6A6B87
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:25:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A23E61F6A
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 16:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F6DC433D2;
        Fri,  3 Feb 2023 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675441519;
        bh=2e3ySll+WienhVNIzM3Go29U/Mgk6xJqA4crBFmUKwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMeGLjmQ+om5s/Wy6fmrMtXl10fbG7AjnpKYUwtXjmWEa25Cj/KkrsAaXfJLf1DIQ
         hGIg+b1w9+nOqyALk6ProfTs8Woyg3QEAhQqNzs5T083X9mFVSRpTSqwxrrEK4x5Gb
         0gBOhdUNcSlXni4KG8H4ULSNsfTlTg2D019XL96ViVcSJvBPxN1Y36TxKSVwB65U0v
         TMzwWyRT251h6cP9HE1xHYpqUsmuaMmRhNdRMgiNTMsURuNvrR31wE/v8osVHwdefE
         Ba9u0IEGfuX6FX4f7YNWM4toXY9A5T28xj+CUsZybr17EL/ipadRe8yX5hIFDiq23k
         gTXOCR95cfiUA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCHv3 bpf-next 9/9] bpf: Move kernel test kfuncs to bpf_testmod
Date:   Fri,  3 Feb 2023 17:23:36 +0100
Message-Id: <20230203162336.608323-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203162336.608323-1-jolsa@kernel.org>
References: <20230203162336.608323-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving kernel test kfuncs into bpf_testmod kernel module,
and adding necessary init calls and BTF IDs records.

As suggested by David adding bpf_testmod.ko make dependency for
bpf programs, so they are rebuilt if we change the bpf_testmod.ko
module.

Also adding missing __bpf_kfunc to bpf_kfunc_call_test4 functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 net/bpf/test_run.c                            | 271 +-----------------
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 206 ++++++++++++-
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  61 ++++
 4 files changed, 268 insertions(+), 271 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index e6f773d12045..88fead83d8d3 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -535,217 +535,6 @@ __bpf_kfunc int bpf_modify_return_test(int a, int *b)
 	return a + *b;
 }
 
-__bpf_kfunc u64 bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
-{
-	return a + b + c + d;
-}
-
-__bpf_kfunc int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
-{
-	return a + b;
-}
-
-__bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk)
-{
-	return sk;
-}
-
-long noinline bpf_kfunc_call_test4(signed char a, short b, int c, long d)
-{
-	/* Provoke the compiler to assume that the caller has sign-extended a,
-	 * b and c on platforms where this is required (e.g. s390x).
-	 */
-	return (long)a + (long)b + (long)c + d;
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
-__bpf_kfunc struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
-{
-	refcount_inc(&prog_test_struct.cnt);
-	return &prog_test_struct;
-}
-
-__bpf_kfunc struct prog_test_member *
-bpf_kfunc_call_memb_acquire(void)
-{
-	WARN_ON_ONCE(1);
-	return NULL;
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
-{
-	if (!p)
-		return;
-
-	refcount_dec(&p->cnt);
-}
-
-__bpf_kfunc void bpf_kfunc_call_memb_release(struct prog_test_member *p)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
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
-__bpf_kfunc int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p,
-						  const int rdwr_buf_size)
-{
-	return __bpf_kfunc_call_test_get_mem(p, rdwr_buf_size);
-}
-
-__bpf_kfunc int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p,
-						    const int rdonly_buf_size)
-{
-	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
-}
-
-/* the next 2 ones can't be really used for testing expect to ensure
- * that the verifier rejects the call.
- * Acquire functions must return struct pointers, so these ones are
- * failing.
- */
-__bpf_kfunc int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p,
-						    const int rdonly_buf_size)
-{
-	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
-}
-
-__bpf_kfunc void bpf_kfunc_call_int_mem_release(int *p)
-{
-}
-
-__bpf_kfunc struct prog_test_ref_kfunc *
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
-__bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
-{
-}
-
-__bpf_kfunc void bpf_kfunc_call_test_destructive(void)
-{
-}
-
-__bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused)
-{
-	return arg;
-}
-
 __diag_pop();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
@@ -758,35 +547,6 @@ static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
 	.set   = &bpf_test_modify_return_ids,
 };
 
-BTF_SET8_START(test_sk_check_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
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
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
-BTF_SET8_END(test_sk_check_kfunc_ids)
-
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 			   u32 size, u32 headroom, u32 tailroom)
 {
@@ -1669,37 +1429,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
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
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b2eb3201b85a..7008e49015e0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -441,6 +441,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
 		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
 		     $$(INCLUDE_DIR)/vmlinux.h				\
+		     $(OUTPUT)/bpf_testmod.ko				\
 		     $(wildcard $(BPFDIR)/bpf_*.h)			\
 		     $(wildcard $(BPFDIR)/*.bpf.h)			\
 		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 46500636d8cd..437e449d7c5c 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -9,6 +9,7 @@
 #include <linux/sysfs.h>
 #include <linux/tracepoint.h>
 #include "bpf_testmod.h"
+#include "bpf_testmod_kfunc.h"
 
 #define CREATE_TRACE_POINTS
 #include "bpf_testmod-events.h"
@@ -220,7 +221,189 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 	.write = bpf_testmod_test_write,
 };
 
+__bpf_kfunc u64 bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
+{
+	return a + b + c + d;
+}
+
+__bpf_kfunc int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
+{
+	return a + b;
+}
+
+__bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk)
+{
+	return sk;
+}
+
+__bpf_kfunc long bpf_kfunc_call_test4(signed char a, short b, int c, long d)
+{
+	/* Provoke the compiler to assume that the caller has sign-extended a,
+	 * b and c on platforms where this is required (e.g. s390x).
+	 */
+	return (long)a + (long)b + (long)c + d;
+}
+
+static struct prog_test_ref_kfunc prog_test_struct = {
+	.a = 42,
+	.b = 108,
+	.next = &prog_test_struct,
+	.cnt = REFCOUNT_INIT(1),
+};
+
+__bpf_kfunc struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
+{
+	refcount_inc(&prog_test_struct.cnt);
+	return &prog_test_struct;
+}
+
+__bpf_kfunc struct prog_test_member *
+bpf_kfunc_call_memb_acquire(void)
+{
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
+{
+	if (!p)
+		return;
+
+	refcount_dec(&p->cnt);
+}
+
+__bpf_kfunc void bpf_kfunc_call_memb_release(struct prog_test_member *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_memb1_release(struct prog_test_member1 *p)
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
+__bpf_kfunc int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p,
+						  const int rdwr_buf_size)
+{
+	return __bpf_kfunc_call_test_get_mem(p, rdwr_buf_size);
+}
+
+__bpf_kfunc int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p,
+						    const int rdonly_buf_size)
+{
+	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
+}
+
+/* the next 2 ones can't be really used for testing expect to ensure
+ * that the verifier rejects the call.
+ * Acquire functions must return struct pointers, so these ones are
+ * failing.
+ */
+__bpf_kfunc int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p,
+						    const int rdonly_buf_size)
+{
+	return __bpf_kfunc_call_test_get_mem(p, rdonly_buf_size);
+}
+
+__bpf_kfunc void bpf_kfunc_call_int_mem_release(int *p)
+{
+}
+
+__bpf_kfunc struct prog_test_ref_kfunc *
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
+__bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_destructive(void)
+{
+}
+
+__bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused)
+{
+	return arg;
+}
+
 BTF_SET8_START(bpf_testmod_check_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
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
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
@@ -229,13 +412,34 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
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
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index 27d4494444c8..c8bf054b1ba3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -10,6 +10,61 @@
 #define __ksym
 #endif
 
+struct prog_test_pass1 {
+	int x0;
+	struct {
+		int x1;
+		struct {
+			int x2;
+			struct {
+				int x3;
+			};
+		};
+	};
+};
+
+struct prog_test_pass2 {
+	int len;
+	short arr1[4];
+	struct {
+		char arr2[4];
+		unsigned long arr3[8];
+	} x;
+};
+
+struct prog_test_fail1 {
+	void *p;
+	int x;
+};
+
+struct prog_test_fail2 {
+	int x8;
+	struct prog_test_pass1 x;
+};
+
+struct prog_test_fail3 {
+	int len;
+	char arr1[2];
+	char arr2[];
+};
+
+struct prog_test_member1 {
+	int a;
+};
+
+struct prog_test_member {
+	struct prog_test_member1 m;
+	int c;
+};
+
+struct prog_test_ref_kfunc {
+	int a;
+	int b;
+	struct prog_test_member memb;
+	struct prog_test_ref_kfunc *next;
+	refcount_t cnt;
+};
+
 struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
 struct prog_test_ref_kfunc *
@@ -21,7 +76,13 @@ int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int r
 int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
 int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
 void bpf_kfunc_call_int_mem_release(int *p) __ksym;
+
+/* The bpf_kfunc_call_test_static_unused_arg is defined as static,
+ * but bpf program compilation needs to see it as global symbol.
+ */
+#ifndef __KERNEL__
 u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
+#endif
 
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
 
-- 
2.39.1

