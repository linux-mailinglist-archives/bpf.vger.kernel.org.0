Return-Path: <bpf+bounces-13057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 825997D427D
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B1BB20CB4
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8D241E0;
	Mon, 23 Oct 2023 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MrxVQ45V"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A81859
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:00:47 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C1310C8
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:43 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NF6YMG031036
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=oZOLPD2rM92DmYgETMB+DdoR7lO+mCygsBERnN4P08c=;
 b=MrxVQ45Vxck1KVANsT0/99FPfZn8NEIiEE5uPBPOSM1Th7ofTYPGDP8GIKAUq32SND0Z
 eZmp7D9X5HqNE2J/vuJykZD2MGWEpfnk2o1+I93wi3j9QII5Jk2n6Bn4f1136tPG/c6C
 ep+9l1FIGchTM0hMdy9MHcORO+njp96Y9iE= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3twu662weu-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:42 -0700
Received: from twshared5508.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 23 Oct 2023 15:00:40 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 94D1B2632D0CA; Mon, 23 Oct 2023 15:00:34 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 2/4] bpf: Refactor btf_find_field with btf_field_info_search
Date: Mon, 23 Oct 2023 15:00:28 -0700
Message-ID: <20231023220030.2556229-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023220030.2556229-1-davemarchevsky@fb.com>
References: <20231023220030.2556229-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Nr0OzvCXCa88rotxZ11cfngsakRzdphv
X-Proofpoint-GUID: Nr0OzvCXCa88rotxZ11cfngsakRzdphv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02

btf_find_field takes (btf_type, special_field_types) and returns info
about the specific special fields in btf_type, in the form of an array
of struct btf_field info. The meat of this 'search for special fields'
process happens in btf_find_datasec_var and btf_find_struct_field
helpers: each member is examined and, if it's special, a struct
btf_field_info describing it is added to the return array. Indeed, any
function that might add to the output probably also looks at struct
members or datasec vars.

Most of the parameters passed around between helpers doing the search
can be grouped into two categories: "info about the output array" and
"info about which fields to search for". This patch joins those together
in struct btf_field_info_search, simplifying the signatures of most
helpers involved in the search, including array flattening helper that
later patches in the series will add.

The aforementioned array flattening logic will greatly increase the
number of btf_field_info's needed to describe some structs, so this
patch also turns the statically-sized struct btf_field_info
info_arr[BTF_FIELDS_MAX] into a growable array with a larger max size.

Implementation notes:
  * BTF_FIELDS_MAX is now max size of growable btf_field_info *infos
    instead of initial (and max) size of static result array
    * Static array before had 10 elems (+1 tmp btf_field_info)
    * growable array starts with 16 and doubles every time it needs to
      grow, up to BTF_FIELDS_MAX of 256

  * __next_field_infos is used with next_cnt > 1 later in the series

  * btf_find_{datasec_var, struct_field} have special logic for an edge
    case where the result array is full but the field being examined
    gets BTF_FIELD_IGNORE return from btf_find_{struct, kptr,graph_root}
    * If result wasn't BTF_FIELD_IGNORE, a btf_field_info would have to
      be added to the array. Since it is we can look at next field.
    * Before this patch the logic handling this edge case was hard to
      follow and used a tmp btf_struct_info. This patch moves the
      add-if-not-ignore logic down into btf_find_{struct, kptr,
      graph_root}, removing the need to opportunistically grab a
      btf_field_info to populate before knowing if it's actually
      necessary. Now a new one is grabbed only if the field shouldn't
      be ignored.

  * Within btf_find_{datasec_var, struct_field}, each member is
    currently examined in two phases: first btf_get_field_type checks
    the member type name, then btf_find_{struct,graph_root,kptr} do
    additional sanity checking and populate struct btf_field_info. Kptr
    fields don't have a specific type name, though, so
    btf_get_field_type assumes that - if we're looking for kptrs - any
    member that fails type name check could be a kptr field.
    * As a result btf_find_kptr effectively does all the pointer
      hopping, sanity checking, and info population. Instead of trying
      to fit kptr handling into this two-phase model, where it's
      unwieldy, handle it in a separate codepath when name matching
      fails.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h |   4 +-
 kernel/bpf/btf.c    | 331 +++++++++++++++++++++++++++++---------------
 2 files changed, 219 insertions(+), 116 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4825d3cdb29..e07cac5cc3cf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -171,8 +171,8 @@ struct bpf_map_ops {
 };
=20
 enum {
-	/* Support at most 10 fields in a BTF type */
-	BTF_FIELDS_MAX	   =3D 10,
+	/* Support at most 256 fields in a BTF type */
+	BTF_FIELDS_MAX	   =3D 256,
 };
=20
 enum btf_field_type {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 975ef8e73393..e999ba85c363 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3257,25 +3257,94 @@ struct btf_field_info {
 	};
 };
=20
+struct btf_field_info_search {
+	/* growable array. allocated in __next_field_infos
+	 * free'd in btf_parse_fields
+	 */
+	struct btf_field_info *infos;
+	/* size of infos */
+	int info_cnt;
+	/* index of next btf_field_info to populate */
+	int idx;
+
+	/* btf_field_types to search for */
+	u32 field_mask;
+	/* btf_field_types found earlier */
+	u32 seen_mask;
+};
+
+/* Reserve next_cnt contiguous btf_field_info's for caller to populate
+ * Returns ptr to first reserved btf_field_info
+ */
+static struct btf_field_info *__next_field_infos(struct btf_field_info_s=
earch *srch,
+						 u32 next_cnt)
+{
+	struct btf_field_info *new_infos, *ret;
+
+	if (!next_cnt)
+		return ERR_PTR(-EINVAL);
+
+	if (srch->idx + next_cnt < srch->info_cnt)
+		goto nogrow_out;
+
+	/* Need to grow */
+	if (srch->idx + next_cnt > BTF_FIELDS_MAX)
+		return ERR_PTR(-E2BIG);
+
+	while (srch->idx + next_cnt >=3D srch->info_cnt)
+		srch->info_cnt =3D srch->infos ? srch->info_cnt * 2 : 16;
+
+	new_infos =3D krealloc(srch->infos,
+			     srch->info_cnt * sizeof(struct btf_field_info),
+			     GFP_KERNEL | __GFP_NOWARN);
+	if (!new_infos)
+		return ERR_PTR(-ENOMEM);
+	srch->infos =3D new_infos;
+
+nogrow_out:
+	ret =3D &srch->infos[srch->idx];
+	srch->idx +=3D next_cnt;
+	return ret;
+}
+
+/* Request srch's next free btf_field_info to populate, possibly growing
+ * srch->infos
+ */
+static struct btf_field_info *__next_field_info(struct btf_field_info_se=
arch *srch)
+{
+	return __next_field_infos(srch, 1);
+}
+
 static int btf_find_struct(const struct btf *btf, const struct btf_type =
*t,
 			   u32 off, int sz, enum btf_field_type field_type,
-			   struct btf_field_info *info)
+			   struct btf_field_info_search *srch)
 {
+	struct btf_field_info *info;
+
 	if (!__btf_type_is_struct(t))
 		return BTF_FIELD_IGNORE;
 	if (t->size !=3D sz)
 		return BTF_FIELD_IGNORE;
+
+	info =3D __next_field_info(srch);
+	if (IS_ERR_OR_NULL(info))
+		return PTR_ERR(info);
+
 	info->type =3D field_type;
 	info->off =3D off;
 	return BTF_FIELD_FOUND;
 }
=20
-static int btf_find_kptr(const struct btf *btf, const struct btf_type *t=
,
-			 u32 off, int sz, struct btf_field_info *info)
+static int btf_maybe_find_kptr(const struct btf *btf, const struct btf_t=
ype *t,
+			       u32 off, struct btf_field_info_search *srch)
 {
+	struct btf_field_info *info;
 	enum btf_field_type type;
 	u32 res_id;
=20
+	if (!(srch->field_mask & BPF_KPTR))
+		return BTF_FIELD_IGNORE;
+
 	/* Permit modifiers on the pointer itself */
 	if (btf_type_is_volatile(t))
 		t =3D btf_type_by_id(btf, t->type);
@@ -3304,6 +3373,10 @@ static int btf_find_kptr(const struct btf *btf, co=
nst struct btf_type *t,
 	if (!__btf_type_is_struct(t))
 		return -EINVAL;
=20
+	info =3D __next_field_info(srch);
+	if (IS_ERR_OR_NULL(info))
+		return PTR_ERR(info);
+
 	info->type =3D type;
 	info->off =3D off;
 	info->kptr.type_id =3D res_id;
@@ -3340,9 +3413,10 @@ const char *btf_find_decl_tag_value(const struct b=
tf *btf, const struct btf_type
 static int
 btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 		    const struct btf_type *t, int comp_idx, u32 off,
-		    int sz, struct btf_field_info *info,
+		    int sz, struct btf_field_info_search *srch,
 		    enum btf_field_type head_type)
 {
+	struct btf_field_info *info;
 	const char *node_field_name;
 	const char *value_type;
 	s32 id;
@@ -3367,6 +3441,11 @@ btf_find_graph_root(const struct btf *btf, const s=
truct btf_type *pt,
 	node_field_name++;
 	if (str_is_empty(node_field_name))
 		return -EINVAL;
+
+	info =3D __next_field_info(srch);
+	if (IS_ERR_OR_NULL(info))
+		return PTR_ERR(info);
+
 	info->type =3D head_type;
 	info->off =3D off;
 	info->graph_root.value_btf_id =3D id;
@@ -3374,25 +3453,24 @@ btf_find_graph_root(const struct btf *btf, const =
struct btf_type *pt,
 	return BTF_FIELD_FOUND;
 }
=20
-#define field_mask_test_name(field_type, field_type_str)		\
-	if (field_mask & field_type && !strcmp(name, field_type_str)) {	\
-		type =3D field_type;					\
-		goto end;						\
+#define field_mask_test_name(field_type, field_type_str)			\
+	if (srch->field_mask & field_type && !strcmp(name, field_type_str)) {	\
+		return field_type;						\
 	}
=20
-#define field_mask_test_name_check_seen(field_type, field_type_str)	\
-	if (field_mask & field_type && !strcmp(name, field_type_str)) {	\
-		if (*seen_mask & field_type)				\
-			return -E2BIG;					\
-		*seen_mask |=3D field_type;				\
-		type =3D field_type;					\
-		goto end;						\
+#define field_mask_test_name_check_seen(field_type, field_type_str)		\
+	if (srch->field_mask & field_type && !strcmp(name, field_type_str)) {	\
+		if (srch->seen_mask & field_type)				\
+			return -E2BIG;						\
+		srch->seen_mask |=3D field_type;					\
+		return field_type;						\
 	}
=20
-static int btf_get_field_type(const char *name, u32 field_mask, u32 *see=
n_mask,
-			      int *align, int *sz)
+static int btf_get_field_type_by_name(const struct btf *btf,
+				      const struct btf_type *t,
+				      struct btf_field_info_search *srch)
 {
-	int type =3D 0;
+	const char *name =3D __btf_name_by_offset(btf, t->name_off);
=20
 	field_mask_test_name_check_seen(BPF_SPIN_LOCK, "bpf_spin_lock");
 	field_mask_test_name_check_seen(BPF_TIMER,     "bpf_timer");
@@ -3403,47 +3481,58 @@ static int btf_get_field_type(const char *name, u=
32 field_mask, u32 *seen_mask,
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
 	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
=20
-	/* Only return BPF_KPTR when all other types with matchable names fail =
*/
-	if (field_mask & BPF_KPTR) {
-		type =3D BPF_KPTR_REF;
-		goto end;
-	}
 	return 0;
-end:
-	*sz =3D btf_field_type_size(type);
-	*align =3D btf_field_type_align(type);
-	return type;
 }
=20
 #undef field_mask_test_name_check_seen
 #undef field_mask_test_name
=20
+static int __struct_member_check_align(u32 off, enum btf_field_type fiel=
d_type)
+{
+	u32 align =3D btf_field_type_align(field_type);
+
+	if (off % align)
+		return -EINVAL;
+	return 0;
+}
+
 static int btf_find_struct_field(const struct btf *btf,
-				 const struct btf_type *t, u32 field_mask,
-				 struct btf_field_info *info, int info_cnt)
+				 const struct btf_type *t,
+				 struct btf_field_info_search *srch)
 {
-	int ret, idx =3D 0, align, sz, field_type;
 	const struct btf_member *member;
-	struct btf_field_info tmp;
-	u32 i, off, seen_mask =3D 0;
+	int ret, field_type;
+	u32 i, off, sz;
=20
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type =3D btf_type_by_id(btf,
 								    member->type);
-
-		field_type =3D btf_get_field_type(__btf_name_by_offset(btf, member_typ=
e->name_off),
-						field_mask, &seen_mask, &align, &sz);
-		if (field_type =3D=3D 0)
-			continue;
-		if (field_type < 0)
-			return field_type;
-
 		off =3D __btf_member_bit_offset(t, member);
 		if (off % 8)
 			/* valid C code cannot generate such BTF */
 			return -EINVAL;
 		off /=3D 8;
-		if (off % align)
+
+		field_type =3D btf_get_field_type_by_name(btf, member_type, srch);
+		if (field_type < 0)
+			return field_type;
+
+		if (field_type =3D=3D 0) {
+			/* Maybe it's a kptr. Use BPF_KPTR_REF for align
+			 * checks, all ptrs have same align.
+			 * btf_maybe_find_kptr will find actual kptr type
+			 */
+			if (__struct_member_check_align(off, BPF_KPTR_REF))
+				continue;
+
+			ret =3D btf_maybe_find_kptr(btf, member_type, off, srch);
+			if (ret < 0)
+				return ret;
+			continue;
+		}
+
+		sz =3D btf_field_type_size(field_type);
+		if (__struct_member_check_align(off, field_type))
 			continue;
=20
 		switch (field_type) {
@@ -3453,64 +3542,81 @@ static int btf_find_struct_field(const struct btf=
 *btf,
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
 			ret =3D btf_find_struct(btf, member_type, off, sz, field_type,
-					      idx < info_cnt ? &info[idx] : &tmp);
-			if (ret < 0)
-				return ret;
-			break;
-		case BPF_KPTR_UNREF:
-		case BPF_KPTR_REF:
-		case BPF_KPTR_PERCPU:
-			ret =3D btf_find_kptr(btf, member_type, off, sz,
-					    idx < info_cnt ? &info[idx] : &tmp);
+					      srch);
 			if (ret < 0)
 				return ret;
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
 			ret =3D btf_find_graph_root(btf, t, member_type,
-						  i, off, sz,
-						  idx < info_cnt ? &info[idx] : &tmp,
-						  field_type);
+						  i, off, sz, srch, field_type);
 			if (ret < 0)
 				return ret;
 			break;
+		/* kptr fields are not handled in this switch, see
+		 * btf_maybe_find_kptr above
+		 */
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
 		default:
 			return -EFAULT;
 		}
-
-		if (ret =3D=3D BTF_FIELD_IGNORE)
-			continue;
-		if (idx >=3D info_cnt)
-			return -E2BIG;
-		++idx;
 	}
-	return idx;
+	return srch->idx;
+}
+
+static int __datasec_vsi_check_align_sz(const struct btf_var_secinfo *vs=
i,
+					enum btf_field_type field_type,
+					u32 expected_sz)
+{
+	u32 off, align;
+
+	off =3D vsi->offset;
+	align =3D btf_field_type_align(field_type);
+
+	if (vsi->size !=3D expected_sz)
+		return -EINVAL;
+	if (off % align)
+		return -EINVAL;
+
+	return 0;
 }
=20
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_=
type *t,
-				u32 field_mask, struct btf_field_info *info,
-				int info_cnt)
+				struct btf_field_info_search *srch)
 {
-	int ret, idx =3D 0, align, sz, field_type;
 	const struct btf_var_secinfo *vsi;
-	struct btf_field_info tmp;
-	u32 i, off, seen_mask =3D 0;
+	int ret, field_type;
+	u32 i, off, sz;
=20
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var =3D btf_type_by_id(btf, vsi->type);
 		const struct btf_type *var_type =3D btf_type_by_id(btf, var->type);
=20
-		field_type =3D btf_get_field_type(__btf_name_by_offset(btf, var_type->=
name_off),
-						field_mask, &seen_mask, &align, &sz);
-		if (field_type =3D=3D 0)
-			continue;
+		off =3D vsi->offset;
+		field_type =3D btf_get_field_type_by_name(btf, var_type, srch);
 		if (field_type < 0)
 			return field_type;
=20
-		off =3D vsi->offset;
-		if (vsi->size !=3D sz)
+		if (field_type =3D=3D 0) {
+			/* Maybe it's a kptr. Use BPF_KPTR_REF for sz / align
+			 * checks, all ptrs have same sz / align.
+			 * btf_maybe_find_kptr will find actual kptr type
+			 */
+			sz =3D btf_field_type_size(BPF_KPTR_REF);
+			if (__datasec_vsi_check_align_sz(vsi, BPF_KPTR_REF, sz))
+				continue;
+
+			ret =3D btf_maybe_find_kptr(btf, var_type, off, srch);
+			if (ret < 0)
+				return ret;
 			continue;
-		if (off % align)
+		}
+
+		sz =3D btf_field_type_size(field_type);
+
+		if (__datasec_vsi_check_align_sz(vsi, field_type, sz))
 			continue;
=20
 		switch (field_type) {
@@ -3520,48 +3626,38 @@ static int btf_find_datasec_var(const struct btf =
*btf, const struct btf_type *t,
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
 			ret =3D btf_find_struct(btf, var_type, off, sz, field_type,
-					      idx < info_cnt ? &info[idx] : &tmp);
-			if (ret < 0)
-				return ret;
-			break;
-		case BPF_KPTR_UNREF:
-		case BPF_KPTR_REF:
-		case BPF_KPTR_PERCPU:
-			ret =3D btf_find_kptr(btf, var_type, off, sz,
-					    idx < info_cnt ? &info[idx] : &tmp);
+					      srch);
 			if (ret < 0)
 				return ret;
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
 			ret =3D btf_find_graph_root(btf, var, var_type,
-						  -1, off, sz,
-						  idx < info_cnt ? &info[idx] : &tmp,
+						  -1, off, sz, srch,
 						  field_type);
 			if (ret < 0)
 				return ret;
 			break;
+		/* kptr fields are not handled in this switch, see
+		 * btf_maybe_find_kptr above
+		 */
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
 		default:
 			return -EFAULT;
 		}
-
-		if (ret =3D=3D BTF_FIELD_IGNORE)
-			continue;
-		if (idx >=3D info_cnt)
-			return -E2BIG;
-		++idx;
 	}
-	return idx;
+	return srch->idx;
 }
=20
 static int btf_find_field(const struct btf *btf, const struct btf_type *=
t,
-			  u32 field_mask, struct btf_field_info *info,
-			  int info_cnt)
+			  struct btf_field_info_search *srch)
 {
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, field_mask, info, info_cnt);
+		return btf_find_struct_field(btf, t, srch);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt);
+		return btf_find_datasec_var(btf, t, srch);
 	return -EINVAL;
 }
=20
@@ -3729,47 +3825,51 @@ static int btf_field_cmp(const void *_a, const vo=
id *_b, const void *priv)
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct =
btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
-	struct btf_field_info info_arr[BTF_FIELDS_MAX];
+	struct btf_field_info_search srch;
 	u32 next_off =3D 0, field_type_size;
+	struct btf_field_info *info;
 	struct btf_record *rec;
 	int ret, i, cnt;
=20
-	ret =3D btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_ar=
r));
-	if (ret < 0)
-		return ERR_PTR(ret);
-	if (!ret)
-		return NULL;
+	memset(&srch, 0, sizeof(srch));
+	srch.field_mask =3D field_mask;
+	ret =3D btf_find_field(btf, t, &srch);
+	if (ret <=3D 0)
+		goto end_srch;
=20
 	cnt =3D ret;
 	/* This needs to be kzalloc to zero out padding and unused fields, see
 	 * comment in btf_record_equal.
 	 */
 	rec =3D kzalloc(offsetof(struct btf_record, fields[cnt]), GFP_KERNEL | =
__GFP_NOWARN);
-	if (!rec)
-		return ERR_PTR(-ENOMEM);
+	if (!rec) {
+		ret =3D -ENOMEM;
+		goto end_srch;
+	}
=20
 	rec->spin_lock_off =3D -EINVAL;
 	rec->timer_off =3D -EINVAL;
 	rec->refcount_off =3D -EINVAL;
 	for (i =3D 0; i < cnt; i++) {
-		field_type_size =3D btf_field_type_size(info_arr[i].type);
-		if (info_arr[i].off + field_type_size > value_size) {
-			WARN_ONCE(1, "verifier bug off %d size %d", info_arr[i].off, value_si=
ze);
+		info =3D &srch.infos[i];
+		field_type_size =3D btf_field_type_size(info->type);
+		if (info->off + field_type_size > value_size) {
+			WARN_ONCE(1, "verifier bug off %d size %d", info->off, value_size);
 			ret =3D -EFAULT;
 			goto end;
 		}
-		if (info_arr[i].off < next_off) {
+		if (info->off < next_off) {
 			ret =3D -EEXIST;
 			goto end;
 		}
-		next_off =3D info_arr[i].off + field_type_size;
+		next_off =3D info->off + field_type_size;
=20
-		rec->field_mask |=3D info_arr[i].type;
-		rec->fields[i].offset =3D info_arr[i].off;
-		rec->fields[i].type =3D info_arr[i].type;
+		rec->field_mask |=3D info->type;
+		rec->fields[i].offset =3D info->off;
+		rec->fields[i].type =3D info->type;
 		rec->fields[i].size =3D field_type_size;
=20
-		switch (info_arr[i].type) {
+		switch (info->type) {
 		case BPF_SPIN_LOCK:
 			WARN_ON_ONCE(rec->spin_lock_off >=3D 0);
 			/* Cache offset for faster lookup at runtime */
@@ -3788,17 +3888,17 @@ struct btf_record *btf_parse_fields(const struct =
btf *btf, const struct btf_type
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
-			ret =3D btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
+			ret =3D btf_parse_kptr(btf, &rec->fields[i], info);
 			if (ret < 0)
 				goto end;
 			break;
 		case BPF_LIST_HEAD:
-			ret =3D btf_parse_list_head(btf, &rec->fields[i], &info_arr[i]);
+			ret =3D btf_parse_list_head(btf, &rec->fields[i], info);
 			if (ret < 0)
 				goto end;
 			break;
 		case BPF_RB_ROOT:
-			ret =3D btf_parse_rb_root(btf, &rec->fields[i], &info_arr[i]);
+			ret =3D btf_parse_rb_root(btf, &rec->fields[i], info);
 			if (ret < 0)
 				goto end;
 			break;
@@ -3828,10 +3928,13 @@ struct btf_record *btf_parse_fields(const struct =
btf *btf, const struct btf_type
=20
 	sort_r(rec->fields, rec->cnt, sizeof(struct btf_field), btf_field_cmp,
 	       NULL, rec);
+	kfree(srch.infos);
=20
 	return rec;
 end:
 	btf_record_free(rec);
+end_srch:
+	kfree(srch.infos);
 	return ERR_PTR(ret);
 }
=20
--=20
2.34.1


