Return-Path: <bpf+bounces-66188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0242B2F6CA
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6AD7B777A
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C50430F808;
	Thu, 21 Aug 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hziyPsnC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3130E852
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776042; cv=none; b=KJusSEnZP0QOcwsA3sUxhSpxQlAF1wijVla6qFMgbTqt2zf2zYE7Yqs/qw9K5hojlbjI5yDDNEVrDRTkrR9VEQLezcXUrbimb+hpSB3HYQ5UR7kecYGnGXs0/+fMwnja7h3jinkcLgJbiXHqQaDT0xosg7NpRIgGjjkvqHfds3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776042; c=relaxed/simple;
	bh=grZgC+8yEYWS1W3A79qMVGZGbuklSdx8hLIh/D9ctbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFYsuZk3t3tRl3n7GZ5Q1kyVUzvkIDjKH8RtjQl1d3haQ2U9D6NYaf4JNBYF3gcvAWEwuS+4iCYGhQvDOI919bXT/oQLPWkSr/wJ4ql30jAIBbM9NoPHj6axtdm2cKzMQkCt1ahDX3U52h7Khu2imEi/y5S/5PTAiV8D6SkMnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hziyPsnC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAdv3W012217;
	Thu, 21 Aug 2025 11:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oNImfZUPJmBBxUBBX
	9KaaIkUHjMnUHai0pfh9qCFg3o=; b=hziyPsnCxI/543E+Hcz0ClMwZ905JVipW
	ykALKhfvo1psbMZNTupYeVt0Kg7U/XOqD2TVraQEntXD7aEl93JaWlzast3aaueE
	pBSmTBhDnqx5Np0pP8lhw3VgjVE762cgfij+6cEok4V6dsaY4jd7qJzdc28TQExY
	WRLCGhzoZ30kTkTXwddQreA8hII0soKcIb2Mj/VGy41/YehLesBOR/ATB77LGpO9
	dwyxyKnjHMp2dmYawrM71tAPOQA3Ej7DxRuHgB6EiqxDqzlmxoNvy073YyfRfZeh
	eBMb0wFK62h9EN+tkNnzxLtbVwHZ+pnIviMjsbNdXB/0ZgAJyCO0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vgbtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LApEkO031994;
	Thu, 21 Aug 2025 11:33:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y82ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LBXhYm53936438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:33:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B64E20040;
	Thu, 21 Aug 2025 11:33:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C54A820043;
	Thu, 21 Aug 2025 11:33:42 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 11:33:42 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Add __arch_s390x macro
Date: Thu, 21 Aug 2025 13:25:57 +0200
Message-ID: <20250821113339.292434-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821113339.292434-1-iii@linux.ibm.com>
References: <20250821113339.292434-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ik3vQYhnpAhRWRpZAx7h_A2IvBosBFIJ
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a7041c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=PxyTHdGiSEegRioac8kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX47LTGh5m1M6s
 cjMKNgCqcbwZ1kNstkc6+dt4y6gN3WyA9OlCd5I+7+1TN+PEqC4gPj/wxNXcvdZl3WVLULC2PCy
 WqK31oYjoIpYJbhI6tdmORnEg73NjY3vBxl2adICTMHR00tc8qc8ni88GNkAaul0fVqYn26JZPF
 5cK/0VwgO33IepPZ4cMPXjcrYSHomgNzMBbBt+cRlL58nY0Oqod7CQp72GNxYETYY0nqR6SA9wq
 3z8VTLk6qQvQH18F5TBzCj6C80E6ISXRqHzfshvn/8p+azTUMDF8651pCEfcpyEVwfG13EljBUX
 GJ88P88EQpHLrTtN3Y0nsX5w69u6l5ExYX2RPezqfXK4/AGaoiKc9GCCP8ktK6aZ6DJ1dHLnfxR
 ey9wcnLNx9HnaELa/TXAW+Cq5PRiJg==
X-Proofpoint-ORIG-GUID: Ik3vQYhnpAhRWRpZAx7h_A2IvBosBFIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

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


