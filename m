Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250DA5A6B4A
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiH3Rw7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiH3Rwn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:52:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE02A9C38
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:49:19 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UFrVfi007679
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TPNw2gPY2Pxjdru4n0HetYVA0UxIqST4v7qkVNdkt9E=;
 b=iJMeQo+IMZ3aLt8OE2B+VMfEKe3BSbFv/53LjLDs5PNoS8X/3pFcAsFj8yOjVW/gnROL
 FqdKBOH6zO+nxY5nDBjynME4mrE6mEGf6zAvqxufhzF+g7DUa2bo92D7OVIdqGnpTPlE
 4oLQ/3GNl7zkJSkj+xkRc61kXuROGEmPZ1A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9yk9df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:15 -0700
Received: from twshared10711.09.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:35:14 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 5F1B3CAD0781; Tue, 30 Aug 2022 10:28:10 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 10/18] bpf: Verifier tracking of rbtree_spin_lock held
Date:   Tue, 30 Aug 2022 10:27:51 -0700
Message-ID: <20220830172759.4069786-11-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ebW7U4wkAjWabDPwk_GD9Ne9aMa0bLPq
X-Proofpoint-GUID: ebW7U4wkAjWabDPwk_GD9Ne9aMa0bLPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch teaches the verifier that rbtree_{lock,unlock} interact with
locks and eases use of rbtree_lock(&some_lock) where &some_lock is in a
global internal map.

The verifier now tracks lock id for rbtree_{lock,unlock} and understands
that lock can / must be held when calling various other rbtree helpers.

Logic is also added to ease this pattern:

  /* internal map */
  struct bpf_spin_lock lock SEC(".bss.private");

  /* In bpf prog */

  rbtree_lock(&lock);
  /* ... use all registers for other work */
  rbtree_unlock(&lock);

In the above example, the prog compiles down to something like:

  r1 =3D 0x12345
  call rbtree_lock
  /* begin other work
  r1 =3D some_unrelated_value
  r2 =3D r1 or similar never happens
  */
  r1 =3D 0x12345
  call rbtree_unlock

Each time "r1 =3D 0x12345" happens, verifier's check_ld_imm will assign a
new id to the lock, which will result in it later complaining that
the incorrect lock is being unlocked when checking rbtree_unlock.

To help with this pattern, bpf_verifier_state now has a
maybe_active_spin_lock_addr field. If this field is nonzero and
bpf_verifier_state's active_spin_lock is also nonzero, then
maybe_active_spin_lock_addr contains the address of the active spin lock
(corresponding to active_spin_lock's id). This allows the verifier to
avoid assigning a new lock id when it sees the second "r1 =3D 0x12345",
since it can recognize that the address matches an existing lock id.

[ RFC Notes:

  * rbtree_process_spin_lock should be merged w/ normal
    process_spin_lock, same with rbtree_lock and normal lock helpers.
    Left separate for now to highlight the logic differences.

  * The hacky maybe_active_spin_lock_addr logic can be improved by
    adding support to a custom .lock section similar to existing use of
    .bss.private. The new section type would function like .bss.private,
    but the verifier would know that locks in .lock are likely to be
    used like bpf_spin_lock(&lock), and could track the address of each
    map value for deduping, instead of just tracking single address. For
    multiple-lock scenario this is probably necessary.
]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h          |   2 +
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/rbtree.c          |   2 +-
 kernel/bpf/verifier.c        | 136 ++++++++++++++++++++++++++++++++---
 4 files changed, 129 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4a44ffb0d6c..d6458aa7b79c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -497,6 +497,7 @@ enum bpf_return_type {
 	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated me=
mory */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a b=
tf_id */
 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
+	RET_PTR_TO_SPIN_LOCK,		/* returns a pointer to a struct bpf_spin_lock *=
/
 	__BPF_RET_TYPE_MAX,
=20
 	/* Extended ret_types. */
@@ -612,6 +613,7 @@ enum bpf_reg_type {
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
+	PTR_TO_SPIN_LOCK,	 /* reg points to a struct bpf_spin_lock */
 	__BPF_REG_TYPE_MAX,
=20
 	/* Extended reg_types. */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9c017575c034..f81638844a4d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -313,6 +313,7 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;
 	u32 active_spin_lock;
+	void *maybe_active_spin_lock_addr;
 	bool speculative;
=20
 	/* first and last insn idx of this verifier state */
diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index c61662822511..0821e841a518 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -305,7 +305,7 @@ BPF_CALL_1(bpf_rbtree_get_lock, struct bpf_map *, map=
)
 const struct bpf_func_proto bpf_rbtree_get_lock_proto =3D {
 	.func =3D bpf_rbtree_get_lock,
 	.gpl_only =3D true,
-	.ret_type =3D RET_PTR_TO_MAP_VALUE,
+	.ret_type =3D RET_PTR_TO_SPIN_LOCK,
 	.arg1_type =3D ARG_CONST_MAP_PTR,
 };
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9e5d87fe323..f8ba381f1327 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -452,8 +452,9 @@ static bool reg_type_not_null(enum bpf_reg_type type)
=20
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return reg->type =3D=3D PTR_TO_MAP_VALUE &&
-		map_value_has_spin_lock(reg->map_ptr);
+	return (reg->type =3D=3D PTR_TO_MAP_VALUE &&
+		map_value_has_spin_lock(reg->map_ptr)) ||
+		reg->type =3D=3D PTR_TO_SPIN_LOCK;
 }
=20
 static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
@@ -507,6 +508,34 @@ static bool is_ptr_cast_function(enum bpf_func_id fu=
nc_id)
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
 }
=20
+/* These functions can only be called when spinlock associated with rbtr=
ee
+ * is held. If they have a callback argument, that callback is not requi=
red
+ * to release active_spin_lock before exiting
+ */
+static bool is_rbtree_lock_required_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_rbtree_add ||
+		func_id =3D=3D BPF_FUNC_rbtree_remove ||
+		func_id =3D=3D BPF_FUNC_rbtree_find ||
+		func_id =3D=3D BPF_FUNC_rbtree_unlock;
+}
+
+/* These functions are OK to call when spinlock associated with rbtree
+ * is held.
+ */
+static bool is_rbtree_lock_ok_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_rbtree_alloc_node ||
+		func_id =3D=3D BPF_FUNC_rbtree_free_node ||
+		is_rbtree_lock_required_function(func_id);
+}
+
+static bool is_lock_allowed_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_spin_unlock ||
+		is_rbtree_lock_ok_function(func_id);
+}
+
 static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 {
 	return func_id =3D=3D BPF_FUNC_dynptr_data;
@@ -579,6 +608,7 @@ static const char *reg_type_str(struct bpf_verifier_e=
nv *env,
 		[PTR_TO_BUF]		=3D "buf",
 		[PTR_TO_FUNC]		=3D "func",
 		[PTR_TO_MAP_KEY]	=3D "map_key",
+		[PTR_TO_SPIN_LOCK]	=3D "spin_lock",
 	};
=20
 	if (type & PTR_MAYBE_NULL) {
@@ -1199,6 +1229,7 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
 	dst_state->speculative =3D src->speculative;
 	dst_state->curframe =3D src->curframe;
 	dst_state->active_spin_lock =3D src->active_spin_lock;
+	dst_state->maybe_active_spin_lock_addr =3D src->maybe_active_spin_lock_=
addr;
 	dst_state->branches =3D src->branches;
 	dst_state->parent =3D src->parent;
 	dst_state->first_insn_idx =3D src->first_insn_idx;
@@ -5471,6 +5502,35 @@ static int process_spin_lock(struct bpf_verifier_e=
nv *env, int regno,
 			return -EINVAL;
 		}
 		cur->active_spin_lock =3D 0;
+		cur->maybe_active_spin_lock_addr =3D 0;
+	}
+	return 0;
+}
+
+static int rbtree_process_spin_lock(struct bpf_verifier_env *env, int re=
gno,
+				    bool is_lock)
+{
+	struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno];
+	struct bpf_verifier_state *cur =3D env->cur_state;
+
+	if (is_lock) {
+		if (cur->active_spin_lock) {
+			verbose(env,
+				"Locking two bpf_spin_locks are not allowed\n");
+			return -EINVAL;
+		}
+		cur->active_spin_lock =3D reg->id;
+	} else {
+		if (!cur->active_spin_lock) {
+			verbose(env, "rbtree_spin_unlock without taking a lock\n");
+			return -EINVAL;
+		}
+		if (cur->active_spin_lock !=3D reg->id) {
+			verbose(env, "rbtree_spin_unlock of different lock\n");
+			return -EINVAL;
+		}
+		cur->active_spin_lock =3D 0;
+		cur->maybe_active_spin_lock_addr =3D 0;
 	}
 	return 0;
 }
@@ -5686,12 +5746,18 @@ static const struct bpf_reg_types int_ptr_types =3D=
 {
 	},
 };
=20
+static const struct bpf_reg_types spin_lock_types =3D {
+	.types =3D {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_SPIN_LOCK
+	},
+};
+
 static const struct bpf_reg_types fullsock_types =3D { .types =3D { PTR_=
TO_SOCKET } };
 static const struct bpf_reg_types scalar_types =3D { .types =3D { SCALAR=
_VALUE } };
 static const struct bpf_reg_types context_types =3D { .types =3D { PTR_T=
O_CTX } };
 static const struct bpf_reg_types alloc_mem_types =3D { .types =3D { PTR=
_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types =3D { .types =3D {=
 CONST_PTR_TO_MAP } };
-static const struct bpf_reg_types btf_ptr_types =3D { .types =3D { PTR_T=
O_BTF_ID } };
 static const struct bpf_reg_types spin_lock_types =3D { .types =3D { PTR=
_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types =3D { .types =3D =
{ PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types =3D { .types =3D { PTR_=
TO_FUNC } };
@@ -6057,8 +6123,12 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 		} else if (meta->func_id =3D=3D BPF_FUNC_spin_unlock) {
 			if (process_spin_lock(env, regno, false))
 				return -EACCES;
-		} else if (meta->func_id =3D=3D BPF_FUNC_rbtree_lock ||
-			   meta->func_id =3D=3D BPF_FUNC_rbtree_unlock) { // Do nothing for n=
ow
+		} else if (meta->func_id =3D=3D BPF_FUNC_rbtree_lock) {
+			if (rbtree_process_spin_lock(env, regno, true))
+				return -EACCES;
+		} else if (meta->func_id =3D=3D BPF_FUNC_rbtree_unlock) {
+			if (rbtree_process_spin_lock(env, regno, false))
+				return -EACCES;
 		} else {
 			verbose(env, "verifier internal error\n");
 			return -EFAULT;
@@ -6993,6 +7063,29 @@ static int set_find_vma_callback_state(struct bpf_=
verifier_env *env,
 	return 0;
 }
=20
+/* Are we currently verifying the callback for a rbtree helper that must
+ * be called with lock held? If so, no need to complain about unreleased
+ * lock
+ */
+static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_insn *insn =3D env->prog->insnsi;
+	struct bpf_func_state *callee;
+	int func_id;
+
+	if (!state->curframe)
+		return false;
+
+	callee =3D state->frame[state->curframe];
+
+	if (!callee->in_callback_fn)
+		return false;
+
+	func_id =3D insn[callee->callsite].imm;
+	return is_rbtree_lock_required_function(func_id);
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
@@ -7508,6 +7601,11 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			regs[BPF_REG_0].id =3D ++env->id_gen;
 		}
 		break;
+	case RET_PTR_TO_SPIN_LOCK:
+		mark_reg_known_zero(env, regs, BPF_REG_0);
+		regs[BPF_REG_0].type =3D PTR_TO_SPIN_LOCK | ret_flag;
+		regs[BPF_REG_0].id =3D ++env->id_gen;
+		break;
 	case RET_PTR_TO_SOCKET:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_SOCKET | ret_flag;
@@ -10366,6 +10464,20 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
 	return 0;
 }
=20
+static unsigned int ld_imm_lock_id_gen(struct bpf_verifier_env *env,
+					     void *imm)
+{
+	struct bpf_verifier_state *cur =3D env->cur_state;
+
+	if (cur->active_spin_lock && cur->maybe_active_spin_lock_addr &&
+	    cur->maybe_active_spin_lock_addr =3D=3D imm)
+		return cur->active_spin_lock;
+
+	if (!cur->active_spin_lock)
+		cur->maybe_active_spin_lock_addr =3D imm;
+	return ++env->id_gen;
+}
+
 /* verify BPF_LD_IMM64 instruction */
 static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *i=
nsn)
 {
@@ -10373,6 +10485,7 @@ static int check_ld_imm(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	struct bpf_reg_state *dst_reg;
 	struct bpf_map *map;
+	u64 imm;
 	int err;
=20
 	if (BPF_SIZE(insn->code) !=3D BPF_DW) {
@@ -10390,7 +10503,7 @@ static int check_ld_imm(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
=20
 	dst_reg =3D &regs[insn->dst_reg];
 	if (insn->src_reg =3D=3D 0) {
-		u64 imm =3D ((u64)(insn + 1)->imm << 32) | (u32)insn->imm;
+		imm =3D ((u64)(insn + 1)->imm << 32) | (u32)insn->imm;
=20
 		dst_reg->type =3D SCALAR_VALUE;
 		__mark_reg_known(&regs[insn->dst_reg], imm);
@@ -10441,13 +10554,14 @@ static int check_ld_imm(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
=20
 	map =3D env->used_maps[aux->map_index];
 	dst_reg->map_ptr =3D map;
-
 	if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
 	    insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE) {
 		dst_reg->type =3D PTR_TO_MAP_VALUE;
 		dst_reg->off =3D aux->map_off;
-		if (map_value_has_spin_lock(map))
-			dst_reg->id =3D ++env->id_gen;
+		if (map_value_has_spin_lock(map)) {
+			imm =3D ((u64)(insn + 1)->imm << 32) | (u32)insn->imm;
+			dst_reg->id =3D ld_imm_lock_id_gen(env, (void *)imm);
+		}
 	} else if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type =3D CONST_PTR_TO_MAP;
@@ -12432,7 +12546,7 @@ static int do_check(struct bpf_verifier_env *env)
=20
 				if (env->cur_state->active_spin_lock &&
 				    (insn->src_reg =3D=3D BPF_PSEUDO_CALL ||
-				     insn->imm !=3D BPF_FUNC_spin_unlock)) {
+				     !is_lock_allowed_function(insn->imm))) {
 					verbose(env, "function calls are not allowed while holding a lock\n=
");
 					return -EINVAL;
 				}
@@ -12467,7 +12581,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
=20
-				if (env->cur_state->active_spin_lock) {
+				if (state->active_spin_lock && !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
--=20
2.30.2

