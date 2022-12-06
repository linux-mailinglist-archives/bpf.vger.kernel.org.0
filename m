Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D589F644F5A
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLFXK1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLFXK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:10:26 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7EF4298E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:10:25 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LhJ5d032730
        for <bpf@vger.kernel.org>; Tue, 6 Dec 2022 15:10:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DgcPGFT4Kqc9QQP4cTSX7FDCFdBcJdilQ//tNgqCojo=;
 b=LbyMGD//xK2dhmIDeHFrEFaqo1e6bkbqSDJYM/Ek+hrHqvZr1CUHJ5IjcOyBv+OSfyq0
 3mQsKJZLaJJ6mmRZE9FPB5uIxAiB2SAJTbHbpqQGayk+MsmeTsLpzQJ5qNSS4skZzJEU
 56cKJDK2+SO4+tY780gvZ4nZALPEKM0qqAQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9x70xv4w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:10:25 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 15:10:21 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id D728D120B3788; Tue,  6 Dec 2022 15:10:06 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 09/13] bpf: Special verifier handling for bpf_rbtree_{remove, first}
Date:   Tue, 6 Dec 2022 15:09:56 -0800
Message-ID: <20221206231000.3180914-10-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206231000.3180914-1-davemarchevsky@fb.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZEOe3eBegH9NTIsFrSvVS8Bri8aQynY3
X-Proofpoint-GUID: ZEOe3eBegH9NTIsFrSvVS8Bri8aQynY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
that require handling in the verifier:

  * both bpf_rbtree_remove and bpf_rbtree_first return the type containin=
g
    the bpf_rb_node field, with the offset set to that field's offset,
    instead of a struct bpf_rb_node *
    * Generalized existing next-gen list verifier handling for this
      as mark_reg_datastructure_node helper

  * Unlike other functions, which set release_on_unlock on one of their
    args, bpf_rbtree_first takes no arguments, rather setting
    release_on_unlock on its return value

  * bpf_rbtree_remove's node input is a node that's been inserted
    in the tree. Only non-owning references (PTR_UNTRUSTED +
    release_on_unlock) refer to such nodes, but kfuncs don't take
    PTR_UNTRUSTED args
    * Added special carveout for bpf_rbtree_remove to take PTR_UNTRUSTED
    * Since node input already has release_on_unlock set, don't set
      it again

This patch, along with the previous one, complete special verifier
handling for all rbtree API functions added in this series.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 89 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9ad8c0b264dc..29983e2c27df 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6122,6 +6122,23 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 	return 0;
 }
=20
+static bool
+func_arg_reg_rb_node_offset(const struct bpf_reg_state *reg, s32 off)
+{
+	struct btf_record *rec;
+	struct btf_field *field;
+
+	rec =3D reg_btf_record(reg);
+	if (!rec)
+		return false;
+
+	field =3D btf_record_find(rec, off, BPF_RB_NODE);
+	if (!field)
+		return false;
+
+	return true;
+}
+
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
 			   enum bpf_arg_type arg_type)
@@ -6176,6 +6193,13 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 		 */
 		fixed_off_ok =3D true;
 		break;
+	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
+		/* Currently only bpf_rbtree_remove accepts a PTR_UNTRUSTED
+		 * bpf_rb_node. Fixed off of the node type is OK
+		 */
+		if (reg->off && func_arg_reg_rb_node_offset(reg, reg->off))
+			fixed_off_ok =3D true;
+		break;
 	default:
 		break;
 	}
@@ -8875,26 +8899,44 @@ __process_kf_arg_ptr_to_datastructure_node(struct=
 bpf_verifier_env *env,
 			btf_name_by_offset(field->datastructure_head.btf, et->name_off));
 		return -EINVAL;
 	}
-	/* Set arg#1 for expiration after unlock */
-	return ref_set_release_on_unlock(env, reg->ref_obj_id);
+
+	return 0;
 }
=20
 static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, u32 regno,
 					   struct bpf_kfunc_call_arg_meta *meta)
 {
-	return __process_kf_arg_ptr_to_datastructure_node(env, reg, regno, meta=
,
-							  BPF_LIST_HEAD, BPF_LIST_NODE,
-							  &meta->arg_list_head.field);
+	int err;
+
+	err =3D __process_kf_arg_ptr_to_datastructure_node(env, reg, regno, met=
a,
+							 BPF_LIST_HEAD, BPF_LIST_NODE,
+							 &meta->arg_list_head.field);
+	if (err)
+		return err;
+
+	return ref_set_release_on_unlock(env, reg->ref_obj_id);
 }
=20
 static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *en=
v,
 					     struct bpf_reg_state *reg, u32 regno,
 					     struct bpf_kfunc_call_arg_meta *meta)
 {
-	return __process_kf_arg_ptr_to_datastructure_node(env, reg, regno, meta=
,
-							  BPF_RB_ROOT, BPF_RB_NODE,
-							  &meta->arg_rbtree_root.field);
+	int err;
+
+	err =3D __process_kf_arg_ptr_to_datastructure_node(env, reg, regno, met=
a,
+							 BPF_RB_ROOT, BPF_RB_NODE,
+							 &meta->arg_rbtree_root.field);
+	if (err)
+		return err;
+
+	/* bpf_rbtree_remove's node parameter is a non-owning reference to
+	 * a bpf_rb_node, so release_on_unlock is already set
+	 */
+	if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove])
+		return 0;
+
+	return ref_set_release_on_unlock(env, reg->ref_obj_id);
 }
=20
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfu=
nc_call_arg_meta *meta)
@@ -8902,7 +8944,7 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 	const char *func_name =3D meta->func_name, *ref_tname;
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
-	u32 i, nargs;
+	u32 i, nargs, check_type;
 	int ret;
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
@@ -9141,7 +9183,13 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_NODE:
-			if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC)) {
+			if (meta->btf =3D=3D btf_vmlinux &&
+			    meta->func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove])
+				check_type =3D (PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED);
+			else
+				check_type =3D (PTR_TO_BTF_ID | MEM_ALLOC);
+
+			if (reg->type !=3D check_type) {
 				verbose(env, "arg#%d expected pointer to allocated object\n", i);
 				return -EINVAL;
 			}
@@ -9380,11 +9428,14 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
=20
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D field->datastructure_head.btf;
-				regs[BPF_REG_0].btf_id =3D field->datastructure_head.value_btf_id;
-				regs[BPF_REG_0].off =3D field->datastructure_head.node_offset;
+				mark_reg_datastructure_node(regs, BPF_REG_0,
+							    &field->datastructure_head);
+			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remov=
e] ||
+				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first]) {
+				struct btf_field *field =3D meta.arg_rbtree_root.field;
+
+				mark_reg_datastructure_node(regs, BPF_REG_0,
+							    &field->datastructure_head);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx]) {
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
@@ -9450,6 +9501,9 @@ static int check_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 			if (is_kfunc_ret_null(&meta))
 				regs[BPF_REG_0].id =3D id;
 			regs[BPF_REG_0].ref_obj_id =3D id;
+
+			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first])
+				ref_set_release_on_unlock(env, regs[BPF_REG_0].ref_obj_id);
 		}
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].i=
d)
 			regs[BPF_REG_0].id =3D ++env->id_gen;
@@ -11636,8 +11690,11 @@ static void mark_ptr_or_null_reg(struct bpf_func=
_state *state,
 		 */
 		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_co=
nst(reg->var_off, 0)))
 			return;
-		if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL) && WAR=
N_ON_ONCE(reg->off))
+		if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL) &&
+		    reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL | PTR_U=
NTRUSTED) &&
+		    WARN_ON_ONCE(reg->off)) {
 			return;
+		}
 		if (is_null) {
 			reg->type =3D SCALAR_VALUE;
 			/* We don't need id and ref_obj_id from this point
--=20
2.30.2

