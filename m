Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62C40314F
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbhIGXCI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 19:02:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347270AbhIGXCH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:02:07 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187N0Asr019235
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:01:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=v0pz4n+xUzjZZMlOZqom3RXByo2rza909mdikkbUE+o=;
 b=Le8qFNF9MrIvda/ecVSdbhkZrX7Non2VGgEuVrPXxtjPW9dNPu2j18DTY2KFPKH8UhTw
 qVoIJOrNSwK872rkW/m5TUQ2Q4f8MZDy6aeTHTs6+j9IBYHU/KIhw3MnQ81FWhT0qzwj
 1og0poOKvq5Mf2fUfOgL+NNR4jDKjRc5c0Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcnb9u7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:01:00 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:00:59 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5DF496E0C02A; Tue,  7 Sep 2021 16:00:55 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/9] bpf: support for new btf kind BTF_KIND_TAG
Date:   Tue, 7 Sep 2021 16:00:55 -0700
Message-ID: <20210907230055.1957809-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907230050.1957493-1-yhs@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: q2FJWkmiydyZxW7xF2LLGWNxMx5NCOwr
X-Proofpoint-GUID: q2FJWkmiydyZxW7xF2LLGWNxMx5NCOwr
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM14 added support for a new C attribute ([1])
  __attribute__((btf_tag("arbitrary_str")))
This attribute will be emitted to dwarf ([2]) and pahole
will convert it to BTF. Or for bpf target, this
attribute will be emitted to BTF directly ([3]).
The attribute is intended to provide additional
information for
  - struct/union type or struct/union member
  - static/global variables
  - static/global function or function parameter.

For linux kernel, the btf_tag can be applied
in various places to specify user pointer,
function pre- or post- condition, function
allow/deny in certain context, etc. Such information
will be encoded in vmlinux BTF and can be used
by verifier.

The btf_tag can also be applied to bpf programs
to help global verifiable functions, e.g.,
specifying preconditions, etc.

This patch added basic parsing and checking support
in kernel for new BTF_KIND_TAG kind.

 [1] https://reviews.llvm.org/D106614
 [2] https://reviews.llvm.org/D106621
 [3] https://reviews.llvm.org/D106622

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/uapi/linux/btf.h       |  15 ++++-
 kernel/bpf/btf.c               | 115 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/btf.h |  15 ++++-
 3 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index d27b1708efe9..ca73c4449116 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -36,14 +36,14 @@ struct btf_type {
 	 * bits 24-27: kind (e.g. int, ptr, array...etc)
 	 * bits 28-30: unused
 	 * bit     31: kind_flag, currently used by
-	 *             struct, union and fwd
+	 *             struct, union, fwd and tag
 	 */
 	__u32 info;
 	/* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC, FUNC_PROTO and VAR.
+	 * FUNC, FUNC_PROTO, VAR and TAG.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -73,7 +73,8 @@ struct btf_type {
 #define BTF_KIND_VAR		14	/* Variable	*/
 #define BTF_KIND_DATASEC	15	/* Section	*/
 #define BTF_KIND_FLOAT		16	/* Floating point	*/
-#define BTF_KIND_MAX		BTF_KIND_FLOAT
+#define BTF_KIND_TAG		17	/* Tag */
+#define BTF_KIND_MAX		BTF_KIND_TAG
 #define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
=20
 /* For some specific BTF_KIND, "struct btf_type" is immediately
@@ -170,4 +171,12 @@ struct btf_var_secinfo {
 	__u32	size;
 };
=20
+/* BTF_KIND_TAG is followed by a single "struct btf_tag" to describe
+ * additional information related to the tag such as which field of
+ * a struct or union or which argument of a function.
+ */
+struct btf_tag {
+       __u32   comp_id;
+};
+
 #endif /* _UAPI__LINUX_BTF_H__ */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dfe61df4f974..9545290f804b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -281,6 +281,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_VAR]		=3D "VAR",
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
+	[BTF_KIND_TAG]		=3D "TAG",
 };
=20
 const char *btf_type_str(const struct btf_type *t)
@@ -459,6 +460,17 @@ static bool btf_type_is_datasec(const struct btf_type =
*t)
 	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DATASEC;
 }
=20
+static bool btf_type_is_tag(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TAG;
+}
+
+static bool btf_type_is_tag_target(const struct btf_type *t)
+{
+	return btf_type_is_func(t) || btf_type_is_struct(t) ||
+	       btf_type_is_var(t);
+}
+
 u32 btf_nr_types(const struct btf *btf)
 {
 	u32 total =3D 0;
@@ -537,6 +549,7 @@ const struct btf_type *btf_type_resolve_func_ptr(const =
struct btf *btf,
 static bool btf_type_is_resolve_source_only(const struct btf_type *t)
 {
 	return btf_type_is_var(t) ||
+	       btf_type_is_tag(t) ||
 	       btf_type_is_datasec(t);
 }
=20
@@ -563,6 +576,7 @@ static bool btf_type_needs_resolve(const struct btf_typ=
e *t)
 	       btf_type_is_struct(t) ||
 	       btf_type_is_array(t) ||
 	       btf_type_is_var(t) ||
+	       btf_type_is_tag(t) ||
 	       btf_type_is_datasec(t);
 }
=20
@@ -616,6 +630,11 @@ static const struct btf_var *btf_type_var(const struct=
 btf_type *t)
 	return (const struct btf_var *)(t + 1);
 }
=20
+static const struct btf_tag *btf_type_tag(const struct btf_type *t)
+{
+	return (const struct btf_tag *)(t + 1);
+}
+
 static const struct btf_kind_operations *btf_type_ops(const struct btf_typ=
e *t)
 {
 	return kind_ops[BTF_INFO_KIND(t->info)];
@@ -3801,6 +3820,97 @@ static const struct btf_kind_operations float_ops =
=3D {
 	.show =3D btf_df_show,
 };
=20
+static s32 btf_tag_check_meta(struct btf_verifier_env *env,
+			      const struct btf_type *t,
+			      u32 meta_left)
+{
+	const struct btf_tag *tag;
+	u32 meta_needed =3D sizeof(*tag);
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				       meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (!t->name_off) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+
+	if (btf_type_vlen(t)) {
+		btf_verifier_log_type(env, t, "vlen !=3D 0");
+		return -EINVAL;
+	}
+
+	tag =3D btf_type_tag(t);
+	if (btf_type_kflag(t) && tag->comp_id) {
+		btf_verifier_log_type(env, t, "kflag/comp_id mismatch");
+		return -EINVAL;
+	}
+
+	btf_verifier_log_type(env, t, NULL);
+
+	return meta_needed;
+}
+
+static int btf_tag_resolve(struct btf_verifier_env *env,
+			   const struct resolve_vertex *v)
+{
+	const struct btf_type *next_type;
+	const struct btf_type *t =3D v->t;
+	u32 next_type_id =3D t->type;
+	struct btf *btf =3D env->btf;
+	u32 vlen, comp_id;
+
+	next_type =3D btf_type_by_id(btf, next_type_id);
+	if (!next_type || !btf_type_is_tag_target(next_type)) {
+		btf_verifier_log_type(env, v->t, "Invalid type_id");
+		return -EINVAL;
+	}
+
+	if (!env_type_is_resolve_sink(env, next_type) &&
+	    !env_type_is_resolved(env, next_type_id))
+		return env_stack_push(env, next_type, next_type_id);
+
+	if (!btf_type_kflag(t)) {
+		if (btf_type_is_struct(next_type)) {
+			vlen =3D btf_type_vlen(next_type);
+		} else if (btf_type_is_func(next_type)) {
+			next_type =3D btf_type_by_id(btf, next_type->type);
+			vlen =3D btf_type_vlen(next_type);
+		} else {
+			btf_verifier_log_type(env, v->t, "Invalid next_type");
+			return -EINVAL;
+		}
+
+		comp_id =3D btf_type_tag(t)->comp_id;
+		if (comp_id >=3D vlen) {
+			btf_verifier_log_type(env, v->t, "Invalid comp_id");
+			return -EINVAL;
+		}
+	}
+
+	env_stack_pop_resolved(env, next_type_id, 0);
+
+	return 0;
+}
+
+static void btf_tag_log(struct btf_verifier_env *env, const struct btf_typ=
e *t)
+{
+	btf_verifier_log(env, "type=3D%u", t->type);
+}
+
+static const struct btf_kind_operations tag_ops =3D {
+	.check_meta =3D btf_tag_check_meta,
+	.resolve =3D btf_tag_resolve,
+	.check_member =3D btf_df_check_member,
+	.check_kflag_member =3D btf_df_check_kflag_member,
+	.log_details =3D btf_tag_log,
+	.show =3D btf_df_show,
+};
+
 static int btf_func_proto_check(struct btf_verifier_env *env,
 				const struct btf_type *t)
 {
@@ -3935,6 +4045,7 @@ static const struct btf_kind_operations * const kind_=
ops[NR_BTF_KINDS] =3D {
 	[BTF_KIND_VAR] =3D &var_ops,
 	[BTF_KIND_DATASEC] =3D &datasec_ops,
 	[BTF_KIND_FLOAT] =3D &float_ops,
+	[BTF_KIND_TAG] =3D &tag_ops,
 };
=20
 static s32 btf_check_meta(struct btf_verifier_env *env,
@@ -4019,6 +4130,10 @@ static bool btf_resolve_valid(struct btf_verifier_en=
v *env,
 		return !btf_resolved_type_id(btf, type_id) &&
 		       !btf_resolved_type_size(btf, type_id);
=20
+	if (btf_type_is_tag(t))
+		return btf_resolved_type_id(btf, type_id) &&
+		       !btf_resolved_type_size(btf, type_id);
+
 	if (btf_type_is_modifier(t) || btf_type_is_ptr(t) ||
 	    btf_type_is_var(t)) {
 		t =3D btf_type_id_resolve(btf, &type_id);
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index d27b1708efe9..ca73c4449116 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -36,14 +36,14 @@ struct btf_type {
 	 * bits 24-27: kind (e.g. int, ptr, array...etc)
 	 * bits 28-30: unused
 	 * bit     31: kind_flag, currently used by
-	 *             struct, union and fwd
+	 *             struct, union, fwd and tag
 	 */
 	__u32 info;
 	/* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC, FUNC_PROTO and VAR.
+	 * FUNC, FUNC_PROTO, VAR and TAG.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -73,7 +73,8 @@ struct btf_type {
 #define BTF_KIND_VAR		14	/* Variable	*/
 #define BTF_KIND_DATASEC	15	/* Section	*/
 #define BTF_KIND_FLOAT		16	/* Floating point	*/
-#define BTF_KIND_MAX		BTF_KIND_FLOAT
+#define BTF_KIND_TAG		17	/* Tag */
+#define BTF_KIND_MAX		BTF_KIND_TAG
 #define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
=20
 /* For some specific BTF_KIND, "struct btf_type" is immediately
@@ -170,4 +171,12 @@ struct btf_var_secinfo {
 	__u32	size;
 };
=20
+/* BTF_KIND_TAG is followed by a single "struct btf_tag" to describe
+ * additional information related to the tag such as which field of
+ * a struct or union or which argument of a function.
+ */
+struct btf_tag {
+       __u32   comp_id;
+};
+
 #endif /* _UAPI__LINUX_BTF_H__ */
--=20
2.30.2

