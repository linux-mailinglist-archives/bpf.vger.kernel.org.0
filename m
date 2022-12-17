Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7158F64F839
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiLQIZj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiLQIZh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:25:37 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA242F671
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:36 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BH8AtnX016989
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=X6QIxuBCdTRY1bch+Ed/moZM2DYJEUF9D41qa43guC8=;
 b=CaaTXu/QDK4kmZ8D2RUbbM3BiUWMWvlNyTCAnsrvMka9Lw+dsqi04Ou9qJNU5TbcI3uE
 znbyrHJy+PB1rhv8A74eVzzv4975awXCRgdEHb3ACgywKnKxV3TElfe9rEnk+YszvqK5
 U/1x9E+Kl1ijeIfOgnL2xDxVsPiSqIHLOKE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mh6uj8mp8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:35 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 00:25:33 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id D844412A9E026; Sat, 17 Dec 2022 00:25:18 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 09/13] bpf: Special verifier handling for bpf_rbtree_{remove, first}
Date:   Sat, 17 Dec 2022 00:25:02 -0800
Message-ID: <20221217082506.1570898-10-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217082506.1570898-1-davemarchevsky@fb.com>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vvuLxH8FWvEzrHbxLSLNFy0wzTWbE91y
X-Proofpoint-GUID: vvuLxH8FWvEzrHbxLSLNFy0wzTWbE91y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
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
    * mark_reg_graph_node helper added in previous patch generalizes
      this logic, use it

  * bpf_rbtree_remove's node input is a node that's been inserted
    in the tree - a non-owning reference.

  * bpf_rbtree_remove must invalidate non-owning references in order to
    avoid aliasing issue. Add KF_INVALIDATE_NON_OWN flag, which
    indicates that the marked kfunc is a non-owning ref invalidation
    point, and associated verifier logic using previously-added
    invalidate_non_owning_refs helper.

  * Unlike other functions, which convert one of their input arg regs to
    non-owning reference, bpf_rbtree_first takes no arguments and just
    returns a non-owning reference (possibly null)
    * For now verifier logic for this is special-cased instead of
      adding new kfunc flag.

This patch, along with the previous one, complete special verifier
handling for all rbtree API functions added in this series.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/helpers.c  |  2 +-
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 8aee3f7f4248..3663911bb7c0 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -72,6 +72,7 @@
 #define KF_DESTRUCTIVE		(1 << 6) /* kfunc performs destructive actions *=
/
 #define KF_RCU			(1 << 7) /* kfunc only takes rcu pointer arguments */
 #define KF_RELEASE_NON_OWN	(1 << 8) /* kfunc converts its referenced arg=
 into non-owning ref */
+#define KF_INVALIDATE_NON_OWN	(1 << 9) /* kfunc invalidates non-owning r=
efs after return */
=20
 /*
  * Return the name of the passed struct, if exists, or halt the build if=
 for
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index de4523c777b7..0e6d010e6423 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2121,7 +2121,7 @@ BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | K=
F_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_acquire_not_zero, KF_ACQUIRE | KF_RCU | KF_R=
ET_NULL)
 BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_=
NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_INVALIDATE_NON_OWN=
)
 BTF_ID_FLAGS(func, bpf_rbtree_add, KF_RELEASE | KF_RELEASE_NON_OWN)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 75979f78399d..b4bf3701de7f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8393,6 +8393,11 @@ static bool is_kfunc_release_non_own(struct bpf_kf=
unc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE_NON_OWN;
 }
=20
+static bool is_kfunc_invalidate_non_own(struct bpf_kfunc_call_arg_meta *=
meta)
+{
+	return meta->kfunc_flags & KF_INVALIDATE_NON_OWN;
+}
+
 static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_TRUSTED_ARGS;
@@ -9425,10 +9430,20 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d expected pointer to allocated object\n", i);
 				return -EINVAL;
 			}
-			if (!reg->ref_obj_id) {
+			if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove]) {
+				if (reg->ref_obj_id) {
+					verbose(env, "rbtree_remove node input must be non-owning ref\n");
+					return -EINVAL;
+				}
+				if (in_rbtree_lock_required_cb(env)) {
+					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
+					return -EINVAL;
+				}
+			} else if (!reg->ref_obj_id) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
+
 			ret =3D process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
 			if (ret < 0)
 				return ret;
@@ -9665,11 +9680,12 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
=20
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D field->graph_root.btf;
-				regs[BPF_REG_0].btf_id =3D field->graph_root.value_btf_id;
-				regs[BPF_REG_0].off =3D field->graph_root.node_offset;
+				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
+			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remov=
e] ||
+				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first]) {
+				struct btf_field *field =3D meta.arg_rbtree_root.field;
+
+				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx]) {
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
@@ -9735,7 +9751,13 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 			if (is_kfunc_ret_null(&meta))
 				regs[BPF_REG_0].id =3D id;
 			regs[BPF_REG_0].ref_obj_id =3D id;
+		} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first]=
) {
+			ref_set_non_owning_lock(env, &regs[BPF_REG_0]);
 		}
+
+		if (is_kfunc_invalidate_non_own(&meta))
+			invalidate_non_owning_refs(env, &env->cur_state->active_lock);
+
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].i=
d)
 			regs[BPF_REG_0].id =3D ++env->id_gen;
 	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
--=20
2.30.2

