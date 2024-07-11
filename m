Return-Path: <bpf+bounces-34588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA9592EED5
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CF4B20AAD
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5510E16DED5;
	Thu, 11 Jul 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="no97k6sn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1F16DC36
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722234; cv=none; b=rMa6bes/KUHEVDDV/sgU1LwPjKbmTems1q3urVZDTzNzyVZeQL2vAyAwGx3sLCTbDvASElmVYlxPFMx/OLAmcLV9OQ0YlAR/FYKHziWTC39+BH0XyWvIOdNdEoQJdcmK+HW7WHaBH1cQMHPS32pluDFpbPqYwweJcDpijNbJQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722234; c=relaxed/simple;
	bh=kjS8GS8ORRKYGxxLAdpmXSf7xTl/SWM28tuT9ZAMJRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P63FMWFfF4WqquUmqh5SIIMGfg9FpiQzb0KmqsUsFW1S7/r7ZDMOLUq1KSnp/LhoU01DHCecRKdmu+atXrDVgd8grqVABqyK83FMfk28mBT/ZFtx4I+S9P2BOmPbeHUgx3/NMmZ2+qu5owU3NXDPlPKE3wiGhlkZBcClwPsXDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=no97k6sn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBZ6a008221;
	Thu, 11 Jul 2024 18:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=NBjoJieNagwZr4
	dcPn1+MbP/wHLoamoksLaTFpZerfM=; b=no97k6sneXm9FbNda8EBGyMJ5JaBN5
	xmC1pYHbb+cCTBlPzwV4vAwQuN5QV/Z8yXQIFc1wS4vzQufGX8OPBFc4IqGkUQYe
	oQh54sbh4vvzTth5aMIuX4bYyq1dT9wfYVfVIPuGOjNTYc2kgwopETFLy812ZyiT
	q8ItsKlIg6L9q4tr4k2VSNdUiz+BtLfVBcY5uWnxrr4HSpA1J3GCqIU9bsImNkGr
	sw7iA1SnIwM/4US54UqeR0Y+NQkC5/eNouoyrvyXJiboCvBUmbhhmSGy3K40NMa3
	uVrFHfkksqTb6ky1NpTpq7duU2TUMB4zbdhGuMMvSVh6616J8VOPdwAA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkyacjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:23:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BHWRCx030316;
	Thu, 11 Jul 2024 18:23:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvbn61p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 18:23:25 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46BIKrLg022086;
	Thu, 11 Jul 2024 18:23:24 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-207-250.vpn.oracle.com [10.175.207.250])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 409vvbn604-1;
	Thu, 11 Jul 2024 18:23:24 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PATCH bpf] bpf: annotate BTF show functions with __printf
Date: Thu, 11 Jul 2024 19:23:21 +0100
Message-ID: <20240711182321.963667-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110128
X-Proofpoint-ORIG-GUID: vm6aRimHHy6BLuX1aiOjc9rwsKOJXpEk
X-Proofpoint-GUID: vm6aRimHHy6BLuX1aiOjc9rwsKOJXpEk

-Werror=suggest-attribute=format warns about two functions
in kernel/bpf/btf.c [1]; add __printf() annotations to silence
these warnings since for CONFIG_WERROR=y they will trigger
build failures.

[1] https://lore.kernel.org/bpf/a8b20c72-6631-4404-9e1f-0410642d7d20@gmail.com/

Fixes: 31d0bc81637d ("bpf: Move to generic BTF show support, apply it to seq files/strings")
Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4ff11779699e..d5019c4454d6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7538,8 +7538,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
 	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
 }
 
-static void btf_seq_show(struct btf_show *show, const char *fmt,
-			 va_list args)
+__printf(2, 0) static void btf_seq_show(struct btf_show *show, const char *fmt,
+					va_list args)
 {
 	seq_vprintf((struct seq_file *)show->target, fmt, args);
 }
@@ -7572,8 +7572,8 @@ struct btf_show_snprintf {
 	int len;		/* length we would have written */
 };
 
-static void btf_snprintf_show(struct btf_show *show, const char *fmt,
-			      va_list args)
+__printf(2, 0) static void btf_snprintf_show(struct btf_show *show, const char *fmt,
+					     va_list args)
 {
 	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
 	int len;
-- 
2.31.1


