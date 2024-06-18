Return-Path: <bpf+bounces-32418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FFC90D92B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A8D2844CF
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D0A4E1C8;
	Tue, 18 Jun 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OSG6aSb0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA1459164
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727939; cv=none; b=KojVjFN45NsZHSo/HY1WKRWwRJqfh7LX58+sfqomFokY+TQiu93Qt9lWoQf6+F0ec42peJmJ3S+I2QriBb16Mu4YpzGEGdxd8zCo2YNWQqAQ4Hepg9GrksKL28zVGqyrKOwECX30kNfSbcM0CphL9Y/ybft5sPcSK1ooZYNIgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727939; c=relaxed/simple;
	bh=nLQDdleOZJNxAbrRBpBV/HH4Pe4jq9+gKQtR3+F1wWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0JP3WzrZKKiabaUe+WdJfrJZPJNV4H8GrfKplCEefDR+8Y+s1sek0yH4yRkTGJQhVluBVypU8a2LOGQJNM5s/7vW7XdgjDiPWO9hun23DO2J1CUxtWkWM8ZhdL+3QX2d/e5n8jV9quzBQF5T0NS9S3+odXDUBazUkRz7ttBnBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OSG6aSb0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IGBFlQ026708;
	Tue, 18 Jun 2024 16:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=l
	kTIL8y4hed7LB/r33RFtinDr6E/T0r3FqFeOzMOKcA=; b=OSG6aSb0OFveMx/VG
	xZ4CWsVudYg68ktw3rb0vr/87VfYvREYN9JAMfv0k8nwgAotrcOuEkoxfOU4jIwN
	UX7JbimMWzJwTuVtj19xTz06WpcqA2DU+OZvHQxhC9P1fFq8y35G/7edmdyYE33s
	ln7seKS4dWB5oVUPWbVpdc2hzJ1DgcivqjbCCsd4f0GGRVfP6tHLntAf1LEe3xfL
	J8h/CZr9U4nQ7CnaU8HXzsWKjRPMfbpcumELca/f7sp2s5w2iatwKEgccC3ujDjd
	GLsq4qJ1xrUYQ5DpXPwcFYblvYyUlRpgcfQtScqlvbkXiECwc5YJWZtDRICbhily
	DFx8g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js59fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:25:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IG9imY034751;
	Tue, 18 Jun 2024 16:25:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8c0fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:25:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45IGOt3u028167;
	Tue, 18 Jun 2024 16:25:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-223-50.vpn.oracle.com [10.175.223.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1d8c08e-2;
	Tue, 18 Jun 2024 16:25:01 +0000
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
Subject: [PATCH bpf-next 1/5] libbpf: BTF relocation followup fixing naming, loop logic
Date: Tue, 18 Jun 2024 17:24:45 +0100
Message-ID: <20240618162449.809994-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618162449.809994-1-alan.maguire@oracle.com>
References: <20240618162449.809994-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180123
X-Proofpoint-ORIG-GUID: D8P-sFj_uhEmBcZe8RX3OWRaTzNlvBP5
X-Proofpoint-GUID: D8P-sFj_uhEmBcZe8RX3OWRaTzNlvBP5

Use less verbose names in BTF relocation code and fix off-by-one error
and typo in btf_relocate.c.  Simplify loop over matching distilled
types, moving from assigning a _next value in loop body to moving
match check conditions into the guard.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf_relocate.c | 74 ++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index eabb8755f662..64cd8bdc0105 100644
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
@@ -169,26 +169,25 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
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
+		info[id].name = btf__name_by_offset(r->dist_base_btf,
+						    dist_t->name_off);
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
@@ -216,8 +215,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 
 	/* Now search base BTF for matching distilled base BTF types. */
 	for (id = 1; id < r->nr_base_types; id++) {
-		struct btf_name_info *dist_name_info, *dist_name_info_next = NULL;
-		struct btf_name_info base_name_info = {};
+		struct btf_name_info *dist_info, base_info = {};
 		int dist_kind, base_kind;
 
 		base_t = btf_type_by_id(r->base_btf, id);
@@ -225,16 +223,16 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
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
@@ -248,31 +246,25 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
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
+		for (dist_info = search_btf_name_size(&base_info, info,
+						      r->nr_dist_base_types);
+		     dist_info && dist_info < info_end &&
+		     !cmp_btf_name_size(&base_info, dist_info);
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
@@ -319,15 +311,15 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
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
@@ -337,13 +329,13 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
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
@@ -362,7 +354,7 @@ static int btf_relocate_map_distilled_base(struct btf_relocate *r)
 	}
 done:
 	free(base_name_cnt);
-	free(dist_base_info_sorted);
+	free(info);
 	return err;
 }
 
-- 
2.31.1


