Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60357E69D
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiGVSfO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbiGVSfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422DB1CA
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:10 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MHu43L003229
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=EZUgqNntwmRMvAGD1nbOqMdiHHe+FBcGIfNMuR3ugLk=;
 b=JuX3sEVXgdZ4XaCv05dubBattM1PKfyuZER4f1dROlXxE5aGgcy6VlWJij0DmlZWVDWt
 CpLG4gn3VmcG4Nx+CvpcVums9oZS11SABoNNeG0w5d7K2U7gmiLbTfxRGh1QSlWjgI+G
 vG/0JkBALQ0OBs41E9GZwNGQqTGoZQ+7orI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hg0qp87jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:09 -0700
Received: from twshared1866.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:35:08 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 3FE93AB6F1A8; Fri, 22 Jul 2022 11:34:51 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 09/11] bpf: Add CONDITIONAL_RELEASE type flag
Date:   Fri, 22 Jul 2022 11:34:36 -0700
Message-ID: <20220722183438.3319790-10-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VrT7hGowEHTA2RIAJ0aJ1Yf-MrCb0CwC
X-Proofpoint-GUID: VrT7hGowEHTA2RIAJ0aJ1Yf-MrCb0CwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently if a helper proto has an arg with OBJ_RELEASE flag, the verifie=
r
assumes the 'release' logic in the helper will always succeed, and
therefore always clears the arg reg, other regs w/ same
ref_obj_id, and releases the reference. This poses a problem for
'release' helpers which may not always succeed.

For example, bpf_rbtree_add will fail to add the passed-in node to a
bpf_rbtree if the rbtree's lock is not held when the helper is called.
In this case the helper returns NULL and the calling bpf program must
release the node in another way before terminating to avoid leaking
memory. An example of such logic:

1  struct node_data *node =3D bpf_rbtree_alloc_node(&rbtree, ...);
2  struct node_data *ret =3D bpf_rbtree_add(&rbtree, node);
3  if (!ret) {
4    bpf_rbtree_free_node(node);
5    return 0;
6  }
7  bpf_trace_printk("%d\n", ret->id);

However, current verifier logic does not allow this: after line 2,
ref_obj_id of reg holding 'node' (BPF_REG_2) will be released via
release_reference function, which will mark BPF_REG_2 and any other reg
with same ref_obj_id as unknown. As a result neither ret nor node will
point to anything useful if line 3's check passes. Additionally, since th=
e
reference is unconditionally released, the program would pass the
verifier without the null check.

This patch adds 'conditional release' semantics so that the verifier can
handle the above example correctly. The CONDITIONAL_RELEASE type flag
works in concert with the existing OBJ_RELEASE flag - the latter is used
to tag an argument, while the new type flag is used to tag return type.

If a helper has an OBJ_RELEASE arg type and CONDITIONAL_RELEASE return
type, the helper is considered to use its return value to indicate
success or failure of the release operation. NULL is returned if release
fails, non-null otherwise.

For my concrete usecase - bpf_rbtree_add - CONDITIONAL_RELEASE works in
concert with OBJ_NON_OWNING_REF: successful release results in a non-owni=
ng
reference being returned, allowing line 7 in above example.

Instead of unconditionally releasing the OBJ_RELEASE reference when
doing check_helper_call, for CONDITIONAL_RELEASE helpers the verifier
will wait until the return value is checked for null.
  If not null: the reference is released

  If null: no reference is released. Since other regs w/ same ref_obj_id
           were not marked unknown by check_helper_call, they can be
           used to release the reference via other means (line 4 above),

It's necessary to prevent conditionally-released ref_obj_id regs from
being used between the release helper and null check. For example:

1  struct node_data *node =3D bpf_rbtree_alloc_node(&rbtree, ...);
2  struct node_data *ret =3D bpf_rbtree_add(&rbtree, node);
3  do_something_with_a_node(node);
4  if (!ret) {
5    bpf_rbtree_free_node(node);
6    return 0;
7  }

Line 3 shouldn't be allowed since node may have been released. The
verifier tags all regs with ref_obj_id of the conditionally-released arg
in the period between the helper call and null check for this reason.

Why no matching CONDITIONAL_ACQUIRE type flag? Existing verifier logic
already treats acquire of an _OR_NULL type as a conditional acquire.
Consider this code:

1  struct thing *i =3D acquire_helper_that_returns_thing_or_null();
2  if (!i)
3    return 0;
4  manipulate_thing(i);
5  release_thing(i);

After line 1, BPF_REG_0 will have an _OR_NULL type and a ref_obj_id set.
When the verifier sees line 2's conditional jump, existing logic in
mark_ptr_or_null_regs, specifically the if:

  if (ref_obj_id && ref_obj_id =3D=3D id && is_null)
          /* regs[regno] is in the " =3D=3D NULL" branch.
           * No one could have freed the reference state before
           * doing the NULL check.
           */
           WARN_ON_ONCE(release_reference_state(state, id));

will release the reference in the is_null state.

[ TODO: Either need to remove WARN_ON_ONCE there without adding
CONDITIONAL_ACQUIRE flag or add the flag and don't WARN_ON_ONCE if it's
set. Left out of first pass for simplicity's sake. ]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h          |   3 +
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/rbtree.c          |   2 +-
 kernel/bpf/verifier.c        | 122 +++++++++++++++++++++++++++++++----
 4 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c9c4b4fb019c..a601ab30a2b1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -413,6 +413,9 @@ enum bpf_type_flag {
 	MEM_FIXED_SIZE		=3D BIT(10 + BPF_BASE_TYPE_BITS),
=20
 	OBJ_NON_OWNING_REF	=3D BIT(11 + BPF_BASE_TYPE_BITS),
+
+	CONDITIONAL_RELEASE	=3D BIT(12 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9c017575c034..bdc8c48c2343 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -313,6 +313,7 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;
 	u32 active_spin_lock;
+	u32 active_cond_ref_obj_id;
 	bool speculative;
=20
 	/* first and last insn idx of this verifier state */
diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index 34864fc83209..dcf8f69d4ada 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -111,7 +111,7 @@ BPF_CALL_3(bpf_rbtree_add, struct bpf_map *, map, voi=
d *, value, void *, cb)
 const struct bpf_func_proto bpf_rbtree_add_proto =3D {
 	.func =3D bpf_rbtree_add,
 	.gpl_only =3D true,
-	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL | OBJ_NON_OWNING_REF,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL | OBJ_NON_OWNING_REF | CONDITIO=
NAL_RELEASE,
 	.arg1_type =3D ARG_CONST_MAP_PTR,
 	.arg2_type =3D ARG_PTR_TO_BTF_ID | OBJ_RELEASE,
 	.arg2_btf_id =3D &bpf_rbtree_btf_ids[0],
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f46b2dfbc4b..f80e161170de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -472,6 +472,11 @@ static bool type_is_non_owning_ref(u32 type)
 	return type & OBJ_NON_OWNING_REF;
 }
=20
+static bool type_is_cond_release(u32 type)
+{
+	return type & CONDITIONAL_RELEASE;
+}
+
 static bool type_may_be_null(u32 type)
 {
 	return type & PTR_MAYBE_NULL;
@@ -600,6 +605,15 @@ static const char *reg_type_str(struct bpf_verifier_=
env *env,
 			postfix_idx +=3D strlcpy(postfix + postfix_idx, "_non_own", 32 - post=
fix_idx);
 	}
=20
+	if (type_is_cond_release(type)) {
+		if (base_type(type) =3D=3D PTR_TO_BTF_ID)
+			postfix_idx +=3D strlcpy(postfix + postfix_idx, "cond_rel_",
+					       32 - postfix_idx);
+		else
+			postfix_idx +=3D strlcpy(postfix + postfix_idx, "_cond_rel",
+					       32 - postfix_idx);
+	}
+
 	if (type & MEM_RDONLY)
 		strncpy(prefix, "rdonly_", 32);
 	if (type & MEM_ALLOC)
@@ -1211,6 +1225,7 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
 	dst_state->speculative =3D src->speculative;
 	dst_state->curframe =3D src->curframe;
 	dst_state->active_spin_lock =3D src->active_spin_lock;
+	dst_state->active_cond_ref_obj_id =3D src->active_cond_ref_obj_id;
 	dst_state->branches =3D src->branches;
 	dst_state->parent =3D src->parent;
 	dst_state->first_insn_idx =3D src->first_insn_idx;
@@ -1418,6 +1433,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_st=
ate *reg)
 		return;
 	}
=20
+	reg->type &=3D ~CONDITIONAL_RELEASE;
 	reg->type &=3D ~PTR_MAYBE_NULL;
 }
=20
@@ -6635,24 +6651,78 @@ static void release_reg_references(struct bpf_ver=
ifier_env *env,
 	}
 }
=20
+static int __release_reference(struct bpf_verifier_env *env, struct bpf_=
verifier_state *vstate,
+			       int ref_obj_id)
+{
+	int err;
+	int i;
+
+	err =3D release_reference_state(vstate->frame[vstate->curframe], ref_ob=
j_id);
+	if (err)
+		return err;
+
+	for (i =3D 0; i <=3D vstate->curframe; i++)
+		release_reg_references(env, vstate->frame[i], ref_obj_id);
+	return 0;
+}
+
 /* The pointer with the specified id has released its reference to kerne=
l
  * resources. Identify all copies of the same pointer and clear the refe=
rence.
  */
 static int release_reference(struct bpf_verifier_env *env,
 			     int ref_obj_id)
 {
-	struct bpf_verifier_state *vstate =3D env->cur_state;
-	int err;
+	return __release_reference(env, env->cur_state, ref_obj_id);
+}
+
+static void tag_reference_cond_release_regs(struct bpf_verifier_env *env=
,
+					    struct bpf_func_state *state,
+					    int ref_obj_id,
+					    bool remove)
+{
+	struct bpf_reg_state *regs =3D state->regs, *reg;
 	int i;
=20
-	err =3D release_reference_state(cur_func(env), ref_obj_id);
-	if (err)
-		return err;
+	for (i =3D 0; i < MAX_BPF_REG; i++)
+		if (regs[i].ref_obj_id =3D=3D ref_obj_id) {
+			if (remove)
+				regs[i].type &=3D ~CONDITIONAL_RELEASE;
+			else
+				regs[i].type |=3D CONDITIONAL_RELEASE;
+		}
+
+	bpf_for_each_spilled_reg(i, state, reg) {
+		if (!reg)
+			continue;
+		if (reg->ref_obj_id =3D=3D ref_obj_id) {
+			if (remove)
+				reg->type &=3D ~CONDITIONAL_RELEASE;
+			else
+				reg->type |=3D CONDITIONAL_RELEASE;
+		}
+	}
+}
+
+static void tag_reference_cond_release(struct bpf_verifier_env *env,
+				       int ref_obj_id)
+{
+	struct bpf_verifier_state *vstate =3D env->cur_state;
+	int i;
=20
 	for (i =3D 0; i <=3D vstate->curframe; i++)
-		release_reg_references(env, vstate->frame[i], ref_obj_id);
+		tag_reference_cond_release_regs(env, vstate->frame[i],
+						ref_obj_id, false);
+}
=20
-	return 0;
+static void untag_reference_cond_release(struct bpf_verifier_env *env,
+					 struct bpf_verifier_state *vstate,
+					 int ref_obj_id)
+{
+	int i;
+
+	for (i =3D 0; i <=3D vstate->curframe; i++)
+		tag_reference_cond_release_regs(env, vstate->frame[i],
+						ref_obj_id, true);
 }
=20
 static void clear_non_owning_ref_regs(struct bpf_verifier_env *env,
@@ -7406,7 +7476,17 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
 			err =3D unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
 		else if (meta.ref_obj_id)
-			err =3D release_reference(env, meta.ref_obj_id);
+			if (type_is_cond_release(fn->ret_type)) {
+				if (env->cur_state->active_cond_ref_obj_id) {
+					verbose(env, "can't handle >1 cond_release\n");
+					return err;
+				}
+				env->cur_state->active_cond_ref_obj_id =3D meta.ref_obj_id;
+				tag_reference_cond_release(env, meta.ref_obj_id);
+				err =3D 0;
+			} else {
+				err =3D release_reference(env, meta.ref_obj_id);
+			}
 		/* meta.ref_obj_id can only be 0 if register that is meant to be
 		 * released is NULL, which must be > R0.
 		 */
@@ -10040,8 +10120,8 @@ static void __mark_ptr_or_null_regs(struct bpf_fu=
nc_state *state, u32 id,
 /* The logic is similar to find_good_pkt_pointers(), both could eventual=
ly
  * be folded together at some point.
  */
-static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32=
 regno,
-				  bool is_null)
+static int mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 =
regno,
+				 bool is_null, struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs =3D state->regs;
@@ -10056,8 +10136,19 @@ static void mark_ptr_or_null_regs(struct bpf_ver=
ifier_state *vstate, u32 regno,
 		 */
 		WARN_ON_ONCE(release_reference_state(state, id));
=20
+	if (type_is_cond_release(regs[regno].type)) {
+		if (!is_null) {
+			__release_reference(env, vstate, vstate->active_cond_ref_obj_id);
+			vstate->active_cond_ref_obj_id =3D 0;
+		} else {
+			untag_reference_cond_release(env, vstate, vstate->active_cond_ref_obj=
_id);
+			vstate->active_cond_ref_obj_id =3D 0;
+		}
+	}
 	for (i =3D 0; i <=3D vstate->curframe; i++)
 		__mark_ptr_or_null_regs(vstate->frame[i], id, is_null);
+
+	return 0;
 }
=20
 static bool try_match_pkt_pointers(const struct bpf_insn *insn,
@@ -10365,10 +10456,10 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R =3D=3D 0 or R !=3D 0 conditional.
 		 */
-		mark_ptr_or_null_regs(this_branch, insn->dst_reg,
-				      opcode =3D=3D BPF_JNE);
-		mark_ptr_or_null_regs(other_branch, insn->dst_reg,
-				      opcode =3D=3D BPF_JEQ);
+		err =3D mark_ptr_or_null_regs(this_branch, insn->dst_reg,
+					    opcode =3D=3D BPF_JNE, env);
+		err =3D mark_ptr_or_null_regs(other_branch, insn->dst_reg,
+					    opcode =3D=3D BPF_JEQ, env);
 	} else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg],
 					   this_branch, other_branch) &&
 		   is_pointer_value(env, insn->dst_reg)) {
@@ -11809,6 +11900,9 @@ static bool states_equal(struct bpf_verifier_env =
*env,
 	if (old->active_spin_lock !=3D cur->active_spin_lock)
 		return false;
=20
+	if (old->active_cond_ref_obj_id !=3D cur->active_cond_ref_obj_id)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
--=20
2.30.2

