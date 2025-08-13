Return-Path: <bpf+bounces-65513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB1B2493B
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 14:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C04567B83
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F02FE59A;
	Wed, 13 Aug 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gjemDkmg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B432F83B6
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087040; cv=none; b=LM9aSVmdVGzvmbMkTUQ29S2r8ghs57ghmE/hT0kUQvkuk7mIur/3FWVmuNFiZUI5yDGVrVDsvY5GJaSCAHZRLnaKdGlrPdiaTfatptOoUzMK+Sw5LAK9LDWzWgg1g26DVROO0QksU8/9ZJXSC2yIpOcanl1pRn+9MsgyhxZiZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087040; c=relaxed/simple;
	bh=YhNRZ4QD05EvNJsn9o4u4N515keMyZAN5uAT7aacVmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG2hUa08ofHdC2lMTIGTizYm+cBUgGuYgL71DJ28tVsrGELFfIax9nX7CitzhI5VKMaP5QXaKQjSXSjW2El4ACPyLQ7ZSJNQ3SxZOaefl5nLIPwNiSsjyuC1XkoTA58WnepK78DR7TfLyrtkCn2X45U5jGlGV+j8lW4Xs9OyyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gjemDkmg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DC6v63011286;
	Wed, 13 Aug 2025 12:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HdVlZDYQoGJX7y3QP
	UBD+d3nb6MbEw4gTMfQM0JQvQA=; b=gjemDkmgXfXLFJEURfVRcsR3ei3jc9crK
	s1Lbe5/W4A7N6purr84kHqv2wItnSQFsDQesC4DyxBdcqF6vtpPkBdrh+Bg5st3u
	JXFzL0ARVBD+x7tZXb+urjHrbm/AIfcMEk1Snp4i1w1OKv5Pi9Fhbpnpy9qACWDA
	Pbqk38P7nVPYXPcTF8iyG3UX2HgajQYl16LnmjCHbckhF08noEMsWriTpOVnLGXH
	etabX0B+mnrx60YB0IHCu3FDHXwTcuJyqfir6gsli2PWxmVJ/q9wUdjrxAxuDuHk
	+Q/iYRiyIEKh7iKgcE8VrZo6QjTL1lV/eTkZukgct1guZQeqhp68g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duruc8uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DAIgSJ010657;
	Wed, 13 Aug 2025 12:10:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnuqccb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DCAKY022086084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 12:10:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6371B2004D;
	Wed, 13 Aug 2025 12:10:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAA1A20043;
	Wed, 13 Aug 2025 12:10:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.48.128])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 12:10:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 2/4] s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
Date: Wed, 13 Aug 2025 14:06:29 +0200
Message-ID: <20250813121016.163375-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813121016.163375-1-iii@linux.ibm.com>
References: <20250813121016.163375-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FQ3S-e0qQuOe0DQ4vJLeFvH6NtKlITC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX54YgjqoJwrAf
 fcFCoV2ZKcF02iE3TNIA3vYwjnplEchHLoZ31+SvXV/3uZXj7NfH7Kd/0Z78oXJWS1RxltlNGnX
 J3N94Ax65OiAE/7e0ernpcItKoU/DPa1TCpkkiJdFeC4/CaMe7Bdw8EtpSDLpIVArJQS1E1rfdI
 Favx0ORT2Hw1btpJRqUFZNfxMPK+WvD5rK9SvUL2yqTRp5h6waW870Uxr4K4q2/V58ct8lcAZHF
 IbJgTE+K81HCpDFri3lHAX04j6nxdPoWG3jiJkI2TeiyUXWzuAkSy1xUtrFElGuFPPXsnMVQovd
 zGjUEgYPXt9dVSiKVK6QAU/r+JyFdnZlUZcqsh9lQ07IMTPu90zg5+KxFarNtnT74cD7ZAPoc0H
 o3Np7XxA
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689c80b0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pAWVCH5PS7jakKlMGnsA:9
X-Proofpoint-ORIG-GUID: FQ3S-e0qQuOe0DQ4vJLeFvH6NtKlITC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

The tailcall_bpf2bpf_hierarchy_1 test hangs on s390. Its call graph is
as follows:

  entry()
    subprog_tail()
      bpf_tail_call_static(0) -> entry + tail_call_start
    subprog_tail()
      bpf_tail_call_static(0) -> entry + tail_call_start

entry() copies its tail call counter to the subprog_tail()'s frame,
which then increments it. However, the incremented result is discarded,
leading to an astronomically large number of tail calls.

Fix by writing the incremented counter back to the entry()'s frame.

Fixes: dd691e847d28 ("s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index bfac1ddf3447..ccb83ac3e6f3 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1793,13 +1793,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 
 		/*
 		 * Copy the tail call counter to where the callee expects it.
-		 *
-		 * Note 1: The callee can increment the tail call counter, but
-		 * we do not load it back, since the x86 JIT does not do this
-		 * either.
-		 *
-		 * Note 2: We assume that the verifier does not let us call the
-		 * main program, which clears the tail call counter on entry.
 		 */
 
 		if (insn->src_reg == BPF_PSEUDO_CALL)
@@ -1833,6 +1826,22 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		call_r1(jit);
 		/* lgr %b0,%r2: load return value into %b0 */
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
+
+		/*
+		 * Copy the potentially updated tail call counter back.
+		 */
+
+		if (insn->src_reg == BPF_PSEUDO_CALL)
+			/*
+			 * mvc frame_off+tail_call_cnt(%r15),
+			 *     tail_call_cnt(4,%r15)
+			 */
+			_EMIT6(0xd203f000 | (jit->frame_off +
+					     offsetof(struct prog_frame,
+						      tail_call_cnt)),
+			       0xf000 | offsetof(struct prog_frame,
+						 tail_call_cnt));
+
 		break;
 	}
 	case BPF_JMP | BPF_TAIL_CALL: {
-- 
2.50.1


