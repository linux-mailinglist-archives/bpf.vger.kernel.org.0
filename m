Return-Path: <bpf+bounces-33715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A657D924CDF
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 02:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFD61C2231C
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECD223C9;
	Wed,  3 Jul 2024 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tmg21EfV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674801361
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967874; cv=none; b=cnMjMiwkcbBbaTi2cRQiZTswrcjFg3Ni8TeMh8+RqK18ZuQ62RX/bf7T6I4ai/i9dgI7iLRLA/r4D0UgxkXTtU3pZhhvRPsy5EMd/Twq0Gw6uRugqDREszsTi2MAwSDMtCuDe2VeU47gjsDKIL6/ja/O47cx8bSl2XEDW4cbWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967874; c=relaxed/simple;
	bh=Sa6lylH2abzNtuR/JHeDTW7tUjqgPl0ZT24Omcok8ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLpIUZkVK87NXuCKrTkjCWDqb5xpLYAibyUVoo0P2c1kw37DthGff85x+YzpZlIemtk7Rf+5WD79kWwMYROIDIGq/3XHFFCvPg37KUPEPyEWg60UnPgEsdPxTZg9eU5QXxFyKm85wN7vAzYCDMi6O4Wotbvyd8qHIfu4xBftGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tmg21EfV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4630bIn1006026;
	Wed, 3 Jul 2024 00:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=uTod5tC34iRx9
	gQlP/2+NhtkSS1IDqw4XX2AypLJbZE=; b=Tmg21EfVoO+703+fDdqtASqDB3vT+
	4rLc7hqrZii16yt0FHwITQY5hRDDJtJzY42ED6jOnjTk00ZF/s+K3eaJREUc621u
	eK+wnDCfHN1UnPdnhgJdO+ilQYxWbIFy2KAuI5I7z+slLgrwnWs2ejx0nsjnsKbM
	s/5t/L1xOAo1BWL7haVkE1vXPZgIhCdb2NkgsXinEH2WBQ1g5pz/RcmSPD8nRPyE
	l95imk4dPkCP29TBvNmaiEv0e3oJIP1XJT+tthhj2yeAzLsDG17EuQ367KMBY1cH
	eqUajSbUf2IbYy/tKGIhgPH/m9jM6pKpKeIWDwW23u+ZVXsgCBITn+yiQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404u8hg556-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 00:50:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 462NcEUX005985;
	Wed, 3 Jul 2024 00:50:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vku83nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 00:50:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4630on3o42795304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 00:50:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 917042004B;
	Wed,  3 Jul 2024 00:50:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B5F620040;
	Wed,  3 Jul 2024 00:50:49 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.78.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jul 2024 00:50:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] s390/bpf: Change seen_reg to a mask
Date: Wed,  3 Jul 2024 02:48:47 +0200
Message-ID: <20240703005047.40915-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703005047.40915-1-iii@linux.ibm.com>
References: <20240703005047.40915-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kA552Lya-e1VPDKUVmejmxZshpQ6GNvw
X-Proofpoint-GUID: kA552Lya-e1VPDKUVmejmxZshpQ6GNvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_17,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=863
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030001

Using a mask instead of an array saves a small amount of memory and
allows marking multiple registers as seen with a simple "or". Another
positive side-effect is that it speeds up verification with jitterbug.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ddfc0e99872e..945f2ee6511b 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -35,7 +35,7 @@
 
 struct bpf_jit {
 	u32 seen;		/* Flags to remember seen eBPF instructions */
-	u32 seen_reg[16];	/* Array to remember which registers are used */
+	u16 seen_regs;		/* Mask to remember which registers are used */
 	u32 *addrs;		/* Array with relative instruction addresses */
 	u8 *prg_buf;		/* Start of program */
 	int size;		/* Size of program and literal pool */
@@ -120,8 +120,8 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 {
 	u32 r1 = reg2hex[b1];
 
-	if (r1 >= 6 && r1 <= 15 && !jit->seen_reg[r1])
-		jit->seen_reg[r1] = 1;
+	if (r1 >= 6 && r1 <= 15)
+		jit->seen_regs |= (1 << r1);
 }
 
 #define REG_SET_SEEN(b1)					\
@@ -129,8 +129,6 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	reg_set_seen(jit, b1);					\
 })
 
-#define REG_SEEN(b1) jit->seen_reg[reg2hex[(b1)]]
-
 /*
  * EMIT macros for code generation
  */
@@ -438,12 +436,12 @@ static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re, u32 stack_depth)
 /*
  * Return first seen register (from start)
  */
-static int get_start(struct bpf_jit *jit, int start)
+static int get_start(u16 seen_regs, int start)
 {
 	int i;
 
 	for (i = start; i <= 15; i++) {
-		if (jit->seen_reg[i])
+		if (seen_regs & (1 << i))
 			return i;
 	}
 	return 0;
@@ -452,15 +450,15 @@ static int get_start(struct bpf_jit *jit, int start)
 /*
  * Return last seen register (from start) (gap >= 2)
  */
-static int get_end(struct bpf_jit *jit, int start)
+static int get_end(u16 seen_regs, int start)
 {
 	int i;
 
 	for (i = start; i < 15; i++) {
-		if (!jit->seen_reg[i] && !jit->seen_reg[i + 1])
+		if (!(seen_regs & (3 << i)))
 			return i - 1;
 	}
-	return jit->seen_reg[15] ? 15 : 14;
+	return (seen_regs & (1 << 15)) ? 15 : 14;
 }
 
 #define REGS_SAVE	1
@@ -469,8 +467,10 @@ static int get_end(struct bpf_jit *jit, int start)
  * Save and restore clobbered registers (6-15) on stack.
  * We save/restore registers in chunks with gap >= 2 registers.
  */
-static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth)
+static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
+			      u16 extra_regs)
 {
+	u16 seen_regs = jit->seen_regs | extra_regs;
 	const int last = 15, save_restore_size = 6;
 	int re = 6, rs;
 
@@ -484,10 +484,10 @@ static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth)
 	}
 
 	do {
-		rs = get_start(jit, re);
+		rs = get_start(seen_regs, re);
 		if (!rs)
 			break;
-		re = get_end(jit, rs + 1);
+		re = get_end(seen_regs, rs + 1);
 		if (op == REGS_SAVE)
 			save_regs(jit, rs, re);
 		else
@@ -573,7 +573,7 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	/* Tail calls have to skip above initialization */
 	jit->tail_call_start = jit->prg;
 	/* Save registers */
-	save_restore_regs(jit, REGS_SAVE, stack_depth);
+	save_restore_regs(jit, REGS_SAVE, stack_depth, 0);
 	/* Setup literal pool */
 	if (is_first_pass(jit) || (jit->seen & SEEN_LITERAL)) {
 		if (!is_first_pass(jit) &&
@@ -649,7 +649,7 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	/* Load exit code: lgr %r2,%b0 */
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
-	save_restore_regs(jit, REGS_RESTORE, stack_depth);
+	save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
 	if (nospec_uses_trampoline()) {
 		jit->r14_thunk_ip = jit->prg;
 		/* Generate __s390_indirect_jump_r14 thunk */
@@ -1847,7 +1847,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/*
 		 * Restore registers before calling function
 		 */
-		save_restore_regs(jit, REGS_RESTORE, stack_depth);
+		save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
 
 		/*
 		 * goto *(prog->bpf_func + tail_call_start);
-- 
2.45.2


