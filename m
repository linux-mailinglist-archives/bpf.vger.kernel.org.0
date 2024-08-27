Return-Path: <bpf+bounces-38189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F129616B3
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351BC1C22F0A
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 18:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B186E1D2F52;
	Tue, 27 Aug 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M8yWP/SE"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B61D27A3
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782640; cv=none; b=UTnWYpOrikTHZrybhSqQl7POCwpat/mnGaspPPUdLMFcjWTCGmj+ObWTjr4uB5RVcW8XMdY3naoK8rnbXJFBFwD3A1+0LcKdHTQaOw3l1R18XjQd9SR8woAoNA+fzBKCosGq6Dme68lNloyoxZKO0JP7TOtj4NIHYtkP195wKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782640; c=relaxed/simple;
	bh=agvaY6eNQK2Sj29TzrzuzFP+YFiGFdDRW5yTWDRDB7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fr9VxPEY0Kcw+3SV/B6P4Hm6/8xVaBF0KJs/9H6thzBKel4B9lwfhdiNGt0rFBolZOL9dvLz2Uh6MuoMBn0A4UA9tV7eFUkpuPrWNqSUBvF2OEiyOlZ3j6ah87QvgrcloCEaL1K9J6o9qU/pc1RReKC+kPkD8CIty+peSAL/wVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M8yWP/SE; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724782636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYN2+JySorAqqEIuQxA3I+Df9CuJ6kIjUKUB9EXnT20=;
	b=M8yWP/SEjzcS44jq5b2Itj21ytwGL2LVjSFLrm90Tm5g0kjkNRWRSLDsPpcu1GOh3FBwml
	iTC+0l8hh5lwqdrxXn2krWASkuQo78bS5AVSJtY2QdNWGd2V6afPPVO7N53m1k/XDbvelg
	gpTL1qyzSe/tC+EsoHWKYRHAat+1SUM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 6/9] selftests/bpf: Test gen_prologue and gen_epilogue
Date: Tue, 27 Aug 2024 11:16:42 -0700
Message-ID: <20240827181647.847890-7-martin.lau@linux.dev>
In-Reply-To: <20240827181647.847890-1-martin.lau@linux.dev>
References: <20240827181647.847890-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This test adds a new struct_ops "bpf_testmod_st_ops" in bpf_testmod.
The ops of the bpf_testmod_st_ops is triggered by new kfunc calls
"bpf_kfunc_st_ops_test_*logue". These new kfunc calls are
primarily used by the SEC("syscall") program. The test triggering
sequence is like:
    SEC("syscall")
    syscall_prologue_subprog(struct st_ops_args *args)
        bpf_kfunc_st_op_test_prologue(args)
	    st_ops->test_prologue(args)

.gen_prologue adds 1000 to args->a
.gen_epilogue adds 10000 to args->a
.gen_epilogue will also set the r0 to 2 * args->a.

The .gen_prologue and .gen_epilogue of the bpf_testmod_st_ops
will test the prog->aux->attach_func_name to decide if
it needs to generate codes.

The main programs of the pro_epilogue_subprog.c will call a subprog()
which does "args->a += 1".

The main programs of the pro_epilogue_kfunc.c will call a
new kfunc bpf_kfunc_st_ops_inc10 which does "args->a += 10".

This patch uses the test_loader infra to check the __xlated
instructions patched after gen_prologue and/or gen_epilogue.
The __xlated check is based on Eduard's example (Thanks!) in v1.

args->a is returned by the struct_ops prog (either the main prog
or the epilogue). Thus, the __retval of the SEC("syscall") prog
is checked. For example, when triggering the ops in the
'SEC("struct_ops/test_epilogue_subprog") int test_epilogue_subprog'
The expected args->a is +1 (subprog call) + 10000 (.gen_epilogue) = 10001.
The expected return value is 2 * 10001 (.gen_epilogue).

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 190 ++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  11 +
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   6 +
 .../selftests/bpf/prog_tests/pro_epilogue.c   |  12 ++
 .../selftests/bpf/progs/pro_epilogue_kfunc.c  | 156 ++++++++++++++
 .../bpf/progs/pro_epilogue_subprog.c          | 125 ++++++++++++
 6 files changed, 500 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index c04b7dec2ab9..b8b6989d596a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -17,6 +17,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/un.h>
+#include <linux/filter.h>
 #include <net/sock.h>
 #include <linux/namei.h>
 #include "bpf_testmod.h"
@@ -928,6 +929,51 @@ __bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
 	return err;
 }
 
+static DEFINE_MUTEX(st_ops_mutex);
+static struct bpf_testmod_st_ops *st_ops;
+
+__bpf_kfunc int bpf_kfunc_st_ops_test_prologue(struct st_ops_args *args)
+{
+	int ret = -1;
+
+	mutex_lock(&st_ops_mutex);
+	if (st_ops && st_ops->test_prologue)
+		ret = st_ops->test_prologue(args);
+	mutex_unlock(&st_ops_mutex);
+
+	return ret;
+}
+
+__bpf_kfunc int bpf_kfunc_st_ops_test_epilogue(struct st_ops_args *args)
+{
+	int ret = -1;
+
+	mutex_lock(&st_ops_mutex);
+	if (st_ops && st_ops->test_epilogue)
+		ret = st_ops->test_epilogue(args);
+	mutex_unlock(&st_ops_mutex);
+
+	return ret;
+}
+
+__bpf_kfunc int bpf_kfunc_st_ops_test_pro_epilogue(struct st_ops_args *args)
+{
+	int ret = -1;
+
+	mutex_lock(&st_ops_mutex);
+	if (st_ops && st_ops->test_pro_epilogue)
+		ret = st_ops->test_pro_epilogue(args);
+	mutex_unlock(&st_ops_mutex);
+
+	return ret;
+}
+
+__bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
+{
+	args->a += 10;
+	return args->a;
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -964,6 +1010,10 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1083,6 +1133,144 @@ struct bpf_struct_ops bpf_testmod_ops2 = {
 	.owner = THIS_MODULE,
 };
 
+static int bpf_test_mod_st_ops__test_prologue(struct st_ops_args *args)
+{
+	return 0;
+}
+
+static int bpf_test_mod_st_ops__test_epilogue(struct st_ops_args *args)
+{
+	return 0;
+}
+
+static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
+{
+	return 0;
+}
+
+static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
+			       const struct bpf_prog *prog)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	if (strcmp(prog->aux->attach_func_name, "test_prologue") &&
+	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
+		return 0;
+
+	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
+	 * r7 = r6->a;
+	 * r7 += 1000;
+	 * r6->a = r7;
+	 */
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0);
+	*insn++ = BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_ALU32_IMM(BPF_ADD, BPF_REG_7, 1000);
+	*insn++ = BPF_STX_MEM(BPF_W, BPF_REG_6, BPF_REG_7, offsetof(struct st_ops_args, a));
+	*insn++ = prog->insnsi[0];
+
+	return insn - insn_buf;
+}
+
+static int st_ops_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
+			       s16 ctx_stack_off)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	if (strcmp(prog->aux->attach_func_name, "test_epilogue") &&
+	    strcmp(prog->aux->attach_func_name, "test_pro_epilogue"))
+		return 0;
+
+	/* r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
+	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
+	 * r6 = r1->a;
+	 * r6 += 10000;
+	 * r1->a = r6;
+	 * r0 = r6;
+	 * r0 *= 2;
+	 * BPF_EXIT;
+	 */
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	*insn++ = BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_ALU32_IMM(BPF_ADD, BPF_REG_6, 10000);
+	*insn++ = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_6, offsetof(struct st_ops_args, a));
+	*insn++ = BPF_MOV32_REG(BPF_REG_0, BPF_REG_6);
+	*insn++ = BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, 2);
+	*insn++ = BPF_EXIT_INSN();
+
+	return insn - insn_buf;
+}
+
+static int st_ops_btf_struct_access(struct bpf_verifier_log *log,
+				    const struct bpf_reg_state *reg,
+				    int off, int size)
+{
+	if (off < 0 || off + size > sizeof(struct st_ops_args))
+		return -EACCES;
+	return 0;
+}
+
+static const struct bpf_verifier_ops st_ops_verifier_ops = {
+	.is_valid_access = bpf_testmod_ops_is_valid_access,
+	.btf_struct_access = st_ops_btf_struct_access,
+	.gen_prologue = st_ops_gen_prologue,
+	.gen_epilogue = st_ops_gen_epilogue,
+	.get_func_proto = bpf_base_func_proto,
+};
+
+static struct bpf_testmod_st_ops st_ops_cfi_stubs = {
+	.test_prologue = bpf_test_mod_st_ops__test_prologue,
+	.test_epilogue = bpf_test_mod_st_ops__test_epilogue,
+	.test_pro_epilogue = bpf_test_mod_st_ops__test_pro_epilogue,
+};
+
+static int st_ops_reg(void *kdata, struct bpf_link *link)
+{
+	int err = 0;
+
+	mutex_lock(&st_ops_mutex);
+	if (st_ops) {
+		pr_err("st_ops has already been registered\n");
+		err = -EEXIST;
+		goto unlock;
+	}
+	st_ops = kdata;
+
+unlock:
+	mutex_unlock(&st_ops_mutex);
+	return err;
+}
+
+static void st_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	mutex_lock(&st_ops_mutex);
+	st_ops = NULL;
+	mutex_unlock(&st_ops_mutex);
+}
+
+static int st_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int st_ops_init_member(const struct btf_type *t,
+			      const struct btf_member *member,
+			      void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static struct bpf_struct_ops testmod_st_ops = {
+	.verifier_ops = &st_ops_verifier_ops,
+	.init = st_ops_init,
+	.init_member = st_ops_init_member,
+	.reg = st_ops_reg,
+	.unreg = st_ops_unreg,
+	.cfi_stubs = &st_ops_cfi_stubs,
+	.name = "bpf_testmod_st_ops",
+	.owner = THIS_MODULE,
+};
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -1100,8 +1288,10 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
+	ret = ret ?: register_bpf_struct_ops(&testmod_st_ops, bpf_testmod_st_ops);
 	ret = ret ?: register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
 						 ARRAY_SIZE(bpf_testmod_dtors),
 						 THIS_MODULE);
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index fe0d402b0d65..3241a9d796ed 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -94,4 +94,15 @@ struct bpf_testmod_ops2 {
 	int (*test_1)(void);
 };
 
+struct st_ops_args {
+	int a;
+};
+
+struct bpf_testmod_st_ops {
+	int (*test_prologue)(struct st_ops_args *args);
+	int (*test_epilogue)(struct st_ops_args *args);
+	int (*test_pro_epilogue)(struct st_ops_args *args);
+	struct module *owner;
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index e587a79f2239..0df429a0edaa 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -144,4 +144,10 @@ void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nulla
 struct bpf_testmod_ctx *bpf_testmod_ctx_create(int *err) __ksym;
 void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx) __ksym;
 
+struct st_ops_args;
+int bpf_kfunc_st_ops_test_prologue(struct st_ops_args *args) __ksym;
+int bpf_kfunc_st_ops_test_epilogue(struct st_ops_args *args) __ksym;
+int bpf_kfunc_st_ops_test_pro_epilogue(struct st_ops_args *args) __ksym;
+int bpf_kfunc_st_ops_inc10(struct st_ops_args *args) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
new file mode 100644
index 000000000000..69e4a5a1756d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "pro_epilogue_subprog.skel.h"
+#include "pro_epilogue_kfunc.skel.h"
+
+void test_pro_epilogue(void)
+{
+	RUN_TESTS(pro_epilogue_subprog);
+	RUN_TESTS(pro_epilogue_kfunc);
+}
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c b/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
new file mode 100644
index 000000000000..7d1124cf4942
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+void __kfunc_btf_root(void)
+{
+	struct st_ops_args args = {};
+
+	bpf_kfunc_st_ops_inc10(&args);
+}
+
+static __noinline __used int subprog(struct st_ops_args *args)
+{
+	args->a += 1;
+	return args->a;
+}
+
+__success
+/* prologue */
+__xlated("0: r6 = *(u64 *)(r1 +0)")
+__xlated("1: r7 = *(u32 *)(r6 +0)")
+__xlated("2: w7 += 1000")
+__xlated("3: *(u32 *)(r6 +0) = r7")
+/* main prog */
+__xlated("4: r1 = *(u64 *)(r1 +0)")
+__xlated("5: r6 = r1")
+__xlated("6: call kernel-function")
+__xlated("7: r1 = r6")
+__xlated("8: call pc+1")
+__xlated("9: exit")
+SEC("struct_ops/test_prologue_kfunc")
+__naked int test_prologue_kfunc(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+__success
+/* save __u64 *ctx to stack */
+__xlated("0: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("1: r1 = *(u64 *)(r1 +0)")
+__xlated("2: r6 = r1")
+__xlated("3: call kernel-function")
+__xlated("4: r1 = r6")
+__xlated("5: call pc+")
+/* epilogue */
+__xlated("6: r1 = *(u64 *)(r10 -8)")
+__xlated("7: r1 = *(u64 *)(r1 +0)")
+__xlated("8: r6 = *(u32 *)(r1 +0)")
+__xlated("9: w6 += 10000")
+__xlated("10: *(u32 *)(r1 +0) = r6")
+__xlated("11: w0 = w6")
+__xlated("12: w0 *= 2")
+__xlated("13: exit")
+SEC("struct_ops/test_epilogue_kfunc")
+__naked int test_epilogue_kfunc(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+__success
+/* prologue */
+__xlated("0: r6 = *(u64 *)(r1 +0)")
+__xlated("1: r7 = *(u32 *)(r6 +0)")
+__xlated("2: w7 += 1000")
+__xlated("3: *(u32 *)(r6 +0) = r7")
+/* save __u64 *ctx to stack */
+__xlated("4: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("5: r1 = *(u64 *)(r1 +0)")
+__xlated("6: r6 = r1")
+__xlated("7: call kernel-function")
+__xlated("8: r1 = r6")
+__xlated("9: call pc+")
+/* epilogue */
+__xlated("10: r1 = *(u64 *)(r10 -8)")
+__xlated("11: r1 = *(u64 *)(r1 +0)")
+__xlated("12: r6 = *(u32 *)(r1 +0)")
+__xlated("13: w6 += 10000")
+__xlated("14: *(u32 *)(r1 +0) = r6")
+__xlated("15: w0 = w6")
+__xlated("16: w0 *= 2")
+__xlated("17: exit")
+SEC("struct_ops/test_pro_epilogue_kfunc")
+__naked int test_pro_epilogue_kfunc(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r6 = r1;"
+	"call %[bpf_kfunc_st_ops_inc10];"
+	"r1 = r6;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_st_ops_inc10)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__retval(1011) /* PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] */
+int syscall_prologue_kfunc(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_prologue(&args);
+}
+
+SEC("syscall")
+__retval(20022) /* (KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_epilogue_kfunc(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
+
+SEC("syscall")
+__retval(22022) /* (PROLOGUE_A [1000] + KFUNC_INC10 + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_pro_epilogue_kfunc(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_pro_epilogue(&args);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops pro_epilogue_kfunc = {
+	.test_prologue = (void *)test_prologue_kfunc,
+	.test_epilogue = (void *)test_epilogue_kfunc,
+	.test_pro_epilogue = (void *)test_pro_epilogue_kfunc,
+};
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c b/tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c
new file mode 100644
index 000000000000..c91b1bf30e37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_subprog.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+static __noinline __used int subprog(struct st_ops_args *args)
+{
+	args->a += 1;
+	return args->a;
+}
+
+__success
+/* prologue */
+__xlated("0: r6 = *(u64 *)(r1 +0)")
+__xlated("1: r7 = *(u32 *)(r6 +0)")
+__xlated("2: w7 += 1000")
+__xlated("3: *(u32 *)(r6 +0) = r7")
+/* main prog */
+__xlated("4: r1 = *(u64 *)(r1 +0)")
+__xlated("5: call pc+1")
+__xlated("6: exit")
+SEC("struct_ops/test_prologue_subprog")
+__naked int test_prologue_subprog(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"call subprog;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__success
+/* save __u64 *ctx to stack */
+__xlated("0: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("1: r1 = *(u64 *)(r1 +0)")
+__xlated("2: call pc+")
+/* epilogue */
+__xlated("3: r1 = *(u64 *)(r10 -8)")
+__xlated("4: r1 = *(u64 *)(r1 +0)")
+__xlated("5: r6 = *(u32 *)(r1 +0)")
+__xlated("6: w6 += 10000")
+__xlated("7: *(u32 *)(r1 +0) = r6")
+__xlated("8: w0 = w6")
+__xlated("9: w0 *= 2")
+__xlated("10: exit")
+SEC("struct_ops/test_epilogue_subprog")
+__naked int test_epilogue_subprog(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"call subprog;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__success
+/* prologue */
+__xlated("0: r6 = *(u64 *)(r1 +0)")
+__xlated("1: r7 = *(u32 *)(r6 +0)")
+__xlated("2: w7 += 1000")
+__xlated("3: *(u32 *)(r6 +0) = r7")
+/* save __u64 *ctx to stack */
+__xlated("4: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("5: r1 = *(u64 *)(r1 +0)")
+__xlated("6: call pc+")
+/* epilogue */
+__xlated("7: r1 = *(u64 *)(r10 -8)")
+__xlated("8: r1 = *(u64 *)(r1 +0)")
+__xlated("9: r6 = *(u32 *)(r1 +0)")
+__xlated("10: w6 += 10000")
+__xlated("11: *(u32 *)(r1 +0) = r6")
+__xlated("12: w0 = w6")
+__xlated("13: w0 *= 2")
+__xlated("14: exit")
+SEC("struct_ops/test_pro_epilogue_subprog")
+__naked int test_pro_epilogue_subprog(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"call subprog;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("syscall")
+__retval(1001) /* PROLOGUE_A [1000] + SUBPROG_A [1] */
+int syscall_prologue_subprog(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_prologue(&args);
+}
+
+SEC("syscall")
+__retval(20002) /* (SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_epilogue_subprog(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
+
+SEC("syscall")
+__retval(22002) /* (PROLOGUE_A [1000] + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_pro_epilogue_subprog(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_pro_epilogue(&args);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops pro_epilogue_subprog = {
+	.test_prologue = (void *)test_prologue_subprog,
+	.test_epilogue = (void *)test_epilogue_subprog,
+	.test_pro_epilogue = (void *)test_pro_epilogue_subprog,
+};
-- 
2.43.5


