Return-Path: <bpf+bounces-33494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB9391E0D3
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C461F23687
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51415EFB4;
	Mon,  1 Jul 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kCvM4Kd7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB115ECFF
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840902; cv=none; b=M7sRMOHNU9iPIwSwbplz3bVzlwXTMSijOh5AtywVclMzgigNcRx7L2qpyEkxN4eRZAujhkzmDV0vLFphp9wtyWzYDkJBJTd1taVcp0FfCPFmbeHGT/WuG9SWZuiy6uzNM1gKEP1GCE4zkkENiM0DpUkDQdAGulWfg4qVOFnw5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840902; c=relaxed/simple;
	bh=IDwdYmgcPWR3s5soAxD9qGsJ4lExdKHyTUPWBYYcw8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPXS/jLl/6GtKAItck8aCL37SvwYZHNwLlhsAFsHRTVnimOWs+h9wK6hGcwT81EcJMCQk9VLugK+01TEM/CLNBPztmtOed/UbegzR/x/I9vHbmNOH6AS36/wY/LBsImVgsh4DVwB0+MKFmX5RXch8uvuyhC2XVltSGkXLImdsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kCvM4Kd7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461DU8qs006526;
	Mon, 1 Jul 2024 13:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=km3RowtczH2in
	e0nckkJiV8lv/3lCTELZsofM8ofzns=; b=kCvM4Kd7QH1P4s7Lp6PAscTv5oBBo
	6vwvRSmRqHU/Ae1G9vEOAvaysdqxPxq4kU7JxaGMmZteHQqwbAfcQ3LujusG7u6f
	qEKAKp/UkaBSjnDhE4E29hP7woZPcpG+mI9gwONBIiCBe1fSCJ8uWBZnvdyY+1GE
	MTayseYADn9rzmkCfGX22KsrPW+JO95oDrHOaZUgyZKCWV90jsmQnm13cXnKkaRt
	nZg01fwdN1OXbAk4nXynFLT0MCdALoSyWueITJ7ij13Ne3OK6QFBtEcv1WEAOldz
	LOvG3N0ckO/Ejo8gKvwYJAUZvkK1KKHMzI7EfFzriIorC7T1fU1auwzDA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403wcgr0gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461Bu62B026409;
	Mon, 1 Jul 2024 13:34:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpqer5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461DYZud54198576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:34:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF9F20043;
	Mon,  1 Jul 2024 13:34:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E27220040;
	Mon,  1 Jul 2024 13:34:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.5.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 13:34:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 01/11] bpf: Fix atomic probe zero-extension
Date: Mon,  1 Jul 2024 15:24:39 +0200
Message-ID: <20240701133432.3883-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701133432.3883-1-iii@linux.ibm.com>
References: <20240701133432.3883-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: chysnnjfmJBy8e7FUb5lGOBLEndo3u2O
X-Proofpoint-ORIG-GUID: chysnnjfmJBy8e7FUb5lGOBLEndo3u2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=921 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010103

Zero-extending results of atomic probe operations fails with:

    verifier bug. zext_dst is set, but no reg is defined

The problem is that insn_def_regno() handles BPF_ATOMICs, but not
BPF_PROBE_ATOMICs. Fix by adding the missing condition.

Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3927d819465..e25ad5fb9115 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3217,7 +3217,8 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	case BPF_ST:
 		return -1;
 	case BPF_STX:
-		if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+		if ((BPF_MODE(insn->code) == BPF_ATOMIC ||
+		     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) &&
 		    (insn->imm & BPF_FETCH)) {
 			if (insn->imm == BPF_CMPXCHG)
 				return BPF_REG_0;
-- 
2.45.2


