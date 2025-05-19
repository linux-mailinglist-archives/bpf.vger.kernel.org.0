Return-Path: <bpf+bounces-58510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE7ABCB05
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 00:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9EA1B63F8E
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B021D3C5;
	Mon, 19 May 2025 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZY3Lbc/h"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E22192FC
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694231; cv=none; b=DRvgHhouSJMMRNOfdVXP7sKnKhtqjIEmfEQRrrhuGoVQkcihqGE4L4gXFzcHHQ1PTIjmFJd80PLsDYcmxI+MY9km1lzX+hf32UIqqxJiExlIK4K83itGtkxs5bmfETJX0/v5Yo2q4CRwrKWzAf3/dxY7coNjo7EzD4YRDkzVdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694231; c=relaxed/simple;
	bh=CRYnrk5FrjFOgp6n7i0rE6HDU7p9MQpKVOKmUfIeqp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7FFzYbkR2Hsj7O8e4dazJclFjM2SLD3Akk+j3wC4gChuY2LFgc75xHVRNX1iuPLEihqNfDMQC4InGevjQKERVtfXYePmhLwhborNnxVKclzvpGyEeQ9VBTjgWUW0LxZg5JTxAIC8nJjls+FQS0DfLslOhPPqRmwIIXBQHGBEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZY3Lbc/h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIsQAG012085;
	Mon, 19 May 2025 22:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Pv7SNTNSwsPWF5rgC
	vlLQQ//JscUidFJEl/vDTZ6mUQ=; b=ZY3Lbc/hZ1Rj5xVfwDcvgT6hMM7w+M3f5
	10jnothxRid4Yx+L+/LHXKvf71PBaeST53Kq6pUB0nJq4libZ0MaZcpzvD/X3jlD
	LC7kajhWSSgwm5eNhAd3KpfDL2CwK6c7lgDMX32oFKyWSGfGlLDgE80ro6s0E9Qs
	aHlQJpaMMn4fK6tgEyBjvQ2kVgBp2jKgkIr0NfvxZJ9HCVumq9K4eb5M7DVBOemF
	wAHgwYbca6Q0OjfxhOXAgqEaUnUVdkM485jGn26dEUaj8dYadEayOsxu/52Pfjqw
	EWmxnUBe1rg0rjlYnWvAmChmbAlkr42RgB5fSnH0jNtgsn/zECIWQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rab70s5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 22:36:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54JMSLVP005356;
	Mon, 19 May 2025 22:36:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q69m8ryk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 22:36:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54JMaoR255509420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 22:36:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D85182012D;
	Mon, 19 May 2025 22:36:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C0D92012B;
	Mon, 19 May 2025 22:36:50 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.111.59.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 May 2025 22:36:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] s390/bpf: Use kernel's expoline thunks
Date: Mon, 19 May 2025 23:30:06 +0100
Message-ID: <20250519223646.66382-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519223646.66382-1-iii@linux.ibm.com>
References: <20250519223646.66382-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=682bb287 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=HMsYVznzO8yh3S67C-MA:9
X-Proofpoint-ORIG-GUID: Dcn0JF06o4y7FoZaqH7xrUthu8O1P0Z5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDIxMSBTYWx0ZWRfX9YMD08iEAb1W i91AZRq/uHja7sXFqQV3gMECy37gosiHmXUCQMnVzWcs374GTPPF6TN9k8DZNLKnOuqVwmT3RQ+ NtpAeg7mX25kjKeYJqJQwWzxf0u8CqsyazyHYtLhixiVYi842HF8f2PNCbLlIzhvXebzqm12BZX
 LShSgCYmoVgqSlPHPdCmtwHfUFB8qPWEGN4jQApCbpGkIGZtsWO+wOu3hWqzETYAt/HXDcbgy/D aWxpSZv716GE/e5FQTLoIvKdlaUJe3K0/bkDvfGFzMcKMUyBAJddh5yMDEDkzZk4ASNROw/+c+X ptcySKBCv3Thrl1gVe4kiVIIiFZ1Bz+wKyPXf1PUlRW+HH2yOWdqWEqfdllLi7O787mZjDhVBKb
 nDVi5Fll5d6f1kNpSDqwJMs9WIApd76yNJTbnMwCD0uARGp7T5OzWylxUmTA2zv3F7nW1KFL
X-Proofpoint-GUID: Dcn0JF06o4y7FoZaqH7xrUthu8O1P0Z5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=998
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190211

Simplify the JIT code by replacing the custom expolines with the ones
defined in the kernel text.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 61 ++++++++++--------------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 70a93e03bfb3..c7f8313ba449 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -48,8 +48,6 @@ struct bpf_jit {
 	int lit64;		/* Current position in 64-bit literal pool */
 	int base_ip;		/* Base address for literal pool */
 	int exit_ip;		/* Address of exit */
-	int r1_thunk_ip;	/* Address of expoline thunk for 'br %r1' */
-	int r14_thunk_ip;	/* Address of expoline thunk for 'br %r14' */
 	int tail_call_start;	/* Tail call start offset */
 	int excnt;		/* Number of exception table entries */
 	int prologue_plt_ret;	/* Return address for prologue hotpatch PLT */
@@ -642,28 +640,17 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 }
 
 /*
- * Emit an expoline for a jump that follows
+ * Jump using a register either directly or via an expoline thunk
  */
-static void emit_expoline(struct bpf_jit *jit)
-{
-	/* exrl %r0,.+10 */
-	EMIT6_PCREL_RIL(0xc6000000, jit->prg + 10);
-	/* j . */
-	EMIT4_PCREL(0xa7f40000, 0);
-}
-
-/*
- * Emit __s390_indirect_jump_r1 thunk if necessary
- */
-static void emit_r1_thunk(struct bpf_jit *jit)
-{
-	if (nospec_uses_trampoline()) {
-		jit->r1_thunk_ip = jit->prg;
-		emit_expoline(jit);
-		/* br %r1 */
-		_EMIT2(0x07f1);
-	}
-}
+#define EMIT_JUMP_REG(reg) do {						\
+	if (nospec_uses_trampoline())					\
+		/* brcl 0xf,__s390_indirect_jump_rN */			\
+		EMIT6_PCREL_RILC_PTR(0xc0040000, 0x0f,			\
+				     __s390_indirect_jump_r ## reg);	\
+	else								\
+		/* br %rN */						\
+		_EMIT2(0x07f0 | reg);					\
+} while (0)
 
 /*
  * Call r1 either directly or via __s390_indirect_jump_r1 thunk
@@ -672,7 +659,8 @@ static void call_r1(struct bpf_jit *jit)
 {
 	if (nospec_uses_trampoline())
 		/* brasl %r14,__s390_indirect_jump_r1 */
-		EMIT6_PCREL_RILB(0xc0050000, REG_14, jit->r1_thunk_ip);
+		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14,
+				     __s390_indirect_jump_r1);
 	else
 		/* basr %r14,%r1 */
 		EMIT2(0x0d00, REG_14, REG_1);
@@ -688,16 +676,7 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
 	save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
-	if (nospec_uses_trampoline()) {
-		jit->r14_thunk_ip = jit->prg;
-		/* Generate __s390_indirect_jump_r14 thunk */
-		emit_expoline(jit);
-	}
-	/* br %r14 */
-	_EMIT2(0x07fe);
-
-	if (is_first_pass(jit) || (jit->seen & SEEN_FUNC))
-		emit_r1_thunk(jit);
+	EMIT_JUMP_REG(14);
 
 	jit->prg = ALIGN(jit->prg, 8);
 	jit->prologue_plt = jit->prg;
@@ -1899,7 +1878,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			/* aghi %r1,tail_call_start */
 			EMIT4_IMM(0xa70b0000, REG_1, jit->tail_call_start);
 			/* brcl 0xf,__s390_indirect_jump_r1 */
-			EMIT6_PCREL_RILC(0xc0040000, 0xf, jit->r1_thunk_ip);
+			EMIT6_PCREL_RILC_PTR(0xc0040000, 0xf,
+					     __s390_indirect_jump_r1);
 		} else {
 			/* bc 0xf,tail_call_start(%r1) */
 			_EMIT4(0x47f01000 + jit->tail_call_start);
@@ -2868,17 +2848,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	       0xf000 | tjit->tccnt_off);
 	/* aghi %r15,stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, tjit->stack_size);
-	/* Emit an expoline for the following indirect jump. */
-	if (nospec_uses_trampoline())
-		emit_expoline(jit);
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
-		/* br %r14 */
-		_EMIT2(0x07fe);
+		EMIT_JUMP_REG(14);
 	else
-		/* br %r1 */
-		_EMIT2(0x07f1);
-
-	emit_r1_thunk(jit);
+		EMIT_JUMP_REG(1);
 
 	return 0;
 }
-- 
2.49.0


