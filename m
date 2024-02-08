Return-Path: <bpf+bounces-21495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC384DDB9
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73F21C27ECC
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AA6D1A2;
	Thu,  8 Feb 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K/5dDrtL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F76EB67
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386525; cv=none; b=k+7BhinBnJl0na6J9Zux0y82NgcfkfzlBSvB/+yhwQQ+525Ssq8xE5o8hL3HZgS6RYje0gFYGBfWJt35QjsjIIvv50M+N7TcLQ9iEQ1mcYuYVJfa8UNKaBv1QTORc4Zf2CnS+HstWYcQcjzMBnwYWclnd6YAno3VWzW+nPwAbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386525; c=relaxed/simple;
	bh=/P7ZDwKvSw+sdDJwfU43ooP2HA8t+o0zMEjb+kApWuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UixN2ZASy9Z2czEVIptGUKrhJQmpz4R+LyJ+oThb5yseaaATcVBSDdC5tlkEBc8faJ8S2rfgQVcmDD5RR5/NdmmuDTNSJXFlDKbkUT7vDtgEsb6LxpajiTR+JFOjNvq5uBDygcYb42uhNoGNG965mI31gYebZhaaZWVPVsRVAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K/5dDrtL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4189cIfn002459;
	Thu, 8 Feb 2024 10:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=RA5fMLvfklmgM5nih9zxYbGmEDH/osLoWCH5ihUxIe0=;
 b=K/5dDrtLXYCF5qv1oxuYRWpLCrd5JA10VyBJy3TUYTrDSSMdM3pgAuh/yA4dLxSYjxQe
 74LWvQY49oEVfxjphRh5mBdOetlg1mTZ1CghYO76xOXfSNk/baMJ5gzJuwrbuRRCtOIz
 yqKbEfaGzxv0tuMKIwXovbHKShDiKVAfWuvqlU1VvN9FwYmTs4I6xOb5nu+ga9uaQt96
 7oL0Y1Nxxm4bEIB5BZjGW7a17czhBRkw9e6fvjKfXt8gtAMMreEwJ8oRfS2Z7CDb3IiR
 YQpfwyokf5bdP1Z/WHfD/RUKqKZKl0h5IBLPkt9s5SPcU5uiqjZ4MkQHVwRauJF4UsLj Wg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4vg9gfey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 10:01:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4189A2TZ014761;
	Thu, 8 Feb 2024 10:01:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tp3mef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 10:01:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418A1HXJ30802424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:01:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6418D2004D;
	Thu,  8 Feb 2024 10:01:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12AEE2004B;
	Thu,  8 Feb 2024 10:01:16 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 10:01:15 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: void@manifault.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] bpf: fix warning for bpf_cpumask in verifier
Date: Thu,  8 Feb 2024 15:31:15 +0530
Message-ID: <20240208100115.602172-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hOqvcqCUmusPCps6C0H7fWOQXFMbB0mU
X-Proofpoint-GUID: hOqvcqCUmusPCps6C0H7fWOQXFMbB0mU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=619 suspectscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080052

Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
warning:

  "WARN: resolve_btfids: unresolved symbol bpf_cpumask"

Fix it by adding the appropriate #ifdef.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 65f598694d55..b263f093ee76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5227,7 +5227,9 @@ BTF_ID(struct, prog_test_ref_kfunc)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 #endif
+#ifdef CONFIG_BPF_JIT
 BTF_ID(struct, bpf_cpumask)
+#endif
 BTF_ID(struct, task_struct)
 BTF_SET_END(rcu_protected_types)
 
-- 
2.43.0


