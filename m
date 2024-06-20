Return-Path: <bpf+bounces-32570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1901910020
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6955C1F222A0
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA719DF71;
	Thu, 20 Jun 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdfbCddM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3519DF6C
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875102; cv=none; b=ThxKpzGsvlX1RG8pFJZQ0b7jPlKbrXG6QieDoyCaDJ+D6dMRWvGpbsi70v9jC2uxKeGQe286DC4LjOC3mdqcvR9tpuUSTNhPt/ZL8aqJ9CA6r3AFrQfAi9gd34J+0Zth7Ek2BBrXPHYhtVbzmYoWFvgiw+7F44RkcI++ClRq188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875102; c=relaxed/simple;
	bh=E/180g0xF7dwOediP7E0OayJPSkH6c3YjmEAPp8EZ94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vyx3fmuc5FQ/5IoBug1w6YrQoKeR/tGlDQvg/8Hc2vh9ZvGd6JsQvZjFx3VwyndiJ+EXqBdHzFJZYn6Y11EWxa6/iMVZOzfD6vTFJxV6JvBSZ8WHOmGkJ0AD3icaXGDoSB9fvbS8B5zbwbID/Un79b7iaGi9Ro1RrcbVpRdzc9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JdfbCddM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5GFIH006627;
	Thu, 20 Jun 2024 09:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=V
	OKhFITiGAjpm/VDSd5ObvhNTzgrml4ujHZaysTv8Ag=; b=JdfbCddMcRGg7uyqT
	NcCAWGAWuID/y6X0guXbTre1eOLY9qM4LEpEfc8VbYCJZs3l0KEqvHVQ0afYLZ17
	5WKR7uJflfM8GB8AIIrjOPWUwbYh3ywJ4nfS2wJ48iuvcU/ZhGOyv7tq5riV+3b0
	jnU4Un8GEsIG6rwTh+eLyP6ry1G+TcBDIPhYBlR37l9oBA655swDL8kdBX9QGrki
	dP2YZo9MvqjVuw50ft7sv5g9E+Dl3l04h3KXhiYMcEUOm8OJZJEagQpFKcv53WIS
	ElMkrlFhuInCZJj6t4hv/Dn7myWnFzh7kK3mfaUTrBtbmz3gNI9kIC4cG4Zs3HaB
	mGkUQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9jargj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:17:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45K7MeJQ031869;
	Thu, 20 Jun 2024 09:17:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1da769h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:17:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45K9HdGF028275;
	Thu, 20 Jun 2024 09:17:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-186-70.vpn.oracle.com [10.175.186.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1da764t-2;
	Thu, 20 Jun 2024 09:17:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH v2 bpf-next 1/6] libbpf: BTF relocation followup fixing naming, loop logic
Date: Thu, 20 Jun 2024 10:17:28 +0100
Message-ID: <20240620091733.1967885-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620091733.1967885-1-alan.maguire@oracle.com>
References: <20240620091733.1967885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200065
X-Proofpoint-GUID: QV5vnaNIIpg2bgHMnaZq8Ga4ONDZQf8C
X-Proofpoint-ORIG-GUID: QV5vnaNIIpg2bgHMnaZq8Ga4ONDZQf8C

Use less verbose names in BTF relocation code and fix off-by-one error
and typo in btf_relocate.c.  Simplify loop over matching distilled
types, moving from assigning a _next value in loop body to moving
match check conditions into the guard.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_relocate.c | 72 ++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index eabb8755f662..23a41fb03e0d 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -160,7 +160,7 @@ static int btf_mark_embedded_composite_type_ids(struct btf_relocate *r, __u32 i)
  */
 static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 {
-	struct btf_name_info *dist_base_info_sorted, *dist_base_info_sorted_end;
+	struct btf_name_info *info, *info_end;
 	struct btf_type *base_t, *dist_t;
 	__u8 *base_name_cnt = NULL;
 	int err = 0;
@@ -169,26 +169,24 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 	/* generate a sort index array of name/type ids sorted by name for
 	 * distilled base BTF to speed name-based lookups.
 	 */
-	dist_base_info_sorted = calloc(r->nr_dist_base_types, sizeof(*dist_base_info_sorted));
-	if (!dist_base_info_sorted) {
+	info = calloc(r->nr_dist_base_types, sizeof(*info));
+	if (!info) {
 		err = -ENOMEM;
 		goto done;
 	}
-	dist_base_info_sorted_end = dist_base_info_sorted + r->nr_dist_base_types;
+	info_end = info + r->nr_dist_base_types;
 	for (id = 0; id < r->nr_dist_base_types; id++) {
 		dist_t = btf_type_by_id(r->dist_base_btf, id);
-		dist_base_info_sorted[id].name = btf__name_by_offset(r->dist_base_btf,
-								     dist_t->name_off);
-		dist_base_info_sorted[id].id = id;
-		dist_base_info_sorted[id].size = dist_t->size;
-		dist_base_info_sorted[id].needs_size = true;
+		info[id].name = btf__name_by_offset(r->dist_base_btf, dist_t->name_off);
+		info[id].id = id;
+		info[id].size = dist_t->size;
+		info[id].needs_size = true;
 	}
-	qsort(dist_base_info_sorted, r->nr_dist_base_types, sizeof(*dist_base_info_sorted),
-	      cmp_btf_name_size);
+	qsort(info, r->nr_dist_base_types, sizeof(*info), cmp_btf_name_size);
 
 	/* Mark distilled base struct/union members of split BTF structs/unions
 	 * in id_map with BTF_IS_EMBEDDED; this signals that these types
-	 * need to match both name and size, otherwise embeddding the base
+	 * need to match both name and size, otherwise embedding the base
 	 * struct/union in the split type is invalid.
 	 */
 	for (id = r->nr_dist_base_types; id < r->nr_split_types; id++) {
@@ -216,8 +214,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 
 	/* Now search base BTF for matching distilled base BTF types. */
 	for (id = 1; id < r->nr_base_types; id++) {
-		struct btf_name_info *dist_name_info, *dist_name_info_next = NULL;
-		struct btf_name_info base_name_info = {};
+		struct btf_name_info *dist_info, base_info = {};
 		int dist_kind, base_kind;
 
 		base_t = btf_type_by_id(r->base_btf, id);
@@ -225,16 +222,16 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 		if (!base_t->name_off)
 			continue;
 		base_kind = btf_kind(base_t);
-		base_name_info.id = id;
-		base_name_info.name = btf__name_by_offset(r->base_btf, base_t->name_off);
+		base_info.id = id;
+		base_info.name = btf__name_by_offset(r->base_btf, base_t->name_off);
 		switch (base_kind) {
 		case BTF_KIND_INT:
 		case BTF_KIND_FLOAT:
 		case BTF_KIND_ENUM:
 		case BTF_KIND_ENUM64:
 			/* These types should match both name and size */
-			base_name_info.needs_size = true;
-			base_name_info.size = base_t->size;
+			base_info.needs_size = true;
+			base_info.size = base_t->size;
 			break;
 		case BTF_KIND_FWD:
 			/* No size considerations for fwds. */
@@ -248,31 +245,24 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 			 * unless corresponding _base_ types to match them are
 			 * missing.
 			 */
-			base_name_info.needs_size = base_name_cnt[base_t->name_off] > 1;
-			base_name_info.size = base_t->size;
+			base_info.needs_size = base_name_cnt[base_t->name_off] > 1;
+			base_info.size = base_t->size;
 			break;
 		default:
 			continue;
 		}
 		/* iterate over all matching distilled base types */
-		for (dist_name_info = search_btf_name_size(&base_name_info, dist_base_info_sorted,
-							   r->nr_dist_base_types);
-		     dist_name_info != NULL; dist_name_info = dist_name_info_next) {
-			/* Are there more distilled matches to process after
-			 * this one?
-			 */
-			dist_name_info_next = dist_name_info + 1;
-			if (dist_name_info_next >= dist_base_info_sorted_end ||
-			    cmp_btf_name_size(&base_name_info, dist_name_info_next))
-				dist_name_info_next = NULL;
-
-			if (!dist_name_info->id || dist_name_info->id > r->nr_dist_base_types) {
+		for (dist_info = search_btf_name_size(&base_info, info, r->nr_dist_base_types);
+		     dist_info != NULL && dist_info < info_end &&
+		     cmp_btf_name_size(&base_info, dist_info) == 0;
+		     dist_info++) {
+			if (!dist_info->id || dist_info->id >= r->nr_dist_base_types) {
 				pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\n",
-					id, dist_name_info->id);
+					id, dist_info->id);
 				err = -EINVAL;
 				goto done;
 			}
-			dist_t = btf_type_by_id(r->dist_base_btf, dist_name_info->id);
+			dist_t = btf_type_by_id(r->dist_base_btf, dist_info->id);
 			dist_kind = btf_kind(dist_t);
 
 			/* Validate that the found distilled type is compatible.
@@ -319,15 +309,15 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 				/* size verification is required for embedded
 				 * struct/unions.
 				 */
-				if (r->id_map[dist_name_info->id] == BTF_IS_EMBEDDED &&
+				if (r->id_map[dist_info->id] == BTF_IS_EMBEDDED &&
 				    base_t->size != dist_t->size)
 					continue;
 				break;
 			default:
 				continue;
 			}
-			if (r->id_map[dist_name_info->id] &&
-			    r->id_map[dist_name_info->id] != BTF_IS_EMBEDDED) {
+			if (r->id_map[dist_info->id] &&
+			    r->id_map[dist_info->id] != BTF_IS_EMBEDDED) {
 				/* we already have a match; this tells us that
 				 * multiple base types of the same name
 				 * have the same size, since for cases where
@@ -337,13 +327,13 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 				 * to in base BTF, so error out.
 				 */
 				pr_warn("distilled base BTF type '%s' [%u], size %u has multiple candidates of the same size (ids [%u, %u]) in base BTF\n",
-					base_name_info.name, dist_name_info->id,
-					base_t->size, id, r->id_map[dist_name_info->id]);
+					base_info.name, dist_info->id,
+					base_t->size, id, r->id_map[dist_info->id]);
 				err = -EINVAL;
 				goto done;
 			}
 			/* map id and name */
-			r->id_map[dist_name_info->id] = id;
+			r->id_map[dist_info->id] = id;
 			r->str_map[dist_t->name_off] = base_t->name_off;
 		}
 	}
@@ -362,7 +352,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 	}
 done:
 	free(base_name_cnt);
-	free(dist_base_info_sorted);
+	free(info);
 	return err;
 }
 
-- 
2.31.1


