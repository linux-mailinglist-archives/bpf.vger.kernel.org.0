Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A275A6B2F
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiH3RtF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiH3Rsn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:48:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3425E9B
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:45:42 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UG2F9Y025015
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:31:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xjs6vWKiLzieNqi5jZB2GEaVN9g15z7SKNRg+eGLHrg=;
 b=rRmgZcD9Rg/MM+Q8CKuJRgWzzTop7+/tLpvmpKZVRrsL+2Jg9rNUJKpNvXegdVCOLJF4
 n181tmtVxiIQ9GVXwYdyWgAxbU3bRzsi08/fJFo6V9EuLLpYpu2Jal00LPhqT9KUf4zr
 cwLKUfWOmhkQoxWY+EBwUGHyp02jzNQ0DG0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9ae4c5ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:31:20 -0700
Received: from twshared0646.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:31:19 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id F19EDCAD079B; Tue, 30 Aug 2022 10:28:10 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 12/18] bpf: Add OBJ_NON_OWNING_REF type flag
Date:   Tue, 30 Aug 2022 10:27:53 -0700
Message-ID: <20220830172759.4069786-13-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xeFsjwL0cdoTY6sXGyAuwjam8L_KzDm0
X-Proofpoint-GUID: xeFsjwL0cdoTY6sXGyAuwjam8L_KzDm0
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

Consider a pointer to a type that would normally need acquire / release
semantics to be safely held. There may be scenarios where such a pointer
can be safely held without the need to acquire a reference.

For example, although a PTR_TO_BTF_ID for a rbtree_map node is released
via bpf_rbtree_add helper, the helper doesn't change the address of the
node and must be called with the rbtree_map's spinlock held. Since the
only way to remove a node from the rbtree - bpf_rbtree_remove helper -
requires the same lock, the newly-added node cannot be removed by a
concurrently-running program until the lock is released. Therefore it is
safe to hold a reference to this node until bpf_rbtree_unlock is called.

This patch introduces a new type flag and associated verifier logic to
handle such "non-owning" references.

Currently the only usecase I have is the rbtree example above, so the
verifier logic is straightforward:
  * Tag return types of bpf_rbtree_{add,find} with OBJ_NON_OWNING_REF
    * These both require the rbtree lock to be held to return anything
    non-NULL
    * Since ret type for both is PTR_TO_BTF_ID_OR_NULL, if lock is not
    held and NULL is returned, existing mark_ptr_or_null_reg logic
    will clear reg type.
    * So if mark_ptr_or_null_reg logic turns the returned reg into a
    PTR_TO_BTF_ID | OBJ_NON_OWNING_REF, verifier knows lock is held.

  * When the lock is released the verifier invalidates any regs holding
  non owning refs similarly to existing release_reference logic - but no
  need to clear ref_obj_id as an 'owning' reference was never acquired.

[ TODO: Currently the invalidation logic in
clear_rbtree_node_non_owning_refs is not parametrized by map so
unlocking any rbtree lock will invalidate all non-owning refs ]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/rbtree.c   |  4 +--
 kernel/bpf/verifier.c | 65 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b762c6b3dcfb..f164bd6e2f3a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -415,6 +415,7 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		=3D BIT(10 + BPF_BASE_TYPE_BITS),
=20
+	OBJ_NON_OWNING_REF	=3D BIT(11 + BPF_BASE_TYPE_BITS),
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index b5d158254de6..cc89639df8a2 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -144,7 +144,7 @@ BPF_CALL_3(bpf_rbtree_add, struct bpf_map *, map, voi=
d *, value, void *, cb)
 const struct bpf_func_proto bpf_rbtree_add_proto =3D {
 	.func =3D bpf_rbtree_add,
 	.gpl_only =3D true,
-	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL | OBJ_NON_OWNING_REF,
 	.ret_btf_id =3D BPF_PTR_POISON,
 	.arg1_type =3D ARG_CONST_MAP_PTR,
 	.arg2_type =3D ARG_PTR_TO_BTF_ID | OBJ_RELEASE,
@@ -167,7 +167,7 @@ BPF_CALL_3(bpf_rbtree_find, struct bpf_map *, map, vo=
id *, key, void *, cb)
 const struct bpf_func_proto bpf_rbtree_find_proto =3D {
 	.func =3D bpf_rbtree_find,
 	.gpl_only =3D true,
-	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL | OBJ_NON_OWNING_REF,
 	.ret_btf_id =3D BPF_PTR_POISON,
 	.arg1_type =3D ARG_CONST_MAP_PTR,
 	.arg2_type =3D ARG_ANYTHING,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c9af1047d80..26aa228fa860 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -469,6 +469,11 @@ static bool type_is_rdonly_mem(u32 type)
 	return type & MEM_RDONLY;
 }
=20
+static bool type_is_non_owning_ref(u32 type)
+{
+	return type & OBJ_NON_OWNING_REF;
+}
+
 static bool type_may_be_null(u32 type)
 {
 	return type & PTR_MAYBE_NULL;
@@ -595,7 +600,9 @@ static bool function_returns_rbtree_node(enum bpf_fun=
c_id func_id)
 static const char *reg_type_str(struct bpf_verifier_env *env,
 				enum bpf_reg_type type)
 {
-	char postfix[16] =3D {0}, prefix[32] =3D {0};
+	char postfix[32] =3D {0}, prefix[32] =3D {0};
+	unsigned int postfix_idx =3D 0;
+
 	static const char * const str[] =3D {
 		[NOT_INIT]		=3D "?",
 		[SCALAR_VALUE]		=3D "scalar",
@@ -620,11 +627,18 @@ static const char *reg_type_str(struct bpf_verifier=
_env *env,
 		[PTR_TO_SPIN_LOCK]	=3D "spin_lock",
 	};
=20
-	if (type & PTR_MAYBE_NULL) {
+	if (type_may_be_null(type)) {
 		if (base_type(type) =3D=3D PTR_TO_BTF_ID)
-			strncpy(postfix, "or_null_", 16);
+			postfix_idx +=3D strlcpy(postfix + postfix_idx, "or_null_", 32 - post=
fix_idx);
 		else
-			strncpy(postfix, "_or_null", 16);
+			postfix_idx +=3D strlcpy(postfix + postfix_idx, "_or_null", 32 - post=
fix_idx);
+	}
+
+	if (type_is_non_owning_ref(type)) {
+		if (base_type(type) =3D=3D PTR_TO_BTF_ID)
+			postfix_idx +=3D strlcpy(postfix + postfix_idx, "non_own_", 32 - post=
fix_idx);
+		else
+			postfix_idx +=3D strlcpy(postfix + postfix_idx, "_non_own", 32 - post=
fix_idx);
 	}
=20
 	if (type & MEM_RDONLY)
@@ -5758,7 +5772,14 @@ static const struct bpf_reg_types int_ptr_types =3D=
 {
 static const struct bpf_reg_types spin_lock_types =3D {
 	.types =3D {
 		PTR_TO_MAP_VALUE,
-		PTR_TO_SPIN_LOCK
+		PTR_TO_SPIN_LOCK,
+	},
+};
+
+static const struct bpf_reg_types btf_ptr_types =3D {
+	.types =3D {
+		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | OBJ_NON_OWNING_REF,
 	},
 };
=20
@@ -5767,7 +5788,6 @@ static const struct bpf_reg_types scalar_types =3D =
{ .types =3D { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types =3D { .types =3D { PTR_T=
O_CTX } };
 static const struct bpf_reg_types alloc_mem_types =3D { .types =3D { PTR=
_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types =3D { .types =3D {=
 CONST_PTR_TO_MAP } };
-static const struct bpf_reg_types spin_lock_types =3D { .types =3D { PTR=
_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types =3D { .types =3D =
{ PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types =3D { .types =3D { PTR_=
TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types =3D { .types =3D { PTR=
_TO_STACK } };
@@ -6723,6 +6743,33 @@ static int release_reference(struct bpf_verifier_e=
nv *env,
 	return 0;
 }
=20
+static void clear_non_owning_ref_regs(struct bpf_verifier_env *env,
+				      struct bpf_func_state *state)
+{
+	struct bpf_reg_state *regs =3D state->regs, *reg;
+	int i;
+
+	for (i =3D 0; i < MAX_BPF_REG; i++)
+		if (type_is_non_owning_ref(regs[i].type))
+			mark_reg_unknown(env, regs, i);
+
+	bpf_for_each_spilled_reg(i, state, reg) {
+		if (!reg)
+			continue;
+		if (type_is_non_owning_ref(reg->type))
+			__mark_reg_unknown(env, reg);
+	}
+}
+
+static void clear_rbtree_node_non_owning_refs(struct bpf_verifier_env *e=
nv)
+{
+	struct bpf_verifier_state *vstate =3D env->cur_state;
+	int i;
+
+	for (i =3D 0; i <=3D vstate->curframe; i++)
+		clear_non_owning_ref_regs(env, vstate->frame[i]);
+}
+
 static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 				    struct bpf_reg_state *regs)
 {
@@ -7584,6 +7631,12 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			return -EFAULT;
 		}
 		break;
+	case BPF_FUNC_rbtree_unlock:
+		/* TODO clear_rbtree_node_non_owning_refs calls should be
+		 * parametrized by base_type or ideally by owning map
+		 */
+		clear_rbtree_node_non_owning_refs(env);
+		break;
 	}
=20
 	if (err)
--=20
2.30.2

