Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D6646325
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLGVRs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLGVRr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:17:47 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD727FF3
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 13:17:45 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id 14EFA135539B; Wed,  7 Dec 2022 12:56:48 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kernel-team@meta.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 4/6] bpf: Add bpf_dynptr_clone
Date:   Wed,  7 Dec 2022 12:55:35 -0800
Message-Id: <20221207205537.860248-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221207205537.860248-1-joannelkoong@gmail.com>
References: <20221207205537.860248-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new helper, bpf_dynptr_clone, which clones a dynptr.

The cloned dynptr will point to the same data as its parent dynptr,
with the same type, offset, size and read-only properties.

Any writes to a dynptr will be reflected across all instances
(by 'instance', this means any dynptrs that point to the same
underlying data).

Please note that data slice and dynptr invalidations will affect all
instances as well. For example, if bpf_dynptr_write() is called on an
skb-type dynptr, all data slices of dynptr instances to that skb
will be invalidated as well (eg data slices of any clones, parents,
grandparents, ...). Another example is if a ringbuf dynptr is submitted,
any instance of that dynptr will be invalidated.

Changing the view of the dynptr (eg advancing the offset or
trimming the size) will only affect that dynptr and not affect any
other instances.

One example use case where cloning may be helpful is for hashing or
iterating through dynptr data. Cloning will allow the user to maintain
the original view of the dynptr for future use, while also allowing
views to smaller subsets of the data after the offset is advanced or the
size is trimmed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       |  26 +++++++
 kernel/bpf/helpers.c           |  34 ++++++++
 kernel/bpf/verifier.c          | 138 +++++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h |  26 +++++++
 4 files changed, 173 insertions(+), 51 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5ad52d481cde..f9387c5aba2b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5594,6 +5594,31 @@ union bpf_attr {
  *	Return
  *		The offset of the dynptr on success, -EINVAL if the dynptr is
  *		invalid.
+ *
+ * long bpf_dynptr_clone(struct bpf_dynptr *ptr, struct bpf_dynptr *clon=
e, u32 offset)
+ *	Description
+ *		Clone an initialized dynptr *ptr*. After this call, both *ptr*
+ *		and *clone* will point to the same underlying data. If non-zero,
+ *		*offset* specifies how many bytes to advance the cloned dynptr by.
+ *
+ *		*clone* must be an uninitialized dynptr.
+ *
+ *		Any data slice or dynptr invalidations will apply equally for
+ *		both dynptrs after this call. For example, if ptr1 is a
+ *		ringbuf-type dynptr with multiple data slices that is cloned to
+ *		ptr2, if ptr2 discards the ringbuf sample, then ptr2, ptr2's
+ *		data slices, ptr1, and ptr1's data slices will all be
+ *		invalidated.
+ *
+ *		This is convenient for getting different "views" to the same
+ *		data. For instance, if one wishes to hash only a particular
+ *		section of data, one can clone the dynptr, advance it to a
+ *		specified offset and trim it to a specified size, pass it
+ *		to the hash function, and discard it after hashing, without
+ *		losing access to the original view of the dynptr.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr to clone is invalid, -ERANGE
+ *		if attempting to clone the dynptr at an out of range offset.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5816,6 +5841,7 @@ union bpf_attr {
 	FN(dynptr_is_rdonly, 217, ##ctx)		\
 	FN(dynptr_get_size, 218, ##ctx)		\
 	FN(dynptr_get_offset, 219, ##ctx)		\
+	FN(dynptr_clone, 220, ##ctx)			\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0164d7e4b5a6..0c2cfb4ed33c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1760,6 +1760,38 @@ static const struct bpf_func_proto bpf_dynptr_get_=
offset_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
 };
=20
+BPF_CALL_3(bpf_dynptr_clone, struct bpf_dynptr_kern *, ptr,
+	   struct bpf_dynptr_kern *, clone, u32, offset)
+{
+	int err =3D -EINVAL;
+
+	if (!ptr->data)
+		goto error;
+
+	memcpy(clone, ptr, sizeof(*clone));
+
+	if (offset) {
+		err =3D bpf_dynptr_adjust(clone, offset, offset);
+		if (err)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	bpf_dynptr_set_null(clone);
+	return err;
+}
+
+static const struct bpf_func_proto bpf_dynptr_clone_proto =3D {
+	.func		=3D bpf_dynptr_clone,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_PTR_TO_DYNPTR | MEM_UNINIT,
+	.arg3_type	=3D ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1876,6 +1908,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_get_size_proto;
 	case BPF_FUNC_dynptr_get_offset:
 		return &bpf_dynptr_get_offset_proto;
+	case BPF_FUNC_dynptr_clone:
+		return &bpf_dynptr_clone_proto;
 #ifdef CONFIG_CGROUPS
 	case BPF_FUNC_cgrp_storage_get:
 		return &bpf_cgrp_storage_get_proto;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4d81d159254b..3f617f7040b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -719,17 +719,53 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum=
 bpf_arg_type arg_type)
 	}
 }
=20
+static bool arg_type_is_dynptr(enum bpf_arg_type type)
+{
+	return base_type(type) =3D=3D ARG_PTR_TO_DYNPTR;
+}
+
 static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 {
 	return type =3D=3D BPF_DYNPTR_TYPE_RINGBUF;
 }
=20
-static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
-				   enum bpf_arg_type arg_type, int insn_idx)
+static struct bpf_reg_state *get_dynptr_arg_reg(const struct bpf_func_pr=
oto *fn,
+						struct bpf_reg_state *regs)
+{
+	enum bpf_arg_type t;
+	int i;
+
+	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+		t =3D fn->arg_type[i];
+		if (arg_type_is_dynptr(t) && !(t & MEM_UNINIT))
+			return &regs[BPF_REG_1 + i];
+	}
+
+	return NULL;
+}
+
+static enum bpf_dynptr_type stack_slot_get_dynptr_info(struct bpf_verifi=
er_env *env,
+						       struct bpf_reg_state *reg,
+						       int *ref_obj_id)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	int spi =3D get_spi(reg->off);
+
+	if (ref_obj_id)
+		*ref_obj_id =3D state->stack[spi].spilled_ptr.id;
+
+	return state->stack[spi].spilled_ptr.dynptr.type;
+}
+
+static int mark_stack_slots_dynptr(struct bpf_verifier_env *env,
+				   const struct bpf_func_proto *fn,
+				   struct bpf_reg_state *reg,
+				   enum bpf_arg_type arg_type,
+				   int insn_idx, int func_id)
 {
 	struct bpf_func_state *state =3D func(env, reg);
 	enum bpf_dynptr_type type;
-	int spi, i, id;
+	int spi, i, id =3D 0;
=20
 	spi =3D get_spi(reg->off);
=20
@@ -741,7 +777,21 @@ static int mark_stack_slots_dynptr(struct bpf_verifi=
er_env *env, struct bpf_reg_
 		state->stack[spi - 1].slot_type[i] =3D STACK_DYNPTR;
 	}
=20
-	type =3D arg_to_dynptr_type(arg_type);
+	if (func_id =3D=3D BPF_FUNC_dynptr_clone) {
+		/* find the type and id of the dynptr we're cloning and
+		 * assign it to the clone
+		 */
+		struct bpf_reg_state *parent_state =3D get_dynptr_arg_reg(fn, state->r=
egs);
+
+		if (!parent_state) {
+			verbose(env, "verifier internal error: no parent dynptr in bpf_dynptr=
_clone()\n");
+			return -EFAULT;
+		}
+		type =3D stack_slot_get_dynptr_info(env, parent_state, &id);
+	} else {
+		type =3D arg_to_dynptr_type(arg_type);
+	}
+
 	if (type =3D=3D BPF_DYNPTR_TYPE_INVALID)
 		return -EINVAL;
=20
@@ -751,9 +801,11 @@ static int mark_stack_slots_dynptr(struct bpf_verifi=
er_env *env, struct bpf_reg_
=20
 	if (dynptr_type_refcounted(type)) {
 		/* The id is used to track proper releasing */
-		id =3D acquire_reference_state(env, insn_idx);
-		if (id < 0)
-			return id;
+		if (!id) {
+			id =3D acquire_reference_state(env, insn_idx);
+			if (id < 0)
+				return id;
+		}
=20
 		state->stack[spi].spilled_ptr.id =3D id;
 		state->stack[spi - 1].spilled_ptr.id =3D id;
@@ -762,6 +814,17 @@ static int mark_stack_slots_dynptr(struct bpf_verifi=
er_env *env, struct bpf_reg_
 	return 0;
 }
=20
+static void invalidate_dynptr(struct bpf_func_state *state, int spi)
+{
+	int i;
+
+	state->stack[spi].spilled_ptr.id =3D 0;
+	for (i =3D 0; i < BPF_REG_SIZE; i++)
+		state->stack[spi].slot_type[i] =3D STACK_INVALID;
+	state->stack[spi].spilled_ptr.dynptr.first_slot =3D false;
+	state->stack[spi].spilled_ptr.dynptr.type =3D 0;
+}
+
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
 {
 	struct bpf_func_state *state =3D func(env, reg);
@@ -772,22 +835,25 @@ static int unmark_stack_slots_dynptr(struct bpf_ver=
ifier_env *env, struct bpf_re
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
=20
-	for (i =3D 0; i < BPF_REG_SIZE; i++) {
-		state->stack[spi].slot_type[i] =3D STACK_INVALID;
-		state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
-	}
-
-	/* Invalidate any slices associated with this dynptr */
 	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) =
{
+		int id =3D state->stack[spi].spilled_ptr.id;
+
+		/* If the dynptr is refcounted, we need to invalidate two things:
+		 * 1) any dynptrs with a matching id
+		 * 2) any slices associated with the dynptr id
+		 */
+
 		release_reference(env, state->stack[spi].spilled_ptr.id);
-		state->stack[spi].spilled_ptr.id =3D 0;
-		state->stack[spi - 1].spilled_ptr.id =3D 0;
+		for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+			if (state->stack[i].slot_type[0] =3D=3D STACK_DYNPTR &&
+			    state->stack[i].spilled_ptr.id =3D=3D id)
+				invalidate_dynptr(state, i);
+		}
+	} else {
+		invalidate_dynptr(state, spi);
+		invalidate_dynptr(state, spi - 1);
 	}
=20
-	state->stack[spi].spilled_ptr.dynptr.first_slot =3D false;
-	state->stack[spi].spilled_ptr.dynptr.type =3D 0;
-	state->stack[spi - 1].spilled_ptr.dynptr.type =3D 0;
-
 	return 0;
 }
=20
@@ -5862,11 +5928,6 @@ static bool arg_type_is_release(enum bpf_arg_type =
type)
 	return type & OBJ_RELEASE;
 }
=20
-static bool arg_type_is_dynptr(enum bpf_arg_type type)
-{
-	return base_type(type) =3D=3D ARG_PTR_TO_DYNPTR;
-}
-
 static int int_ptr_type_to_size(enum bpf_arg_type type)
 {
 	if (type =3D=3D ARG_PTR_TO_INT)
@@ -6176,31 +6237,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
=20
-static struct bpf_reg_state *get_dynptr_arg_reg(const struct bpf_func_pr=
oto *fn,
-						struct bpf_reg_state *regs)
-{
-	int i;
-
-	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
-		if (arg_type_is_dynptr(fn->arg_type[i]))
-			return &regs[BPF_REG_1 + i];
-
-	return NULL;
-}
-
-static enum bpf_dynptr_type stack_slot_get_dynptr_info(struct bpf_verifi=
er_env *env,
-						       struct bpf_reg_state *reg,
-						       int *ref_obj_id)
-{
-	struct bpf_func_state *state =3D func(env, reg);
-	int spi =3D get_spi(reg->off);
-
-	if (ref_obj_id)
-		*ref_obj_id =3D state->stack[spi].spilled_ptr.id;
-
-	return state->stack[spi].spilled_ptr.dynptr.type;
-}
-
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -7697,9 +7733,9 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 				return err;
 		}
=20
-		err =3D mark_stack_slots_dynptr(env, &regs[meta.uninit_dynptr_regno],
+		err =3D mark_stack_slots_dynptr(env, fn, &regs[meta.uninit_dynptr_regn=
o],
 					      fn->arg_type[meta.uninit_dynptr_regno - BPF_REG_1],
-					      insn_idx);
+					      insn_idx, func_id);
 		if (err)
 			return err;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 5ad52d481cde..f9387c5aba2b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5594,6 +5594,31 @@ union bpf_attr {
  *	Return
  *		The offset of the dynptr on success, -EINVAL if the dynptr is
  *		invalid.
+ *
+ * long bpf_dynptr_clone(struct bpf_dynptr *ptr, struct bpf_dynptr *clon=
e, u32 offset)
+ *	Description
+ *		Clone an initialized dynptr *ptr*. After this call, both *ptr*
+ *		and *clone* will point to the same underlying data. If non-zero,
+ *		*offset* specifies how many bytes to advance the cloned dynptr by.
+ *
+ *		*clone* must be an uninitialized dynptr.
+ *
+ *		Any data slice or dynptr invalidations will apply equally for
+ *		both dynptrs after this call. For example, if ptr1 is a
+ *		ringbuf-type dynptr with multiple data slices that is cloned to
+ *		ptr2, if ptr2 discards the ringbuf sample, then ptr2, ptr2's
+ *		data slices, ptr1, and ptr1's data slices will all be
+ *		invalidated.
+ *
+ *		This is convenient for getting different "views" to the same
+ *		data. For instance, if one wishes to hash only a particular
+ *		section of data, one can clone the dynptr, advance it to a
+ *		specified offset and trim it to a specified size, pass it
+ *		to the hash function, and discard it after hashing, without
+ *		losing access to the original view of the dynptr.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr to clone is invalid, -ERANGE
+ *		if attempting to clone the dynptr at an out of range offset.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5816,6 +5841,7 @@ union bpf_attr {
 	FN(dynptr_is_rdonly, 217, ##ctx)		\
 	FN(dynptr_get_size, 218, ##ctx)		\
 	FN(dynptr_get_offset, 219, ##ctx)		\
+	FN(dynptr_clone, 220, ##ctx)			\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
--=20
2.30.2

