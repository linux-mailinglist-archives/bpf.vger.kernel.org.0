Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39A5B10C3
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIHAHn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIHAHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:07:43 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE11B2CE2
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:07:41 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id BA509117037C7; Wed,  7 Sep 2022 17:07:27 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 4/8] bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
Date:   Wed,  7 Sep 2022 17:02:50 -0700
Message-Id: <20220908000254.3079129-5-joannelkoong@gmail.com>
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

Add two new helper functions: bpf_dynptr_get_size and
bpf_dynptr_get_offset.

bpf_dynptr_get_size returns the number of usable bytes in a dynptr and
bpf_dynptr_get_offset returns the current offset into the dynptr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       | 25 ++++++++++++++++++++
 kernel/bpf/helpers.c           | 42 ++++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h | 25 ++++++++++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 90b6d0744df2..4ca07cf500d2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5485,6 +5485,29 @@ union bpf_attr {
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
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5703,6 +5726,8 @@ union bpf_attr {
 	FN(dynptr_trim),		\
 	FN(dynptr_is_null),		\
 	FN(dynptr_is_rdonly),		\
+	FN(dynptr_get_size),		\
+	FN(dynptr_get_offset),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8729383d0966..62ed27444b73 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1418,7 +1418,7 @@ static enum bpf_dynptr_type bpf_dynptr_get_type(con=
st struct bpf_dynptr_kern *pt
 	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
 }
=20
-static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+static u32 __bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
@@ -1451,7 +1451,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *pt=
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
@@ -1660,7 +1660,7 @@ BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_ke=
rn *, ptr, u32, len)
 	if (!ptr->data)
 		return -EINVAL;
=20
-	size =3D bpf_dynptr_get_size(ptr);
+	size =3D __bpf_dynptr_get_size(ptr);
=20
 	if (len > size)
 		return -ERANGE;
@@ -1687,7 +1687,7 @@ BPF_CALL_2(bpf_dynptr_trim, struct bpf_dynptr_kern =
*, ptr, u32, len)
 	if (!ptr->data)
 		return -EINVAL;
=20
-	size =3D bpf_dynptr_get_size(ptr);
+	size =3D __bpf_dynptr_get_size(ptr);
=20
 	if (len > size)
 		return -ERANGE;
@@ -1732,6 +1732,36 @@ static const struct bpf_func_proto bpf_dynptr_is_r=
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
@@ -1812,6 +1842,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_is_null_proto;
 	case BPF_FUNC_dynptr_is_rdonly:
 		return &bpf_dynptr_is_rdonly_proto;
+	case BPF_FUNC_dynptr_get_size:
+		return &bpf_dynptr_get_size_proto;
+	case BPF_FUNC_dynptr_get_offset:
+		return &bpf_dynptr_get_offset_proto;
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 90b6d0744df2..4ca07cf500d2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5485,6 +5485,29 @@ union bpf_attr {
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
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5703,6 +5726,8 @@ union bpf_attr {
 	FN(dynptr_trim),		\
 	FN(dynptr_is_null),		\
 	FN(dynptr_is_rdonly),		\
+	FN(dynptr_get_size),		\
+	FN(dynptr_get_offset),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

