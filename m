Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21404097E2
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbhIMPxQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:53:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20746 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245133AbhIMPxH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 11:53:07 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF544O014322
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:51:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=awEp5KRnaX0yLiff8NiwedjURdHh+NDSDmt749QIGLI=;
 b=V7mCl91ePDu8x/OXTd7hWKSrIYOtSI1QjixIinMIqoaDv7GL3iSQLt5Ru0n8byqFqDkC
 HcznfrlOuwgQ0hJZ+gdOHOwrqoFTvjWGW5ii/8Bp6Ida6CFc8LcTiwKChZnSLdMNOiS7
 9tSHxl+zSHBKGgpcBNbpr03n9I/9zvGY3A0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1vfcux2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:51:51 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 08:51:50 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3F8F0727902D; Mon, 13 Sep 2021 08:51:45 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 04/11] libbpf: add support for BTF_KIND_TAG
Date:   Mon, 13 Sep 2021 08:51:45 -0700
Message-ID: <20210913155145.3726307-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913155122.3722704-1-yhs@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 2PUOQT3NZ30qxbIgPSVKkCwUkIhchwf9
X-Proofpoint-ORIG-GUID: 2PUOQT3NZ30qxbIgPSVKkCwUkIhchwf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TAG support for parsing and dedup.
Also added sanitization for BTF_KIND_TAG. If BTF_KIND_TAG is not
supported in the kernel, sanitize it to INTs.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c             | 69 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h             | 15 +++++++
 tools/lib/bpf/btf_dump.c        |  3 ++
 tools/lib/bpf/libbpf.c          | 31 +++++++++++++--
 tools/lib/bpf/libbpf.map        |  5 +++
 tools/lib/bpf/libbpf_internal.h |  2 +
 6 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7cb6ebf1be37..f4dc3741af47 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -304,6 +304,8 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + sizeof(struct btf_var);
 	case BTF_KIND_DATASEC:
 		return base_size + vlen * sizeof(struct btf_var_secinfo);
+	case BTF_KIND_TAG:
+		return base_size + sizeof(struct btf_tag);
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
 		return -EINVAL;
@@ -376,6 +378,9 @@ static int btf_bswap_type_rest(struct btf_type *t)
 			v->size =3D bswap_32(v->size);
 		}
 		return 0;
+	case BTF_KIND_TAG:
+		btf_tag(t)->component_idx =3D bswap_32(btf_tag(t)->component_idx);
+		return 0;
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
 		return -EINVAL;
@@ -586,6 +591,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 =
type_id)
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_VAR:
+		case BTF_KIND_TAG:
 			type_id =3D t->type;
 			break;
 		case BTF_KIND_ARRAY:
@@ -2440,6 +2446,49 @@ int btf__add_datasec_var_info(struct btf *btf, int=
 var_type_id, __u32 offset, __
 	return 0;
 }
=20
+/*
+ * Append new BTF_KIND_TAG type with:
+ *   - *value* - non-empty/non-NULL string;
+ *   - *ref_type_id* - referenced type ID, it might not exist yet;
+ *   - *component_idx* - -1 for tagging reference type, otherwise struct=
/union
+ *     member or function argument index;
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_tag(struct btf *btf, const char *value, int ref_type_id,
+		 int component_idx)
+{
+	bool for_ref_type =3D false;
+	struct btf_type *t;
+	int sz, value_off;
+
+	if (!value || !value[0] || component_idx < -1)
+		return libbpf_err(-EINVAL);
+
+	if (validate_type_id(ref_type_id))
+		return libbpf_err(-EINVAL);
+
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	sz =3D sizeof(struct btf_type) + sizeof(struct btf_tag);
+	t =3D btf_add_type_mem(btf, sz);
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	value_off =3D btf__add_str(btf, value);
+	if (value_off < 0)
+		return value_off;
+
+	t->name_off =3D value_off;
+	t->info =3D btf_type_info(BTF_KIND_TAG, 0, for_ref_type);
+	t->type =3D ref_type_id;
+	((struct btf_tag *)(t + 1))->component_idx =3D component_idx;
+
+	return btf_commit_type(btf, sz);
+}
+
 struct btf_ext_sec_setup_param {
 	__u32 off;
 	__u32 len;
@@ -3535,6 +3584,7 @@ static int btf_dedup_prep(struct btf_dedup *d)
 			h =3D btf_hash_common(t);
 			break;
 		case BTF_KIND_INT:
+		case BTF_KIND_TAG:
 			h =3D btf_hash_int_tag(t);
 			break;
 		case BTF_KIND_ENUM:
@@ -3590,6 +3640,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d,=
 __u32 type_id)
 	case BTF_KIND_FUNC_PROTO:
 	case BTF_KIND_VAR:
 	case BTF_KIND_DATASEC:
+	case BTF_KIND_TAG:
 		return 0;
=20
 	case BTF_KIND_INT:
@@ -4210,6 +4261,23 @@ static int btf_dedup_ref_type(struct btf_dedup *d,=
 __u32 type_id)
 		}
 		break;
=20
+	case BTF_KIND_TAG:
+		ref_type_id =3D btf_dedup_ref_type(d, t->type);
+		if (ref_type_id < 0)
+			return ref_type_id;
+		t->type =3D ref_type_id;
+
+		h =3D btf_hash_int_tag(t);
+		for_each_dedup_cand(d, hash_entry, h) {
+			cand_id =3D (__u32)(long)hash_entry->value;
+			cand =3D btf_type_by_id(d->btf, cand_id);
+			if (btf_equal_int_tag(t, cand)) {
+				new_id =3D cand_id;
+				break;
+			}
+		}
+		break;
+
 	case BTF_KIND_ARRAY: {
 		struct btf_array *info =3D btf_array(t);
=20
@@ -4482,6 +4550,7 @@ int btf_type_visit_type_ids(struct btf_type *t, typ=
e_id_visit_fn visit, void *ct
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
+	case BTF_KIND_TAG:
 		return visit(&t->type, ctx);
=20
 	case BTF_KIND_ARRAY: {
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index f2e2fab950b7..659ea8a2769b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -143,6 +143,10 @@ LIBBPF_API int btf__add_datasec(struct btf *btf, con=
st char *name, __u32 byte_sz
 LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_i=
d,
 					 __u32 offset, __u32 byte_sz);
=20
+/* tag construction API */
+LIBBPF_API int btf__add_tag(struct btf *btf, const char *value, int ref_=
type_id,
+			    int component_idx);
+
 struct btf_dedup_opts {
 	unsigned int dedup_table_size;
 	bool dont_resolve_fwds;
@@ -330,6 +334,11 @@ static inline bool btf_is_float(const struct btf_typ=
e *t)
 	return btf_kind(t) =3D=3D BTF_KIND_FLOAT;
 }
=20
+static inline bool btf_is_tag(const struct btf_type *t)
+{
+	return btf_kind(t) =3D=3D BTF_KIND_TAG;
+}
+
 static inline __u8 btf_int_encoding(const struct btf_type *t)
 {
 	return BTF_INT_ENCODING(*(__u32 *)(t + 1));
@@ -398,6 +407,12 @@ btf_var_secinfos(const struct btf_type *t)
 	return (struct btf_var_secinfo *)(t + 1);
 }
=20
+struct btf_tag;
+static inline struct btf_tag *btf_tag(const struct btf_type *t)
+{
+	return (struct btf_tag *)(t + 1);
+}
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index e4b483f15fb9..ad6df97295ae 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -316,6 +316,7 @@ static int btf_dump_mark_referenced(struct btf_dump *=
d)
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FUNC:
 		case BTF_KIND_VAR:
+		case BTF_KIND_TAG:
 			d->type_states[t->type].referenced =3D 1;
 			break;
=20
@@ -583,6 +584,7 @@ static int btf_dump_order_type(struct btf_dump *d, __=
u32 id, bool through_ptr)
 	case BTF_KIND_FUNC:
 	case BTF_KIND_VAR:
 	case BTF_KIND_DATASEC:
+	case BTF_KIND_TAG:
 		d->type_states[id].order_state =3D ORDERED;
 		return 0;
=20
@@ -2215,6 +2217,7 @@ static int btf_dump_dump_type_data(struct btf_dump =
*d,
 	case BTF_KIND_FWD:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_FUNC_PROTO:
+	case BTF_KIND_TAG:
 		err =3D btf_dump_unsupported_data(d, t, id);
 		break;
 	case BTF_KIND_INT:
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8f579c6666b2..4a62ef714562 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -195,6 +195,8 @@ enum kern_feature_id {
 	FEAT_BTF_FLOAT,
 	/* BPF perf link support */
 	FEAT_PERF_LINK,
+	/* BTF_KIND_ATTR support */
+	FEAT_BTF_TAG,
 	__FEAT_CNT,
 };
=20
@@ -1987,6 +1989,7 @@ static const char *__btf_kind_str(__u16 kind)
 	case BTF_KIND_VAR: return "var";
 	case BTF_KIND_DATASEC: return "datasec";
 	case BTF_KIND_FLOAT: return "float";
+	case BTF_KIND_TAG: return "tag";
 	default: return "unknown";
 	}
 }
@@ -2486,8 +2489,9 @@ static bool btf_needs_sanitization(struct bpf_objec=
t *obj)
 	bool has_datasec =3D kernel_supports(obj, FEAT_BTF_DATASEC);
 	bool has_float =3D kernel_supports(obj, FEAT_BTF_FLOAT);
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
+	bool has_tag =3D kernel_supports(obj, FEAT_BTF_TAG);
=20
-	return !has_func || !has_datasec || !has_func_global || !has_float;
+	return !has_func || !has_datasec || !has_func_global || !has_float || !=
has_tag;
 }
=20
 static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf =
*btf)
@@ -2496,14 +2500,15 @@ static void bpf_object__sanitize_btf(struct bpf_o=
bject *obj, struct btf *btf)
 	bool has_datasec =3D kernel_supports(obj, FEAT_BTF_DATASEC);
 	bool has_float =3D kernel_supports(obj, FEAT_BTF_FLOAT);
 	bool has_func =3D kernel_supports(obj, FEAT_BTF_FUNC);
+	bool has_tag =3D kernel_supports(obj, FEAT_BTF_TAG);
 	struct btf_type *t;
 	int i, j, vlen;
=20
 	for (i =3D 1; i <=3D btf__get_nr_types(btf); i++) {
 		t =3D (struct btf_type *)btf__type_by_id(btf, i);
=20
-		if (!has_datasec && btf_is_var(t)) {
-			/* replace VAR with INT */
+		if ((!has_datasec && btf_is_var(t)) || (!has_tag && btf_is_tag(t))) {
+			/* replace VAR/TAG with INT */
 			t->info =3D BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
 			/*
 			 * using size =3D 1 is the safest choice, 4 will be too
@@ -4213,6 +4218,23 @@ static int probe_kern_btf_float(void)
 					     strs, sizeof(strs)));
 }
=20
+static int probe_kern_btf_tag(void)
+{
+	static const char strs[] =3D "\0tag";
+	__u32 types[] =3D {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* attr */
+		BTF_TYPE_TAG_ENC(1, 2, -1),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
 static int probe_kern_array_mmap(void)
 {
 	struct bpf_create_map_attr attr =3D {
@@ -4429,6 +4451,9 @@ static struct kern_feature_desc {
 	[FEAT_PERF_LINK] =3D {
 		"BPF perf link support", probe_perf_link,
 	},
+	[FEAT_BTF_TAG] =3D {
+		"BTF_KIND_TAG support", probe_kern_btf_tag,
+	},
 };
=20
 static bool kernel_supports(const struct bpf_object *obj, enum kern_feat=
ure_id feat_id)
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index bbc53bb25f68..9e649cf9e771 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -386,3 +386,8 @@ LIBBPF_0.5.0 {
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
 } LIBBPF_0.4.0;
+
+LIBBPF_0.6.0 {
+	global:
+		btf__add_tag;
+} LIBBPF_0.5.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 4f6ff5c23695..ceb0c98979bc 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -69,6 +69,8 @@
 #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
 #define BTF_TYPE_FLOAT_ENC(name, sz) \
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
+#define BTF_TYPE_TAG_ENC(value, type, component_idx) \
+	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (component=
_idx)
=20
 #ifndef likely
 #define likely(x) __builtin_expect(!!(x), 1)
--=20
2.30.2

