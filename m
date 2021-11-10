Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4618B44BB01
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhKJFWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:22:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18800 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhKJFWq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:22:46 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA54iUV021737
        for <bpf@vger.kernel.org>; Tue, 9 Nov 2021 21:19:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VqqkTvQiX63RZVKo2EInyiro2//+T0CaNstT5WosU/Q=;
 b=ln0+hIPIP06HM3J6uLVkjkKUHpXpcrPAmlc0w5lW/6Wx/T9EjiJy1PTmPr//49b+WS9/
 qZfjGpzHCZMW8nnNwmqIxB9qdAkC0+DyKbnbREyrOuwglj3w+RcZ1wmzqvEcC7y85DCb
 H9U/d2Q68A5/pxqlydvuEP3h/ePjqU6h6iI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7ys2u5wp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:19:59 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:19:57 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 4C1D72361188; Tue,  9 Nov 2021 21:19:51 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 02/10] libbpf: Support BTF_KIND_TYPE_TAG
Date:   Tue, 9 Nov 2021 21:19:51 -0800
Message-ID: <20211110051951.369416-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110051940.367472-1-yhs@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: BiU77oc3LdDhHhgUpiP-b7SEvw6o98Xs
X-Proofpoint-GUID: BiU77oc3LdDhHhgUpiP-b7SEvw6o98Xs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add libbpf support for BTF_KIND_TYPE_TAG.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c             | 23 +++++++++++++++++++++++
 tools/lib/bpf/btf.h             |  9 ++++++++-
 tools/lib/bpf/btf_dump.c        |  9 +++++++++
 tools/lib/bpf/libbpf.c          | 31 ++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.map        |  1 +
 tools/lib/bpf/libbpf_internal.h |  2 ++
 6 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7e4c5586bd87..4d9883bef330 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -299,6 +299,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_FLOAT:
+	case BTF_KIND_TYPE_TAG:
 		return base_size;
 	case BTF_KIND_INT:
 		return base_size + sizeof(__u32);
@@ -349,6 +350,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_FLOAT:
+	case BTF_KIND_TYPE_TAG:
 		return 0;
 	case BTF_KIND_INT:
 		*(__u32 *)(t + 1) =3D bswap_32(*(__u32 *)(t + 1));
@@ -649,6 +651,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_CONST:
 	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
 		return btf__align_of(btf, t->type);
 	case BTF_KIND_ARRAY:
 		return btf__align_of(btf, btf_array(t)->type);
@@ -2235,6 +2238,22 @@ int btf__add_restrict(struct btf *btf, int ref_typ=
e_id)
 	return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id);
 }
=20
+/*
+ * Append new BTF_KIND_TYPE_TAGtype with:
+ *   - *value*, non-empty/non-NULL name;
+ *   - *ref_type_id* - referenced type ID, it might not exist yet;
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_i=
d)
+{
+	if (!value|| !value[0])
+		return libbpf_err(-EINVAL);
+
+	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id);
+}
+
 /*
  * Append new BTF_KIND_FUNC type with:
  *   - *name*, non-empty/non-NULL name;
@@ -3625,6 +3644,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FUNC:
 		case BTF_KIND_FLOAT:
+		case BTF_KIND_TYPE_TAG:
 			h =3D btf_hash_common(t);
 			break;
 		case BTF_KIND_INT:
@@ -3685,6 +3705,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d,=
 __u32 type_id)
 	case BTF_KIND_VAR:
 	case BTF_KIND_DATASEC:
 	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_TYPE_TAG:
 		return 0;
=20
 	case BTF_KIND_INT:
@@ -4289,6 +4310,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, =
__u32 type_id)
 	case BTF_KIND_PTR:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
+	case BTF_KIND_TYPE_TAG:
 		ref_type_id =3D btf_dedup_ref_type(d, t->type);
 		if (ref_type_id < 0)
 			return ref_type_id;
@@ -4595,6 +4617,7 @@ int btf_type_visit_type_ids(struct btf_type *t, typ=
e_id_visit_fn visit, void *ct
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
 	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_TYPE_TAG:
 		return visit(&t->type, ctx);
=20
 	case BTF_KIND_ARRAY: {
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index bc005ba3ceec..129c2acc8493 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -227,6 +227,7 @@ LIBBPF_API int btf__add_typedef(struct btf *btf, cons=
t char *name, int ref_type_
 LIBBPF_API int btf__add_volatile(struct btf *btf, int ref_type_id);
 LIBBPF_API int btf__add_const(struct btf *btf, int ref_type_id);
 LIBBPF_API int btf__add_restrict(struct btf *btf, int ref_type_id);
+LIBBPF_API int btf__add_type_tag(struct btf *btf, const char *value, int=
 ref_type_id);
=20
 /* func and func_proto construction APIs */
 LIBBPF_API int btf__add_func(struct btf *btf, const char *name,
@@ -403,7 +404,8 @@ static inline bool btf_is_mod(const struct btf_type *=
t)
=20
 	return kind =3D=3D BTF_KIND_VOLATILE ||
 	       kind =3D=3D BTF_KIND_CONST ||
-	       kind =3D=3D BTF_KIND_RESTRICT;
+	       kind =3D=3D BTF_KIND_RESTRICT ||
+	       kind =3D=3D BTF_KIND_TYPE_TAG;
 }
=20
 static inline bool btf_is_func(const struct btf_type *t)
@@ -436,6 +438,11 @@ static inline bool btf_is_decl_tag(const struct btf_=
type *t)
 	return btf_kind(t) =3D=3D BTF_KIND_DECL_TAG;
 }
=20
+static inline bool btf_is_type_tag(const struct btf_type *t)
+{
+	return btf_kind(t) =3D=3D BTF_KIND_TYPE_TAG;
+}
+
 static inline __u8 btf_int_encoding(const struct btf_type *t)
 {
 	return BTF_INT_ENCODING(*(__u32 *)(t + 1));
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 17db62b5002e..380250a5bfcd 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -317,6 +317,7 @@ static int btf_dump_mark_referenced(struct btf_dump *=
d)
 		case BTF_KIND_FUNC:
 		case BTF_KIND_VAR:
 		case BTF_KIND_DECL_TAG:
+		case BTF_KIND_TYPE_TAG:
 			d->type_states[t->type].referenced =3D 1;
 			break;
=20
@@ -560,6 +561,7 @@ static int btf_dump_order_type(struct btf_dump *d, __=
u32 id, bool through_ptr)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_CONST:
 	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
 		return btf_dump_order_type(d, t->type, through_ptr);
=20
 	case BTF_KIND_FUNC_PROTO: {
@@ -734,6 +736,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __=
u32 id, __u32 cont_id)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_CONST:
 	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
 		btf_dump_emit_type(d, t->type, cont_id);
 		break;
 	case BTF_KIND_ARRAY:
@@ -1154,6 +1157,7 @@ static void btf_dump_emit_type_decl(struct btf_dump=
 *d, __u32 id,
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_FUNC_PROTO:
+		case BTF_KIND_TYPE_TAG:
 			id =3D t->type;
 			break;
 		case BTF_KIND_ARRAY:
@@ -1322,6 +1326,11 @@ static void btf_dump_emit_type_chain(struct btf_du=
mp *d,
 		case BTF_KIND_RESTRICT:
 			btf_dump_printf(d, " restrict");
 			break;
+		case BTF_KIND_TYPE_TAG:
+			btf_dump_emit_mods(d, decls);
+			name =3D btf_name_of(d, t->name_off);
+			btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
+			break;
 		case BTF_KIND_ARRAY: {
 			const struct btf_array *a =3D btf_array(t);
 			const struct btf_type *next_t;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d869ebee1e27..f6bf8ce24bbd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -197,6 +197,8 @@ enum kern_feature_id {
 	FEAT_PERF_LINK,
 	/* BTF_KIND_DECL_TAG support */
 	FEAT_BTF_DECL_TAG,
+	/* BTF_KIND_TYPE_TAG support */
+	FEAT_BTF_TYPE_TAG,
 	__FEAT_CNT,
 };
=20
@@ -2076,6 +2078,7 @@ static const char *__btf_kind_str(__u16 kind)
 	case BTF_KIND_DATASEC: return "datasec";
 	case BTF_KIND_FLOAT: return "float";
 	case BTF_KIND_DECL_TAG: return "decl_tag";
+	case BTF_KIND_TYPE_TAG: return "type_tag";
 	default: return "unknown";
 	}
 }
@@ -2588,8 +2591,10 @@ static bool btf_needs_sanitization(struct bpf_obje=
ct *obj)
 	bool has_float =3D kernel_supports(obj, FEAT_BTF_FLOAT);
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
 	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
+	bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
=20
-	return !has_func || !has_datasec || !has_func_global || !has_float || !=
has_decl_tag;
+	return !has_func || !has_datasec || !has_func_global || !has_float ||
+	       !has_decl_tag || !has_type_tag;
 }
=20
 static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf =
*btf)
@@ -2599,6 +2604,7 @@ static void bpf_object__sanitize_btf(struct bpf_obj=
ect *obj, struct btf *btf)
 	bool has_float =3D kernel_supports(obj, FEAT_BTF_FLOAT);
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
 	bool has_decl_tag =3D kernel_supports(obj, FEAT_BTF_DECL_TAG);
+	bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	struct btf_type *t;
 	int i, j, vlen;
=20
@@ -2657,6 +2663,10 @@ static void bpf_object__sanitize_btf(struct bpf_ob=
ject *obj, struct btf *btf)
 			 */
 			t->name_off =3D 0;
 			t->info =3D BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 0);
+		} else if (!has_type_tag && btf_is_type_tag(t)) {
+			/* replace TYPE_TAG with a CONST */
+			t->name_off =3D 0;
+			t->info =3D BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
 		}
 	}
 }
@@ -4460,6 +4470,22 @@ static int probe_kern_btf_decl_tag(void)
 					     strs, sizeof(strs)));
 }
=20
+static int probe_kern_btf_type_tag(void)
+{
+	static const char strs[] =3D "\0tag";
+	__u32 types[] =3D {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		/* attr */
+		BTF_TYPE_TYPE_TAG_ENC(1, 1),				/* [2] */
+		/* ptr */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 2),	/* [3] */
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
 static int probe_kern_array_mmap(void)
 {
 	struct bpf_create_map_attr attr =3D {
@@ -4657,6 +4683,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_DECL_TAG] =3D {
 		"BTF_KIND_DECL_TAG support", probe_kern_btf_decl_tag,
 	},
+	[FEAT_BTF_TYPE_TAG] =3D {
+		"BTF_KIND_TYPE_TAG support", probe_kern_btf_type_tag,
+	},
 };
=20
 static bool kernel_supports(const struct bpf_object *obj, enum kern_feat=
ure_id feat_id)
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b895861a13c0..0126d924674f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -401,6 +401,7 @@ LIBBPF_0.6.0 {
 		bpf_program__insns;
 		btf__add_btf;
 		btf__add_decl_tag;
+		btf__add_type_tag;
 		btf__raw_data;
 		btf__type_cnt;
 } LIBBPF_0.5.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 2d873c962f99..5490fa98c0a6 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -73,6 +73,8 @@
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
 #define BTF_TYPE_DECL_TAG_ENC(value, type, component_idx) \
 	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), type), (comp=
onent_idx)
+#define BTF_TYPE_TYPE_TAG_ENC(value, type) \
+	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
=20
 #ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
--=20
2.30.2

