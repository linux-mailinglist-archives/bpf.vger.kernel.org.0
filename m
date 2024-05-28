Return-Path: <bpf+bounces-30718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E568D1B32
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3094FB29BE0
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8919716D9A8;
	Tue, 28 May 2024 12:24:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C862140E37
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899091; cv=none; b=qo3Itdk8hZzXUxFnfFpuJ3EITUaXkUgaKEXh9hfdwCcExvoc4JnOAU09lmS9SqTUHWdo9rWHxahpIhVO1qhbnLQB+FhlXfpnOFl3a9M13ywCSsulxE4TqCzgfhFBjVHGN57FDZFTh9CTVfXQH/FzGS8+CJ72tE4RfeTAgMNV/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899091; c=relaxed/simple;
	bh=OR8NeHNiaoJGqUZA6nftzJ/pnnGXIGPkSg+yXtJghTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPO98LqSXKxQmve7wqO7N/hRpMP4mxRlmgBYT3XvDNO4o7DwwT0upuNJoAmF26ZRLElFCMVN3hNjitcIlMKjg2m20pNlaTorM7MUi13DzDDNnPo9wooT65XOPjKE8WbjnebcL+O89xUqMoYI6PDY5Zrqxsvs8TOv0D2NA0h9f4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBn1da031918;
	Tue, 28 May 2024 12:24:21 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DmgZBVtW54tjB1fL8A7w7BKRn5y9DNrNSBUP1mpucHVI=3D;_b=3DCnnD5R0l?=
 =?UTF-8?Q?ku6mHazYODdnHLAifSSovXT7yJTRyqhT+zQA2xcFZlohCfRKCv1bwTV8jLsZ_tS?=
 =?UTF-8?Q?8KKEpJiVyXZcICTMbYYD/YaYFOsxUuxeae8/uw9rtJTS/BxlyBz59A07BCUQfBn?=
 =?UTF-8?Q?9Ba_xxHn8BfaSyLGctCfBroO69O5DjD/7rv02KWPm7ZDx8kaR1Gfsr1s8RvTF9A?=
 =?UTF-8?Q?l2BPPcXqt_4dtQi5sxNPSqvmgKlef+W02aahZPiscKVUGCsCsErljXGqWmp0ax2?=
 =?UTF-8?Q?TXNv073ixguuK/w_gadmK+/tSXGau+iKNNT4sIjRZq9aNXWQzypOKiKrXZLt24p?=
 =?UTF-8?Q?Q4dDa5nxhb4QBscQvUOfB_Hg=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9m73s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SC1ud0037288;
	Tue, 28 May 2024 12:24:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5359yq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SCNlJP022297;
	Tue, 28 May 2024 12:24:19 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-164-70.vpn.oracle.com [10.175.164.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc5359yey-2;
	Tue, 28 May 2024 12:24:19 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 1/9] libbpf: add btf__distill_base() creating split BTF with distilled base BTF
Date: Tue, 28 May 2024 13:24:00 +0100
Message-Id: <20240528122408.3154936-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240528122408.3154936-1-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_08,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280093
X-Proofpoint-GUID: zHYab3pcDaYLbMjW9set_HqPZUS7bO_d
X-Proofpoint-ORIG-GUID: zHYab3pcDaYLbMjW9set_HqPZUS7bO_d

To support more robust split BTF, adding supplemental context for the
base BTF type ids that split BTF refers to is required.  Without such
references, a simple shuffling of base BTF type ids (without any other
significant change) invalidates the split BTF.  Here the attempt is made
to store additional context to make split BTF more robust.

This context comes in the form of distilled base BTF providing minimal
information (name and - in some cases - size) for base INTs, FLOATs,
STRUCTs, UNIONs, ENUMs and ENUM64s along with modified split BTF that
points at that base and contains any additional types needed (such as
TYPEDEF, PTR and anonymous STRUCT/UNION declarations).  This
information constitutes the minimal BTF representation needed to
disambiguate or remove split BTF references to base BTF.  The rules
are as follows:

- INT, FLOAT, FWD are recorded in full.
- if a named base BTF STRUCT or UNION is referred to from split BTF, it
  will be encoded as a zero-member sized STRUCT/UNION (preserving
  size for later relocation checks).  Only base BTF STRUCT/UNIONs
  that are either embedded in split BTF STRUCT/UNIONs or that have
  multiple STRUCT/UNION instances of the same name will _need_ size
  checks at relocation time, but as it is possible a different set of
  types will be duplicates in the later to-be-resolved base BTF,
  we preserve size information for all named STRUCT/UNIONs.
- if an ENUM[64] is named, a ENUM forward representation (an ENUM
  with no values) of the same size is used.
- in all other cases, the type is added to the new split BTF.

Avoiding struct/union/enum/enum64 expansion is important to keep the
distilled base BTF representation to a minimum size.

When successful, new representations of the distilled base BTF and new
split BTF that refers to it are returned.  Both need to be freed by the
caller.

So to take a simple example, with split BTF with a type referring
to "struct sk_buff", we will generate distilled base BTF with a
0-member STRUCT sk_buff of the appropriate size, and the split BTF
will refer to it instead.

Tools like pahole can utilize such split BTF to populate the .BTF
section (split BTF) and an additional .BTF.base section.  Then
when the split BTF is loaded, the distilled base BTF can be used
to relocate split BTF to reference the current (and possibly changed)
base BTF.

So for example if "struct sk_buff" was id 502 when the split BTF was
originally generated,  we can use the distilled base BTF to see that
id 502 refers to a "struct sk_buff" and replace instances of id 502
with the current (relocated) base BTF sk_buff type id.

Distilled base BTF is small; when building a kernel with all modules
using distilled base BTF as a test, overall module size grew by only
5.3Mb total across ~2700 modules.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 302 ++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h      |  21 +++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 318 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..9f68268e659a 100644
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
@@ -5212,3 +5218,287 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
 
 	return 0;
 }
+
+struct btf_distill {
+	struct btf_pipe pipe;
+	int *id_map;
+	unsigned int split_start_id;
+	unsigned int split_start_str;
+	int diff_id;
+};
+
+static int btf_add_distilled_type_ids(__u32 *id, void *ctx)
+{
+	struct btf_distill *dist = ctx;
+	struct btf_type *t = btf_type_by_id(dist->pipe.src, *id);
+
+	if (!*id)
+		return 0;
+	/* split BTF id, not needed */
+	if (*id >= dist->split_start_id)
+		return 0;
+	/* already added ? */
+	if (dist->id_map[*id] > 0)
+		return 0;
+
+	/* only a subset of base BTF types should be referenced from split
+	 * BTF; ensure nothing unexpected is referenced.
+	 */
+	switch (btf_kind(t)) {
+	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_FWD:
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
+	case BTF_KIND_TYPE_TAG:
+		dist->id_map[*id] = *id;
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
+	 * into members.  For anonymous struct/unions, we may need their
+	 * member types.
+	 */
+	if (btf_is_composite(t) && t->name_off)
+		return 0;
+
+	/* ensure references in type are added also. */
+	return btf_type_visit_type_ids(t, btf_add_distilled_type_ids, ctx);
+}
+
+static int btf_add_distilled_types(struct btf_distill *dist)
+{
+	bool adding_to_base = dist->pipe.dst->start_id == 1;
+	int id = btf__type_cnt(dist->pipe.dst);
+	struct btf_type *t;
+	int i, err = 0;
+
+	/* Add types for each of the required references to either distilled
+	 * base or split BTF, depending on type characteristics.
+	 */
+	for (i = 1; i < dist->split_start_id; i++) {
+		const char *name;
+		int kind;
+
+		if (!dist->id_map[i])
+			continue;
+		t = btf_type_by_id(dist->pipe.src, i);
+		kind = btf_kind(t);
+		name = btf__name_by_offset(dist->pipe.src, t->name_off);
+
+		switch (kind) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_FWD:
+			/* Named int, float, fwd are added to base. */
+			if (!adding_to_base)
+				continue;
+			err = btf_add_type(&dist->pipe, t);
+			break;
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			/* Named struct/union are added to base as 0-vlen
+			 * struct/union of same size.  Anonymous struct/unions
+			 * are added to split BTF as-is.
+			 */
+			if (adding_to_base) {
+				if (!t->name_off)
+					continue;
+				err = btf_add_composite(dist->pipe.dst, kind, name, t->size);
+			} else {
+				if (t->name_off)
+					continue;
+				err = btf_add_type(&dist->pipe, t);
+			}
+			break;
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			/* Named enum[64]s are added to base as a sized
+			 * enum; relocation will match with appropriately-named
+			 * and sized enum or enum64.
+			 *
+			 * Anonymous enums are added to split BTF as-is.
+			 */
+			if (adding_to_base) {
+				if (!t->name_off)
+					continue;
+				err = btf__add_enum(dist->pipe.dst, name, t->size);
+			} else {
+				if (t->name_off)
+					continue;
+				err = btf_add_type(&dist->pipe, t);
+			}
+			break;
+		case BTF_KIND_ARRAY:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_PTR:
+		case BTF_KIND_CONST:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_FUNC_PROTO:
+		case BTF_KIND_TYPE_TAG:
+			/* All other types are added to split BTF. */
+			if (adding_to_base)
+				continue;
+			err = btf_add_type(&dist->pipe, t);
+			break;
+		default:
+			pr_warn("unexpected kind when adding base type '%s'[%u] of kind [%u] to distilled base BTF.\n",
+				name, i, kind);
+			return -EINVAL;
+
+		}
+		if (err < 0)
+			break;
+		dist->id_map[i] = id++;
+	}
+	return err;
+}
+
+/* Split BTF ids without a mapping will be shifted downwards since distilled
+ * base BTF is smaller than the original base BTF.  For those that have a
+ * mapping (either to base or updated split BTF), update the id based on
+ * that mapping.
+ */
+static int btf_update_distilled_type_ids(__u32 *id, void *ctx)
+{
+	struct btf_distill *dist = ctx;
+
+	if (dist->id_map[*id])
+		*id = dist->id_map[*id];
+	else if (*id >= dist->split_start_id)
+		*id -= dist->diff_id;
+	return 0;
+}
+
+/* Create updated split BTF with distilled base BTF; distilled base BTF
+ * consists of BTF information required to clarify the types that split
+ * BTF refers to, omitting unneeded details.  Specifically it will contain
+ * base types and memberless definitions of named structs, unions and enumerated
+ * types. Associated reference types like pointers, arrays and anonymous
+ * structs, unions and enumerated types will be added to split BTF.
+ * Size is recorded for named struct/unions to help guide matching to the
+ * target base BTF during later relocation.
+ *
+ * The only case where structs, unions or enumerated types are fully represented
+ * is when they are anonymous; in such cases, the anonymous type is added to
+ * split BTF in full.
+ *
+ * We return newly-created split BTF where the split BTF refers to a newly-created
+ * distilled base BTF. Both must be freed separately by the caller.
+ */
+int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
+		      struct btf **new_split_btf)
+{
+	struct btf *new_base = NULL, *new_split = NULL;
+	const struct btf *old_base;
+	unsigned int n = btf__type_cnt(src_btf);
+	struct btf_distill dist = {};
+	struct btf_type *t;
+	int i, err = 0;
+
+	/* src BTF must be split BTF. */
+	old_base = btf__base_btf(src_btf);
+	if (!new_base_btf || !new_split_btf || !old_base)
+		return libbpf_err(-EINVAL);
+
+	new_base = btf__new_empty();
+	if (!new_base)
+		return libbpf_err(-ENOMEM);
+	dist.id_map = calloc(n, sizeof(*dist.id_map));
+	if (!dist.id_map) {
+		err = -ENOMEM;
+		goto done;
+	}
+	dist.pipe.src = src_btf;
+	dist.pipe.dst = new_base;
+	dist.pipe.str_off_map = hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
+	if (IS_ERR(dist.pipe.str_off_map)) {
+		err = -ENOMEM;
+		goto done;
+	}
+	dist.split_start_id = btf__type_cnt(old_base);
+	dist.split_start_str = old_base->hdr->str_len;
+
+	/* Pass over src split BTF; generate the list of base BTF type ids it
+	 * references; these will constitute our distilled BTF set to be
+	 * distributed over base and split BTF as appropriate.
+	 */
+	for (i = src_btf->start_id; i < n; i++) {
+		t = btf_type_by_id(src_btf, i);
+		err = btf_type_visit_type_ids(t,  btf_add_distilled_type_ids, &dist);
+		if (err < 0)
+			goto done;
+	}
+	/* Next add types for each of the required references to base BTF and split BTF
+	 * in turn.
+	 */
+	err = btf_add_distilled_types(&dist);
+	if (err < 0)
+		goto done;
+
+	/* Create new split BTF with distilled base BTF as its base; the final
+	 * state is split BTF with distilled base BTF that represents enough
+	 * about its base references to allow it to be relocated with the base
+	 * BTF available.
+	 */
+	new_split = btf__new_empty_split(new_base);
+	if (!new_split_btf) {
+		err = -errno;
+		goto done;
+	}
+	dist.pipe.dst = new_split;
+	/* First add all split types */
+	for (i = src_btf->start_id; i < n; i++) {
+		t = btf_type_by_id(src_btf, i);
+		err = btf_add_type(&dist.pipe, t);
+		if (err < 0)
+			goto done;
+	}
+	/* Now add distilled types to split BTF that are not added to base. */
+	err = btf_add_distilled_types(&dist);
+	if (err < 0)
+		goto done;
+
+	/* All split BTF ids will be shifted downwards since there are less base
+	 * BTF ids in distilled base BTF.
+	 */
+	dist.diff_id = dist.split_start_id - btf__type_cnt(new_base);
+
+	n = btf__type_cnt(new_split);
+	/* Now update base/split BTF ids. */
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(new_split, i);
+
+		err = btf_type_visit_type_ids(t, btf_update_distilled_type_ids, &dist);
+		if (err < 0)
+			goto done;
+	}
+done:
+	free(dist.id_map);
+	hashmap__free(dist.pipe.str_off_map);
+	if (err) {
+		btf__free(new_split);
+		btf__free(new_base);
+		return libbpf_err(err);
+	}
+	*new_base_btf = new_base;
+	*new_split_btf = new_split;
+
+	return 0;
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..cb08ee9a5a10 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -107,6 +107,27 @@ LIBBPF_API struct btf *btf__new_empty(void);
  */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
+/**
+ * @brief **btf__distill_base()** creates new versions of the split BTF
+ * *src_btf* and its base BTF. The new base BTF will only contain the types
+ * needed to improve robustness of the split BTF to small changes in base BTF.
+ * When that split BTF is loaded against a (possibly changed) base, this
+ * distilled base BTF will help update references to that (possibly changed)
+ * base BTF.
+ *
+ * Both the new split and its associated new base BTF must be freed by
+ * the caller.
+ *
+ * If successful, 0 is returned and **new_base_btf** and **new_split_btf**
+ * will point at new base/split BTF. Both the new split and its associated
+ * new base BTF must be freed by the caller.
+ *
+ * A negative value is returned on error and the thread-local `errno` variable
+ * is set to the error code as well.
+ */
+LIBBPF_API int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
+				 struct btf **new_split_btf);
+
 LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
 LIBBPF_API struct btf *btf__parse_split(const char *path, struct btf *base_btf);
 LIBBPF_API struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c1ce8aa3520b..9e69d6e2a512 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -419,6 +419,7 @@ LIBBPF_1.4.0 {
 
 LIBBPF_1.5.0 {
 	global:
+		btf__distill_base;
 		bpf_program__attach_sockmap;
 		ring__consume_n;
 		ring_buffer__consume_n;
-- 
2.31.1


