Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CD7646328
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLGVTg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLGVTf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:19:35 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0CC81DA6
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 13:19:34 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id C61A71355387; Wed,  7 Dec 2022 12:56:44 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kernel-team@meta.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 1/6] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
Date:   Wed,  7 Dec 2022 12:55:32 -0800
Message-Id: <20221207205537.860248-2-joannelkoong@gmail.com>
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

Add two new helper functions: bpf_dynptr_trim and bpf_dynptr_advance.

bpf_dynptr_trim decreases the size of a dynptr by the specified
number of bytes (offset remains the same). bpf_dynptr_advance advances
the offset of the dynptr by the specified number of bytes (size
decreases correspondingly).

One example where trimming / advancing the dynptr may useful is for
hashing. If the dynptr points to a larger struct, it is possible to hash
an individual field within the struct through dynptrs by using
bpf_dynptr_advance+trim.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       | 18 +++++++++
 kernel/bpf/helpers.c           | 67 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 18 +++++++++
 3 files changed, 103 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a9bb98365031..c2d915601484 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5537,6 +5537,22 @@ union bpf_attr {
  *		*flags* is currently unused, it must be 0 for now.
  *	Return
  *		0 on success, -EINVAL if flags is not 0.
+ *
+ * long bpf_dynptr_advance(struct bpf_dynptr *ptr, u32 len)
+ *	Description
+ *		Advance a dynptr's internal offset by *len* bytes.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if *len*
+ *		exceeds the bounds of the dynptr.
+ *
+ * long bpf_dynptr_trim(struct bpf_dynptr *ptr, u32 len)
+ *	Description
+ *		Trim the size of memory pointed to by the dynptr by *len* bytes.
+ *
+ *		The offset is unmodified.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
+ *		trying to trim more bytes than the size of the dynptr.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5753,6 +5769,8 @@ union bpf_attr {
 	FN(cgrp_storage_delete, 211, ##ctx)		\
 	FN(dynptr_from_skb, 212, ##ctx)			\
 	FN(dynptr_from_xdp, 213, ##ctx)			\
+	FN(dynptr_advance, 214, ##ctx)			\
+	FN(dynptr_trim, 215, ##ctx)			\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3a9c8814aaf6..fa3989047ff6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1429,6 +1429,13 @@ u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *pt=
r)
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
=20
+static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_siz=
e)
+{
+	u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
+
+	ptr->size =3D new_size | metadata;
+}
+
 int bpf_dynptr_check_size(u32 size)
 {
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
@@ -1640,6 +1647,62 @@ static const struct bpf_func_proto bpf_dynptr_data=
_proto =3D {
 	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
=20
+/* For dynptrs, the offset may only be advanced and the size may only be=
 decremented */
+static int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 off_inc, u=
32 sz_dec)
+{
+	u32 size;
+
+	if (!ptr->data)
+		return -EINVAL;
+
+	size =3D bpf_dynptr_get_size(ptr);
+
+	if (sz_dec > size)
+		return -ERANGE;
+
+	if (off_inc) {
+		u32 new_off;
+
+		if (off_inc > size)
+			return -ERANGE;
+
+		if (check_add_overflow(ptr->offset, off_inc, &new_off))
+			return -ERANGE;
+
+		ptr->offset =3D new_off;
+	}
+
+	bpf_dynptr_set_size(ptr, size - sz_dec);
+
+	return 0;
+}
+
+BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
+{
+	return bpf_dynptr_adjust(ptr, len, len);
+}
+
+static const struct bpf_func_proto bpf_dynptr_advance_proto =3D {
+	.func		=3D bpf_dynptr_advance,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_dynptr_trim, struct bpf_dynptr_kern *, ptr, u32, len)
+{
+	return bpf_dynptr_adjust(ptr, 0, len);
+}
+
+static const struct bpf_func_proto bpf_dynptr_trim_proto =3D {
+	.func		=3D bpf_dynptr_trim,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1744,6 +1807,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_write_proto;
 	case BPF_FUNC_dynptr_data:
 		return &bpf_dynptr_data_proto;
+	case BPF_FUNC_dynptr_advance:
+		return &bpf_dynptr_advance_proto;
+	case BPF_FUNC_dynptr_trim:
+		return &bpf_dynptr_trim_proto;
 #ifdef CONFIG_CGROUPS
 	case BPF_FUNC_cgrp_storage_get:
 		return &bpf_cgrp_storage_get_proto;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index a9bb98365031..c2d915601484 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5537,6 +5537,22 @@ union bpf_attr {
  *		*flags* is currently unused, it must be 0 for now.
  *	Return
  *		0 on success, -EINVAL if flags is not 0.
+ *
+ * long bpf_dynptr_advance(struct bpf_dynptr *ptr, u32 len)
+ *	Description
+ *		Advance a dynptr's internal offset by *len* bytes.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if *len*
+ *		exceeds the bounds of the dynptr.
+ *
+ * long bpf_dynptr_trim(struct bpf_dynptr *ptr, u32 len)
+ *	Description
+ *		Trim the size of memory pointed to by the dynptr by *len* bytes.
+ *
+ *		The offset is unmodified.
+ *	Return
+ *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
+ *		trying to trim more bytes than the size of the dynptr.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5753,6 +5769,8 @@ union bpf_attr {
 	FN(cgrp_storage_delete, 211, ##ctx)		\
 	FN(dynptr_from_skb, 212, ##ctx)			\
 	FN(dynptr_from_xdp, 213, ##ctx)			\
+	FN(dynptr_advance, 214, ##ctx)			\
+	FN(dynptr_trim, 215, ##ctx)			\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
--=20
2.30.2

