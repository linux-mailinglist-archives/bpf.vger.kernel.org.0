Return-Path: <bpf+bounces-27693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3108B0EFA
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81062957AA
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9C15FA81;
	Wed, 24 Apr 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DfmJBUpF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43115FD07
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973729; cv=none; b=TqHYbMzU5ObQpVKyxRQHtc48dcPHJgj06U+VQalqlPCibhd+g+lsIUN2/RlFvhwkrpecJ4S0s103HBJt0KTKEV6uwMF6KzRiUTX3EdxWboGgl/JnxL0GRBZ4ZP/K4qHLhudCbVODFDWVM8aORV5jRCxOlUVgEaXtNjcJHxxwg5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973729; c=relaxed/simple;
	bh=8zJxa+4QpvDS8yI/O0OKbkk4m3YhafEaMoKP+ULJI/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEvDv7YtT3g7BeehsYc2iQ7UMjhdAbOT2bSACMIO/rR7wxldDWcQdaW0CMw0jF1g61cxk3diva11S9J4bVtJa2lMJUdT5nbsmkxePYIZy93YyxL/kaGBxi1pWF80artvYL5DXlU43zgMgRx7yb5Wl0quXAktkBCXhplPLtpA9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DfmJBUpF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OA7WEx023291;
	Wed, 24 Apr 2024 15:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=6KpLJCYkImANnhICCx+Igp525bhmqr5Aq1hg5Xq8pfk=;
 b=DfmJBUpFKXIgsX/7hOs4TJxCX1xXdF+bTOVaSFdl2HDWiNYqFNjw9H3JrDmgEgQOCB4u
 Eb91IJuNHnsgF4s2DTRnE1BHCHYTL5Xj7RoUaJd36A+2y8Oq3iDCvUdFxq7rmxjoSR3N
 oYieTzHqBFHu3x22/YlO8pnuIQnUvXVNF1KcOC9T9btzgmluG3YmpAQ2lDGBT4kKsQcI
 MXi0UzQ2hkLGCsWgIvK+W6NspaIhGVbIrMMFUgYHcHZvU7hpbLm/42wGfFsVxVdIw4ym
 DewM36t1GTSiUOshfsvyjDF49ofE/ARydLieYr67LjEnLc8ung6sjRgFIqH2O/duzCoO XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aurgtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OEs6xk025222;
	Wed, 24 Apr 2024 15:48:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fay6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCoS008769;
	Wed, 24 Apr 2024 15:48:22 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-3;
	Wed, 24 Apr 2024 15:48:22 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 02/13] libbpf: add btf__distill_base() creating split BTF with distilled base BTF
Date: Wed, 24 Apr 2024 16:47:55 +0100
Message-Id: <20240424154806.3417662-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-ORIG-GUID: FBNQm422YcssWjNfK0022YXzg6qPk-du
X-Proofpoint-GUID: FBNQm422YcssWjNfK0022YXzg6qPk-du

To support more robust split BTF, adding supplemental context for the
base BTF type ids that split BTF refers to is required.  Without such
references, a simple shuffling of base BTF type ids (without any other
significant change) invalidates the split BTF.  Here the attempt is made
to store additional context to make split BTF more robust.

This context comes in the form of distilled base BTF - this base BTF
constitutes the minimal BTF representation needed to disambiguate split BTF
references to base BTF.  The rules are as follows:

- INT, FLOAT are recorded in full.
- if a named base BTF STRUCT or UNION is referred to from split BTF, it
  will be encoded either as a zero-member sized STRUCT/UNION (preserving
  size for later relocation checks) or as a named FWD.  Only base BTF
  STRUCT/UNIONs that are embedded in split BTF STRUCT/UNIONs need to
  preserve size information, so a FWD representation will be used in
  most cases.
- if an ENUM[64] is named, a ENUM[64] forward representation (an ENUM[64]
  with no values) is used.
- if a STRUCT, UNION, ENUM or ENUM64 is not named, it is recorded in full.
- base BTF reference types like CONST, RESTRICT, TYPEDEF, PTR are recorded
  as-is.

Avoiding struct/union/enum/enum64 expansion is important to keep the
distilled base BTF representation to a minimum size; however anonymous
struct, union and enum[64] types are represented in full since type details
are needed to disambiguate the reference - the name is not enough in those
cases since there is no name.  In practice these are rare; in sample
cases where reference base BTF was generated for in-tree kernel modules,
only a few were needed in distilled base BTF.  These represent the
anonymous struct/unions that are used by the module but were de-duplicated
to use base vmlinux BTF ids instead.

When successful, new representations of the distilled base BTF and new
split BTF that refers to it are returned.  Both need to be freed by the
caller.

So to take a simple example, with split BTF with a type referring
to "struct sk_buff", we will generate base reference BTF with a
FWD struct sk_buff, and the split BTF will refer to it instead.

Tools like pahole can utilize such split BTF to popuate the .BTF section
(split BTF) and an additional .BTF.base section.
Then when the split BTF is loaded, the distilled base BTF can be used
to relocate split BTF to reference the current - and possibly changed -
base BTF.

So for example if "struct sk_buff" was id 502 when the split BTF was
originally generated,  we can use the distilled base BTF to see that
id 502 refers to a "struct sk_buff" and replace instances of id 502
with the current (relocated) base BTF sk_buff type id.

Distilled base BTF is small; when building a kernel with all modules
using distilled base BTF as a test, the average size for module
distilled base BTF is 1555 bytes (standard deviation 1563).  The
maximum distilled base BTF size across ~2700 modules was 37895 bytes.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 316 ++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h      |  20 +++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 331 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 44afae098369..419cc4fa2e86 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1771,9 +1771,8 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
 	return 0;
 }
 
-int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
+static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 {
-	struct btf_pipe p = { .src = src_btf, .dst = btf };
 	struct btf_type *t;
 	int sz, err;
 
@@ -1782,20 +1781,27 @@ int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_t
 		return libbpf_err(sz);
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
-	if (btf_ensure_modifiable(btf))
+	if (btf_ensure_modifiable(p->dst))
 		return libbpf_err(-ENOMEM);
 
-	t = btf_add_type_mem(btf, sz);
+	t = btf_add_type_mem(p->dst, sz);
 	if (!t)
 		return libbpf_err(-ENOMEM);
 
 	memcpy(t, src_type, sz);
 
-	err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
+	err = btf_type_visit_str_offs(t, btf_rewrite_str, p);
 	if (err)
 		return libbpf_err(err);
 
-	return btf_commit_type(btf, sz);
+	return btf_commit_type(p->dst, sz);
+}
+
+int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
+{
+	struct btf_pipe p = { .src = src_btf, .dst = btf };
+
+	return btf_add_type(&p, src_type);
 }
 
 static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
@@ -5217,3 +5223,301 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
 
 	return 0;
 }
+
+struct btf_distill_id {
+	int id;
+	bool embedded;		/* true if id refers to a struct/union in base BTF
+				 * that is embedded in a split BTF struct/union.
+				 */
+};
+
+struct btf_distill {
+	struct btf_pipe pipe;
+	struct btf_distill_id *ids;
+	__u32 query_id;
+	unsigned int nr_base_types;
+	unsigned int diff_id;
+};
+
+/* Check if a member of a split BTF struct/union refers to a base BTF
+ * struct/union.  Members can be const/restrict/volatile/typedef
+ * reference types, but if a pointer is encountered, type is no longer
+ * considered embedded.
+ */
+static int btf_find_embedded_composite_type_ids(__u32 *id, void *ctx)
+{
+	struct btf_distill *dist = ctx;
+	const struct btf_type *t;
+	__u32 next_id = *id;
+
+	do {
+		if (next_id == 0)
+			return 0;
+		t = btf_type_by_id(dist->pipe.src, next_id);
+		switch (btf_kind(t)) {
+		case BTF_KIND_CONST:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_TYPEDEF:
+			next_id = t->type;
+			break;
+		case BTF_KIND_ARRAY: {
+			struct btf_array *a = btf_array(t);
+
+			next_id = a->type;
+			break;
+		}
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			dist->ids[next_id].embedded = next_id > 0 &&
+						      next_id <= dist->nr_base_types;
+			return 0;
+		default:
+			return 0;
+		}
+
+	} while (next_id != 0);
+
+	return 0;
+}
+
+static bool btf_is_eligible_named_fwd(const struct btf_type *t)
+{
+	return (btf_is_composite(t) || btf_is_any_enum(t)) && t->name_off != 0;
+}
+
+static int btf_add_distilled_type_ids(__u32 *id, void *ctx)
+{
+	struct btf_distill *dist = ctx;
+	struct btf_type *t = btf_type_by_id(dist->pipe.src, *id);
+	int ret;
+
+	/* split BTF id, not needed */
+	if (*id > dist->nr_base_types)
+		return 0;
+	/* already added ? */
+	if (dist->ids[*id].id >= 0)
+		return 0;
+	dist->ids[*id].id = *id;
+
+	/* only a subset of base BTF types should be referenced from split
+	 * BTF; ensure nothing unexpected is referenced.
+	 */
+	switch (btf_kind(t)) {
+	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_ARRAY:
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+	case BTF_KIND_PTR:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_FUNC_PROTO:
+		break;
+	default:
+		pr_warn("unexpected reference to base type[%u] of kind [%u] when creating distilled base BTF.\n",
+			*id, btf_kind(t));
+		return -EINVAL;
+	}
+
+	/* struct/union members not needed, except for anonymous structs
+	 * and unions, which we need since name won't help us determine
+	 * matches; so if a named struct/union, no need to recurse
+	 * into members.
+	 */
+	if (btf_is_eligible_named_fwd(t))
+		return 0;
+
+	/* ensure references in type are added also. */
+	ret = btf_type_visit_type_ids(t, btf_add_distilled_type_ids, ctx);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+/* All split BTF ids will be shifted downwards since there are less base BTF
+ * in distilled base BTF, and for those that refer to base BTF, we use the
+ * reference map to map from original base BTF to distilled base BTF id.
+ */
+static int btf_update_distilled_type_ids(__u32 *id, void *ctx)
+{
+	struct btf_distill *dist = ctx;
+
+	if (*id >= dist->nr_base_types)
+		*id -= dist->diff_id;
+	else
+		*id = dist->ids[*id].id;
+	return 0;
+}
+
+/* Create updated /split BTF with distilled base BTF; distilled base BTF
+ * consists of BTF information required to clarify the types that split
+ * BTF refers to, omitting unneeded details.  Specifically it will contain
+ * base types and forward declarations of structs, unions and enumerated
+ * types, along with associated reference types like pointers, arrays etc.
+ *
+ * The only case where structs, unions or enumerated types are fully represented
+ * is when they are anonymous; in such cases, info about type content is needed
+ * to clarify type references.
+ *
+ * We return newly-created split BTF where the split BTf refers to a newly-created
+ * distilled base BTF. Both must be freed separately by the caller.
+ *
+ * When creating the BTF representation for a module and provided with the
+ * distilled_base option, pahole will create split BTF using this API, and store
+ * the distilled base BTF in the .BTF.base.distilled section.
+ */
+int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
+		      struct btf **new_split_btf)
+{
+	struct btf *new_base = NULL, *new_split = NULL;
+	unsigned int n = btf__type_cnt(src_btf);
+	struct btf_distill dist = {};
+	struct btf_type *t;
+	__u32 i, id = 0;
+	int ret = 0;
+
+	/* src BTF must be split BTF. */
+	if (!new_base_btf || !new_split_btf || !btf__base_btf(src_btf)) {
+		errno = EINVAL;
+		return -EINVAL;
+	}
+	new_base = btf__new_empty();
+	if (!new_base)
+		return -ENOMEM;
+	dist.ids = calloc(n, sizeof(*dist.ids));
+	if (!dist.ids) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+	for (i = 1; i < n; i++)
+		dist.ids[i].id = -1;
+	dist.pipe.src = src_btf;
+	dist.pipe.dst = new_base;
+	dist.pipe.str_off_map = hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
+	if (IS_ERR(dist.pipe.str_off_map)) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+	dist.nr_base_types = btf__type_cnt(btf__base_btf(src_btf));
+
+	/* Pass over src split BTF; generate the list of base BTF
+	 * type ids it references; these will constitute our distilled
+	 * base BTF set.
+	 */
+	for (i = src_btf->start_id; i < n; i++) {
+		t = (struct btf_type *)btf__type_by_id(src_btf, i);
+
+		/* check if members of struct/union in split BTF refer to base BTF
+		 * struct/union; if so, we will use an empty sized struct to represent
+		 * it rather than a FWD because its size must match on later BTF
+		 * relocation.
+		 */
+		if (btf_is_composite(t)) {
+			ret = btf_type_visit_type_ids(t, btf_find_embedded_composite_type_ids,
+						      &dist);
+			if (ret < 0)
+				goto err_out;
+		}
+		ret = btf_type_visit_type_ids(t,  btf_add_distilled_type_ids, &dist);
+		if (ret < 0)
+			goto err_out;
+	}
+	/* Next add types for each of the required references. */
+	for (i = 1; i < src_btf->start_id; i++) {
+		if (dist.ids[i].id < 0)
+			continue;
+		t = btf_type_by_id(src_btf, i);
+
+		if (dist.ids[i].embedded) {
+			/* If a named struct/union in base BTF is referenced as a type
+			 * in split BTF without use of a pointer - i.e. as an embedded
+			 * struct/union - add an empty struct/union preserving size
+			 * since size must be consistent when relocating split and
+			 * possibly changed base BTF.
+			 */
+			ret = btf_add_composite(new_base, btf_kind(t),
+						btf__name_by_offset(src_btf, t->name_off),
+						t->size);
+		} else if (btf_is_eligible_named_fwd(t)) {
+			enum btf_fwd_kind fwd_kind;
+
+			/* If not embedded, use a fwd for named struct/unions since we
+			 * can match via name without any other details.
+			 */
+			switch (btf_kind(t)) {
+			case BTF_KIND_STRUCT:
+				fwd_kind = BTF_FWD_STRUCT;
+				break;
+			case BTF_KIND_UNION:
+				fwd_kind = BTF_FWD_UNION;
+				break;
+			case BTF_KIND_ENUM:
+				fwd_kind = BTF_FWD_ENUM;
+				break;
+			case BTF_KIND_ENUM64:
+				fwd_kind = BTF_FWD_ENUM64;
+				break;
+			default:
+				pr_warn("unexpected kind [%u] when creating distilled base BTF.\n",
+					btf_kind(t));
+				goto err_out;
+			}
+			ret = btf__add_fwd(new_base, btf__name_by_offset(src_btf, t->name_off),
+					   fwd_kind);
+		} else {
+			ret = btf_add_type(&dist.pipe, t);
+		}
+		if (ret < 0)
+			goto err_out;
+		dist.ids[i].id = ++id;
+	}
+	/* now create new split BTF with distilled base BTF as its base; we end up with
+	 * split BTF that has base BTF that represents enough about its base references
+	 * to allow it to be relocated with the base BTF available.
+	 */
+	new_split = btf__new_empty_split(new_base);
+	if (!new_split_btf) {
+		ret = libbpf_get_error(new_split);
+		goto err_out;
+	}
+
+	dist.pipe.dst = new_split;
+	/* all split BTF ids will be shifted downwards since there are less base BTF ids
+	 * in distilled base BTF.
+	 */
+	dist.diff_id = dist.nr_base_types - btf__type_cnt(new_base);
+
+	/* First add all split types */
+	for (i = src_btf->start_id; i < n; i++) {
+		t = btf_type_by_id(src_btf, i);
+		ret = btf_add_type(&dist.pipe, t);
+		if (ret < 0)
+			goto err_out;
+	}
+	n = btf__type_cnt(new_split);
+	/* Now update base/split BTF ids. */
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(new_split, i);
+
+		ret = btf_type_visit_type_ids(t,  btf_update_distilled_type_ids, &dist);
+		if (ret < 0)
+			goto err_out;
+	}
+	free(dist.ids);
+	hashmap__free(dist.pipe.str_off_map);
+	*new_base_btf = new_base;
+	*new_split_btf = new_split;
+	return 0;
+err_out:
+	free(dist.ids);
+	hashmap__free(dist.pipe.str_off_map);
+	btf__free(new_split);
+	btf__free(new_base);
+	errno = -ret;
+	return ret;
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 47d3e00b25c7..025ed28b7fe8 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -107,6 +107,26 @@ LIBBPF_API struct btf *btf__new_empty(void);
  */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
+/**
+ * @brief **btf__distill_base()** creates new versions of the split BTF
+ * *src_btf* and its base BTF.  The new base BTF will only contain the types
+ * needed to improve robustness of the split BTF to small changes in base BTF.
+ * When that split BTF is loaded against a (possibly changed) base, this
+ * distilled base BTF will help update references to that (possibly changed)
+ * base BTF.
+ *
+ * Both the new split and its associated new base BTF must be freed by
+ * the caller.
+ *
+ * If successful, 0 is returned and **new_base_btf** and **new_split_btf**
+ * will point at new base/split BTF.  Both the new split and its associated
+ * new base BTF must be freed by the caller.
+ *
+ * A negative value is returned on error.
+ */
+LIBBPF_API int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
+				 struct btf **new_split_btf);
+
 LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
 LIBBPF_API struct btf *btf__parse_split(const char *path, struct btf *base_btf);
 LIBBPF_API struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c1ce8aa3520b..c4d9bd7d3220 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -420,6 +420,7 @@ LIBBPF_1.4.0 {
 LIBBPF_1.5.0 {
 	global:
 		bpf_program__attach_sockmap;
+		btf__distill_base;
 		ring__consume_n;
 		ring_buffer__consume_n;
 } LIBBPF_1.4.0;
-- 
2.31.1


