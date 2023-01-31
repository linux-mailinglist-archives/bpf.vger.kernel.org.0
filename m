Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20B683494
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjAaSCu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjAaSCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:02:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4541559ED
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:35 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGntRf026607
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AYId6KvkKh8tfs/k9+wo7fW7RlG2rpfe0b77aPW4vNg=;
 b=Lon9iscI+YEAGU9TK7fbw97uGYawtbdrsXlY3c1keHa9jLeCyki52FtXYv2QQxjWSm5H
 7zH4pDQS0Gj7cZcEBVTxOnozli8LGCNqQ7TkXPWR56SIIyUDPw1SrffUdYmE4HGTjnGW
 g3KaDHHZjS3wYaobFDqWwX5lAO5vDk/Jbh8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nepsg5h74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:34 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 31 Jan 2023 10:02:34 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 1DCC315D5BB72; Tue, 31 Jan 2023 10:00:21 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 07/11] bpf: Add callback validation to kfunc verifier logic
Date:   Tue, 31 Jan 2023 10:00:12 -0800
Message-ID: <20230131180016.3368305-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230131180016.3368305-1-davemarchevsky@fb.com>
References: <20230131180016.3368305-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KlkPtcrBX1MOiIGAgs8yvr4-04P3ogsk
X-Proofpoint-ORIG-GUID: KlkPtcrBX1MOiIGAgs8yvr4-04P3ogsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some BPF helpers take a callback function which the helper calls. For
each helper that takes such a callback, there's a special call to
__check_func_call with a callback-state-setting callback that sets up
verifier bpf_func_state for the callback's frame.

kfuncs don't have any of this infrastructure yet, so let's add it in
this patch, following existing helper pattern as much as possible. To
validate functionality of this added plumbing, this patch adds
callback handling for the bpf_rbtree_add kfunc and hopes to lay
groundwork for future graph datastructure callbacks.

In the "general plumbing" category we have:

  * check_kfunc_call doing callback verification right before clearing
    CALLER_SAVED_REGS, exactly like check_helper_call
  * recognition of func_ptr BTF types in kfunc args as
    KF_ARG_PTR_TO_CALLBACK + propagation of subprogno for this arg type

In the "rbtree_add / graph datastructure-specific plumbing" category:

  * Since bpf_rbtree_add must be called while the spin_lock associated
    with the tree is held, don't complain when callback's func_state
    doesn't unlock it by frame exit
  * Mark rbtree_add callback's args with ref_set_non_owning_lock
    to prevent rbtree api functions from being called in the callback.
    Semantically this makes sense, as less() takes no ownership of its
    args when determining which comes first.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 135 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5543103e0b9c..4a0c38d83eff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -192,6 +192,8 @@ static int acquire_reference_state(struct bpf_verifie=
r_env *env, int insn_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
 				       struct bpf_active_lock *lock);
+static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
+
 static int ref_set_non_owning_lock(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg);
=20
@@ -1494,6 +1496,16 @@ static void mark_ptr_not_null_reg(struct bpf_reg_s=
tate *reg)
 	reg->type &=3D ~PTR_MAYBE_NULL;
 }
=20
+static void mark_reg_graph_node(struct bpf_reg_state *regs, u32 regno,
+				struct btf_field_graph_root *ds_head)
+{
+	__mark_reg_known_zero(&regs[regno]);
+	regs[regno].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
+	regs[regno].btf =3D ds_head->btf;
+	regs[regno].btf_id =3D ds_head->value_btf_id;
+	regs[regno].off =3D ds_head->node_offset;
+}
+
 static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
 {
 	return type_is_pkt_pointer(reg->type);
@@ -6509,6 +6521,10 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 		meta->ret_btf_id =3D reg->btf_id;
 		break;
 	case ARG_PTR_TO_SPIN_LOCK:
+		if (in_rbtree_lock_required_cb(env)) {
+			verbose(env, "can't spin_{lock,unlock} in rbtree cb\n");
+			return -EACCES;
+		}
 		if (meta->func_id =3D=3D BPF_FUNC_spin_lock) {
 			err =3D process_spin_lock(env, regno, true);
 			if (err)
@@ -7118,6 +7134,8 @@ static int set_callee_state(struct bpf_verifier_env=
 *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
=20
+static bool is_callback_calling_kfunc(u32 btf_id);
+
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
 			     int *insn_idx, int subprog,
 			     set_callee_state_fn set_callee_state_cb)
@@ -7172,10 +7190,18 @@ static int __check_func_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
 	 * interested in validating only BPF helpers that can call subprogs as
 	 * callbacks
 	 */
-	if (set_callee_state_cb !=3D set_callee_state && !is_callback_calling_f=
unction(insn->imm)) {
-		verbose(env, "verifier bug: helper %s#%d is not marked as callback-cal=
ling\n",
-			func_id_name(insn->imm), insn->imm);
-		return -EFAULT;
+	if (set_callee_state_cb !=3D set_callee_state) {
+		if (bpf_pseudo_kfunc_call(insn) &&
+		    !is_callback_calling_kfunc(insn->imm)) {
+			verbose(env, "verifier bug: kfunc %s#%d not marked as callback-callin=
g\n",
+				func_id_name(insn->imm), insn->imm);
+			return -EFAULT;
+		} else if (!bpf_pseudo_kfunc_call(insn) &&
+			   !is_callback_calling_function(insn->imm)) { /* helper */
+			verbose(env, "verifier bug: helper %s#%d not marked as callback-calli=
ng\n",
+				func_id_name(insn->imm), insn->imm);
+			return -EFAULT;
+		}
 	}
=20
 	if (insn->code =3D=3D (BPF_JMP | BPF_CALL) &&
@@ -7440,6 +7466,63 @@ static int set_user_ringbuf_callback_state(struct =
bpf_verifier_env *env,
 	return 0;
 }
=20
+static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
+					 struct bpf_func_state *caller,
+					 struct bpf_func_state *callee,
+					 int insn_idx)
+{
+	/* void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *no=
de,
+	 *                     bool (less)(struct bpf_rb_node *a, const struct =
bpf_rb_node *b));
+	 *
+	 * 'struct bpf_rb_node *node' arg to bpf_rbtree_add is the same PTR_TO_=
BTF_ID w/ offset
+	 * that 'less' callback args will be receiving. However, 'node' arg was=
 release_reference'd
+	 * by this point, so look at 'root'
+	 */
+	struct btf_field *field;
+
+	field =3D reg_find_field_offset(&caller->regs[BPF_REG_1], caller->regs[=
BPF_REG_1].off,
+				      BPF_RB_ROOT);
+	if (!field || !field->graph_root.value_btf_id)
+		return -EFAULT;
+
+	mark_reg_graph_node(callee->regs, BPF_REG_1, &field->graph_root);
+	ref_set_non_owning_lock(env, &callee->regs[BPF_REG_1]);
+	mark_reg_graph_node(callee->regs, BPF_REG_2, &field->graph_root);
+	ref_set_non_owning_lock(env, &callee->regs[BPF_REG_2]);
+
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_callback_fn =3D true;
+	callee->callback_ret_range =3D tnum_range(0, 1);
+	return 0;
+}
+
+static bool is_rbtree_lock_required_kfunc(u32 btf_id);
+
+/* Are we currently verifying the callback for a rbtree helper that must
+ * be called with lock held? If so, no need to complain about unreleased
+ * lock
+ */
+static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_insn *insn =3D env->prog->insnsi;
+	struct bpf_func_state *callee;
+	int kfunc_btf_id;
+
+	if (!state->curframe)
+		return false;
+
+	callee =3D state->frame[state->curframe];
+
+	if (!callee->in_callback_fn)
+		return false;
+
+	kfunc_btf_id =3D insn[callee->callsite].imm;
+	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
@@ -8297,6 +8380,7 @@ struct bpf_kfunc_call_arg_meta {
 	bool r0_rdonly;
 	u32 ret_btf_id;
 	u64 r0_size;
+	u32 subprogno;
 	struct {
 		u64 value;
 		bool found;
@@ -8475,6 +8559,18 @@ static bool is_kfunc_arg_rbtree_node(const struct =
btf *btf, const struct btf_par
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
 }
=20
+static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const st=
ruct btf *btf,
+				  const struct btf_param *arg)
+{
+	const struct btf_type *t;
+
+	t =3D btf_type_resolve_func_ptr(btf, arg->type, NULL);
+	if (!t)
+		return false;
+
+	return true;
+}
+
 /* Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed */
 static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 					const struct btf *btf,
@@ -8534,6 +8630,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip i=
t */
+	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
 };
@@ -8658,6 +8755,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env=
,
 		return KF_ARG_PTR_TO_BTF_ID;
 	}
=20
+	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_CALLBACK;
+
 	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno +=
 1], &regs[regno + 1]))
 		arg_mem_size =3D true;
=20
@@ -8889,6 +8989,16 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id)=
;
 }
=20
+static bool is_callback_calling_kfunc(u32 btf_id)
+{
+	return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add];
+}
+
+static bool is_rbtree_lock_required_kfunc(u32 btf_id)
+{
+	return is_bpf_rbtree_api_kfunc(btf_id);
+}
+
 static bool check_kfunc_is_graph_root_api(struct bpf_verifier_env *env,
 					  enum btf_field_type head_field_type,
 					  u32 kfunc_btf_id)
@@ -9224,6 +9334,7 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_RB_NODE:
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
+		case KF_ARG_PTR_TO_CALLBACK:
 			/* Trusted by default */
 			break;
 		default:
@@ -9375,6 +9486,9 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 			/* Skip next '__sz' argument */
 			i++;
 			break;
+		case KF_ARG_PTR_TO_CALLBACK:
+			meta->subprogno =3D reg->subprogno;
+			break;
 		}
 	}
=20
@@ -9503,6 +9617,16 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 		}
 	}
=20
+	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add]) {
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_rbtree_add_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, func_id);
+			return err;
+		}
+	}
+
 	for (i =3D 0; i < CALLER_SAVED_REGS; i++)
 		mark_reg_not_init(env, regs, caller_saved[i]);
=20
@@ -14347,7 +14471,8 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
=20
-				if (env->cur_state->active_lock.ptr) {
+				if (env->cur_state->active_lock.ptr &&
+				    !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
--=20
2.30.2

