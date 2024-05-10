Return-Path: <bpf+bounces-29456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2928A8C2233
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974871F23CDD
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D988004A;
	Fri, 10 May 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PdkchoEO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4155C3B
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337193; cv=none; b=a01w1d+9Ubx2gdM9Ma7R/v1mV0GHux/d6n8GBMfCxaBNJYSRQgn9aGsOk3NF5MUMeLpT4hKdmdHfHxauasf58ADKkVBkMcuUgXi8CZQFUD0SJ1+XMvVgHglOtQN+aweO901Ek5rQU4rBWfSl/PVpiWYaqrdPjL1dzjM4JvYkcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337193; c=relaxed/simple;
	bh=Vkhnbm9YakwwMiUNS8J2o3GMq5Jo/AKxZ5erQkzcbnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPnRZCcHnTybLfr3sJHLxbL8LMkOOqRTxG+sXLxsfN1dtK8ZmrPhGXcCRhvGlKaknOw7/dHv+aSz2ueZZDQlYjxgHbE/98vmOUL9YvPOcx8PpQ2BMPFs8zEjvQT7ggiBA3RL9UYVJXiZUc0PVP/vLdIykiieNVHCMxK4GogkLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PdkchoEO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AAWgCj015434;
	Fri, 10 May 2024 10:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=8M29G8Ns7/gvJIhUFbEZ8l73MJEcMhbsL4RGWETlEvA=;
 b=PdkchoEOn86Y2sd/HIYbTVtYhmvPFN9dWOK1o03O8QjSlt2Gmo2WzqZCSMdtebXCPgoZ
 XpQl3yvJFw69C0sUfpZAiV4nCLWJ3NIL7iZW/ZNAlkoiXR5rA7408IjBRmL1leRU+wPL
 IRdNqLjuw+2F6LgTvDqoxbdsEYcEbzWABRQ1SCMe28tXU22b9VTOnSQQPkj151r8CXs8
 ke2BlmEKPPm4NAJvG82frzx17OTmszv4V4ACVsp2I9rXoWJqby8hVu5mldcCXYbFdvXW
 76+/mNUouk3PoIpYmr4hbmmdysAQ019a6p9Jy4kJ0kvYminaCwKqJvUAgKnR4dVd8u7k ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1f4x0c4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:32:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A9Mx0Z019119;
	Fri, 10 May 2024 10:31:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpcmje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:31:06 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAV0hT011786;
	Fri, 10 May 2024 10:31:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-199.vpn.oracle.com [10.175.161.199])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpcm4p-2;
	Fri, 10 May 2024 10:31:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 01/11] libbpf: add btf__distill_base() creating split BTF with distilled base BTF
Date: Fri, 10 May 2024 11:30:42 +0100
Message-Id: <20240510103052.850012-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240510103052.850012-1-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100074
X-Proofpoint-GUID: oNNwPGN7S97RpvHiyhohibNCIINxZmXn
X-Proofpoint-ORIG-GUID: oNNwPGN7S97RpvHiyhohibNCIINxZmXn

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

- INT, FLOAT are recorded in full.
- if a named base BTF STRUCT or UNION is referred to from split BTF, it
  will be encoded either as a zero-member sized STRUCT/UNION (preserving
  size for later relocation checks) or as a named FWD.  Only base BTF
  STRUCT/UNIONs that are embedded in split BTF STRUCT/UNIONs need to
  preserve size information, so a FWD representation will be used in
  most cases.
- if an ENUM[64] is named, a ENUM forward representation (an ENUM
  with no values) is used.
- in all other cases, the type is added to the new split BTF.

Avoiding struct/union/enum/enum64 expansion is important to keep the
distilled base BTF representation to a minimum size.

When successful, new representations of the distilled base BTF and new
split BTF that refers to it are returned.  Both need to be freed by the
caller.

So to take a simple example, with split BTF with a type referring
to "struct sk_buff", we will generate distilled base BTF with a
FWD struct sk_buff, and the split BTF will refer to it instead.

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
using distilled base BTF as a test, ovreall module size grew by only
5.3Mb total across ~2700 modules.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 346 ++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h      |  20 +++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 361 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..65abd555fa36 100644
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
@@ -5212,3 +5218,331 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
 
 	return 0;
 }
+
+#define BTF_EMBEDDED_COMPOSITE	(1 << 31)	/* flag set if struct/union is embedded */
+#define BTF_ID(id)		(id & ~BTF_EMBEDDED_COMPOSITE)
+
+struct btf_distill {
+	struct btf_pipe pipe;
+	int *ids;
+	unsigned int split_start_id;
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
+		case BTF_KIND_TYPE_TAG:
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
+			dist->ids[next_id] |= BTF_EMBEDDED_COMPOSITE;
+			return 0;
+		default:
+			return 0;
+		}
+
+	} while (1);
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
+	int err;
+
+	if (!*id)
+		return 0;
+	/* split BTF id, not needed */
+	if (*id >= dist->split_start_id)
+		return 0;
+	/* already added ? */
+	if (BTF_ID(dist->ids[*id]) > 0)
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
+		dist->ids[*id] |= *id;
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
+	err = btf_type_visit_type_ids(t, btf_add_distilled_type_ids, ctx);
+	if (err < 0)
+		return err;
+	return 0;
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
+		if (!BTF_ID(dist->ids[i]))
+			continue;
+		t = btf_type_by_id(dist->pipe.src, i);
+		kind = btf_kind(t);
+		name = btf__name_by_offset(dist->pipe.src, t->name_off);
+
+		/* Named int, float, fwd struct, union, enum[64] are added to
+		 * base; everything else is added to split BTF.
+		 */
+		switch (kind) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_FWD:
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			if ((adding_to_base && !t->name_off) || (!adding_to_base && t->name_off))
+				continue;
+			break;
+		default:
+			if (adding_to_base)
+				continue;
+			break;
+		}
+		if (dist->ids[i] & BTF_EMBEDDED_COMPOSITE) {
+			/* If a named struct/union in base BTF is referenced as a type
+			 * in split BTF without use of a pointer - i.e. as an embedded
+			 * struct/union - add an empty struct/union preserving size
+			 * since size must be consistent when relocating split and
+			 * possibly changed base BTF.
+			 */
+			err = btf_add_composite(dist->pipe.dst, kind, name, t->size);
+		} else if (btf_is_eligible_named_fwd(t)) {
+			/* If not embedded, use a fwd for named struct/unions since we
+			 * can match via name without any other details.
+			 */
+			switch (kind) {
+			case BTF_KIND_STRUCT:
+				err = btf__add_fwd(dist->pipe.dst, name, BTF_FWD_STRUCT);
+				break;
+			case BTF_KIND_UNION:
+				err = btf__add_fwd(dist->pipe.dst, name, BTF_FWD_UNION);
+				break;
+			case BTF_KIND_ENUM:
+				err = btf__add_enum(dist->pipe.dst, name, sizeof(int));
+				break;
+			case BTF_KIND_ENUM64:
+				err = btf__add_enum(dist->pipe.dst, name, sizeof(__u64));
+				break;
+			default:
+				pr_warn("unexpected kind [%u] when creating distilled base BTF.\n",
+					btf_kind(t));
+				return -EINVAL;
+			}
+		} else {
+			err = btf_add_type(&dist->pipe, t);
+		}
+		if (err < 0)
+			break;
+		dist->ids[i] = id++;
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
+	if (BTF_ID(dist->ids[*id]))
+		*id = BTF_ID(dist->ids[*id]);
+	else if (*id >= dist->split_start_id)
+		*id -= dist->diff_id;
+	return 0;
+}
+
+/* Create updated split BTF with distilled base BTF; distilled base BTF
+ * consists of BTF information required to clarify the types that split
+ * BTF refers to, omitting unneeded details.  Specifically it will contain
+ * base types and forward declarations of named structs, unions and enumerated
+ * types. Associated reference types like pointers, arrays and anonymous
+ * structs, unions and enumerated types will be added to split BTF.
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
+	unsigned int n = btf__type_cnt(src_btf);
+	struct btf_distill dist = {};
+	struct btf_type *t;
+	int i, err = 0;
+
+	/* src BTF must be split BTF. */
+	if (!new_base_btf || !new_split_btf || !btf__base_btf(src_btf))
+		return libbpf_err(-EINVAL);
+
+	new_base = btf__new_empty();
+	if (!new_base)
+		return libbpf_err(-ENOMEM);
+	dist.ids = calloc(n, sizeof(*dist.ids));
+	if (!dist.ids) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	dist.pipe.src = src_btf;
+	dist.pipe.dst = new_base;
+	dist.pipe.str_off_map = hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
+	if (IS_ERR(dist.pipe.str_off_map)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	dist.split_start_id = btf__type_cnt(btf__base_btf(src_btf));
+
+	/* Pass over src split BTF; generate the list of base BTF
+	 * type ids it references; these will constitute our distilled
+	 * BTF set to be distributed over base and split BTF as appropriate.
+	 */
+	for (i = src_btf->start_id; i < n; i++) {
+		t = btf_type_by_id(src_btf, i);
+
+		/* check if members of struct/union in split BTF refer to base BTF
+		 * struct/union; if so, we will use an empty sized struct to represent
+		 * it rather than a FWD because its size must match on later BTF
+		 * relocation.
+		 */
+		if (btf_is_composite(t)) {
+			err = btf_type_visit_type_ids(t, btf_find_embedded_composite_type_ids,
+						      &dist);
+			if (err < 0)
+				goto err_out;
+		}
+		err = btf_type_visit_type_ids(t,  btf_add_distilled_type_ids, &dist);
+		if (err < 0)
+			goto err_out;
+	}
+	/* Next add types for each of the required references to base BTF and split BTF in turn. */
+	err = btf_add_distilled_types(&dist);
+	if (err < 0)
+		goto err_out;
+	/* now create new split BTF with distilled base BTF as its base; we end up with
+	 * split BTF that has base BTF that represents enough about its base references
+	 * to allow it to be relocated with the base BTF available.
+	 */
+	new_split = btf__new_empty_split(new_base);
+	if (!new_split_btf) {
+		err = -errno;
+		goto err_out;
+	}
+	dist.pipe.dst = new_split;
+	/* First add all split types */
+	for (i = src_btf->start_id; i < n; i++) {
+		t = btf_type_by_id(src_btf, i);
+		err = btf_add_type(&dist.pipe, t);
+		if (err < 0)
+			goto err_out;
+	}
+	/* Now add distilled types to split BTF that are not added to base. */
+	err = btf_add_distilled_types(&dist);
+	if (err < 0)
+		goto err_out;
+
+	/* all split BTF ids will be shifted downwards since there are less base BTF ids
+	 * in distilled base BTF.
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
+			goto err_out;
+	}
+	free(dist.ids);
+	hashmap__free(dist.pipe.str_off_map);
+	*new_base_btf = new_base;
+	*new_split_btf = new_split;
+	return 0;
+err_out:
+	free(dist.ids);
+	if (!IS_ERR(dist.pipe.str_off_map))
+		hashmap__free(dist.pipe.str_off_map);
+	btf__free(new_split);
+	btf__free(new_base);
+	return libbpf_err(err);
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..f3f149a09088 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -107,6 +107,26 @@ LIBBPF_API struct btf *btf__new_empty(void);
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
+ * A negative value is returned on error.
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


