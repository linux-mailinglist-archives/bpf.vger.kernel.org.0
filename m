Return-Path: <bpf+bounces-33488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2080991E0CA
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFDE2B224F9
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E3815ECDC;
	Mon,  1 Jul 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ozlMnkGj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57D14B96C
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840898; cv=none; b=XeYy8RRPPULCJYbl1XaNHrWgrg9+x2Q5W7XL5kkMpCE70JJFSssHhkR6017DorqkUZvMS3KYtQ/2EicWWDyk3kHyl8WgFFaLLB5LluBsMMPMHqIq+CF8EXtqVdj94+BBgcPXQf3G/NIvCod6qNA/COrSsUy0VzcvAHs3YXZ/Ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840898; c=relaxed/simple;
	bh=CMDoq7koA9F5m4zBtxZnvx6BijJnJYY2D1BNNSwvY/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGOA6jii6jp3/cjgFsC+Bdc99P/hzW0FT5tZocgjg7AzVPdvoBAlIlsuIvsY/qkfnnfbGOy6mn+iuiY/eXyZWJ5ckraaPcTd1fz83Ky/unktoTybEpvXC0RNr99Qkfv8dmR6o793S37/kvyFhLyrAtxyOTc/uHU0oQTRegXLSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ozlMnkGj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461DPJHF015264;
	Mon, 1 Jul 2024 13:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=HyLG7cKBYvUHQ
	YdtIvtPnTMQHq80LRV6ShZUkjpj0z8=; b=ozlMnkGjZSIPZfeA9xM+dYiq+lcTL
	M+0t9x7/O7HMB5UahKrD6b1YFtJHIZBGPl+Cz1/A9raQcbso0AlCguKoXJYFlCnx
	ua2CeLpBtbLs7tM9Aq0Jcavd8hi2UN5fE3DUGXKnpK2RWTtUZUbGHIjmXgtFQyFX
	cTCH59tVMtVa6NGizT/GF+WJcCJrnM2Cpy/lyw7JDX5uEm2ZfL8Z/tgU4fqSURw1
	4wXQKCMgJ0Bcw5miVB+a0/ozmsdAiWBaBl3S+5kL3Pp9ahh7zvx30wfTxRNYCo2z
	iFsaMwLT+YjF7YkLk8CFCs5W6+SG3Q0TJGQ4APdeHDUnpmW03qcfrtetQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403vx6r2x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461ARkMC005948;
	Mon, 1 Jul 2024 13:34:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vktypwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461DYbpR57278796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:34:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A31C520043;
	Mon,  1 Jul 2024 13:34:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29E5F20040;
	Mon,  1 Jul 2024 13:34:37 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.5.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 13:34:37 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 05/11] s390/bpf: Land on the next JITed instruction after exception
Date: Mon,  1 Jul 2024 15:24:43 +0200
Message-ID: <20240701133432.3883-6-iii@linux.ibm.com>
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
X-Proofpoint-GUID: 6umBHlysOPspaYFlBV53k9IakyqlDoG-
X-Proofpoint-ORIG-GUID: 6umBHlysOPspaYFlBV53k9IakyqlDoG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=840 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010103

Currently we land on the nop, which is unnecessary: we can just as well
begin executing the next instruction. Furthermore, the upcoming arena
support for the loop-based BPF_XCHG implementation will require landing
on an instruction that comes after the loop.

So land on the next JITed instruction, which covers both cases.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 582fa3830772..ecd53f8f0602 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -747,10 +747,11 @@ static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
 			return -1;
 		ex->insn = delta;
 		/*
-		 * Always land on the nop. Note that extable infrastructure
-		 * ignores fixup field, it is handled by ex_handler_bpf().
+		 * Land on the current instruction. Note that the extable
+		 * infrastructure ignores the fixup field; it is handled by
+		 * ex_handler_bpf().
 		 */
-		delta = jit->prg_buf + probe->nop_prg - (u8 *)&ex->fixup;
+		delta = jit->prg_buf + jit->prg - (u8 *)&ex->fixup;
 		if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
 			/* JIT bug - landing pad and extable must be close. */
 			return -1;
-- 
2.45.2


