Return-Path: <bpf+bounces-21607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFA84F53E
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 13:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974FC1F23162
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D1364D6;
	Fri,  9 Feb 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a8ZJQ4Kj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975862E847
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482177; cv=none; b=FlRlEipqnjr2HpTZB9rJG/j8GolE2IlYNgCqegQH4cexynnUg74nH+x5qtUZ/0xsSr+P+mYofmO9Tb8ErReEB1lmWxv2sTxTL3pp8Thw+0/rdMBV9AL4CQ4S+OGwEGUfaMo31RUQpwn+IQIOTLTfIpU7PD0jVkeJwWJgv9RKHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482177; c=relaxed/simple;
	bh=ttsbX7I0BWPrflzO4B46/VG4Dk/YGNfAARkHA3Fomt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxOjkmSoRL2Zj9+RlouLxT86h4yBQlU2PgE7noXO33jfhPAte4V8j20nyqdLn2eg7ErGAyR38H25WftJ1x7Et3Lbbpu6LQYqjaKLfstD87b6XfKPZ8lWPF/QaVCGoQhYEGPb2AVlmbNnXlKe5U7zf4XzS/QUBMoZHPSI63FI1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a8ZJQ4Kj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419A7MPj018626;
	Fri, 9 Feb 2024 12:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=vubZIESnt7jrvGwvc8I12ElOSW5kfQEZSaDgQBPHH8g=;
 b=a8ZJQ4KjQBWCF+DW1CiZeLNHAdwZQARd0bTtL9YJgAoW/aqfeDmnUABH0b7xWEbyIJQI
 ogAbMWkH8EPf2QeRNc5xiqx7J74YnOD3LGUqR6A7trBb74FAh9FcQ7HD2nJL+AvPSI7v
 /KCjetZoWWO8jkMGiLSUNGuKr2P4X9Cl7WEfaazTkEzzlRSjCyBrGZ54N9QDxy8qyPAs
 F6vanJdbN4cgOTquBXE9hId2+SwN6wdQFbUS1Pitt0NxEFmbg2x685bG6WVmx1yt9C4H
 U5nybpuMmOFplIhs0xiEi7rsherQgsTbHIHEWTzngxaiI8hqxB7Fzv5hY3ezBz7rSZpT Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5j10b9a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:35:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419CR6cK005713;
	Fri, 9 Feb 2024 12:35:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5j10b99u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:35:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4199i4OU014765;
	Fri, 9 Feb 2024 12:35:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tpb4a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:35:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419CZNIe18350722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 12:35:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E05F420043;
	Fri,  9 Feb 2024 12:35:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B7D320040;
	Fri,  9 Feb 2024 12:35:22 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.81.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Feb 2024 12:35:21 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH linux-next] bpf: fix warning for crash_kexec
Date: Fri,  9 Feb 2024 18:05:20 +0530
Message-ID: <20240209123520.778599-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vu9_NhhfI1MMhEB7lQioL_xJ-UTS49Zg
X-Proofpoint-ORIG-GUID: 4l2-SQyZW1ffC1O9ZoSlBmEuNjNUBGMA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_10,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=917
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402090091

With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
to the below warning:

  "WARN: resolve_btfids: unresolved symbol crash_kexec"

Fix it by using the appropriate #ifdef.

[1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4db1c658254c..e408d1115e26 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2545,7 +2545,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
-- 
2.43.0


