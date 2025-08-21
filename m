Return-Path: <bpf+bounces-66183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CEB2F56B
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338363ACE3B
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB23054D3;
	Thu, 21 Aug 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TaUyW+gw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CF26F287
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772404; cv=none; b=Uni5ZLDYOxWTn+bcNaJnGbwwkLOOY3YGBShjq/gmgEVA4WC3x1+xTv0V9sGI24CEe5Kd42I1E/Zj6XN7KLt86K0pBhYzLFczFjHEKev+WTew7MbNw+SaNSZKT4ZuLLdtM4z9y3Cd5gKIAAbul5AAgtrc8061V0p0UqLecpg+cFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772404; c=relaxed/simple;
	bh=grZgC+8yEYWS1W3A79qMVGZGbuklSdx8hLIh/D9ctbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8FMW90pbw3S1dM2EEZvYnZXPdwRY1ndPrVw0JuakuEHA1p1kO3Dkaffi4AOEKg0CbwlL3qldpfDs2uXD36RSCsZs/J3cUIybyM5ocmMd085KGvvunc+AZSh6st8ZZ9JhBdKpByDRJYPl2DnSKbdplBIb+RPi7g9dz8KUQSL6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TaUyW+gw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L5LZvR008088;
	Thu, 21 Aug 2025 10:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oNImfZUPJmBBxUBBX
	9KaaIkUHjMnUHai0pfh9qCFg3o=; b=TaUyW+gwIcBSLjzvaJ5989xStN8Ul5lZI
	3QuWrpP9vn2nSh6ldWq8l9UZdYuzBbxV8H3JDwOE4pmTKmjQfNWMoMtHqH3ThBuz
	K2gN/G6dnsCJDEmRo/0uKlMdUYx/4KNBqyTSIeDdl2q6OZhXCCibGpkRV3vcqMz4
	LImMBk6CHFbPmIIVuWOSfw9L20vLFDwj75cm+Tf2Lna+qPLmFuDitE5DvJOt/lMT
	akGlCh0qI5+rMDK62x1S9W1NboZHOXNfZww9nrttFajumhIoJlxXVV4ETz6smE4y
	Bo0nRr3Wc5kHYL0wo2WSUJXqjEoEYSC1k6ovcOjD1UaK6KfqaJ+0A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vyyya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6o3Pi024740;
	Thu, 21 Aug 2025 10:33:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my5vyuft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LAX1ug44237234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:33:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5D1E20040;
	Thu, 21 Aug 2025 10:33:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75E0B20049;
	Thu, 21 Aug 2025 10:33:00 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 10:33:00 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: Add __arch_s390x macro
Date: Thu, 21 Aug 2025 12:23:39 +0200
Message-ID: <20250821103256.291412-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821103256.291412-1-iii@linux.ibm.com>
References: <20250821103256.291412-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yYkibehqRWFIDwb86tNBfiKrseAlffmM
X-Proofpoint-GUID: yYkibehqRWFIDwb86tNBfiKrseAlffmM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXya5hJDHLOmYZ
 ZOiXvxIcJ/pDbQArQmjBH3QO8A4vUu9DDKtssJvQtwSfMJ+o6F2DF8gV7cjvIhFCOQu/BoH8poL
 9irRnb6eef+bQ4kDHiW97G7/ICu6foy3JinuUJ3fXkgsgg9pVRTUvLJ1nT1uQtY8SiXeEGBT/E/
 iTiXRQ0elPu0ONfZcA1rGr2FaC8VxAA0lpUDAxBzPOO4DVzhuDTG1geBztnJfgEor8En/HqKcVY
 tLNNaJn29OMENzP4MaNtn8xQizhpdYU4O42/6Rg45ktIM8SaEs+UzJuzrcgT6HlpzvWikMNzl7T
 zT8ARWZCHdMBIpeIussgocMY7rWLkfkSR6tAQH1uedZ0U3eQ/DD8bpRwtq7OY6OWtcSFUzx+Y1L
 knNd29+WBDW5u2xX9dl7BK6yThVmaA==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a6f5e6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=PxyTHdGiSEegRioac8kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

Make it possible to limit certain tests to s390x, just like it's
already done for x86_64, arm64, and riscv64.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c1cfd297aabf..72c2d72a245e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -136,6 +136,7 @@
 #define __arch_x86_64		__arch("X86_64")
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
+#define __arch_s390x		__arch("s390x")
 #define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
 #define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
 #define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index e1987d1959fd..a9388ac88358 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -374,6 +374,7 @@ enum arch {
 	ARCH_X86_64	= 0x2,
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
+	ARCH_S390X	= 0x10,
 };
 
 static int get_current_arch(void)
@@ -384,6 +385,8 @@ static int get_current_arch(void)
 	return ARCH_ARM64;
 #elif defined(__riscv) && __riscv_xlen == 64
 	return ARCH_RISCV64;
+#elif defined(__s390x__)
+	return ARCH_S390X;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -565,6 +568,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_ARM64;
 			} else if (strcmp(val, "RISCV64") == 0) {
 				arch = ARCH_RISCV64;
+			} else if (strcmp(val, "s390x") == 0) {
+				arch = ARCH_S390X;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.50.1


