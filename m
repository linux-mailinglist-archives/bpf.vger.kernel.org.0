Return-Path: <bpf+bounces-33490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE391E0CB
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858A11F22DBD
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B215ECEC;
	Mon,  1 Jul 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="INlM3cYo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C615ECC5
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840899; cv=none; b=t52ApZGY90+7Ey1ctgrLGLY3w/vrEvIvdXaQLt/51grAwo905SCANh5K60NIH7DEP9/s7OKrI4dDf+yWHEjbcDA3sMm6E89R0Hf9KPyDO+M/GgcKauhJINsOR6KgcAV5dHizpMTps7GXVdzZ4nv0j7gpiC9K/O/Ip0idxzU5+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840899; c=relaxed/simple;
	bh=QHzT5BWkXXxyEISDPlHFqxf+bFfTZdX0GiZjPvMfexQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSGimQcJpjBlTKi/fijj6lOHemw2jd++VT1NZEIfWfmKZWiiY/rejXKgpyok9nugOdVq5VMjViSeYvpZY878NjrvLszc09Xq6Z5TTfUQacsGp0CtB/Sy00H9M5qOPe0NnbYHG1/cHP4dCkmCJSLL+daCCq8n7fBlsgxXrX9moGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=INlM3cYo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461DL6d9029609;
	Mon, 1 Jul 2024 13:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=oBCW7ApJhpCFX
	4EyNprymqi7a4pIqPmVdokLSSJpoi8=; b=INlM3cYox4xKY5kE6FZeh7DdpVy1V
	dL2sxZDJElsmWPxtEmH2dh8cNOci0WvUEtLIrFtgnNtxyiWsTlDKGM27bZC+zwhW
	jjCEoDSpQ3mDIYdnoA7Z2zuyW/mLvCxwcjDW8G053wmtCe9fnduNaflfwgAi/AeK
	zCaRxGrCmmZM8cIttYTRKjrF8vkdwax79R8JqD9qP6vLyWOd9bB350UdqsmSJVrN
	bm8Hvku9CclxhwDVPI9raMxd5M7v7xBwkFyFDlWHIPJQ+ywpNt58x6xJ0RbRdMVO
	IHDzI9yObeapFWyhlkYRj3xRmKjrmqo3al8KaO3UajV1/Rbj1KgfkvdHQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403um08des-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461CtVV7009529;
	Mon, 1 Jul 2024 13:34:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtmf7ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461DYcPj49414614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:34:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF9502004F;
	Mon,  1 Jul 2024 13:34:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5657220040;
	Mon,  1 Jul 2024 13:34:38 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.5.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 13:34:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 07/11] s390/bpf: Support address space cast instruction
Date: Mon,  1 Jul 2024 15:24:45 +0200
Message-ID: <20240701133432.3883-8-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: HMJetvrcGGUBRgN_tc4TUPUkTOWBOU10
X-Proofpoint-GUID: HMJetvrcGGUBRgN_tc4TUPUkTOWBOU10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407010103

The new address cast instruction translates arena offsets to userspace
addresses. NULL pointers must not be translated.

The common code sets up the mappings in such a way that it's enough to
replace the higher 32 bits to achieve the desired result. s390x has
just an instruction for this: INSERT IMMEDIATE.

Implement the sequence using 3 instruction: LOAD AND TEST, BRANCH
RELATIVE ON CONDITION and INSERT IMMEDIATE.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 4b62b5162dfb..39c1d9aa7f1e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -54,6 +54,7 @@ struct bpf_jit {
 	int prologue_plt_ret;	/* Return address for prologue hotpatch PLT */
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
 	int kern_arena;		/* Pool offset of kernel arena address */
+	u64 user_arena;		/* User arena address */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -863,6 +864,22 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		}
 		break;
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (insn_is_cast_user(insn)) {
+			int patch_brc;
+
+			/* ltgr %dst,%src */
+			EMIT4(0xb9020000, dst_reg, src_reg);
+			/* brc 8,0f */
+			patch_brc = jit->prg;
+			EMIT4_PCREL_RIC(0xa7040000, 8, 0);
+			/* iihf %dst,user_arena>>32 */
+			EMIT6_IMM(0xc0080000, dst_reg, jit->user_arena >> 32);
+			/* 0: */
+			if (jit->prg_buf)
+				*(u16 *)(jit->prg_buf + patch_brc + 2) =
+					(jit->prg - patch_brc) >> 1;
+			break;
+		}
 		switch (insn->off) {
 		case 0: /* DST = SRC */
 			/* lgr %dst,%src */
@@ -2076,6 +2093,7 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	kern_arena = bpf_arena_get_kern_vm_start(fp->aux->arena);
 	if (kern_arena)
 		jit->kern_arena = _EMIT_CONST_U64(kern_arena);
+	jit->user_arena = bpf_arena_get_user_vm_start(fp->aux->arena);
 
 	bpf_jit_prologue(jit, fp, stack_depth);
 	if (bpf_set_addr(jit, 0) < 0)
-- 
2.45.2


