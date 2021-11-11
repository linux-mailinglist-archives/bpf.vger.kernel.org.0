Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682D044DE75
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 00:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhKKX2n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 18:28:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233119AbhKKX2m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 18:28:42 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABN5tRD010252
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:25:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PIHZNHyITasDuBy1sLcMc2Qj33YXclcvyWFLLcSWpKU=;
 b=opJsbEoSB0Tg0xf3+C+SlKKz2Qhp/siF8AONgCs15MY87DNxzmK3g5t+Qs2ZnA/zEwrG
 6cfCpekTw0usrgrBOBUA48pvRiEEvgbe3yZWrB/LLw6I1aO+cGgGj/bXYta4hTtL6+JB
 Yt1y5qN6kKzjkqIwZUoT94ZKUkS+Q4HavL4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9bmu0jqk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:25:53 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 15:25:50 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id F212524B3D85; Thu, 11 Nov 2021 15:25:48 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 01/10] bpf: Support BTF_KIND_TYPE_TAG for btf_type_tag attributes
Date:   Thu, 11 Nov 2021 15:25:48 -0800
Message-ID: <20211111232548.787620-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111232543.786041-1-yhs@fb.com>
References: <20211111232543.786041-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Os11ZfoxfHGzxnSnMF1YeabxWnHGrn5j
X-Proofpoint-GUID: Os11ZfoxfHGzxnSnMF1YeabxWnHGrn5j
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 mlxlogscore=790 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM patches ([1] for clang, [2] and [3] for BPF backend)
added support for btf_type_tag attributes. This patch
added support for the kernel.

The main motivation for btf_type_tag is to bring kernel
annotations __user, __rcu etc. to btf. With such information
available in btf, bpf verifier can detect mis-usages
and reject the program. For example, for __user tagged pointer,
developers can then use proper helper like bpf_probe_read_user()
etc. to read the data.

BTF_KIND_TYPE_TAG may also useful for other tracing
facility where instead of to require user to specify
kernel/user address type, the kernel can detect it
by itself with btf.

  [1] https://reviews.llvm.org/D111199
  [2] https://reviews.llvm.org/D113222
  [3] https://reviews.llvm.org/D113496

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/btf.h       |  3 ++-
 kernel/bpf/btf.c               | 14 +++++++++++++-
 tools/include/uapi/linux/btf.h |  3 ++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index deb12f755f0f..b0d8fea1951d 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -43,7 +43,7 @@ struct btf_type {
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC, FUNC_PROTO, VAR and DECL_TAG.
+	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -75,6 +75,7 @@ enum {
 	BTF_KIND_DATASEC	=3D 15,	/* Section	*/
 	BTF_KIND_FLOAT		=3D 16,	/* Floating point	*/
 	BTF_KIND_DECL_TAG	=3D 17,	/* Decl Tag */
+	BTF_KIND_TYPE_TAG	=3D 18,	/* Type Tag */
=20
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		=3D NR_BTF_KINDS - 1,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cdb0fba65600..1dd9ba82da1e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -282,6 +282,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
 	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
+	[BTF_KIND_TYPE_TAG]	=3D "TYPE_TAG",
 };
=20
 const char *btf_type_str(const struct btf_type *t)
@@ -418,6 +419,7 @@ static bool btf_type_is_modifier(const struct btf_type =
*t)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_CONST:
 	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
 		return true;
 	}
=20
@@ -1737,6 +1739,7 @@ __btf_resolve_size(const struct btf *btf, const struc=
t btf_type *type,
 		case BTF_KIND_VOLATILE:
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
+		case BTF_KIND_TYPE_TAG:
 			id =3D type->type;
 			type =3D btf_type_by_id(btf, type->type);
 			break;
@@ -2345,6 +2348,8 @@ static int btf_ref_type_check_meta(struct btf_verifie=
r_env *env,
 				   const struct btf_type *t,
 				   u32 meta_left)
 {
+	const char *value;
+
 	if (btf_type_vlen(t)) {
 		btf_verifier_log_type(env, t, "vlen !=3D 0");
 		return -EINVAL;
@@ -2360,7 +2365,7 @@ static int btf_ref_type_check_meta(struct btf_verifie=
r_env *env,
 		return -EINVAL;
 	}
=20
-	/* typedef type must have a valid name, and other ref types,
+	/* typedef/type_tag type must have a valid name, and other ref types,
 	 * volatile, const, restrict, should have a null name.
 	 */
 	if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TYPEDEF) {
@@ -2369,6 +2374,12 @@ static int btf_ref_type_check_meta(struct btf_verifi=
er_env *env,
 			btf_verifier_log_type(env, t, "Invalid name");
 			return -EINVAL;
 		}
+	} else if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TYPE_TAG) {
+		value =3D btf_name_by_offset(env->btf, t->name_off);
+		if (!value || !value[0]) {
+			btf_verifier_log_type(env, t, "Invalid name");
+			return -EINVAL;
+		}
 	} else {
 		if (t->name_off) {
 			btf_verifier_log_type(env, t, "Invalid name");
@@ -4059,6 +4070,7 @@ static const struct btf_kind_operations * const kind_=
ops[NR_BTF_KINDS] =3D {
 	[BTF_KIND_DATASEC] =3D &datasec_ops,
 	[BTF_KIND_FLOAT] =3D &float_ops,
 	[BTF_KIND_DECL_TAG] =3D &decl_tag_ops,
+	[BTF_KIND_TYPE_TAG] =3D &modifier_ops,
 };
=20
 static s32 btf_check_meta(struct btf_verifier_env *env,
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index deb12f755f0f..b0d8fea1951d 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -43,7 +43,7 @@ struct btf_type {
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC, FUNC_PROTO, VAR and DECL_TAG.
+	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -75,6 +75,7 @@ enum {
 	BTF_KIND_DATASEC	=3D 15,	/* Section	*/
 	BTF_KIND_FLOAT		=3D 16,	/* Floating point	*/
 	BTF_KIND_DECL_TAG	=3D 17,	/* Decl Tag */
+	BTF_KIND_TYPE_TAG	=3D 18,	/* Type Tag */
=20
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		=3D NR_BTF_KINDS - 1,
--=20
2.30.2

