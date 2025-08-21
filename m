Return-Path: <bpf+bounces-66184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F65BB2F56C
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EF53AD18F
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457803054CF;
	Thu, 21 Aug 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A6AEAPLr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A493054C0
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772404; cv=none; b=KdpdHJKITn4H+KDD9m2N/oGjvLXe9/R7pOOWnexoKLteqEMJUTl8WSV+PXF4gCVJYXIvszX6gPvhidN9fxH4+XYaK8gqv0jdHHdKDN08Wb84sJ+2C5Bk5T3Hia9eVT0dhAOHtCFEvtjT6iYaYME60Oesqm7pajXbuEIqj1jYdJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772404; c=relaxed/simple;
	bh=cC0Mw9Jxryrwxdi6voaK4ZtTh9s3o1CrNrdcbulVbVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llMQYy5NH1Nrwx6SnmKtf2200v/RpCUB3l8LE1cWGO+t0bY2HlTcTleyvH9YGHVSSwrO1Zf4ydg/CnwyepgQJg+MnaHdz5jADSpffubTUdcn92E8QxpM+ZjpFT/+Xop1lMGBFQC3zER8DIzrexy4lfOyoU6Mif80zo1xkXtjr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A6AEAPLr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAH0PW002774;
	Thu, 21 Aug 2025 10:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oYbawII9ZLUI6B0eg
	DYOw5ax0uT7crDKzFI+3QTHX18=; b=A6AEAPLrUhvkgIvYByF5dLiN/ZmHcXH4N
	Eo49XB5s4Z1GAYMdcxmb4qGSyRKoOBlF0Ef6f1i3qAAbq2m/3dz/pL1zKUxP4KDi
	SkJxKrJlV2i8o0rK7NYxt9QBBtbOQZLgiO2vxnhsVZZbMS9AUOj3MWtqhP4ecteO
	yelv33Ze4BvW8WdpJ5nJjTwGUgcJ4hD6RLkobVWSx5gGXFzWRD9+PMmR+VClRsth
	0T7O2Pliyf0V6yvaCXQ3KyYOsmne4k7gUv/Pvl8q5Z55tGzuGc+2EYoakRvAkO77
	J/kcJd2Dt0ioi4Qmmozuj+8UNXcTvFk3S64fRnkCBLVX4l/q/w1xg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w7xuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6kd0o026916;
	Thu, 21 Aug 2025 10:33:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4w7vqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LAX1do44237236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:33:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 607D720040;
	Thu, 21 Aug 2025 10:33:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F8A20049;
	Thu, 21 Aug 2025 10:33:01 +0000 (GMT)
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
Subject: [PATCH bpf-next 4/5] selftests/bpf: Enable timed may_goto verifier tests on s390x
Date: Thu, 21 Aug 2025 12:23:40 +0200
Message-ID: <20250821103256.291412-5-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX7Q8ZWHlb4Jd4
 mQEIAizf6Lx0IYAjpgKBziyDflaoAAlbZzNSn4XUUmJCwDZ9AsiU4XAdPvH+yvALmT/wJsBFn5W
 H93uyAMFuqOhiUVYtZgBKX+oWwcEDtTqVm3a80CMBBpB/v7bRRPxhn+DBFcXgGZLHYovttkkNmw
 13r7A6NRd39MbWNhN7p3x+Ch/Yab2ykjUR0eWD1t/RRJNnGAlcS28heNcd4kYikQ/oruQPquNe5
 aqD+0H9IW5vXPd2ZqBl5cX6ePAMrlJNTqgMm+ALb9zM0PuFSiq0QBfoBqT/gWxgc2bUrtsyCBFb
 0trl+XxW446yrJt6M9Cos/YClHqSemArRLfkkhztH32lJfnrR+60jjUN+L5Ln3loFx/4AX1o5T4
 Cbqui8nKQr0yY9TmbONWREwBzC5nQA==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a6f5e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=FhcJVP5P1EmADn9_fkIA:9
X-Proofpoint-ORIG-GUID: dGBfipn7J2Cefu6JURFumv66GsvMyNXh
X-Proofpoint-GUID: dGBfipn7J2Cefu6JURFumv66GsvMyNXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
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
index d9f0185dca61..d89d04832011 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -77,7 +77,7 @@ void test_stream_errors(void)
 		ASSERT_OK(ret, "ret");
 		ASSERT_OK(opts.retval, "retval");
 
-#if !defined(__x86_64__)
+#if !defined(__x86_64__) || !defined(__s390x__)
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


