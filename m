Return-Path: <bpf+bounces-66190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FEBB2F6E2
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114273B4CE9
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C223101B5;
	Thu, 21 Aug 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bgccU50V"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1A30F7EF
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776043; cv=none; b=jbAqOwLuXXJM9DvBeddAU6wzxEtCITlbEddiNBJeil+B3dMZvq4Wdn+opqWWMsGrSuATyYpYbO9m6u7gVHMNLtLlSP/wyoJv3m72pXezTytRbwUoAtVxLUuRrWwJh0kAtclZX5dF82RJaBujusS3vtsIKL03PpWw79U3uXsv8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776043; c=relaxed/simple;
	bh=FrWcPuv7C4FxhjrP/KWbPX5XwTc7t22LgQ7b1ftY5nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alY4T+zyfgtvLVn4CDzhOrHnLxscO84xlqY56+qxUeJ55MwcedYtEY0exVvGONkRKgbvPlrqnMusrnyCBHbCkpDKhOUEQub0TlP0KQz+4mZcz69SEz4zuadZoJQ83S6mCCn/gCBUH50gyO/KQrhodOPURHbnxnz6du6kpMzZG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bgccU50V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LBRh6g002194;
	Thu, 21 Aug 2025 11:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rpkV5+0tNS+3NHnJ2
	ZD3MiVnxIbqd7QvoE+IqtvV9BY=; b=bgccU50VAwdXQUjsVqw6SOZsceWr51fMZ
	ddGcD0TdQEMk0oXxViYhtQQHo/H91BeBYoghqkm2pHLdL3a/XZ3H+KCOugc9kt8o
	XgvlJoBbjPkC6tX8PcUm+hYoSjUIgSlHgwc/h8dDZ35F+l8QiBBsNHzvUxXsNdNE
	lmkiQYXdUQZdu1eMW3/IKk9rXezk2TxEQw3CrnukFe7oahPAJaTgvtvRGtO7LTCZ
	4DrfsaGUhOrr0Q3/hyszw3ET4h+3V6zHb0xe5rbCRUAuFviPKWEyjAQVVHRLccCn
	/ZSdWbDUv9+RmkJG2UK7u0eAymFIJ+xhyQztjBPJOT7inEoqS4jgA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w86q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAo4Wu027145;
	Thu, 21 Aug 2025 11:33:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4w8307-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LBXhIi53936440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:33:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8FFC20040;
	Thu, 21 Aug 2025 11:33:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 674EC20043;
	Thu, 21 Aug 2025 11:33:43 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 11:33:43 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Enable timed may_goto verifier tests on s390x
Date: Thu, 21 Aug 2025 13:25:58 +0200
Message-ID: <20250821113339.292434-5-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX8JX6i1sw6J4E
 0w5DaErB7rbTGIBFpCoXFFhlLUHOj0AoH7/BZaq6J3WK3LFk3fmxPlxvRaq+BzRKeVUYpCk9VSV
 KZS7UFf0N+vwfjm3QGSmQHIFArS9khrfmxbBPy8pOrBhZO8fyXpHqeoDjohFellYDpPcIke8MRA
 OZge4oxvqorvgD3MvEZd4FjHUjeLFWJ6sVBpB6UG5x4I0yxSgClRvKOZmnjyLxsteuT5gXIBnCI
 MKLSLD8TR4Kt/jFh/OanTzRwTwcUmaMBoJQ6EOZI/hdOYU8k0szndQR05zk5vNMrRjQC44XVsSV
 9ZFF60drkCai/aUjByBIuOH+epB2pC1UhvnuMl/Mep9nIWAcxYHHcbE8i/OBVC6Y4pFtFKRpJtL
 XDpgQMhCVu3SEHYWUuCrIofnr4IEYw==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a7041c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=FhcJVP5P1EmADn9_fkIA:9
X-Proofpoint-ORIG-GUID: K4rdjLQ1Zf6gjEUiYxzhtI8ldOX2vLDQ
X-Proofpoint-GUID: K4rdjLQ1Zf6gjEUiYxzhtI8ldOX2vLDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

Now that the timed may_goto implementation is available on s390x,
enable the respective verifier tests.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/stream.c         | 2 +-
 tools/testing/selftests/bpf/progs/verifier_may_goto_1.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index d9f0185dca61..36a1a1ebde69 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -77,7 +77,7 @@ void test_stream_errors(void)
 		ASSERT_OK(ret, "ret");
 		ASSERT_OK(opts.retval, "retval");
 
-#if !defined(__x86_64__)
+#if !defined(__x86_64__) && !defined(__s390x__)
 		ASSERT_TRUE(1, "Timed may_goto unsupported, skip.");
 		if (i == 0) {
 			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 3966d827f288..cc1063863569 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -9,6 +9,7 @@
 SEC("raw_tp")
 __description("may_goto 0")
 __arch_x86_64
+__arch_s390x
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -27,6 +28,7 @@ __naked void may_goto_simple(void)
 SEC("raw_tp")
 __description("batch 2 of may_goto 0")
 __arch_x86_64
+__arch_s390x
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -47,6 +49,7 @@ __naked void may_goto_batch_0(void)
 SEC("raw_tp")
 __description("may_goto batch with offsets 2/1/0")
 __arch_x86_64
+__arch_s390x
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -69,8 +72,9 @@ __naked void may_goto_batch_1(void)
 }
 
 SEC("raw_tp")
-__description("may_goto batch with offsets 2/0 - x86_64")
+__description("may_goto batch with offsets 2/0 - x86_64 and s390x")
 __arch_x86_64
+__arch_s390x
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
 __xlated("2: r11 = *(u64 *)(r10 -16)")
@@ -84,7 +88,7 @@ __xlated("9: r0 = 1")
 __xlated("10: r0 = 2")
 __xlated("11: exit")
 __success
-__naked void may_goto_batch_2_x86_64(void)
+__naked void may_goto_batch_2_x86_64_s390x(void)
 {
 	asm volatile (
 	".8byte %[may_goto1];"
-- 
2.50.1


