Return-Path: <bpf+bounces-78954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A74D20DCA
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A491F3013E9D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591333A704;
	Wed, 14 Jan 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e9THy/gH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14F3358B5
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415994; cv=none; b=PoZeXGx0/I+mj2iqrDteLoxr6cF60cd7v4q+pf77zrT6R8Kw0wQyxkVy/eTFvH3zrAy8j8XBNMWICw+67EXNnqtmVS2UXGMi3AMek7wwa6mW+LodjyZx/gIoVn2w7MtHo0UuHVKKOL9WNWmmesguOKmZcQ1pZKWR2O52+uWHbzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415994; c=relaxed/simple;
	bh=XgLoUdNFOVwfebAEgKWTMkVWj5YV/WUdX5HZIu/16Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTlaUc3LtCoSsVGzf9bjmHCW0QBej65IGnQuHNvPIW8HwIPFsC+RtZUb6bYvx5uQOxwZdoVr2tkperET0vW24T2G5mkGmWOjsnJHwqMz9TqON3dH9DyMbmVwJnX1GX3LLMyqRLEp1dVGNCUPDIqAB0Tem2p6n+sC2jR9wmcKnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e9THy/gH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EHjOjL1940366;
	Wed, 14 Jan 2026 18:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=0HKJh
	5I5G8MtmV7wK0x5aLxDs43RC5CE76I3OTtv/vw=; b=e9THy/gHDftVUHUDerPlP
	xr/Ks631Yg7Xp4VquD1mNByRydFJNOBithV6lOwTk+yFcqyVdkIo/qdulnRnilJA
	/5v20zY2ULz+hus8IJoyovBql0OEweoNtLaYKp47CLkL+vLLDUgsz6n9fNeNjKgp
	5GWYMAGT6sN87X3SsHk22BLogmXHmUBJQ5ykmMlpVdE0S2IlJ+dWGx1B9NZA2//p
	eV/ToEU0sBS9GtdjkuURrbfRb9j/WnUB6q0Knb0NExhflmU/CXghZcGQskToTiDH
	CzWwm4hCeVEuuzjdkmaarrs4wxOQHTioECBmT39UipV6WXZmid5d7M2UXJKDPDzu
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5p391yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:38:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60EH5xXt011825;
	Wed, 14 Jan 2026 18:38:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7acdhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:38:27 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60EIcNUF016071;
	Wed, 14 Jan 2026 18:38:26 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-147.vpn.oracle.com [10.154.50.147])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7acd9y-2;
	Wed, 14 Jan 2026 18:38:26 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, yonghong.song@linux.dev
Cc: nilay@linux.ibm.com, ast@kernel.org, jolsa@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf v2 1/2] libbpf: BTF dedup should ignore modifiers in type equivalence checks
Date: Wed, 14 Jan 2026 18:38:07 +0000
Message-ID: <20260114183808.2946395-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260114183808.2946395-1-alan.maguire@oracle.com>
References: <20260114183808.2946395-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601140155
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=6967e2a4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=OeDGyIjvcQv4VQ66o48A:9
X-Proofpoint-ORIG-GUID: Tv3i0q91t7W2noYntqhd_xjaegfiP56R
X-Proofpoint-GUID: Tv3i0q91t7W2noYntqhd_xjaegfiP56R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NCBTYWx0ZWRfX36ANQZAlE+Rn
 Z5vL0f9jJrM5H++o40P0OMrRPTkVNRlOxtS4ZFl0GzpBO7XnoKZNiA6C8bQtkYxZzVnMmAFLkkz
 9MVjSuD+u4zmKnLZB/sKoPIqWqVW+ZeATUFk8mmkZdJWwl8VORLh+eZiwm9T4jBdU9FPo071h8b
 QskzuwZ7vfXqY4PM4OD2flEWgaTWc4zA/mJBkyP7QGvTP7St5UMF30KKVtSLH/1Fh35HvXvyUu8
 zY1sGp24ByLE5x0bYUjb0zOi5ciSt5g8ZfQRr0vA25wTeUyWL+he/PWKQj75Ir1MDoyTXiTbT9p
 RIbRNXuhJiuzRdPQzKZKwfcb7IfEHRF76ZZooyqfwV30buh0qOHKP8btH7sE2AOktpF117Kg2xQ
 SBwBYJF/xbJVMiSCvH/4eHFx3ijg2vR4FJoQnAkpz5H7AUcJsD+GgNOOL/POvEvpwThKsRhCK72
 ynBYdfVMzVQrdD7O9zA==

We see identical type problems in [1] as a result of an occasionally
applied volatile modifier to kernel data structures. Such things can
result from different header include patterns, explicit Makefile
rules, and in the KCSAN case compiler flags.  As a result consider
types with modifiers const, volatile and restrict as equivalent
for dedup equivalence testing purposes.

Type tag is excluded from modifier equivalence as it would be possible
we would end up with the type without the type tag annotations in the
final BTF, which could potentially lead to information loss.

Importantly we do not update the hypothetical map for matching types;
this allows us to match in both directions where the canonical has
the modifier _and_ when it does not.  This bidirectional matching is
important because in some cases we need to favour the modifier,
and in other cases not.  Consider split BTF; if the base BTF has
a struct containing a type without modifier and the split has the
modifier, we want to deduplicate and have base type as canonical.
Also if a type has a mix of modifier and non-modifier qualified
types we want it to deduplicate against a possibly different mix.
See the following selftest for examples of these cases.

[1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/

Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 83fe79ffcb8f..74c93e936d1c 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4734,20 +4734,15 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return 0;
 	}
 
-	if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
-		return -ENOMEM;
-
 	cand_type = btf_type_by_id(d->btf, cand_id);
 	canon_type = btf_type_by_id(d->btf, canon_id);
 	cand_kind = btf_kind(cand_type);
 	canon_kind = btf_kind(canon_type);
 
-	if (cand_type->name_off != canon_type->name_off)
-		return 0;
-
 	/* FWD <--> STRUCT/UNION equivalence check, if enabled */
-	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
-	    && cand_kind != canon_kind) {
+	if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD) &&
+	    cand_type->name_off == canon_type->name_off &&
+	    cand_kind != canon_kind) {
 		__u16 real_kind;
 		__u16 fwd_kind;
 
@@ -4761,12 +4756,34 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 			if (fwd_kind == real_kind && canon_id < d->btf->start_id)
 				d->hypot_adjust_canon = true;
 		}
+		if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
+			return -ENOMEM;
 		return fwd_kind == real_kind;
 	}
 
-	if (cand_kind != canon_kind)
+	/*
+	 * Types are considered equivalent if modifiers (const, volatile,
+	 * restrict) are present for one but not the other.
+	 */
+	if (cand_kind != canon_kind) {
+		__u32 next_cand_id = cand_id;
+		__u32 next_canon_id = canon_id;
+
+		if (btf_is_mod(cand_type) && !btf_is_type_tag(cand_type))
+			next_cand_id = cand_type->type;
+		if (btf_is_mod(canon_type) && !btf_is_type_tag(canon_type))
+			next_canon_id = canon_type->type;
+		if (cand_id == next_cand_id && canon_id == next_canon_id)
+			return 0;
+		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
+	}
+
+	if (cand_type->name_off != canon_type->name_off)
 		return 0;
 
+	if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
+		return -ENOMEM;
+
 	switch (cand_kind) {
 	case BTF_KIND_INT:
 		return btf_equal_int_tag(cand_type, canon_type);
-- 
2.31.1


