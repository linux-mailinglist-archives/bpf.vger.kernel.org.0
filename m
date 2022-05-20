Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6593B52E3F2
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 06:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345359AbiETEn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 00:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345380AbiETEn1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 00:43:27 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD712FEF0
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 21:43:26 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 999CFC9E201A; Thu, 19 May 2022 21:43:23 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v5 5/6] bpf: Add dynptr data slices
Date:   Thu, 19 May 2022 21:42:44 -0700
Message-Id: <20220520044245.3305025-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520044245.3305025-1-joannelkoong@gmail.com>
References: <20220520044245.3305025-1-joannelkoong@gmail.com>
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
---
 include/linux/bpf.h            |  4 ++++
 include/uapi/linux/bpf.h       | 12 ++++++++++++
 kernel/bpf/helpers.c           | 28 ++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 27 +++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 12 ++++++++++++
 5 files changed, 83 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dce532393f3d..ddf97b12e180 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -398,6 +398,9 @@ enum bpf_type_flag {
 	/* DYNPTR points to a ringbuf record. */
 	DYNPTR_TYPE_RINGBUF	=3D BIT(9 + BPF_BASE_TYPE_BITS),
=20
+	/* MEM is memory owned by a dynptr */
+	MEM_DYNPTR		=3D BIT(10 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -488,6 +491,7 @@ enum bpf_return_type {
 	RET_PTR_TO_TCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COM=
MON,
 	RET_PTR_TO_ALLOC_MEM_OR_NULL	=3D PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_T=
O_ALLOC_MEM,
+	RET_PTR_TO_DYNPTR_MEM_OR_NULL	=3D PTR_MAYBE_NULL | MEM_DYNPTR | RET_PTR=
_TO_ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
=20
 	/* This must be the last entry. Its purpose is to ensure the enum is
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d11603c5b87a..89d0932255ab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5232,6 +5232,17 @@ union bpf_attr {
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
@@ -5436,6 +5447,7 @@ union bpf_attr {
 	FN(ringbuf_discard_dynptr),	\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 726a4164ceca..47b36c4f71de 100644
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
index 4b502b8a369e..79c68e28ae5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -567,6 +567,8 @@ static const char *reg_type_str(struct bpf_verifier_e=
nv *env,
 		strncpy(prefix, "rdonly_", 32);
 	if (type & MEM_ALLOC)
 		strncpy(prefix, "alloc_", 32);
+	if (type & MEM_DYNPTR)
+		strncpy(prefix, "dynptr_", 32);
 	if (type & MEM_USER)
 		strncpy(prefix, "user_", 32);
 	if (type & MEM_PERCPU)
@@ -5640,6 +5642,7 @@ static const struct bpf_reg_types mem_types =3D {
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
 		PTR_TO_MEM | MEM_ALLOC,
+		PTR_TO_MEM | MEM_DYNPTR,
 		PTR_TO_BUF,
 	},
 };
@@ -5803,6 +5806,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	case PTR_TO_MEM:
 	case PTR_TO_MEM | MEM_RDONLY:
 	case PTR_TO_MEM | MEM_ALLOC:
+	case PTR_TO_MEM | MEM_DYNPTR:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case SCALAR_VALUE:
@@ -5837,6 +5841,14 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
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
@@ -7383,6 +7395,21 @@ static int check_helper_call(struct bpf_verifier_e=
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
index d11603c5b87a..89d0932255ab 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5232,6 +5232,17 @@ union bpf_attr {
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
@@ -5436,6 +5447,7 @@ union bpf_attr {
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

