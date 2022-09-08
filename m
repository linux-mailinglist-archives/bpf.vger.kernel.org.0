Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95ED5B10CD
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIHAKM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIHAKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:10:09 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9865699B5C
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:10:08 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 5E5AA1170376F; Wed,  7 Sep 2022 17:07:25 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 1/8] bpf: Add bpf_dynptr_data_rdonly
Date:   Wed,  7 Sep 2022 17:02:47 -0700
Message-Id: <20220908000254.3079129-2-joannelkoong@gmail.com>
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

Add a new helper bpf_dynptr_data_rdonly

void *bpf_dynptr_data_rdonly(struct bpf_dynptr *ptr, u32 offset, u32 len)=
;

which gets a read-only pointer to the underlying dynptr data.

This is equivalent to bpf_dynptr_data(), except the pointer returned is
read-only, which allows this to support both read-write and read-only
dynptrs.

One example where this will be useful is for skb dynptrs where the
program type only allows read-only access to packet data. This API will
provide a way to obtain a data slice that can be used for direct reads.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       | 15 +++++++++++++++
 kernel/bpf/helpers.c           | 32 ++++++++++++++++++++++++++------
 kernel/bpf/verifier.c          |  7 +++++--
 tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
 4 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c55c23f25c0f..cce3356765fc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5439,6 +5439,20 @@ union bpf_attr {
  *		*flags* is currently unused, it must be 0 for now.
  *	Return
  *		0 on success, -EINVAL if flags is not 0.
+ *
+ * void *bpf_dynptr_data_rdonly(struct bpf_dynptr *ptr, u32 offset, u32 =
len)
+ *	Description
+ *		Get a read-only pointer to the underlying dynptr data.
+ *
+ *		This is equivalent to **bpf_dynptr_data**\ () except the
+ *		pointer returned is read-only, which allows this to support
+ *		both read-write and read-only dynptrs. For more details on using
+ *		the API, please refer to **bpf_dynptr_data**\ ().
+ *	Return
+ *		Read-only pointer to the underlying dynptr data, NULL if the
+ *		dynptr is invalid or if the offset and length is out of bounds
+ *		or in a paged buffer for skb-type dynptrs or across fragments
+ *		for xdp-type dynptrs.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5652,6 +5666,7 @@ union bpf_attr {
 	FN(ktime_get_tai_ns),		\
 	FN(dynptr_from_skb),		\
 	FN(dynptr_from_xdp),		\
+	FN(dynptr_data_rdonly),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index befafae34a63..30a59c9e5df3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1572,7 +1572,7 @@ static const struct bpf_func_proto bpf_dynptr_write=
_proto =3D {
 	.arg5_type	=3D ARG_ANYTHING,
 };
=20
-BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, =
u32, len)
+void *__bpf_dynptr_data(struct bpf_dynptr_kern *ptr, u32 offset, u32 len=
, bool writable)
 {
 	enum bpf_dynptr_type type;
 	void *data;
@@ -1585,7 +1585,7 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern =
*, ptr, u32, offset, u32, len
 	if (err)
 		return 0;
=20
-	if (bpf_dynptr_is_rdonly(ptr))
+	if (writable && bpf_dynptr_is_rdonly(ptr))
 		return 0;
=20
 	type =3D bpf_dynptr_get_type(ptr);
@@ -1610,13 +1610,31 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_ker=
n *, ptr, u32, offset, u32, len
 		/* if the requested data in across fragments, then it cannot
 		 * be accessed directly - bpf_xdp_pointer will return NULL
 		 */
-		return (unsigned long)bpf_xdp_pointer(ptr->data,
-						      ptr->offset + offset, len);
+		return bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
 	default:
-		WARN_ONCE(true, "bpf_dynptr_data: unknown dynptr type %d\n", type);
+		WARN_ONCE(true, "__bpf_dynptr_data: unknown dynptr type %d\n", type);
 		return 0;
 	}
-	return (unsigned long)(data + ptr->offset + offset);
+	return data + ptr->offset + offset;
+}
+
+BPF_CALL_3(bpf_dynptr_data_rdonly, struct bpf_dynptr_kern *, ptr, u32, o=
ffset, u32, len)
+{
+	return (unsigned long)__bpf_dynptr_data(ptr, offset, len, false);
+}
+
+static const struct bpf_func_proto bpf_dynptr_data_rdonly_proto =3D {
+	.func		=3D bpf_dynptr_data_rdonly,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_DYNPTR_MEM_OR_NULL | MEM_RDONLY,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
+};
+
+BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, =
u32, len)
+{
+	return (unsigned long)__bpf_dynptr_data(ptr, offset, len, true);
 }
=20
 static const struct bpf_func_proto bpf_dynptr_data_proto =3D {
@@ -1698,6 +1716,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_write_proto;
 	case BPF_FUNC_dynptr_data:
 		return &bpf_dynptr_data_proto;
+	case BPF_FUNC_dynptr_data_rdonly:
+		return &bpf_dynptr_data_rdonly_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b1f66a1cc690..c312d931359d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -506,7 +506,8 @@ static bool is_ptr_cast_function(enum bpf_func_id fun=
c_id)
=20
 static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 {
-	return func_id =3D=3D BPF_FUNC_dynptr_data;
+	return func_id =3D=3D BPF_FUNC_dynptr_data ||
+		func_id =3D=3D BPF_FUNC_dynptr_data_rdonly;
 }
=20
 static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
@@ -7398,6 +7399,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		}
 		break;
 	case BPF_FUNC_dynptr_data:
+	case BPF_FUNC_dynptr_data_rdonly:
 	{
 		struct bpf_reg_state *reg;
=20
@@ -7495,7 +7497,8 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type =3D PTR_TO_MEM | ret_flag;
 		regs[BPF_REG_0].mem_size =3D meta.mem_size;
-		if (func_id =3D=3D BPF_FUNC_dynptr_data) {
+		if (func_id =3D=3D BPF_FUNC_dynptr_data ||
+		    func_id =3D=3D BPF_FUNC_dynptr_data_rdonly) {
 			if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_SKB)
 				regs[BPF_REG_0].type |=3D DYNPTR_TYPE_SKB;
 			else if (dynptr_type =3D=3D BPF_DYNPTR_TYPE_XDP)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index c55c23f25c0f..cce3356765fc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5439,6 +5439,20 @@ union bpf_attr {
  *		*flags* is currently unused, it must be 0 for now.
  *	Return
  *		0 on success, -EINVAL if flags is not 0.
+ *
+ * void *bpf_dynptr_data_rdonly(struct bpf_dynptr *ptr, u32 offset, u32 =
len)
+ *	Description
+ *		Get a read-only pointer to the underlying dynptr data.
+ *
+ *		This is equivalent to **bpf_dynptr_data**\ () except the
+ *		pointer returned is read-only, which allows this to support
+ *		both read-write and read-only dynptrs. For more details on using
+ *		the API, please refer to **bpf_dynptr_data**\ ().
+ *	Return
+ *		Read-only pointer to the underlying dynptr data, NULL if the
+ *		dynptr is invalid or if the offset and length is out of bounds
+ *		or in a paged buffer for skb-type dynptrs or across fragments
+ *		for xdp-type dynptrs.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5652,6 +5666,7 @@ union bpf_attr {
 	FN(ktime_get_tai_ns),		\
 	FN(dynptr_from_skb),		\
 	FN(dynptr_from_xdp),		\
+	FN(dynptr_data_rdonly),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

