Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1464187B
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 19:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLCSqO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 13:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLCSqN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 13:46:13 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1718B3E
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 10:46:06 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B3CuiTQ009529
        for <bpf@vger.kernel.org>; Sat, 3 Dec 2022 10:46:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ms8fphjeR3/WkU986ZaU/bo1TI/SbJ3v28t4ofQUu/8=;
 b=S+2YZz8uYUAxuwVzK44a84B99GZIt9B3M0ZE4mcWns7RBXyzRpbPqkdFtCxidyvyHH1z
 eCGh2egnauqEttvI62bH1cW3wDiXncZyO4x2o7CQt0y4/SldFwnj8eDhUlflJCyNgRW0
 Gk3PxZ+QyYfDHxf+2XPrE/M/i97M/rAlQYk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m84eyacsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 03 Dec 2022 10:46:06 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 10:46:05 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 898A81320E6A2; Sat,  3 Dec 2022 10:46:02 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/3] bpf: Handle MEM_RCU type properly
Date:   Sat, 3 Dec 2022 10:46:02 -0800
Message-ID: <20221203184602.477272-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221203184557.476871-1-yhs@fb.com>
References: <20221203184557.476871-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WbN-CXN2isfV5q6tg5JYFHwlIyn2n3hX
X-Proofpoint-GUID: WbN-CXN2isfV5q6tg5JYFHwlIyn2n3hX
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-03_10,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
introduced MEM_RCU and bpf_rcu_read_lock/unlock() support. In that
commit, a rcu pointer is tagged with both MEM_RCU and PTR_TRUSTED
so that it can be passed into kfuncs or helpers as an argument.

Martin raised a good question in [1] such that the rcu pointer,
although being able to accessing the object, might have reference
count of 0. This might cause a problem if the rcu pointer is passed
to a kfunc which expects trusted arguments where ref count should
be greater than 0.

This patch makes the following changes related to MEM_RCU pointer:
  - MEM_RCU pointer might be NULL (PTR_MAYBE_NULL).
  - Introduce KF_RCU so MEM_RCU ptr can be acquired with
    a KF_RCU tagged kfunc which assumes ref count of rcu ptr
    could be zero.
  - For mem access 'b =3D ptr->a', say 'ptr' is a MEM_RCU ptr, and
    'a' is tagged with __rcu as well. Let us mark 'b' as
    MEM_RCU | PTR_MAYBE_NULL.

 [1] https://lore.kernel.org/bpf/ac70f574-4023-664e-b711-e0d3b18117fd@linux=
.dev/

Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_verifier.h |  2 +-
 include/linux/btf.h          |  1 +
 kernel/bpf/helpers.c         | 14 +++++++++++
 kernel/bpf/verifier.c        | 45 +++++++++++++++++++++++++-----------
 4 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b5090e89cb3f..c07b351a5bc7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -682,7 +682,7 @@ static inline bool bpf_prog_check_recur(const struct bp=
f_prog *prog)
 	}
 }
=20
-#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | MEM_RCU | PTR_TRUSTED)
+#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
=20
 static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 {
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9ed00077db6e..cbd6e4096f8c 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -70,6 +70,7 @@
 #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer argum=
ents */
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
+#define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments=
 */
=20
 /*
  * Return the name of the passed struct, if exists, or halt the build if f=
or
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a5a511430f2a..cca642358e80 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1837,6 +1837,19 @@ struct task_struct *bpf_task_acquire(struct task_str=
uct *p)
 	return p;
 }
=20
+/**
+ * bpf_task_acquire_not_zero - Acquire a reference to a rcu task object. A=
 task
+ * acquired by this kfunc which is not stored in a map as a kptr, must be
+ * released by calling bpf_task_release().
+ * @p: The task on which a reference is being acquired.
+ */
+struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
+{
+	if (!refcount_inc_not_zero(&p->rcu_users))
+		return NULL;
+	return p;
+}
+
 /**
  * bpf_task_kptr_get - Acquire a reference on a struct task_struct kptr. A=
 task
  * kptr acquired by this kfunc which is not subsequently stored in a map, =
must
@@ -2013,6 +2026,7 @@ BTF_ID_FLAGS(func, bpf_list_push_back)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_acquire_not_zero, KF_ACQUIRE | KF_RCU | KF_RET=
_NULL)
 BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NU=
LL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 #ifdef CONFIG_CGROUPS
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b0db9c10567b..66b82f52b5bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4275,7 +4275,7 @@ static bool is_trusted_reg(const struct bpf_reg_state=
 *reg)
 		return true;
=20
 	/* If a register is not referenced, it is trusted if it has the
-	 * MEM_ALLOC, MEM_RCU or PTR_TRUSTED type modifiers, and no others. Some =
of the
+	 * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
 	 * other type modifiers may be safe, but we elect to take an opt-in
 	 * approach here as some (e.g. PTR_UNTRUSTED and PTR_MAYBE_NULL) are
 	 * not.
@@ -4287,6 +4287,11 @@ static bool is_trusted_reg(const struct bpf_reg_stat=
e *reg)
 	       !bpf_type_has_unsafe_modifiers(reg->type);
 }
=20
+static bool is_rcu_reg(const struct bpf_reg_state *reg)
+{
+	return reg->type & MEM_RCU;
+}
+
 static int check_pkt_ptr_alignment(struct bpf_verifier_env *env,
 				   const struct bpf_reg_state *reg,
 				   int off, int size, bool strict)
@@ -4785,14 +4790,16 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
=20
 	if (flag & MEM_RCU) {
 		/* Mark value register as MEM_RCU only if it is protected by
-		 * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
+		 * bpf_rcu_read_lock() and the ptr reg is rcu or trusted. MEM_RCU
 		 * itself can already indicate trustedness inside the rcu
-		 * read lock region. Also mark it as PTR_TRUSTED.
+		 * read lock region. Also mark rcu pointer as PTR_MAYBE_NULL since
+		 * it could be null in some cases.
 		 */
-		if (!env->cur_state->active_rcu_lock || !is_trusted_reg(reg))
+		if (!env->cur_state->active_rcu_lock ||
+		    !(is_trusted_reg(reg) || is_rcu_reg(reg)))
 			flag &=3D ~MEM_RCU;
 		else
-			flag |=3D PTR_TRUSTED;
+			flag |=3D PTR_MAYBE_NULL;
 	} else if (reg->type & MEM_RCU) {
 		/* ptr (reg) is marked as MEM_RCU, but the struct field is not tagged
 		 * with __rcu. Mark the flag as PTR_UNTRUSTED conservatively.
@@ -5957,7 +5964,7 @@ static const struct bpf_reg_types btf_ptr_types =3D {
 	.types =3D {
 		PTR_TO_BTF_ID,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
-		PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED,
+		PTR_TO_BTF_ID | MEM_RCU,
 	},
 };
 static const struct bpf_reg_types percpu_btf_ptr_types =3D {
@@ -6136,7 +6143,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *e=
nv,
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
-	case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
+	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
@@ -8038,6 +8045,11 @@ static bool is_kfunc_destructive(struct bpf_kfunc_ca=
ll_arg_meta *meta)
 	return meta->kfunc_flags & KF_DESTRUCTIVE;
 }
=20
+static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_RCU;
+}
+
 static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, in=
t arg)
 {
 	return arg =3D=3D 0 && (meta->kfunc_flags & KF_KPTR_GET);
@@ -8722,13 +8734,20 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-			if (!is_kfunc_trusted_args(meta))
+			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
 				break;
=20
 			if (!is_trusted_reg(reg)) {
-				verbose(env, "R%d must be referenced or trusted\n", regno);
-				return -EINVAL;
+				if (!is_kfunc_rcu(meta)) {
+					verbose(env, "R%d must be referenced or trusted\n", regno);
+					return -EINVAL;
+				}
+				if (!is_rcu_reg(reg)) {
+					verbose(env, "R%d must be a rcu pointer\n", regno);
+					return -EINVAL;
+				}
 			}
+
 			fallthrough;
 		case KF_ARG_PTR_TO_CTX:
 			/* Trusted arguments have the same offset checks as release arguments */
@@ -8839,7 +8858,7 @@ static int check_kfunc_args(struct bpf_verifier_env *=
env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
-			     bpf_type_has_unsafe_modifiers(reg->type)) &&
+			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) &&
 			    !reg2btf_ids[base_type(reg->type)]) {
 				verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
 				verbose(env, "expected %s or socket\n",
@@ -8954,7 +8973,7 @@ static int check_kfunc_call(struct bpf_verifier_env *=
env, struct bpf_insn *insn,
 		} else if (rcu_unlock) {
 			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 				if (reg->type & MEM_RCU) {
-					reg->type &=3D ~(MEM_RCU | PTR_TRUSTED);
+					reg->type &=3D ~(MEM_RCU | PTR_MAYBE_NULL);
 					reg->type |=3D PTR_UNTRUSTED;
 				}
 			}));
@@ -11294,7 +11313,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_st=
ate *state,
 				 bool is_null)
 {
 	if (type_may_be_null(reg->type) && reg->id =3D=3D id &&
-	    !WARN_ON_ONCE(!reg->id)) {
+	    (is_rcu_reg(reg) || !WARN_ON_ONCE(!reg->id))) {
 		/* Old offset (both fixed and variable parts) should have been
 		 * known-zero, because we don't allow pointer arithmetic on
 		 * pointers that might be NULL. If we see this happening, don't
--=20
2.30.2

