Return-Path: <bpf+bounces-44417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA79C2997
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 03:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D405BB22A67
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 02:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9FE128369;
	Sat,  9 Nov 2024 02:54:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ECB129E9C
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731120842; cv=none; b=d81CWEmDcTUkf2OCnzYU7tuvR+/yPHVuLro79AmlT59gyoqCCG+b3hYhzhoF+ugfWALxK+nZ7ga5EkiZSDdrqt1R+DA7+QIjYUSdJ+XiQgBlBKaLTR2IXNdRUrGbs6+ghPSVOPfYBgG35okxtTgf5qTnu7e8HCuNNwJ2M7s2PtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731120842; c=relaxed/simple;
	bh=5AstnVy3aqttJDEaVH1IaNKfohIrJ7O0raWldSbSPjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLaYL/5yZyP3c9ufil54yj5Ta/xw6RxQ3EPqJlvqpDsiGx6LKRf532sYXUnD7nxHlsD15aHFXgiZ18Gy18nNEE3SwrTacj2dj5GhhLVmHHPokM+bYioq4ks4bUfu5vIWfOJrvmJyM3ReXjxhDpgtVGO4ZEMW7wuFdNjPWFk5ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 11830AE075E0; Fri,  8 Nov 2024 18:53:48 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v11 7/7] selftests/bpf: Add struct_ops prog private stack tests
Date: Fri,  8 Nov 2024 18:53:48 -0800
Message-ID: <20241109025348.150681-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109025312.148539-1-yonghong.song@linux.dev>
References: <20241109025312.148539-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add three tests for struct_ops using private stack.
  ./test_progs -t struct_ops_private_stack
  #333/1   struct_ops_private_stack/private_stack:OK
  #333/2   struct_ops_private_stack/private_stack_fail:OK
  #333/3   struct_ops_private_stack/private_stack_recur:OK
  #333     struct_ops_private_stack:OK

The following is a snippet of a struct_ops check_member() implementation:

	u32 moff =3D __btf_member_bit_offset(t, member) / 8;
	switch (moff) {
	case offsetof(struct bpf_testmod_ops3, test_1):
        	prog->aux->priv_stack_requested =3D true;
                prog->aux->recursion_detected =3D test_1_recursion_detect=
ed;
        	fallthrough;
	default:
        	break;
	}
	return 0;

The first test is with nested two different callback functions where the
first prog has more than 512 byte stack size (including subprogs) with
private stack enabled.

The second test is a negative test where the second prog has more than 51=
2
byte stack size without private stack enabled.

The third test is the same callback function recursing itself. At run tim=
e,
the jit trampoline recursion check kicks in to prevent the recursion. The
recursion_detected() callback function is implemented by the bpf_testmod,
the following message in dmesg
  bpf_testmod: oh no, recursing into test_1, recursion_misses 1
demonstrates the callback function is indeed triggered when recursion mis=
s
happens.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 104 +++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/struct_ops_private_stack.c | 106 ++++++++++++++++++
 .../bpf/progs/struct_ops_private_stack.c      |  62 ++++++++++
 .../bpf/progs/struct_ops_private_stack_fail.c |  62 ++++++++++
 .../progs/struct_ops_private_stack_recur.c    |  50 +++++++++
 6 files changed, 389 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_pri=
vate_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_=
stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_=
stack_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_=
stack_recur.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 987d41af71d2..cc9dde507aba 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -245,6 +245,39 @@ __bpf_kfunc void bpf_testmod_ctx_release(struct bpf_=
testmod_ctx *ctx)
 		call_rcu(&ctx->rcu, testmod_free_cb);
 }
=20
+static struct bpf_testmod_ops3 *st_ops3;
+
+static int bpf_testmod_test_3(void)
+{
+	return 0;
+}
+
+static int bpf_testmod_test_4(void)
+{
+	return 0;
+}
+
+static struct bpf_testmod_ops3 __bpf_testmod_ops3 =3D {
+	.test_1 =3D bpf_testmod_test_3,
+	.test_2 =3D bpf_testmod_test_4,
+};
+
+static void bpf_testmod_test_struct_ops3(void)
+{
+	if (st_ops3)
+		st_ops3->test_1();
+}
+
+__bpf_kfunc void bpf_testmod_ops3_call_test_1(void)
+{
+	st_ops3->test_1();
+}
+
+__bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
+{
+	st_ops3->test_2();
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -382,6 +415,8 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
=20
 	(void)trace_bpf_testmod_test_raw_tp_null(NULL);
=20
+	bpf_testmod_test_struct_ops3();
+
 	struct_arg3 =3D kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
 				sizeof(int)), GFP_KERNEL);
 	if (struct_arg3 !=3D NULL) {
@@ -586,6 +621,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test, KF_TRU=
STED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
=20
 BTF_ID_LIST(bpf_testmod_dtor_ids)
@@ -1096,6 +1133,10 @@ static const struct bpf_verifier_ops bpf_testmod_v=
erifier_ops =3D {
 	.is_valid_access =3D bpf_testmod_ops_is_valid_access,
 };
=20
+static const struct bpf_verifier_ops bpf_testmod_verifier_ops3 =3D {
+	.is_valid_access =3D bpf_testmod_ops_is_valid_access,
+};
+
 static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops *ops =3D kdata;
@@ -1175,6 +1216,68 @@ struct bpf_struct_ops bpf_testmod_ops2 =3D {
 	.owner =3D THIS_MODULE,
 };
=20
+static int st_ops3_reg(void *kdata, struct bpf_link *link)
+{
+	int err =3D 0;
+
+	mutex_lock(&st_ops_mutex);
+	if (st_ops3) {
+		pr_err("st_ops has already been registered\n");
+		err =3D -EEXIST;
+		goto unlock;
+	}
+	st_ops3 =3D kdata;
+
+unlock:
+	mutex_unlock(&st_ops_mutex);
+	return err;
+}
+
+static void st_ops3_unreg(void *kdata, struct bpf_link *link)
+{
+	mutex_lock(&st_ops_mutex);
+	st_ops3 =3D NULL;
+	mutex_unlock(&st_ops_mutex);
+}
+
+static void test_1_recursion_detected(struct bpf_prog *prog)
+{
+	struct bpf_prog_stats *stats;
+
+	stats =3D this_cpu_ptr(prog->stats);
+	printk("bpf_testmod: oh no, recursing into test_1, recursion_misses %ll=
u",
+	       u64_stats_read(&stats->misses));
+}
+
+static int st_ops3_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	u32 moff =3D __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct bpf_testmod_ops3, test_1):
+		prog->aux->priv_stack_requested =3D true;
+		prog->aux->recursion_detected =3D test_1_recursion_detected;
+		fallthrough;
+	default:
+		break;
+	}
+	return 0;
+}
+
+struct bpf_struct_ops bpf_testmod_ops3 =3D {
+	.verifier_ops =3D &bpf_testmod_verifier_ops3,
+	.init =3D bpf_testmod_ops_init,
+	.init_member =3D bpf_testmod_ops_init_member,
+	.reg =3D st_ops3_reg,
+	.unreg =3D st_ops3_unreg,
+	.check_member =3D st_ops3_check_member,
+	.cfi_stubs =3D &__bpf_testmod_ops3,
+	.name =3D "bpf_testmod_ops3",
+	.owner =3D THIS_MODULE,
+};
+
 static int bpf_test_mod_st_ops__test_prologue(struct st_ops_args *args)
 {
 	return 0;
@@ -1333,6 +1436,7 @@ static int bpf_testmod_init(void)
 	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf=
_testmod_kfunc_set);
 	ret =3D ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmo=
d_ops);
 	ret =3D ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_o=
ps2);
+	ret =3D ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_o=
ps3);
 	ret =3D ret ?: register_bpf_struct_ops(&testmod_st_ops, bpf_testmod_st_=
ops);
 	ret =3D ret ?: register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
 						 ARRAY_SIZE(bpf_testmod_dtors),
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index fb7dff47597a..356803d1c10e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -94,6 +94,11 @@ struct bpf_testmod_ops2 {
 	int (*test_1)(void);
 };
=20
+struct bpf_testmod_ops3 {
+	int (*test_1)(void);
+	int (*test_2)(void);
+};
+
 struct st_ops_args {
 	u64 a;
 };
diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_st=
ack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
new file mode 100644
index 000000000000..4006879ca3fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_private_stack.skel.h"
+#include "struct_ops_private_stack_fail.skel.h"
+#include "struct_ops_private_stack_recur.skel.h"
+
+static void test_private_stack(void)
+{
+	struct struct_ops_private_stack *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel =3D struct_ops_private_stack__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack__open"))
+		return;
+
+	if (skel->data->skip) {
+		test__skip();
+		goto cleanup;
+	}
+
+	err =3D struct_ops_private_stack__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_private_stack__load"))
+		goto cleanup;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->val_i, 3, "val_i");
+	ASSERT_EQ(skel->bss->val_j, 8, "val_j");
+
+	bpf_link__destroy(link);
+
+cleanup:
+	struct_ops_private_stack__destroy(skel);
+}
+
+static void test_private_stack_fail(void)
+{
+	struct struct_ops_private_stack_fail *skel;
+	int err;
+
+	skel =3D struct_ops_private_stack_fail__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_fail__open"))
+		return;
+
+	if (skel->data->skip) {
+		test__skip();
+		goto cleanup;
+	}
+
+	err =3D struct_ops_private_stack_fail__load(skel);
+	if (!ASSERT_ERR(err, "struct_ops_private_stack_fail__load"))
+		goto cleanup;
+	return;
+
+cleanup:
+	struct_ops_private_stack_fail__destroy(skel);
+}
+
+static void test_private_stack_recur(void)
+{
+	struct struct_ops_private_stack_recur *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel =3D struct_ops_private_stack_recur__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_recur__open"))
+		return;
+
+	if (skel->data->skip) {
+		test__skip();
+		goto cleanup;
+	}
+
+	err =3D struct_ops_private_stack_recur__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_private_stack_recur__load"))
+		goto cleanup;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->val_j, 3, "val_j");
+
+	bpf_link__destroy(link);
+
+cleanup:
+	struct_ops_private_stack_recur__destroy(skel);
+}
+
+void test_struct_ops_private_stack(void)
+{
+	if (test__start_subtest("private_stack"))
+		test_private_stack();
+	if (test__start_subtest("private_stack_fail"))
+		test_private_stack_fail();
+	if (test__start_subtest("private_stack_recur"))
+		test_private_stack_recur();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c=
 b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
new file mode 100644
index 000000000000..8ea57e5348ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+#if defined(__TARGET_ARCH_x86)
+bool skip __attribute((__section__(".data"))) =3D false;
+#else
+bool skip =3D true;
+#endif
+
+void bpf_testmod_ops3_call_test_2(void) __ksym;
+
+int val_i, val_j;
+
+__noinline static int subprog2(int *a, int *b)
+{
+	return val_i + a[10] + b[20];
+}
+
+__noinline static int subprog1(int *a)
+{
+	/* stack size 200 bytes */
+	int b[50] =3D {};
+
+	b[20] =3D 2;
+	return subprog2(a, b);
+}
+
+
+SEC("struct_ops")
+int BPF_PROG(test_1)
+{
+	/* stack size 400 bytes */
+	int a[100] =3D {};
+
+	a[10] =3D 1;
+	val_i =3D subprog1(a);
+	bpf_testmod_ops3_call_test_2();
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(test_2)
+{
+	/* stack size 200 bytes */
+	int a[50] =3D {};
+
+	a[10] =3D 3;
+	val_j =3D subprog1(a);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct bpf_testmod_ops3 testmod_1 =3D {
+	.test_1 =3D (void *)test_1,
+	.test_2 =3D (void *)test_2,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_f=
ail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
new file mode 100644
index 000000000000..1f55ec4cee37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+#if defined(__TARGET_ARCH_x86)
+bool skip __attribute((__section__(".data"))) =3D false;
+#else
+bool skip =3D true;
+#endif
+
+void bpf_testmod_ops3_call_test_2(void) __ksym;
+
+int val_i, val_j;
+
+__noinline static int subprog2(int *a, int *b)
+{
+	return val_i + a[10] + b[20];
+}
+
+__noinline static int subprog1(int *a)
+{
+	/* stack size 200 bytes */
+	int b[50] =3D {};
+
+	b[20] =3D 2;
+	return subprog2(a, b);
+}
+
+
+SEC("struct_ops")
+int BPF_PROG(test_1)
+{
+	/* stack size 100 bytes */
+	int a[25] =3D {};
+
+	a[10] =3D 1;
+	val_i =3D subprog1(a);
+	bpf_testmod_ops3_call_test_2();
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(test_2)
+{
+	/* stack size 400 bytes */
+	int a[100] =3D {};
+
+	a[10] =3D 3;
+	val_j =3D subprog1(a);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct bpf_testmod_ops3 testmod_1 =3D {
+	.test_1 =3D (void *)test_1,
+	.test_2 =3D (void *)test_2,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_r=
ecur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur=
.c
new file mode 100644
index 000000000000..f2f300d50988
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+#if defined(__TARGET_ARCH_x86)
+bool skip __attribute((__section__(".data"))) =3D false;
+#else
+bool skip =3D true;
+#endif
+
+void bpf_testmod_ops3_call_test_1(void) __ksym;
+
+int val_i, val_j;
+
+__noinline static int subprog2(int *a, int *b)
+{
+	return val_i + a[1] + b[20];
+}
+
+__noinline static int subprog1(int *a)
+{
+	/* stack size 400 bytes */
+	int b[100] =3D {};
+
+	b[20] =3D 2;
+	return subprog2(a, b);
+}
+
+
+SEC("struct_ops")
+int BPF_PROG(test_1)
+{
+	/* stack size 20 bytes */
+	int a[5] =3D {};
+
+	a[1] =3D 1;
+	val_j +=3D subprog1(a);
+	bpf_testmod_ops3_call_test_1();
+	return 0;
+}
+
+SEC(".struct_ops")
+struct bpf_testmod_ops3 testmod_1 =3D {
+	.test_1 =3D (void *)test_1,
+};
--=20
2.43.5


