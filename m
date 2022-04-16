Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E250348B
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 08:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiDPGz2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 02:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPGz2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 02:55:28 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0281310EC44
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 23:52:55 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 19E27B1DE61F; Fri, 15 Apr 2022 23:35:39 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v2 4/7] bpf: Add bpf_dynptr_read and bpf_dynptr_write
Date:   Fri, 15 Apr 2022 23:34:26 -0700
Message-Id: <20220416063429.3314021-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416063429.3314021-1-joannelkoong@gmail.com>
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
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

This patch adds two helper functions, bpf_dynptr_read and
bpf_dynptr_write:

long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offs=
et);

long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 =
len);

The dynptr passed into these functions must be valid dynptrs that have
been initialized.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            | 16 ++++++++++
 include/uapi/linux/bpf.h       | 19 ++++++++++++
 kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 19 ++++++++++++
 4 files changed, 110 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fee91b07ee74..8eb32ec201bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2434,6 +2434,12 @@ enum bpf_dynptr_type {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_TYPE_SHIFT	28
 #define DYNPTR_TYPE_MASK	0x7
+#define DYNPTR_RDONLY_BIT	BIT(31)
+
+static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
+{
+	return ptr->size & DYNPTR_RDONLY_BIT;
+}
=20
 static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr=
_kern *ptr)
 {
@@ -2455,6 +2461,16 @@ static inline int bpf_dynptr_check_size(u32 size)
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
 }
=20
+static inline int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, =
u32 offset, u32 len)
+{
+	u32 capacity =3D bpf_dynptr_get_size(ptr) - ptr->offset;
+
+	if (len > capacity || offset > capacity - len)
+		return -EINVAL;
+
+	return 0;
+}
+
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_d=
ynptr_type type,
 		     u32 offset, u32 size);
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e339b2697d9a..abe9a221ef08 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5179,6 +5179,23 @@ union bpf_attr {
  *		After this operation, *ptr* will be an invalidated dynptr.
  *	Return
  *		Void.
+ *
+ * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 =
offset)
+ *	Description
+ *		Read *len* bytes from *src* into *dst*, starting from *offset*
+ *		into *src*.
+ *	Return
+ *		0 on success, -EINVAL if *offset* + *len* exceeds the length
+ *		of *src*'s data or if *src* is an invalid dynptr.
+ *
+ * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, =
u32 len)
+ *	Description
+ *		Write *len* bytes from *src* into *dst*, starting from *offset*
+ *		into *dst*.
+ *	Return
+ *		0 on success, -EINVAL if *offset* + *len* exceeds the length
+ *		of *dst*'s data or if *dst* is an invalid dynptr or if *dst*
+ *		is a read-only dynptr.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5378,6 +5395,8 @@ union bpf_attr {
 	FN(dynptr_from_mem),		\
 	FN(dynptr_alloc),		\
 	FN(dynptr_put),			\
+	FN(dynptr_read),		\
+	FN(dynptr_write),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 87c14edda315..ae2239375c51 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1478,6 +1478,58 @@ const struct bpf_func_proto bpf_dynptr_put_proto =3D=
 {
 	.arg1_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | OBJ_RELEASE,
 };
=20
+BPF_CALL_4(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_ker=
n *, src, u32, offset)
+{
+	int err;
+
+	if (!src->data)
+		return -EINVAL;
+
+	err =3D bpf_dynptr_check_off_len(src, offset, len);
+	if (err)
+		return err;
+
+	memcpy(dst, src->data + src->offset + offset, len);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_dynptr_read_proto =3D {
+	.func		=3D bpf_dynptr_read,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
+	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg4_type	=3D ARG_ANYTHING,
+};
+
+BPF_CALL_4(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset,=
 void *, src, u32, len)
+{
+	int err;
+
+	if (!dst->data || bpf_dynptr_is_rdonly(dst))
+		return -EINVAL;
+
+	err =3D bpf_dynptr_check_off_len(dst, offset, len);
+	if (err)
+		return err;
+
+	memcpy(dst->data + dst->offset + offset, src, len);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_dynptr_write_proto =3D {
+	.func		=3D bpf_dynptr_write,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg4_type	=3D ARG_CONST_SIZE_OR_ZERO,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1536,6 +1588,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_alloc_proto;
 	case BPF_FUNC_dynptr_put:
 		return &bpf_dynptr_put_proto;
+	case BPF_FUNC_dynptr_read:
+		return &bpf_dynptr_read_proto;
+	case BPF_FUNC_dynptr_write:
+		return &bpf_dynptr_write_proto;
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index e339b2697d9a..abe9a221ef08 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5179,6 +5179,23 @@ union bpf_attr {
  *		After this operation, *ptr* will be an invalidated dynptr.
  *	Return
  *		Void.
+ *
+ * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 =
offset)
+ *	Description
+ *		Read *len* bytes from *src* into *dst*, starting from *offset*
+ *		into *src*.
+ *	Return
+ *		0 on success, -EINVAL if *offset* + *len* exceeds the length
+ *		of *src*'s data or if *src* is an invalid dynptr.
+ *
+ * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, =
u32 len)
+ *	Description
+ *		Write *len* bytes from *src* into *dst*, starting from *offset*
+ *		into *dst*.
+ *	Return
+ *		0 on success, -EINVAL if *offset* + *len* exceeds the length
+ *		of *dst*'s data or if *dst* is an invalid dynptr or if *dst*
+ *		is a read-only dynptr.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5378,6 +5395,8 @@ union bpf_attr {
 	FN(dynptr_from_mem),		\
 	FN(dynptr_alloc),		\
 	FN(dynptr_put),			\
+	FN(dynptr_read),		\
+	FN(dynptr_write),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

