Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F8F42A9EF
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJLQvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 12:51:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231751AbhJLQut (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 12:50:49 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CGSqOY030034
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 09:48:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=M54RlGDwsggjNNPiKxRt2agPPUFz0C9Q20/um3URb28=;
 b=cUkuNcSrXYpWh6c3Pz9SG3UiKb5MURqi8HSonbD069dZfRu+So1zFOgiG6URq8aTgbWA
 6eeC6Y00smXYF3SopgdBaHFQeHgkGtOmtDeALgd7fExirDAQDokotRO3ygbimpSlvVGM
 ffcvFh+bvdC0s8yjurqPkg4g3Pxy54pOpb4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bndwqg55x-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 09:48:47 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 12 Oct 2021 09:48:44 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9C5FAE7CCAE; Tue, 12 Oct 2021 09:48:38 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3] bpf: rename BTF_KIND_TAG to BTF_KIND_DECL_TAG
Date:   Tue, 12 Oct 2021 09:48:38 -0700
Message-ID: <20211012164838.3345699-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: OMleqSfMtdYJiyNxITqNUxNDgtDbNQqw
X-Proofpoint-GUID: OMleqSfMtdYJiyNxITqNUxNDgtDbNQqw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_04,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patch set [1] introduced BTF_KIND_TAG to allow tagging
declarations for struct/union, struct/union field, var, func
and func arguments and these tags will be encoded into
dwarf. They are also encoded to btf by llvm for the bpf target.

After BTF_KIND_TAG is introduced, we intended to use it
for kernel __user attributes. But kernel __user is actually
a type attribute. Upstream and internal discussion showed
it is not a good idea to mix declaration attribute and
type attribute. So we proposed to introduce btf_type_tag
as a type attribute and existing btf_tag renamed to
btf_decl_tag ([2]).

This patch renamed BTF_KIND_TAG to BTF_KIND_DECL_TAG and some
other declarations with *_tag to *_decl_tag to make it clear
the tag is for declaration. In the future, BTF_KIND_TYPE_TAG
might be introduced per [3].

 [1] https://lore.kernel.org/bpf/20210914223004.244411-1-yhs@fb.com/
 [2] https://reviews.llvm.org/D111588
 [3] https://reviews.llvm.org/D111199

Fixes: b5ea834dde6b ("bpf: Support for new btf kind BTF_KIND_TAG")
Fixes: 5b84bd10363e ("libbpf: Add support for BTF_KIND_TAG")
Fixes: 5c07f2fec003 ("bpftool: Add support for BTF_KIND_TAG")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst                     |  24 +--
 include/uapi/linux/btf.h                      |   8 +-
 kernel/bpf/btf.c                              |  44 ++---
 tools/bpf/bpftool/btf.c                       |   6 +-
 tools/include/uapi/linux/btf.h                |   8 +-
 tools/lib/bpf/btf.c                           |  36 ++--
 tools/lib/bpf/btf.h                           |  12 +-
 tools/lib/bpf/btf_dump.c                      |   6 +-
 tools/lib/bpf/libbpf.c                        |  24 +--
 tools/lib/bpf/libbpf.map                      |   2 +-
 tools/lib/bpf/libbpf_internal.h               |   4 +-
 tools/testing/selftests/bpf/README.rst        |   4 +-
 tools/testing/selftests/bpf/btf_helpers.c     |   8 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  | 160 +++++++++---------
 .../selftests/bpf/prog_tests/btf_write.c      |  30 ++--
 tools/testing/selftests/bpf/progs/tag.c       |   6 +-
 tools/testing/selftests/bpf/test_btf.h        |   4 +-
 17 files changed, 193 insertions(+), 193 deletions(-)

Changelogs:
  v2 -> v3:
    - clang patch to rename btf_tag to btf_decl_tag has landed,
      so update selftests/bpf/progs/tag.c and selftests/bpf/README.rst
      accordingly.
  v1 -> v2:
    - add Fixes tags

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 1bfe4072f5fc..9e5b4a98af76 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -85,7 +85,7 @@ sequentially and type id is assigned to each recognized t=
ype starting from id
     #define BTF_KIND_VAR            14      /* Variable     */
     #define BTF_KIND_DATASEC        15      /* Section      */
     #define BTF_KIND_FLOAT          16      /* Floating point       */
-    #define BTF_KIND_TAG            17      /* Tag          */
+    #define BTF_KIND_DECL_TAG       17      /* Decl Tag     */
=20
 Note that the type section encodes debug info, not just pure types.
 ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
@@ -107,7 +107,7 @@ Each type contains the following common data::
          * "size" tells the size of the type it is describing.
          *
          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-         * FUNC, FUNC_PROTO and TAG.
+         * FUNC, FUNC_PROTO and DECL_TAG.
          * "type" is a type_id referring to another type.
          */
         union {
@@ -466,30 +466,30 @@ map definition.
=20
 No additional type data follow ``btf_type``.
=20
-2.2.17 BTF_KIND_TAG
-~~~~~~~~~~~~~~~~~~~
+2.2.17 BTF_KIND_DECL_TAG
+~~~~~~~~~~~~~~~~~~~~~~~~
=20
 ``struct btf_type`` encoding requirement:
  * ``name_off``: offset to a non-empty string
  * ``info.kind_flag``: 0
- * ``info.kind``: BTF_KIND_TAG
+ * ``info.kind``: BTF_KIND_DECL_TAG
  * ``info.vlen``: 0
  * ``type``: ``struct``, ``union``, ``func`` or ``var``
=20
-``btf_type`` is followed by ``struct btf_tag``.::
+``btf_type`` is followed by ``struct btf_decl_tag``.::
=20
-    struct btf_tag {
+    struct btf_decl_tag {
         __u32   component_idx;
     };
=20
-The ``name_off`` encodes btf_tag attribute string.
+The ``name_off`` encodes btf_decl_tag attribute string.
 The ``type`` should be ``struct``, ``union``, ``func`` or ``var``.
-For ``var`` type, ``btf_tag.component_idx`` must be ``-1``.
-For the other three types, if the btf_tag attribute is
+For ``var`` type, ``btf_decl_tag.component_idx`` must be ``-1``.
+For the other three types, if the btf_decl_tag attribute is
 applied to the ``struct``, ``union`` or ``func`` itself,
-``btf_tag.component_idx`` must be ``-1``. Otherwise,
+``btf_decl_tag.component_idx`` must be ``-1``. Otherwise,
 the attribute is applied to a ``struct``/``union`` member or
-a ``func`` argument, and ``btf_tag.component_idx`` should be a
+a ``func`` argument, and ``btf_decl_tag.component_idx`` should be a
 valid index (starting from 0) pointing to a member or an argument.
=20
 3. BTF Kernel API
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 642b6ecb37d7..deb12f755f0f 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -43,7 +43,7 @@ struct btf_type {
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC, FUNC_PROTO, VAR and TAG.
+	 * FUNC, FUNC_PROTO, VAR and DECL_TAG.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -74,7 +74,7 @@ enum {
 	BTF_KIND_VAR		=3D 14,	/* Variable	*/
 	BTF_KIND_DATASEC	=3D 15,	/* Section	*/
 	BTF_KIND_FLOAT		=3D 16,	/* Floating point	*/
-	BTF_KIND_TAG		=3D 17,	/* Tag */
+	BTF_KIND_DECL_TAG	=3D 17,	/* Decl Tag */
=20
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		=3D NR_BTF_KINDS - 1,
@@ -174,14 +174,14 @@ struct btf_var_secinfo {
 	__u32	size;
 };
=20
-/* BTF_KIND_TAG is followed by a single "struct btf_tag" to describe
+/* BTF_KIND_DECL_TAG is followed by a single "struct btf_decl_tag" to desc=
ribe
  * additional information related to the tag applied location.
  * If component_idx =3D=3D -1, the tag is applied to a struct, union,
  * variable or function. Otherwise, it is applied to a struct/union
  * member or a func argument, and component_idx indicates which member
  * or argument (0 ... vlen-1).
  */
-struct btf_tag {
+struct btf_decl_tag {
        __s32   component_idx;
 };
=20
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2ebffb9f57eb..9059053088b9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -281,7 +281,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_VAR]		=3D "VAR",
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
-	[BTF_KIND_TAG]		=3D "TAG",
+	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
 };
=20
 const char *btf_type_str(const struct btf_type *t)
@@ -460,12 +460,12 @@ static bool btf_type_is_datasec(const struct btf_type=
 *t)
 	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DATASEC;
 }
=20
-static bool btf_type_is_tag(const struct btf_type *t)
+static bool btf_type_is_decl_tag(const struct btf_type *t)
 {
-	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TAG;
+	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DECL_TAG;
 }
=20
-static bool btf_type_is_tag_target(const struct btf_type *t)
+static bool btf_type_is_decl_tag_target(const struct btf_type *t)
 {
 	return btf_type_is_func(t) || btf_type_is_struct(t) ||
 	       btf_type_is_var(t);
@@ -549,7 +549,7 @@ const struct btf_type *btf_type_resolve_func_ptr(const =
struct btf *btf,
 static bool btf_type_is_resolve_source_only(const struct btf_type *t)
 {
 	return btf_type_is_var(t) ||
-	       btf_type_is_tag(t) ||
+	       btf_type_is_decl_tag(t) ||
 	       btf_type_is_datasec(t);
 }
=20
@@ -576,7 +576,7 @@ static bool btf_type_needs_resolve(const struct btf_typ=
e *t)
 	       btf_type_is_struct(t) ||
 	       btf_type_is_array(t) ||
 	       btf_type_is_var(t) ||
-	       btf_type_is_tag(t) ||
+	       btf_type_is_decl_tag(t) ||
 	       btf_type_is_datasec(t);
 }
=20
@@ -630,9 +630,9 @@ static const struct btf_var *btf_type_var(const struct =
btf_type *t)
 	return (const struct btf_var *)(t + 1);
 }
=20
-static const struct btf_tag *btf_type_tag(const struct btf_type *t)
+static const struct btf_decl_tag *btf_type_decl_tag(const struct btf_type =
*t)
 {
-	return (const struct btf_tag *)(t + 1);
+	return (const struct btf_decl_tag *)(t + 1);
 }
=20
 static const struct btf_kind_operations *btf_type_ops(const struct btf_typ=
e *t)
@@ -3820,11 +3820,11 @@ static const struct btf_kind_operations float_ops =
=3D {
 	.show =3D btf_df_show,
 };
=20
-static s32 btf_tag_check_meta(struct btf_verifier_env *env,
+static s32 btf_decl_tag_check_meta(struct btf_verifier_env *env,
 			      const struct btf_type *t,
 			      u32 meta_left)
 {
-	const struct btf_tag *tag;
+	const struct btf_decl_tag *tag;
 	u32 meta_needed =3D sizeof(*tag);
 	s32 component_idx;
 	const char *value;
@@ -3852,7 +3852,7 @@ static s32 btf_tag_check_meta(struct btf_verifier_env=
 *env,
 		return -EINVAL;
 	}
=20
-	component_idx =3D btf_type_tag(t)->component_idx;
+	component_idx =3D btf_type_decl_tag(t)->component_idx;
 	if (component_idx < -1) {
 		btf_verifier_log_type(env, t, "Invalid component_idx");
 		return -EINVAL;
@@ -3863,7 +3863,7 @@ static s32 btf_tag_check_meta(struct btf_verifier_env=
 *env,
 	return meta_needed;
 }
=20
-static int btf_tag_resolve(struct btf_verifier_env *env,
+static int btf_decl_tag_resolve(struct btf_verifier_env *env,
 			   const struct resolve_vertex *v)
 {
 	const struct btf_type *next_type;
@@ -3874,7 +3874,7 @@ static int btf_tag_resolve(struct btf_verifier_env *e=
nv,
 	u32 vlen;
=20
 	next_type =3D btf_type_by_id(btf, next_type_id);
-	if (!next_type || !btf_type_is_tag_target(next_type)) {
+	if (!next_type || !btf_type_is_decl_tag_target(next_type)) {
 		btf_verifier_log_type(env, v->t, "Invalid type_id");
 		return -EINVAL;
 	}
@@ -3883,7 +3883,7 @@ static int btf_tag_resolve(struct btf_verifier_env *e=
nv,
 	    !env_type_is_resolved(env, next_type_id))
 		return env_stack_push(env, next_type, next_type_id);
=20
-	component_idx =3D btf_type_tag(t)->component_idx;
+	component_idx =3D btf_type_decl_tag(t)->component_idx;
 	if (component_idx !=3D -1) {
 		if (btf_type_is_var(next_type)) {
 			btf_verifier_log_type(env, v->t, "Invalid component_idx");
@@ -3909,18 +3909,18 @@ static int btf_tag_resolve(struct btf_verifier_env =
*env,
 	return 0;
 }
=20
-static void btf_tag_log(struct btf_verifier_env *env, const struct btf_typ=
e *t)
+static void btf_decl_tag_log(struct btf_verifier_env *env, const struct bt=
f_type *t)
 {
 	btf_verifier_log(env, "type=3D%u component_idx=3D%d", t->type,
-			 btf_type_tag(t)->component_idx);
+			 btf_type_decl_tag(t)->component_idx);
 }
=20
-static const struct btf_kind_operations tag_ops =3D {
-	.check_meta =3D btf_tag_check_meta,
-	.resolve =3D btf_tag_resolve,
+static const struct btf_kind_operations decl_tag_ops =3D {
+	.check_meta =3D btf_decl_tag_check_meta,
+	.resolve =3D btf_decl_tag_resolve,
 	.check_member =3D btf_df_check_member,
 	.check_kflag_member =3D btf_df_check_kflag_member,
-	.log_details =3D btf_tag_log,
+	.log_details =3D btf_decl_tag_log,
 	.show =3D btf_df_show,
 };
=20
@@ -4058,7 +4058,7 @@ static const struct btf_kind_operations * const kind_=
ops[NR_BTF_KINDS] =3D {
 	[BTF_KIND_VAR] =3D &var_ops,
 	[BTF_KIND_DATASEC] =3D &datasec_ops,
 	[BTF_KIND_FLOAT] =3D &float_ops,
-	[BTF_KIND_TAG] =3D &tag_ops,
+	[BTF_KIND_DECL_TAG] =3D &decl_tag_ops,
 };
=20
 static s32 btf_check_meta(struct btf_verifier_env *env,
@@ -4143,7 +4143,7 @@ static bool btf_resolve_valid(struct btf_verifier_env=
 *env,
 		return !btf_resolved_type_id(btf, type_id) &&
 		       !btf_resolved_type_size(btf, type_id);
=20
-	if (btf_type_is_tag(t))
+	if (btf_type_is_decl_tag(t))
 		return btf_resolved_type_id(btf, type_id) &&
 		       !btf_resolved_type_size(btf, type_id);
=20
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 49743ad96851..7b68d4f65fe6 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -37,7 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =3D {
 	[BTF_KIND_VAR]		=3D "VAR",
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
-	[BTF_KIND_TAG]		=3D "TAG",
+	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
 };
=20
 struct btf_attach_table {
@@ -348,8 +348,8 @@ static int dump_btf_type(const struct btf *btf, __u32 i=
d,
 			printf(" size=3D%u", t->size);
 		break;
 	}
-	case BTF_KIND_TAG: {
-		const struct btf_tag *tag =3D (const void *)(t + 1);
+	case BTF_KIND_DECL_TAG: {
+		const struct btf_decl_tag *tag =3D (const void *)(t + 1);
=20
 		if (json_output) {
 			jsonw_uint_field(w, "type_id", t->type);
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 642b6ecb37d7..deb12f755f0f 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -43,7 +43,7 @@ struct btf_type {
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC, FUNC_PROTO, VAR and TAG.
+	 * FUNC, FUNC_PROTO, VAR and DECL_TAG.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -74,7 +74,7 @@ enum {
 	BTF_KIND_VAR		=3D 14,	/* Variable	*/
 	BTF_KIND_DATASEC	=3D 15,	/* Section	*/
 	BTF_KIND_FLOAT		=3D 16,	/* Floating point	*/
-	BTF_KIND_TAG		=3D 17,	/* Tag */
+	BTF_KIND_DECL_TAG	=3D 17,	/* Decl Tag */
=20
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		=3D NR_BTF_KINDS - 1,
@@ -174,14 +174,14 @@ struct btf_var_secinfo {
 	__u32	size;
 };
=20
-/* BTF_KIND_TAG is followed by a single "struct btf_tag" to describe
+/* BTF_KIND_DECL_TAG is followed by a single "struct btf_decl_tag" to desc=
ribe
  * additional information related to the tag applied location.
  * If component_idx =3D=3D -1, the tag is applied to a struct, union,
  * variable or function. Otherwise, it is applied to a struct/union
  * member or a func argument, and component_idx indicates which member
  * or argument (0 ... vlen-1).
  */
-struct btf_tag {
+struct btf_decl_tag {
        __s32   component_idx;
 };
=20
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 60fbd1c6d466..1f6dea11f600 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -309,8 +309,8 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + sizeof(struct btf_var);
 	case BTF_KIND_DATASEC:
 		return base_size + vlen * sizeof(struct btf_var_secinfo);
-	case BTF_KIND_TAG:
-		return base_size + sizeof(struct btf_tag);
+	case BTF_KIND_DECL_TAG:
+		return base_size + sizeof(struct btf_decl_tag);
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
 		return -EINVAL;
@@ -383,8 +383,8 @@ static int btf_bswap_type_rest(struct btf_type *t)
 			v->size =3D bswap_32(v->size);
 		}
 		return 0;
-	case BTF_KIND_TAG:
-		btf_tag(t)->component_idx =3D bswap_32(btf_tag(t)->component_idx);
+	case BTF_KIND_DECL_TAG:
+		btf_decl_tag(t)->component_idx =3D bswap_32(btf_decl_tag(t)->component_i=
dx);
 		return 0;
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
@@ -596,7 +596,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 ty=
pe_id)
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_VAR:
-		case BTF_KIND_TAG:
+		case BTF_KIND_DECL_TAG:
 			type_id =3D t->type;
 			break;
 		case BTF_KIND_ARRAY:
@@ -2569,7 +2569,7 @@ int btf__add_datasec_var_info(struct btf *btf, int va=
r_type_id, __u32 offset, __
 }
=20
 /*
- * Append new BTF_KIND_TAG type with:
+ * Append new BTF_KIND_DECL_TAG type with:
  *   - *value* - non-empty/non-NULL string;
  *   - *ref_type_id* - referenced type ID, it might not exist yet;
  *   - *component_idx* - -1 for tagging reference type, otherwise struct/u=
nion
@@ -2578,7 +2578,7 @@ int btf__add_datasec_var_info(struct btf *btf, int va=
r_type_id, __u32 offset, __
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
  */
-int btf__add_tag(struct btf *btf, const char *value, int ref_type_id,
+int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 		 int component_idx)
 {
 	struct btf_type *t;
@@ -2593,7 +2593,7 @@ int btf__add_tag(struct btf *btf, const char *value, =
int ref_type_id,
 	if (btf_ensure_modifiable(btf))
 		return libbpf_err(-ENOMEM);
=20
-	sz =3D sizeof(struct btf_type) + sizeof(struct btf_tag);
+	sz =3D sizeof(struct btf_type) + sizeof(struct btf_decl_tag);
 	t =3D btf_add_type_mem(btf, sz);
 	if (!t)
 		return libbpf_err(-ENOMEM);
@@ -2603,9 +2603,9 @@ int btf__add_tag(struct btf *btf, const char *value, =
int ref_type_id,
 		return value_off;
=20
 	t->name_off =3D value_off;
-	t->info =3D btf_type_info(BTF_KIND_TAG, 0, false);
+	t->info =3D btf_type_info(BTF_KIND_DECL_TAG, 0, false);
 	t->type =3D ref_type_id;
-	btf_tag(t)->component_idx =3D component_idx;
+	btf_decl_tag(t)->component_idx =3D component_idx;
=20
 	return btf_commit_type(btf, sz);
 }
@@ -3427,7 +3427,7 @@ static bool btf_equal_common(struct btf_type *t1, str=
uct btf_type *t2)
 }
=20
 /* Calculate type signature hash of INT or TAG. */
-static long btf_hash_int_tag(struct btf_type *t)
+static long btf_hash_int_decl_tag(struct btf_type *t)
 {
 	__u32 info =3D *(__u32 *)(t + 1);
 	long h;
@@ -3705,8 +3705,8 @@ static int btf_dedup_prep(struct btf_dedup *d)
 			h =3D btf_hash_common(t);
 			break;
 		case BTF_KIND_INT:
-		case BTF_KIND_TAG:
-			h =3D btf_hash_int_tag(t);
+		case BTF_KIND_DECL_TAG:
+			h =3D btf_hash_int_decl_tag(t);
 			break;
 		case BTF_KIND_ENUM:
 			h =3D btf_hash_enum(t);
@@ -3761,11 +3761,11 @@ static int btf_dedup_prim_type(struct btf_dedup *d,=
 __u32 type_id)
 	case BTF_KIND_FUNC_PROTO:
 	case BTF_KIND_VAR:
 	case BTF_KIND_DATASEC:
-	case BTF_KIND_TAG:
+	case BTF_KIND_DECL_TAG:
 		return 0;
=20
 	case BTF_KIND_INT:
-		h =3D btf_hash_int_tag(t);
+		h =3D btf_hash_int_decl_tag(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id =3D (__u32)(long)hash_entry->value;
 			cand =3D btf_type_by_id(d->btf, cand_id);
@@ -4382,13 +4382,13 @@ static int btf_dedup_ref_type(struct btf_dedup *d, =
__u32 type_id)
 		}
 		break;
=20
-	case BTF_KIND_TAG:
+	case BTF_KIND_DECL_TAG:
 		ref_type_id =3D btf_dedup_ref_type(d, t->type);
 		if (ref_type_id < 0)
 			return ref_type_id;
 		t->type =3D ref_type_id;
=20
-		h =3D btf_hash_int_tag(t);
+		h =3D btf_hash_int_decl_tag(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id =3D (__u32)(long)hash_entry->value;
 			cand =3D btf_type_by_id(d->btf, cand_id);
@@ -4671,7 +4671,7 @@ int btf_type_visit_type_ids(struct btf_type *t, type_=
id_visit_fn visit, void *ct
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
-	case BTF_KIND_TAG:
+	case BTF_KIND_DECL_TAG:
 		return visit(&t->type, ctx);
=20
 	case BTF_KIND_ARRAY: {
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 864eb51753a1..4011e206e6f7 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -236,7 +236,7 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *bt=
f, int var_type_id,
 					 __u32 offset, __u32 byte_sz);
=20
 /* tag construction API */
-LIBBPF_API int btf__add_tag(struct btf *btf, const char *value, int ref_ty=
pe_id,
+LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int r=
ef_type_id,
 			    int component_idx);
=20
 struct btf_dedup_opts {
@@ -426,9 +426,9 @@ static inline bool btf_is_float(const struct btf_type *=
t)
 	return btf_kind(t) =3D=3D BTF_KIND_FLOAT;
 }
=20
-static inline bool btf_is_tag(const struct btf_type *t)
+static inline bool btf_is_decl_tag(const struct btf_type *t)
 {
-	return btf_kind(t) =3D=3D BTF_KIND_TAG;
+	return btf_kind(t) =3D=3D BTF_KIND_DECL_TAG;
 }
=20
 static inline __u8 btf_int_encoding(const struct btf_type *t)
@@ -499,10 +499,10 @@ btf_var_secinfos(const struct btf_type *t)
 	return (struct btf_var_secinfo *)(t + 1);
 }
=20
-struct btf_tag;
-static inline struct btf_tag *btf_tag(const struct btf_type *t)
+struct btf_decl_tag;
+static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 {
-	return (struct btf_tag *)(t + 1);
+	return (struct btf_decl_tag *)(t + 1);
 }
=20
 #ifdef __cplusplus
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ad6df97295ae..5ef42f0abed1 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -316,7 +316,7 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FUNC:
 		case BTF_KIND_VAR:
-		case BTF_KIND_TAG:
+		case BTF_KIND_DECL_TAG:
 			d->type_states[t->type].referenced =3D 1;
 			break;
=20
@@ -584,7 +584,7 @@ static int btf_dump_order_type(struct btf_dump *d, __u3=
2 id, bool through_ptr)
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
 	case BTF_KIND_DATASEC:
-	case BTF_KIND_TAG:
+	case BTF_KIND_DECL_TAG:
 		d->type_states[id].order_state =3D ORDERED;
 		return 0;
=20
@@ -2217,7 +2217,7 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
 	case BTF_KIND_FWD:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_FUNC_PROTO:
-	case BTF_KIND_TAG:
+	case BTF_KIND_DECL_TAG:
 		err =3D btf_dump_unsupported_data(d, t, id);
 		break;
 	case BTF_KIND_INT:
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ae0889bebe32..63d738654ff6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -195,8 +195,8 @@ enum kern_feature_id {
 	FEAT_BTF_FLOAT,
 	/* BPF perf link support */
 	FEAT_PERF_LINK,
-	/* BTF_KIND_TAG support */
-	FEAT_BTF_TAG,
+	/* BTF_KIND_DECL_TAG support */
+	FEAT_BTF_DECL_TAG,
 	__FEAT_CNT,
 };
=20
@@ -2024,7 +2024,7 @@ static const char *__btf_kind_str(__u16 kind)
 	case BTF_KIND_VAR: return "var";
 	case BTF_KIND_DATASEC: return "datasec";
 	case BTF_KIND_FLOAT: return "float";
-	case BTF_KIND_TAG: return "tag";
+	case BTF_KIND_DECL_TAG: return "decl_tag";
 	default: return "unknown";
 	}
 }
@@ -2524,9 +2524,9 @@ static bool btf_needs_sanitization(struct bpf_object =
*obj)
 	bool has_datasec =3D kernel_supports(obj, FEAT_BTF_DATASEC);
 	bool has_float =3D kernel_supports(obj, FEAT_BTF_FLOAT);
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
-	bool has_tag =3D kernel_supports(obj, FEAT_BTF_TAG);
+	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
=20
-	return !has_func || !has_datasec || !has_func_global || !has_float || !ha=
s_tag;
+	return !has_func || !has_datasec || !has_func_global || !has_float || !ha=
s_decl_tag;
 }
=20
 static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *b=
tf)
@@ -2535,15 +2535,15 @@ static void bpf_object__sanitize_btf(struct bpf_obj=
ect *obj, struct btf *btf)
 	bool has_datasec =3D kernel_supports(obj, FEAT_BTF_DATASEC);
 	bool has_float =3D kernel_supports(obj, FEAT_BTF_FLOAT);
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
-	bool has_tag =3D kernel_supports(obj, FEAT_BTF_TAG);
+	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	struct btf_type *t;
 	int i, j, vlen;
=20
 	for (i =3D 1; i <=3D btf__get_nr_types(btf); i++) {
 		t =3D (struct btf_type *)btf__type_by_id(btf, i);
=20
-		if ((!has_datasec && btf_is_var(t)) || (!has_tag && btf_is_tag(t))) {
-			/* replace VAR/TAG with INT */
+		if ((!has_datasec && btf_is_var(t)) || (!has_decl_tag && btf_is_decl_tag=
(t))) {
+			/* replace VAR/DECL_TAG with INT */
 			t->info =3D BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
 			/*
 			 * using size =3D 1 is the safest choice, 4 will be too
@@ -4248,7 +4248,7 @@ static int probe_kern_btf_float(void)
 					     strs, sizeof(strs)));
 }
=20
-static int probe_kern_btf_tag(void)
+static int probe_kern_btf_decl_tag(void)
 {
 	static const char strs[] =3D "\0tag";
 	__u32 types[] =3D {
@@ -4258,7 +4258,7 @@ static int probe_kern_btf_tag(void)
 		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
 		BTF_VAR_STATIC,
 		/* attr */
-		BTF_TYPE_TAG_ENC(1, 2, -1),
+		BTF_TYPE_DECL_TAG_ENC(1, 2, -1),
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
@@ -4481,8 +4481,8 @@ static struct kern_feature_desc {
 	[FEAT_PERF_LINK] =3D {
 		"BPF perf link support", probe_perf_link,
 	},
-	[FEAT_BTF_TAG] =3D {
-		"BTF_KIND_TAG support", probe_kern_btf_tag,
+	[FEAT_BTF_DECL_TAG] =3D {
+		"BTF_KIND_DECL_TAG support", probe_kern_btf_decl_tag,
 	},
 };
=20
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f270d25e4af3..e6fb1ba49369 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -394,5 +394,5 @@ LIBBPF_0.6.0 {
 		bpf_object__prev_map;
 		bpf_object__prev_program;
 		btf__add_btf;
-		btf__add_tag;
+		btf__add_decl_tag;
 } LIBBPF_0.5.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_interna=
l.h
index f7fd3944d46d..f6a5748dd318 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -69,8 +69,8 @@
 #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
 #define BTF_TYPE_FLOAT_ENC(name, sz) \
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
-#define BTF_TYPE_TAG_ENC(value, type, component_idx) \
-	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (component_i=
dx)
+#define BTF_TYPE_DECL_TAG_ENC(value, type, component_idx) \
+	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), type), (compon=
ent_idx)
=20
 #ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftes=
ts/bpf/README.rst
index 554553acc6d9..5e287e445f75 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -204,7 +204,7 @@ __ https://reviews.llvm.org/D93563
 btf_tag test and Clang version
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
-The btf_tag selftest require LLVM support to recognize the btf_tag attribu=
te.
+The btf_tag selftest require LLVM support to recognize the btf_decl_tag at=
tribute.
 It was introduced in `Clang 14`__.
=20
 Without it, the btf_tag selftest will be skipped and you will observe:
@@ -213,7 +213,7 @@ Without it, the btf_tag selftest will be skipped and yo=
u will observe:
=20
   #<test_num> btf_tag:SKIP
=20
-__ https://reviews.llvm.org/D106614
+__ https://reviews.llvm.org/D111588
=20
 Clang dependencies for static linking tests
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/self=
tests/bpf/btf_helpers.c
index ce103fb0ad1b..668cfa20bb1b 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -24,12 +24,12 @@ static const char * const btf_kind_str_mapping[] =3D {
 	[BTF_KIND_VAR]		=3D "VAR",
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
-	[BTF_KIND_TAG]		=3D "TAG",
+	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
 };
=20
 static const char *btf_kind_str(__u16 kind)
 {
-	if (kind > BTF_KIND_TAG)
+	if (kind > BTF_KIND_DECL_TAG)
 		return "UNKNOWN";
 	return btf_kind_str_mapping[kind];
 }
@@ -178,9 +178,9 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *b=
tf, __u32 id)
 	case BTF_KIND_FLOAT:
 		fprintf(out, " size=3D%u", t->size);
 		break;
-	case BTF_KIND_TAG:
+	case BTF_KIND_DECL_TAG:
 		fprintf(out, " type_id=3D%u component_idx=3D%d",
-			t->type, btf_tag(t)->component_idx);
+			t->type, btf_decl_tag(t)->component_idx);
 		break;
 	default:
 		break;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/s=
elftests/bpf/prog_tests/btf.c
index acd33d0cd5d9..fa67f25bbef5 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3662,15 +3662,15 @@ static struct btf_raw_test raw_tests[] =3D {
 },
=20
 {
-	.descr =3D "tag test #1, struct/member, well-formed",
+	.descr =3D "decl_tag test #1, struct/member, well-formed",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_STRUCT_ENC(0, 2, 8),			/* [2] */
 		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
 		BTF_MEMBER_ENC(NAME_TBD, 1, 32),
-		BTF_TAG_ENC(NAME_TBD, 2, -1),
-		BTF_TAG_ENC(NAME_TBD, 2, 0),
-		BTF_TAG_ENC(NAME_TBD, 2, 1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, -1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, 0),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, 1),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0m1\0m2\0tag1\0tag2\0tag3"),
@@ -3683,15 +3683,15 @@ static struct btf_raw_test raw_tests[] =3D {
 	.max_entries =3D 1,
 },
 {
-	.descr =3D "tag test #2, union/member, well-formed",
+	.descr =3D "decl_tag test #2, union/member, well-formed",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_UNION_ENC(NAME_TBD, 2, 4),			/* [2] */
 		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
 		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
-		BTF_TAG_ENC(NAME_TBD, 2, -1),
-		BTF_TAG_ENC(NAME_TBD, 2, 0),
-		BTF_TAG_ENC(NAME_TBD, 2, 1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, -1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, 0),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, 1),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
@@ -3704,13 +3704,13 @@ static struct btf_raw_test raw_tests[] =3D {
 	.max_entries =3D 1,
 },
 {
-	.descr =3D "tag test #3, variable, well-formed",
+	.descr =3D "decl_tag test #3, variable, well-formed",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
 		BTF_VAR_ENC(NAME_TBD, 1, 1),			/* [3] */
-		BTF_TAG_ENC(NAME_TBD, 2, -1),
-		BTF_TAG_ENC(NAME_TBD, 3, -1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, -1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 3, -1),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0local\0global\0tag1\0tag2"),
@@ -3723,16 +3723,16 @@ static struct btf_raw_test raw_tests[] =3D {
 	.max_entries =3D 1,
 },
 {
-	.descr =3D "tag test #4, func/parameter, well-formed",
+	.descr =3D "decl_tag test #4, func/parameter, well-formed",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 		BTF_FUNC_ENC(NAME_TBD, 2),			/* [3] */
-		BTF_TAG_ENC(NAME_TBD, 3, -1),
-		BTF_TAG_ENC(NAME_TBD, 3, 0),
-		BTF_TAG_ENC(NAME_TBD, 3, 1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 3, -1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 3, 0),
+		BTF_DECL_TAG_ENC(NAME_TBD, 3, 1),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0arg1\0arg2\0f\0tag1\0tag2\0tag3"),
@@ -3745,11 +3745,11 @@ static struct btf_raw_test raw_tests[] =3D {
 	.max_entries =3D 1,
 },
 {
-	.descr =3D "tag test #5, invalid value",
+	.descr =3D "decl_tag test #5, invalid value",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
-		BTF_TAG_ENC(0, 2, -1),
+		BTF_DECL_TAG_ENC(0, 2, -1),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0local\0tag"),
@@ -3764,10 +3764,10 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid value",
 },
 {
-	.descr =3D "tag test #6, invalid target type",
+	.descr =3D "decl_tag test #6, invalid target type",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-		BTF_TAG_ENC(NAME_TBD, 1, -1),
+		BTF_DECL_TAG_ENC(NAME_TBD, 1, -1),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0tag1"),
@@ -3782,11 +3782,11 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid type",
 },
 {
-	.descr =3D "tag test #7, invalid vlen",
+	.descr =3D "decl_tag test #7, invalid vlen",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
-		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 0, 1), 2), (0),
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 1), 2), (0),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0local\0tag1"),
@@ -3801,11 +3801,11 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "vlen !=3D 0",
 },
 {
-	.descr =3D "tag test #8, invalid kflag",
+	.descr =3D "decl_tag test #8, invalid kflag",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
-		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 1, 0), 2), (-1),
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 1, 0), 2), (-1),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0local\0tag1"),
@@ -3820,11 +3820,11 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid btf_info kind_flag",
 },
 {
-	.descr =3D "tag test #9, var, invalid component_idx",
+	.descr =3D "decl_tag test #9, var, invalid component_idx",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
-		BTF_TAG_ENC(NAME_TBD, 2, 0),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, 0),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0local\0tag"),
@@ -3839,13 +3839,13 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid component_idx",
 },
 {
-	.descr =3D "tag test #10, struct member, invalid component_idx",
+	.descr =3D "decl_tag test #10, struct member, invalid component_idx",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_STRUCT_ENC(0, 2, 8),			/* [2] */
 		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
 		BTF_MEMBER_ENC(NAME_TBD, 1, 32),
-		BTF_TAG_ENC(NAME_TBD, 2, 2),
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, 2),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0m1\0m2\0tag"),
@@ -3860,14 +3860,14 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid component_idx",
 },
 {
-	.descr =3D "tag test #11, func parameter, invalid component_idx",
+	.descr =3D "decl_tag test #11, func parameter, invalid component_idx",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 		BTF_FUNC_ENC(NAME_TBD, 2),			/* [3] */
-		BTF_TAG_ENC(NAME_TBD, 3, 2),
+		BTF_DECL_TAG_ENC(NAME_TBD, 3, 2),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0arg1\0arg2\0f\0tag"),
@@ -3882,14 +3882,14 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid component_idx",
 },
 {
-	.descr =3D "tag test #12, < -1 component_idx",
+	.descr =3D "decl_tag test #12, < -1 component_idx",
 	.raw_types =3D {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 		BTF_FUNC_ENC(NAME_TBD, 2),			/* [3] */
-		BTF_TAG_ENC(NAME_TBD, 3, -2),
+		BTF_DECL_TAG_ENC(NAME_TBD, 3, -2),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0arg1\0arg2\0f\0tag"),
@@ -6672,9 +6672,9 @@ const struct btf_dedup_test dedup_tests[] =3D {
 			/* const -> [1] int */
 			BTF_CONST_ENC(1),						/* [6] */
 			/* tag -> [3] struct s */
-			BTF_TAG_ENC(NAME_NTH(2), 3, -1),				/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),				/* [7] */
 			/* tag -> [3] struct s, member 1 */
-			BTF_TAG_ENC(NAME_NTH(2), 3, 1),					/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, 1),				/* [8] */
=20
 			/* full copy of the above */
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),	/* [9] */
@@ -6689,8 +6689,8 @@ const struct btf_dedup_test dedup_tests[] =3D {
 			BTF_PTR_ENC(14),						/* [13] */
 			BTF_CONST_ENC(9),						/* [14] */
 			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [15] */
-			BTF_TAG_ENC(NAME_NTH(2), 11, -1),				/* [16] */
-			BTF_TAG_ENC(NAME_NTH(2), 11, 1),				/* [17] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 11, -1),				/* [16] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 11, 1),				/* [17] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0int\0s\0next\0a\0b\0c\0float\0d"),
@@ -6714,8 +6714,8 @@ const struct btf_dedup_test dedup_tests[] =3D {
 			BTF_PTR_ENC(6),							/* [5] */
 			/* const -> [1] int */
 			BTF_CONST_ENC(1),						/* [6] */
-			BTF_TAG_ENC(NAME_NTH(2), 3, -1),				/* [7] */
-			BTF_TAG_ENC(NAME_NTH(2), 3, 1),					/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),				/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, 1),				/* [8] */
 			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [9] */
 			BTF_END_RAW,
 		},
@@ -6841,8 +6841,8 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
 			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
-			BTF_TAG_ENC(NAME_TBD, 13, -1),					/* [15] tag */
-			BTF_TAG_ENC(NAME_TBD, 13, 1),					/* [16] tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] tag */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P"),
@@ -6869,8 +6869,8 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
 			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
-			BTF_TAG_ENC(NAME_TBD, 13, -1),					/* [15] tag */
-			BTF_TAG_ENC(NAME_TBD, 13, 1),					/* [16] tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] tag */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P"),
@@ -7036,14 +7036,14 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
 			BTF_FUNC_ENC(NAME_NTH(4), 2),			/* [4] */
 			/* tag -> t */
-			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
-			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [6] */
 			/* tag -> func */
-			BTF_TAG_ENC(NAME_NTH(5), 4, -1),		/* [7] */
-			BTF_TAG_ENC(NAME_NTH(5), 4, -1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),		/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),		/* [8] */
 			/* tag -> func arg a1 */
-			BTF_TAG_ENC(NAME_NTH(5), 4, 1),			/* [9] */
-			BTF_TAG_ENC(NAME_NTH(5), 4, 1),			/* [10] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),		/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),		/* [10] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
@@ -7056,9 +7056,9 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
 			BTF_FUNC_ENC(NAME_NTH(4), 2),			/* [4] */
-			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
-			BTF_TAG_ENC(NAME_NTH(5), 4, -1),		/* [6] */
-			BTF_TAG_ENC(NAME_NTH(5), 4, 1),			/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),		/* [7] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
@@ -7084,17 +7084,17 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
 			BTF_FUNC_ENC(NAME_NTH(3), 4),			/* [5] */
 			/* tag -> f: tag1, tag2 */
-			BTF_TAG_ENC(NAME_NTH(4), 3, -1),		/* [6] */
-			BTF_TAG_ENC(NAME_NTH(5), 3, -1),		/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 3, -1),		/* [7] */
 			/* tag -> f/a2: tag1, tag2 */
-			BTF_TAG_ENC(NAME_NTH(4), 3, 1),			/* [8] */
-			BTF_TAG_ENC(NAME_NTH(5), 3, 1),			/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, 1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 3, 1),		/* [9] */
 			/* tag -> f: tag1, tag3 */
-			BTF_TAG_ENC(NAME_NTH(4), 5, -1),		/* [10] */
-			BTF_TAG_ENC(NAME_NTH(6), 5, -1),		/* [11] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 5, -1),		/* [10] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 5, -1),		/* [11] */
 			/* tag -> f/a2: tag1, tag3 */
-			BTF_TAG_ENC(NAME_NTH(4), 5, 1),			/* [12] */
-			BTF_TAG_ENC(NAME_NTH(6), 5, 1),			/* [13] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 5, 1),		/* [12] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 5, 1),		/* [13] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
@@ -7106,12 +7106,12 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
 				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
 			BTF_FUNC_ENC(NAME_NTH(3), 2),			/* [3] */
-			BTF_TAG_ENC(NAME_NTH(4), 3, -1),		/* [4] */
-			BTF_TAG_ENC(NAME_NTH(5), 3, -1),		/* [5] */
-			BTF_TAG_ENC(NAME_NTH(6), 3, -1),		/* [6] */
-			BTF_TAG_ENC(NAME_NTH(4), 3, 1),			/* [7] */
-			BTF_TAG_ENC(NAME_NTH(5), 3, 1),			/* [8] */
-			BTF_TAG_ENC(NAME_NTH(6), 3, 1),			/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 3, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 3, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, 1),		/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 3, 1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 3, 1),		/* [9] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
@@ -7133,17 +7133,17 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
 				BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
 			/* tag -> t: tag1, tag2 */
-			BTF_TAG_ENC(NAME_NTH(4), 2, -1),		/* [4] */
-			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
 			/* tag -> t/m2: tag1, tag2 */
-			BTF_TAG_ENC(NAME_NTH(4), 2, 1),			/* [6] */
-			BTF_TAG_ENC(NAME_NTH(5), 2, 1),			/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, 1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, 1),		/* [7] */
 			/* tag -> t: tag1, tag3 */
-			BTF_TAG_ENC(NAME_NTH(4), 3, -1),		/* [8] */
-			BTF_TAG_ENC(NAME_NTH(6), 3, -1),		/* [9] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),		/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 3, -1),		/* [9] */
 			/* tag -> t/m2: tag1, tag3 */
-			BTF_TAG_ENC(NAME_NTH(4), 3, 1),			/* [10] */
-			BTF_TAG_ENC(NAME_NTH(6), 3, 1),			/* [11] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, 1),		/* [10] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 3, 1),		/* [11] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
@@ -7154,12 +7154,12 @@ const struct btf_dedup_test dedup_tests[] =3D {
 			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [2] */
 				BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
 				BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
-			BTF_TAG_ENC(NAME_NTH(4), 2, -1),		/* [3] */
-			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [4] */
-			BTF_TAG_ENC(NAME_NTH(6), 2, -1),		/* [5] */
-			BTF_TAG_ENC(NAME_NTH(4), 2, 1),			/* [6] */
-			BTF_TAG_ENC(NAME_NTH(5), 2, 1),			/* [7] */
-			BTF_TAG_ENC(NAME_NTH(6), 2, 1),			/* [8] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 2, -1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, 1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, 1),		/* [7] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 2, 1),		/* [8] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
@@ -7202,8 +7202,8 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + sizeof(struct btf_var);
 	case BTF_KIND_DATASEC:
 		return base_size + vlen * sizeof(struct btf_var_secinfo);
-	case BTF_KIND_TAG:
-		return base_size + sizeof(struct btf_tag);
+	case BTF_KIND_DECL_TAG:
+		return base_size + sizeof(struct btf_decl_tag);
 	default:
 		fprintf(stderr, "Unsupported BTF_KIND:%u\n", kind);
 		return -EINVAL;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/tes=
ting/selftests/bpf/prog_tests/btf_write.c
index 886e0fc1efb1..b912eeb0b6b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -277,26 +277,26 @@ static void gen_btf(struct btf *btf)
 		     "[17] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
 		     "\ttype_id=3D1 offset=3D4 size=3D8", "raw_dump");
=20
-	/* TAG */
-	id =3D btf__add_tag(btf, "tag1", 16, -1);
+	/* DECL_TAG */
+	id =3D btf__add_decl_tag(btf, "tag1", 16, -1);
 	ASSERT_EQ(id, 18, "tag_id");
 	t =3D btf__type_by_id(btf, 18);
 	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "tag1", "tag_value");
-	ASSERT_EQ(btf_kind(t), BTF_KIND_TAG, "tag_kind");
+	ASSERT_EQ(btf_kind(t), BTF_KIND_DECL_TAG, "tag_kind");
 	ASSERT_EQ(t->type, 16, "tag_type");
-	ASSERT_EQ(btf_tag(t)->component_idx, -1, "tag_component_idx");
+	ASSERT_EQ(btf_decl_tag(t)->component_idx, -1, "tag_component_idx");
 	ASSERT_STREQ(btf_type_raw_dump(btf, 18),
-		     "[18] TAG 'tag1' type_id=3D16 component_idx=3D-1", "raw_dump");
+		     "[18] DECL_TAG 'tag1' type_id=3D16 component_idx=3D-1", "raw_dump");
=20
-	id =3D btf__add_tag(btf, "tag2", 14, 1);
+	id =3D btf__add_decl_tag(btf, "tag2", 14, 1);
 	ASSERT_EQ(id, 19, "tag_id");
 	t =3D btf__type_by_id(btf, 19);
 	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "tag2", "tag_value");
-	ASSERT_EQ(btf_kind(t), BTF_KIND_TAG, "tag_kind");
+	ASSERT_EQ(btf_kind(t), BTF_KIND_DECL_TAG, "tag_kind");
 	ASSERT_EQ(t->type, 14, "tag_type");
-	ASSERT_EQ(btf_tag(t)->component_idx, 1, "tag_component_idx");
+	ASSERT_EQ(btf_decl_tag(t)->component_idx, 1, "tag_component_idx");
 	ASSERT_STREQ(btf_type_raw_dump(btf, 19),
-		     "[19] TAG 'tag2' type_id=3D14 component_idx=3D1", "raw_dump");
+		     "[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1", "raw_dump");
 }
=20
 static void test_btf_add()
@@ -336,8 +336,8 @@ static void test_btf_add()
 		"[16] VAR 'var1' type_id=3D1, linkage=3Dglobal-alloc",
 		"[17] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
 		"\ttype_id=3D1 offset=3D4 size=3D8",
-		"[18] TAG 'tag1' type_id=3D16 component_idx=3D-1",
-		"[19] TAG 'tag2' type_id=3D14 component_idx=3D1");
+		"[18] DECL_TAG 'tag1' type_id=3D16 component_idx=3D-1",
+		"[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1");
=20
 	btf__free(btf);
 }
@@ -389,8 +389,8 @@ static void test_btf_add_btf()
 		"[16] VAR 'var1' type_id=3D1, linkage=3Dglobal-alloc",
 		"[17] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
 		"\ttype_id=3D1 offset=3D4 size=3D8",
-		"[18] TAG 'tag1' type_id=3D16 component_idx=3D-1",
-		"[19] TAG 'tag2' type_id=3D14 component_idx=3D1",
+		"[18] DECL_TAG 'tag1' type_id=3D16 component_idx=3D-1",
+		"[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1",
=20
 		/* types appended from the second BTF */
 		"[20] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED",
@@ -418,8 +418,8 @@ static void test_btf_add_btf()
 		"[35] VAR 'var1' type_id=3D20, linkage=3Dglobal-alloc",
 		"[36] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
 		"\ttype_id=3D20 offset=3D4 size=3D8",
-		"[37] TAG 'tag1' type_id=3D35 component_idx=3D-1",
-		"[38] TAG 'tag2' type_id=3D33 component_idx=3D1");
+		"[37] DECL_TAG 'tag1' type_id=3D35 component_idx=3D-1",
+		"[38] DECL_TAG 'tag2' type_id=3D33 component_idx=3D1");
=20
 cleanup:
 	btf__free(btf1);
diff --git a/tools/testing/selftests/bpf/progs/tag.c b/tools/testing/selfte=
sts/bpf/progs/tag.c
index b46b1bfac7da..672d19e7b120 100644
--- a/tools/testing/selftests/bpf/progs/tag.c
+++ b/tools/testing/selftests/bpf/progs/tag.c
@@ -8,9 +8,9 @@
 #define __has_attribute(x) 0
 #endif
=20
-#if __has_attribute(btf_tag)
-#define __tag1 __attribute__((btf_tag("tag1")))
-#define __tag2 __attribute__((btf_tag("tag2")))
+#if __has_attribute(btf_decl_tag)
+#define __tag1 __attribute__((btf_decl_tag("tag1")))
+#define __tag2 __attribute__((btf_decl_tag("tag2")))
 volatile const bool skip_tests __tag1 __tag2 =3D false;
 #else
 #define __tag1
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftes=
ts/bpf/test_btf.h
index 0619e06d745e..32c7a57867da 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -69,7 +69,7 @@
 #define BTF_TYPE_FLOAT_ENC(name, sz) \
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
=20
-#define BTF_TAG_ENC(value, type, component_idx)	\
-	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (component_i=
dx)
+#define BTF_DECL_TAG_ENC(value, type, component_idx)	\
+	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), type), (compon=
ent_idx)
=20
 #endif /* _TEST_BTF_H */
--=20
2.30.2

