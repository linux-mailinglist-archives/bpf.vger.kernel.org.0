Return-Path: <bpf+bounces-531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CEA702E80
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5EB1C20910
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2CC8FA;
	Mon, 15 May 2023 13:39:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBAC8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1ADC433EF;
	Mon, 15 May 2023 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157984;
	bh=CvxNwHfPRkEsx1LNKWkqjXa5sEXaW9nv7+xG/a7PUzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6tBEsQNqOPaqJ+63DFWK6cxALgZd1rX21xeBMhOeHK5KkEeeFlueoAL/Ne5eSSpl
	 9zuQ5Ac9PDM/T8KNEpjk0/YBjT2c7mDAVq805mz6411+KLfN0nq9RV5MrhmprOYEEe
	 TJckbhzMvh+7nd1x5NUw/2r+yre4iCs9N3BIEebjNw1ksKqGEm/ty5lRlv3rZzNVBw
	 azQcbLCdreODQITdrIOtuC0q/Bs6bd/IEJiiVqQbPSAVWhtxZ7Wn0eCWkDQcaUIYhK
	 0aYcCuowsrLxCQk8tQTmCQIQd49WWOgP0BGFz37MXzghWeXj7X5vr2AbiVNrYuXxnp
	 +qXS9gMTqagXA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	David Vernet <void@manifault.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 10/10] bpf: Move kernel test kfuncs to bpf_testmod
Date: Mon, 15 May 2023 15:37:56 +0200
Message-Id: <20230515133756.1658301-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
References: <20230515133756.1658301-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving kernel test kfuncs into bpf_testmod kernel module, and adding
necessary init calls and BTF IDs records.

We need to keep following structs in kernel:
  struct prog_test_ref_kfunc
  struct prog_test_member (embedded in prog_test_ref_kfunc)

The reason is because they need to be marked as rcu safe (check test
prog mark_ref_as_untrusted_or_null) and such objects are being required
to be defined only in kernel at the moment (see rcu_safe_kptr check
in kernel).

We need to keep also dtor functions for both objects in kernel:
  bpf_kfunc_call_test_release
  bpf_kfunc_call_memb_release

We also keep the copy of these struct in bpf_testmod_kfunc.h, because
other test functions use them. This is unfortunate, but this is just
temporary solution until we are able to these structs them to bpf_testmod
completely.

As suggested by David adding bpf_testmod.ko make dependency for
bpf programs, so they are rebuilt if we change the bpf_testmod.ko
module.

Also adding missing __bpf_kfunc to bpf_kfunc_call_test4 functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 net/bpf/test_run.c                            | 201 ------------------
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 166 +++++++++++++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  60 ++++++
 3 files changed, 226 insertions(+), 201 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index e79e3a415ca9..79055a3a540b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -561,29 +561,6 @@ __bpf_kfunc int bpf_modify_return_test(int a, int *b)
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
 int noinline bpf_fentry_shadow_test(int a)
 {
 	return a + 1;
@@ -606,32 +583,6 @@ struct prog_test_ref_kfunc {
 	refcount_t cnt;
 };
 
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
-__bpf_kfunc void bpf_kfunc_call_test_offset(struct prog_test_ref_kfunc *p)
-{
-	WARN_ON_ONCE(1);
-}
-
-__bpf_kfunc struct prog_test_member *
-bpf_kfunc_call_memb_acquire(void)
-{
-	WARN_ON_ONCE(1);
-	return NULL;
-}
-
 __bpf_kfunc void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
 	refcount_dec(&p->cnt);
@@ -641,134 +592,6 @@ __bpf_kfunc void bpf_kfunc_call_memb_release(struct prog_test_member *p)
 {
 }
 
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
-	/* p != NULL, but p->cnt could be 0 */
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
@@ -782,32 +605,8 @@ static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
 };
 
 BTF_SET8_START(test_sk_check_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_memb_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_memb1_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdwr_mem, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdonly_mem, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_acq_rdonly_mem, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 52785ba671e6..cf216041876c 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -9,6 +9,7 @@
 #include <linux/sysfs.h>
 #include <linux/tracepoint.h>
 #include "bpf_testmod.h"
+#include "bpf_testmod_kfunc.h"
 
 #define CREATE_TRACE_POINTS
 #include "bpf_testmod-events.h"
@@ -289,8 +290,171 @@ static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.set   = &bpf_testmod_common_kfunc_ids,
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
+__bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short b, int c, long d)
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
+__bpf_kfunc void bpf_kfunc_call_test_offset(struct prog_test_ref_kfunc *p)
+{
+	WARN_ON_ONCE(1);
+}
+
+__bpf_kfunc struct prog_test_member *
+bpf_kfunc_call_memb_acquire(void)
+{
+	WARN_ON_ONCE(1);
+	return NULL;
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
+	/* p != NULL, but p->cnt could be 0 */
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
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_memb_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_memb1_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdwr_mem, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdonly_mem, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_acq_rdonly_mem, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
@@ -312,6 +476,8 @@ static int bpf_testmod_init(void)
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_testmod_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index 57f6166911f8..9693c626646b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -8,8 +8,62 @@
 #include <bpf/bpf_helpers.h>
 #else
 #define __ksym
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
 struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
 void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
@@ -20,7 +74,13 @@ int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int r
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
2.40.1


