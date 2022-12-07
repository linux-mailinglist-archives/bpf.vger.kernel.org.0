Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77F3646323
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 22:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLGVRJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 16:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLGVQ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 16:16:58 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8121CFF2
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 13:16:57 -0800 (PST)
Received: by devvm15675.prn0.facebook.com (Postfix, from userid 115148)
        id AE0D21355392; Wed,  7 Dec 2022 12:56:46 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kernel-team@meta.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 2/6] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
Date:   Wed,  7 Dec 2022 12:55:33 -0800
Message-Id: <20221207205537.860248-3-joannelkoong@gmail.com>
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

Add two new helper functions: bpf_dynptr_is_null and
bpf_dynptr_is_rdonly.

bpf_dynptr_is_null returns true if the dynptr is null / invalid
(determined by whether ptr->data is NULL), else false if
the dynptr is a valid dynptr.

bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
else false if the dynptr is read-writable.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/bpf.h       | 20 ++++++++++++++++++
 kernel/bpf/helpers.c           | 37 +++++++++++++++++++++++++++++++---
 scripts/bpf_doc.py             |  3 +++
 tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c2d915601484..80582bc00bf4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5553,6 +5553,24 @@ union bpf_attr {
  *	Return
  *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
  *		trying to trim more bytes than the size of the dynptr.
+ *
+ * bool bpf_dynptr_is_null(struct bpf_dynptr *ptr)
+ *	Description
+ *		Determine whether a dynptr is null / invalid.
+ *
+ *		*ptr* must be an initialized dynptr.
+ *	Return
+ *		True if the dynptr is null, else false.
+ *
+ * bool bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
+ *	Description
+ *		Determine whether a dynptr is read-only.
+ *
+ *		*ptr* must be an initialized dynptr. If *ptr*
+ *		is a null dynptr, this will return false.
+ *	Return
+ *		True if the dynptr is read-only and a valid dynptr,
+ *		else false.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5771,6 +5789,8 @@ union bpf_attr {
 	FN(dynptr_from_xdp, 213, ##ctx)			\
 	FN(dynptr_advance, 214, ##ctx)			\
 	FN(dynptr_trim, 215, ##ctx)			\
+	FN(dynptr_is_null, 216, ##ctx)			\
+	FN(dynptr_is_rdonly, 217, ##ctx)		\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fa3989047ff6..cd9e1a2972fe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1404,7 +1404,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_pr=
oto =3D {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
=20
-static bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
+static bool __bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
@@ -1547,7 +1547,7 @@ BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern=
 *, dst, u32, offset, void *,
 	enum bpf_dynptr_type type;
 	int err;
=20
-	if (!dst->data || bpf_dynptr_is_rdonly(dst))
+	if (!dst->data || __bpf_dynptr_is_rdonly(dst))
 		return -EINVAL;
=20
 	err =3D bpf_dynptr_check_off_len(dst, offset, len);
@@ -1605,7 +1605,7 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern =
*, ptr, u32, offset, u32, len
 	switch (type) {
 	case BPF_DYNPTR_TYPE_LOCAL:
 	case BPF_DYNPTR_TYPE_RINGBUF:
-		if (bpf_dynptr_is_rdonly(ptr))
+		if (__bpf_dynptr_is_rdonly(ptr))
 			return 0;
=20
 		data =3D ptr->data;
@@ -1703,6 +1703,33 @@ static const struct bpf_func_proto bpf_dynptr_trim=
_proto =3D {
 	.arg2_type	=3D ARG_ANYTHING,
 };
=20
+BPF_CALL_1(bpf_dynptr_is_null, struct bpf_dynptr_kern *, ptr)
+{
+	return !ptr->data;
+}
+
+static const struct bpf_func_proto bpf_dynptr_is_null_proto =3D {
+	.func		=3D bpf_dynptr_is_null,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+};
+
+BPF_CALL_1(bpf_dynptr_is_rdonly, struct bpf_dynptr_kern *, ptr)
+{
+	if (!ptr->data)
+		return false;
+
+	return __bpf_dynptr_is_rdonly(ptr);
+}
+
+static const struct bpf_func_proto bpf_dynptr_is_rdonly_proto =3D {
+	.func		=3D bpf_dynptr_is_rdonly,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1811,6 +1838,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_advance_proto;
 	case BPF_FUNC_dynptr_trim:
 		return &bpf_dynptr_trim_proto;
+	case BPF_FUNC_dynptr_is_null:
+		return &bpf_dynptr_is_null_proto;
+	case BPF_FUNC_dynptr_is_rdonly:
+		return &bpf_dynptr_is_rdonly_proto;
 #ifdef CONFIG_CGROUPS
 	case BPF_FUNC_cgrp_storage_get:
 		return &bpf_cgrp_storage_get_proto;
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index fdb0aff8cb5a..c20cf141e787 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -710,6 +710,7 @@ class PrinterHelpers(Printer):
             'int',
             'long',
             'unsigned long',
+            'bool',
=20
             '__be16',
             '__be32',
@@ -781,6 +782,8 @@ class PrinterHelpers(Printer):
         header =3D '''\
 /* This is auto-generated file. See bpf_doc.py for details. */
=20
+#include <stdbool.h>
+
 /* Forward declarations of BPF structs */'''
=20
         print(header)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index c2d915601484..80582bc00bf4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5553,6 +5553,24 @@ union bpf_attr {
  *	Return
  *		0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
  *		trying to trim more bytes than the size of the dynptr.
+ *
+ * bool bpf_dynptr_is_null(struct bpf_dynptr *ptr)
+ *	Description
+ *		Determine whether a dynptr is null / invalid.
+ *
+ *		*ptr* must be an initialized dynptr.
+ *	Return
+ *		True if the dynptr is null, else false.
+ *
+ * bool bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
+ *	Description
+ *		Determine whether a dynptr is read-only.
+ *
+ *		*ptr* must be an initialized dynptr. If *ptr*
+ *		is a null dynptr, this will return false.
+ *	Return
+ *		True if the dynptr is read-only and a valid dynptr,
+ *		else false.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5771,6 +5789,8 @@ union bpf_attr {
 	FN(dynptr_from_xdp, 213, ##ctx)			\
 	FN(dynptr_advance, 214, ##ctx)			\
 	FN(dynptr_trim, 215, ##ctx)			\
+	FN(dynptr_is_null, 216, ##ctx)			\
+	FN(dynptr_is_rdonly, 217, ##ctx)		\
 	/* */
=20
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
--=20
2.30.2

