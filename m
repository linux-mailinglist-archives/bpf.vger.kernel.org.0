Return-Path: <bpf+bounces-33241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F33791A241
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D55283D08
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49491327E5;
	Thu, 27 Jun 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CFkkdNH4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7313AA4C
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479371; cv=none; b=Thlf9ahgDGaXvOLp4C8YL6QrZCh/nvi8Y6Mg14IJhBK5039+Qbnw7Ny2Csjd2x+hXSQP1kwG2SgHHSFjiwo6SZOS12O34MtZmqscW+zswk2Jp0Hs6D/sxo0lsBkkDaz14stOnDVJoJIM99BzkDlfuMz+yqNfmplKlWqbmhOy7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479371; c=relaxed/simple;
	bh=QHzT5BWkXXxyEISDPlHFqxf+bFfTZdX0GiZjPvMfexQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLkKaWOM2aLH92IxBvib/G23cp1RZMDFD0nZkfwoNLNxrJ5dRGZush+Nc+KZ8N8kPxwDWsd/PB1zdLq0C9Lfi8Ng1FqHDqs7gwb+d8PgLLvJvNpYQe6UW3czX37ByROfspTSRenXjUxwCV/9W2ig3ezN4TnNcMCKMMKH+C6LJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CFkkdNH4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R8San5021970;
	Thu, 27 Jun 2024 09:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=oBCW7ApJhpCFX
	4EyNprymqi7a4pIqPmVdokLSSJpoi8=; b=CFkkdNH4YygpHIjrNVFtGI4wjxgLw
	ZhKjPwJiVEBVdtEDZqTWwlaFxPpm5XMBZ7Y581Lhd3Jc7BcTCEMTHBRqW/z8GqZq
	SRJWGIZABzhUd11KoTC91fHfY/MNqE2AUjQUsvXyKiVhw55rcV0qtY4jog8KyWUk
	KXVP3AG5mJbxv6TS4p7+IWt2KmdvqIXXxUTcvyb7ezTVZZRVxFd9HLg3CXnu5iRj
	0WzZC7hTBtsIE41Fxx12s90fslzZVegGcMPaT1uXQSzPRRV0iH/nr0zApxClwnRl
	eiOfI0Pp8KD+6P0Myh+irJBceXbMPIpObvAbqgi9fneiag9WBw5Hzuj0A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4014ks835x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R7FIFU018103;
	Thu, 27 Jun 2024 09:09:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xuj5bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R997Hd46399812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4464D2005A;
	Thu, 27 Jun 2024 09:09:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B58CD2004D;
	Thu, 27 Jun 2024 09:09:06 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:06 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 06/10] s390/bpf: Support address space cast instruction
Date: Thu, 27 Jun 2024 11:07:09 +0200
Message-ID: <20240627090900.20017-7-iii@linux.ibm.com>
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
X-Proofpoint-GUID: HIcfC_jkcOb_SwwnRs-JJdyml9fk0BgG
X-Proofpoint-ORIG-GUID: HIcfC_jkcOb_SwwnRs-JJdyml9fk0BgG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

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


