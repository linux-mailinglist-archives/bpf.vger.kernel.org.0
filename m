Return-Path: <bpf+bounces-37075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB66950C88
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B616B24BEA
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5A1A3BAA;
	Tue, 13 Aug 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="emiCaCqX"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DA1BF53
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575008; cv=none; b=BWeo+A0fwgiYTODzGZCgQBAixr/onow7QvxH5aDx/o8uGVoI4t+118w0OYguP3XuIscBKedc4PD31JbxfezTC+YyVJpTP8boKwMxSoggkMjD7Ex+AEt8YacvaijUVzX46FtjoQFmeH3LGICHRoj0X+68tV+Ojop5Xer/FKEeeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575008; c=relaxed/simple;
	bh=1ffyzeJazkYS5fvLnRB+//9PgQ7N9W7dyKNZOKM0nfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDSF0h3Os2TkO/pIbg0bAVKy1JbuUgezJZvs7wUFE2gkVxjmrla0nYFw19JsW/U7yLEFmkDk+K8cUL5l0TPTEffCkKGeGUAWr84lQnTX8HmHXHlR2D++cp0+veD/uVmQpysaXug0NatRfri8nUY6jEZa8WoFqY09PAjktabnrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=emiCaCqX; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723575002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vp0gvY9jG15PsEIVLmXcrBiefGfJIALcwVt/mFFKD8=;
	b=emiCaCqX1WfGEcOYGkDbxnhlHdc9UpgNDAv+0EZMfTQ4C12Z02xpxUdnVBq546blXU+Ulx
	gKb7bHd46cwO4MzNm9SJIUoTllmrOSR5MfA7OxBH1tUJzL5hyfn62hLpqWxakVEJ9TllvJ
	pEuRuJto5raBcvVjUeAeK+DQiHvtKq0=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next 3/6] selftests/test: test gen_prologue and gen_epilogue
Date: Tue, 13 Aug 2024 11:49:36 -0700
Message-ID: <20240813184943.3759630-4-martin.lau@linux.dev>
In-Reply-To: <20240813184943.3759630-1-martin.lau@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
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
    syscall_prologue(struct st_ops_args *args)
        bpf_kfunc_st_op_test_prologue(args)
	    st_ops->test_prologue(args)

The .gen_prologue and .gen_epilogue of the bpf_testmod_st_ops
will add PROLOGUE_A (1000) and EPILOGUE_A (10000) to args->a.
.gen_prologue adds PROLOGUE_A (1000).
.gen_epilogue adds EPILOGUE_A (10000).
.gen_epilogue will also set the r0 to 2 * args->a.

The .gen_prologue and .gen_epilogue of the bpf_testmod_st_ops
will test the prog->aux->attach_func_name to decide if
it needs to generate codes.

The main programs of the SEC("struct_ops/..") will either
call a global subprog() which does "args->a += 1" or
call another new kfunc bpf_kfunc_st_ops_inc10 which does "args->a += 10".

The prog_tests/struct_ops_syscall.c will test_run the SEC("syscall")
programs. It checks the result by testing the args->a and the retval.

For example, when triggering the ops in the
'SEC("struct_ops/test_epilogue") int BPF_PROG(test_epilogue_subprog..'

the expected args->a is
+1 (because of the subprog calls) + 10000 (.gen_epilogue) = 10001
The expected return value is 2 * 10001 (.gen_epilogue).

Another set of tests is to have the main struct_ops program
to call a subprog and call the inc10 kfunc.

There is also a bpf_tail_call test for epilogue.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 190 ++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  11 +
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   6 +
 .../bpf/prog_tests/struct_ops_syscall.c       |  91 +++++++++
 .../selftests/bpf/progs/struct_ops_syscall.c  | 113 +++++++++++
 5 files changed, 411 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_syscall.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 3687a40b61c6..7194330bdefc 100644
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
@@ -920,6 +921,51 @@ __bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
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
@@ -956,6 +1002,10 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1075,6 +1125,144 @@ struct bpf_struct_ops bpf_testmod_ops2 = {
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
@@ -1092,8 +1280,10 @@ static int bpf_testmod_init(void)
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
diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c
new file mode 100644
index 000000000000..a293a35b0dcc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_syscall.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "struct_ops_syscall.skel.h"
+
+#define EPILOGUE_A  10000
+#define PROLOGUE_A   1000
+#define KFUNC_A10      10
+#define SUBPROG_A       1
+
+#define SUBPROG_TEST_MAIN	SUBPROG_A
+#define KFUNC_TEST_MAIN		(KFUNC_A10 + SUBPROG_A)
+
+struct st_ops_args {
+	int a;
+};
+
+static void do_test(struct struct_ops_syscall *skel,
+		    struct bpf_map *st_ops_map, int main_prog_a)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd, expected_a;
+	struct st_ops_args args;
+	struct bpf_link *link;
+
+	topts.ctx_in = &args;
+	topts.ctx_size_in = sizeof(args);
+
+	link = bpf_map__attach_struct_ops(st_ops_map);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		return;
+
+	/* gen_prologue + main prog */
+	expected_a = PROLOGUE_A + main_prog_a;
+	memset(&args, 0, sizeof(args));
+	prog_fd = bpf_program__fd(skel->progs.syscall_prologue);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(args.a, expected_a, "args.a");
+	ASSERT_EQ(topts.retval, 0, "topts.retval");
+
+	/* main prog + gen_epilogue */
+	expected_a =  main_prog_a + EPILOGUE_A;
+	memset(&args, 0, sizeof(args));
+	prog_fd = bpf_program__fd(skel->progs.syscall_epilogue);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(args.a, expected_a, "args.a");
+	ASSERT_EQ(topts.retval, expected_a * 2, "topts.retval");
+
+	/* gen_prologue + main prog + gen_epilogue */
+	expected_a = PROLOGUE_A + main_prog_a + EPILOGUE_A;
+	memset(&args, 0, sizeof(args));
+	prog_fd = bpf_program__fd(skel->progs.syscall_pro_epilogue);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(args.a, expected_a, "args.a");
+	ASSERT_EQ(topts.retval, expected_a * 2, "topts.retval");
+	bpf_link__destroy(link);
+}
+
+void test_struct_ops_syscall(void)
+{
+	struct struct_ops_syscall *skel;
+
+	skel = struct_ops_syscall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	if (test__start_subtest("subprog"))
+		do_test(skel, skel->maps.pro_epilogue_subprog_ops,
+			SUBPROG_TEST_MAIN);
+
+	if (test__start_subtest("kfunc"))
+		do_test(skel, skel->maps.pro_epilogue_kfunc_ops,
+			KFUNC_TEST_MAIN);
+
+	if (test__start_subtest("tailcall")) {
+		const int zero = 0;
+		int prog_fd = bpf_program__fd(skel->progs.test_epilogue_subprog);
+		int map_fd = bpf_map__fd(skel->maps.epilogue_map);
+		int err;
+
+		err = bpf_map_update_elem(map_fd, &zero, &prog_fd, 0);
+		if (ASSERT_OK(err, "map_update(epilogue_map)"))
+			do_test(skel, skel->maps.pro_epilogue_tail_ops,
+				SUBPROG_TEST_MAIN);
+	}
+
+	struct_ops_syscall__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_syscall.c b/tools/testing/selftests/bpf/progs/struct_ops_syscall.c
new file mode 100644
index 000000000000..ee153461d9f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_syscall.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} epilogue_map SEC(".maps");
+
+static __noinline int subprog(struct st_ops_args *args)
+{
+	args->a += 1;
+	return 0;
+}
+
+SEC("struct_ops/test_prologue_subprog")
+int BPF_PROG(test_prologue_subprog, struct st_ops_args *args)
+{
+	subprog(args);
+	return 0;
+}
+
+SEC("struct_ops/test_epilogue_subprog")
+int BPF_PROG(test_epilogue_subprog, struct st_ops_args *args)
+{
+	subprog(args);
+	return 0;
+}
+
+SEC("struct_ops/test_pro_epilogue_subprog")
+int BPF_PROG(test_pro_epilogue_subprog, struct st_ops_args *args)
+{
+	subprog(args);
+	return 0;
+}
+
+SEC("struct_ops/test_prologue_kfunc")
+int BPF_PROG(test_prologue_kfunc, struct st_ops_args *args)
+{
+	bpf_kfunc_st_ops_inc10(args);
+	subprog(args);
+	return 0;
+}
+
+SEC("struct_ops/test_epilogue_kfunc")
+int BPF_PROG(test_epilogue_kfunc, struct st_ops_args *args)
+{
+	bpf_kfunc_st_ops_inc10(args);
+	subprog(args);
+	return 0;
+}
+
+SEC("struct_ops/test_pro_epilogue_kfunc")
+int BPF_PROG(test_pro_epilogue_kfunc, struct st_ops_args *args)
+{
+	bpf_kfunc_st_ops_inc10(args);
+	subprog(args);
+	return 0;
+}
+
+SEC("struct_ops/test_epilogue_tail")
+int test_epilogue_tail(unsigned long long *ctx)
+{
+	bpf_tail_call_static(ctx, &epilogue_map, 0);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops pro_epilogue_subprog_ops = {
+	.test_prologue = (void *)test_prologue_subprog,
+	.test_epilogue = (void *)test_epilogue_subprog,
+	.test_pro_epilogue = (void *)test_pro_epilogue_subprog,
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops pro_epilogue_kfunc_ops = {
+	.test_prologue = (void *)test_prologue_kfunc,
+	.test_epilogue = (void *)test_epilogue_kfunc,
+	.test_pro_epilogue = (void *)test_pro_epilogue_kfunc,
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops pro_epilogue_tail_ops = {
+	.test_prologue = (void *)test_prologue_subprog,
+	.test_epilogue = (void *)test_epilogue_tail,
+	.test_pro_epilogue = (void *)test_pro_epilogue_subprog,
+};
+
+SEC("syscall")
+int syscall_prologue(struct st_ops_args *args)
+{
+	return bpf_kfunc_st_ops_test_prologue(args);
+}
+
+SEC("syscall")
+int syscall_epilogue(struct st_ops_args *args)
+{
+	return bpf_kfunc_st_ops_test_epilogue(args);
+}
+
+SEC("syscall")
+int syscall_pro_epilogue(struct st_ops_args *args)
+{
+	return bpf_kfunc_st_ops_test_pro_epilogue(args);
+}
-- 
2.43.5


