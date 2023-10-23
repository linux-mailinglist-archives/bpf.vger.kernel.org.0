Return-Path: <bpf+bounces-13059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DABB7D427E
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7802816C4
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BA23776;
	Mon, 23 Oct 2023 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rWyUGOnk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3D23758
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:00:59 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038D510C
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:56 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39NGk4dY010212
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bQ0SRCCLeLmBmt3dIr9VyvpsMlil8PiR94pFAktpJ2U=;
 b=rWyUGOnk7Z+hJ/lNKuRB3aj1jdxuRvxCnnUgAuo+shoabZ5h5EJB9bUmGLXi04E5sshX
 J1vDKxVG6yBNRgt39LbE89h0N/+OOVaykNzkn5FoCqO79StDkcXYO900/MUxQ7HaqYoU
 YrPd14RM4+yLRCVWOkdeaGznT7iIuq4VyFc= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3twkuhw6xn-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:55 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 23 Oct 2023 15:00:52 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 3624F2632D0D5; Mon, 23 Oct 2023 15:00:35 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 3/4] btf: Descend into structs and arrays during special field search
Date: Mon, 23 Oct 2023 15:00:29 -0700
Message-ID: <20231023220030.2556229-4-davemarchevsky@fb.com>
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
X-Proofpoint-ORIG-GUID: 2hhCc7X5ay2KQB4z-4mYj_kk_KOJnS9W
X-Proofpoint-GUID: 2hhCc7X5ay2KQB4z-4mYj_kk_KOJnS9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02

Structs and arrays are aggregate types which contain some inner
type(s) - members and elements - at various offsets. Currently, when
examining a struct or datasec for special fields, the verifier does
not look into the inner type of the structs or arrays it contains.
This patch adds logic to descend into struct and array types when
searching for special fields.

If we have struct x containing an array:

struct x {
  int a;
  u64 b[10];
};

we can construct some struct y with no array or struct members that
has the same types at the same offsets:

struct y {
  int a;
  u64 b1;
  u64 b2;
  /* ... */
  u64 b10;
};

Similarly for a struct containing a struct:

struct x {
  char a;
  struct {
    int b;
    u64 c;
  } inner;
};

there's a struct y with no aggregate members and same types/offsets:

struct y {
  char a;
  int inner_b __attribute__ ((aligned (8))); /* See [0] */
  u64 inner_c __attribute__ ((aligned (8)));
};

This patch takes advantage of this equivalence to 'flatten' the
field info found while descending into struct or array members into
the btf_field_info result array of the original type being examined.
The resultant btf_record of the original type being searched will
have the correct fields at the correct offsets, but without any
differentiation between "this field is one of my members" and "this
field is actually in my some struct / array member".

For now this descendant search logic looks for kptr fields only.

Implementation notes:
  * Search starts at btf_find_field - we're either looking at a struct
    that's the type of some mapval (btf_find_struct_field), or a
    datasec representing a .bss or .data map (btf_find_datasec_var).
    Newly-added btf_find_aggregate_field is a "disambiguation helper"
    like btf_find_field, but is meant to be called from one of the
    starting points of the search - btf_find_{struct_field,
    datasec_var}.
    * btf_find_aggregate_field may itself call btf_find_struct_field,
      so there's some recursive digging possible here

  * Newly-added btf_flatten_array_field handles array fields by
    finding the type of their element and continuing the dig based on
    elem type.

  [0]:  Structs have the alignment of their largest field, so the
        explicit alignment is necessary here. Luckily this patch's
        changes don't need to care about alignment / padding, since
	the BTF created during compilation is being searched, and
	it already has the correct information.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/btf.c | 151 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 142 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e999ba85c363..b982bf6fef9d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3496,9 +3496,41 @@ static int __struct_member_check_align(u32 off, en=
um btf_field_type field_type)
 	return 0;
 }
=20
+/* Return number of elems and elem_type of a btf_array
+ *
+ * If the array is multi-dimensional, return elem count of
+ * equivalent single-dimensional array
+ *   e.g. int x[10][10][10] has same layout as int x[1000]
+ */
+static u32 __multi_dim_elem_type_nelems(const struct btf *btf,
+					const struct btf_type *t,
+					const struct btf_type **elem_type)
+{
+	u32 nelems =3D btf_array(t)->nelems;
+
+	if (!nelems)
+		return 0;
+
+	*elem_type =3D btf_type_by_id(btf, btf_array(t)->type);
+
+	while (btf_type_is_array(*elem_type)) {
+		if (!btf_array(*elem_type)->nelems)
+			return 0;
+		nelems *=3D btf_array(*elem_type)->nelems;
+		*elem_type =3D btf_type_by_id(btf, btf_array(*elem_type)->type);
+	}
+	return nelems;
+}
+
+static int btf_find_aggregate_field(const struct btf *btf,
+				    const struct btf_type *t,
+				    struct btf_field_info_search *srch,
+				    int field_off, int rec);
+
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t,
-				 struct btf_field_info_search *srch)
+				 struct btf_field_info_search *srch,
+				 int struct_field_off, int rec)
 {
 	const struct btf_member *member;
 	int ret, field_type;
@@ -3522,10 +3554,24 @@ static int btf_find_struct_field(const struct btf=
 *btf,
 			 * checks, all ptrs have same align.
 			 * btf_maybe_find_kptr will find actual kptr type
 			 */
-			if (__struct_member_check_align(off, BPF_KPTR_REF))
+			if (srch->field_mask & BPF_KPTR &&
+			    !__struct_member_check_align(off, BPF_KPTR_REF)) {
+				ret =3D btf_maybe_find_kptr(btf, member_type,
+							  struct_field_off + off,
+							  srch);
+				if (ret < 0)
+					return ret;
+				if (ret =3D=3D BTF_FIELD_FOUND)
+					continue;
+			}
+
+			if (!(btf_type_is_array(member_type) ||
+			      __btf_type_is_struct(member_type)))
 				continue;
=20
-			ret =3D btf_maybe_find_kptr(btf, member_type, off, srch);
+			ret =3D btf_find_aggregate_field(btf, member_type, srch,
+						       struct_field_off + off,
+						       rec);
 			if (ret < 0)
 				return ret;
 			continue;
@@ -3541,15 +3587,17 @@ static int btf_find_struct_field(const struct btf=
 *btf,
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
-			ret =3D btf_find_struct(btf, member_type, off, sz, field_type,
-					      srch);
+			ret =3D btf_find_struct(btf, member_type,
+					      struct_field_off + off,
+					      sz, field_type, srch);
 			if (ret < 0)
 				return ret;
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
 			ret =3D btf_find_graph_root(btf, t, member_type,
-						  i, off, sz, srch, field_type);
+						  i, struct_field_off + off, sz,
+						  srch, field_type);
 			if (ret < 0)
 				return ret;
 			break;
@@ -3566,6 +3614,82 @@ static int btf_find_struct_field(const struct btf =
*btf,
 	return srch->idx;
 }
=20
+static int btf_flatten_array_field(const struct btf *btf,
+				   const struct btf_type *t,
+				   struct btf_field_info_search *srch,
+				   int array_field_off, int rec)
+{
+	int ret, start_idx, elem_field_cnt;
+	const struct btf_type *elem_type;
+	struct btf_field_info *info;
+	u32 i, j, off, nelems;
+
+	if (!btf_type_is_array(t))
+		return -EINVAL;
+	nelems =3D __multi_dim_elem_type_nelems(btf, t, &elem_type);
+	if (!nelems || !__btf_type_is_struct(elem_type))
+		return srch->idx;
+
+	start_idx =3D srch->idx;
+	ret =3D btf_find_struct_field(btf, elem_type, srch, array_field_off + o=
ff, rec);
+	if (ret < 0)
+		return ret;
+
+	/* No btf_field_info's added */
+	if (srch->idx =3D=3D start_idx)
+		return srch->idx;
+
+	elem_field_cnt =3D srch->idx - start_idx;
+	info =3D __next_field_infos(srch, elem_field_cnt * (nelems - 1));
+	if (IS_ERR_OR_NULL(info))
+		return PTR_ERR(info);
+
+	/* Array elems after the first can copy first elem's btf_field_infos
+	 * and adjust offset
+	 */
+	for (i =3D 1; i < nelems; i++) {
+		memcpy(info, &srch->infos[start_idx],
+		       elem_field_cnt * sizeof(struct btf_field_info));
+		for (j =3D 0; j < elem_field_cnt; j++) {
+			info->off +=3D (i * elem_type->size);
+			info++;
+		}
+	}
+	return srch->idx;
+}
+
+static int btf_find_aggregate_field(const struct btf *btf,
+				    const struct btf_type *t,
+				    struct btf_field_info_search *srch,
+				    int field_off, int rec)
+{
+	u32 orig_field_mask;
+	int ret;
+
+	/* Dig up to 4 levels deep */
+	if (rec >=3D 4)
+		return -E2BIG;
+
+	orig_field_mask =3D srch->field_mask;
+	srch->field_mask &=3D BPF_KPTR;
+
+	if (!srch->field_mask) {
+		ret =3D 0;
+		goto reset_field_mask;
+	}
+
+	if (__btf_type_is_struct(t))
+		ret =3D btf_find_struct_field(btf, t, srch, field_off, rec + 1);
+	else if (btf_type_is_array(t))
+		ret =3D btf_flatten_array_field(btf, t, srch, field_off, rec + 1);
+	else
+		ret =3D -EINVAL;
+
+reset_field_mask:
+	srch->field_mask =3D orig_field_mask;
+	return ret;
+}
+
 static int __datasec_vsi_check_align_sz(const struct btf_var_secinfo *vs=
i,
 					enum btf_field_type field_type,
 					u32 expected_sz)
@@ -3605,10 +3729,19 @@ static int btf_find_datasec_var(const struct btf =
*btf, const struct btf_type *t,
 			 * btf_maybe_find_kptr will find actual kptr type
 			 */
 			sz =3D btf_field_type_size(BPF_KPTR_REF);
-			if (__datasec_vsi_check_align_sz(vsi, BPF_KPTR_REF, sz))
+			if (srch->field_mask & BPF_KPTR &&
+			    !__datasec_vsi_check_align_sz(vsi, BPF_KPTR_REF, sz)) {
+				ret =3D btf_maybe_find_kptr(btf, var_type, off, srch);
+				if (ret < 0)
+					return ret;
+				if (ret =3D=3D BTF_FIELD_FOUND)
+					continue;
+			}
+
+			if (!(btf_type_is_array(var_type) || __btf_type_is_struct(var_type)))
 				continue;
=20
-			ret =3D btf_maybe_find_kptr(btf, var_type, off, srch);
+			ret =3D btf_find_aggregate_field(btf, var_type, srch, off, 0);
 			if (ret < 0)
 				return ret;
 			continue;
@@ -3655,7 +3788,7 @@ static int btf_find_field(const struct btf *btf, co=
nst struct btf_type *t,
 			  struct btf_field_info_search *srch)
 {
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, srch);
+		return btf_find_struct_field(btf, t, srch, 0, 0);
 	else if (btf_type_is_datasec(t))
 		return btf_find_datasec_var(btf, t, srch);
 	return -EINVAL;
--=20
2.34.1


