Return-Path: <bpf+bounces-71998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC93C04C09
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B657401FA2
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 07:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F052E5400;
	Fri, 24 Oct 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yk7QV8yR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8262E6CA5;
	Fri, 24 Oct 2025 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291249; cv=none; b=pGDhf8ZExt22f5Uid899Urs0r2I+GI/pqqaTdbHQFBo5m2UI7p1ifOa8zcxEYgg7nfsILpf1CXhaxw04O6RPmGkqQ9d+mwKrI9ACUJ8XpgdSEaoBE+4zTivdhAWYCmsxiDpr1sgkrsQhRgqNvYu8RoYdHtRKJnBaHBSY5pC8T0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291249; c=relaxed/simple;
	bh=aGdOuMTDpHskXFTv2BxWW7OsMA+qUlwUu5D/K5Z7NQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2Bt3B4haHL7iRxucn6WIg984avsZgl0mIvuRUjVZhfyIUd8XzBKq1tINsQUv9AggblFsLp1JRFFQC7WVI07J//xAXAkrkF1qTEtxHoKdKgm/W6GeZON5Jm+0INSFes7sjkJu/VV4bM3UpCMOQbtjUNJgoIZ1UvvlJNIYa+JcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yk7QV8yR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NLGA021556;
	Fri, 24 Oct 2025 07:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=FCH4o
	o1JDbvloxFPOyFe7NJDYA5snlXEeVj/02wSPzM=; b=Yk7QV8yRmv1nYpIn5oFfB
	iMe9y/dNHVw8m3BkfBGTgs0BwmACTyeY97QV6MOVFN60OljHS6dcVmCBItAK9Qt5
	hosABwZJTrrp9Y65LbTGTR5wVyLe4Sngpxd0lIXoAHr9CPkseWgGqJfAW+O1T9TG
	Sbk2BVyAKxqegFTZnuNMt4/xVXflUwf5Ug9f3uKdf4/5lgNtB4ENH4uMS6RG+Ol3
	bJRXIqxV0PD9hT5SBoDAlfO88CHjItxC7ZzC1VPJYGtbOsIzO4i6coEdLG8qpVMv
	MYXHBj1Se/fMbhN7gyGZ1pcP5ANhmGXUNDZBqduXRmIGpaZfDaRnhlP8tIcpIhmh
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3k460k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7UVWf022373;
	Fri, 24 Oct 2025 07:33:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm4fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59O7XYwh019356;
	Fri, 24 Oct 2025 07:33:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-127.vpn.oracle.com [10.154.57.127])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bgm48v-3;
	Fri, 24 Oct 2025 07:33:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
Subject: [RFC dwarves 2/5] dwarf_loader: Add name to inline expansion
Date: Fri, 24 Oct 2025 08:33:25 +0100
Message-ID: <20251024073328.370457-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251024073328.370457-1-alan.maguire@oracle.com>
References: <20251024073328.370457-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240065
X-Proofpoint-GUID: Rrpg5eTOH6W1dfU9sNTASUBOupQ89bNs
X-Authority-Analysis: v=2.4 cv=bLgb4f+Z c=1 sm=1 tr=0 ts=68fb2bd6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=_JUeNTLN5gHo4JZYuNsA:9 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX3tlgAgnpKyVU
 Fvbxfx1DcQLMDhjUzJRhPJgBVLfxyxs7fSBe2H3G9WxzKO+iJ+w9G6FoItF1FmOGnd2TFeKHTxx
 dwkB1LmSOwifPUhT64jN2Rk/TWfVfzUZnxdcAaEVwuzBS2t6d4vGeyw9oPQ76NH8tpEXTritYdF
 K8YIB0tMoJ4774K5LbQEzv7bN1JNaCRkuTaxEudO4jypufB/lU6fLDxU6Z1NmVmuVN5oFjDL3D7
 05UAGUf0XtQQmHSAsix98aKwJohay8PDUllf19G1GId800oFkK1z+P2oSKMVf5Vntwz9UHf0TCr
 BHCkm7zR4uThFUJnF5iiqs8N/7zyBnMfuNtAKkHnh+UQuFpAyPem1QIS9p8nzdhJR6GRuVYlfIV
 Rsj/FjfkPv8AnAMToBkn9NwiZ/4dhS4Ac2TrMgqx9OpYd958jlE=
X-Proofpoint-ORIG-GUID: Rrpg5eTOH6W1dfU9sNTASUBOupQ89bNs

From: Thierry Treyer <ttreyer@meta.com>

Add the name field to inline expansion. It contains the name of the
abstract origin. The name can be used to locate the origin function.

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
---
 dwarf_loader.c | 9 +++++++++
 dwarves.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e19414d..4656575 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1375,6 +1375,15 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dtag->decl_file = attr_string(die, DW_AT_call_file, conf);
 		dtag->decl_line = attr_numeric(die, DW_AT_call_line);
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin);
+
+		Dwarf_Attribute attr_orig;
+		if (dwarf_attr(die, DW_AT_abstract_origin, &attr_orig)) {
+			Dwarf_Die die_orig;
+			if (dwarf_formref_die(&attr_orig, &die_orig)) {
+				exp->name = attr_string(&die_orig, DW_AT_name, conf);
+			}
+		}
+
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
 		exp->nr_parms = 0;
diff --git a/dwarves.h b/dwarves.h
index 4e91e8f..284bc02 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -821,6 +821,7 @@ struct ip_tag {
 
 struct inline_expansion {
 	struct ip_tag	 ip;
+	const char	 *name;
 	size_t		 size;
 	uint64_t	 high_pc;
 	struct list_head parms;
-- 
2.39.3


