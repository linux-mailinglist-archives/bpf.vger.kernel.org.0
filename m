Return-Path: <bpf+bounces-36828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D4894DBF9
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9603C1C210EB
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D22C14C5A7;
	Sat, 10 Aug 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aemASHfU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003F43ACB
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723282540; cv=none; b=tRKRXwnV6Ldsrt01jIIEAAD89vFdidY0SrX4xFEcIpj7ylHopzX5uoRht9WzV1abuvWoeFAhSD6oRJtEkU7V8j41HOc9vW/vQI5wqEvlwOuLfn7ZhLTXpB3t+NuRKH0Aq1E2rwBBmX7FO/6+0yKfh/gewzOQQrRhpajuaeJy2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723282540; c=relaxed/simple;
	bh=hcH0iX8GLHoSS+E4ma26FzUQjWPVzECT2v2ju2RzxRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqDuBZfve3ITqEzXjMEMquJkF6c8xmzVBTizSzrFYR9bEY9QQCHctA55cvIhdrfqfRtpDITv7uY45HsWZIlT7eJhgqph6/2cdUbwbA3kROC2fXIPedHOgXyNLyC0pylYkYT7qwk/DCXzEhSPSlSKILdPsVbHEbiiGPyOOCyKUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aemASHfU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47A9RjmO012985;
	Sat, 10 Aug 2024 09:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=WlUg64gGmh9hXf
	4JgAOO+ZgsI91IchSwVWJvza/3w7w=; b=aemASHfUs4uHIvGT0SZOan1FfEz42w
	utfMJ7lgPkDd2yHodfuRJfOKeJisY/Xl2/wMuu93xE4XHQKdt4AM2HXtuHM4lfHm
	JMBPqn5CF2QLFvBiq7jTY478v/9E3vtqTI7uowP++vjU75yQa7tObpi0HwxHIayO
	LbrTXrAy0myTBVGd/fAL3q0A2xiLWxPz/lf8iVzCEL+i1EFqWSi6TnABMFQJWTAg
	GyUFmAMjVvQBFxPkca752nfWs0d3E+kmqOZE2y5j6JfeWIaHPR8SB+GvrwbK+1B7
	cm73Ybu+iSavBEptY9cLosaODOszYkzDHaG0dDjKBIynesc4Lax3DHxA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmcr8rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Aug 2024 09:35:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47A6vC4w021825;
	Sat, 10 Aug 2024 09:35:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnc6r34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Aug 2024 09:35:09 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47A9Z8Uf034564;
	Sat, 10 Aug 2024 09:35:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-204-108.vpn.oracle.com [10.175.204.108])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxnc6r19-1;
	Sat, 10 Aug 2024 09:35:08 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Neill Kapron <nkapron@google.com>
Subject: [PATCH bpf-next] libbpf: fix license for btf_relocate.c
Date: Sat, 10 Aug 2024 10:35:04 +0100
Message-ID: <20240810093504.2111134-1-alan.maguire@oracle.com>
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
 definitions=2024-08-10_06,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=990
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408100072
X-Proofpoint-ORIG-GUID: dZE92NpgNmmSzocuAOu2phhMsf_5qYe7
X-Proofpoint-GUID: dZE92NpgNmmSzocuAOu2phhMsf_5qYe7

License should be

// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

...as with other libbpf files.

Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
Reported-by: Neill Kapron <nkapron@google.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf_relocate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index 17f8b32f94a0..4f7399d85eab 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2024, Oracle and/or its affiliates. */
 
 #ifndef _GNU_SOURCE
-- 
2.43.5


