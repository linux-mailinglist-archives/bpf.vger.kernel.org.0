Return-Path: <bpf+bounces-75200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7028C768AF
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F1CA4E27E0
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F80242D7D;
	Thu, 20 Nov 2025 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fs55h+yH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6E2ECD28
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678666; cv=none; b=pU0kxsCKojHDu4tPrbGB4NaG2UkXO8pCKtIajYejvE161Hy1lZFTbjGCpvEXiZPy4OfAlBg10u2DVSWHyL4IwbvquNw2ZFaM4gvC8YdVrgZ3D+8fbWlLDQwmNLjYctMDEQ0ExdtddT8EVtqhrOjOmrgCyns9GFoxxK+Zg+2DjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678666; c=relaxed/simple;
	bh=Bu6agvZNHn1yOVHo7ZYT7x2vI5KHqEpDMabeh+jpbD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcR/r1U/I0GKXatwfAaFxv30pSI76DtF1n9BELd7KHZ6BWjXfsqzfeWFzoHefEqq3Ba5TOkHnyzf4cN9fgrqX1rpOTITGilNiBXk6WmYrETDrG1/vFWEk+yTdsTDc/FSgzc+ueDF0FsCsB3kjAGR90YFGALjWzE1GrMgHV996o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fs55h+yH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKJgJOq024217;
	Thu, 20 Nov 2025 22:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=DrfMuAqc0yVbj/0jC9y5nUsC8kFMW
	LH6Ebfzdsc3whY=; b=fs55h+yHEV3ievJeRpVVKbLak36O5Clo8mnBtySf2L4kC
	KDBTAJTAYNdLrbKYadHgfq/pcTJczDEUR+qlpWKixqRmljroapZ2SQAYdwR0AXQo
	0e7MttU5dsgvXzDZH0jh74jqhzCFwlGOZ0vkU4jIoFo/BycGLCWZsgoxD83rAv98
	MthBYzpKVCHvBHEvkmxuDNMfSDrRlKmFsRjAgsxFxHMMERUin3xTivQGtOhWyiNu
	N7U6jnTf3g2H5VWGLQQmntZJXDVqAwtC1l78/FuFY1hTjMmijNXC0xcxllZy8+q/
	UsQU7KsA5/lS66sblE2+4NizSp65qwmOb7vZH0pIQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbusy4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 22:43:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKMLg9n002456;
	Thu, 20 Nov 2025 22:43:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyct5qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 22:43:00 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AKMh0Or015790;
	Thu, 20 Nov 2025 22:43:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-60.vpn.oracle.com [10.154.60.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefyct5nb-1;
	Thu, 20 Nov 2025 22:43:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] libbpf: Add debug messaging in dedup equivalence/identity matching
Date: Thu, 20 Nov 2025 22:42:56 +0000
Message-ID: <20251120224256.51313-1-alan.maguire@oracle.com>
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
 definitions=2025-11-20_09,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzX4VS2FQhxgm
 vYYttKCaqkSQLFO62+Dm+4GD5tSs47Su1KiiGaffLYJkEgk+JkQGax6hsPS17CD0qlnTIOavFD5
 zecNaE3xtsrjdTg2dCc9v3aBKRUC6z2/xD+NO0/+kjusXo7+YZU8N2fd0/BxgxvmFx3nKFVsxL2
 a/GxnHK/ID69YWyOSnCW2mK889zJLoMFSIjXpp6605ysQlzbZMqcfDFd9p72iWDz7n3ih4RHZFC
 Z6iQVutWlJjaIkFYegqKRgcNPH9yb4+vKbbOHidNgZzL0Sic0GfK4dPLLH1DHaixYDlzjQmp0rE
 xZwiPEeNaPF0TJmnqSGBR4Moh7BG9ivuYMscQ3T9begCxQW+z8Uw5jPLHsmtwBNbeiW9Fyw2GYN
 f5PQdomD1a5Nk1yROt0FMOKVsMe3FA==
X-Proofpoint-GUID: ATmko8ji7OzMIs0FkjUq_OHGSxnBLOFN
X-Proofpoint-ORIG-GUID: ATmko8ji7OzMIs0FkjUq_OHGSxnBLOFN
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691f9975 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=9HJ_8bGEoqVLx-hquNgA:9

We have seen a number of issues like [1]; failures to deduplicate
key kernel data structures like task_struct.  These are often hard
to debug from pahole even with verbose output, especially when
identity/equivalence checks fail deep in a nested struct comparison.

Here we add debug messages of the form

libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent but differs for 23-indexed cand/canon member 'sched_class'/'sched_class': 0

These will be emitted during dedup from pahole when --verbose/-V
is specified.  This greatly helps identify exactly where dedup
failures are experienced.

[1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 84a4b0abc8be..c220ba1fbcab 100644
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
@@ -4497,8 +4500,18 @@ static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2,
 		for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
 			if (m1->type == m2->type)
 				continue;
-			if (!btf_dedup_identical_types(d, m1->type, m2->type, depth - 1))
+			if (!btf_dedup_identical_types(d, m1->type, m2->type, depth - 1)) {
+				/* provide debug message for named types. */
+				if (t1->name_off) {
+					pr_debug("%s '%s' (size %d vlen %d) appears equal but differs for %d-indexed members '%s'/'%s'\n",
+						 k1 == BTF_KIND_STRUCT ? "struct" : "union",
+						 btf__name_by_offset(d->btf, t1->name_off),
+						 t1->size, btf_vlen(t1), i,
+						 btf__name_by_offset(d->btf, m1->name_off),
+						 btf__name_by_offset(d->btf, m2->name_off));
+				}
 				return false;
+			}
 		}
 		return true;
 	}
@@ -4739,8 +4752,21 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		canon_m = btf_members(canon_type);
 		for (i = 0; i < vlen; i++) {
 			eq = btf_dedup_is_equiv(d, cand_m->type, canon_m->type);
-			if (eq <= 0)
+			if (eq <= 0) {
+				/* provide debug message for named types only;
+				 * too many anon struct/unions match.
+				 */
+				if (cand_type->name_off) {
+					pr_debug("%s '%s' (size %d vlen %d) appears equivalent but differs for %d-indexed cand/canon member '%s'/'%s': %d\n",
+						 cand_kind == BTF_KIND_STRUCT ? "struct" : "union",
+						 btf__name_by_offset(d->btf, cand_type->name_off),
+						 vlen, cand_type->size, i,
+						 btf__name_by_offset(d->btf, cand_m->name_off),
+						 btf__name_by_offset(d->btf, canon_m->name_off),
+						 eq);
+				}
 				return eq;
+			}
 			cand_m++;
 			canon_m++;
 		}
-- 
2.39.3


