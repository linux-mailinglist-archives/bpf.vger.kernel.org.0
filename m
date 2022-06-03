Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E8B53C2D2
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 04:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiFCB7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 21:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiFCB7f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 21:59:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD8A39696
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 18:59:34 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2530r089025189
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 18:59:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=y2zoF6WHFKKTVcqtCBYR2bt2fWYvFBh/TLQktqYqeW4=;
 b=RuuQA9EeR8R8MnunPGhSdTXw3em0d3qpSF2/hkORz03pwonfzWUG2JqCVZTsrF5WRtau
 eJlz3jrRgzFrq8lP7y2lu/y/lWaMnnOAkbHByd7dVRwuopkVheGINpZCMgpylFqjMDad
 QkA5ekI5giKaS4JPm6R3AXzdTcK79u3Uo9U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge144wvt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 18:59:34 -0700
Received: from twshared18317.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 18:59:30 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 7BA34B299F63; Thu,  2 Jun 2022 18:59:21 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 05/18] libbpf: Add enum64 parsing and new enum64 public API
Date:   Thu, 2 Jun 2022 18:59:21 -0700
Message-ID: <20220603015921.1190165-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603015855.1187538-1-yhs@fb.com>
References: <20220603015855.1187538-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AGrY9eZbZdoPi0FrCXtC2tZLO54tAaTY
X-Proofpoint-ORIG-GUID: AGrY9eZbZdoPi0FrCXtC2tZLO54tAaTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_01,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add enum64 parsing support and two new enum64 public APIs:
  btf__add_enum64
  btf__add_enum64_value

Also add support of signedness for BTF_KIND_ENUM. The
BTF_KIND_ENUM API signatures are not changed. The signedness
will be changed from unsigned to signed if btf__add_enum_value()
finds any negative values.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c      | 103 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  12 +++++
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 117 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 1972d0c65e0c..8676efb2baba 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -305,6 +305,8 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + sizeof(__u32);
 	case BTF_KIND_ENUM:
 		return base_size + vlen * sizeof(struct btf_enum);
+	case BTF_KIND_ENUM64:
+		return base_size + vlen * sizeof(struct btf_enum64);
 	case BTF_KIND_ARRAY:
 		return base_size + sizeof(struct btf_array);
 	case BTF_KIND_STRUCT:
@@ -334,6 +336,7 @@ static void btf_bswap_type_base(struct btf_type *t)
 static int btf_bswap_type_rest(struct btf_type *t)
 {
 	struct btf_var_secinfo *v;
+	struct btf_enum64 *e64;
 	struct btf_member *m;
 	struct btf_array *a;
 	struct btf_param *p;
@@ -361,6 +364,13 @@ static int btf_bswap_type_rest(struct btf_type *t)
 			e->val =3D bswap_32(e->val);
 		}
 		return 0;
+	case BTF_KIND_ENUM64:
+		for (i =3D 0, e64 =3D btf_enum64(t); i < vlen; i++, e64++) {
+			e64->name_off =3D bswap_32(e64->name_off);
+			e64->val_lo32 =3D bswap_32(e64->val_lo32);
+			e64->val_hi32 =3D bswap_32(e64->val_hi32);
+		}
+		return 0;
 	case BTF_KIND_ARRAY:
 		a =3D btf_array(t);
 		a->type =3D bswap_32(a->type);
@@ -611,6 +621,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 =
type_id)
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
 		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
 		case BTF_KIND_DATASEC:
 		case BTF_KIND_FLOAT:
 			size =3D t->size;
@@ -658,6 +669,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
 	switch (kind) {
 	case BTF_KIND_INT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 	case BTF_KIND_FLOAT:
 		return min(btf_ptr_sz(btf), (size_t)t->size);
 	case BTF_KIND_PTR:
@@ -2176,6 +2188,10 @@ static int btf_add_enum_common(struct btf *btf, co=
nst char *name, __u32 byte_sz,
  */
 int btf__add_enum(struct btf *btf, const char *name, __u32 byte_sz)
 {
+	/*
+	 * set the signedness to be unsigned, it will change to signed
+	 * if any later enumerator is negative.
+	 */
 	return btf_add_enum_common(btf, name, byte_sz, false, BTF_KIND_ENUM);
 }
=20
@@ -2226,6 +2242,82 @@ int btf__add_enum_value(struct btf *btf, const cha=
r *name, __s64 value)
 	t =3D btf_last_type(btf);
 	btf_type_inc_vlen(t);
=20
+	/* if negative value, set signedness to signed */
+	if (value < 0)
+		t->info =3D btf_type_info(btf_kind(t), btf_vlen(t), true);
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
+ *   - *byte_sz* - size of the enum, in bytes.
+ *   - *is_signed* - whether the enum values are signed or not;
+ *
+ * Enum initially has no enum values in it (and corresponds to enum forw=
ard
+ * declaration). Enumerator values can be added by btf__add_enum64_value=
()
+ * immediately after btf__add_enum64() succeeds.
+ *
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_enum64(struct btf *btf, const char *name, __u32 byte_sz,
+		    bool is_signed)
+{
+	return btf_add_enum_common(btf, name, byte_sz, is_signed,
+				   BTF_KIND_ENUM64);
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
+	v->val_lo32 =3D (__u32)value;
+	v->val_hi32 =3D value >> 32;
+
+	/* update parent type's vlen */
+	t =3D btf_last_type(btf);
+	btf_type_inc_vlen(t);
+
 	btf->hdr->type_len +=3D sz;
 	btf->hdr->str_off +=3D sz;
 	return 0;
@@ -4737,6 +4829,7 @@ int btf_type_visit_type_ids(struct btf_type *t, typ=
e_id_visit_fn visit, void *ct
 	case BTF_KIND_INT:
 	case BTF_KIND_FLOAT:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		return 0;
=20
 	case BTF_KIND_FWD:
@@ -4831,6 +4924,16 @@ int btf_type_visit_str_offs(struct btf_type *t, st=
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
index 951ac7475794..a41463bf9060 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -215,6 +215,8 @@ LIBBPF_API int btf__add_field(struct btf *btf, const =
char *name, int field_type_
 /* enum construction APIs */
 LIBBPF_API int btf__add_enum(struct btf *btf, const char *name, __u32 by=
tes_sz);
 LIBBPF_API int btf__add_enum_value(struct btf *btf, const char *name, __=
s64 value);
+LIBBPF_API int btf__add_enum64(struct btf *btf, const char *name, __u32 =
bytes_sz, bool is_signed);
+LIBBPF_API int btf__add_enum64_value(struct btf *btf, const char *name, =
__u64 value);
=20
 enum btf_fwd_kind {
 	BTF_FWD_STRUCT =3D 0,
@@ -454,6 +456,11 @@ static inline bool btf_is_enum(const struct btf_type=
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
@@ -549,6 +556,11 @@ static inline struct btf_enum *btf_enum(const struct=
 btf_type *t)
 	return (struct btf_enum *)(t + 1);
 }
=20
+static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
+{
+	return (struct btf_enum64 *)(t + 1);
+}
+
 static inline struct btf_member *btf_members(const struct btf_type *t)
 {
 	return (struct btf_member *)(t + 1);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 38e284ff057d..116a2a8ee7c2 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -462,6 +462,8 @@ LIBBPF_0.8.0 {
=20
 LIBBPF_1.0.0 {
 	global:
+		btf__add_enum64;
+		btf__add_enum64_value;
 		libbpf_bpf_attach_type_str;
 		libbpf_bpf_link_type_str;
 		libbpf_bpf_map_type_str;
--=20
2.30.2

