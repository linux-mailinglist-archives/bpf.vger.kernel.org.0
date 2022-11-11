Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66E625FED
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 17:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiKKQ6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 11:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiKKQ6H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 11:58:07 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3B4AF34
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:06 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDIi0Y029692
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=aA1BFRM4JbMhczpDoBeM8bLUK6hZ5CpSkvQuV7BQA14=;
 b=DUxnF8a/shbZ+17g4MrtqTprBCrrMxffsgAvprJ5dlDelKPA+LjiJyHqUT/IDfZKgZuJ
 UKN3X0Zke0fmaAYWohZd4In3N74VIrMTlHUM+BDnFanzLjFJG2xHidTun1WFxTOZV+/T
 QZ2hGZyxIx1qhMEDx3+twEpPG9XVMxR2stI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ksq5rhbu7-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 08:58:05 -0800
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 08:58:03 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 606DB11FF3EB5; Fri, 11 Nov 2022 08:57:55 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 4/7] bpf: Add bpf_rcu_read_lock() verifier support
Date:   Fri, 11 Nov 2022 08:57:55 -0800
Message-ID: <20221111165755.2527531-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111165734.2524596-1-yhs@fb.com>
References: <20221111165734.2524596-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vOqiccg8vgWCz8HG0qJv25ICYcBtct5q
X-Proofpoint-ORIG-GUID: vOqiccg8vgWCz8HG0qJv25ICYcBtct5q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To simplify the design and support the common practice, no nested
bpf_rcu_read_lock() is allowed. A new bpf_type_flag MEM_RCU is added to
indicate a PTR_TO_BTF_ID object access needing rcu_read_lock protection.
Note that rcu protection is not needed for non-sleepable program, but
it is supported to make cross-sleepable/nonsleepable development easier.
For sleepable program, the following insns can be inside the rcu
lock region:
  - any non call insns except BPF_ABS/BPF_IND
  - non sleepable helpers or kfuncs
The rcu pointer will be invalidated at bpf_rcu_read_unlock() so it
cannot be used outside the current rcu read lock region.
Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
allocation flag) should be GFP_ATOMIC.

If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
this pointer and the load which gets this pointer needs to be
protected by bpf_rcu_read_lock(). The following shows a couple
of examples:
  struct task_struct {
        ...
        struct task_struct __rcu        *real_parent;
        struct css_set __rcu            *cgroups;
        ...
  };
  struct css_set {
        ...
        struct cgroup *dfl_cgrp;
        ...
  }
  ...
  task =3D bpf_get_current_task_btf();
  cgroups =3D task->cgroups;
  dfl_cgroup =3D cgroups->dfl_cgrp;
  ... using dfl_cgroup ...

The bpf_rcu_read_lock/unlock() should be added like below to
avoid verification failures.
  task =3D bpf_get_current_task_btf();
  bpf_rcu_read_lock();
  cgroups =3D task->cgroups;
  dfl_cgroup =3D cgroups->dfl_cgrp;
  bpf_rcu_read_unlock();
  ... using dfl_cgroup ...

The following is another example for task->real_parent.
  task =3D bpf_get_current_task_btf();
  bpf_rcu_read_lock();
  real_parent =3D task->real_parent;
  ... bpf_task_storage_get(&map, real_parent, 0, 0);
  bpf_rcu_read_unlock();

There is another case observed in selftest bpf_iter_ipv6_route.c:
  struct fib6_info *rt =3D ctx->rt;
  ...
  fib6_nh =3D &rt->fib6_nh[0]; // Not rcu protected
  ...
  if (rt->nh)
    fib6_nh =3D &nh->nh_info->fib6_nh; // rcu protected
  ...
  ... using fib6_nh ...
Note that the use of fib6_nh is tag with rcu in one path but not in the
other path. Current verification will fail since the same insn cannot
be used with different pointer types. The above use case is a valid
one so the verifier is changed to ignore MEM_RCU type tag
in such cases.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h          |   3 +
 include/linux/bpf_verifier.h |   4 ++
 kernel/bpf/btf.c             |  31 ++++++++-
 kernel/bpf/verifier.c        | 122 ++++++++++++++++++++++++++++++++---
 4 files changed, 149 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3ed817cf191d..f35bba8dc81c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -510,6 +510,9 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		=3D BIT(10 + BPF_BASE_TYPE_BITS),
=20
+	/* MEM is tagged with rcu and memory access needs rcu_read_lock protect=
ion. */
+	MEM_RCU			=3D BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a32baa78ce2..484baeffbfb0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -325,6 +325,7 @@ struct bpf_verifier_state {
 	u32 curframe;
 	u32 active_spin_lock;
 	bool speculative;
+	bool active_rcu_lock;
=20
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
@@ -424,6 +425,7 @@ struct bpf_insn_aux_data {
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt *=
/
 	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
 	bool zext_dst; /* this insn zero extends dst reg */
+	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory=
 alloc */
 	u8 alu_state; /* used in combination with alu_limit */
=20
 	/* below fields are initialized once */
@@ -627,6 +629,8 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab =
*tab);
=20
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
=20
+void clear_all_rcu_pointers(struct bpf_verifier_env *env);
+
 #define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS - 1, 0)
=20
 /* extract base type from bpf_{arg, return, reg}_type. */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 84f09235857c..17d22abf66e4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5850,6 +5850,9 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
 				/* check __percpu tag */
 				if (strcmp(tag_value, "percpu") =3D=3D 0)
 					tmp_flag =3D MEM_PERCPU;
+				/* check __rcu tag */
+				if (strcmp(tag_value, "rcu") =3D=3D 0)
+					tmp_flag =3D MEM_RCU;
 			}
=20
 			stype =3D btf_type_skip_modifiers(btf, mtype->type, &id);
@@ -6309,6 +6312,9 @@ static bool btf_is_kfunc_arg_mem_size(const struct =
btf *btf,
 	return true;
 }
=20
+BTF_ID_LIST_SINGLE(bpf_rcu_read_lock_id, func, bpf_rcu_read_lock)
+BTF_ID_LIST_SINGLE(bpf_rcu_read_unlock_id, func, bpf_rcu_read_unlock)
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
@@ -6318,7 +6324,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env,
 {
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
 	bool rel =3D false, kptr_get =3D false, trusted_args =3D false;
-	bool sleepable =3D false;
+	bool sleepable =3D false, rcu_lock =3D false, rcu_unlock =3D false;
 	struct bpf_verifier_log *log =3D &env->log;
 	u32 i, nargs, ref_id, ref_obj_id =3D 0;
 	bool is_kfunc =3D btf_is_kernel(btf);
@@ -6327,6 +6333,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env,
 	const struct btf_param *args;
 	int ref_regno =3D 0, ret;
=20
+
 	t =3D btf_type_by_id(btf, func_id);
 	if (!t || !btf_type_is_func(t)) {
 		/* These checks were already done by the verifier while loading
@@ -6357,6 +6364,28 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env,
 		kptr_get =3D kfunc_meta->flags & KF_KPTR_GET;
 		trusted_args =3D kfunc_meta->flags & KF_TRUSTED_ARGS;
 		sleepable =3D kfunc_meta->flags & KF_SLEEPABLE;
+		rcu_lock =3D func_id =3D=3D *bpf_rcu_read_lock_id;
+		rcu_unlock =3D func_id =3D=3D *bpf_rcu_read_unlock_id;
+	}
+
+	/* checking rcu read lock/unlock */
+	if (env->cur_state->active_rcu_lock) {
+		if (rcu_lock) {
+			bpf_log(log, "nested rcu read lock (kernel function %s)\n", func_name=
);
+			return -EINVAL;
+		} else if (rcu_unlock) {
+			clear_all_rcu_pointers(env);
+			env->cur_state->active_rcu_lock =3D false;
+		} else if (sleepable) {
+			bpf_log(log, "kernel func %s is sleepable within rcu_read_lock region=
\n",
+				func_name);
+			return -EINVAL;
+		}
+	} else if (rcu_lock) {
+		env->cur_state->active_rcu_lock =3D true;
+	} else if (rcu_unlock) {
+		bpf_log(log, "unmatched rcu read unlock (kernel function %s)\n", func_=
name);
+		return -EINVAL;
 	}
=20
 	/* check that BTF function arguments match actual types that the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3b75aa0c54d..2aa140dceb9a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23,6 +23,7 @@
 #include <linux/error-injection.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
+#include <linux/trace_events.h>
 #include <linux/poison.h>
=20
 #include "disasm.h"
@@ -513,6 +514,14 @@ static bool is_callback_calling_function(enum bpf_fu=
nc_id func_id)
 	       func_id =3D=3D BPF_FUNC_user_ringbuf_drain;
 }
=20
+static bool is_storage_get_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_sk_storage_get ||
+	       func_id =3D=3D BPF_FUNC_inode_storage_get ||
+	       func_id =3D=3D BPF_FUNC_task_storage_get ||
+	       func_id =3D=3D BPF_FUNC_cgrp_storage_get;
+}
+
 static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 					const struct bpf_map *map)
 {
@@ -583,6 +592,8 @@ static const char *reg_type_str(struct bpf_verifier_e=
nv *env,
 		strncpy(prefix, "user_", 32);
 	if (type & MEM_PERCPU)
 		strncpy(prefix, "percpu_", 32);
+	if (type & MEM_RCU)
+		strncpy(prefix, "rcu_", 32);
 	if (type & PTR_UNTRUSTED)
 		strncpy(prefix, "untrusted_", 32);
=20
@@ -1203,6 +1214,7 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
 	dst_state->speculative =3D src->speculative;
 	dst_state->curframe =3D src->curframe;
 	dst_state->active_spin_lock =3D src->active_spin_lock;
+	dst_state->active_rcu_lock =3D src->active_rcu_lock;
 	dst_state->branches =3D src->branches;
 	dst_state->parent =3D src->parent;
 	dst_state->first_insn_idx =3D src->first_insn_idx;
@@ -4682,6 +4694,14 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 		return -EACCES;
 	}
=20
+	if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
+	    !env->cur_state->active_rcu_lock) {
+		verbose(env,
+			"R%d is ptr_%s access rcu-protected memory with off=3D%d, not rcu pro=
tected\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access) {
 		ret =3D env->ops->btf_struct_access(&env->log, reg->btf, t,
 						  off, size, atype, &btf_id, &flag);
@@ -4698,6 +4718,16 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 	if (ret < 0)
 		return ret;
=20
+	/* The value is a rcu pointer. For a sleepable program, the load needs =
to be
+	 * in a rcu lock region, similar to rcu_dereference().
+	 */
+	if ((flag & MEM_RCU) && env->prog->aux->sleepable && !env->cur_state->a=
ctive_rcu_lock) {
+		verbose(env,
+			"R%d is rcu dereference ptr_%s with off=3D%d, not in rcu_read_lock re=
gion\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	/* If this is an untrusted pointer, all pointers formed by walking it
 	 * also inherit the untrusted flag.
 	 */
@@ -5800,7 +5830,12 @@ static const struct bpf_reg_types scalar_types =3D=
 { .types =3D { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types =3D { .types =3D { PTR_T=
O_CTX } };
 static const struct bpf_reg_types alloc_mem_types =3D { .types =3D { PTR=
_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types =3D { .types =3D {=
 CONST_PTR_TO_MAP } };
-static const struct bpf_reg_types btf_ptr_types =3D { .types =3D { PTR_T=
O_BTF_ID } };
+static const struct bpf_reg_types btf_ptr_types =3D {
+	.types =3D {
+		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | MEM_RCU,
+	}
+};
 static const struct bpf_reg_types spin_lock_types =3D { .types =3D { PTR=
_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types =3D { .types =3D =
{ PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types =3D { .types =3D { PTR_=
TO_FUNC } };
@@ -5874,6 +5909,20 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 	if (arg_type & PTR_MAYBE_NULL)
 		type &=3D ~PTR_MAYBE_NULL;
=20
+	/* If the reg type is marked as MEM_RCU, ensure the usage is in the rcu=
_read_lock
+	 * region, and remove MEM_RCU from the type since the arg_type won't en=
code
+	 * MEM_RCU.
+	 */
+	if (type & MEM_RCU) {
+		if (env->prog->aux->sleepable && !env->cur_state->active_rcu_lock) {
+			verbose(env,
+				"R%d is arg type %s needs rcu protection\n",
+				regno, reg_type_str(env, reg->type));
+			return -EACCES;
+		}
+		type &=3D ~MEM_RCU;
+	}
+
 	for (i =3D 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected =3D compatible->types[i];
 		if (expected =3D=3D NOT_INIT)
@@ -5890,7 +5939,8 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 	return -EACCES;
=20
 found:
-	if (reg->type =3D=3D PTR_TO_BTF_ID) {
+	/* reg is already protected by rcu_read_lock(). Peel off MEM_RCU from r=
eg->type. */
+	if ((reg->type & ~MEM_RCU) =3D=3D PTR_TO_BTF_ID) {
 		/* For bpf_sk_release, it needs to match against first member
 		 * 'struct sock_common', hence make an exception for it. This
 		 * allows bpf_sk_release to work for multiple socket types.
@@ -5966,6 +6016,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
@@ -6693,6 +6744,17 @@ static void clear_all_pkt_pointers(struct bpf_veri=
fier_env *env)
 	}));
 }
=20
+void clear_all_rcu_pointers(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+		if (reg->type & MEM_RCU)
+			__mark_reg_unknown(env, reg);
+	}));
+}
+
 enum {
 	AT_PKT_END =3D -1,
 	BEYOND_PKT_END =3D -2,
@@ -7418,6 +7480,18 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		return err;
 	}
=20
+	if (env->cur_state->active_rcu_lock) {
+		if (bpf_lsm_sleepable_func_proto(func_id) ||
+		    bpf_tracing_sleepable_func_proto(func_id)) {
+			verbose(env, "sleepable helper %s#%din rcu_read_lock region\n",
+				func_id_name(func_id), func_id);
+			return -EINVAL;
+		}
+
+		if (env->prog->aux->sleepable && is_storage_get_function(func_id))
+			env->insn_aux_data[insn_idx].storage_get_func_atomic =3D true;
+	}
+
 	meta.func_id =3D func_id;
 	/* check args */
 	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -10605,6 +10679,11 @@ static int check_ld_abs(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
 		return -EINVAL;
 	}
=20
+	if (env->prog->aux->sleepable && env->cur_state->active_rcu_lock) {
+		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_rcu_read_lock=
-ed region\n");
+		return -EINVAL;
+	}
+
 	if (regs[ctx_reg].type !=3D PTR_TO_CTX) {
 		verbose(env,
 			"at the time of BPF_LD_ABS|IND R6 !=3D pointer to skb\n");
@@ -11869,6 +11948,9 @@ static bool states_equal(struct bpf_verifier_env =
*env,
 	if (old->active_spin_lock !=3D cur->active_spin_lock)
 		return false;
=20
+	if (old->active_rcu_lock !=3D cur->active_rcu_lock)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -12282,6 +12364,11 @@ static bool reg_type_mismatch(enum bpf_reg_type =
src, enum bpf_reg_type prev)
 			       !reg_type_mismatch_ok(prev));
 }
=20
+static bool reg_type_mismatch_ignore_rcu(enum bpf_reg_type src, enum bpf=
_reg_type prev)
+{
+	return reg_type_mismatch(src & ~MEM_RCU, prev & ~MEM_RCU);
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
@@ -12407,6 +12494,17 @@ static int do_check(struct bpf_verifier_env *env=
)
=20
 			prev_src_type =3D &env->insn_aux_data[env->insn_idx].ptr_type;
=20
+			/* For code like below,
+			 *   struct foo *f;
+			 *   if (...)
+			 *     f =3D ...; // f with MEM_RCU type tag.
+			 *   else
+			 *     f =3D ...; // f without MEM_RCU type tag.
+			 *   ... f ...  // Here f could be with/without MEM_RCU
+			 *
+			 * It is safe to ignore MEM_RCU type tag here since
+			 * base types are the same.
+			 */
 			if (*prev_src_type =3D=3D NOT_INIT) {
 				/* saw a valid insn
 				 * dst_reg =3D *(u32 *)(src_reg + off)
@@ -12414,7 +12512,7 @@ static int do_check(struct bpf_verifier_env *env)
 				 */
 				*prev_src_type =3D src_reg_type;
=20
-			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
+			} else if (reg_type_mismatch_ignore_rcu(src_reg_type, *prev_src_type)=
) {
 				/* ABuser program is trying to use the same insn
 				 * dst_reg =3D *(u32*) (src_reg + off)
 				 * with different pointer types:
@@ -12553,6 +12651,11 @@ static int do_check(struct bpf_verifier_env *env=
)
 					return -EINVAL;
 				}
=20
+				if (env->cur_state->active_rcu_lock) {
+					verbose(env, "bpf_rcu_read_unlock is missing\n");
+					return -EINVAL;
+				}
+
 				/* We must do check_reference_leak here before
 				 * prepare_func_exit to handle the case when
 				 * state->curframe > 0, it may be a callback
@@ -13641,6 +13744,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		case PTR_TO_BTF_ID | MEM_RCU:
 			if (type =3D=3D BPF_READ) {
 				insn->code =3D BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
@@ -14289,14 +14393,12 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
 			goto patch_call_imm;
 		}
=20
-		if (insn->imm =3D=3D BPF_FUNC_task_storage_get ||
-		    insn->imm =3D=3D BPF_FUNC_sk_storage_get ||
-		    insn->imm =3D=3D BPF_FUNC_inode_storage_get ||
-		    insn->imm =3D=3D BPF_FUNC_cgrp_storage_get) {
-			if (env->prog->aux->sleepable)
-				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
-			else
+		if (is_storage_get_function(insn->imm)) {
+			if (!env->prog->aux->sleepable ||
+			    env->insn_aux_data[i + delta].storage_get_func_atomic)
 				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
+			else
+				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
 			insn_buf[1] =3D *insn;
 			cnt =3D 2;
=20
--=20
2.30.2

