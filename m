Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381224EFDE2
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 04:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiDBCBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 22:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiDBCBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 22:01:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D21168CF
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 18:59:59 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C6ZB031458
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 18:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2YAf5q6KM4iE7dXEo+r6ry350vZoIXuunsGbwbeR5KA=;
 b=W3xI3jB7x6WVzorR4NqIvJrgObzscL3eEPVK+e81MtNTnkO+tpzsCnEnxiHMRWkP9RJ8
 MnPla/Y5oNlxqoQs8l64P3/j+7aCiRrxyzFZIUGUxIw+k8bMPjTdwiRey4cG6llzRMRy
 3zkSWTBjMWSYnNu5lcxKtcEbruR7uMCyJ6s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpgaxa5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 18:59:58 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 18:59:57 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 0A710A79067E; Fri,  1 Apr 2022 18:59:43 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 5/7] bpf: Add dynptr data slices
Date:   Fri, 1 Apr 2022 18:58:24 -0700
Message-ID: <20220402015826.3941317-6-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402015826.3941317-1-joannekoong@fb.com>
References: <20220402015826.3941317-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NFoSrjq3o7k66SZTBhic9fvvvbIJSz3g
X-Proofpoint-GUID: NFoSrjq3o7k66SZTBhic9fvvvbIJSz3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

This patch adds a new helper function

void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);

which returns a pointer to the underlying data of a dynptr. *len*
must be a statically known value. The bpf program may access the returned
data slice as a normal buffer (eg can do direct reads and writes), since
the verifier associates the length with the returned pointer, and
enforces that no out of bounds accesses occur.

This requires a few additions to the verifier. For every
referenced-tracked dynptr that is initialized, we associate an id with
it and attach any data slices to that id. When a release function is
called on a dynptr (eg bpf_free), we invalidate all slices that
correspond to that dynptr. This ensures the slice can't be used after
its dynptr has been invalidated.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf_verifier.h   |  2 +
 include/uapi/linux/bpf.h       | 12 ++++++
 kernel/bpf/helpers.c           | 28 ++++++++++++++
 kernel/bpf/verifier.c          | 70 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 12 ++++++
 5 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bc0f105148f9..4862567af5ef 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -100,6 +100,8 @@ struct bpf_reg_state {
 	 * for the purpose of tracking that it's freed.
 	 * For PTR_TO_SOCKET this is used to share which pointers retain the
 	 * same reference to the socket, to determine proper reference freeing.
+	 * For stack slots that are dynptrs, this is used to track references t=
o
+	 * the dynptr to enforce proper reference freeing.
 	 */
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 16a35e46be90..c835e437cb28 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5191,6 +5191,17 @@ union bpf_attr {
  *	Return
  *		0 on success, -EINVAL if *offset* + *len* exceeds the length
  *		of *dst*'s data or if *dst* is not writeable.
+ *
+ * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ *	Description
+ *		Get a pointer to the underlying dynptr data.
+ *
+ *		*len* must be a statically known value. The returned data slice
+ *		is invalidated whenever the dynptr is invalidated.
+ *	Return
+ *		Pointer to the underlying dynptr data, NULL if the ptr is
+ *		read-only, if the dynptr is invalid, or if the offset and length
+ *		is out of bounds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5392,6 +5403,7 @@ union bpf_attr {
 	FN(free),			\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ec20e79928e..c1295fb5d9d4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1412,6 +1412,32 @@ const struct bpf_func_proto bpf_dynptr_from_mem_pr=
oto =3D {
 	.arg3_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
 };
=20
+BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, =
u32, len)
+{
+	int err;
+
+	if (!ptr->data)
+		return 0;
+
+	err =3D bpf_dynptr_check_off_len(ptr, offset, len);
+	if (err)
+		return 0;
+
+	if (bpf_dynptr_is_rdonly(ptr))
+		return 0;
+
+	return (unsigned long)(ptr->data + ptr->offset + offset);
+}
+
+const struct bpf_func_proto bpf_dynptr_data_proto =3D {
+	.func		=3D bpf_dynptr_data,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_ALLOC_MEM_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
+};
+
 BPF_CALL_4(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_ker=
n *, src, u32, offset)
 {
 	int err;
@@ -1570,6 +1596,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_read_proto;
 	case BPF_FUNC_dynptr_write:
 		return &bpf_dynptr_write_proto;
+	case BPF_FUNC_dynptr_data:
+		return &bpf_dynptr_data_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cb3bcb54d4b4..7352ffb4f9a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -187,6 +187,11 @@ struct bpf_verifier_stack_elem {
 					  POISON_POINTER_DELTA))
 #define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
=20
+/* forward declarations */
+static void release_reg_references(struct bpf_verifier_env *env,
+				   struct bpf_func_state *state,
+				   int ref_obj_id);
+
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
 	return BPF_MAP_PTR(aux->map_ptr_state) =3D=3D BPF_MAP_PTR_POISON;
@@ -523,6 +528,11 @@ static bool is_ptr_cast_function(enum bpf_func_id fu=
nc_id)
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
 }
=20
+static inline bool is_dynptr_ref_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_dynptr_data;
+}
+
 static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 {
 	return BPF_CLASS(insn->code) =3D=3D BPF_STX &&
@@ -700,7 +710,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifie=
r_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state =3D cur_func(env);
 	enum bpf_dynptr_type type;
-	int spi, i, err;
+	int spi, id, i, err;
=20
 	spi =3D get_spi(reg->off);
=20
@@ -721,12 +731,27 @@ static int mark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_reg_
=20
 	state->stack[spi].spilled_ptr.dynptr_first_slot =3D true;
=20
+	/* Generate an id for the dynptr if the dynptr type can be
+	 * acquired/released.
+	 *
+	 * This is used to associated data slices with dynptrs, so that
+	 * if a dynptr gets invalidated, its data slices will also be
+	 * invalidated.
+	 */
+	if (dynptr_type_refcounted(state, spi)) {
+		id =3D ++env->id_gen;
+		state->stack[spi].spilled_ptr.id =3D id;
+		state->stack[spi - 1].spilled_ptr.id =3D id;
+	}
+
 	return 0;
 }
=20
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
 {
+	struct bpf_verifier_state *vstate =3D env->cur_state;
 	struct bpf_func_state *state =3D func(env, reg);
+	bool refcounted;
 	int spi, i;
=20
 	spi =3D get_spi(reg->off);
@@ -734,6 +759,8 @@ static int unmark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_re
 	if (!check_spi_bounds(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
=20
+	refcounted =3D dynptr_type_refcounted(state, spi);
+
 	for (i =3D 0; i < BPF_REG_SIZE; i++) {
 		state->stack[spi].slot_type[i] =3D STACK_INVALID;
 		state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
@@ -743,6 +770,15 @@ static int unmark_stack_slots_dynptr(struct bpf_veri=
fier_env *env, struct bpf_re
 	state->stack[spi].spilled_ptr.dynptr_first_slot =3D 0;
 	state->stack[spi - 1].spilled_ptr.dynptr_type =3D 0;
=20
+	/* Invalidate any slices associated with this dynptr */
+	if (refcounted) {
+		for (i =3D 0; i <=3D vstate->curframe; i++)
+			release_reg_references(env, vstate->frame[i],
+					       state->stack[spi].spilled_ptr.id);
+		state->stack[spi].spilled_ptr.id =3D 0;
+		state->stack[spi - 1].spilled_ptr.id =3D 0;
+	}
+
 	return 0;
 }
=20
@@ -780,6 +816,19 @@ static bool check_dynptr_init(struct bpf_verifier_en=
v *env, struct bpf_reg_state
 	return state->stack[spi].spilled_ptr.dynptr_type =3D=3D expected_type;
 }
=20
+static bool is_ref_obj_id_dynptr(struct bpf_func_state *state, u32 id)
+{
+	int i;
+
+	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+		if (state->stack[i].slot_type[0] =3D=3D STACK_DYNPTR &&
+		    state->stack[i].spilled_ptr.id =3D=3D id)
+			return true;
+	}
+
+	return false;
+}
+
 static bool stack_access_into_dynptr(struct bpf_func_state *state, int s=
pi, int size)
 {
 	int nr_slots, i;
@@ -5585,6 +5634,14 @@ static bool id_in_stack_slot(enum bpf_arg_type arg=
_type)
 	return arg_type_is_dynptr(arg_type);
 }
=20
+static inline u32 stack_slot_get_id(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	int spi =3D get_spi(reg->off);
+
+	return state->stack[spi].spilled_ptr.id;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -7114,6 +7171,14 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		regs[BPF_REG_0].id =3D id;
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D id;
+	} else if (is_dynptr_ref_function(func_id)) {
+		/* Retrieve the id of the associated dynptr. */
+		int id =3D stack_slot_get_id(env, &regs[BPF_REG_1]);
+
+		if (id < 0)
+			return id;
+		regs[BPF_REG_0].id =3D id;
+		regs[BPF_REG_0].ref_obj_id =3D id;
 	}
=20
 	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
@@ -9545,7 +9610,8 @@ static void mark_ptr_or_null_regs(struct bpf_verifi=
er_state *vstate, u32 regno,
 	u32 id =3D regs[regno].id;
 	int i;
=20
-	if (ref_obj_id && ref_obj_id =3D=3D id && is_null)
+	if (ref_obj_id && ref_obj_id =3D=3D id && is_null &&
+	    !is_ref_obj_id_dynptr(state, id))
 		/* regs[regno] is in the " =3D=3D NULL" branch.
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 16a35e46be90..c835e437cb28 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5191,6 +5191,17 @@ union bpf_attr {
  *	Return
  *		0 on success, -EINVAL if *offset* + *len* exceeds the length
  *		of *dst*'s data or if *dst* is not writeable.
+ *
+ * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ *	Description
+ *		Get a pointer to the underlying dynptr data.
+ *
+ *		*len* must be a statically known value. The returned data slice
+ *		is invalidated whenever the dynptr is invalidated.
+ *	Return
+ *		Pointer to the underlying dynptr data, NULL if the ptr is
+ *		read-only, if the dynptr is invalid, or if the offset and length
+ *		is out of bounds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5392,6 +5403,7 @@ union bpf_attr {
 	FN(free),			\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

