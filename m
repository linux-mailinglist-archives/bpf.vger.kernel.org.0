Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA305438F6E
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 08:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhJYG1p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 02:27:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14861 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJYG1o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 02:27:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hd4gw4cDYz90QX;
        Mon, 25 Oct 2021 14:25:16 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 14:25:07 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 14:25:07 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH bpf-next v4 3/4] bpf: add dummy BPF STRUCT_OPS for test purpose
Date:   Mon, 25 Oct 2021 14:40:24 +0800
Message-ID: <20211025064025.2567443-4-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211025064025.2567443-1-houtao1@huawei.com>
References: <20211025064025.2567443-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the test of BPF STRUCT_OPS depends on the specific bpf
implementation of tcp_congestion_ops, but it can not cover all
basic functionalities (e.g, return value handling), so introduce
a dummy BPF STRUCT_OPS for test purpose.

Loading a bpf_dummy_ops implementation from userspace is prohibited,
and its only purpose is to run BPF_PROG_TYPE_STRUCT_OPS program
through bpf(BPF_PROG_TEST_RUN). Now programs for test_1() & test_2()
are supported. The following three cases are exercised in
bpf_dummy_struct_ops_test_run():

(1) test and check the value returned from state arg in test_1(state)
The content of state is copied from userspace pointer and copied back
after calling test_1(state). The user pointer is saved in an u64 array
and the array address is passed through ctx_in.

(2) test and check the return value of test_1(NULL)
Just simulate the case in which an invalid input argument is passed in.

(3) test multiple arguments passing in test_2(state, ...)
5 arguments are passed through ctx_in in form of u64 array. The first
element of array is userspace pointer of state and others 4 arguments
follow.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h               |  16 +++
 kernel/bpf/bpf_struct_ops.c       |   3 +
 kernel/bpf/bpf_struct_ops_types.h |   3 +
 net/bpf/Makefile                  |   3 +
 net/bpf/bpf_dummy_struct_ops.c    | 200 ++++++++++++++++++++++++++++++
 5 files changed, 225 insertions(+)
 create mode 100644 net/bpf/bpf_dummy_struct_ops.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d986e2cc2498..51a85b6e987e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1017,6 +1017,22 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 	else
 		module_put(owner);
 }
+
+#ifdef CONFIG_NET
+/* Define it here to avoid the use of forward declaration */
+struct bpf_dummy_ops_state {
+	int val;
+};
+
+struct bpf_dummy_ops {
+	int (*test_1)(struct bpf_dummy_ops_state *cb);
+	int (*test_2)(struct bpf_dummy_ops_state *cb, int a1, unsigned short a2,
+		      char a3, unsigned long a4);
+};
+
+int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
+			    union bpf_attr __user *uattr);
+#endif
 #else
 static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
 {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 44be101f2562..8ecfe4752769 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -93,6 +93,9 @@ const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
 };
 
 const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
+#ifdef CONFIG_NET
+	.test_run = bpf_struct_ops_test_run,
+#endif
 };
 
 static const struct btf_type *module_type;
diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
index 066d83ea1c99..5678a9ddf817 100644
--- a/kernel/bpf/bpf_struct_ops_types.h
+++ b/kernel/bpf/bpf_struct_ops_types.h
@@ -2,6 +2,9 @@
 /* internal file - do not include directly */
 
 #ifdef CONFIG_BPF_JIT
+#ifdef CONFIG_NET
+BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
+#endif
 #ifdef CONFIG_INET
 #include <net/tcp.h>
 BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
diff --git a/net/bpf/Makefile b/net/bpf/Makefile
index 1c0a98d8c28f..1ebe270bde23 100644
--- a/net/bpf/Makefile
+++ b/net/bpf/Makefile
@@ -1,2 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BPF_SYSCALL)	:= test_run.o
+ifeq ($(CONFIG_BPF_JIT),y)
+obj-$(CONFIG_BPF_SYSCALL)	+= bpf_dummy_struct_ops.o
+endif
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
new file mode 100644
index 000000000000..fbc896323bec
--- /dev/null
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021. Huawei Technologies Co., Ltd
+ */
+#include <linux/kernel.h>
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+extern struct bpf_struct_ops bpf_bpf_dummy_ops;
+
+/* A common type for test_N with return value in bpf_dummy_ops */
+typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
+
+struct bpf_dummy_ops_test_args {
+	u64 args[MAX_BPF_FUNC_ARGS];
+	struct bpf_dummy_ops_state state;
+};
+
+static struct bpf_dummy_ops_test_args *
+dummy_ops_init_args(const union bpf_attr *kattr, unsigned int nr)
+{
+	__u32 size_in;
+	struct bpf_dummy_ops_test_args *args;
+	void __user *ctx_in;
+	void __user *u_state;
+
+	size_in = kattr->test.ctx_size_in;
+	if (size_in != sizeof(u64) * nr)
+		return ERR_PTR(-EINVAL);
+
+	args = kzalloc(sizeof(*args), GFP_KERNEL);
+	if (!args)
+		return ERR_PTR(-ENOMEM);
+
+	ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
+	if (copy_from_user(args->args, ctx_in, size_in))
+		goto out;
+
+	/* args[0] is 0 means state argument of test_N will be NULL */
+	u_state = u64_to_user_ptr(args->args[0]);
+	if (u_state && copy_from_user(&args->state, u_state,
+				      sizeof(args->state)))
+		goto out;
+
+	return args;
+out:
+	kfree(args);
+	return ERR_PTR(-EFAULT);
+}
+
+static int dummy_ops_copy_args(struct bpf_dummy_ops_test_args *args)
+{
+	void __user *u_state;
+
+	u_state = u64_to_user_ptr(args->args[0]);
+	if (u_state && copy_to_user(u_state, &args->state, sizeof(args->state)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int dummy_ops_call_op(void *image, struct bpf_dummy_ops_test_args *args)
+{
+	dummy_ops_test_ret_fn test = (void *)image;
+	struct bpf_dummy_ops_state *state = NULL;
+
+	/* state needs to be NULL if args[0] is 0 */
+	if (args->args[0])
+		state = &args->state;
+	return test(state, args->args[1], args->args[2],
+		    args->args[3], args->args[4]);
+}
+
+int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
+			    union bpf_attr __user *uattr)
+{
+	const struct bpf_struct_ops *st_ops = &bpf_bpf_dummy_ops;
+	const struct btf_type *func_proto;
+	struct bpf_dummy_ops_test_args *args;
+	struct bpf_tramp_progs *tprogs;
+	void *image = NULL;
+	unsigned int op_idx;
+	int prog_ret;
+	int err;
+
+	if (prog->aux->attach_btf_id != st_ops->type_id)
+		return -EOPNOTSUPP;
+
+	func_proto = prog->aux->attach_func_proto;
+	args = dummy_ops_init_args(kattr, btf_type_vlen(func_proto));
+	if (IS_ERR(args))
+		return PTR_ERR(args);
+
+	tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
+	if (!tprogs) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	image = bpf_jit_alloc_exec(PAGE_SIZE);
+	if (!image) {
+		err = -ENOMEM;
+		goto out;
+	}
+	set_vm_flush_reset_perms(image);
+
+	op_idx = prog->expected_attach_type;
+	err = bpf_struct_ops_prepare_trampoline(tprogs, prog,
+						&st_ops->func_models[op_idx],
+						image, image + PAGE_SIZE);
+	if (err < 0)
+		goto out;
+
+	set_memory_ro((long)image, 1);
+	set_memory_x((long)image, 1);
+	prog_ret = dummy_ops_call_op(image, args);
+
+	err = dummy_ops_copy_args(args);
+	if (err)
+		goto out;
+	if (put_user(prog_ret, &uattr->test.retval))
+		err = -EFAULT;
+out:
+	kfree(args);
+	bpf_jit_free_exec(image);
+	kfree(tprogs);
+	return err;
+}
+
+static int bpf_dummy_init(struct btf *btf)
+{
+	return 0;
+}
+
+static bool bpf_dummy_ops_is_valid_access(int off, int size,
+					  enum bpf_access_type type,
+					  const struct bpf_prog *prog,
+					  struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
+					   const struct btf *btf,
+					   const struct btf_type *t, int off,
+					   int size, enum bpf_access_type atype,
+					   u32 *next_btf_id)
+{
+	const struct btf_type *state;
+	s32 type_id;
+	int err;
+
+	type_id = btf_find_by_name_kind(btf, "bpf_dummy_ops_state",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+
+	state = btf_type_by_id(btf, type_id);
+	if (t != state) {
+		bpf_log(log, "only access to bpf_dummy_ops_state is supported\n");
+		return -EACCES;
+	}
+
+	err = btf_struct_access(log, btf, t, off, size, atype, next_btf_id);
+	if (err < 0)
+		return err;
+
+	return atype == BPF_READ ? err : NOT_INIT;
+}
+
+static const struct bpf_verifier_ops bpf_dummy_verifier_ops = {
+	.is_valid_access = bpf_dummy_ops_is_valid_access,
+	.btf_struct_access = bpf_dummy_ops_btf_struct_access,
+};
+
+static int bpf_dummy_init_member(const struct btf_type *t,
+				 const struct btf_member *member,
+				 void *kdata, const void *udata)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bpf_dummy_reg(void *kdata)
+{
+	return -EOPNOTSUPP;
+}
+
+static void bpf_dummy_unreg(void *kdata)
+{
+}
+
+struct bpf_struct_ops bpf_bpf_dummy_ops = {
+	.verifier_ops = &bpf_dummy_verifier_ops,
+	.init = bpf_dummy_init,
+	.init_member = bpf_dummy_init_member,
+	.reg = bpf_dummy_reg,
+	.unreg = bpf_dummy_unreg,
+	.name = "bpf_dummy_ops",
+};
-- 
2.29.2

