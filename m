Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21E5A6B13
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiH3Rpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiH3RpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:45:13 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7101EBCC02
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:41:48 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UGLbLQ003220
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=XbKTLtkRtqi5g/CEyYGaDoZsNgdHirfzPIeoXWRfhG4=;
 b=mS6848Albcv1Y8RpeJZrheKbqSezI2uukZMiy1scfCFmPpx95ITqyc5W0zEtpG0ENWK/
 R0sJR5Kwwh3RvBCXTEtUO9/EnCz0ExHZRT9SigF5eDTPQFfTZs0UZUo1KM/6BNNFuFfu
 uj2DlzcjiUvjAN0wqpRBqowmE5epaHiToT4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9h5djsgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:28 -0700
Received: from twshared0823.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 10:35:27 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 15D77CAD079D; Tue, 30 Aug 2022 10:28:10 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFCv2 PATCH bpf-next 14/18] bpf: Introduce PTR_ITER and PTR_ITER_END type flags
Date:   Tue, 30 Aug 2022 10:27:55 -0700
Message-ID: <20220830172759.4069786-15-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830172759.4069786-1-davemarchevsky@fb.com>
References: <20220830172759.4069786-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fmuqmzsrWcGiuyIBeWYyXUxDXDZ8V6Rh
X-Proofpoint-ORIG-GUID: fmuqmzsrWcGiuyIBeWYyXUxDXDZ8V6Rh
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

Add two type flags, PTR_ITER and PTR_ITER_END, meant to support the
following pattern for iterating data structures:

  struct node *elem =3D data_structure_iter_first(&some_map)
  while (elem) {
    do_something();
    elem =3D data_structure_iter_next(&some_map, elem);
  }

Currently the ret_type of both _first() and _next() helpers would be
PTR_TO_BTF_ID_OR_NULL and the verifier would consider the loop to be
infinite as it knows nothing about an arbitrary PTR_TO_BTF_ID value.

However, if we can express "this PTR_TO_BTF_ID will eventually be
NULL if used in iteration helpers" via a new type flag, the verifier can
use this information to determine that the loop will terminate while
still verifying the loop body.

So for our contrived example above, _first() now returns a
PTR_TO_BTF_ID_OR_NULL | PTR_ITER, which _next() expects as input,
itself returning PTR_TO_BTF_ID_OR_NULL | PTR_ITER_END.

The verifier does nothing special for PTR_ITER, so the first iteration
of the example loop will result in both elem =3D=3D NULL and elem !=3D NU=
LL
branches being verified. When verifying the latter branch, elem will
become a PTR_TO_BTF_ID_OR_NULL | PTR_ITER_END.

When the verifier sees a reg holding PTR_ITER_END in a conditional jump
it knows the reg type and val can be replaced with SCALAR 0. So in the
example loop on 2nd iteration elem =3D=3D NULL will be assumed and
verification will continue with that branch only.

[ TODO:
  * PTR_ITER needs to be associated with the helper that produced it, to
  prevent something like:
    struct node *elem =3D data_structure_iter_last(&some_map)
    while (elem) {
      do_something();
      elem =3D data_structure_iter_next(&some_map, elem);
    }

  i.e. _first() and _next() should be used together, same with _last()
  and _prev().

  * This is currently very unsafe. Per multiple conversations w/ Alexei
  and Andrii, there are probably some ways forward here, but may be more
  complex than it's worth. If so, can migrate to a callback-based
  approach with similar functionality .
]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h            |  3 ++
 include/uapi/linux/bpf.h       | 32 ++++++++++++++
 kernel/bpf/helpers.c           | 12 ++++++
 kernel/bpf/rbtree.c            | 78 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 53 +++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 32 ++++++++++++++
 6 files changed, 207 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 83b8d63545e3..f4aabfa943c1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -419,6 +419,9 @@ enum bpf_type_flag {
=20
 	CONDITIONAL_RELEASE	=3D BIT(12 + BPF_BASE_TYPE_BITS),
=20
+	PTR_ITER	=3D BIT(13 + BPF_BASE_TYPE_BITS),
+	PTR_ITER_END	=3D BIT(14 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f4c615fbf64f..bb556c449cf0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5433,6 +5433,34 @@ union bpf_attr {
  *
  *	Return
  *		0
+ *
+ * long bpf_rbtree_first(struct bpf_map *map)
+ *	Description
+ *		Return the first node in the tree according to sort order
+ *
+ *	Return
+ *		If found, ptr to node, otherwise NULL
+ *
+ * long bpf_rbtree_last(struct bpf_map *map)
+ *	Description
+ *		Return the last node in the tree according to sort order
+ *
+ *	Return
+ *		If found, ptr to node, otherwise NULL
+ *
+ * long bpf_rbtree_next(struct bpf_map *map, void *cur)
+ *	Description
+ *		Return the next node in the tree according to sort order
+ *
+ *	Return
+ *		If found, ptr to node, otherwise NULL
+ *
+ * long bpf_rbtree_prev(struct bpf_map *map, void *cur)
+ *	Description
+ *		Return the previous node in the tree according to sort order
+ *
+ *	Return
+ *		If found, ptr to node, otherwise NULL
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5652,6 +5680,10 @@ union bpf_attr {
 	FN(rbtree_get_lock),		\
 	FN(rbtree_lock),		\
 	FN(rbtree_unlock),		\
+	FN(rbtree_first),		\
+	FN(rbtree_last),		\
+	FN(rbtree_next),		\
+	FN(rbtree_prev),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0ca5fed1013b..32e245c559c4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1608,6 +1608,10 @@ const struct bpf_func_proto bpf_rbtree_free_node_p=
roto __weak;
 const struct bpf_func_proto bpf_rbtree_get_lock_proto __weak;
 const struct bpf_func_proto bpf_rbtree_lock_proto __weak;
 const struct bpf_func_proto bpf_rbtree_unlock_proto __weak;
+const struct bpf_func_proto bpf_rbtree_first_proto __weak;
+const struct bpf_func_proto bpf_rbtree_last_proto __weak;
+const struct bpf_func_proto bpf_rbtree_next_proto __weak;
+const struct bpf_func_proto bpf_rbtree_prev_proto __weak;
=20
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
@@ -1715,6 +1719,14 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_rbtree_lock_proto;
 	case BPF_FUNC_rbtree_unlock:
 		return &bpf_rbtree_unlock_proto;
+	case BPF_FUNC_rbtree_first:
+		return &bpf_rbtree_first_proto;
+	case BPF_FUNC_rbtree_last:
+		return &bpf_rbtree_last_proto;
+	case BPF_FUNC_rbtree_next:
+		return &bpf_rbtree_next_proto;
+	case BPF_FUNC_rbtree_prev:
+		return &bpf_rbtree_prev_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
index e6f51c27661c..4794a50adbca 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -174,6 +174,84 @@ const struct bpf_func_proto bpf_rbtree_find_proto =3D=
 {
 	.arg3_type =3D ARG_PTR_TO_FUNC,
 };
=20
+BPF_CALL_1(bpf_rbtree_first, struct bpf_map *, map)
+{
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+
+	if (!__rbtree_lock_held(tree))
+		return (u64)NULL;
+
+	return (u64)rb_first_cached(&tree->root);
+}
+
+const struct bpf_func_proto bpf_rbtree_first_proto =3D {
+	.func =3D bpf_rbtree_first,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL | PTR_ITER | OBJ_NON_OWNING_REF=
,
+	.ret_btf_id =3D BPF_PTR_POISON,
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+};
+
+BPF_CALL_1(bpf_rbtree_last, struct bpf_map *, map)
+{
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+
+	if (!__rbtree_lock_held(tree))
+		return (u64)NULL;
+
+	return (u64)rb_last(&tree->root.rb_root);
+}
+
+const struct bpf_func_proto bpf_rbtree_last_proto =3D {
+	.func =3D bpf_rbtree_last,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL | PTR_ITER | OBJ_NON_OWNING_REF=
,
+	.ret_btf_id =3D BPF_PTR_POISON,
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+};
+
+BPF_CALL_2(bpf_rbtree_next, struct bpf_map *, map, void *, cur)
+{
+	struct rb_node *next =3D rb_next((struct rb_node *)cur);
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+
+	if (!__rbtree_lock_held(tree))
+		return (u64)NULL;
+
+	return (u64)next;
+}
+
+const struct bpf_func_proto bpf_rbtree_next_proto =3D {
+	.func =3D bpf_rbtree_next,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL | PTR_ITER_END | OBJ_NON_OWNING=
_REF,
+	.ret_btf_id =3D BPF_PTR_POISON,
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_PTR_TO_BTF_ID | PTR_ITER,
+	.arg2_btf_id =3D BPF_PTR_POISON,
+};
+
+BPF_CALL_2(bpf_rbtree_prev, struct bpf_map *, map, void *, cur)
+{
+	struct rb_node *node =3D (struct rb_node *)cur;
+	struct bpf_rbtree *tree =3D container_of(map, struct bpf_rbtree, map);
+
+	if (!__rbtree_lock_held(tree))
+		return (u64)NULL;
+
+	return (u64)rb_prev(node);
+}
+
+const struct bpf_func_proto bpf_rbtree_prev_proto =3D {
+	.func =3D bpf_rbtree_prev,
+	.gpl_only =3D true,
+	.ret_type =3D RET_PTR_TO_BTF_ID_OR_NULL | PTR_ITER_END | OBJ_NON_OWNING=
_REF,
+	.ret_btf_id =3D BPF_PTR_POISON,
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_PTR_TO_BTF_ID | PTR_ITER,
+	.arg2_btf_id =3D BPF_PTR_POISON,
+};
+
 /* Like rbtree_postorder_for_each_entry_safe, but 'pos' and 'n' are
  * 'rb_node *', so field name of rb_node within containing struct is not
  * needed.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3da8959e5f7a..6354d3a2217d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -484,6 +484,11 @@ static bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
=20
+static bool type_is_iter(u32 type)
+{
+	return type & PTR_ITER || type & PTR_ITER_END;
+}
+
 static bool is_acquire_function(enum bpf_func_id func_id,
 				const struct bpf_map *map)
 {
@@ -586,7 +591,9 @@ static bool function_manipulates_rbtree_node(enum bpf=
_func_id func_id)
 {
 	return func_id =3D=3D BPF_FUNC_rbtree_add ||
 		func_id =3D=3D BPF_FUNC_rbtree_remove ||
-		func_id =3D=3D BPF_FUNC_rbtree_free_node;
+		func_id =3D=3D BPF_FUNC_rbtree_free_node ||
+		func_id =3D=3D BPF_FUNC_rbtree_next ||
+		func_id =3D=3D BPF_FUNC_rbtree_prev;
 }
=20
 static bool function_returns_rbtree_node(enum bpf_func_id func_id)
@@ -594,7 +601,11 @@ static bool function_returns_rbtree_node(enum bpf_fu=
nc_id func_id)
 	return func_id =3D=3D BPF_FUNC_rbtree_alloc_node ||
 		func_id =3D=3D BPF_FUNC_rbtree_find ||
 		func_id =3D=3D BPF_FUNC_rbtree_add ||
-		func_id =3D=3D BPF_FUNC_rbtree_remove;
+		func_id =3D=3D BPF_FUNC_rbtree_remove ||
+		func_id =3D=3D BPF_FUNC_rbtree_first ||
+		func_id =3D=3D BPF_FUNC_rbtree_last ||
+		func_id =3D=3D BPF_FUNC_rbtree_next ||
+		func_id =3D=3D BPF_FUNC_rbtree_prev;
 }
=20
 /* string representation of 'enum bpf_reg_type'
@@ -655,6 +666,12 @@ static const char *reg_type_str(struct bpf_verifier_=
env *env,
 					       32 - postfix_idx);
 	}
=20
+	if (type_is_iter(type)) {
+		postfix_idx +=3D strlcpy(postfix + postfix_idx, "_iter", 32 - postfix_=
idx);
+		if (type & PTR_ITER_END)
+			postfix_idx +=3D strlcpy(postfix + postfix_idx, "_end", 32 - postfix_=
idx);
+	}
+
 	if (type & MEM_RDONLY)
 		strncpy(prefix, "rdonly_", 32);
 	if (type & MEM_ALLOC)
@@ -1470,7 +1487,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_st=
ate *reg)
 			   map->map_type =3D=3D BPF_MAP_TYPE_SOCKHASH) {
 			reg->type =3D PTR_TO_SOCKET;
 		} else {
-			reg->type =3D PTR_TO_MAP_VALUE;
+			reg->type &=3D ~PTR_MAYBE_NULL;
 		}
 		return;
 	}
@@ -3063,6 +3080,11 @@ static bool __is_pointer_value(bool allow_ptr_leak=
s,
 	return reg->type !=3D SCALAR_VALUE;
 }
=20
+static bool __is_iter_end(const struct bpf_reg_state *reg)
+{
+	return reg->type & PTR_ITER_END;
+}
+
 static void save_register_state(struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
 				int size)
@@ -5737,6 +5759,8 @@ static const struct bpf_reg_types map_key_value_typ=
es =3D {
 		PTR_TO_PACKET_META,
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
+		PTR_TO_MAP_VALUE | PTR_ITER,
+		PTR_TO_MAP_VALUE | PTR_ITER_END,
 	},
 };
=20
@@ -5870,6 +5894,17 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 	if (arg_type & PTR_MAYBE_NULL)
 		type &=3D ~PTR_MAYBE_NULL;
=20
+	/* TYPE | PTR_ITER is valid input for helpers that expect TYPE
+	 * TYPE is not valid input for helpers that expect TYPE | PTR_ITER
+	 */
+	if (type_is_iter(arg_type)) {
+		if (!type_is_iter(type))
+			goto not_found;
+
+		type &=3D ~PTR_ITER;
+		type &=3D ~PTR_ITER_END;
+	}
+
 	for (i =3D 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected =3D compatible->types[i];
 		if (expected =3D=3D NOT_INIT)
@@ -5879,6 +5914,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 			goto found;
 	}
=20
+not_found:
 	verbose(env, "R%d type=3D%s expected=3D", regno, reg_type_str(env, reg-=
>type));
 	for (j =3D 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
@@ -9933,6 +9969,17 @@ static int is_branch_taken(struct bpf_reg_state *r=
eg, u64 val, u8 opcode,
 			   bool is_jmp32)
 {
 	if (__is_pointer_value(false, reg)) {
+		if (__is_iter_end(reg) && val =3D=3D 0) {
+			__mark_reg_const_zero(reg);
+			switch (opcode) {
+			case BPF_JEQ:
+				return 1;
+			case BPF_JNE:
+				return 0;
+			default:
+				return -1;
+			}
+		}
 		if (!reg_type_not_null(reg->type))
 			return -1;
=20
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index f4c615fbf64f..bb556c449cf0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5433,6 +5433,34 @@ union bpf_attr {
  *
  *	Return
  *		0
+ *
+ * long bpf_rbtree_first(struct bpf_map *map)
+ *	Description
+ *		Return the first node in the tree according to sort order
+ *
+ *	Return
+ *		If found, ptr to node, otherwise NULL
+ *
+ * long bpf_rbtree_last(struct bpf_map *map)
+ *	Description
+ *		Return the last node in the tree according to sort order
+ *
+ *	Return
+ *		If found, ptr to node, otherwise NULL
+ *
+ * long bpf_rbtree_next(struct bpf_map *map, void *cur)
+ *	Description
+ *		Return the next node in the tree according to sort order
+ *
+ *	Return
+ *		If found, ptr to node, otherwise NULL
+ *
+ * long bpf_rbtree_prev(struct bpf_map *map, void *cur)
+ *	Description
+ *		Return the previous node in the tree according to sort order
+ *
+ *	Return
+ *		If found, ptr to node, otherwise NULL
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5652,6 +5680,10 @@ union bpf_attr {
 	FN(rbtree_get_lock),		\
 	FN(rbtree_lock),		\
 	FN(rbtree_unlock),		\
+	FN(rbtree_first),		\
+	FN(rbtree_last),		\
+	FN(rbtree_next),		\
+	FN(rbtree_prev),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

