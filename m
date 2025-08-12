Return-Path: <bpf+bounces-65429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D470EB22A77
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601085A2EF6
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F82EB5DB;
	Tue, 12 Aug 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e22NiYDr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDEA2E5B02
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007966; cv=none; b=IZeqbFtwHY5cxPXZiWgMbBwHX3pEYUPUBiX8Ky8W8ufhkqGvkB9mxaZxI5mMXOE5ogn0h/oFXgs8i1T9ncDNg/sQHV/GX1vcFH8rj3nw+em+XvLaU6MQqkQ0WmjrFi1OeX/lWV9awUjGogrgrVrOdI40+JqA9JLyLTwYKlUOJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007966; c=relaxed/simple;
	bh=w+n2cwW7gTLmoxYnilRXuee6ORcQYyF9AYGE23HDsMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1ViizgYQofL+XJVoedDYc6wyTgOJy3xAKTiqs5qRYDHEFCPHl9tiha8iE+mFB+uIdyLTEeLj6DfrqScW9YAYGPZhF5x47YPcN7YBA0YBgd2IMpnmSXI9gUNd1HIm6jGTfLsBW6Sfl9+v4ywlkID6y+DpVKpx8fsSBauopJ934k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e22NiYDr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CE4jjY017480;
	Tue, 12 Aug 2025 14:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Bday8CVJlRizKg429
	r3aWfWhS98tNySFv6vxnmR4sCE=; b=e22NiYDrBUBXJP1D5gZ5BvLGbTBDo+IY4
	fQCj8QHNOrcLgFtgVqGpid685IEbZ8H5INLR+hRT9ixgQ4NOBelORi91ycLhb9Kr
	J6zGgywGlIpabe57Asb2NP/3ZX6YPwW9X+gleAcYYVWJyKNwFaKgf2Kq4mEG45eK
	/dnNx8cNQfR6xfMlRlqIofMaTdQ4Gu1bsx++TRIGxWEeg+GLIAiM+hGyw8mc0c3p
	O67fR+6AIlFAt27VuKlv8nChdZbpYQKG+14lLBzAumVMbS6SE6Yyz3XwCy4wPMtF
	5nW8BF2W3kknjfxp2eq6IvOdM8K/wfGTHNwcWYnkLLmhGfIz4LNPw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaa32qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:12:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CA15M9028629;
	Tue, 12 Aug 2025 14:12:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n2k31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:12:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CECKtu40763712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 14:12:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E489620043;
	Tue, 12 Aug 2025 14:12:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79D592004E;
	Tue, 12 Aug 2025 14:12:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.48.128])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 14:12:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/2] s390/bpf: Write back the tail call counter for BPF_CALL
Date: Tue, 12 Aug 2025 16:07:51 +0200
Message-ID: <20250812141217.144551-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812141217.144551-1-iii@linux.ibm.com>
References: <20250812141217.144551-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689b4bc8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pAWVCH5PS7jakKlMGnsA:9
X-Proofpoint-ORIG-GUID: Bx5I9l02832lRJQuYAqZIWWwtCsLS9CM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzMyBTYWx0ZWRfX3FFHOhP8MoSt
 yqkNue3S02nUs6I1domaFv8ilG7afm0dlfFekhaDFFVIghHwGKPUpZ+htOC9VutCfqw9eORg+A/
 KdxOyW7vDI5DUjO77gcQ/PbDy2J5U1v3zan1iWjhXnPr2BkIFndQvR3k4Vucjfh5sR8kkjAatAE
 e1EJMUsVSDEXy6q4AN/K2Q6QAi43jYYZ9GFJwYg1XHhYqavoBsUPV/6OuG3dXGSVatXvyLXm8Ec
 95NP3YoXpOR9aHMD5NWEXR7WcSG4ieRdfKZOhhcSqZg2x+CTsxAEOm3BWRtNBTeD4/vUNREHMoK
 D+Ccj6FlijeunJqM4epGfyBitygZ/salll7Gkvk7oTDw/i7nrEEqUV95PAG5bGmimyCcuy12vR7
 HfFLZNm2ql/Hepq44jj4vbIc8eXw7aMpnwER65m5mBjbyX3dPvArP7Bg9/MXQeV+2i37n+Tm
X-Proofpoint-GUID: Bx5I9l02832lRJQuYAqZIWWwtCsLS9CM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120133

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
 arch/s390/net/bpf_jit_comp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index bb17efe29d65..85695576df6c 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1790,16 +1790,11 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 
 		REG_SET_SEEN(BPF_REG_5);
 		jit->seen |= SEEN_FUNC;
+
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
+
 		/* mvc tail_call_cnt(4,%r15),frame_off+tail_call_cnt(%r15) */
 		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
 		       0xf000 | (jit->frame_off +
@@ -1825,6 +1820,17 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		call_r1(jit);
 		/* lgr %b0,%r2: load return value into %b0 */
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
+
+		/*
+		 * Copy the potentially updated tail call counter back.
+		 */
+
+		/* mvc frame_off+tail_call_cnt(%r15),tail_call_cnt(4,%r15) */
+		_EMIT6(0xd203f000 | (jit->frame_off +
+				     offsetof(struct prog_frame,
+					      tail_call_cnt)),
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
+
 		break;
 	}
 	case BPF_JMP | BPF_TAIL_CALL: {
-- 
2.50.1


