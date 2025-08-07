Return-Path: <bpf+bounces-65202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855BCB1DA17
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E78A17DFCF
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC55264A77;
	Thu,  7 Aug 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XDJSwqdb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E57147C9B;
	Thu,  7 Aug 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577741; cv=none; b=sp+EXeJ5d/AF9vHGg323cHERzlEBxguwlMCn2IQnt6QGGOCueDGOafKqldot+mYDpmjpZA7GmLkGVM1TpXot5I5sVz/7Y43VT3zdJGRo2cX4Lfb0/WukykgZ0CshYtyYtdR9Q9HaPgpG4/XAFc5RTAS+7aA1YPpbbNzY58wKA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577741; c=relaxed/simple;
	bh=5vhwdRoUoZuAXN/p69QGR1KXle7xTpZXh9UFzZrYC2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a70opdosoASHGoMe0uncBzFbxEp9QgWHjJrFFs4Aj+LWBLGy+kkJR3j3EzegVBtUrokWdZkk5NV2ndUO5TXKrKVHWEh+lQHkUWwjQ4ptqSWmXIJTEvR3HId/yfWnx/fW+ZXrqOkRJv+6NkFbiX3v3C6LlN9lJXw2L0kQy9WGXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XDJSwqdb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777NdMv007678;
	Thu, 7 Aug 2025 14:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OTrLD
	LELUt4hoWoIcDjI17KLLa4S0Fo0MTU2AC1Z4D4=; b=XDJSwqdbKB7n8/h9t1Vnf
	sv/9a3EsPE2IKQConECAnKEuxjhqf8GuQIouYg/N+E+gwIGc1zkP6jhowvs67RXl
	9U78xQ3gUZ/5uGR1BFBXGDh34UpGKTRsQUYvh1yMwD/fSZZgWGc2QEp7C3BYVL81
	4Z0LV4Coy2MuMl3ooEFzBW5ASUyFJ8WD3BXPOBBn/vnA4JM8U5emhpNpezg7JxBc
	CRnHErBDLiSwyXGoysjnbr5jBfYWRsOLkRZ2854wDXMhEJ5r7ZO5G+L3+TRDwqKB
	07pB+FtAAG53dgeHmGq8E8QYoX9yFqAuIBvsIwsrEw/OsM0c/N31Z/LhPkhHstfR
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy4dp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577ER2Eh005733;
	Thu, 7 Aug 2025 14:42:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwyhw00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 577EgAIt014830;
	Thu, 7 Aug 2025 14:42:15 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-8.vpn.oracle.com [10.154.53.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48bpwyhvt5-6;
	Thu, 07 Aug 2025 14:42:15 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 5/6] btf_encoder: Do not error out if BTF is not found in some input files
Date: Thu,  7 Aug 2025 15:42:08 +0100
Message-ID: <20250807144209.1845760-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250807144209.1845760-1-alan.maguire@oracle.com>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070118
X-Proofpoint-GUID: G2BVlNT1if90gMq2Gm1bZWOnK5jEIxIu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExOSBTYWx0ZWRfX1//nJC/eUOyX
 lPi3w8ED7WLAIlU+St/KEj5CsFqIK6r41S87tkm0XTo+xfRQ8eHuL/Q7eXnzyV5oooooZSZIGm4
 qg75iabLgibwGAxAU0vOqikySHrBCdlJEAewVBzHBqDv97kTMPfLjPNlo9RLWlEAxOa6i1NPSrn
 zKu6/1Ob/aWIOLduiB3RkXaaN67rpTzSzdWZaxSsw6rYxlTM4ez9ieQPFHPFimme1X3kyjTEGMk
 5kDFjcgJiWI9EtvkIpUdhdAApqMY/mWwRpax3aXin3tqHU+P3fErITH1rNI/76H30Q1HtCaCf2J
 3AetrDusRbBPUV0+yFGfLTyZe9AgRAMgbfGXnjlFZotYF/G2o9orvdh5387Xibhj9KsJMCn0BCZ
 sQ3on1FTwb7XY1llWIKYOXZhyP8tC1TTmoOPmZ5jtFNJd2ZxJERK3St/VdSUeHACDhajkyoB
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=6894bb49 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=PBXSyQl6t6HQkZJ5:21 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8
 a=Rz7FqSVgpgXAa5yxgpcA:9 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: G2BVlNT1if90gMq2Gm1bZWOnK5jEIxIu

When encoding from a lot of object file sources, it is possible some
will not contain BTF, so if --btf_features=encode_force is set, drive
on as long as at least one _does_ contain a .BTF section.

With this in place, we can test how gcc -gbtf generation across vmlinux
works in a simple manner by doing the following on a kernel build which
specified -gbtf in the KCFLAGS environment variable (tested with gcc 14):

 pahole --format_path=btf -J --btf_features=encode_force \
        --btf_encode_detached=/tmp/vmlinux.btf $(ar t vmlinux.a)

("ar t vmlinux.a" gives a list of the object files comprising vmlinux)

This is no substitute for link-time BTF deduplication of course, but
it does provide a simple way to see the BTF that gcc generates for vmlinux.

The idea is that we can explore differences in BTF generation across
the various combinations

1. debug info source: DWARF; dedup done via pahole (traditional)
2. debug info source: compiler-generated BTF; dedup done via pahole (above)
3. debug info source: compiler-generated BTF; dedup done via linker (TBD)

Handling 3 - linker-based dedup - will require BTF archives so that is the
next step we need to explore.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarves.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index ef93239..8b37b13 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2948,17 +2948,27 @@ try_elf:
 int cus__load_files(struct cus *cus, struct conf_load *conf,
 		    char *filenames[])
 {
-	int i = 0;
+	int i = 0, loaded = 0, failed = 0;
 
 	while (filenames[i] != NULL) {
 		int err = cus__load_file(cus, conf, filenames[i]);
 		if (err) {
 			errno = -err;
-			return -++i;
+			if (conf->btf_encode_force)
+				failed = -(i + 1);
+			else
+				return -++i;
+		} else {
+			loaded++;
 		}
 		++i;
 	}
 
+	if (conf->btf_encode_force) {
+		/* If no files loaded, error out, otherwise return success */
+		if (loaded == 0)
+			return failed;
+	}
 	return i ? 0 : cus__load_running_kernel(cus, conf);
 }
 
-- 
2.43.5


