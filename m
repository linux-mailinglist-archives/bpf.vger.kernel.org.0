Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3451673C
	for <lists+bpf@lfdr.de>; Sun,  1 May 2022 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351367AbiEATDq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 May 2022 15:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245551AbiEATDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 May 2022 15:03:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA06429
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 12:00:16 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241AIu98006959
        for <bpf@vger.kernel.org>; Sun, 1 May 2022 12:00:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ngimd3+nOkLijNfAkQmK/9zbIDlqYS+fkfoy9u/Lnq0=;
 b=dbA8awtlIRLYLz6V6h+8OqZxTm7hnR8AC1WzNMmT8xITSq45vmIXBv71XHRZXT5EvNHy
 ckTSIgaJpfszpl+dAgrP8U9FZmhFwEoQwBbAoiU0inotA4PMTTkobojybZob9uXWQBPk
 T10yFzGtVLDcNL4GCS+EXBh/ibJTV+junP8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs27rdset-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 12:00:16 -0700
Received: from twshared8053.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 1 May 2022 12:00:14 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5C4269C01EEA; Sun,  1 May 2022 12:00:07 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 01/12] bpf: Add btf enum64 support
Date:   Sun, 1 May 2022 12:00:07 -0700
Message-ID: <20220501190007.2576808-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220501190002.2576452-1-yhs@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6hqBqXpgQfZC6xo7jEdE5mw8sWxexemY
X-Proofpoint-ORIG-GUID: 6hqBqXpgQfZC6xo7jEdE5mw8sWxexemY
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-01_07,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, BTF only supports upto 32bit enum value with BTF_KIND_ENUM.
But in kernel, some enum indeed has 64bit values, e.g.,
in uapi bpf.h, we have
  enum {
        BPF_F_INDEX_MASK                =3D 0xffffffffULL,
        BPF_F_CURRENT_CPU               =3D BPF_F_INDEX_MASK,
        BPF_F_CTXLEN_MASK               =3D (0xfffffULL << 32),
  };
In this case, BTF_KIND_ENUM will encode the value of BPF_F_CTXLEN_MASK
as 0, which certainly is incorrect.

This patch added a new btf kind, BTF_KIND_ENUM64, which permits
64bit value to cover the above use case. The BTF_KIND_ENUM64 has
the following three bytes followed by the common type:
  struct bpf_enum64 {
    __u32 nume_off;
    __u32 hi32;
    __u32 lo32;
  };
Currently, btf type section has an alignment of 4 as all element types
are u32. Representing the value with __u64 will introduce a pad
for bpf_enum64 and may also introduce misalignment for the 64bit value.
Hence, two members of hi32 and lo32 are chosen to avoid these issues.

The kflag is also introduced for BTF_KIND_ENUM and BTF_KIND_ENUM64
to indicate whether the value is signed or unsigned. The kflag intends
to provide consistent output of BTF C fortmat with the original
source code. For example, the original BTF_KIND_ENUM bit value is 0xfffffff=
f.
The format C has two choices, print out 0xffffffff or -1 and current libbpf
prints out as unsigned value. But if the signedness is preserved in btf,
the value can be printed the same as the original source code.

The new BTF_KIND_ENUM64 is intended to support the enum value represented as
64bit value. But it can represent all BTF_KIND_ENUM values as well.
The value size of BTF_KIND_ENUM64 is encoded to 8 to represent its intent.
The compiler ([1]) and pahole will generate BTF_KIND_ENUM64 only if the val=
ue has
to be represented with 64 bits.

  [1] https://reviews.llvm.org/D124641

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/btf.h            |  18 ++++-
 include/uapi/linux/btf.h       |  17 ++++-
 kernel/bpf/btf.c               | 132 ++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/btf.h |  17 ++++-
 4 files changed, 168 insertions(+), 16 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2611cea2c2b6..280c33c9414a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -174,7 +174,8 @@ static inline bool btf_type_is_small_int(const struct b=
tf_type *t)
=20
 static inline bool btf_type_is_enum(const struct btf_type *t)
 {
-	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_ENUM;
+	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_ENUM ||
+	       BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_ENUM64;
 }
=20
 static inline bool str_is_empty(const char *s)
@@ -192,6 +193,16 @@ static inline bool btf_is_enum(const struct btf_type *=
t)
 	return btf_kind(t) =3D=3D BTF_KIND_ENUM;
 }
=20
+static inline bool btf_is_enum64(const struct btf_type *t)
+{
+	return btf_kind(t) =3D=3D BTF_KIND_ENUM64;
+}
+
+static inline u64 btf_enum64_value(const struct btf_enum64 *e)
+{
+	return (u64)e->hi32 << 32 | e->lo32;
+}
+
 static inline bool btf_is_composite(const struct btf_type *t)
 {
 	u16 kind =3D btf_kind(t);
@@ -332,6 +343,11 @@ static inline struct btf_enum *btf_enum(const struct b=
tf_type *t)
 	return (struct btf_enum *)(t + 1);
 }
=20
+static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
+{
+	return (struct btf_enum64 *)(t + 1);
+}
+
 static inline const struct btf_var_secinfo *btf_type_var_secinfo(
 		const struct btf_type *t)
 {
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index a9162a6c0284..2aac226a27b2 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -36,10 +36,10 @@ struct btf_type {
 	 * bits 24-28: kind (e.g. int, ptr, array...etc)
 	 * bits 29-30: unused
 	 * bit     31: kind_flag, currently used by
-	 *             struct, union and fwd
+	 *             struct, union, enum, fwd and enum64
 	 */
 	__u32 info;
-	/* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
+	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
@@ -63,7 +63,7 @@ enum {
 	BTF_KIND_ARRAY		=3D 3,	/* Array	*/
 	BTF_KIND_STRUCT		=3D 4,	/* Struct	*/
 	BTF_KIND_UNION		=3D 5,	/* Union	*/
-	BTF_KIND_ENUM		=3D 6,	/* Enumeration	*/
+	BTF_KIND_ENUM		=3D 6,	/* Enumeration for int/unsigned int values */
 	BTF_KIND_FWD		=3D 7,	/* Forward	*/
 	BTF_KIND_TYPEDEF	=3D 8,	/* Typedef	*/
 	BTF_KIND_VOLATILE	=3D 9,	/* Volatile	*/
@@ -76,6 +76,7 @@ enum {
 	BTF_KIND_FLOAT		=3D 16,	/* Floating point	*/
 	BTF_KIND_DECL_TAG	=3D 17,	/* Decl Tag */
 	BTF_KIND_TYPE_TAG	=3D 18,	/* Type Tag */
+	BTF_KIND_ENUM64		=3D 19,	/* Enumeration for long/unsigned long values */
=20
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		=3D NR_BTF_KINDS - 1,
@@ -186,4 +187,14 @@ struct btf_decl_tag {
        __s32   component_idx;
 };
=20
+/* BTF_KIND_ENUM64 is followed by multiple "struct btf_enum64".
+ * The exact number of btf_enum64 is stored in the vlen (of the
+ * info in "struct btf_type").
+ */
+struct btf_enum64 {
+	__u32	name_off;
+	__u32	hi32;
+	__u32	lo32;
+};
+
 #endif /* _UAPI__LINUX_BTF_H__ */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2f0b0440131c..17e24b362d3d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -307,6 +307,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
 	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	=3D "TYPE_TAG",
+	[BTF_KIND_ENUM64]	=3D "ENUM64",
 };
=20
 const char *btf_type_str(const struct btf_type *t)
@@ -664,6 +665,7 @@ static bool btf_type_has_size(const struct btf_type *t)
 	case BTF_KIND_ENUM:
 	case BTF_KIND_DATASEC:
 	case BTF_KIND_FLOAT:
+	case BTF_KIND_ENUM64:
 		return true;
 	}
=20
@@ -709,6 +711,11 @@ static const struct btf_decl_tag *btf_type_decl_tag(co=
nst struct btf_type *t)
 	return (const struct btf_decl_tag *)(t + 1);
 }
=20
+static const struct btf_enum64 *btf_type_enum64(const struct btf_type *t)
+{
+	return (const struct btf_enum64 *)(t + 1);
+}
+
 static const struct btf_kind_operations *btf_type_ops(const struct btf_typ=
e *t)
 {
 	return kind_ops[BTF_INFO_KIND(t->info)];
@@ -1017,6 +1024,7 @@ static const char *btf_show_name(struct btf_show *sho=
w)
 			parens =3D "{";
 		break;
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		prefix =3D "enum";
 		break;
 	default:
@@ -1832,6 +1840,7 @@ __btf_resolve_size(const struct btf *btf, const struc=
t btf_type *type,
 		case BTF_KIND_UNION:
 		case BTF_KIND_ENUM:
 		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM64:
 			size =3D type->size;
 			goto resolved;
=20
@@ -3668,6 +3677,7 @@ static s32 btf_enum_check_meta(struct btf_verifier_en=
v *env,
 {
 	const struct btf_enum *enums =3D btf_type_enum(t);
 	struct btf *btf =3D env->btf;
+	const char *fmt_str;
 	u16 i, nr_enums;
 	u32 meta_needed;
=20
@@ -3681,11 +3691,6 @@ static s32 btf_enum_check_meta(struct btf_verifier_e=
nv *env,
 		return -EINVAL;
 	}
=20
-	if (btf_type_kflag(t)) {
-		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
-		return -EINVAL;
-	}
-
 	if (t->size > 8 || !is_power_of_2(t->size)) {
 		btf_verifier_log_type(env, t, "Unexpected size");
 		return -EINVAL;
@@ -3716,7 +3721,8 @@ static s32 btf_enum_check_meta(struct btf_verifier_en=
v *env,
=20
 		if (env->log.level =3D=3D BPF_LOG_KERNEL)
 			continue;
-		btf_verifier_log(env, "\t%s val=3D%d\n",
+		fmt_str =3D btf_type_kflag(t) ? "\t%s val=3D%u\n" : "\t%s val=3D%d\n";
+		btf_verifier_log(env, fmt_str,
 				 __btf_name_by_offset(btf, enums[i].name_off),
 				 enums[i].val);
 	}
@@ -3757,7 +3763,10 @@ static void btf_enum_show(const struct btf *btf, con=
st struct btf_type *t,
 		return;
 	}
=20
-	btf_show_type_value(show, "%d", v);
+	if (btf_type_kflag(t))
+		btf_show_type_value(show, "%u", v);
+	else
+		btf_show_type_value(show, "%d", v);
 	btf_show_end_type(show);
 }
=20
@@ -3770,6 +3779,109 @@ static struct btf_kind_operations enum_ops =3D {
 	.show =3D btf_enum_show,
 };
=20
+static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
+				 const struct btf_type *t,
+				 u32 meta_left)
+{
+	const struct btf_enum64 *enums =3D btf_type_enum64(t);
+	struct btf *btf =3D env->btf;
+	const char *fmt_str;
+	u16 i, nr_enums;
+	u32 meta_needed;
+
+	nr_enums =3D btf_type_vlen(t);
+	meta_needed =3D nr_enums * sizeof(*enums);
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				       meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (t->size !=3D 8) {
+		btf_verifier_log_type(env, t, "Unexpected size");
+		return -EINVAL;
+	}
+
+	/* enum type either no name or a valid one */
+	if (t->name_off &&
+	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+
+	btf_verifier_log_type(env, t, NULL);
+
+	for (i =3D 0; i < nr_enums; i++) {
+		if (!btf_name_offset_valid(btf, enums[i].name_off)) {
+			btf_verifier_log(env, "\tInvalid name_offset:%u",
+					 enums[i].name_off);
+			return -EINVAL;
+		}
+
+		/* enum member must have a valid name */
+		if (!enums[i].name_off ||
+		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
+			btf_verifier_log_type(env, t, "Invalid name");
+			return -EINVAL;
+		}
+
+		if (env->log.level =3D=3D BPF_LOG_KERNEL)
+			continue;
+
+		fmt_str =3D btf_type_kflag(t) ? "\t%s val=3D%llu\n" : "\t%s val=3D%lld\n=
";
+		btf_verifier_log(env, fmt_str,
+				 __btf_name_by_offset(btf, enums[i].name_off),
+				 btf_enum64_value(enums + i));
+	}
+
+	return meta_needed;
+}
+
+static void btf_enum64_show(const struct btf *btf, const struct btf_type *=
t,
+			    u32 type_id, void *data, u8 bits_offset,
+			    struct btf_show *show)
+{
+	const struct btf_enum64 *enums =3D btf_type_enum64(t);
+	u32 i, nr_enums =3D btf_type_vlen(t);
+	void *safe_data;
+	s64 v;
+
+	safe_data =3D btf_show_start_type(show, t, type_id, data);
+	if (!safe_data)
+		return;
+
+	v =3D *(u64 *)safe_data;
+
+	for (i =3D 0; i < nr_enums; i++) {
+		if (v !=3D btf_enum64_value(enums + i))
+			continue;
+
+		btf_show_type_value(show, "%s",
+				    __btf_name_by_offset(btf,
+							 enums[i].name_off));
+
+		btf_show_end_type(show);
+		return;
+	}
+
+	if (btf_type_kflag(t))
+		btf_show_type_value(show, "%llu", v);
+	else
+		btf_show_type_value(show, "%lld", v);
+	btf_show_end_type(show);
+}
+
+static struct btf_kind_operations enum64_ops =3D {
+	.check_meta =3D btf_enum64_check_meta,
+	.resolve =3D btf_df_resolve,
+	.check_member =3D btf_enum_check_member,
+	.check_kflag_member =3D btf_enum_check_kflag_member,
+	.log_details =3D btf_enum_log,
+	.show =3D btf_enum64_show,
+};
+
 static s32 btf_func_proto_check_meta(struct btf_verifier_env *env,
 				     const struct btf_type *t,
 				     u32 meta_left)
@@ -4436,6 +4548,7 @@ static const struct btf_kind_operations * const kind_=
ops[NR_BTF_KINDS] =3D {
 	[BTF_KIND_FLOAT] =3D &float_ops,
 	[BTF_KIND_DECL_TAG] =3D &decl_tag_ops,
 	[BTF_KIND_TYPE_TAG] =3D &modifier_ops,
+	[BTF_KIND_ENUM64] =3D &enum64_ops,
 };
=20
 static s32 btf_check_meta(struct btf_verifier_env *env,
@@ -7329,6 +7442,7 @@ int __bpf_core_types_are_compat(const struct btf *loc=
al_btf, __u32 local_id,
 	case BTF_KIND_UNION:
 	case BTF_KIND_ENUM:
 	case BTF_KIND_FWD:
+	case BTF_KIND_ENUM64:
 		return 1;
 	case BTF_KIND_INT:
 		/* just reject deprecated bitfield-like integers; all other
@@ -7381,10 +7495,10 @@ int __bpf_core_types_are_compat(const struct btf *l=
ocal_btf, __u32 local_id,
  * field-based relocations. This function assumes that root types were alr=
eady
  * checked for name match. Beyond that initial root-level name check, names
  * are completely ignored. Compatibility rules are as follows:
- *   - any two STRUCTs/UNIONs/FWDs/ENUMs/INTs are considered compatible, b=
ut
+ *   - any two STRUCTs/UNIONs/FWDs/ENUMs/INTs/ENUM64s are considered compa=
tible, but
  *     kind should match for local and target types (i.e., STRUCT is not
  *     compatible with UNION);
- *   - for ENUMs, the size is ignored;
+ *   - for ENUMs/ENUM64s, the size is ignored;
  *   - for INT, size and signedness are ignored;
  *   - for ARRAY, dimensionality is ignored, element types are checked for
  *     compatibility recursively;
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index a9162a6c0284..2aac226a27b2 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -36,10 +36,10 @@ struct btf_type {
 	 * bits 24-28: kind (e.g. int, ptr, array...etc)
 	 * bits 29-30: unused
 	 * bit     31: kind_flag, currently used by
-	 *             struct, union and fwd
+	 *             struct, union, enum, fwd and enum64
 	 */
 	__u32 info;
-	/* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
+	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
@@ -63,7 +63,7 @@ enum {
 	BTF_KIND_ARRAY		=3D 3,	/* Array	*/
 	BTF_KIND_STRUCT		=3D 4,	/* Struct	*/
 	BTF_KIND_UNION		=3D 5,	/* Union	*/
-	BTF_KIND_ENUM		=3D 6,	/* Enumeration	*/
+	BTF_KIND_ENUM		=3D 6,	/* Enumeration for int/unsigned int values */
 	BTF_KIND_FWD		=3D 7,	/* Forward	*/
 	BTF_KIND_TYPEDEF	=3D 8,	/* Typedef	*/
 	BTF_KIND_VOLATILE	=3D 9,	/* Volatile	*/
@@ -76,6 +76,7 @@ enum {
 	BTF_KIND_FLOAT		=3D 16,	/* Floating point	*/
 	BTF_KIND_DECL_TAG	=3D 17,	/* Decl Tag */
 	BTF_KIND_TYPE_TAG	=3D 18,	/* Type Tag */
+	BTF_KIND_ENUM64		=3D 19,	/* Enumeration for long/unsigned long values */
=20
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		=3D NR_BTF_KINDS - 1,
@@ -186,4 +187,14 @@ struct btf_decl_tag {
        __s32   component_idx;
 };
=20
+/* BTF_KIND_ENUM64 is followed by multiple "struct btf_enum64".
+ * The exact number of btf_enum64 is stored in the vlen (of the
+ * info in "struct btf_type").
+ */
+struct btf_enum64 {
+	__u32	name_off;
+	__u32	hi32;
+	__u32	lo32;
+};
+
 #endif /* _UAPI__LINUX_BTF_H__ */
--=20
2.30.2

