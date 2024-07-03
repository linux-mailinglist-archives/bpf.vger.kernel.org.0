Return-Path: <bpf+bounces-33717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E702C924CE2
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 02:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C77281944
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D196E53BE;
	Wed,  3 Jul 2024 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q0uPMMT/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D14C6C
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967878; cv=none; b=O/v3uhkKCl5vwbH2Jl96JsY52q9p2QRO5syDyurqVcGCvGVqemJPdlJ/VZWEhw7lZX7kUdrgIT4aCSQyHKJ3ROGNscVYBUPu0m2cIUhmJIbaVp05q4g1OZsLxlIPMDYcmX5DEwsDlnrkQor4ppLCjrxXLPnuBQzgEFhfxk2bDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967878; c=relaxed/simple;
	bh=drLtYWWsR9+CgoH0FAUkN8Fng5o52oeg6jsB2v4QOgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POSDHlkQNzLXyPqWeMe9LIaOwfn7wkr4oMsq1wZBYnyRgS8rjm5iIqpOqI4BGmnN/urEspMlGtSKw78VgZmp4Qk+IsoliqgmBfZRkiRfZHQKqYYCQevIRKH5NWvLZC0E3ko4UALz85cxY/Awp5/WjIdj+DgaKNarDnqdrZsuVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q0uPMMT/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4630gJuu010399;
	Wed, 3 Jul 2024 00:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=qQ9vX5gheADfP
	l6ikPet2MUwJ+FzesxchU/XU9pkzPY=; b=Q0uPMMT/KdTj6n8FVqpEX+59z4EiD
	X2apCSFvpBcNOwlpGqY8qldC/tsAOyRUkQGO5WP2Ehyz7TdeaDWMBIFrPlKTiKH7
	KDjC5EOk1KKA+d7AbYDMvIwhCogp6K4UBsiFmPUl1IO7Sm4NEn5mCdP6ST1Q6SAw
	1xmi6SCEvNiklenl0lxpNvaV8Jj3SjkhABEtMeeOrElv/Z8qhCZaQODgr2B4mG5j
	cL09ZghebqnnEu+EY6K7s9U/i4iuL2MQpXTQFxCf9sMd98mwgtII1yMsA6Vt34pV
	E4zjIcHT6MJnd1C0OOhAkRkMB7SBCpO0fxzI/R+bxrkx4+hwHDQuCGYtQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404v4tg1gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 00:50:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 462Nqikp005930;
	Wed, 3 Jul 2024 00:50:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vku83ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 00:50:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4630ooCq31916610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 00:50:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29EC420063;
	Wed,  3 Jul 2024 00:50:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7B4220040;
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
Subject: [PATCH bpf-next 2/3] s390/bpf: Implement exceptions
Date: Wed,  3 Jul 2024 02:48:48 +0200
Message-ID: <20240703005047.40915-3-iii@linux.ibm.com>
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
X-Proofpoint-GUID: G7qTHgv3PChykClf-uQZ1tkQ4kbGk3b8
X-Proofpoint-ORIG-GUID: G7qTHgv3PChykClf-uQZ1tkQ4kbGk3b8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_17,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=925 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030001

Implement the following three pieces required from the JIT:

- A "top-level" BPF prog (exception_boundary) must save all
  non-volatile registers, and not only the ones that it clobbers.
- A "handler" BPF prog (exception_cb) must switch stack to that of
  exception_boundary, and restore the registers that exception_boundary
  saved.
- arch_bpf_stack_walk() must unwind the stack and provide the results
  in a way that satisfies both bpf_throw() and exception_cb.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 55 ++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 945f2ee6511b..9d440a0b729e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -31,6 +31,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/set_memory.h>
 #include <asm/text-patching.h>
+#include <asm/unwind.h>
 #include "bpf_jit.h"
 
 struct bpf_jit {
@@ -62,6 +63,8 @@ struct bpf_jit {
 #define SEEN_FUNC	BIT(2)		/* calls C functions */
 #define SEEN_STACK	(SEEN_FUNC | SEEN_MEM)
 
+#define NVREGS		0xffc0		/* %r6-%r15 */
+
 /*
  * s390 registers
  */
@@ -572,8 +575,21 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	}
 	/* Tail calls have to skip above initialization */
 	jit->tail_call_start = jit->prg;
-	/* Save registers */
-	save_restore_regs(jit, REGS_SAVE, stack_depth, 0);
+	if (fp->aux->exception_cb) {
+		/*
+		 * Switch stack, the new address is in the 2nd parameter.
+		 *
+		 * Arrange the restoration of %r6-%r15 in the epilogue.
+		 * Do not restore them now, the prog does not need them.
+		 */
+		/* lgr %r15,%r3 */
+		EMIT4(0xb9040000, REG_15, REG_3);
+		jit->seen_regs |= NVREGS;
+	} else {
+		/* Save registers */
+		save_restore_regs(jit, REGS_SAVE, stack_depth,
+				  fp->aux->exception_boundary ? NVREGS : 0);
+	}
 	/* Setup literal pool */
 	if (is_first_pass(jit) || (jit->seen & SEEN_LITERAL)) {
 		if (!is_first_pass(jit) &&
@@ -2909,3 +2925,38 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	 */
 	return true;
 }
+
+bool bpf_jit_supports_exceptions(void)
+{
+	/*
+	 * Exceptions require unwinding support, which is always available,
+	 * because the kernel is always built with backchain.
+	 */
+	return true;
+}
+
+void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64),
+			 void *cookie)
+{
+	unsigned long addr, prev_addr = 0;
+	struct unwind_state state;
+
+	unwind_for_each_frame(&state, NULL, NULL, 0) {
+		addr = unwind_get_return_address(&state);
+		if (!addr)
+			break;
+		/*
+		 * addr is a return address and state.sp is the value of %r15
+		 * at this address. exception_cb needs %r15 at entry to the
+		 * function containing addr, so take the next state.sp.
+		 *
+		 * There is no bp, and the exception_cb prog does not need one
+		 * to perform a quasi-longjmp. The common code requires a
+		 * non-zero bp, so pass sp there as well.
+		 */
+		if (prev_addr && !consume_fn(cookie, prev_addr, state.sp,
+					     state.sp))
+			break;
+		prev_addr = addr;
+	}
+}
-- 
2.45.2


