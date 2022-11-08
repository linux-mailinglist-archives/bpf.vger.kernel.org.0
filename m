Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3882E620A85
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiKHHmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiKHHle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E474F1A21A
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:41:26 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A85pqVg028007
        for <bpf@vger.kernel.org>; Mon, 7 Nov 2022 23:41:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wcfnRN/3dkIgtpsGQgxMUD9FM/rMXJlzKsVeIxlwS2s=;
 b=WoArbqg1SvSAf2idkPNpHcOgToZhZQTzUKeeC9HVvx8WAwylSoLGpEefzbVnCrGLiKuR
 68zimvU2PUlZeFlnPYL+kh2V/3gtji6YEBPtaP1MEXerfJOQdNfm0ZNEqrFqY/B7JI4K
 +X7qLpKl7u15tbQx1Y5imCCA2X3/x+VOPhE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqhb78hca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:41:26 -0800
Received: from twshared6758.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 23:41:25 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id C92B111D233E6; Mon,  7 Nov 2022 23:41:14 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 5/8] bpf: Add bpf_rcu_read_lock() verifier support
Date:   Mon, 7 Nov 2022 23:41:14 -0800
Message-ID: <20221108074114.264485-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108074047.261848-1-yhs@fb.com>
References: <20221108074047.261848-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nA-mpSmp06jd1YUMTzxdABf5dHMd1ben
X-Proofpoint-GUID: nA-mpSmp06jd1YUMTzxdABf5dHMd1ben
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To simplify the design and support the common practice, no
nested bpf_rcu_read_lock() is allowed. During verification,
each paired bpf_rcu_read_lock()/unlock() has a unique
region id, starting from 1. Each rcu ptr register also
remembers the region id when the ptr reg is initialized.
The following is a simple example to illustrate the
rcu lock regions and usage of rcu ptr's.

     ...                    <=3D=3D=3D rcu lock region 0
     bpf_rcu_read_lock()    <=3D=3D=3D rcu lock region 1
     rcu_ptr1 =3D ...         <=3D=3D=3D rcu_ptr1 with region 1
     ... using rcu_ptr1 ...
     bpf_rcu_read_unlock()
     ...                    <=3D=3D=3D rcu lock region -1
     bpf_rcu_read_lock()    <=3D=3D=3D rcu lock region 2
     rcu_ptr2 =3D ...         <=3D=3D=3D rcu_ptr2 with region 2
     ... using rcu_ptr2 ...
     ... using rcu_ptr1 ... <=3D=3D=3D wrong, region 1 rcu_ptr in region =
2
     bpf_rcu_read_unlock()

Outside the rcu lock region, the rcu lock region id is 0 or negative of
previous valid rcu lock region id, so the next valid rcu lock region
id can be easily computed.

Note that rcu protection is not needed for non-sleepable program. But
it is supported to make cross-sleepable/nonsleepable development easier.
For non-sleepable program, the following insns can be inside the rcu
lock region:
  - any non call insns except BPF_ABS/BPF_IND
  - non sleepable helpers or kfuncs
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

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  7 +++
 kernel/bpf/btf.c             | 32 ++++++++++++-
 kernel/bpf/verifier.c        | 92 +++++++++++++++++++++++++++++++-----
 4 files changed, 120 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4bbcafd1c9b..98af0c9ec721 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -761,6 +761,7 @@ struct bpf_prog_ops {
 struct btf_struct_access_info {
 	u32 next_btf_id;
 	enum bpf_type_flag flag;
+	bool is_rcu;
 };
=20
 struct bpf_verifier_ops {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a32baa78ce2..5d703637bb12 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -179,6 +179,10 @@ struct bpf_reg_state {
 	 */
 	s32 subreg_def;
 	enum bpf_reg_liveness live;
+	/* 0: not rcu ptr; > 0: rcu ptr, id of the rcu read lock region where
+	 * the rcu ptr reg is initialized.
+	 */
+	int active_rcu_lock;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
 };
@@ -324,6 +328,8 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;
 	u32 active_spin_lock;
+	/* <=3D 0: not in rcu read lock region; > 0: the rcu lock region id */
+	int active_rcu_lock;
 	bool speculative;
=20
 	/* first and last insn idx of this verifier state */
@@ -424,6 +430,7 @@ struct bpf_insn_aux_data {
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
index d2ee1669a2f3..c5a9569f2ae0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5831,6 +5831,7 @@ static int btf_struct_walk(struct bpf_verifier_log =
*log, const struct btf *btf,
 		if (btf_type_is_ptr(mtype)) {
 			const struct btf_type *stype, *t;
 			enum bpf_type_flag tmp_flag =3D 0;
+			bool is_rcu =3D false;
 			u32 id;
=20
 			if (msize !=3D size || off !=3D moff) {
@@ -5850,12 +5851,16 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
 				/* check __percpu tag */
 				if (strcmp(tag_value, "percpu") =3D=3D 0)
 					tmp_flag =3D MEM_PERCPU;
+				/* check __rcu tag */
+				if (strcmp(tag_value, "rcu") =3D=3D 0)
+					is_rcu =3D true;
 			}
=20
 			stype =3D btf_type_skip_modifiers(btf, mtype->type, &id);
 			if (btf_type_is_struct(stype)) {
 				info->next_btf_id =3D id;
 				info->flag =3D tmp_flag;
+				info->is_rcu =3D is_rcu;
 				return WALK_PTR;
 			}
 		}
@@ -6317,7 +6322,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env,
 {
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
 	bool rel =3D false, kptr_get =3D false, trusted_args =3D false;
-	bool sleepable =3D false;
+	bool sleepable =3D false, rcu_lock =3D false, rcu_unlock =3D false;
 	struct bpf_verifier_log *log =3D &env->log;
 	u32 i, nargs, ref_id, ref_obj_id =3D 0;
 	bool is_kfunc =3D btf_is_kernel(btf);
@@ -6356,6 +6361,31 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env,
 		kptr_get =3D kfunc_meta->flags & KF_KPTR_GET;
 		trusted_args =3D kfunc_meta->flags & KF_TRUSTED_ARGS;
 		sleepable =3D kfunc_meta->flags & KF_SLEEPABLE;
+		rcu_lock =3D kfunc_meta->flags & KF_RCU_LOCK;
+		rcu_unlock =3D kfunc_meta->flags & KF_RCU_UNLOCK;
+	}
+
+	/* checking rcu read lock/unlock */
+	if (env->cur_state->active_rcu_lock > 0) {
+		if (rcu_lock) {
+			bpf_log(log, "nested rcu read lock (kernel function %s)\n", func_name=
);
+			return -EINVAL;
+		} else if (rcu_unlock) {
+			/* change active_rcu_lock to its corresponding negative value to
+			 * preserve the previous lock region id.
+			 */
+			env->cur_state->active_rcu_lock =3D -env->cur_state->active_rcu_lock;
+		} else if (sleepable) {
+			bpf_log(log, "kernel func %s is sleepable within rcu_read_lock region=
\n",
+				func_name);
+			return -EINVAL;
+		}
+	} else if (rcu_lock) {
+		/* a new lock region started, increase the region id. */
+		env->cur_state->active_rcu_lock =3D (-env->cur_state->active_rcu_lock)=
 + 1;
+	} else if (rcu_unlock) {
+		bpf_log(log, "unmatched rcu read unlock (kernel function %s)\n", func_=
name);
+		return -EINVAL;
 	}
=20
 	/* check that BTF function arguments match actual types that the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4d50f9568245..85151f2a655a 100644
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
@@ -1203,6 +1212,7 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
 	dst_state->speculative =3D src->speculative;
 	dst_state->curframe =3D src->curframe;
 	dst_state->active_spin_lock =3D src->active_spin_lock;
+	dst_state->active_rcu_lock =3D src->active_rcu_lock;
 	dst_state->branches =3D src->branches;
 	dst_state->parent =3D src->parent;
 	dst_state->first_insn_idx =3D src->first_insn_idx;
@@ -1687,6 +1697,7 @@ static void __mark_reg_unknown(const struct bpf_ver=
ifier_env *env,
 	reg->var_off =3D tnum_unknown;
 	reg->frameno =3D 0;
 	reg->precise =3D !env->bpf_capable;
+	reg->active_rcu_lock =3D 0;
 	__mark_reg_unbounded(reg);
 }
=20
@@ -1727,7 +1738,7 @@ static void mark_btf_ld_reg(struct bpf_verifier_env=
 *env,
 			    struct bpf_reg_state *regs, u32 regno,
 			    enum bpf_reg_type reg_type,
 			    struct btf *btf, u32 btf_id,
-			    enum bpf_type_flag flag)
+			    enum bpf_type_flag flag, bool set_rcu_lock)
 {
 	if (reg_type =3D=3D SCALAR_VALUE) {
 		mark_reg_unknown(env, regs, regno);
@@ -1737,6 +1748,9 @@ static void mark_btf_ld_reg(struct bpf_verifier_env=
 *env,
 	regs[regno].type =3D PTR_TO_BTF_ID | flag;
 	regs[regno].btf =3D btf;
 	regs[regno].btf_id =3D btf_id;
+	/* the reg rcu lock region id equals the current rcu lock region id */
+	if (set_rcu_lock)
+		regs[regno].active_rcu_lock =3D env->cur_state->active_rcu_lock;
 }
=20
 #define DEF_NOT_SUBREG	(0)
@@ -3940,7 +3954,7 @@ static int check_map_kptr_access(struct bpf_verifie=
r_env *env, u32 regno,
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, kptr_f=
ield->kptr.btf,
-				kptr_field->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
+				kptr_field->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED, false);
 		/* For mark_ptr_or_null_reg */
 		val_reg->id =3D ++env->id_gen;
 	} else if (class =3D=3D BPF_STX) {
@@ -4681,6 +4695,18 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 		return -EACCES;
 	}
=20
+	/* If reg valid rcu region id does not equal to the current rcu region =
id,
+	 * rcu access is not protected properly, either out of a valid rcu regi=
on,
+	 * or in a different rcu region.
+	 */
+	if (env->prog->aux->sleepable && reg->active_rcu_lock &&
+	    reg->active_rcu_lock !=3D env->cur_state->active_rcu_lock) {
+		verbose(env,
+			"R%d is ptr_%s access rcu-protected memory with off=3D%d, not rcu pro=
tected\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access) {
 		ret =3D env->ops->btf_struct_access(&env->log, reg->btf, t,
 						  off, size, atype, &info);
@@ -4697,6 +4723,16 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 	if (ret < 0)
 		return ret;
=20
+	/* The value is a rcu pointer. For a sleepable program, the load needs =
to be
+	 * in a rcu lock region, similar to rcu_dereference().
+	 */
+	if (info.is_rcu && env->prog->aux->sleepable && env->cur_state->active_=
rcu_lock <=3D 0) {
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
@@ -4705,7 +4741,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
=20
 	if (atype =3D=3D BPF_READ && value_regno >=3D 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, info.next_btf_i=
d,
-				info.flag);
+				info.flag, info.is_rcu && env->prog->aux->sleepable);
=20
 	return 0;
 }
@@ -4761,7 +4797,7 @@ static int check_ptr_to_map_access(struct bpf_verif=
ier_env *env,
=20
 	if (value_regno >=3D 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, info.next_bt=
f_id,
-				info.flag);
+				info.flag, info.is_rcu && env->prog->aux->sleepable);
=20
 	return 0;
 }
@@ -5874,6 +5910,17 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 	if (arg_type & PTR_MAYBE_NULL)
 		type &=3D ~PTR_MAYBE_NULL;
=20
+	/* If a rcu pointer is a helper argument, the helper should be protecte=
d in
+	 * the same rcu lock region where the rcu pointer reg is initialized.
+	 */
+	if (env->prog->aux->sleepable && reg->active_rcu_lock &&
+	    reg->active_rcu_lock !=3D env->cur_state->active_rcu_lock) {
+		verbose(env,
+			"R%d is arg type %s needs rcu protection\n",
+			regno, reg_type_str(env, reg->type));
+		return -EACCES;
+	}
+
 	for (i =3D 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected =3D compatible->types[i];
 		if (expected =3D=3D NOT_INIT)
@@ -7418,6 +7465,18 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		return err;
 	}
=20
+	if (env->cur_state->active_rcu_lock > 0) {
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
@@ -10605,6 +10664,11 @@ static int check_ld_abs(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
 		return -EINVAL;
 	}
=20
+	if (env->prog->aux->sleepable && env->cur_state->active_rcu_lock > 0) {
+		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_rcu_read_lock=
-ed region\n");
+		return -EINVAL;
+	}
+
 	if (regs[ctx_reg].type !=3D PTR_TO_CTX) {
 		verbose(env,
 			"at the time of BPF_LD_ABS|IND R6 !=3D pointer to skb\n");
@@ -11869,6 +11933,9 @@ static bool states_equal(struct bpf_verifier_env =
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
@@ -12553,6 +12620,11 @@ static int do_check(struct bpf_verifier_env *env=
)
 					return -EINVAL;
 				}
=20
+				if (env->cur_state->active_rcu_lock > 0) {
+					verbose(env, "bpf_rcu_read_unlock is missing\n");
+					return -EINVAL;
+				}
+
 				/* We must do check_reference_leak here before
 				 * prepare_func_exit to handle the case when
 				 * state->curframe > 0, it may be a callback
@@ -14289,14 +14361,12 @@ static int do_misc_fixups(struct bpf_verifier_e=
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

