Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04953516740
	for <lists+bpf@lfdr.de>; Sun,  1 May 2022 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245551AbiEATEG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 May 2022 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355274AbiEATEE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 May 2022 15:04:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9FB19004
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 12:00:36 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241CZ4oJ028932
        for <bpf@vger.kernel.org>; Sun, 1 May 2022 12:00:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tdioFrHv1qIvEuJgzR6wQTzujFluX1ut82/FfXaUs/o=;
 b=fTuzAPJTtkXXPzW3YVlYz2Skz3O15cJFLy5VvnzRaHKHeqEcELaw+7IYMRNoEvBcSAe8
 zCAX2VvC/QGSVrFC6z7lP6c68wsuhnMHAqNQDP0v3cdRap/CjjMKhKnheR8IG2lie7n/
 ZUASgZHzAEPV4Dg4v5Qocyyp+rDI28I/Xt4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs4e2dbn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 12:00:36 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 1 May 2022 12:00:35 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3FF469C01F59; Sun,  1 May 2022 12:00:23 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
Date:   Sun, 1 May 2022 12:00:23 -0700
Message-ID: <20220501190023.2578209-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220501190002.2576452-1-yhs@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7yNaZztBpd8aPRSjPrUY5GLJwLc8EB-E
X-Proofpoint-GUID: 7yNaZztBpd8aPRSjPrUY5GLJwLc8EB-E
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

Add BTF_KIND_ENUM64 support. Deprecated btf__add_enum() and
btf__add_enum_value() and introduced the following new APIs
  btf__add_enum32()
  btf__add_enum32_value()
  btf__add_enum64()
  btf__add_enum64_value()
due to new kind and introduction of kflag.

To support old kernel with enum64, the sanitization is
added to replace BTF_KIND_ENUM64 with a bunch of
pointer-to-void types.

The enum64 value relocation is also supported. The enum64
forward resolution, with enum type as forward declaration
and enum64 as the actual definition, is also supported.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
 tools/lib/bpf/btf.h                           |  21 ++
 tools/lib/bpf/btf_dump.c                      |  94 ++++++--
 tools/lib/bpf/libbpf.c                        |  64 ++++-
 tools/lib/bpf/libbpf.map                      |   4 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/lib/bpf/linker.c                        |   2 +
 tools/lib/bpf/relo_core.c                     |  93 ++++---
 .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
 .../selftests/bpf/prog_tests/btf_write.c      |   6 +-
 10 files changed, 450 insertions(+), 72 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index bb1e06eb1eca..77fe14e99eeb 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -318,6 +318,8 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + vlen * sizeof(struct btf_var_secinfo);
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
+	case BTF_KIND_ENUM64:
+		return base_size + vlen * sizeof(struct btf_enum64);
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
 		return -EINVAL;
@@ -334,6 +336,7 @@ static void btf_bswap_type_base(struct btf_type *t)
 static int btf_bswap_type_rest(struct btf_type *t)
 {
 	struct btf_var_secinfo *v;
+	struct btf_enum64 *e64;
 	struct btf_member *m;
 	struct btf_array *a;
 	struct btf_param *p;
@@ -394,6 +397,13 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		btf_decl_tag(t)->component_idx =3D bswap_32(btf_decl_tag(t)->component=
_idx);
 		return 0;
+	case BTF_KIND_ENUM64:
+		for (i =3D 0, e64 =3D btf_enum64(t); i < vlen; i++, e64++) {
+			e64->name_off =3D bswap_32(e64->name_off);
+			e64->hi32 =3D bswap_32(e64->hi32);
+			e64->lo32 =3D bswap_32(e64->lo32);
+		}
+		return 0;
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
 		return -EINVAL;
@@ -599,6 +609,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 =
type_id)
 		case BTF_KIND_ENUM:
 		case BTF_KIND_DATASEC:
 		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM64:
 			size =3D t->size;
 			goto done;
 		case BTF_KIND_PTR:
@@ -645,6 +656,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
 	case BTF_KIND_FLOAT:
+	case BTF_KIND_ENUM64:
 		return min(btf_ptr_sz(btf), (size_t)t->size);
 	case BTF_KIND_PTR:
 		return btf_ptr_sz(btf);
@@ -2211,6 +2223,171 @@ int btf__add_enum_value(struct btf *btf, const ch=
ar *name, __s64 value)
 	return 0;
 }
=20
+static int btf_add_enum_common(struct btf *btf, const char *name,
+			       bool is_unsigned, __u8 kind, __u32 tsize)
+{
+	struct btf_type *t;
+	int sz, name_off =3D 0;
+
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	sz =3D sizeof(struct btf_type);
+	t =3D btf_add_type_mem(btf, sz);
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	if (name && name[0]) {
+		name_off =3D btf__add_str(btf, name);
+		if (name_off < 0)
+			return name_off;
+	}
+
+	/* start out with vlen=3D0; it will be adjusted when adding enum values=
 */
+	t->name_off =3D name_off;
+	t->info =3D btf_type_info(kind, 0, is_unsigned);
+	t->size =3D tsize;
+
+	return btf_commit_type(btf, sz);
+}
+
+/*
+ * Append new BTF_KIND_ENUM type with:
+ *   - *name* - name of the enum, can be NULL or empty for anonymous enu=
ms;
+ *   - *is_unsigned* - whether the enum values are unsigned or not;
+ *
+ * Enum initially has no enum values in it (and corresponds to enum forw=
ard
+ * declaration). Enumerator values can be added by btf__add_enum64_value=
()
+ * immediately after btf__add_enum() succeeds.
+ *
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_enum32(struct btf *btf, const char *name, bool is_unsigned)
+{
+	return btf_add_enum_common(btf, name, is_unsigned, BTF_KIND_ENUM, 4);
+}
+
+/*
+ * Append new enum value for the current ENUM type with:
+ *   - *name* - name of the enumerator value, can't be NULL or empty;
+ *   - *value* - integer value corresponding to enum value *name*;
+ * Returns:
+ *   -  0, on success;
+ *   - <0, on error.
+ */
+int btf__add_enum32_value(struct btf *btf, const char *name, __s32 value=
)
+{
+	struct btf_enum *v;
+	struct btf_type *t;
+	int sz, name_off;
+
+	/* last type should be BTF_KIND_ENUM */
+	if (btf->nr_types =3D=3D 0)
+		return libbpf_err(-EINVAL);
+	t =3D btf_last_type(btf);
+	if (!btf_is_enum(t))
+		return libbpf_err(-EINVAL);
+
+	/* non-empty name */
+	if (!name || !name[0])
+		return libbpf_err(-EINVAL);
+
+	/* decompose and invalidate raw data */
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	sz =3D sizeof(struct btf_enum);
+	v =3D btf_add_type_mem(btf, sz);
+	if (!v)
+		return libbpf_err(-ENOMEM);
+
+	name_off =3D btf__add_str(btf, name);
+	if (name_off < 0)
+		return name_off;
+
+	v->name_off =3D name_off;
+	v->val =3D value;
+
+	/* update parent type's vlen */
+	t =3D btf_last_type(btf);
+	btf_type_inc_vlen(t);
+
+	btf->hdr->type_len +=3D sz;
+	btf->hdr->str_off +=3D sz;
+	return 0;
+}
+
+/*
+ * Append new BTF_KIND_ENUM64 type with:
+ *   - *name* - name of the enum, can be NULL or empty for anonymous enu=
ms;
+ *   - *is_unsigned* - whether the enum values are unsigned or not;
+ *
+ * Enum64 initially has no enum values in it (and corresponds to enum fo=
rward
+ * declaration). Enumerator values can be added by btf__add_enum64_value=
()
+ * immediately after btf__add_enum64() succeeds.
+ *
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_enum64(struct btf *btf, const char *name, bool is_unsigned)
+{
+	return btf_add_enum_common(btf, name, is_unsigned, BTF_KIND_ENUM64, 8);
+}
+
+/*
+ * Append new enum value for the current ENUM64 type with:
+ *   - *name* - name of the enumerator value, can't be NULL or empty;
+ *   - *value* - integer value corresponding to enum value *name*;
+ * Returns:
+ *   -  0, on success;
+ *   - <0, on error.
+ */
+int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value=
)
+{
+	struct btf_enum64 *v;
+	struct btf_type *t;
+	int sz, name_off;
+
+	/* last type should be BTF_KIND_ENUM64 */
+	if (btf->nr_types =3D=3D 0)
+		return libbpf_err(-EINVAL);
+	t =3D btf_last_type(btf);
+	if (!btf_is_enum64(t))
+		return libbpf_err(-EINVAL);
+
+	/* non-empty name */
+	if (!name || !name[0])
+		return libbpf_err(-EINVAL);
+
+	/* decompose and invalidate raw data */
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	sz =3D sizeof(struct btf_enum64);
+	v =3D btf_add_type_mem(btf, sz);
+	if (!v)
+		return libbpf_err(-ENOMEM);
+
+	name_off =3D btf__add_str(btf, name);
+	if (name_off < 0)
+		return name_off;
+
+	v->name_off =3D name_off;
+	v->hi32 =3D value >> 32;
+	v->lo32 =3D (__u32)value;
+
+	/* update parent type's vlen */
+	t =3D btf_last_type(btf);
+	btf_type_inc_vlen(t);
+
+	btf->hdr->type_len +=3D sz;
+	btf->hdr->str_off +=3D sz;
+	return 0;
+}
+
 /*
  * Append new BTF_KIND_FWD type with:
  *   - *name*, non-empty/non-NULL name;
@@ -2242,7 +2419,7 @@ int btf__add_fwd(struct btf *btf, const char *name,=
 enum btf_fwd_kind fwd_kind)
 		/* enum forward in BTF currently is just an enum with no enum
 		 * values; we also assume a standard 4-byte size for it
 		 */
-		return btf__add_enum(btf, name, sizeof(int));
+		return btf__add_enum32(btf, name, false);
 	default:
 		return libbpf_err(-EINVAL);
 	}
@@ -3485,6 +3662,7 @@ static long btf_hash_enum(struct btf_type *t)
 /* Check structural equality of two ENUMs. */
 static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
 {
+	const struct btf_enum64 *n1, *n2;
 	const struct btf_enum *m1, *m2;
 	__u16 vlen;
 	int i;
@@ -3493,26 +3671,40 @@ static bool btf_equal_enum(struct btf_type *t1, s=
truct btf_type *t2)
 		return false;
=20
 	vlen =3D btf_vlen(t1);
-	m1 =3D btf_enum(t1);
-	m2 =3D btf_enum(t2);
-	for (i =3D 0; i < vlen; i++) {
-		if (m1->name_off !=3D m2->name_off || m1->val !=3D m2->val)
-			return false;
-		m1++;
-		m2++;
+	if (btf_is_enum(t1)) {
+		m1 =3D btf_enum(t1);
+		m2 =3D btf_enum(t2);
+		for (i =3D 0; i < vlen; i++) {
+			if (m1->name_off !=3D m2->name_off || m1->val !=3D m2->val)
+				return false;
+			m1++;
+			m2++;
+		}
+	} else {
+		n1 =3D btf_enum64(t1);
+		n2 =3D btf_enum64(t2);
+		for (i =3D 0; i < vlen; i++) {
+			if (n1->name_off !=3D n2->name_off || n1->hi32 !=3D n2->hi32 ||
+			    n1->lo32 !=3D n2->lo32)
+				return false;
+			n1++;
+			n2++;
+		}
 	}
 	return true;
 }
=20
 static inline bool btf_is_enum_fwd(struct btf_type *t)
 {
-	return btf_is_enum(t) && btf_vlen(t) =3D=3D 0;
+	return (btf_is_enum(t) || btf_is_enum64(t)) && btf_vlen(t) =3D=3D 0;
 }
=20
 static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
 {
-	if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2))
+	if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2)) {
 		return btf_equal_enum(t1, t2);
+	}
+
 	/* ignore vlen when comparing */
 	return t1->name_off =3D=3D t2->name_off &&
 	       (t1->info & ~0xffff) =3D=3D (t2->info & ~0xffff) &&
@@ -3731,6 +3923,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 			h =3D btf_hash_int_decl_tag(t);
 			break;
 		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
 			h =3D btf_hash_enum(t);
 			break;
 		case BTF_KIND_STRUCT:
@@ -3800,6 +3993,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d,=
 __u32 type_id)
 		break;
=20
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		h =3D btf_hash_enum(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id =3D (__u32)(long)hash_entry->value;
@@ -4113,6 +4307,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, =
__u32 cand_id,
 		return btf_equal_int_tag(cand_type, canon_type);
=20
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		return btf_compat_enum(cand_type, canon_type);
=20
 	case BTF_KIND_FWD:
@@ -4717,6 +4912,7 @@ int btf_type_visit_type_ids(struct btf_type *t, typ=
e_id_visit_fn visit, void *ct
 	case BTF_KIND_INT:
 	case BTF_KIND_FLOAT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		return 0;
=20
 	case BTF_KIND_FWD:
@@ -4811,6 +5007,16 @@ int btf_type_visit_str_offs(struct btf_type *t, st=
r_off_visit_fn visit, void *ct
 		}
 		break;
 	}
+	case BTF_KIND_ENUM64: {
+		struct btf_enum64 *m =3D btf_enum64(t);
+
+		for (i =3D 0, n =3D btf_vlen(t); i < n; i++, m++) {
+			err =3D visit(&m->name_off, ctx);
+			if (err)
+				return err;
+		}
+		break;
+	}
 	case BTF_KIND_FUNC_PROTO: {
 		struct btf_param *m =3D btf_params(t);
=20
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 951ac7475794..90f35bc00038 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -213,8 +213,14 @@ LIBBPF_API int btf__add_field(struct btf *btf, const=
 char *name, int field_type_
 			      __u32 bit_offset, __u32 bit_size);
=20
 /* enum construction APIs */
+LIBBPF_DEPRECATED_SINCE(0, 8, "btf__add_enum is deprecated; use btf__add=
_enum32 or btf__add_enum64")
 LIBBPF_API int btf__add_enum(struct btf *btf, const char *name, __u32 by=
tes_sz);
+LIBBPF_DEPRECATED_SINCE(0, 8, "btf__add_enum_value is deprecated; use bt=
f_add_enum32_value or btf_add_enum64_value")
 LIBBPF_API int btf__add_enum_value(struct btf *btf, const char *name, __=
s64 value);
+LIBBPF_API int btf__add_enum32(struct btf *btf, const char *name, bool i=
s_unsigned);
+LIBBPF_API int btf__add_enum32_value(struct btf *btf, const char *name, =
__s32 value);
+LIBBPF_API int btf__add_enum64(struct btf *btf, const char *name, bool i=
s_unsigned);
+LIBBPF_API int btf__add_enum64_value(struct btf *btf, const char *name, =
__u64 value);
=20
 enum btf_fwd_kind {
 	BTF_FWD_STRUCT =3D 0,
@@ -454,6 +460,11 @@ static inline bool btf_is_enum(const struct btf_type=
 *t)
 	return btf_kind(t) =3D=3D BTF_KIND_ENUM;
 }
=20
+static inline bool btf_is_enum64(const struct btf_type *t)
+{
+	return btf_kind(t) =3D=3D BTF_KIND_ENUM64;
+}
+
 static inline bool btf_is_fwd(const struct btf_type *t)
 {
 	return btf_kind(t) =3D=3D BTF_KIND_FWD;
@@ -549,6 +560,16 @@ static inline struct btf_enum *btf_enum(const struct=
 btf_type *t)
 	return (struct btf_enum *)(t + 1);
 }
=20
+static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
+{
+	return (struct btf_enum64 *)(t + 1);
+}
+
+static inline __u64 btf_enum64_value(const struct btf_enum64 *e)
+{
+	return (__u64)e->hi32 << 32 | e->lo32;
+}
+
 static inline struct btf_member *btf_members(const struct btf_type *t)
 {
 	return (struct btf_member *)(t + 1);
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 6b1bc1f43728..c3f99ca29426 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -320,6 +320,7 @@ static int btf_dump_mark_referenced(struct btf_dump *=
d)
 		case BTF_KIND_ENUM:
 		case BTF_KIND_FWD:
 		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM64:
 			break;
=20
 		case BTF_KIND_VOLATILE:
@@ -539,6 +540,7 @@ static int btf_dump_order_type(struct btf_dump *d, __=
u32 id, bool through_ptr)
 	}
 	case BTF_KIND_ENUM:
 	case BTF_KIND_FWD:
+	case BTF_KIND_ENUM64:
 		/*
 		 * non-anonymous or non-referenced enums are top-level
 		 * declarations and should be emitted. Same logic can be
@@ -739,6 +741,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __=
u32 id, __u32 cont_id)
 		tstate->emit_state =3D EMITTED;
 		break;
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		if (top_level_def) {
 			btf_dump_emit_enum_def(d, id, t, 0);
 			btf_dump_printf(d, ";\n\n");
@@ -993,8 +996,11 @@ static void btf_dump_emit_enum_def(struct btf_dump *=
d, __u32 id,
 				   const struct btf_type *t,
 				   int lvl)
 {
-	const struct btf_enum *v =3D btf_enum(t);
+	bool is_unsigned =3D btf_kflag(t);
+	const struct btf_enum64 *v64;
+	const struct btf_enum *v;
 	__u16 vlen =3D btf_vlen(t);
+	const char *fmt_str;
 	const char *name;
 	size_t dup_cnt;
 	int i;
@@ -1005,18 +1011,47 @@ static void btf_dump_emit_enum_def(struct btf_dum=
p *d, __u32 id,
=20
 	if (vlen) {
 		btf_dump_printf(d, " {");
-		for (i =3D 0; i < vlen; i++, v++) {
-			name =3D btf_name_of(d, v->name_off);
-			/* enumerators share namespace with typedef idents */
-			dup_cnt =3D btf_dump_name_dups(d, d->ident_names, name);
-			if (dup_cnt > 1) {
-				btf_dump_printf(d, "\n%s%s___%zu =3D %u,",
-						pfx(lvl + 1), name, dup_cnt,
-						(__u32)v->val);
-			} else {
-				btf_dump_printf(d, "\n%s%s =3D %u,",
-						pfx(lvl + 1), name,
-						(__u32)v->val);
+		if (btf_is_enum(t)) {
+			v =3D btf_enum(t);
+			for (i =3D 0; i < vlen; i++, v++) {
+				name =3D btf_name_of(d, v->name_off);
+				/* enumerators share namespace with typedef idents */
+				dup_cnt =3D btf_dump_name_dups(d, d->ident_names, name);
+				if (dup_cnt > 1) {
+					fmt_str =3D is_unsigned ? "\n%s%s___%zu =3D %u,"
+							      : "\n%s%s___%zu =3D %d,";
+					btf_dump_printf(d, fmt_str,
+							pfx(lvl + 1), name, dup_cnt,
+							v->val);
+				} else {
+					fmt_str =3D is_unsigned ? "\n%s%s =3D %u,"
+							      : "\n%s%s =3D %d,";
+					btf_dump_printf(d, fmt_str,
+							pfx(lvl + 1), name,
+							v->val);
+				}
+			}
+		} else {
+			v64 =3D btf_enum64(t);
+			for (i =3D 0; i < vlen; i++, v64++) {
+				__u64 val =3D btf_enum64_value(v64);
+
+				name =3D btf_name_of(d, v64->name_off);
+				/* enumerators share namespace with typedef idents */
+				dup_cnt =3D btf_dump_name_dups(d, d->ident_names, name);
+				if (dup_cnt > 1) {
+					fmt_str =3D is_unsigned ? "\n%s%s___%zu =3D %lluULL,"
+							      : "\n%s%s___%zu =3D %lldLL,";
+					btf_dump_printf(d, fmt_str,
+							pfx(lvl + 1), name, dup_cnt,
+							val);
+				} else {
+					fmt_str =3D is_unsigned ? "\n%s%s =3D %lluULL,"
+							      : "\n%s%s =3D %lldLL,";
+					btf_dump_printf(d, fmt_str,
+							pfx(lvl + 1), name,
+							val);
+				}
 			}
 		}
 		btf_dump_printf(d, "\n%s}", pfx(lvl));
@@ -1183,6 +1218,7 @@ static void btf_dump_emit_type_decl(struct btf_dump=
 *d, __u32 id,
 		case BTF_KIND_UNION:
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM64:
 			goto done;
 		default:
 			pr_warn("unexpected type in decl chain, kind:%u, id:[%u]\n",
@@ -1312,6 +1348,7 @@ static void btf_dump_emit_type_chain(struct btf_dum=
p *d,
 				btf_dump_emit_struct_fwd(d, id, t);
 			break;
 		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
 			btf_dump_emit_mods(d, decls);
 			/* inline anonymous enum */
 			if (t->name_off =3D=3D 0 && !d->skip_anon_defs)
@@ -2024,7 +2061,9 @@ static int btf_dump_enum_data(struct btf_dump *d,
 			      __u32 id,
 			      const void *data)
 {
+	const struct btf_enum64 *e64;
 	const struct btf_enum *e;
+	bool is_unsigned;
 	__s64 value;
 	int i, err;
=20
@@ -2032,14 +2071,26 @@ static int btf_dump_enum_data(struct btf_dump *d,
 	if (err)
 		return err;
=20
-	for (i =3D 0, e =3D btf_enum(t); i < btf_vlen(t); i++, e++) {
-		if (value !=3D e->val)
-			continue;
-		btf_dump_type_values(d, "%s", btf_name_of(d, e->name_off));
-		return 0;
-	}
+	is_unsigned =3D btf_kflag(t);
+	if (btf_is_enum(t)) {
+		for (i =3D 0, e =3D btf_enum(t); i < btf_vlen(t); i++, e++) {
+			if (value !=3D e->val)
+				continue;
+			btf_dump_type_values(d, "%s", btf_name_of(d, e->name_off));
+			return 0;
+		}
=20
-	btf_dump_type_values(d, "%d", value);
+		btf_dump_type_values(d, is_unsigned ? "%u" : "%d", value);
+	} else {
+		for (i =3D 0, e64 =3D btf_enum64(t); i < btf_vlen(t); i++, e64++) {
+			if (value !=3D btf_enum64_value(e64))
+				continue;
+			btf_dump_type_values(d, "%s", btf_name_of(d, e64->name_off));
+			return 0;
+		}
+
+		btf_dump_type_values(d, is_unsigned ? "%lluULL" : "%lldLL", value);
+	}
 	return 0;
 }
=20
@@ -2099,6 +2150,7 @@ static int btf_dump_type_data_check_overflow(struct=
 btf_dump *d,
 	case BTF_KIND_FLOAT:
 	case BTF_KIND_PTR:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		if (data + bits_offset / 8 + size > d->typed_dump->data_end)
 			return -E2BIG;
 		break;
@@ -2203,6 +2255,7 @@ static int btf_dump_type_data_check_zero(struct btf=
_dump *d,
 		return -ENODATA;
 	}
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		err =3D btf_dump_get_enum_value(d, t, data, id, &value);
 		if (err)
 			return err;
@@ -2275,6 +2328,7 @@ static int btf_dump_dump_type_data(struct btf_dump =
*d,
 		err =3D btf_dump_struct_data(d, t, id, data);
 		break;
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		/* handle bitfield and int enum values */
 		if (bit_sz) {
 			__u64 print_num;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 63c0f412266c..2e8b843ff5ef 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2114,6 +2114,7 @@ static const char *__btf_kind_str(__u16 kind)
 	case BTF_KIND_FLOAT: return "float";
 	case BTF_KIND_DECL_TAG: return "decl_tag";
 	case BTF_KIND_TYPE_TAG: return "type_tag";
+	case BTF_KIND_ENUM64: return "enum64";
 	default: return "unknown";
 	}
 }
@@ -2642,9 +2643,10 @@ static bool btf_needs_sanitization(struct bpf_obje=
ct *obj)
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
 	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
+	bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
=20
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag;
+	       !has_decl_tag || !has_type_tag || !has_enum64;
 }
=20
 static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf =
*btf)
@@ -2655,6 +2657,7 @@ static void bpf_object__sanitize_btf(struct bpf_obj=
ect *obj, struct btf *btf)
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
 	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
 	bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
+	bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
 	struct btf_type *t;
 	int i, j, vlen;
=20
@@ -2717,6 +2720,17 @@ static void bpf_object__sanitize_btf(struct bpf_ob=
ject *obj, struct btf *btf)
 			/* replace TYPE_TAG with a CONST */
 			t->name_off =3D 0;
 			t->info =3D BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
+		} else if (!has_enum64 && btf_is_enum(t)) {
+			/* clear the kflag */
+			t->info &=3D 0x7fffffff;
+		} else if (!has_enum64 && btf_is_enum64(t)) {
+			/* replace ENUM64 with pointer->void's */
+			vlen =3D btf_vlen(t);
+			for (j =3D 0; j <=3D vlen; j++, t++) {
+				t->name_off =3D 0;
+				t->info =3D BTF_INFO_ENC(BTF_KIND_PTR, 0, 0);
+				t->type =3D 0;
+			}
 		}
 	}
 }
@@ -3563,6 +3577,12 @@ static enum kcfg_type find_kcfg_type(const struct =
btf *btf, int id,
 		if (strcmp(name, "libbpf_tristate"))
 			return KCFG_UNKNOWN;
 		return KCFG_TRISTATE;
+	case BTF_KIND_ENUM64:
+		if (t->size !=3D 8)
+			return KCFG_UNKNOWN;
+		if (strcmp(name, "libbpf_tristate"))
+			return KCFG_UNKNOWN;
+		return KCFG_TRISTATE;
 	case BTF_KIND_ARRAY:
 		if (btf_array(t)->nelems =3D=3D 0)
 			return KCFG_UNKNOWN;
@@ -4746,6 +4766,17 @@ static int probe_kern_bpf_cookie(void)
 	return probe_fd(ret);
 }
=20
+static int probe_kern_btf_enum64(void)
+{
+	static const char strs[] =3D "\0enum64";
+	__u32 types[] =3D {
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN =3D 0,
 	FEAT_SUPPORTED =3D 1,
@@ -4811,6 +4842,9 @@ static struct kern_feature_desc {
 	[FEAT_BPF_COOKIE] =3D {
 		"BPF cookie support", probe_kern_bpf_cookie,
 	},
+	[FEAT_BTF_ENUM64] =3D {
+		"BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
+	},
 };
=20
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
@@ -5296,6 +5330,15 @@ void bpf_core_free_cands(struct bpf_core_cand_list=
 *cands)
 	free(cands);
 }
=20
+static bool btf_is_enum_enum64(const struct btf_type *t1,
+			       const struct btf_type *t2) {
+	if (btf_is_enum(t1) && btf_is_enum64(t2))
+		return true;
+	if (btf_is_enum(t2) && btf_is_enum64(t1))
+		return true;
+	return false;
+}
+
 int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 		       size_t local_essent_len,
 		       const struct btf *targ_btf,
@@ -5315,8 +5358,10 @@ int bpf_core_add_cands(struct bpf_core_cand *local=
_cand,
 	n =3D btf__type_cnt(targ_btf);
 	for (i =3D targ_start_id; i < n; i++) {
 		t =3D btf__type_by_id(targ_btf, i);
-		if (btf_kind(t) !=3D btf_kind(local_t))
-			continue;
+		if (btf_kind(t) !=3D btf_kind(local_t)) {
+			if (!btf_is_enum_enum64(t, local_t))
+				continue;
+		}
=20
 		targ_name =3D btf__name_by_offset(targ_btf, t->name_off);
 		if (str_is_empty(targ_name))
@@ -5529,8 +5574,10 @@ int bpf_core_types_are_compat(const struct btf *lo=
cal_btf, __u32 local_id,
 	/* caller made sure that names match (ignoring flavor suffix) */
 	local_type =3D btf__type_by_id(local_btf, local_id);
 	targ_type =3D btf__type_by_id(targ_btf, targ_id);
-	if (btf_kind(local_type) !=3D btf_kind(targ_type))
-		return 0;
+	if (btf_kind(local_type) !=3D btf_kind(targ_type)) {
+		if (!btf_is_enum_enum64(local_type, targ_type))
+			return 0;
+	}
=20
 recur:
 	depth--;
@@ -5542,8 +5589,10 @@ int bpf_core_types_are_compat(const struct btf *lo=
cal_btf, __u32 local_id,
 	if (!local_type || !targ_type)
 		return -EINVAL;
=20
-	if (btf_kind(local_type) !=3D btf_kind(targ_type))
-		return 0;
+	if (btf_kind(local_type) !=3D btf_kind(targ_type)) {
+		if (!btf_is_enum_enum64(local_type, targ_type))
+			return 0;
+	}
=20
 	switch (btf_kind(local_type)) {
 	case BTF_KIND_UNKN:
@@ -5551,6 +5600,7 @@ int bpf_core_types_are_compat(const struct btf *loc=
al_btf, __u32 local_id,
 	case BTF_KIND_UNION:
 	case BTF_KIND_ENUM:
 	case BTF_KIND_FWD:
+	case BTF_KIND_ENUM64:
 		return 1;
 	case BTF_KIND_INT:
 		/* just reject deprecated bitfield-like integers; all other
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b5bc84039407..acde13bd48c8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -448,6 +448,10 @@ LIBBPF_0.8.0 {
 		bpf_object__open_subskeleton;
 		bpf_program__attach_kprobe_multi_opts;
 		bpf_program__attach_usdt;
+		btf__add_enum32;
+		btf__add_enum32_value;
+		btf__add_enum64;
+		btf__add_enum64_value;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
 } LIBBPF_0.7.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 4abdbe2fea9d..10c16acfa8ae 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -351,6 +351,8 @@ enum kern_feature_id {
 	FEAT_MEMCG_ACCOUNT,
 	/* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
 	FEAT_BPF_COOKIE,
+	/* BTF_KIND_ENUM64 support and BTF_KIND_ENUM kflag support */
+	FEAT_BTF_ENUM64,
 	__FEAT_CNT,
 };
=20
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 9aa016fb55aa..1e1ef3302921 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1343,6 +1343,7 @@ static bool glob_sym_btf_matches(const char *sym_na=
me, bool exact,
 	case BTF_KIND_FWD:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
+	case BTF_KIND_ENUM64:
 		n1 =3D btf__str_by_offset(btf1, t1->name_off);
 		n2 =3D btf__str_by_offset(btf2, t2->name_off);
 		if (strcmp(n1, n2) !=3D 0) {
@@ -1358,6 +1359,7 @@ static bool glob_sym_btf_matches(const char *sym_na=
me, bool exact,
 	switch (btf_kind(t1)) {
 	case BTF_KIND_UNKN: /* void */
 	case BTF_KIND_FWD:
+	case BTF_KIND_ENUM64:
 		return true;
 	case BTF_KIND_INT:
 	case BTF_KIND_FLOAT:
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index f25ffd03c3b1..1e751400427b 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -231,11 +231,15 @@ int bpf_core_parse_spec(const char *prog_name, cons=
t struct btf *btf,
 	spec->len++;
=20
 	if (core_relo_is_enumval_based(relo->kind)) {
-		if (!btf_is_enum(t) || spec->raw_len > 1 || access_idx >=3D btf_vlen(t=
))
+		if (!(btf_is_enum(t) || btf_is_enum64(t)) ||
+		    spec->raw_len > 1 || access_idx >=3D btf_vlen(t))
 			return -EINVAL;
=20
 		/* record enumerator name in a first accessor */
-		acc->name =3D btf__name_by_offset(btf, btf_enum(t)[access_idx].name_of=
f);
+		if (btf_is_enum(t))
+			acc->name =3D btf__name_by_offset(btf, btf_enum(t)[access_idx].name_o=
ff);
+		else
+			acc->name =3D btf__name_by_offset(btf, btf_enum64(t)[access_idx].name=
_off);
 		return 0;
 	}
=20
@@ -340,15 +344,19 @@ static int bpf_core_fields_are_compat(const struct =
btf *local_btf,
=20
 	if (btf_is_composite(local_type) && btf_is_composite(targ_type))
 		return 1;
-	if (btf_kind(local_type) !=3D btf_kind(targ_type))
-		return 0;
+	if (btf_kind(local_type) !=3D btf_kind(targ_type)) {
+		if (btf_is_enum(local_type) && btf_is_enum64(targ_type)) ;
+		else if (btf_is_enum64(local_type) && btf_is_enum(targ_type)) ;
+		else return 0;
+	}
=20
 	switch (btf_kind(local_type)) {
 	case BTF_KIND_PTR:
 	case BTF_KIND_FLOAT:
 		return 1;
 	case BTF_KIND_FWD:
-	case BTF_KIND_ENUM: {
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64: {
 		const char *local_name, *targ_name;
 		size_t local_len, targ_len;
=20
@@ -494,29 +502,48 @@ static int bpf_core_spec_match(struct bpf_core_spec=
 *local_spec,
=20
 	if (core_relo_is_enumval_based(local_spec->relo_kind)) {
 		size_t local_essent_len, targ_essent_len;
+		const struct btf_enum64 *e64;
 		const struct btf_enum *e;
 		const char *targ_name;
=20
 		/* has to resolve to an enum */
 		targ_type =3D skip_mods_and_typedefs(targ_spec->btf, targ_id, &targ_id=
);
-		if (!btf_is_enum(targ_type))
+		if (!btf_is_enum(targ_type) && !btf_is_enum64(targ_type))
 			return 0;
=20
 		local_essent_len =3D bpf_core_essential_name_len(local_acc->name);
=20
-		for (i =3D 0, e =3D btf_enum(targ_type); i < btf_vlen(targ_type); i++,=
 e++) {
-			targ_name =3D btf__name_by_offset(targ_spec->btf, e->name_off);
-			targ_essent_len =3D bpf_core_essential_name_len(targ_name);
-			if (targ_essent_len !=3D local_essent_len)
-				continue;
-			if (strncmp(local_acc->name, targ_name, local_essent_len) =3D=3D 0) {
-				targ_acc->type_id =3D targ_id;
-				targ_acc->idx =3D i;
-				targ_acc->name =3D targ_name;
-				targ_spec->len++;
-				targ_spec->raw_spec[targ_spec->raw_len] =3D targ_acc->idx;
-				targ_spec->raw_len++;
-				return 1;
+		if (btf_is_enum(targ_type)) {
+			for (i =3D 0, e =3D btf_enum(targ_type); i < btf_vlen(targ_type); i++=
, e++) {
+				targ_name =3D btf__name_by_offset(targ_spec->btf, e->name_off);
+				targ_essent_len =3D bpf_core_essential_name_len(targ_name);
+				if (targ_essent_len !=3D local_essent_len)
+					continue;
+				if (strncmp(local_acc->name, targ_name, local_essent_len) =3D=3D 0) =
{
+					targ_acc->type_id =3D targ_id;
+					targ_acc->idx =3D i;
+					targ_acc->name =3D targ_name;
+					targ_spec->len++;
+					targ_spec->raw_spec[targ_spec->raw_len] =3D targ_acc->idx;
+					targ_spec->raw_len++;
+					return 1;
+				}
+			}
+		} else {
+			for (i =3D 0, e64 =3D btf_enum64(targ_type); i < btf_vlen(targ_type);=
 i++, e64++) {
+				targ_name =3D btf__name_by_offset(targ_spec->btf, e64->name_off);
+				targ_essent_len =3D bpf_core_essential_name_len(targ_name);
+				if (targ_essent_len !=3D local_essent_len)
+					continue;
+				if (strncmp(local_acc->name, targ_name, local_essent_len) =3D=3D 0) =
{
+					targ_acc->type_id =3D targ_id;
+					targ_acc->idx =3D i;
+					targ_acc->name =3D targ_name;
+					targ_spec->len++;
+					targ_spec->raw_spec[targ_spec->raw_len] =3D targ_acc->idx;
+					targ_spec->raw_len++;
+					return 1;
+				}
 			}
 		}
 		return 0;
@@ -681,7 +708,7 @@ static int bpf_core_calc_field_relo(const char *prog_=
name,
 		break;
 	case BPF_CORE_FIELD_SIGNED:
 		/* enums will be assumed unsigned */
-		*val =3D btf_is_enum(mt) ||
+		*val =3D btf_is_enum(mt) || btf_is_enum64(mt) ||
 		       (btf_int_encoding(mt) & BTF_INT_SIGNED);
 		if (validate)
 			*validate =3D true; /* signedness is never ambiguous */
@@ -753,6 +780,7 @@ static int bpf_core_calc_enumval_relo(const struct bp=
f_core_relo *relo,
 				      const struct bpf_core_spec *spec,
 				      __u64 *val)
 {
+	const struct btf_enum64 *e64;
 	const struct btf_type *t;
 	const struct btf_enum *e;
=20
@@ -764,8 +792,13 @@ static int bpf_core_calc_enumval_relo(const struct b=
pf_core_relo *relo,
 		if (!spec)
 			return -EUCLEAN; /* request instruction poisoning */
 		t =3D btf_type_by_id(spec->btf, spec->spec[0].type_id);
-		e =3D btf_enum(t) + spec->spec[0].idx;
-		*val =3D e->val;
+		if (btf_is_enum(t)) {
+			e =3D btf_enum(t) + spec->spec[0].idx;
+			*val =3D e->val;
+		} else {
+			e64 =3D btf_enum64(t) + spec->spec[0].idx;
+			*val =3D btf_enum64_value(e64);
+		}
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1034,7 +1067,7 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
 		}
=20
 		insn[0].imm =3D new_val;
-		insn[1].imm =3D 0; /* currently only 32-bit values are supported */
+		insn[1].imm =3D new_val >> 32;
 		pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -=
> %llu\n",
 			 prog_name, relo_idx, insn_idx,
 			 (unsigned long long)imm, new_val);
@@ -1056,6 +1089,7 @@ int bpf_core_patch_insn(const char *prog_name, stru=
ct bpf_insn *insn,
  */
 int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core=
_spec *spec)
 {
+	const struct btf_enum64 *e64;
 	const struct btf_type *t;
 	const struct btf_enum *e;
 	const char *s;
@@ -1086,10 +1120,15 @@ int bpf_core_format_spec(char *buf, size_t buf_sz=
, const struct bpf_core_spec *s
=20
 	if (core_relo_is_enumval_based(spec->relo_kind)) {
 		t =3D skip_mods_and_typedefs(spec->btf, type_id, NULL);
-		e =3D btf_enum(t) + spec->raw_spec[0];
-		s =3D btf__name_by_offset(spec->btf, e->name_off);
-
-		append_buf("::%s =3D %u", s, e->val);
+		if (btf_is_enum(t)) {
+			e =3D btf_enum(t) + spec->raw_spec[0];
+			s =3D btf__name_by_offset(spec->btf, e->name_off);
+			append_buf("::%s =3D %u", s, e->val);
+		} else {
+			e64 =3D btf_enum64(t) + spec->raw_spec[0];
+			s =3D btf__name_by_offset(spec->btf, e64->name_off);
+			append_buf("::%s =3D %llu", s, btf_enum64_value(e64));
+		}
 		return len;
 	}
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
index 5fce7008d1ff..1d3ac4496e7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -159,16 +159,16 @@ static void test_btf_dump_incremental(void)
 	 * struct s { int x; };
 	 *
 	 */
-	id =3D btf__add_enum(btf, "x", 4);
+	id =3D btf__add_enum32(btf, "x", false);
 	ASSERT_EQ(id, 1, "enum_declaration_id");
-	id =3D btf__add_enum(btf, "x", 4);
+	id =3D btf__add_enum32(btf, "x", true);
 	ASSERT_EQ(id, 2, "named_enum_id");
-	err =3D btf__add_enum_value(btf, "X", 1);
+	err =3D btf__add_enum32_value(btf, "X", 1);
 	ASSERT_OK(err, "named_enum_val_ok");
=20
-	id =3D btf__add_enum(btf, NULL, 4);
+	id =3D btf__add_enum32(btf, NULL, true);
 	ASSERT_EQ(id, 3, "anon_enum_id");
-	err =3D btf__add_enum_value(btf, "Y", 1);
+	err =3D btf__add_enum32_value(btf, "Y", 1);
 	ASSERT_OK(err, "anon_enum_val_ok");
=20
 	id =3D btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_write.c
index addf99c05896..be958ab26ebd 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -152,11 +152,11 @@ static void gen_btf(struct btf *btf)
 		     "\t'f1' type_id=3D1 bits_offset=3D0 bitfield_size=3D16", "raw_dum=
p");
=20
 	/* ENUM */
-	id =3D btf__add_enum(btf, "e1", 4);
+	id =3D btf__add_enum32(btf, "e1", true);
 	ASSERT_EQ(id, 9, "enum_id");
-	err =3D btf__add_enum_value(btf, "v1", 1);
+	err =3D btf__add_enum32_value(btf, "v1", 1);
 	ASSERT_OK(err, "v1_res");
-	err =3D btf__add_enum_value(btf, "v2", 2);
+	err =3D btf__add_enum32_value(btf, "v2", 2);
 	ASSERT_OK(err, "v2_res");
=20
 	t =3D btf__type_by_id(btf, 9);
--=20
2.30.2

