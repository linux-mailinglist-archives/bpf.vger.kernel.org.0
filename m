Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0962E64632A
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLGVUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLGVUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:20:19 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83014E402
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 13:20:18 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id 44DD21355394; Wed,  7 Dec 2022 12:56:47 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kernel-team@meta.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 3/6] bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
Date:   Wed,  7 Dec 2022 12:55:34 -0800
Message-Id: <20221207205537.860248-4-joannelkoong@gmail.com>
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

Add two new helper functions: bpf_dynptr_get_size and
bpf_dynptr_get_offset.

bpf_dynptr_get_size returns the number of usable bytes in a dynptr and
bpf_dynptr_get_offset returns the current offset into the dynptr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            |  2 +-
 include/uapi/linux/bpf.h       | 25 +++++++++++++++++++++
 kernel/bpf/helpers.c           | 40 +++++++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c       |  4 ++--
 tools/include/uapi/linux/bpf.h | 25 +++++++++++++++++++++
 5 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5628256de3e5..753444e1478c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1118,7 +1118,7 @@ enum bpf_dynptr_type {
 };
=20
 int bpf_dynptr_check_size(u32 size);
-u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
+u32 __bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
=20
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tra=
mpoline *tr);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 80582bc00bf4..5ad52d481cde 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5571,6 +5571,29 @@ union bpf_attr {
  *	Return
  *		True if the dynptr is read-only and a valid dynptr,
  *		else false.
+ *
+ * long bpf_dynptr_get_size(struct bpf_dynptr *ptr)
+ *	Description
+ *		Get the size of *ptr*.
+ *
+ *		Size refers to the number of usable bytes. For example,
+ *		if *ptr* was initialized with 100 bytes and its
+ *		offset was advanced by 40 bytes, then the size will be
+ *		60 bytes.
+ *
+ *		*ptr* must be an initialized dynptr.
+ *	Return
+ *		The size of the dynptr on success, -EINVAL if the dynptr is
+ *		invalid.
+ *
+ * long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
+ *	Description
+ *		Get the offset of the dynptr.
+ *
+ *		*ptr* must be an initialized dynptr.
+ *	Return
+ *		The offset of the dynptr on success, -EINVAL if the dynptr is
+ *		invalid.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5791,6 +5814,8 @@ union bpf_attr {
 	FN(dynptr_trim, 215, ##ctx)			\
 	FN(dynptr_is_null, 216, ##ctx)			\
 	FN(dynptr_is_rdonly, 217, ##ctx)		\
+	FN(dynptr_get_size, 218, ##ctx)		\
+	FN(dynptr_get_offset, 219, ##ctx)		\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cd9e1a2972fe..0164d7e4b5a6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1424,7 +1424,7 @@ static enum bpf_dynptr_type bpf_dynptr_get_type(con=
st struct bpf_dynptr_kern *pt
 	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
 }
=20
-u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+u32 __bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
@@ -1457,7 +1457,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *pt=
r)
=20
 static int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 off=
set, u32 len)
 {
-	u32 size =3D bpf_dynptr_get_size(ptr);
+	u32 size =3D __bpf_dynptr_get_size(ptr);
=20
 	if (len > size || offset > size - len)
 		return -E2BIG;
@@ -1655,7 +1655,7 @@ static int bpf_dynptr_adjust(struct bpf_dynptr_kern=
 *ptr, u32 off_inc, u32 sz_de
 	if (!ptr->data)
 		return -EINVAL;
=20
-	size =3D bpf_dynptr_get_size(ptr);
+	size =3D __bpf_dynptr_get_size(ptr);
=20
 	if (sz_dec > size)
 		return -ERANGE;
@@ -1730,6 +1730,36 @@ static const struct bpf_func_proto bpf_dynptr_is_r=
donly_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
 };
=20
+BPF_CALL_1(bpf_dynptr_get_size, struct bpf_dynptr_kern *, ptr)
+{
+	if (!ptr->data)
+		return -EINVAL;
+
+	return __bpf_dynptr_get_size(ptr);
+}
+
+static const struct bpf_func_proto bpf_dynptr_get_size_proto =3D {
+	.func		=3D bpf_dynptr_get_size,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+};
+
+BPF_CALL_1(bpf_dynptr_get_offset, struct bpf_dynptr_kern *, ptr)
+{
+	if (!ptr->data)
+		return -EINVAL;
+
+	return ptr->offset;
+}
+
+static const struct bpf_func_proto bpf_dynptr_get_offset_proto =3D {
+	.func		=3D bpf_dynptr_get_offset,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1842,6 +1872,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_is_null_proto;
 	case BPF_FUNC_dynptr_is_rdonly:
 		return &bpf_dynptr_is_rdonly_proto;
+	case BPF_FUNC_dynptr_get_size:
+		return &bpf_dynptr_get_size_proto;
+	case BPF_FUNC_dynptr_get_offset:
+		return &bpf_dynptr_get_offset_proto;
 #ifdef CONFIG_CGROUPS
 	case BPF_FUNC_cgrp_storage_get:
 		return &bpf_cgrp_storage_get_proto;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3bbd3f0c810c..e057570b4e2c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1349,9 +1349,9 @@ int bpf_verify_pkcs7_signature(struct bpf_dynptr_ke=
rn *data_ptr,
 	}
=20
 	return verify_pkcs7_signature(data_ptr->data,
-				      bpf_dynptr_get_size(data_ptr),
+				      __bpf_dynptr_get_size(data_ptr),
 				      sig_ptr->data,
-				      bpf_dynptr_get_size(sig_ptr),
+				      __bpf_dynptr_get_size(sig_ptr),
 				      trusted_keyring->key,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 80582bc00bf4..5ad52d481cde 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5571,6 +5571,29 @@ union bpf_attr {
  *	Return
  *		True if the dynptr is read-only and a valid dynptr,
  *		else false.
+ *
+ * long bpf_dynptr_get_size(struct bpf_dynptr *ptr)
+ *	Description
+ *		Get the size of *ptr*.
+ *
+ *		Size refers to the number of usable bytes. For example,
+ *		if *ptr* was initialized with 100 bytes and its
+ *		offset was advanced by 40 bytes, then the size will be
+ *		60 bytes.
+ *
+ *		*ptr* must be an initialized dynptr.
+ *	Return
+ *		The size of the dynptr on success, -EINVAL if the dynptr is
+ *		invalid.
+ *
+ * long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
+ *	Description
+ *		Get the offset of the dynptr.
+ *
+ *		*ptr* must be an initialized dynptr.
+ *	Return
+ *		The offset of the dynptr on success, -EINVAL if the dynptr is
+ *		invalid.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5791,6 +5814,8 @@ union bpf_attr {
 	FN(dynptr_trim, 215, ##ctx)			\
 	FN(dynptr_is_null, 216, ##ctx)			\
 	FN(dynptr_is_rdonly, 217, ##ctx)		\
+	FN(dynptr_get_size, 218, ##ctx)		\
+	FN(dynptr_get_offset, 219, ##ctx)		\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
--=20
2.30.2

