Return-Path: <bpf+bounces-44849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2475C9C8EFD
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 17:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC3328AF19
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8F188006;
	Thu, 14 Nov 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DfwJewut"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB917187550;
	Thu, 14 Nov 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599943; cv=none; b=bNW391SFrU+c6PS67QxERtS0sMXu7tovmC57t5bv/5KIREjz1Im7lkNS5uivt1I2ffL6f0vHJsN5unYoyYNdnEpKNx9e+6PzAhDtp7xF8Q+NAAq8J5zPWc7Dw8/R4d1I4hQphrx6i/tKe8HE9SQKULU4FADx6SxXJxoS8Okvpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599943; c=relaxed/simple;
	bh=hIrLCG53omfoa/gth0dMljiSmJ9oPplGXGL6H4s1t9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgoF5bchlC2ESWOPGaG+2/uMtylEGMS786Gwih271bZrGHqb+nZ2+EnT04vXCslzePRhP2Bf7YIX7WL3WdiOZ08qKW9xH68vfjljRqECdLcX0UW58JTcT5NvM8zNt8XgF6Vv6wNDYGziHAfcV0vXYDHvUsKhGk7sRfKIPsmvWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DfwJewut; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEChiZc015748;
	Thu, 14 Nov 2024 15:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=/Ww6N
	pz6FeI6PRwspBdygNXKp74rvjfyzn1ZkIHpJdU=; b=DfwJewutr0Nf/ElltjXH9
	gzRp7prGUCOlrBsbA3ZkyFpe1h7CisKl/az06adS/MwD6v9pX8pWOYLE9ukAspvH
	ZO13jBHrq0VOpm1/jNd4Yjm9yJ6HWr1uNsL0Ba+qZFENovk/mkEkn9pSuxeg6OUy
	0EGcUwECV/CHCrOmC1QK5uFNME1xxBNObcqllSXgZ6dRWYAS6ad5A4oYBK8xGBmx
	gXIOBD81efYUvjbVBvXjjeXMUoTy7SWoAOhW2uViuKLgqtagU+VDPO2HXvQQjxJ7
	jdnUiEBfnSrb4wz1ZQUujHln/NCOmcSWKTjgE1sjkeGpFDtqSp78BkPFM3nmousJ
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k29hms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:58:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEFMbV8000346;
	Thu, 14 Nov 2024 15:58:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpad7gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:58:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEFwUgk002439;
	Thu, 14 Nov 2024 15:58:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-214-128.vpn.oracle.com [10.175.214.128])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42tbpad778-3;
	Thu, 14 Nov 2024 15:58:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 2/2] dwarf_loader: use libdw__lock for
Date: Thu, 14 Nov 2024 15:58:22 +0000
Message-ID: <20241114155822.898466-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114155822.898466-1-alan.maguire@oracle.com>
References: <20241114155822.898466-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=951 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140125
X-Proofpoint-ORIG-GUID: p7HpRg_Ye_0SDgHzyaVjQPqi2UrTLpXn
X-Proofpoint-GUID: p7HpRg_Ye_0SDgHzyaVjQPqi2UrTLpXn

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
Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/dwarves/080794545d8eb3df3d6eba90ac621111ab7171f5.camel@gmail.com/
---
 dwarf_loader.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index bc862b5..9299c1f 100644
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
@@ -1193,6 +1201,10 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
 	int loc_num = -1;
 	int ret = -1;
 
+	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
+	 * when libdw is not compiled with experimental --enable-thread-safety
+	 */
+	pthread_mutex_lock(&libdw__lock);
 	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
 		loc_num++;
 
@@ -1228,6 +1240,7 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
 		}
 	}
 out:
+	pthread_mutex_unlock(&libdw__lock);
 	return ret;
 }
 
-- 
2.31.1


