Return-Path: <bpf+bounces-33570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589D91EB80
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F921F214C2
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2ED172BC8;
	Mon,  1 Jul 2024 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HEA7j7Vu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC81741D0
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877419; cv=none; b=jMtzFbZFaRMwZJjyzx2jegXkfQeC0JfYg3FfbUeufVzTu7NExJwTqTgVw0ljGAsbSw+z3pNpW36mSL/WRGvfKxVDoOUQpDdAL4U35KCr+d81Vh6HaWCeOqjfcOrRbIKDsPFfTTE28euaPNJzC0ecNaA8qwjnJ3xnMKAdSOHYla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877419; c=relaxed/simple;
	bh=q0zmxxiOASIzNQEq8lSojTSLWgFCV3pP9hb/FzsGJLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOEG/y8e83mgM2qL/fU4NvWtqdSMPi93LK0P0Im4Zbo886Pudd1qnsJgUDB74tDYZDcrpE72GyB6qZACupbj8b9+eNax/Ksr6jTvqv8uetcWE3qTCWufHMBXIvECNdHLWqbFAgRuLX6IGDDof72pArAfDGUOJZr0rvpp7/8ghzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HEA7j7Vu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461NSrfH016138;
	Mon, 1 Jul 2024 23:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=94zPWmcXTMqKw
	lHxjsbuirIowqZOlxzhAVA9AKBy8tw=; b=HEA7j7Vutypgfl82qx1ZiGIm+cUk5
	xTH+w9eOiell3N/MWHHUecBdJYdGDHeBfRZsPFAiEoTM8Zib6ErMYoau2Q7iCCnA
	kzXAl8yKOoLT+7xtzDr9GL0hmGn6nqsQiUOifgFvANIT5aZw1M6DPpbeyh15n8gM
	su0af2Lt+bJXdSk/R5kAl+AeRJcrJVR669Hn9Weet4/S2t0IGB8I1mRal/2tnhRv
	/h84//cF7xlVGfoh49e6qR72z8Oz1MIUmKoTUpuKjM8PpXICJIEp4dc9G4JfotAu
	1QiLNZbDg3jmOJIS5Au4+BX7FGBBQJI+zR5oyxTMqzlKuNaKlvO433H9Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40465g80sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461LeXYS005953;
	Mon, 1 Jul 2024 23:43:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vku24ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461NhE6h49676734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 23:43:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F021F2004F;
	Mon,  1 Jul 2024 23:43:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7915320043;
	Mon,  1 Jul 2024 23:43:13 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.65.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 23:43:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 12/12] selftests/bpf: Remove arena tests from DENYLIST.s390x
Date: Tue,  2 Jul 2024 01:40:30 +0200
Message-ID: <20240701234304.14336-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701234304.14336-1-iii@linux.ibm.com>
References: <20240701234304.14336-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bt7xB06RbMWNhZNq7SqvGl2q9HRx3nmw
X-Proofpoint-ORIG-GUID: Bt7xB06RbMWNhZNq7SqvGl2q9HRx3nmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010174

Now that the s390x JIT supports arena, remove the respective tests from
the denylist.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index c34adf39eeb2..cb810a98e78f 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -4,6 +4,3 @@ exceptions				 # JIT does not support calling kfunc bpf_throw				       (excepti
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
 verifier_iterating_callbacks
-verifier_arena                           # JIT does not support arena
-arena_htab                               # JIT does not support arena
-arena_atomics
-- 
2.45.2


