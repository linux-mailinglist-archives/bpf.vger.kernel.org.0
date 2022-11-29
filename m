Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6B63B812
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 03:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiK2Che (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 21:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiK2ChY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 21:37:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A049084
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 18:37:22 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASI0fdY027694
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 18:37:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=xgIbOe6/GoZhvC5kbcwZcKVSi0aZGByad4jU7qxQdz8=;
 b=I/Idpk8lHl0YkWlAtFzQcDKEZobcZxkZpjK4cK8qJcAA35UDUQjvkzopab3H0DH9Wo7h
 7M5LbdYY3r/IXWj7Ok1Ya8lspNqUVAhVHLkorOQgVleF2/4G7o5e1dWJq/koSEzq4qMu
 ihN8W1DsPK8Oax8T94P48mMk2G2qQ0HIKtc= 
Received: from maileast.thefacebook.com ([163.114.130.8])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m4yjhwc3f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 18:37:22 -0800
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 18:37:20 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B8D9F12E44F34; Mon, 28 Nov 2022 18:37:13 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] bpf: Handle MEM_RCU type properly
Date:   Mon, 28 Nov 2022 18:37:13 -0800
Message-ID: <20221129023713.2216451-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MJ9RJAubtAK77ZbJL39Jc67JGsxA0wlM
X-Proofpoint-GUID: MJ9RJAubtAK77ZbJL39Jc67JGsxA0wlM
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_02,2022-11-28_02,2022-06-22_01
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

So this patch tries to fix this problem by tagging rcu pointer with
MEM_RCU only. Special acquire functions are needed to try to
acquire a reference with the consideration that the original rcu
pointer ref count could be 0. This special acquire function's
argument needs to be KF_RCU, a new introduced kfunc flag. In
verifier, KF_RCU will require the actual argument register type
to be MEM_RCU.

 [1] https://lore.kernel.org/bpf/ac70f574-4023-664e-b711-e0d3b18117fd@linux=
.dev/

Fixes: 9bb00b2895cb ("bpf: Add kfunc bpf_rcu_read_lock/unlock()")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_verifier.h                  |  2 +-
 include/linux/btf.h                           |  1 +
 kernel/bpf/helpers.c                          | 14 ++++++++
 kernel/bpf/verifier.c                         | 36 +++++++++++++------
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     |  4 +--
 .../selftests/bpf/prog_tests/task_kfunc.c     |  4 +--
 .../selftests/bpf/progs/rcu_read_lock.c       |  7 ++--
 7 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c05aa6e1f6f5..6f192dd9025e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -683,7 +683,7 @@ static inline bool bpf_prog_check_recur(const struct bp=
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
index a5a511430f2a..46fbe027f3b6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1837,6 +1837,19 @@ struct task_struct *bpf_task_acquire(struct task_str=
uct *p)
 	return p;
 }
=20
+/**
+ * bpf_task_acquire_rcu - Acquire a reference to a rcu task object. A task
+ * acquired by this kfunc which is not stored in a map as a kptr, must be
+ * released by calling bpf_task_release().
+ * @p: The task on which a reference is being acquired or NULL.
+ */
+struct task_struct *bpf_task_acquire_rcu(struct task_struct *p)
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
+BTF_ID_FLAGS(func, bpf_task_acquire_rcu, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NU=
LL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 #ifdef CONFIG_CGROUPS
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6599d25dae38..dda89f4d62a7 100644
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
@@ -4775,12 +4780,10 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 		/* Mark value register as MEM_RCU only if it is protected by
 		 * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
 		 * itself can already indicate trustedness inside the rcu
-		 * read lock region. Also mark it as PTR_TRUSTED.
+		 * read lock region.
 		 */
 		if (!env->cur_state->active_rcu_lock || !is_trusted_reg(reg))
 			flag &=3D ~MEM_RCU;
-		else
-			flag |=3D PTR_TRUSTED;
 	} else if (reg->type & MEM_RCU) {
 		/* ptr (reg) is marked as MEM_RCU, but the struct field is not tagged
 		 * with __rcu. Mark the flag as PTR_UNTRUSTED conservatively.
@@ -5945,7 +5948,7 @@ static const struct bpf_reg_types btf_ptr_types =3D {
 	.types =3D {
 		PTR_TO_BTF_ID,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
-		PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED,
+		PTR_TO_BTF_ID | MEM_RCU,
 	},
 };
 static const struct bpf_reg_types percpu_btf_ptr_types =3D {
@@ -6124,7 +6127,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *e=
nv,
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
-	case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
+	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
@@ -8022,6 +8025,11 @@ static bool is_kfunc_destructive(struct bpf_kfunc_ca=
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
@@ -8706,13 +8714,19 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-			if (!is_kfunc_trusted_args(meta))
+			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
 				break;
=20
-			if (!is_trusted_reg(reg)) {
-				verbose(env, "R%d must be referenced or trusted\n", regno);
+			if (!is_trusted_reg(reg) && !is_rcu_reg(reg)) {
+				verbose(env, "R%d must be referenced, trusted or rcu\n", regno);
 				return -EINVAL;
 			}
+
+			if (is_kfunc_rcu(meta) !=3D is_rcu_reg(reg)) {
+				verbose(env, "R%d does not match kf arg rcu tagging\n", regno);
+				return -EINVAL;
+			}
+
 			fallthrough;
 		case KF_ARG_PTR_TO_CTX:
 			/* Trusted arguments have the same offset checks as release arguments */
@@ -8823,7 +8837,7 @@ static int check_kfunc_args(struct bpf_verifier_env *=
env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
-			     bpf_type_has_unsafe_modifiers(reg->type)) &&
+			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) &&
 			    !reg2btf_ids[base_type(reg->type)]) {
 				verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
 				verbose(env, "expected %s or socket\n",
@@ -8938,7 +8952,7 @@ static int check_kfunc_call(struct bpf_verifier_env *=
env, struct bpf_insn *insn,
 		} else if (rcu_unlock) {
 			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 				if (reg->type & MEM_RCU) {
-					reg->type &=3D ~(MEM_RCU | PTR_TRUSTED);
+					reg->type &=3D ~MEM_RCU;
 					reg->type |=3D PTR_UNTRUSTED;
 				}
 			}));
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/te=
sting/selftests/bpf/prog_tests/cgrp_kfunc.c
index 973f0c5af965..5fbd9edd2c4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -93,10 +93,10 @@ static struct {
 	const char *prog_name;
 	const char *expected_err_msg;
 } failure_tests[] =3D {
-	{"cgrp_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
+	{"cgrp_kfunc_acquire_untrusted", "R1 must be referenced, trusted or rcu"},
 	{"cgrp_kfunc_acquire_fp", "arg#0 pointer type STRUCT cgroup must point"},
 	{"cgrp_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 f=
unction"},
-	{"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
+	{"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced, trusted or =
rcu"},
 	{"cgrp_kfunc_acquire_null", "arg#0 pointer type STRUCT cgroup must point"=
},
 	{"cgrp_kfunc_acquire_unreleased", "Unreleased reference"},
 	{"cgrp_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/te=
sting/selftests/bpf/prog_tests/task_kfunc.c
index ffd8ef4303c8..80708c073de6 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -87,10 +87,10 @@ static struct {
 	const char *prog_name;
 	const char *expected_err_msg;
 } failure_tests[] =3D {
-	{"task_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
+	{"task_kfunc_acquire_untrusted", "R1 must be referenced, trusted or rcu"},
 	{"task_kfunc_acquire_fp", "arg#0 pointer type STRUCT task_struct must poi=
nt"},
 	{"task_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 f=
unction"},
-	{"task_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
+	{"task_kfunc_acquire_trusted_walked", "R1 must be referenced, trusted or =
rcu"},
 	{"task_kfunc_acquire_null", "arg#0 pointer type STRUCT task_struct must p=
oint"},
 	{"task_kfunc_acquire_unreleased", "Unreleased reference"},
 	{"task_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/test=
ing/selftests/bpf/progs/rcu_read_lock.c
index 94a970076b98..3035cd080ec4 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -23,7 +23,7 @@ struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 f=
lags) __ksym;
 void bpf_key_put(struct bpf_key *key) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
-struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+struct task_struct *bpf_task_acquire_rcu(struct task_struct *p) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
=20
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
@@ -135,8 +135,11 @@ int task_acquire(void *ctx)
 	bpf_rcu_read_lock();
 	real_parent =3D task->real_parent;
 	/* acquire a reference which can be used outside rcu read lock region */
-	real_parent =3D bpf_task_acquire(real_parent);
+	real_parent =3D bpf_task_acquire_rcu(real_parent);
 	bpf_rcu_read_unlock();
+	if (!real_parent)
+		return 0;
+
 	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
 	bpf_task_release(real_parent);
 	return 0;
--=20
2.30.2

