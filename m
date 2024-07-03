Return-Path: <bpf+bounces-33716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13214924CE1
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 02:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFFB1F22DBF
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991D1FAA;
	Wed,  3 Jul 2024 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lmZiszEB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2B4A28
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967878; cv=none; b=RRAfWscnaYULZHYgfcZ6Rqhp1F37hWaPpBgoPXwgYS3KkpUy1oElmjLoTWlRsTWeK61t4X7pZ6uYRu2ZRfVFFDdhbZTNjOd2oEoF6i4aajY+l9bufgiqUDlZOhBKwSykXx4Z1rbevVYUTofXbtn7WNB4Eomh9uVzQcDDicWiAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967878; c=relaxed/simple;
	bh=WNcxW1wBoAO3H1NSxgvA02fnZlgi8HVLM30t+Ai3yCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWCc6SQB9zf9+xJab4pdvuA60hkkiNsY1RS2GGT6hVdL2sf1t5EZ9UHm+wZ/kY01dlpJG8ZdmrHzz0kNlOYVL8Gij9f+yHvRyvpouAfqy01VoRWfX3E8tp7jId5yjnUNsctyTC7VofRUbf8Zflj4n1fGS8vwZMZBzUyYW5+rSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lmZiszEB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4630hXJD026532;
	Wed, 3 Jul 2024 00:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=AFZXAcqu4rfGz
	/I8EYOA0A2sSpVA7k5+HXugxCY4F3M=; b=lmZiszEBDsM785tU1RZ9FydCA3do7
	OrghU1BRRF0dXx3PDXF2fYL5ywQQUlrKAjHG0ojok4xaKBsxT7Wlw9HR1IMUtQYP
	J1XHCyjNfJVwSSGDpxDv1Xs8N4UhvwstajXD45RZfr8tt1h6cnK2oL1suRPPNzsq
	aZk1NZFTfdW8qMCOK845SAkeuMjo4w70KHFIHYb1mr6wg3/vQibn8boquUXZ9xXT
	JtpODmW4qQ7ck95XmoVLt23ia4mSvUPKU38SA+56q+ZiTRbTsGbPOP6fQz1UhVFQ
	40o3DrexQi/r+avnzs1MO82wUdZk40KOMDYGLCvPkugVZbd2EP4Crj5gA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404upjg3f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 00:50:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 462KxRSI026465;
	Wed, 3 Jul 2024 00:50:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpytu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 00:50:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4630ookY7733522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 00:50:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCA112004E;
	Wed,  3 Jul 2024 00:50:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F7F820040;
	Wed,  3 Jul 2024 00:50:50 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.78.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jul 2024 00:50:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Remove exceptions tests from DENYLIST.s390x
Date: Wed,  3 Jul 2024 02:48:49 +0200
Message-ID: <20240703005047.40915-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703005047.40915-1-iii@linux.ibm.com>
References: <20240703005047.40915-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HocV4ExXl3Hmh1d9EY7zeETDDJIWNeoa
X-Proofpoint-GUID: HocV4ExXl3Hmh1d9EY7zeETDDJIWNeoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_17,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030001

Now that the s390x JIT supports exceptions, remove the respective tests
from the denylist.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index cb810a98e78f..3ebd77206f98 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,6 +1,5 @@
 # TEMPORARY
 # Alphabetical order
-exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
 verifier_iterating_callbacks
-- 
2.45.2


