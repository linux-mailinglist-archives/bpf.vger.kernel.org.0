Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72399695578
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 01:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBNAkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 19:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBNAkk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 19:40:40 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A724FE064
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:40:37 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31DN6STp017843
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:40:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/tby5BhttfHYKj4AK0yWJtQMHG3fWq476FukFlTIBSw=;
 b=pS6jmwISl4xltb4kB2b4+hvZ71DYfHOa38+N870YP36UHBxHuZGY04QVQgf/QiPdj86y
 HEsbZzgOK9mxLfjm6k3WJFoxQjvtn3KJ+Ea05//ffUlYHkp+PtdH2jWSXt4kA6idOySV
 H6d6WTGi9Ho9o+T6RIeHYlygfj2u5UgXnNQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nqxkc0fhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:40:36 -0800
Received: from twshared19883.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Feb 2023 16:40:34 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 6805E16ED5D78; Mon, 13 Feb 2023 16:40:25 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v6 bpf-next 1/8] bpf: Add basic bpf_rb_{root,node} support
Date:   Mon, 13 Feb 2023 16:40:10 -0800
Message-ID: <20230214004017.2534011-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214004017.2534011-1-davemarchevsky@fb.com>
References: <20230214004017.2534011-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: y-JT2fMmPtrNmzflNLxY7Cku0Pg5RWxy
X-Proofpoint-ORIG-GUID: y-JT2fMmPtrNmzflNLxY7Cku0Pg5RWxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds special BPF_RB_{ROOT,NODE} btf_field_types similar to
BPF_LIST_{HEAD,NODE}, adds the necessary plumbing to detect the new
types, and adds bpf_rb_root_free function for freeing bpf_rb_root in
map_values.

structs bpf_rb_root and bpf_rb_node are opaque types meant to
obscure structs rb_root_cached rb_node, respectively.

btf_struct_access will prevent BPF programs from touching these special
fields automatically now that they're recognized.

btf_check_and_fixup_fields now groups list_head and rb_root together as
"graph root" fields and {list,rb}_node as "graph node", and does same
ownership cycle checking as before. Note that this function does _not_
prevent ownership type mixups (e.g. rb_root owning list_node) - that's
handled by btf_parse_graph_root.

After this patch, a bpf program can have a struct bpf_rb_root in a
map_value, but not add anything to nor do anything useful with it.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h                           |  20 ++-
 include/uapi/linux/bpf.h                      |  11 ++
 kernel/bpf/btf.c                              | 162 ++++++++++++------
 kernel/bpf/helpers.c                          |  40 +++++
 kernel/bpf/syscall.c                          |  28 ++-
 kernel/bpf/verifier.c                         |   5 +-
 tools/include/uapi/linux/bpf.h                |  11 ++
 .../selftests/bpf/prog_tests/linked_list.c    |  12 +-
 8 files changed, 216 insertions(+), 73 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8b5d0b4c4ada..be34f7deb6c3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -181,7 +181,10 @@ enum btf_field_type {
 	BPF_KPTR       =3D BPF_KPTR_UNREF | BPF_KPTR_REF,
 	BPF_LIST_HEAD  =3D (1 << 4),
 	BPF_LIST_NODE  =3D (1 << 5),
-	BPF_GRAPH_NODE_OR_ROOT =3D BPF_LIST_NODE | BPF_LIST_HEAD,
+	BPF_RB_ROOT    =3D (1 << 6),
+	BPF_RB_NODE    =3D (1 << 7),
+	BPF_GRAPH_NODE_OR_ROOT =3D BPF_LIST_NODE | BPF_LIST_HEAD |
+				 BPF_RB_NODE | BPF_RB_ROOT,
 };
=20
 struct btf_field_kptr {
@@ -285,6 +288,10 @@ static inline const char *btf_field_type_name(enum b=
tf_field_type type)
 		return "bpf_list_head";
 	case BPF_LIST_NODE:
 		return "bpf_list_node";
+	case BPF_RB_ROOT:
+		return "bpf_rb_root";
+	case BPF_RB_NODE:
+		return "bpf_rb_node";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -305,6 +312,10 @@ static inline u32 btf_field_type_size(enum btf_field=
_type type)
 		return sizeof(struct bpf_list_head);
 	case BPF_LIST_NODE:
 		return sizeof(struct bpf_list_node);
+	case BPF_RB_ROOT:
+		return sizeof(struct bpf_rb_root);
+	case BPF_RB_NODE:
+		return sizeof(struct bpf_rb_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -325,6 +336,10 @@ static inline u32 btf_field_type_align(enum btf_fiel=
d_type type)
 		return __alignof__(struct bpf_list_head);
 	case BPF_LIST_NODE:
 		return __alignof__(struct bpf_list_node);
+	case BPF_RB_ROOT:
+		return __alignof__(struct bpf_rb_root);
+	case BPF_RB_NODE:
+		return __alignof__(struct bpf_rb_node);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -435,6 +450,9 @@ void copy_map_value_locked(struct bpf_map *map, void =
*dst, void *src,
 void bpf_timer_cancel_and_free(void *timer);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock);
+void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
+		      struct bpf_spin_lock *spin_lock);
+
=20
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
=20
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 17afd2b35ee5..1503f61336b6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6917,6 +6917,17 @@ struct bpf_list_node {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+struct bpf_rb_root {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
+struct bpf_rb_node {
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 740bdb045b14..b9d1f5c4e316 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3324,12 +3324,14 @@ static const char *btf_find_decl_tag_value(const =
struct btf *btf,
 	return NULL;
 }
=20
-static int btf_find_list_head(const struct btf *btf, const struct btf_ty=
pe *pt,
-			      const struct btf_type *t, int comp_idx,
-			      u32 off, int sz, struct btf_field_info *info)
+static int
+btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
+		    const struct btf_type *t, int comp_idx, u32 off,
+		    int sz, struct btf_field_info *info,
+		    enum btf_field_type head_type)
 {
+	const char *node_field_name;
 	const char *value_type;
-	const char *list_node;
 	s32 id;
=20
 	if (!__btf_type_is_struct(t))
@@ -3339,26 +3341,32 @@ static int btf_find_list_head(const struct btf *b=
tf, const struct btf_type *pt,
 	value_type =3D btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
 	if (!value_type)
 		return -EINVAL;
-	list_node =3D strstr(value_type, ":");
-	if (!list_node)
+	node_field_name =3D strstr(value_type, ":");
+	if (!node_field_name)
 		return -EINVAL;
-	value_type =3D kstrndup(value_type, list_node - value_type, GFP_KERNEL =
| __GFP_NOWARN);
+	value_type =3D kstrndup(value_type, node_field_name - value_type, GFP_K=
ERNEL | __GFP_NOWARN);
 	if (!value_type)
 		return -ENOMEM;
 	id =3D btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
 	kfree(value_type);
 	if (id < 0)
 		return id;
-	list_node++;
-	if (str_is_empty(list_node))
+	node_field_name++;
+	if (str_is_empty(node_field_name))
 		return -EINVAL;
-	info->type =3D BPF_LIST_HEAD;
+	info->type =3D head_type;
 	info->off =3D off;
 	info->graph_root.value_btf_id =3D id;
-	info->graph_root.node_name =3D list_node;
+	info->graph_root.node_name =3D node_field_name;
 	return BTF_FIELD_FOUND;
 }
=20
+#define field_mask_test_name(field_type, field_type_str) \
+	if (field_mask & field_type && !strcmp(name, field_type_str)) { \
+		type =3D field_type;					\
+		goto end;						\
+	}
+
 static int btf_get_field_type(const char *name, u32 field_mask, u32 *see=
n_mask,
 			      int *align, int *sz)
 {
@@ -3382,18 +3390,11 @@ static int btf_get_field_type(const char *name, u=
32 field_mask, u32 *seen_mask,
 			goto end;
 		}
 	}
-	if (field_mask & BPF_LIST_HEAD) {
-		if (!strcmp(name, "bpf_list_head")) {
-			type =3D BPF_LIST_HEAD;
-			goto end;
-		}
-	}
-	if (field_mask & BPF_LIST_NODE) {
-		if (!strcmp(name, "bpf_list_node")) {
-			type =3D BPF_LIST_NODE;
-			goto end;
-		}
-	}
+	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
+	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
+	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
+	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
+
 	/* Only return BPF_KPTR when all other types with matchable names fail =
*/
 	if (field_mask & BPF_KPTR) {
 		type =3D BPF_KPTR_REF;
@@ -3406,6 +3407,8 @@ static int btf_get_field_type(const char *name, u32=
 field_mask, u32 *seen_mask,
 	return type;
 }
=20
+#undef field_mask_test_name
+
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt)
@@ -3438,6 +3441,7 @@ static int btf_find_struct_field(const struct btf *=
btf,
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_LIST_NODE:
+		case BPF_RB_NODE:
 			ret =3D btf_find_struct(btf, member_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3451,8 +3455,11 @@ static int btf_find_struct_field(const struct btf =
*btf,
 				return ret;
 			break;
 		case BPF_LIST_HEAD:
-			ret =3D btf_find_list_head(btf, t, member_type, i, off, sz,
-						 idx < info_cnt ? &info[idx] : &tmp);
+		case BPF_RB_ROOT:
+			ret =3D btf_find_graph_root(btf, t, member_type,
+						  i, off, sz,
+						  idx < info_cnt ? &info[idx] : &tmp,
+						  field_type);
 			if (ret < 0)
 				return ret;
 			break;
@@ -3499,6 +3506,7 @@ static int btf_find_datasec_var(const struct btf *b=
tf, const struct btf_type *t,
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_LIST_NODE:
+		case BPF_RB_NODE:
 			ret =3D btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3512,8 +3520,11 @@ static int btf_find_datasec_var(const struct btf *=
btf, const struct btf_type *t,
 				return ret;
 			break;
 		case BPF_LIST_HEAD:
-			ret =3D btf_find_list_head(btf, var, var_type, -1, off, sz,
-						 idx < info_cnt ? &info[idx] : &tmp);
+		case BPF_RB_ROOT:
+			ret =3D btf_find_graph_root(btf, var, var_type,
+						  -1, off, sz,
+						  idx < info_cnt ? &info[idx] : &tmp,
+						  field_type);
 			if (ret < 0)
 				return ret;
 			break;
@@ -3615,8 +3626,11 @@ static int btf_parse_kptr(const struct btf *btf, s=
truct btf_field *field,
 	return ret;
 }
=20
-static int btf_parse_list_head(const struct btf *btf, struct btf_field *=
field,
-			       struct btf_field_info *info)
+static int btf_parse_graph_root(const struct btf *btf,
+				struct btf_field *field,
+				struct btf_field_info *info,
+				const char *node_type_name,
+				size_t node_type_align)
 {
 	const struct btf_type *t, *n =3D NULL;
 	const struct btf_member *member;
@@ -3638,13 +3652,13 @@ static int btf_parse_list_head(const struct btf *=
btf, struct btf_field *field,
 		n =3D btf_type_by_id(btf, member->type);
 		if (!__btf_type_is_struct(n))
 			return -EINVAL;
-		if (strcmp("bpf_list_node", __btf_name_by_offset(btf, n->name_off)))
+		if (strcmp(node_type_name, __btf_name_by_offset(btf, n->name_off)))
 			return -EINVAL;
 		offset =3D __btf_member_bit_offset(n, member);
 		if (offset % 8)
 			return -EINVAL;
 		offset /=3D 8;
-		if (offset % __alignof__(struct bpf_list_node))
+		if (offset % node_type_align)
 			return -EINVAL;
=20
 		field->graph_root.btf =3D (struct btf *)btf;
@@ -3656,6 +3670,20 @@ static int btf_parse_list_head(const struct btf *b=
tf, struct btf_field *field,
 	return 0;
 }
=20
+static int btf_parse_list_head(const struct btf *btf, struct btf_field *=
field,
+			       struct btf_field_info *info)
+{
+	return btf_parse_graph_root(btf, field, info, "bpf_list_node",
+					    __alignof__(struct bpf_list_node));
+}
+
+static int btf_parse_rb_root(const struct btf *btf, struct btf_field *fi=
eld,
+			     struct btf_field_info *info)
+{
+	return btf_parse_graph_root(btf, field, info, "bpf_rb_node",
+					    __alignof__(struct bpf_rb_node));
+}
+
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct =
btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
@@ -3718,7 +3746,13 @@ struct btf_record *btf_parse_fields(const struct b=
tf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_RB_ROOT:
+			ret =3D btf_parse_rb_root(btf, &rec->fields[i], &info_arr[i]);
+			if (ret < 0)
+				goto end;
+			break;
 		case BPF_LIST_NODE:
+		case BPF_RB_NODE:
 			break;
 		default:
 			ret =3D -EFAULT;
@@ -3727,8 +3761,9 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
 		rec->cnt++;
 	}
=20
-	/* bpf_list_head requires bpf_spin_lock */
-	if (btf_record_has_field(rec, BPF_LIST_HEAD) && rec->spin_lock_off < 0)=
 {
+	/* bpf_{list_head, rb_node} require bpf_spin_lock */
+	if ((btf_record_has_field(rec, BPF_LIST_HEAD) ||
+	     btf_record_has_field(rec, BPF_RB_ROOT)) && rec->spin_lock_off < 0)=
 {
 		ret =3D -EINVAL;
 		goto end;
 	}
@@ -3739,22 +3774,28 @@ struct btf_record *btf_parse_fields(const struct =
btf *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
=20
+#define GRAPH_ROOT_MASK (BPF_LIST_HEAD | BPF_RB_ROOT)
+#define GRAPH_NODE_MASK (BPF_LIST_NODE | BPF_RB_NODE)
+
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record =
*rec)
 {
 	int i;
=20
-	/* There are two owning types, kptr_ref and bpf_list_head. The former
-	 * only supports storing kernel types, which can never store references
-	 * to program allocated local types, atleast not yet. Hence we only nee=
d
-	 * to ensure that bpf_list_head ownership does not form cycles.
+	/* There are three types that signify ownership of some other type:
+	 *  kptr_ref, bpf_list_head, bpf_rb_root.
+	 * kptr_ref only supports storing kernel types, which can't store
+	 * references to program allocated local types.
+	 *
+	 * Hence we only need to ensure that bpf_{list_head,rb_root} ownership
+	 * does not form cycles.
 	 */
-	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & BPF_LIST_HEAD))
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & GRAPH_ROOT_MASK))
 		return 0;
 	for (i =3D 0; i < rec->cnt; i++) {
 		struct btf_struct_meta *meta;
 		u32 btf_id;
=20
-		if (!(rec->fields[i].type & BPF_LIST_HEAD))
+		if (!(rec->fields[i].type & GRAPH_ROOT_MASK))
 			continue;
 		btf_id =3D rec->fields[i].graph_root.value_btf_id;
 		meta =3D btf_find_struct_meta(btf, btf_id);
@@ -3762,39 +3803,47 @@ int btf_check_and_fixup_fields(const struct btf *=
btf, struct btf_record *rec)
 			return -EFAULT;
 		rec->fields[i].graph_root.value_rec =3D meta->record;
=20
-		if (!(rec->field_mask & BPF_LIST_NODE))
+		/* We need to set value_rec for all root types, but no need
+		 * to check ownership cycle for a type unless it's also a
+		 * node type.
+		 */
+		if (!(rec->field_mask & GRAPH_NODE_MASK))
 			continue;
=20
 		/* We need to ensure ownership acyclicity among all types. The
 		 * proper way to do it would be to topologically sort all BTF
 		 * IDs based on the ownership edges, since there can be multiple
-		 * bpf_list_head in a type. Instead, we use the following
-		 * reasoning:
+		 * bpf_{list_head,rb_node} in a type. Instead, we use the
+		 * following resaoning:
 		 *
 		 * - A type can only be owned by another type in user BTF if it
-		 *   has a bpf_list_node.
+		 *   has a bpf_{list,rb}_node. Let's call these node types.
 		 * - A type can only _own_ another type in user BTF if it has a
-		 *   bpf_list_head.
+		 *   bpf_{list_head,rb_root}. Let's call these root types.
 		 *
-		 * We ensure that if a type has both bpf_list_head and
-		 * bpf_list_node, its element types cannot be owning types.
+		 * We ensure that if a type is both a root and node, its
+		 * element types cannot be root types.
 		 *
 		 * To ensure acyclicity:
 		 *
-		 * When A only has bpf_list_head, ownership chain can be:
+		 * When A is an root type but not a node, its ownership
+		 * chain can be:
 		 *	A -> B -> C
 		 * Where:
-		 * - B has both bpf_list_head and bpf_list_node.
-		 * - C only has bpf_list_node.
+		 * - A is an root, e.g. has bpf_rb_root.
+		 * - B is both a root and node, e.g. has bpf_rb_node and
+		 *   bpf_list_head.
+		 * - C is only an root, e.g. has bpf_list_node
 		 *
-		 * When A has both bpf_list_head and bpf_list_node, some other
-		 * type already owns it in the BTF domain, hence it can not own
-		 * another owning type through any of the bpf_list_head edges.
+		 * When A is both a root and node, some other type already
+		 * owns it in the BTF domain, hence it can not own
+		 * another root type through any of the ownership edges.
 		 *	A -> B
 		 * Where:
-		 * - B only has bpf_list_node.
+		 * - A is both an root and node.
+		 * - B is only an node.
 		 */
-		if (meta->record->field_mask & BPF_LIST_HEAD)
+		if (meta->record->field_mask & GRAPH_ROOT_MASK)
 			return -ELOOP;
 	}
 	return 0;
@@ -5256,6 +5305,8 @@ static const char *alloc_obj_fields[] =3D {
 	"bpf_spin_lock",
 	"bpf_list_head",
 	"bpf_list_node",
+	"bpf_rb_root",
+	"bpf_rb_node",
 };
=20
 static struct btf_struct_metas *
@@ -5329,7 +5380,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log=
, struct btf *btf)
=20
 		type =3D &tab->types[tab->cnt];
 		type->btf_id =3D i;
-		record =3D btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BP=
F_LIST_NODE, t->size);
+		record =3D btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BP=
F_LIST_NODE |
+						  BPF_RB_ROOT | BPF_RB_NODE, t->size);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret =3D PTR_ERR_OR_ZERO(record) ?: -EFAULT;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2dae44581922..192184b5156e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1772,6 +1772,46 @@ void bpf_list_head_free(const struct btf_field *fi=
eld, void *list_head,
 	}
 }
=20
+/* Like rbtree_postorder_for_each_entry_safe, but 'pos' and 'n' are
+ * 'rb_node *', so field name of rb_node within containing struct is not
+ * needed.
+ *
+ * Since bpf_rb_tree's node type has a corresponding struct btf_field wi=
th
+ * graph_root.node_offset, it's not necessary to know field name
+ * or type of node struct
+ */
+#define bpf_rbtree_postorder_for_each_entry_safe(pos, n, root) \
+	for (pos =3D rb_first_postorder(root); \
+	    pos && ({ n =3D rb_next_postorder(pos); 1; }); \
+	    pos =3D n)
+
+void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
+		      struct bpf_spin_lock *spin_lock)
+{
+	struct rb_root_cached orig_root, *root =3D rb_root;
+	struct rb_node *pos, *n;
+	void *obj;
+
+	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root)=
);
+	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bp=
f_rb_root));
+
+	__bpf_spin_lock_irqsave(spin_lock);
+	orig_root =3D *root;
+	*root =3D RB_ROOT_CACHED;
+	__bpf_spin_unlock_irqrestore(spin_lock);
+
+	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
+		obj =3D pos;
+		obj -=3D field->graph_root.node_offset;
+
+		bpf_obj_free_fields(field->graph_root.value_rec, obj);
+
+		migrate_disable();
+		bpf_mem_free(&bpf_global_ma, obj);
+		migrate_enable();
+	}
+}
+
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cda8d00f3762..e3fcdc9836a6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -537,9 +537,6 @@ void btf_record_free(struct btf_record *rec)
 		return;
 	for (i =3D 0; i < rec->cnt; i++) {
 		switch (rec->fields[i].type) {
-		case BPF_SPIN_LOCK:
-		case BPF_TIMER:
-			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			if (rec->fields[i].kptr.module)
@@ -548,7 +545,11 @@ void btf_record_free(struct btf_record *rec)
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_LIST_NODE:
-			/* Nothing to release for bpf_list_head */
+		case BPF_RB_ROOT:
+		case BPF_RB_NODE:
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			/* Nothing to release */
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -581,9 +582,6 @@ struct btf_record *btf_record_dup(const struct btf_re=
cord *rec)
 	new_rec->cnt =3D 0;
 	for (i =3D 0; i < rec->cnt; i++) {
 		switch (fields[i].type) {
-		case BPF_SPIN_LOCK:
-		case BPF_TIMER:
-			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			btf_get(fields[i].kptr.btf);
@@ -594,7 +592,11 @@ struct btf_record *btf_record_dup(const struct btf_r=
ecord *rec)
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_LIST_NODE:
-			/* Nothing to acquire for bpf_list_head */
+		case BPF_RB_ROOT:
+		case BPF_RB_NODE:
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			/* Nothing to acquire */
 			break;
 		default:
 			ret =3D -EFAULT;
@@ -674,7 +676,13 @@ void bpf_obj_free_fields(const struct btf_record *re=
c, void *obj)
 				continue;
 			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
+		case BPF_RB_ROOT:
+			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
+				continue;
+			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
+			break;
 		case BPF_LIST_NODE:
+		case BPF_RB_NODE:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -1010,7 +1018,8 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 		return -EINVAL;
=20
 	map->record =3D btf_parse_fields(btf, value_type,
-				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
+				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
+				       BPF_RB_ROOT,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1058,6 +1067,7 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 				}
 				break;
 			case BPF_LIST_HEAD:
+			case BPF_RB_ROOT:
 				if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
 				    map->map_type !=3D BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type !=3D BPF_MAP_TYPE_ARRAY) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f176bc15c879..4fd098851f43 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14703,9 +14703,10 @@ static int check_map_prog_compatibility(struct b=
pf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type =3D resolve_prog_type(prog);
=20
-	if (btf_record_has_field(map->record, BPF_LIST_HEAD)) {
+	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
+	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
 		if (is_tracing_prog_type(prog_type)) {
-			verbose(env, "tracing progs cannot use bpf_list_head yet\n");
+			verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n"=
);
 			return -EINVAL;
 		}
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 17afd2b35ee5..1503f61336b6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6917,6 +6917,17 @@ struct bpf_list_node {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+struct bpf_rb_root {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
+struct bpf_rb_node {
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index 2592b8aa5e41..c456b34a823a 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -58,12 +58,12 @@ static struct {
 	TEST(inner_map, pop_front)
 	TEST(inner_map, pop_back)
 #undef TEST
-	{ "map_compat_kprobe", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_kretprobe", "tracing progs cannot use bpf_list_head yet" =
},
-	{ "map_compat_tp", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_perf", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_raw_tp", "tracing progs cannot use bpf_list_head yet" },
-	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_list_head yet" }=
,
+	{ "map_compat_kprobe", "tracing progs cannot use bpf_{list_head,rb_root=
} yet" },
+	{ "map_compat_kretprobe", "tracing progs cannot use bpf_{list_head,rb_r=
oot} yet" },
+	{ "map_compat_tp", "tracing progs cannot use bpf_{list_head,rb_root} ye=
t" },
+	{ "map_compat_perf", "tracing progs cannot use bpf_{list_head,rb_root} =
yet" },
+	{ "map_compat_raw_tp", "tracing progs cannot use bpf_{list_head,rb_root=
} yet" },
+	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_{list_head,rb_ro=
ot} yet" },
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_M=
AX]" },
 	{ "obj_new_no_composite", "bpf_obj_new type ID argument must be of a st=
ruct" },
 	{ "obj_new_no_struct", "bpf_obj_new type ID argument must be of a struc=
t" },
--=20
2.30.2

