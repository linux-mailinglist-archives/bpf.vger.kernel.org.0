Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9324EFDDE
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 04:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiDBCBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 22:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiDBCBs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 22:01:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C4103D93
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 18:59:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C6Z7031458
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 18:59:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mQ3SVjRfBxe/XRuL3rStLU3p3gqfyKpGj6IOxWyAYrw=;
 b=JloRv7YhNa5q/ObjPiEcedWAxJtDGQg9BtW2qTLY4rLOQGnSQGu+WGfAOXggCXv3m0Os
 c9p3+R22V7uvAYn62ZRoj8yy0Xsv9w9jXazctniGq0L/KCVZf6bpT2ARHxQWSnXaCOmi
 PROfw82xybr5TSg/zYuYCFCN49lffx/bOUU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpgaxa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 18:59:56 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 18:59:55 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id EA3C8A79067C; Fri,  1 Apr 2022 18:59:43 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 4/7] bpf: Add bpf_dynptr_read and bpf_dynptr_write
Date:   Fri, 1 Apr 2022 18:58:23 -0700
Message-ID: <20220402015826.3941317-5-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402015826.3941317-1-joannekoong@fb.com>
References: <20220402015826.3941317-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y5iw4orNgFXp3BYiW4eaebpz8lQLTguv
X-Proofpoint-GUID: Y5iw4orNgFXp3BYiW4eaebpz8lQLTguv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

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
 include/linux/bpf.h            |  6 ++++
 include/uapi/linux/bpf.h       | 18 +++++++++++
 kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 18 +++++++++++
 4 files changed, 98 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e0fcff9f2aee..cded9753fb7f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2426,6 +2426,12 @@ enum bpf_dynptr_type {
 #define DYNPTR_MAX_SIZE	((1UL << 28) - 1)
 #define DYNPTR_SIZE_MASK	0xFFFFFFF
 #define DYNPTR_TYPE_SHIFT	29
+#define DYNPTR_RDONLY_BIT	BIT(28)
+
+static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
+{
+	return ptr->size & DYNPTR_RDONLY_BIT;
+}
=20
 static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr=
_kern *ptr)
 {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6a57d8a1b882..16a35e46be90 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5175,6 +5175,22 @@ union bpf_attr {
  *		After this operation, *ptr* will be an invalidated dynptr.
  *	Return
  *		Void.
+ *
+ * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 =
offset)
+ *	Description
+ *		Read *len* bytes from *src* into *dst*, starting from *offset*
+ *		into *dst*.
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
+ *		of *dst*'s data or if *dst* is not writeable.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5374,6 +5390,8 @@ union bpf_attr {
 	FN(dynptr_from_mem),		\
 	FN(malloc),			\
 	FN(free),			\
+	FN(dynptr_read),		\
+	FN(dynptr_write),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ed5a7d9d0a18..7ec20e79928e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1412,6 +1412,58 @@ const struct bpf_func_proto bpf_dynptr_from_mem_pr=
oto =3D {
 	.arg3_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
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
 BPF_CALL_2(bpf_malloc, u32, size, struct bpf_dynptr_kern *, ptr)
 {
 	void *data;
@@ -1514,6 +1566,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_malloc_proto;
 	case BPF_FUNC_free:
 		return &bpf_free_proto;
+	case BPF_FUNC_dynptr_read:
+		return &bpf_dynptr_read_proto;
+	case BPF_FUNC_dynptr_write:
+		return &bpf_dynptr_write_proto;
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 6a57d8a1b882..16a35e46be90 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5175,6 +5175,22 @@ union bpf_attr {
  *		After this operation, *ptr* will be an invalidated dynptr.
  *	Return
  *		Void.
+ *
+ * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 =
offset)
+ *	Description
+ *		Read *len* bytes from *src* into *dst*, starting from *offset*
+ *		into *dst*.
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
+ *		of *dst*'s data or if *dst* is not writeable.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5374,6 +5390,8 @@ union bpf_attr {
 	FN(dynptr_from_mem),		\
 	FN(malloc),			\
 	FN(free),			\
+	FN(dynptr_read),		\
+	FN(dynptr_write),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

