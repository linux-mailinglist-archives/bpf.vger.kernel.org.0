Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71C04097DD
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbhIMPw4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:52:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3242 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244469AbhIMPwv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 11:52:51 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF4V5P015366
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:51:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lQ6GVLoIvWQ2RBQqv9GfdakIqf7gcfL9O/w76S03K9Y=;
 b=f5Ar5Kk4sBzVICVqMvBwlu3sKAgIdVDFWltfydiq72TA7YeuWgbXky71Nh1C8gA8e/89
 f16RLNDbEx+oGwhkrprD6bMPaH7a93ohzele+beYRoQLM9fiBAPsw9hukukefwC6xe8R
 1dNi7BnkXBWxofZHzLNbQQIpy4PdM4lDhzQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1xdq3h3u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:51:34 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 08:51:33 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 86CD57278F5D; Mon, 13 Sep 2021 08:51:27 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 01/11] btf: change BTF_KIND_* macros to enums
Date:   Mon, 13 Sep 2021 08:51:27 -0700
Message-ID: <20210913155127.3723489-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913155122.3722704-1-yhs@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: fniXg80QbSexRld3_5LkmXI6Wwe4EBat
X-Proofpoint-GUID: fniXg80QbSexRld3_5LkmXI6Wwe4EBat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxlogscore=826 lowpriorityscore=0
 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change BTF_KIND_* macros to enums so they are encoded in dwarf and
appear in vmlinux.h. This will make it easier for bpf programs
to use these constants without macro definitions.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/btf.h       | 36 ++++++++++++++++++----------------
 tools/include/uapi/linux/btf.h | 36 ++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index d27b1708efe9..c32cd6697d63 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -56,23 +56,25 @@ struct btf_type {
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
+enum {
+	BTF_KIND_UNKN =3D	0,	/* Unknown	*/
+	BTF_KIND_INT,		/* Integer	*/
+	BTF_KIND_PTR,		/* Pointer	*/
+	BTF_KIND_ARRAY,		/* Array	*/
+	BTF_KIND_STRUCT,	/* Struct	*/
+	BTF_KIND_UNION,		/* Union	*/
+	BTF_KIND_ENUM,		/* Enumeration	*/
+	BTF_KIND_FWD,		/* Forward	*/
+	BTF_KIND_TYPEDEF,	/* Typedef	*/
+	BTF_KIND_VOLATILE,	/* Volatile	*/
+	BTF_KIND_CONST,		/* Const	*/
+	BTF_KIND_RESTRICT,	/* Restrict	*/
+	BTF_KIND_FUNC,		/* Function	*/
+	BTF_KIND_FUNC_PROTO,	/* Function Proto	*/
+	BTF_KIND_VAR,		/* Variable	*/
+	BTF_KIND_DATASEC,	/* Section	*/
+	BTF_KIND_FLOAT,		/* Floating point	*/
+};
 #define BTF_KIND_MAX		BTF_KIND_FLOAT
 #define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
=20
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/bt=
f.h
index d27b1708efe9..c32cd6697d63 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -56,23 +56,25 @@ struct btf_type {
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
+enum {
+	BTF_KIND_UNKN =3D	0,	/* Unknown	*/
+	BTF_KIND_INT,		/* Integer	*/
+	BTF_KIND_PTR,		/* Pointer	*/
+	BTF_KIND_ARRAY,		/* Array	*/
+	BTF_KIND_STRUCT,	/* Struct	*/
+	BTF_KIND_UNION,		/* Union	*/
+	BTF_KIND_ENUM,		/* Enumeration	*/
+	BTF_KIND_FWD,		/* Forward	*/
+	BTF_KIND_TYPEDEF,	/* Typedef	*/
+	BTF_KIND_VOLATILE,	/* Volatile	*/
+	BTF_KIND_CONST,		/* Const	*/
+	BTF_KIND_RESTRICT,	/* Restrict	*/
+	BTF_KIND_FUNC,		/* Function	*/
+	BTF_KIND_FUNC_PROTO,	/* Function Proto	*/
+	BTF_KIND_VAR,		/* Variable	*/
+	BTF_KIND_DATASEC,	/* Section	*/
+	BTF_KIND_FLOAT,		/* Floating point	*/
+};
 #define BTF_KIND_MAX		BTF_KIND_FLOAT
 #define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
=20
--=20
2.30.2

