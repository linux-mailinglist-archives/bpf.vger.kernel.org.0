Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E326F632A4B
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 18:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKURFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 12:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKURFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 12:05:37 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A78C8C93
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:36 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALCSF69015990
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Xshkg9kV5a0R9n5QcK2kyQnRPkBrADl5KAxXHNaeW6w=;
 b=o7gO7/ir053UrrHolG5QbD7dbLnKV1NYgtI/IApuq4boP+qcWbasMK+eLhTxCybTD35G
 FPenUi/3l2KMlB+wBJOrJrLk1qshTkAjdSVF/jqCOx1rsjXCM1IVQn7KlFpHnhTp3QVR
 fBWOhMJ0p65JCs4Al+puMi9lDEuBQdpg2YA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxw4xx8da-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:05:35 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 09:05:34 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id E7E9F1282A5B8; Mon, 21 Nov 2022 09:05:30 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Date:   Mon, 21 Nov 2022 09:05:30 -0800
Message-ID: <20221121170530.1196341-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221121170515.1193967-1-yhs@fb.com>
References: <20221121170515.1193967-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _4Eh75WfXTCyouMfwD0xSnbJVWfcKnHJ
X-Proofpoint-ORIG-GUID: _4Eh75WfXTCyouMfwD0xSnbJVWfcKnHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
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
    region.  this is to simulate rcu_dereference() operation.
  - 'last_wakee =3D real_parent->last_wakee' should be iinside bpf_rcu_re=
ad_lock
    region since it tries to access rcu protected memory.
  - the ptr 'last_wakee' will be marked as PTR_UNTRUSTED since in general
    it is not clear whether the object pointed by 'last_wakee' is valid o=
r
    not even inside bpf_rcu_read_lock region.

Note that for non-sleepable progs, it is permitted that rcu pointer load
and accessing rcu protected memory can be outside rcu read lock region.
But verification will be reported for sleepable progs.

To prevent rcu pointer leaks outside the rcu read lock region.
The verifier will clear all rcu pointer register state to unknown, i.e.,
scalar_value, so later dereference becomes impossible.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h          |   3 +
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/btf.c             |   3 +
 kernel/bpf/helpers.c         |  12 +++
 kernel/bpf/verifier.c        | 156 ++++++++++++++++++++++++++++++++---
 5 files changed, 165 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c9eafa67f2a2..d0fbb7f0f13b 100644
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
index 545152ac136c..748431578902 100644
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
index 9e8a5557ea8d..3268be36a319 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1889,6 +1889,16 @@ void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__=
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
@@ -1919,6 +1929,8 @@ BTF_ID(func, bpf_task_release)
 BTF_SET8_START(common_btf_ids)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
 BTF_ID_FLAGS(func, bpf_rdonly_cast)
+BTF_ID_FLAGS(func, bpf_rcu_read_lock)
+BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
 BTF_SET8_END(common_btf_ids)
=20
 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9528a066cfa5..d39ab0e969dd 100644
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
@@ -527,6 +528,14 @@ static bool is_callback_calling_function(enum bpf_fu=
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
@@ -589,11 +598,12 @@ static const char *reg_type_str(struct bpf_verifier=
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
@@ -1220,6 +1230,7 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
 		dst_state->frame[i] =3D NULL;
 	}
 	dst_state->speculative =3D src->speculative;
+	dst_state->active_rcu_lock =3D src->active_rcu_lock;
 	dst_state->curframe =3D src->curframe;
 	dst_state->active_lock.ptr =3D src->active_lock.ptr;
 	dst_state->active_lock.id =3D src->active_lock.id;
@@ -4704,6 +4715,15 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 		return -EACCES;
 	}
=20
+	/* Access rcu protected memory */
+	if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
+	    !env->cur_state->active_rcu_lock) {
+		verbose(env,
+			"R%d is ptr_%s access rcu-protected memory with off=3D%d, not rcu pro=
tected\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
 		if (!btf_is_kernel(reg->btf)) {
 			verbose(env, "verifier internal error: reg->btf must be kernel btf\n"=
);
@@ -4731,12 +4751,27 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
 	if (ret < 0)
 		return ret;
=20
+	/* The value is a rcu pointer. The load needs to be in a rcu lock regio=
n,
+	 * similar to rcu_dereference().
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
 	if (type_flag(reg->type) & PTR_UNTRUSTED)
 		flag |=3D PTR_UNTRUSTED;
=20
+	/* Mark the pointee of the rcu protected memory access as PTR_UNTRUSTED=
 */
+	if (env->cur_state->active_rcu_lock && !(flag & PTR_UNTRUSTED) &&
+	    (reg->type & MEM_RCU) && !(flag & MEM_RCU))
+		flag |=3D PTR_UNTRUSTED;
+
 	/* Any pointer obtained from walking a trusted pointer is no longer tru=
sted. */
 	flag &=3D ~PTR_TRUSTED;
=20
@@ -5896,6 +5931,7 @@ static const struct bpf_reg_types const_map_ptr_typ=
es =3D { .types =3D { CONST_PTR_T
 static const struct bpf_reg_types btf_ptr_types =3D {
 	.types =3D {
 		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | MEM_RCU,
 		PTR_TO_BTF_ID | PTR_TRUSTED,
 	},
 };
@@ -5976,6 +6012,20 @@ static int check_reg_type(struct bpf_verifier_env =
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
@@ -5992,7 +6042,8 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 	return -EACCES;
=20
 found:
-	if (reg->type =3D=3D PTR_TO_BTF_ID || reg->type & PTR_TRUSTED) {
+	/* reg is already protected by rcu_read_lock(). Peel off MEM_RCU from r=
eg->type. */
+	if ((reg->type & ~MEM_RCU) =3D=3D PTR_TO_BTF_ID || reg->type & PTR_TRUS=
TED) {
 		/* For bpf_sk_release, it needs to match against first member
 		 * 'struct sock_common', hence make an exception for it. This
 		 * allows bpf_sk_release to work for multiple socket types.
@@ -6073,6 +6124,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
@@ -7534,6 +7586,18 @@ static int check_helper_call(struct bpf_verifier_e=
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
@@ -8158,6 +8222,8 @@ enum special_kfunc_type {
 	KF_bpf_list_pop_back,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
+	KF_bpf_rcu_read_lock,
+	KF_bpf_rcu_read_unlock,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -8180,6 +8246,18 @@ BTF_ID(func, bpf_list_pop_front)
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
@@ -8812,6 +8890,7 @@ static int check_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	const struct btf_type *t, *func, *func_proto, *ptr_type;
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	const char *func_name, *ptr_type_name;
+	bool sleepable, rcu_lock, rcu_unlock;
 	struct bpf_kfunc_call_arg_meta meta;
 	u32 i, nargs, func_id, ptr_type_id;
 	int err, insn_idx =3D *insn_idx_p;
@@ -8853,11 +8932,38 @@ static int check_kfunc_call(struct bpf_verifier_e=
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
@@ -11749,6 +11855,11 @@ static int check_ld_abs(struct bpf_verifier_env =
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
@@ -13014,6 +13125,9 @@ static bool states_equal(struct bpf_verifier_env =
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
@@ -13427,6 +13541,11 @@ static bool reg_type_mismatch(enum bpf_reg_type =
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
@@ -13552,6 +13671,17 @@ static int do_check(struct bpf_verifier_env *env=
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
@@ -13559,7 +13689,7 @@ static int do_check(struct bpf_verifier_env *env)
 				 */
 				*prev_src_type =3D src_reg_type;
=20
-			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
+			} else if (reg_type_mismatch_ignore_rcu(src_reg_type, *prev_src_type)=
) {
 				/* ABuser program is trying to use the same insn
 				 * dst_reg =3D *(u32*) (src_reg + off)
 				 * with different pointer types:
@@ -13701,6 +13831,11 @@ static int do_check(struct bpf_verifier_env *env=
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
@@ -14795,6 +14930,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
 			convert_ctx_access =3D bpf_xdp_sock_convert_ctx_access;
 			break;
 		case PTR_TO_BTF_ID:
+		case PTR_TO_BTF_ID | MEM_RCU:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 		case PTR_TO_BTF_ID | PTR_TRUSTED:
 		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
@@ -15489,14 +15625,12 @@ static int do_misc_fixups(struct bpf_verifier_e=
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

