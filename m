Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F37C5B10C5
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIHAHp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIHAHp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:07:45 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C1AF4A6
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:07:43 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 0BE5C117037EA; Wed,  7 Sep 2022 17:07:31 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 5/8] bpf: Add bpf_dynptr_clone
Date:   Wed,  7 Sep 2022 17:02:51 -0700
Message-Id: <20220908000254.3079129-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908000254.3079129-1-joannelkoong@gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 include/uapi/linux/bpf.h       |  24 +++++++
 kernel/bpf/helpers.c           |  23 +++++++
 kernel/bpf/verifier.c          | 116 +++++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h |  24 +++++++
 4 files changed, 147 insertions(+), 40 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4ca07cf500d2..16973fa4d073 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5508,6 +5508,29 @@ union bpf_attr {
  *	Return
  *		The offset of the dynptr on success, -EINVAL if the dynptr is
  *		invalid.
+ *
+ * long bpf_dynptr_clone(struct bpf_dynptr *ptr, struct bpf_dynptr *clon=
e)
+ *	Description
+ *		Clone an initialized dynptr *ptr*. After this call, both *ptr*
+ *		and *clone* will point to the same underlying data.
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
+ *		0 on success, -EINVAL if the dynptr to clone is invalid.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5728,6 +5751,7 @@ union bpf_attr {
 	FN(dynptr_is_rdonly),		\
 	FN(dynptr_get_size),		\
 	FN(dynptr_get_offset),		\
+	FN(dynptr_clone),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 62ed27444b73..667f1e213a61 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1762,6 +1762,27 @@ static const struct bpf_func_proto bpf_dynptr_get_=
offset_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
 };
=20
+BPF_CALL_2(bpf_dynptr_clone, struct bpf_dynptr_kern *, ptr,
+	   struct bpf_dynptr_kern *, clone)
+{
+	if (!ptr->data) {
+		bpf_dynptr_set_null(clone);
+		return -EINVAL;
+	}
+
+	memcpy(clone, ptr, sizeof(*clone));
+
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_dynptr_clone_proto =3D {
+	.func		=3D bpf_dynptr_clone,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_PTR_TO_DYNPTR | MEM_UNINIT,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1846,6 +1867,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_get_size_proto;
 	case BPF_FUNC_dynptr_get_offset:
 		return &bpf_dynptr_get_offset_proto;
+	case BPF_FUNC_dynptr_clone:
+		return &bpf_dynptr_clone_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c312d931359d..8c8c101513f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -694,17 +694,38 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum=
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
+static enum bpf_dynptr_type stack_slot_get_dynptr_info(struct bpf_verifi=
er_env *env,
+						       struct bpf_reg_state *reg,
+						       int *ref_obj_id)
 {
 	struct bpf_func_state *state =3D func(env, reg);
-	enum bpf_dynptr_type type;
-	int spi, i, id;
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
+{
+	enum bpf_dynptr_type type =3D BPF_DYNPTR_TYPE_INVALID;
+	struct bpf_func_state *state =3D func(env, reg);
+	int spi, i, id =3D 0;
=20
 	spi =3D get_spi(reg->off);
=20
@@ -716,7 +737,24 @@ static int mark_stack_slots_dynptr(struct bpf_verifi=
er_env *env, struct bpf_reg_
 		state->stack[spi - 1].slot_type[i] =3D STACK_DYNPTR;
 	}
=20
-	type =3D arg_to_dynptr_type(arg_type);
+	if (func_id =3D=3D BPF_FUNC_dynptr_clone) {
+		/* find the type and id of the dynptr we're cloning and
+		 * assign it to the clone
+		 */
+		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+			enum bpf_arg_type t =3D fn->arg_type[i];
+
+			if (arg_type_is_dynptr(t) && !(t & MEM_UNINIT)) {
+				type =3D stack_slot_get_dynptr_info(env,
+								  &state->regs[BPF_REG_1 + i],
+								  &id);
+				break;
+			}
+		}
+	} else {
+		type =3D arg_to_dynptr_type(arg_type);
+	}
+
 	if (type =3D=3D BPF_DYNPTR_TYPE_INVALID)
 		return -EINVAL;
=20
@@ -726,9 +764,11 @@ static int mark_stack_slots_dynptr(struct bpf_verifi=
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
@@ -737,6 +777,17 @@ static int mark_stack_slots_dynptr(struct bpf_verifi=
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
@@ -747,22 +798,25 @@ static int unmark_stack_slots_dynptr(struct bpf_ver=
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
@@ -5578,11 +5632,6 @@ static bool arg_type_is_release(enum bpf_arg_type =
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
@@ -5872,19 +5921,6 @@ static struct bpf_reg_state *get_dynptr_arg_reg(co=
nst struct bpf_func_proto *fn,
 	return NULL;
 }
=20
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
@@ -7317,9 +7353,9 @@ static int check_helper_call(struct bpf_verifier_en=
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
index 4ca07cf500d2..16973fa4d073 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5508,6 +5508,29 @@ union bpf_attr {
  *	Return
  *		The offset of the dynptr on success, -EINVAL if the dynptr is
  *		invalid.
+ *
+ * long bpf_dynptr_clone(struct bpf_dynptr *ptr, struct bpf_dynptr *clon=
e)
+ *	Description
+ *		Clone an initialized dynptr *ptr*. After this call, both *ptr*
+ *		and *clone* will point to the same underlying data.
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
+ *		0 on success, -EINVAL if the dynptr to clone is invalid.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5728,6 +5751,7 @@ union bpf_attr {
 	FN(dynptr_is_rdonly),		\
 	FN(dynptr_get_size),		\
 	FN(dynptr_get_offset),		\
+	FN(dynptr_clone),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

