Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007B52473B
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351133AbiELHnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 03:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351143AbiELHnp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:43:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38DA1A15FC
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:43 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwW2c013980
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Y6w/YomUbNGL1juCVMUJNbemUhqF0oQ8EpnUOtoM028=;
 b=j4SSgKq5Zg+QSNWgtb38TWl4K61u3t24Lx97+DME6nnnskqbTD3xDJucDnheuPFpwO0f
 r1buQ+sXG2eFg3z/zy2lueix09dCk1ZtdRcH9VAbk5gEx3Q8KjIhaySE7fv+FipaehLj
 FQGt7AGxJccQGaJlq5BPVR4gpDr15yLEOjo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g04tb8s07-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:42 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 00:43:41 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 6573C78F7CD5; Thu, 12 May 2022 00:43:30 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 5/5] selftests/bpf: get_reg_val test exercising fxsave fetch
Date:   Thu, 12 May 2022 00:43:21 -0700
Message-ID: <20220512074321.2090073-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220512074321.2090073-1-davemarchevsky@fb.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ngYHf1isjFeAufkQcAkWXpetX0K-gN3L
X-Proofpoint-ORIG-GUID: ngYHf1isjFeAufkQcAkWXpetX0K-gN3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test which calls bpf_get_reg_val with an xmm reg after forcing fpu
state save. The test program writes to %xmm10, then calls a BPF program
which forces fpu save and calls bpf_get_reg_val. This guarantees that
!fpregs_state_valid check will succeed, forcing bpf_get_reg_val to fetch
%xmm10's value from task's fpu state.

A bpf_testmod_save_fpregs kfunc helper is added to bpf_testmod to enable
'force fpu save'. Existing bpf_dummy_ops test infra is extended to
support calling the kfunc.

unload_bpf_testmod would often fail with -EAGAIN when running the test
added in this patch, so a single retry w/ 20ms sleep is added.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h                           |  1 +
 kernel/trace/bpf_trace.c                      |  2 +-
 net/bpf/bpf_dummy_struct_ops.c                | 13 ++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 13 ++++++
 tools/testing/selftests/bpf/prog_tests/usdt.c | 42 +++++++++++++++++++
 .../selftests/bpf/progs/test_urandom_usdt.c   | 24 +++++++++++
 tools/testing/selftests/bpf/test_progs.c      |  7 ++++
 7 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be94833d390a..e642e4b8a726 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2223,6 +2223,7 @@ extern const struct bpf_func_proto bpf_find_vma_pro=
to;
 extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_strncmp_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
+extern const struct bpf_func_proto bpf_get_reg_val_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0de7d6b3af5b..cb81142a751a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1300,7 +1300,7 @@ BPF_CALL_5(get_reg_val, void *, dst, u32, size,
 BTF_ID_LIST(bpf_get_reg_val_ids)
 BTF_ID(struct, pt_regs)
=20
-static const struct bpf_func_proto bpf_get_reg_val_proto =3D {
+const struct bpf_func_proto bpf_get_reg_val_proto =3D {
 	.func	=3D get_reg_val,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
index d0e54e30658a..1f3933cd8aa6 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -171,7 +171,20 @@ static int bpf_dummy_ops_btf_struct_access(struct bp=
f_verifier_log *log,
 	return atype =3D=3D BPF_READ ? err : NOT_INIT;
 }
=20
+static const struct bpf_func_proto *
+bpf_dummy_ops_get_func_proto(enum bpf_func_id func_id,
+			     const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_reg_val:
+		return &bpf_get_reg_val_proto;
+	default:
+		return bpf_base_func_proto(func_id);
+	}
+}
+
 static const struct bpf_verifier_ops bpf_dummy_verifier_ops =3D {
+	.get_func_proto =3D bpf_dummy_ops_get_func_proto,
 	.is_valid_access =3D bpf_dummy_ops_is_valid_access,
 	.btf_struct_access =3D bpf_dummy_ops_btf_struct_access,
 };
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index e585e1cefc77..b2b35138b097 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <asm/fpu/api.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -25,6 +26,13 @@ bpf_testmod_test_mod_kfunc(int i)
 	*(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) =3D i;
 }
=20
+noinline void
+bpf_testmod_save_fpregs(void)
+{
+	kernel_fpu_begin();
+	kernel_fpu_end();
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -150,6 +158,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file=
 __ro_after_init =3D {
=20
 BTF_SET_START(bpf_testmod_check_kfunc_ids)
 BTF_ID(func, bpf_testmod_test_mod_kfunc)
+BTF_ID(func, bpf_testmod_save_fpregs)
 BTF_SET_END(bpf_testmod_check_kfunc_ids)
=20
 static const struct btf_kfunc_id_set bpf_testmod_kfunc_set =3D {
@@ -166,6 +175,10 @@ static int bpf_testmod_init(void)
 	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod=
_kfunc_set);
 	if (ret < 0)
 		return ret;
+	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmo=
d_kfunc_set);
+	if (ret < 0)
+		return ret;
+
 	if (bpf_fentry_test1(0) < 0)
 		return -EINVAL;
 	return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
index f98749ac74a7..3866cb004b22 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -8,6 +8,11 @@
 #include "test_usdt.skel.h"
 #include "test_urandom_usdt.skel.h"
=20
+/* Need to keep consistent with definition in include/linux/bpf.h */
+struct bpf_dummy_ops_state {
+	int val;
+};
+
 int lets_test_this(int);
=20
 static volatile int idx =3D 2;
@@ -415,6 +420,41 @@ static void subtest_urandom_usdt(bool auto_attach)
 	test_urandom_usdt__destroy(skel);
 }
=20
+static void subtest_reg_val_fpustate(void)
+{
+	struct bpf_dummy_ops_state in_state;
+	struct test_urandom_usdt__bss *bss;
+	struct test_urandom_usdt *skel;
+	u64 in_args[1];
+	u64 regval[2];
+	int err, fd;
+
+	in_state.val =3D 0; /* unused */
+	in_args[0] =3D (unsigned long)&in_state;
+
+	LIBBPF_OPTS(bpf_test_run_opts, attr,
+		   .ctx_in =3D in_args,
+		   .ctx_size_in =3D sizeof(in_args),
+	);
+
+	skel =3D test_urandom_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+	bss =3D skel->bss;
+
+	fd =3D bpf_program__fd(skel->progs.save_fpregs_and_read);
+	regval[0] =3D 42;
+	regval[1] =3D 0;
+	asm("movdqa %0, %%xmm10" : "=3Dm"(*(char *)regval));
+
+	err =3D bpf_prog_test_run_opts(fd, &attr);
+	ASSERT_OK(err, "save_fpregs_and_read");
+	ASSERT_EQ(bss->fpregs_dummy_opts_xmm_val, 42, "fpregs_dummy_opts_xmm_va=
l");
+
+	close(fd);
+	test_urandom_usdt__destroy(skel);
+}
+
 void test_usdt(void)
 {
 	if (test__start_subtest("basic"))
@@ -425,4 +465,6 @@ void test_usdt(void)
 		subtest_urandom_usdt(true /* auto_attach */);
 	if (test__start_subtest("urand_pid_attach"))
 		subtest_urandom_usdt(false /* auto_attach */);
+	if (test__start_subtest("bpf_get_reg_val_fpustate"))
+		subtest_reg_val_fpustate();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_urandom_usdt.c b/tool=
s/testing/selftests/bpf/progs/test_urandom_usdt.c
index 575761863eb6..2c8b6709606a 100644
--- a/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_urandom_usdt.c
@@ -67,6 +67,30 @@ int BPF_USDT(urandlib_read_with_sema, int iter_num, in=
t iter_cnt, int buf_sz)
 	return 0;
 }
=20
+extern void bpf_testmod_save_fpregs(void) __ksym;
+
+u64 fpregs_dummy_opts_xmm_val;
+
+SEC("struct_ops/save_fpregs_and_read")
+int BPF_PROG(save_fpregs_and_read, struct bpf_dummy_ops_state *unused)
+{
+	struct task_struct *tsk;
+	u64 val[2];
+
+	bpf_testmod_save_fpregs();
+	tsk =3D bpf_get_current_task_btf();
+
+	bpf_get_reg_val(&val[0], 16, (u64)BPF_GETREG_X86_XMM10 << 32, NULL, tsk=
);
+	__sync_fetch_and_add(&fpregs_dummy_opts_xmm_val, val[0]);
+
+	return 0;
+}
+
+SEC(".struct_ops")
+struct bpf_dummy_ops dummy_ops =3D {
+	.test_1 =3D (void *)save_fpregs_and_read,
+};
+
 int urandlib_xmm_reg_read_buf_sz_sum;
 SEC("usdt/./liburandom_read_xmm.so:urandlib:xmm_reg_read")
 int BPF_USDT(urandlib_xmm_reg_read, int *f1, int *f2, int *f3, int a, in=
t b,
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index a07da648af3b..27a3e8cb9c36 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -620,6 +620,9 @@ int kern_sync_rcu(void)
=20
 static void unload_bpf_testmod(void)
 {
+	bool tried_again =3D false;
+
+again:
 	if (kern_sync_rcu())
 		fprintf(env.stderr, "Failed to trigger kernel-side RCU sync!\n");
 	if (delete_module("bpf_testmod", 0)) {
@@ -627,6 +630,10 @@ static void unload_bpf_testmod(void)
 			if (verbose())
 				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
 			return;
+		} else if (errno =3D=3D EAGAIN && !tried_again) {
+			tried_again =3D true;
+			usleep(20 * 1000);
+			goto again;
 		}
 		fprintf(env.stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n=
", -errno);
 		return;
--=20
2.30.2

