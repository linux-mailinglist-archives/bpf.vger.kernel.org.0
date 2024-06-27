Return-Path: <bpf+bounces-33233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E71C91A238
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5661C213DD
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9509613A409;
	Thu, 27 Jun 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EKcDkU+s"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C871139D0A
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479367; cv=none; b=JHS9hDgmKBVCKqzd6vBYM+M0GzUmkueagBdJmuhivWIj7w4dZfFVUXzqquxe7PWt5LN6/VZQqFd9BYfx6Gr4NKLivWzTfgAmnLwmsdR/t9fwLJnrH+w9AyRyTxmxW/6bgXr3TRYqSJ1pJvE1qmLZfffO4jg72NO4WmTnISxNEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479367; c=relaxed/simple;
	bh=CMDoq7koA9F5m4zBtxZnvx6BijJnJYY2D1BNNSwvY/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+k3T22AvFsEER7BOIEgujghtBrObNQWppMu6UPrE/T54Kfaozhxt947x1cidnhItG3WzBjWyE/KtR+r3rMMaZSGc/j/WkcWpo6JD2cdNI4by4HaETkwptdQkQ012nskkjqiJChy6aVrES5ce3AT7yPu9aLN0g8lnFbabKK5jog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EKcDkU+s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R6099r011732;
	Thu, 27 Jun 2024 09:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=HyLG7cKBYvUHQ
	YdtIvtPnTMQHq80LRV6ShZUkjpj0z8=; b=EKcDkU+s+JP/d2MsLbEhEd3zgiqo8
	t9os45ct+nTOX5CrepK6sPoPbljEMWYQf3l+QYR06ZWRrLCYM2bz64rwpPJgJ378
	lnARMCq8i0aV5aiDQ5y8t3bcpIsr1IUcza2f8MI6cBTtrcxx8oWwAhqz0rHnVzJS
	sQrojE9+oo+lbEoCzFlaN/Kxu9XJYRZdPnLijFMisVANuZPAKpWKpgLnaGVpqiws
	ZvoH8kDT12GzLlJanoEMnwmqzaJaZcQY1H6gqMSrJI4SO7h4EvCnmK7EWDXIVvvr
	ozIRkAGKDVOiKgpSQNst5YBoXo1X+25+oSnXayZQr3kqscimuz29Rf7vA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4012dcrfs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R8dABn020058;
	Thu, 27 Jun 2024 09:09:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5msn05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R996Ab51052826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00FE92004E;
	Thu, 27 Jun 2024 09:09:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 728E02004D;
	Thu, 27 Jun 2024 09:09:05 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:05 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 04/10] s390/bpf: Land on the next JITed instruction after exception
Date: Thu, 27 Jun 2024 11:07:07 +0200
Message-ID: <20240627090900.20017-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627090900.20017-1-iii@linux.ibm.com>
References: <20240627090900.20017-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aopkr0rt9ehl4sxq7k3_XBnghz5lloqq
X-Proofpoint-GUID: aopkr0rt9ehl4sxq7k3_XBnghz5lloqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=825
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

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


