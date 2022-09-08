Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137025B10C8
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIHAHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiIHAHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:07:47 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3032B2CE2
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:07:45 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 28780117037F6; Wed,  7 Sep 2022 17:07:35 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 7/8] bpf: Add bpf_dynptr_iterator
Date:   Wed,  7 Sep 2022 17:02:53 -0700
Message-Id: <20220908000254.3079129-8-joannelkoong@gmail.com>
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
 include/uapi/linux/bpf.h       | 20 ++++++++++++++
 kernel/bpf/helpers.c           | 48 +++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c          | 27 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 20 ++++++++++++++
 4 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 16973fa4d073..ff78a94c262a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5531,6 +5531,25 @@ union bpf_attr {
  *		losing access to the original view of the dynptr.
  *	Return
  *		0 on success, -EINVAL if the dynptr to clone is invalid.
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
+ *		long (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
+ *
+ *		where **callback_fn** returns the number of bytes to advance
+ *		the dynptr by or an error. The iteration will stop if **callback_fn*=
*
+ *		returns 0 or an error or tries to advance by more bytes than the
+ *		size of the dynptr.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0=
,
+ *		-ERANGE if attempting to iterate more bytes than available, or other
+ *		negative error if **callback_fn** returns an error.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5752,6 +5771,7 @@ union bpf_attr {
 	FN(dynptr_get_size),		\
 	FN(dynptr_get_offset),		\
 	FN(dynptr_clone),		\
+	FN(dynptr_iterator),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 667f1e213a61..519b3da06d49 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1653,13 +1653,11 @@ static const struct bpf_func_proto bpf_dynptr_dat=
a_proto =3D {
 	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
=20
-BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
+/* *ptr* should always be a valid dynptr */
+static int __bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 len)
 {
 	u32 size;
=20
-	if (!ptr->data)
-		return -EINVAL;
-
 	size =3D __bpf_dynptr_get_size(ptr);
=20
 	if (len > size)
@@ -1672,6 +1670,14 @@ BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_k=
ern *, ptr, u32, len)
 	return 0;
 }
=20
+BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
+{
+	if (!ptr->data)
+		return -EINVAL;
+
+	return __bpf_dynptr_advance(ptr, len);
+}
+
 static const struct bpf_func_proto bpf_dynptr_advance_proto =3D {
 	.func		=3D bpf_dynptr_advance,
 	.gpl_only	=3D false,
@@ -1783,6 +1789,38 @@ static const struct bpf_func_proto bpf_dynptr_clon=
e_proto =3D {
 	.arg2_type	=3D ARG_PTR_TO_DYNPTR | MEM_UNINIT,
 };
=20
+BPF_CALL_4(bpf_dynptr_iterator, struct bpf_dynptr_kern *, ptr, void *, c=
allback_fn,
+	   void *, callback_ctx, u64, flags)
+{
+	bpf_callback_t callback =3D (bpf_callback_t)callback_fn;
+	int nr_bytes, err;
+
+	if (!ptr->data || flags)
+		return -EINVAL;
+
+	while (ptr->size > 0) {
+		nr_bytes =3D callback((u64)(long)ptr, (u64)(long)callback_ctx, 0, 0, 0=
);
+		if (nr_bytes <=3D 0)
+			return nr_bytes;
+
+		err =3D __bpf_dynptr_advance(ptr, nr_bytes);
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
@@ -1869,6 +1907,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_get_offset_proto;
 	case BPF_FUNC_dynptr_clone:
 		return &bpf_dynptr_clone_proto;
+	case BPF_FUNC_dynptr_iterator:
+		return &bpf_dynptr_iterator_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2eb2a4410344..76108cd4ed85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6901,6 +6901,29 @@ static int set_map_elem_callback_state(struct bpf_=
verifier_env *env,
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
+	callee->regs[BPF_REG_1] =3D caller->regs[BPF_REG_1];
+	callee->regs[BPF_REG_2] =3D caller->regs[BPF_REG_3];
+	callee->callback_ret_range =3D tnum_range(0, U64_MAX);
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
 static int set_loop_callback_state(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee,
@@ -7472,6 +7495,10 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
=20
 		break;
 	}
+	case BPF_FUNC_dynptr_iterator:
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_dynptr_iterator_callback_state);
+		break;
 	}
=20
 	if (err)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 16973fa4d073..ff78a94c262a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5531,6 +5531,25 @@ union bpf_attr {
  *		losing access to the original view of the dynptr.
  *	Return
  *		0 on success, -EINVAL if the dynptr to clone is invalid.
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
+ *		long (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
+ *
+ *		where **callback_fn** returns the number of bytes to advance
+ *		the dynptr by or an error. The iteration will stop if **callback_fn*=
*
+ *		returns 0 or an error or tries to advance by more bytes than the
+ *		size of the dynptr.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0=
,
+ *		-ERANGE if attempting to iterate more bytes than available, or other
+ *		negative error if **callback_fn** returns an error.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5752,6 +5771,7 @@ union bpf_attr {
 	FN(dynptr_get_size),		\
 	FN(dynptr_get_offset),		\
 	FN(dynptr_clone),		\
+	FN(dynptr_iterator),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

