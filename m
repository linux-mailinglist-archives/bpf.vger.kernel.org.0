Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0C40BB69
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhINWbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:31:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235137AbhINWbc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 18:31:32 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG1egS002012
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=oFyevuAO8L1hWOkrz6oEpJZnC0FsLBRUdJV51YIM3uA=;
 b=aDgsPnLI9x0IOJemlkMWe4UhlBX+JwxP9ymgdkADFEx34R4SJYiCccaW6EFY0PZePDCa
 LjYIdi37rT51vC9JEMfZnrgF8XWsevzGZCZhuq4o7qmG6rKnFq1lFfDarCvPyXjBjD7U
 qLKVYC26EjOH3L2x5eX1jyNnQT53FBTdkjo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b2uq0ks12-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:13 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 15:30:12 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id CE4DA738217A; Tue, 14 Sep 2021 15:30:09 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 01/11] btf: change BTF_KIND_* macros to enums
Date:   Tue, 14 Sep 2021 15:30:09 -0700
Message-ID: <20210914223009.245307-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
References: <20210914223004.244411-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: yUraQCzHV2NfwB8ZbRsZFPav8gfP8Md5
X-Proofpoint-GUID: yUraQCzHV2NfwB8ZbRsZFPav8gfP8Md5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=799
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change BTF_KIND_* macros to enums so they are encoded in dwarf and
appear in vmlinux.h. This will make it easier for bpf programs
to use these constants without macro definitions.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/btf.h       | 41 ++++++++++++++++++----------------
 tools/include/uapi/linux/btf.h | 41 ++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index d27b1708efe9..10e401073dd1 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -56,25 +56,28 @@ struct btf_type {
 #define BTF_INFO_VLEN(info)	((info) & 0xffff)
 #define BTF_INFO_KFLAG(info)	((info) >> 31)
=20
-#define BTF_KIND_UNKN		0	/* Unknown	*/
-#define BTF_KIND_INT		1	/* Integer	*/
-#define BTF_KIND_PTR		2	/* Pointer	*/
-#define BTF_KIND_ARRAY		3	/* Array	*/
-#define BTF_KIND_STRUCT		4	/* Struct	*/
-#define BTF_KIND_UNION		5	/* Union	*/
-#define BTF_KIND_ENUM		6	/* Enumeration	*/
-#define BTF_KIND_FWD		7	/* Forward	*/
-#define BTF_KIND_TYPEDEF	8	/* Typedef	*/
-#define BTF_KIND_VOLATILE	9	/* Volatile	*/
-#define BTF_KIND_CONST		10	/* Const	*/
-#define BTF_KIND_RESTRICT	11	/* Restrict	*/
-#define BTF_KIND_FUNC		12	/* Function	*/
-#define BTF_KIND_FUNC_PROTO	13	/* Function Proto	*/
-#define BTF_KIND_VAR		14	/* Variable	*/
-#define BTF_KIND_DATASEC	15	/* Section	*/
-#define BTF_KIND_FLOAT		16	/* Floating point	*/
-#define BTF_KIND_MAX		BTF_KIND_FLOAT
-#define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
+enum {
+	BTF_KIND_UNKN		=3D 0,	/* Unknown	*/
+	BTF_KIND_INT		=3D 1,	/* Integer	*/
+	BTF_KIND_PTR		=3D 2,	/* Pointer	*/
+	BTF_KIND_ARRAY		=3D 3,	/* Array	*/
+	BTF_KIND_STRUCT		=3D 4,	/* Struct	*/
+	BTF_KIND_UNION		=3D 5,	/* Union	*/
+	BTF_KIND_ENUM		=3D 6,	/* Enumeration	*/
+	BTF_KIND_FWD		=3D 7,	/* Forward	*/
+	BTF_KIND_TYPEDEF	=3D 8,	/* Typedef	*/
+	BTF_KIND_VOLATILE	=3D 9,	/* Volatile	*/
+	BTF_KIND_CONST		=3D 10,	/* Const	*/
+	BTF_KIND_RESTRICT	=3D 11,	/* Restrict	*/
+	BTF_KIND_FUNC		=3D 12,	/* Function	*/
+	BTF_KIND_FUNC_PROTO	=3D 13,	/* Function Proto	*/
+	BTF_KIND_VAR		=3D 14,	/* Variable	*/
+	BTF_KIND_DATASEC	=3D 15,	/* Section	*/
+	BTF_KIND_FLOAT		=3D 16,	/* Floating point	*/
+
+	NR_BTF_KINDS,
+	BTF_KIND_MAX		=3D NR_BTF_KINDS - 1,
+};
=20
 /* For some specific BTF_KIND, "struct btf_type" is immediately
  * followed by extra data.
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/bt=
f.h
index d27b1708efe9..10e401073dd1 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -56,25 +56,28 @@ struct btf_type {
 #define BTF_INFO_VLEN(info)	((info) & 0xffff)
 #define BTF_INFO_KFLAG(info)	((info) >> 31)
=20
-#define BTF_KIND_UNKN		0	/* Unknown	*/
-#define BTF_KIND_INT		1	/* Integer	*/
-#define BTF_KIND_PTR		2	/* Pointer	*/
-#define BTF_KIND_ARRAY		3	/* Array	*/
-#define BTF_KIND_STRUCT		4	/* Struct	*/
-#define BTF_KIND_UNION		5	/* Union	*/
-#define BTF_KIND_ENUM		6	/* Enumeration	*/
-#define BTF_KIND_FWD		7	/* Forward	*/
-#define BTF_KIND_TYPEDEF	8	/* Typedef	*/
-#define BTF_KIND_VOLATILE	9	/* Volatile	*/
-#define BTF_KIND_CONST		10	/* Const	*/
-#define BTF_KIND_RESTRICT	11	/* Restrict	*/
-#define BTF_KIND_FUNC		12	/* Function	*/
-#define BTF_KIND_FUNC_PROTO	13	/* Function Proto	*/
-#define BTF_KIND_VAR		14	/* Variable	*/
-#define BTF_KIND_DATASEC	15	/* Section	*/
-#define BTF_KIND_FLOAT		16	/* Floating point	*/
-#define BTF_KIND_MAX		BTF_KIND_FLOAT
-#define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
+enum {
+	BTF_KIND_UNKN		=3D 0,	/* Unknown	*/
+	BTF_KIND_INT		=3D 1,	/* Integer	*/
+	BTF_KIND_PTR		=3D 2,	/* Pointer	*/
+	BTF_KIND_ARRAY		=3D 3,	/* Array	*/
+	BTF_KIND_STRUCT		=3D 4,	/* Struct	*/
+	BTF_KIND_UNION		=3D 5,	/* Union	*/
+	BTF_KIND_ENUM		=3D 6,	/* Enumeration	*/
+	BTF_KIND_FWD		=3D 7,	/* Forward	*/
+	BTF_KIND_TYPEDEF	=3D 8,	/* Typedef	*/
+	BTF_KIND_VOLATILE	=3D 9,	/* Volatile	*/
+	BTF_KIND_CONST		=3D 10,	/* Const	*/
+	BTF_KIND_RESTRICT	=3D 11,	/* Restrict	*/
+	BTF_KIND_FUNC		=3D 12,	/* Function	*/
+	BTF_KIND_FUNC_PROTO	=3D 13,	/* Function Proto	*/
+	BTF_KIND_VAR		=3D 14,	/* Variable	*/
+	BTF_KIND_DATASEC	=3D 15,	/* Section	*/
+	BTF_KIND_FLOAT		=3D 16,	/* Floating point	*/
+
+	NR_BTF_KINDS,
+	BTF_KIND_MAX		=3D NR_BTF_KINDS - 1,
+};
=20
 /* For some specific BTF_KIND, "struct btf_type" is immediately
  * followed by extra data.
--=20
2.30.2

