Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C1646337
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLGVZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGVZm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:25:42 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F3AB9C
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 13:25:41 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id D31B313553A4; Wed,  7 Dec 2022 12:56:48 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kernel-team@meta.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 5/6] bpf: Add bpf_dynptr_iterator
Date:   Wed,  7 Dec 2022 12:55:36 -0800
Message-Id: <20221207205537.860248-6-joannelkoong@gmail.com>
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

Add a new helper function, bpf_dynptr_iterator:

  long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
			   void *callback_ctx, u64 flags)

where callback_fn is defined as:

  long (*callback_fn)(struct bpf_dynptr *ptr, void *ctx)

and callback_fn returns the number of bytes to advance the
dynptr by (or an error code in the case of error). The iteration
will stop if the callback_fn returns 0 or an error or tries to
advance by more bytes than available.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       | 25 +++++++++
 kernel/bpf/helpers.c           | 42 +++++++++++++++
 kernel/bpf/verifier.c          | 93 ++++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h | 25 +++++++++
 4 files changed, 170 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f9387c5aba2b..11c7e1e52f4d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5619,6 +5619,30 @@ union bpf_attr {
  *	Return
  *		0 on success, -EINVAL if the dynptr to clone is invalid, -ERANGE
  *		if attempting to clone the dynptr at an out of range offset.
+ *
+ * long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn, v=
oid *callback_ctx, u64 flags)
+ *	Description
+ *		Iterate through the dynptr data, calling **callback_fn** on each
+ *		iteration with **callback_ctx** as the context parameter.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		Currently **flags** is unused and must be 0.
+ *
+ *		int (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
+ *
+ *		where **callback_fn** returns the number of bytes to advance
+ *		the callback dynptr by or an error. The iteration will stop if
+ *		**callback_fn** returns 0 or an error or tries to advance by more
+ *		bytes than the remaining size.
+ *
+ *		Please note that **ptr** will remain untouched (eg offset and
+ *		size will not be modified) though the data pointed to by **ptr**
+ *		may have been modified. Please also note that you cannot release
+ *		a dynptr within the callback function.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0=
,
+ *		-ERANGE if attempting to iterate more bytes than available, or other
+ *		error code if **callback_fn** returns an error.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5842,6 +5866,7 @@ union bpf_attr {
 	FN(dynptr_get_size, 218, ##ctx)		\
 	FN(dynptr_get_offset, 219, ##ctx)		\
 	FN(dynptr_clone, 220, ##ctx)			\
+	FN(dynptr_iterator, 221, ##ctx)			\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0c2cfb4ed33c..0e612007601e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1792,6 +1792,46 @@ static const struct bpf_func_proto bpf_dynptr_clon=
e_proto =3D {
 	.arg3_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_4(bpf_dynptr_iterator, struct bpf_dynptr_kern *, ptr, void *, c=
allback_fn,
+	   void *, callback_ctx, u64, flags)
+{
+	bpf_callback_t callback =3D (bpf_callback_t)callback_fn;
+	struct bpf_dynptr_kern ptr_copy;
+	int nr_bytes, err;
+
+	if (flags)
+		return -EINVAL;
+
+	err =3D ____bpf_dynptr_clone(ptr, &ptr_copy, 0);
+	if (err)
+		return err;
+
+	while (ptr_copy.size > 0) {
+		nr_bytes =3D callback((uintptr_t)&ptr_copy, (uintptr_t)callback_ctx, 0=
, 0, 0);
+		if (nr_bytes <=3D 0)
+			return nr_bytes;
+
+		if (nr_bytes > U32_MAX)
+			return -ERANGE;
+
+		err =3D bpf_dynptr_adjust(&ptr_copy, nr_bytes, nr_bytes);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_dynptr_iterator_proto =3D {
+	.func		=3D bpf_dynptr_iterator,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_PTR_TO_FUNC,
+	.arg3_type	=3D ARG_PTR_TO_STACK_OR_NULL,
+	.arg4_type	=3D ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1910,6 +1950,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_get_offset_proto;
 	case BPF_FUNC_dynptr_clone:
 		return &bpf_dynptr_clone_proto;
+	case BPF_FUNC_dynptr_iterator:
+		return &bpf_dynptr_iterator_proto;
 #ifdef CONFIG_CGROUPS
 	case BPF_FUNC_cgrp_storage_get:
 		return &bpf_cgrp_storage_get_proto;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3f617f7040b7..8abdc392a48e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -524,7 +524,8 @@ static bool is_callback_calling_function(enum bpf_fun=
c_id func_id)
 	       func_id =3D=3D BPF_FUNC_timer_set_callback ||
 	       func_id =3D=3D BPF_FUNC_find_vma ||
 	       func_id =3D=3D BPF_FUNC_loop ||
-	       func_id =3D=3D BPF_FUNC_user_ringbuf_drain;
+	       func_id =3D=3D BPF_FUNC_user_ringbuf_drain ||
+	       func_id =3D=3D BPF_FUNC_dynptr_iterator;
 }
=20
 static bool is_storage_get_function(enum bpf_func_id func_id)
@@ -703,6 +704,19 @@ static void mark_verifier_state_scratched(struct bpf=
_verifier_env *env)
 	env->scratched_stack_slots =3D ~0ULL;
 }
=20
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
 static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_typ=
e)
 {
 	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
@@ -719,6 +733,25 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum =
bpf_arg_type arg_type)
 	}
 }
=20
+static enum bpf_type_flag dynptr_flag_type(struct bpf_verifier_env *env,
+					   struct bpf_reg_state *state)
+{
+	enum bpf_dynptr_type type =3D stack_slot_get_dynptr_info(env, state, NU=
LL);
+
+	switch (type) {
+	case BPF_DYNPTR_TYPE_LOCAL:
+		return DYNPTR_TYPE_LOCAL;
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		return DYNPTR_TYPE_RINGBUF;
+	case BPF_DYNPTR_TYPE_SKB:
+		return DYNPTR_TYPE_SKB;
+	case BPF_DYNPTR_TYPE_XDP:
+		return DYNPTR_TYPE_XDP;
+	default:
+		return 0;
+	}
+}
+
 static bool arg_type_is_dynptr(enum bpf_arg_type type)
 {
 	return base_type(type) =3D=3D ARG_PTR_TO_DYNPTR;
@@ -744,19 +777,6 @@ static struct bpf_reg_state *get_dynptr_arg_reg(cons=
t struct bpf_func_proto *fn,
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
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env,
 				   const struct bpf_func_proto *fn,
 				   struct bpf_reg_state *reg,
@@ -6053,6 +6073,9 @@ static const struct bpf_reg_types dynptr_types =3D =
{
 	.types =3D {
 		PTR_TO_STACK,
 		PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
+		PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF,
+		PTR_TO_DYNPTR | DYNPTR_TYPE_SKB,
+		PTR_TO_DYNPTR | DYNPTR_TYPE_XDP,
 	}
 };
=20
@@ -6440,8 +6463,13 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 		 * assumption is that if it is, that a helper function
 		 * initialized the dynptr on behalf of the BPF program.
 		 */
-		if (base_type(reg->type) =3D=3D PTR_TO_DYNPTR)
+		if (base_type(reg->type) =3D=3D PTR_TO_DYNPTR) {
+			if (arg_type & MEM_UNINIT) {
+				verbose(env, "PTR_TO_DYNPTR is already an initialized dynptr\n");
+				return -EINVAL;
+			}
 			break;
+		}
 		if (arg_type & MEM_UNINIT) {
 			if (!is_dynptr_reg_valid_uninit(env, reg)) {
 				verbose(env, "Dynptr has to be an uninitialized dynptr\n");
@@ -7342,6 +7370,37 @@ static int set_user_ringbuf_callback_state(struct =
bpf_verifier_env *env,
 	return 0;
 }
=20
+static int set_dynptr_iterator_callback_state(struct bpf_verifier_env *e=
nv,
+					      struct bpf_func_state *caller,
+					      struct bpf_func_state *callee,
+					      int insn_idx)
+{
+	/* bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
+	 * void *callback_ctx, u64 flags);
+	 *
+	 * callback_fn(struct bpf_dynptr *ptr, void *callback_ctx);
+	 */
+
+	enum bpf_type_flag dynptr_flag =3D
+		dynptr_flag_type(env, &caller->regs[BPF_REG_1]);
+
+	if (dynptr_flag =3D=3D 0)
+		return -EFAULT;
+
+	callee->regs[BPF_REG_1].type =3D PTR_TO_DYNPTR | dynptr_flag;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
+	callee->regs[BPF_REG_2] =3D caller->regs[BPF_REG_3];
+	callee->callback_ret_range =3D tnum_range(0, U32_MAX);
+
+	/* unused */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+
+	callee->in_callback_fn =3D true;
+	return 0;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
@@ -7857,6 +7916,10 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_user_ringbuf_callback_state);
 		break;
+	case BPF_FUNC_dynptr_iterator:
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_dynptr_iterator_callback_state);
+		break;
 	}
=20
 	if (err)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index f9387c5aba2b..11c7e1e52f4d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5619,6 +5619,30 @@ union bpf_attr {
  *	Return
  *		0 on success, -EINVAL if the dynptr to clone is invalid, -ERANGE
  *		if attempting to clone the dynptr at an out of range offset.
+ *
+ * long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn, v=
oid *callback_ctx, u64 flags)
+ *	Description
+ *		Iterate through the dynptr data, calling **callback_fn** on each
+ *		iteration with **callback_ctx** as the context parameter.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		Currently **flags** is unused and must be 0.
+ *
+ *		int (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
+ *
+ *		where **callback_fn** returns the number of bytes to advance
+ *		the callback dynptr by or an error. The iteration will stop if
+ *		**callback_fn** returns 0 or an error or tries to advance by more
+ *		bytes than the remaining size.
+ *
+ *		Please note that **ptr** will remain untouched (eg offset and
+ *		size will not be modified) though the data pointed to by **ptr**
+ *		may have been modified. Please also note that you cannot release
+ *		a dynptr within the callback function.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0=
,
+ *		-ERANGE if attempting to iterate more bytes than available, or other
+ *		error code if **callback_fn** returns an error.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5842,6 +5866,7 @@ union bpf_attr {
 	FN(dynptr_get_size, 218, ##ctx)		\
 	FN(dynptr_get_offset, 219, ##ctx)		\
 	FN(dynptr_clone, 220, ##ctx)			\
+	FN(dynptr_iterator, 221, ##ctx)			\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
--=20
2.30.2

