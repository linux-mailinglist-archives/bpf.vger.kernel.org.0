Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58EC6344EB
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 20:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiKVTyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiKVTxz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 14:53:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB7A65BF
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 11:53:48 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AMFnGFZ007147
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 11:53:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=z5beRJNC4u9L3yoP2/U2JMdtdqnV4S4sCI9zJqE6F3o=;
 b=rb1XZJgHjzQuMldh34YFN95lf9B9EsNcjhPBGQ3aqI7xpu0cs9f0EoEFoSiSrU6h/QcN
 hi7iHs4PYbLFr/9cR22HHdeY7Lbt3OdNvyoCS6xrk6f2sVPcG7Sj3bGy517yD1q7u1KM
 ++r7gp2Bqz5xxsdYYIIcKyL8iOz3z9ufhPU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3m0kkdpvn1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 11:53:48 -0800
Received: from twshared7043.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:53:47 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5BA7B12918C29; Tue, 22 Nov 2022 11:53:35 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v8 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Date:   Tue, 22 Nov 2022 11:53:35 -0800
Message-ID: <20221122195335.1782147-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221122195319.1778570-1-yhs@fb.com>
References: <20221122195319.1778570-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s6yyCUHShfAdAJKLLFWxShqdFlm11llA
X-Proofpoint-GUID: s6yyCUHShfAdAJKLLFWxShqdFlm11llA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two kfunc's bpf_rcu_read_lock() and bpf_rcu_read_unlock(). These two =
kfunc's
can be used for all program types. The following is an example about how
rcu pointer are used w.r.t. bpf_rcu_read_lock()/bpf_rcu_read_unlock().

  struct task_struct {
    ...
    struct task_struct              *last_wakee;
    struct task_struct __rcu        *real_parent;
    ...
  };

Let us say prog does 'task =3D bpf_get_current_task_btf()' to get a
'task' pointer. The basic rules are:
  - 'real_parent =3D task->real_parent' should be inside bpf_rcu_read_loc=
k
    region.  this is to simulate rcu_dereference() operation. The
    'real_parent' is marked as MEM_RCU only if (1). task->real_parent is
    inside bpf_rcu_read_lock region, and (2). task is a trusted ptr,
    marked with PTR_TRUSTED or ref_obj_id !=3D 0. In other words,
    MEM_RCU marked ptr can be 'trusted' inside the bpf_rcu_read_lock regi=
on.
  - 'last_wakee =3D real_parent->last_wakee' should be inside bpf_rcu_rea=
d_lock
    region since it tries to access rcu protected memory.
  - the ptr 'last_wakee' will be marked as PTR_UNTRUSTED since in general
    it is not clear whether the object pointed by 'last_wakee' is valid o=
r
    not even inside bpf_rcu_read_lock region.

To prevent rcu pointer leaks outside the rcu read lock region.
The verifier will clear all rcu pointer register state to unknown, i.e.,
scalar_value, at bpf_rcu_read_unlock() kfunc call site,
so later dereference becomes impossible.

The current implementation does not support nested rcu read lock
region in the prog.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h          |   3 +
 include/linux/bpf_verifier.h |   4 +-
 kernel/bpf/btf.c             |   3 +
 kernel/bpf/helpers.c         |  12 ++++
 kernel/bpf/verifier.c        | 118 ++++++++++++++++++++++++++++++++---
 5 files changed, 129 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 43fd7eeeeabb..c6aa6912ea16 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -572,6 +572,9 @@ enum bpf_type_flag {
 	 */
 	PTR_TRUSTED		=3D BIT(12 + BPF_BASE_TYPE_BITS),
=20
+	/* MEM is tagged with rcu and memory access needs rcu_read_lock protect=
ion. */
+	MEM_RCU			=3D BIT(13 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 545152ac136c..1f3ce54e50ed 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -344,6 +344,7 @@ struct bpf_verifier_state {
 		u32 id;
 	} active_lock;
 	bool speculative;
+	bool active_rcu_lock;
=20
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
@@ -445,6 +446,7 @@ struct bpf_insn_aux_data {
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt *=
/
 	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
 	bool zext_dst; /* this insn zero extends dst reg */
+	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory=
 alloc */
 	u8 alu_state; /* used in combination with alu_limit */
=20
 	/* below fields are initialized once */
@@ -680,7 +682,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
 	}
 }
=20
-#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
+#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | MEM_RCU | PTR_TRUSTED)
=20
 static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1a59cc7ad730..68df0df27302 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6237,6 +6237,9 @@ static int btf_struct_walk(struct bpf_verifier_log =
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
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c3b798a1e3e9..3c5b41604c7b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1891,6 +1891,16 @@ void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__=
k)
 	return obj__ign;
 }
=20
+void bpf_rcu_read_lock(void)
+{
+	rcu_read_lock();
+}
+
+void bpf_rcu_read_unlock(void)
+{
+	rcu_read_unlock();
+}
+
 __diag_pop();
=20
 BTF_SET8_START(generic_btf_ids)
@@ -1921,6 +1931,8 @@ BTF_ID(func, bpf_task_release)
 BTF_SET8_START(common_btf_ids)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
 BTF_ID_FLAGS(func, bpf_rdonly_cast)
+BTF_ID_FLAGS(func, bpf_rcu_read_lock)
+BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_SET8_END(common_btf_ids)
=20
 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 068cc885903c..f6105723d6ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -527,6 +527,14 @@ static bool is_callback_calling_function(enum bpf_fu=
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
@@ -589,11 +597,12 @@ static const char *reg_type_str(struct bpf_verifier=
_env *env,
 			strncpy(postfix, "_or_null", 16);
 	}
=20
-	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s",
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
 		 type & MEM_RDONLY ? "rdonly_" : "",
 		 type & MEM_RINGBUF ? "ringbuf_" : "",
 		 type & MEM_USER ? "user_" : "",
 		 type & MEM_PERCPU ? "percpu_" : "",
+		 type & MEM_RCU ? "rcu_" : "",
 		 type & PTR_UNTRUSTED ? "untrusted_" : "",
 		 type & PTR_TRUSTED ? "trusted_" : ""
 	);
@@ -1220,6 +1229,7 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
 		dst_state->frame[i] =3D NULL;
 	}
 	dst_state->speculative =3D src->speculative;
+	dst_state->active_rcu_lock =3D src->active_rcu_lock;
 	dst_state->curframe =3D src->curframe;
 	dst_state->active_lock.ptr =3D src->active_lock.ptr;
 	dst_state->active_lock.id =3D src->active_lock.id;
@@ -4737,9 +4747,30 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 	if (type_flag(reg->type) & PTR_UNTRUSTED)
 		flag |=3D PTR_UNTRUSTED;
=20
-	/* Any pointer obtained from walking a trusted pointer is no longer tru=
sted. */
+	/* By default any pointer obtained from walking a trusted pointer is
+	 * no longer trusted except the rcu case below.
+	 */
 	flag &=3D ~PTR_TRUSTED;
=20
+	if (flag & MEM_RCU) {
+		/* Mark value register as MEM_RCU only if it is protected by
+		 * bpf_rcu_read_lock() and the ptr reg is trusted (PTR_TRUSTED or
+		 * ref_obj_id !=3D 0). MEM_RCU itself can already indicate
+		 * trustedness inside the rcu read lock region. But Mark it
+		 * as PTR_TRUSTED as well similar to MEM_ALLOC.
+		 */
+		if (!env->cur_state->active_rcu_lock ||
+		    (!(reg->type & PTR_TRUSTED) && !reg->ref_obj_id))
+			flag &=3D ~MEM_RCU;
+		else
+			flag |=3D PTR_TRUSTED;
+	} else if (reg->type & MEM_RCU) {
+		/* ptr (reg) is marked as MEM_RCU, but value reg is not marked as MEM_=
RCU.
+		 * Mark the value reg as PTR_UNTRUSTED conservatively.
+		 */
+		flag |=3D PTR_UNTRUSTED;
+	}
+
 	if (atype =3D=3D BPF_READ && value_regno >=3D 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
=20
@@ -5897,6 +5928,7 @@ static const struct bpf_reg_types btf_ptr_types =3D=
 {
 	.types =3D {
 		PTR_TO_BTF_ID,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
+		PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED,
 	},
 };
 static const struct bpf_reg_types percpu_btf_ptr_types =3D {
@@ -6075,6 +6107,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
+	case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
@@ -7539,6 +7572,17 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		return err;
 	}
=20
+	if (env->cur_state->active_rcu_lock) {
+		if (fn->might_sleep) {
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
@@ -8163,6 +8207,8 @@ enum special_kfunc_type {
 	KF_bpf_list_pop_back,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
+	KF_bpf_rcu_read_lock,
+	KF_bpf_rcu_read_unlock,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -8185,6 +8231,18 @@ BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
+BTF_ID(func, bpf_rcu_read_lock)
+BTF_ID(func, bpf_rcu_read_unlock)
+
+static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *m=
eta)
+{
+	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_rcu_read_lock];
+}
+
+static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta =
*meta)
+{
+	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_rcu_read_unlock];
+}
=20
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
@@ -8817,6 +8875,7 @@ static int check_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	const struct btf_type *t, *func, *func_proto, *ptr_type;
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	const char *func_name, *ptr_type_name;
+	bool sleepable, rcu_lock, rcu_unlock;
 	struct bpf_kfunc_call_arg_meta meta;
 	u32 i, nargs, func_id, ptr_type_id;
 	int err, insn_idx =3D *insn_idx_p;
@@ -8858,11 +8917,38 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
=20
-	if (is_kfunc_sleepable(&meta) && !env->prog->aux->sleepable) {
+	sleepable =3D is_kfunc_sleepable(&meta);
+	if (sleepable && !env->prog->aux->sleepable) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n",=
 func_name);
 		return -EACCES;
 	}
=20
+	rcu_lock =3D is_kfunc_bpf_rcu_read_lock(&meta);
+	rcu_unlock =3D is_kfunc_bpf_rcu_read_unlock(&meta);
+	if (env->cur_state->active_rcu_lock) {
+		struct bpf_func_state *state;
+		struct bpf_reg_state *reg;
+
+		if (rcu_lock) {
+			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name=
);
+			return -EINVAL;
+		} else if (rcu_unlock) {
+			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+				if (reg->type & MEM_RCU)
+					__mark_reg_unknown(env, reg);
+			}));
+			env->cur_state->active_rcu_lock =3D false;
+		} else if (sleepable) {
+			verbose(env, "kernel func %s is sleepable within rcu_read_lock region=
\n", func_name);
+			return -EACCES;
+		}
+	} else if (rcu_lock) {
+		env->cur_state->active_rcu_lock =3D true;
+	} else if (rcu_unlock) {
+		verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_=
name);
+		return -EINVAL;
+	}
+
 	/* Check the arguments */
 	err =3D check_kfunc_args(env, &meta);
 	if (err < 0)
@@ -11754,6 +11840,11 @@ static int check_ld_abs(struct bpf_verifier_env =
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
@@ -13019,6 +13110,9 @@ static bool states_equal(struct bpf_verifier_env =
*env,
 	    old->active_lock.id !=3D cur->active_lock.id)
 		return false;
=20
+	if (old->active_rcu_lock !=3D cur->active_rcu_lock)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -13706,6 +13800,11 @@ static int do_check(struct bpf_verifier_env *env=
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
@@ -14802,6 +14901,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 		case PTR_TO_BTF_ID | PTR_TRUSTED:
+		case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
 		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
 		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
 		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
@@ -15494,14 +15594,12 @@ static int do_misc_fixups(struct bpf_verifier_e=
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

