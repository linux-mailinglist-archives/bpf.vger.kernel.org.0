Return-Path: <bpf+bounces-56965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6C1AA1155
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 18:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6AB1B62FD3
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4523243364;
	Tue, 29 Apr 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzQl1UNr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421A238177;
	Tue, 29 Apr 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943059; cv=none; b=dMMToB08zeg+yNMhwYNcwh4a8bq2FYWPkm0cRyvwfM0690P/uNNOGyqqFSkyNiwAO6ymlMEAkgC+Qy63s89Olo67YVQNG6Q04FBzjjxoCzig+cIT7JqYublaiHz68CwGqp/AQ4ehC/A8Ilh4qALbYzXFK7ceh1b567ip53/1vbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943059; c=relaxed/simple;
	bh=vym9ZX8/hgSbdjn3JPWqCZZtBjn0miTIKHLZ182JcX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMe31xM45zVCWVJmVDumZJ78Qvt70G3GaEUl14nbsIJ/XNmg9iqQA9agLnczMJ5hqiYSkX7og60f4Zs1Be+Iu0zDEtRcRL1asW8j1zclLevjImi1v26DiXvGwo8L5mqlZlr9a6WCn7fsG0Rp7nfjsSxweNX7C164W4ynoboJA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FzQl1UNr; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TDxkmh020581;
	Tue, 29 Apr 2025 16:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=SpDwh9w3OCIeHi3SM60OMw/Ozpwrx
	FlIrOmuoLsrzVw=; b=FzQl1UNrIKxsN8Bxy5HrxtKCVTHfurac5dOwBy5UTDWOy
	b6qSYG9/zQLxfqntmd/UAsydSFc8eo9G8Oyi2sm4zAYelCfAIELsUhvrzecaY2t/
	gaaL4ityv6NSysnkNCM4Nuq1ER1G60vOcgIhhcYVa3LCeuhZIwpxE2WeaDyhHwru
	4a5crVu/mA8X3u/se872JAthVl+b9BG+hnWpBB6860nAOVGozz4xzxPPjVXIK8MC
	5A4enSB/MNOQh1cpv/wDTePjiy0F/UpXpjWnuXx9imXpnn8Ow6wRgIdjFjp7Xs2S
	Ek7QsSdH2uLK5kf79ROzDIsh1aMe0zV355ZmWryZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ayvmrerp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:10:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TFLkoV011235;
	Tue, 29 Apr 2025 16:10:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxam24k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:10:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53TGAjcS032105;
	Tue, 29 Apr 2025 16:10:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-35.vpn.oracle.com [10.154.60.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 468nxam22d-1;
	Tue, 29 Apr 2025 16:10:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, acme@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org,
        dwarves@vger.kernel.org, yonghong.song@linux.dev,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] libbpf: add identical pointer detection to btf_dedup_is_equiv()
Date: Tue, 29 Apr 2025 17:10:42 +0100
Message-ID: <20250429161042.2069678-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyMCBTYWx0ZWRfX7x8p0IQ6Rhl3 YeuK+FlrhAe7W9LRw9YfDCu7HgHk64GpmvRWb+79YkXSwIja9DWFgKKhpWt8wq8OZ0en+NPu0Kk xqFIjADHcZoXu3Plf2TxhptdzCTc5rXo/ymb7lRCkYKSvEnJJv51Rj+nqJqngBR7APfYyiUeU4H
 YH3z6wdJ3+HHFTcoBn6reqRUwxARB5YCfGEjJo2OeFnw5EvkVC7GwcyVPXQBj6nM3ZbC1GFdBuy yxV61nMMRa2lARy2JR72R0WJdK8Ev4vkian1FNpkhUXVwmG30r+wXQwbQgSnOJ4MOHhSsOLhpo/ GIN9jNOUrz3qYhyZSl4awbIuTlX1jhGTww3qY05K1cwTOJmTMDo9b0qyElY8cOISQYG5VUCLs8T m/rTxSOw
X-Proofpoint-GUID: jKjZS5jwa8ZIgp2req6boRmcWG_cDLML
X-Authority-Analysis: v=2.4 cv=adhhnQot c=1 sm=1 tr=0 ts=6810fa06 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=rbJ3u8-FI_ebhgAPfkgA:9
X-Proofpoint-ORIG-GUID: jKjZS5jwa8ZIgp2req6boRmcWG_cDLML

Recently as a side-effect of

commit ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")

issues were observed in deduplication between modules and kernel BTF
such that a large number of kernel types were not deduplicated so
were found in module BTF (task_struct, bpf_prog etc).  The root cause
appeared to be a failure to dedup struct types, specifically those
with members that were pointers with __percpu annotations.

The issue in dedup is at the point that we are deduplicating structures,
we have not yet deduplicated reference types like pointers.  If multiple
copies of a pointer point at the same (deduplicated) integer as in this
case, we do not see them as identical.  Special handling already exists
to deal with structures and arrays, so add pointer handling here too.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 24fc71ce5631..eea7fc10d19c 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4396,6 +4396,19 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
 	return true;
 }
 
+static bool btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1,
+__u32 id2)
+{
+	struct btf_type *t1, *t2;
+
+	t1 = btf_type_by_id(d->btf, id1);
+	t2 = btf_type_by_id(d->btf, id2);
+
+	if (!btf_is_ptr(t1) || !btf_is_ptr(t2))
+		return false;
+	return t1->type == t2->type;
+}
+
 /*
  * Check equivalence of BTF type graph formed by candidate struct/union (we'll
  * call it "candidate graph" in this description for brevity) to a type graph
@@ -4528,6 +4541,9 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		 */
 		if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
 			return 1;
+		/* A similar case is again observed for PTRs. */
+		if (btf_dedup_identical_ptrs(d, hypot_type_id, cand_id))
+			return 1;
 		return 0;
 	}
 
-- 
2.43.5


