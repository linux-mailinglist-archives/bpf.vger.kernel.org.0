Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456F157E69C
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiGVSfI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiGVSfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB29FE28
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:03 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MHtoeG002335
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9jUdTz2V+EjxQdQYojBl1SW1YXrs04wGf0Gm8IONLJ0=;
 b=ZqxsljRYOG8HAolqFQM9O4gcnc+0yg39P7PYVpP5IN5cdymFfJNVQm5c5ssFCxCC7hFT
 eJ/i7gIs5nlYwM/fv5DXDgd8v6Wb7PYX7c5IyQ9HuDq10GptWWWmx7bIgdAw3EbligB2
 FyU1QB7cs9rosUhfWQcjrQC5WD+LKhPioCU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hg0qp87hu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:03 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:35:02 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id BBFC6AB6F1AB; Fri, 22 Jul 2022 11:34:51 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 10/11] bpf: Introduce PTR_ITER and PTR_ITER_END type flags
Date:   Fri, 22 Jul 2022 11:34:37 -0700
Message-ID: <20220722183438.3319790-11-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CTAYvy-Gp9E05K1NLO0EgCQJvKofno1y
X-Proofpoint-GUID: CTAYvy-Gp9E05K1NLO0EgCQJvKofno1y
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
 include/uapi/linux/bpf.h       | 34 ++++++++++++++-
 kernel/bpf/helpers.c           | 12 ++++++
 kernel/bpf/rbtree.c            | 78 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 53 +++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 34 ++++++++++++++-
 6 files changed, 209 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a601ab30a2b1..819778e05060 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -416,6 +416,9 @@ enum bpf_type_flag {
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
index d21e2c99ea14..3869653c6aeb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5409,6 +5409,34 @@ union bpf_attr {
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
@@ -5620,13 +5648,17 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(rbtree_alloc_node),		\
-	FN(rbtree_add),		\
+	FN(rbtree_add),			\
 	FN(rbtree_find),		\
 	FN(rbtree_remove),		\
 	FN(rbtree_free_node),		\
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
index fa2dba1dcec8..fdc505139b99 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1592,6 +1592,10 @@ const struct bpf_func_proto bpf_rbtree_free_node_p=
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
@@ -1697,6 +1701,14 @@ bpf_base_func_proto(enum bpf_func_id func_id)
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
index dcf8f69d4ada..f1a06c340d88 100644
--- a/kernel/bpf/rbtree.c
+++ b/kernel/bpf/rbtree.c
@@ -140,6 +140,84 @@ const struct bpf_func_proto bpf_rbtree_find_proto =3D=
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
+	.ret_btf_id =3D &bpf_rbtree_btf_ids[0],
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
+	.ret_btf_id =3D &bpf_rbtree_btf_ids[0],
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
+	.ret_btf_id =3D &bpf_rbtree_btf_ids[0],
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_PTR_TO_BTF_ID | PTR_ITER,
+	.arg2_btf_id =3D &bpf_rbtree_btf_ids[0],
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
+	.ret_btf_id =3D &bpf_rbtree_btf_ids[0],
+	.arg1_type =3D ARG_CONST_MAP_PTR,
+	.arg2_type =3D ARG_PTR_TO_BTF_ID | PTR_ITER,
+	.arg2_btf_id =3D &bpf_rbtree_btf_ids[0],
+};
+
 /* Like rbtree_postorder_for_each_entry_safe, but 'pos' and 'n' are
  * 'rb_node *', so field name of rb_node within containing struct is not
  * needed.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f80e161170de..e1580a01cfe3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -482,6 +482,11 @@ static bool type_may_be_null(u32 type)
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
@@ -547,14 +552,20 @@ static bool function_manipulates_rbtree_node(enum b=
pf_func_id func_id)
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
 {
 	return func_id =3D=3D BPF_FUNC_rbtree_alloc_node ||
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
@@ -614,6 +625,12 @@ static const char *reg_type_str(struct bpf_verifier_=
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
@@ -1428,7 +1445,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_st=
ate *reg)
 			   map->map_type =3D=3D BPF_MAP_TYPE_SOCKHASH) {
 			reg->type =3D PTR_TO_SOCKET;
 		} else {
-			reg->type =3D PTR_TO_MAP_VALUE;
+			reg->type &=3D ~PTR_MAYBE_NULL;
 		}
 		return;
 	}
@@ -3021,6 +3038,11 @@ static bool __is_pointer_value(bool allow_ptr_leak=
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
@@ -5666,6 +5688,8 @@ static const struct bpf_reg_types map_key_value_typ=
es =3D {
 		PTR_TO_PACKET_META,
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
+		PTR_TO_MAP_VALUE | PTR_ITER,
+		PTR_TO_MAP_VALUE | PTR_ITER_END,
 	},
 };
=20
@@ -5793,6 +5817,17 @@ static int check_reg_type(struct bpf_verifier_env =
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
@@ -5802,6 +5837,7 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 			goto found;
 	}
=20
+not_found:
 	verbose(env, "R%d type=3D%s expected=3D", regno, reg_type_str(env, reg-=
>type));
 	for (j =3D 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
@@ -9762,6 +9798,17 @@ static int is_branch_taken(struct bpf_reg_state *r=
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
index d21e2c99ea14..3869653c6aeb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5409,6 +5409,34 @@ union bpf_attr {
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
@@ -5620,13 +5648,17 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(rbtree_alloc_node),		\
-	FN(rbtree_add),		\
+	FN(rbtree_add),			\
 	FN(rbtree_find),		\
 	FN(rbtree_remove),		\
 	FN(rbtree_free_node),		\
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

