Return-Path: <bpf+bounces-33568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87691EB7E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020371F227F2
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23781741DA;
	Mon,  1 Jul 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wyyodpl3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AD173323
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877417; cv=none; b=CSDRwDUkHMhMOBz1Ej/BlxB1fHG5mdy833cFlOv9SW6v2/41dNh8G4Now5eqb7eCetpUZfuE99yITuRzyZTsQcJAOn+h+5Fd7ZhGoA+tW2JQoFId8DX+1U7VJQk4oqEzUnLuYp5kQ57fUuBsQrbiZzJCbFiIfdzDQtRlgxx1ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877417; c=relaxed/simple;
	bh=CMDoq7koA9F5m4zBtxZnvx6BijJnJYY2D1BNNSwvY/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8TCMwUI37mf82Uv6xTL1sSdKe2nY3CMf5msBKUfIHkTo/0hD1stDBfDT2B7OFytZVgQGGOghOGrAViFpzOD+0PY81N2OKlQ44O4wT9l5YoPhftsNoKqtm7nH806JW98/rmMJRaLMT28xP4JfY43p059+Sv/teIi+BQ2/5mipdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wyyodpl3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461NSHEu014796;
	Mon, 1 Jul 2024 23:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=HyLG7cKBYvUHQ
	YdtIvtPnTMQHq80LRV6ShZUkjpj0z8=; b=Wyyodpl3e4jmya6XxpllE2RYe/WnX
	LDP5/Skiehxwqt0F/LEdorOqcLCZbPahDGncC9ftFYC5tEDikeIhdD6fcYVNHh3e
	4MOMHBrNKjT5cAZWaSO6YRASjjQk61XAFS+HQ9CA1rhhvTrUf2XvGJ48GYCncGax
	mvjyEFM+MeDdhZ7TvezX9eagQH3zPCcEaqsXkL3XN3yT8KH9GfUCqZNa+7wTgz7e
	9GEz4Cx198dKW/cK7OLS0TGdr3Oqk1YFMfMVAXpa1FzyB3zJrnB/buZTQZJ7koiq
	EUz8FPT/D1wz1TYAMGn4YbM0ae687c5nGGRo781o6KShmEuxKlUPPW+pA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40465g80sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461MTFsf026417;
	Mon, 1 Jul 2024 23:43:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpsun1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461NhAUG49611260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 23:43:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2837D20043;
	Mon,  1 Jul 2024 23:43:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADDF120040;
	Mon,  1 Jul 2024 23:43:09 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.65.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 23:43:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 05/12] s390/bpf: Land on the next JITed instruction after exception
Date: Tue,  2 Jul 2024 01:40:23 +0200
Message-ID: <20240701234304.14336-6-iii@linux.ibm.com>
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
X-Proofpoint-GUID: mO85lQEYQ1UzlvGksWKaf2NIJ9lwko-F
X-Proofpoint-ORIG-GUID: mO85lQEYQ1UzlvGksWKaf2NIJ9lwko-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=879 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010174

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


