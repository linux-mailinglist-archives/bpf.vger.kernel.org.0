Return-Path: <bpf+bounces-44942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE19CDD90
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBF8B2402A
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317F1B85E1;
	Fri, 15 Nov 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R2tntuZ4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181731B3937;
	Fri, 15 Nov 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670606; cv=none; b=CzCJ+52gmtEP/NqvXCDDGSSsSsYUHMgVskWV384BcR25GfdnPYxKDMAhlRcqqUrJwhMsx85X1ayh7COXM1PY38CmZBG1S3baCL1h3tvCV7qynM6ye6q7YCM9bEGlIf3TauJh2O3gitDEn3HuYHLhAiqEfr0XEvYNMCRD4wcax2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670606; c=relaxed/simple;
	bh=FtDMN2U/hfuJHrHshKMJ14dOrJV8V4BKKow5e/YijZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ulqafjkvb1CtHKSWpywIgZWQ5EUrB+ciAQnfkwCTWYKLbV9hbSOfE+LbPKGHVTW3/ma+1zpZukxCqrXhv4F5aSQpVOumVEFB2EOAzSapTnRPpEmYUh9jYRtx2GZErqgGsf7PsFDKI8s7AuT8o+JpP8IIGT66oWmKjOG02K8hdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R2tntuZ4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHHVh014494;
	Fri, 15 Nov 2024 11:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=FePsa
	iTFio03V3OyehcFqY1kVXTSLQADaV9Hvhf/ivY=; b=R2tntuZ4Dzg2LCh3BpVOz
	TGC+pASZB0B2zik/NjFkuvC9w/s3qVEm9dYeolAElRB8GF7yky8diivsPoW/XcIC
	fnlcDpyZie70vY2miccxdXRdxXPDrsCcYjnM8zo8yWF8Kf3R46AQfwbSlsnwuDCA
	MblP6zAmyE7cWxIIgczpsdVe8XG1gfxEICO1dpe30yUgi2T0RkcHznjgaZdpL8Ua
	FuVlKwQbXGpEi2I4FUscjGwKU1QgRhSqP9uGiTf1cRWwheYAQKIqHDvREcirilnn
	gkdtC+b/TGJTsmVRdvWtgT/s6IkW5RoAFsVQYQhIltWdSl6rZqSY1UKsEt7zt4AB
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k2b71u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 11:36:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAWsGB035964;
	Fri, 15 Nov 2024 11:36:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c38cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 11:36:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AFBa9PJ010008;
	Fri, 15 Nov 2024 11:36:15 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-214-128.vpn.oracle.com [10.175.214.128])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42sx6c388q-3;
	Fri, 15 Nov 2024 11:36:15 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v3 dwarves 2/2] dwarf_loader: use libdw__lock for dwarf_getlocation(s)
Date: Fri, 15 Nov 2024 11:36:05 +0000
Message-ID: <20241115113605.1504796-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115113605.1504796-1-alan.maguire@oracle.com>
References: <20241115113605.1504796-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=954 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150099
X-Proofpoint-ORIG-GUID: tTOA5QEKDXJ2a4K1sJ_JJD1DzsAvFq7Y
X-Proofpoint-GUID: tTOA5QEKDXJ2a4K1sJ_JJD1DzsAvFq7Y

Eduard noticed [1] intermittent segmentation faults triggered by caching
done internally in dwarf_getlocation(s).  A binary tree of location
information is cached in the CU, and if multiple threads access it
concurrently we can get segmentation faults.  It is possible to
compile elfutils with experimental thread-safe support, but safer for
now to add locking to pahole.

No additional overhead in pahole encoding was observed
as a result of these changes.

Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>

[1] https://lore.kernel.org/dwarves/080794545d8eb3df3d6eba90ac621111ab7171f5.camel@gmail.com/
---
 dwarf_loader.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 4789967..598fde4 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -450,7 +450,14 @@ static bool attr_type(Dwarf_Die *die, uint32_t attr_name, Dwarf_Off *offset)
 static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
 {
 	Dwarf_Attribute attr;
+	int ret = 1;
+
 	if (dwarf_attr(die, DW_AT_location, &attr) != NULL) {
+		/* use libdw__lock as dwarf_getlocation(s) has concurrency
+		 * issues when libdw is not compiled with experimental
+		 * --enable-thread-safety
+		 */
+		pthread_mutex_lock(&libdw__lock);
 		if (dwarf_getlocation(&attr, expr, exprlen) == 0) {
 			/* DW_OP_addrx needs additional lookup for real addr. */
 			if (*exprlen != 0 && expr[0]->atom == DW_OP_addrx) {
@@ -462,11 +469,12 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
 
 				expr[0]->number = address;
 			}
-			return 0;
+			ret = 0;
 		}
+		pthread_mutex_unlock(&libdw__lock);
 	}
 
-	return 1;
+	return ret;
 }
 
 /* The struct dwarf_tag has a fixed size while the 'struct tag' is just the base
@@ -1194,6 +1202,10 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
 	int loc_num = -1;
 	int ret = -1;
 
+	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
+	 * when libdw is not compiled with experimental --enable-thread-safety
+	 */
+	pthread_mutex_lock(&libdw__lock);
 	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
 		loc_num++;
 
@@ -1230,6 +1242,7 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
 		}
 	}
 out:
+	pthread_mutex_unlock(&libdw__lock);
 	return ret;
 }
 
-- 
2.31.1


