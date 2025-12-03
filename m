Return-Path: <bpf+bounces-75987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B55CA1509
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 20:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0511A300854A
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16AC3321A9;
	Wed,  3 Dec 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GOx/OYtQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C5331A77
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789399; cv=none; b=kzYFfTetQxu2e8G3LSps3vwpI9fZg2W+RZAR4Q0iNHDqGFnUr4ThwHcfv4dmDNjyAn/+fEMs2Rafb4EdMkf4yXAjQ1GUK2rCUcYFhPtUcooNw6EsKzoQ+MvrlT66WYPnfmblzt2cKMMdaJYiDKkzxpfWRNt6EkTsRNQs3rJFnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789399; c=relaxed/simple;
	bh=CanXnvkFX2sjWH9bLRyC0zs/vc8vHBzJpA7PnMjTFjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DH/P9gYrCzw520EuBYuSNDNNlNI6sMObLuwVxpB3ohlnW3Zc950BrzQDEd2WAz/oMAQU1rvVySzx19KKQOYDCH7l0fg/cZA0DL1lI3wyxcYQbzU5iIOlWqINCTMdp1yEVS4+EhJNih31rLxHPei/NLejX0FHR8YZscR47Z/cpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GOx/OYtQ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3IQuLI3286272;
	Wed, 3 Dec 2025 19:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=dpDA4B6supJ+1n3K9pmyzKtw6I4Ku
	wXRj03m9OFDGqc=; b=GOx/OYtQIKF8La76UIhcR6iqKxLRLynDmj/vEK9uGNdln
	SOSqDgkNnsUj/O37ytr3aaqfWokD1LEme1g4GK26EWOQdN3L+7qFD2WjUaZFdOmU
	UpN/0a7nbv3YRIZDOrFcJIFWJFHBIF+wgld0nVm6EoxYpx3oTXHSgnteBHu+ZItu
	8y7eKbKbZIxwXPd3mqlVrx4ncRETjjHeF1BBPlX2IRzmTRZenVXfX91rlgWY+N2u
	wz19D/c1xUBkRx/N0hVdIRCfVUBG5skZ8kyL2nZuSYwAhWiOVaEFi8fL7pz7gOnF
	O4rgWTWlsXeSQ5dlzgn5HdosfTR69Fst9KRU4VaNg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7cp626x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 19:15:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3IVKdR023477;
	Wed, 3 Dec 2025 19:15:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9emdcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 19:15:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5B3JEu1F016690;
	Wed, 3 Dec 2025 19:15:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-63-50.vpn.oracle.com [10.154.63.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aqq9emda9-1;
	Wed, 03 Dec 2025 19:15:10 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next] libbpf: Add debug messaging in dedup equivalence/identity matching
Date: Wed,  3 Dec 2025 19:15:07 +0000
Message-ID: <20251203191507.55565-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030152
X-Authority-Analysis: v=2.4 cv=ZfgQ98VA c=1 sm=1 tr=0 ts=69308c41 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=9HJ_8bGEoqVLx-hquNgA:9 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: EjmyqxAbNJrA0QgfEPa0HTleuaKPQ0sa
X-Proofpoint-GUID: EjmyqxAbNJrA0QgfEPa0HTleuaKPQ0sa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE1MSBTYWx0ZWRfXzyyxLaP9vQMj
 iIwvdaPRttXZsKWH1iLB3otKhM59/I+SQhLiscVpi6sJCEkfg1wD20THuZkn5kV0DVKomugIvHc
 7Wwq+3JBOZh4uPXZsSo+XZGGey+WZ/6wmMaw61ZyeKTH8MPsEu+wn9WlQ+Re3ONguWovr1L+kRP
 G32hLpJA4WBxxfV6OawqErzfwHT0iXjX02qRlgvEd+yFgBNLuGvY1V4hAyitDveBw3wFjNHKwQe
 3wDNFKmJXvxOC6gFFiiQRI6QzE9gBu4QhWPUjdYuHWKGmop4Z4k2aSYypgnzRNw0JOGTzhX44FO
 /IZ/9BoeTRVdjoccV2J6gMVYf2vbc5jW7id/oFKg5IUfpt817Y89FNF1fVqngrG1l/33jm4stYa
 iRidDlQxzxNms0VUaa6pW0orqSLQg753ILxwzBBAymKjcHqW2Bo=

We have seen a number of issues like [1]; failures to deduplicate
key kernel data structures like task_struct.  These are often hard
to debug from pahole even with verbose output, especially when
identity/equivalence checks fail deep in a nested struct comparison.

Here we add debug messages of the form

libbpf: STRUCT 'task_struct' size=2560 vlen=194 cand_id[54222] canon_id[102820] shallow-equal but not equiv for field#23 'sched_class': 0

These will be emitted during dedup from pahole when --verbose/-V
is specified.  This greatly helps identify exactly where dedup
failures are experienced.

[1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com/

Changes since v1:

- updated debug messages to refer to shallow-equal, added ids (Andrii)

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 84a4b0abc8be..e5003885bda8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4431,11 +4431,14 @@ static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2,
 	struct btf_type *t1, *t2;
 	int k1, k2;
 recur:
-	if (depth <= 0)
-		return false;
-
 	t1 = btf_type_by_id(d->btf, id1);
 	t2 = btf_type_by_id(d->btf, id2);
+	if (depth <= 0) {
+		pr_debug("Reached depth limit for identical type comparison for '%s'/'%s'\n",
+			 btf__name_by_offset(d->btf, t1->name_off),
+			 btf__name_by_offset(d->btf, t2->name_off));
+		return false;
+	}
 
 	k1 = btf_kind(t1);
 	k2 = btf_kind(t2);
@@ -4497,8 +4500,17 @@ static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2,
 		for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
 			if (m1->type == m2->type)
 				continue;
-			if (!btf_dedup_identical_types(d, m1->type, m2->type, depth - 1))
+			if (!btf_dedup_identical_types(d, m1->type, m2->type, depth - 1)) {
+				/* Provide debug message for named types. */
+				if (t1->name_off) {
+					pr_debug("%s '%s' size=%d vlen=%d id1[%u] id2[%u] shallow-equal but not identical for field#%d '%s'\n",
+						 k1 == BTF_KIND_STRUCT ? "STRUCT" : "UNION",
+						 btf__name_by_offset(d->btf, t1->name_off),
+						 t1->size, btf_vlen(t1), id1, id2, i,
+						 btf__name_by_offset(d->btf, m1->name_off));
+				}
 				return false;
+			}
 		}
 		return true;
 	}
@@ -4739,8 +4751,20 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		canon_m = btf_members(canon_type);
 		for (i = 0; i < vlen; i++) {
 			eq = btf_dedup_is_equiv(d, cand_m->type, canon_m->type);
-			if (eq <= 0)
+			if (eq <= 0) {
+				/*
+				 * Provide debug message for named types only;
+				 * too many anon struct/unions match.
+				 */
+				if (cand_type->name_off) {
+					pr_debug("%s '%s' size=%d vlen=%d cand_id[%u] canon_id[%u] shallow-equal but not equiv for field#%d '%s': %d\n",
+						 cand_kind == BTF_KIND_STRUCT ? "STRUCT" : "UNION",
+						 btf__name_by_offset(d->btf, cand_type->name_off),
+						 cand_type->size, vlen, cand_id, canon_id, i,
+						 btf__name_by_offset(d->btf, cand_m->name_off), eq);
+				}
 				return eq;
+			}
 			cand_m++;
 			canon_m++;
 		}
-- 
2.39.3


