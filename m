Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19735B10C4
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIHAHo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIHAHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:07:43 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39625AF4A6
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:07:41 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 1B5C511703794; Wed,  7 Sep 2022 17:07:27 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 3/8] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
Date:   Wed,  7 Sep 2022 17:02:49 -0700
Message-Id: <20220908000254.3079129-4-joannelkoong@gmail.com>
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
index 3b054553be30..90b6d0744df2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5467,6 +5467,24 @@ union bpf_attr {
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
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5683,6 +5701,8 @@ union bpf_attr {
 	FN(dynptr_data_rdonly),		\
 	FN(dynptr_advance),		\
 	FN(dynptr_trim),		\
+	FN(dynptr_is_null),		\
+	FN(dynptr_is_rdonly),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9f356105ab49..8729383d0966 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1398,7 +1398,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_pr=
oto =3D {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
=20
-static bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
+static bool __bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
@@ -1539,7 +1539,7 @@ BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern=
 *, dst, u32, offset, void *,
 	enum bpf_dynptr_type type;
 	int err;
=20
-	if (!dst->data || bpf_dynptr_is_rdonly(dst))
+	if (!dst->data || __bpf_dynptr_is_rdonly(dst))
 		return -EINVAL;
=20
 	err =3D bpf_dynptr_check_off_len(dst, offset, len);
@@ -1592,7 +1592,7 @@ void *__bpf_dynptr_data(struct bpf_dynptr_kern *ptr=
, u32 offset, u32 len, bool w
 	if (err)
 		return 0;
=20
-	if (writable && bpf_dynptr_is_rdonly(ptr))
+	if (writable && __bpf_dynptr_is_rdonly(ptr))
 		return 0;
=20
 	type =3D bpf_dynptr_get_type(ptr);
@@ -1705,6 +1705,33 @@ static const struct bpf_func_proto bpf_dynptr_trim=
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
+		return 0;
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
@@ -1781,6 +1808,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_advance_proto;
 	case BPF_FUNC_dynptr_trim:
 		return &bpf_dynptr_trim_proto;
+	case BPF_FUNC_dynptr_is_null:
+		return &bpf_dynptr_is_null_proto;
+	case BPF_FUNC_dynptr_is_rdonly:
+		return &bpf_dynptr_is_rdonly_proto;
 	default:
 		break;
 	}
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index d5c389df6045..ecd227c2ea34 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -691,6 +691,7 @@ class PrinterHelpers(Printer):
             'int',
             'long',
             'unsigned long',
+            'bool',
=20
             '__be16',
             '__be32',
@@ -761,6 +762,8 @@ class PrinterHelpers(Printer):
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
index 3b054553be30..90b6d0744df2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5467,6 +5467,24 @@ union bpf_attr {
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
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5683,6 +5701,8 @@ union bpf_attr {
 	FN(dynptr_data_rdonly),		\
 	FN(dynptr_advance),		\
 	FN(dynptr_trim),		\
+	FN(dynptr_is_null),		\
+	FN(dynptr_is_rdonly),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

