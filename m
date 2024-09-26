Return-Path: <bpf+bounces-40352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E61C9875FD
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 16:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4BC1F22D2F
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1811531EF;
	Thu, 26 Sep 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d6nXL8cq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00213BAFA
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362287; cv=none; b=mxGUtm252OtAR2ji2azD2BigCpQlA9IIMhMe4EGILrOdEj+U9bdwgYBXGDqV+EkA6DvU85e0gcMAigUwnHlZBlKGRKzzUuJnxY/WLsuWwI7EnZ8C9gMgeXcSEQjZ8mENmYgrDMFhkS83kDB38QPYMU3XftZalk8FjQghPy0uDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362287; c=relaxed/simple;
	bh=xXyGOsYkQjXqrvrSYZy8VsvGpulhxFWZQOCiyIreBOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rsTDkmo1LM1Ot6MOfPRJ4m7U48ALrPMt9WuFFOesjxCc3ffiuMCQ8U1WW/WT6+8r9AWZ7eZbP8sBrAqCr7E+0Lh6OWkUrVsXUirbSdbHcOY9QNNZKM/pnpt5v7n18sgTQRKyPWv6flZ4nQwyaHU0TiyRNH8ac635Zr00srziAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d6nXL8cq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QEXYcm002683;
	Thu, 26 Sep 2024 14:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=7AFb/1lSjg/mMF
	OVRQ0sReqiumdeuZqIkda/iHgM6LM=; b=d6nXL8cqUP9QYcYUaMpXZdcEGGSuoO
	0KtT9EEPr6HbrSrgDMr0bCSE1USNTlsgx/Lh+L+yt+QGl17a79Lw7HczjhdDfq8d
	rRCeDGgIcwytzRqxY/+8yZ55yxk64Usuoe3TexdwyUegEbqBM4/44j3ZV5St7/j1
	9i4gH8KYn86pEAH67DB5vgk5pEsF9N/kkOd9qP2nk5liJReXTyJsSrCmyx1S15+T
	JURglEL2bj2TEaK4ZXz2nFMcT5+JY977tJ47Q4472DQKBe4sJJ2FXpNG9u3SalN4
	kRBWwMs8zOxV5gjs7vopgBvHQpW+Det/Ednd2rqSW7Aa9BKzp5J7uq3w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6cjyu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 14:49:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QE8Djb026081;
	Thu, 26 Sep 2024 14:49:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkc6r3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 14:49:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48QEmEba031138;
	Thu, 26 Sep 2024 14:49:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-179-78.vpn.oracle.com [10.175.179.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41smkc6r03-1;
	Thu, 26 Sep 2024 14:49:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] selftests/bpf: fix uprobe_multi compilation error
Date: Thu, 26 Sep 2024 15:49:48 +0100
Message-ID: <20240926144948.172090-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260102
X-Proofpoint-GUID: 4WnzM4rHu5LX89y7eqX-P19TsbVq9Qjy
X-Proofpoint-ORIG-GUID: 4WnzM4rHu5LX89y7eqX-P19TsbVq9Qjy

When building selftests, the following was seen:

uprobe_multi.c: In function ‘trigger_uprobe’:
uprobe_multi.c:108:40: error: ‘MADV_PAGEOUT’ undeclared (first use in this function)
  108 |                 madvise(addr, page_sz, MADV_PAGEOUT);
      |                                        ^~~~~~~~~~~~
uprobe_multi.c:108:40: note: each undeclared identifier is reported only once for each function it appears in
make: *** [Makefile:850: bpf-next/tools/testing/selftests/bpf/uprobe_multi] Error 1

...even with updated UAPI headers. It seems the above value is
defined in UAPI <linux/mman.h> but including that file triggers
other redefinition errors.  Simplest solution is to add a
guarded definition, as was done for MADV_POPULATE_READ.

Fixes: 3c217a182018 ("selftests/bpf: add build ID tests")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/uprobe_multi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index c7828b13e5ff..dd38dc68f635 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -12,6 +12,10 @@
 #define MADV_POPULATE_READ 22
 #endif
 
+#ifndef MADV_PAGEOUT
+#define MADV_PAGEOUT 21
+#endif
+
 int __attribute__((weak)) uprobe(void)
 {
 	return 0;
-- 
2.43.5


