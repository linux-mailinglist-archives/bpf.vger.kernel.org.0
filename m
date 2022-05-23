Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31B6531D5B
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiEWVHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 17:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiEWVHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:07:47 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0E79811
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:07:43 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 3058CCC66256; Mon, 23 May 2022 14:07:34 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v6 5/6] bpf: Add dynptr data slices
Date:   Mon, 23 May 2022 14:07:11 -0700
Message-Id: <20220523210712.3641569-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220523210712.3641569-1-joannelkoong@gmail.com>
References: <20220523210712.3641569-1-joannelkoong@gmail.com>
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

This patch adds a new helper function

void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);

which returns a pointer to the underlying data of a dynptr. *len*
must be a statically known value. The bpf program may access the returned
data slice as a normal buffer (eg can do direct reads and writes), since
the verifier associates the length with the returned pointer, and
enforces that no out of bounds accesses occur.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 12 ++++++++++++
 kernel/bpf/helpers.c           | 28 ++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 23 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 12 ++++++++++++
 5 files changed, 76 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 60dac491065e..e46cb1b2a90f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -488,6 +488,7 @@ enum bpf_return_type {
 	RET_PTR_TO_TCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COM=
MON,
 	RET_PTR_TO_ALLOC_MEM_OR_NULL	=3D PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_T=
O_ALLOC_MEM,
+	RET_PTR_TO_DYNPTR_MEM_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM=
,
 	RET_PTR_TO_BTF_ID_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
=20
 	/* This must be the last entry. Its purpose is to ensure the enum is
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index efe2505650e6..f4009dbdf62d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5238,6 +5238,17 @@ union bpf_attr {
  *		0 on success, -E2BIG if *offset* + *len* exceeds the length
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
  *		is a read-only dynptr.
+ *
+ * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ *	Description
+ *		Get a pointer to the underlying dynptr data.
+ *
+ *		*len* must be a statically known value. The returned data slice
+ *		is invalidated whenever the dynptr is invalidated.
+ *	Return
+ *		Pointer to the underlying dynptr data, NULL if the dynptr is
+ *		read-only, if the dynptr is invalid, or if the offset and length
+ *		is out of bounds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5443,6 +5454,7 @@ union bpf_attr {
 	FN(ringbuf_discard_dynptr),	\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8cef3fb0d143..225806a02efb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1549,6 +1549,32 @@ const struct bpf_func_proto bpf_dynptr_write_proto=
 =3D {
 	.arg4_type	=3D ARG_CONST_SIZE_OR_ZERO,
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
+	.ret_type	=3D RET_PTR_TO_DYNPTR_MEM_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1615,6 +1641,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_read_proto;
 	case BPF_FUNC_dynptr_write:
 		return &bpf_dynptr_write_proto;
+	case BPF_FUNC_dynptr_data:
+		return &bpf_dynptr_data_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a94b8211e34d..71355a74cd82 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5832,6 +5832,14 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
=20
+static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg)
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
@@ -7384,6 +7392,21 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 		regs[BPF_REG_0].id =3D id;
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D id;
+	} else if (func_id =3D=3D BPF_FUNC_dynptr_data) {
+		int dynptr_id =3D 0, i;
+
+		/* Find the id of the dynptr we're acquiring a reference to */
+		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+			if (arg_type_is_dynptr(fn->arg_type[i])) {
+				if (dynptr_id) {
+					verbose(env, "verifier internal error: multiple dynptr args in func=
\n");
+					return -EFAULT;
+				}
+				dynptr_id =3D stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
+			}
+		}
+		/* For release_reference() */
+		regs[BPF_REG_0].ref_obj_id =3D dynptr_id;
 	}
=20
 	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index efe2505650e6..f4009dbdf62d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5238,6 +5238,17 @@ union bpf_attr {
  *		0 on success, -E2BIG if *offset* + *len* exceeds the length
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
  *		is a read-only dynptr.
+ *
+ * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ *	Description
+ *		Get a pointer to the underlying dynptr data.
+ *
+ *		*len* must be a statically known value. The returned data slice
+ *		is invalidated whenever the dynptr is invalidated.
+ *	Return
+ *		Pointer to the underlying dynptr data, NULL if the dynptr is
+ *		read-only, if the dynptr is invalid, or if the offset and length
+ *		is out of bounds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5443,6 +5454,7 @@ union bpf_attr {
 	FN(ringbuf_discard_dynptr),	\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

