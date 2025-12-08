Return-Path: <bpf+bounces-76302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A9CADDBF
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8F3E302C873
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460E23126B6;
	Mon,  8 Dec 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BUOQnXUq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687842FBDFD;
	Mon,  8 Dec 2025 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214196; cv=none; b=AnoBT/258b6H3y15DsH/0xGlV3SCMC7UqynGsE0vfJ9kACBKCVBsZXceCgSuaaPOfb26J2YNUZcm2SGiPBCoprLoy20G9x+b23LivVeDlAeFjht/32Xyq31uVAE/pYy/jku3wh4Ma2tQe2fKpMVRrQtZWZ8A8Ze20pbhGW1dMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214196; c=relaxed/simple;
	bh=n8pBlgqOyIzV+gOPeF+y2BL0EDkz49lTTImLBPYuSR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdND+l474xm6hcV2cz28voyMkh8XZCcYGO2w60NxTXf/LOE3cHxszMfPePOOYCBG+EwPq3vLSe5Gyr/frJJkAYyTfS8pCOMgUp7ULOC5mZn8CpHkdKXjGyYUGdbNhuHIa6C8toZj5Nq2eTnY/5cPD53pg3rqJk88JbpbdjXHw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BUOQnXUq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8DC1QB016479;
	Mon, 8 Dec 2025 17:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PRuUhT
	HO1HY1f+O9bTpuVEIwX5IW29Qy2eK9vjAVf9k=; b=BUOQnXUq0qzImbXXKfkDcG
	35wmwP0GlP6UJ9asGXL3XIGLF/5w02oTFsDLE2fzlcl4msv5dKry9gteum+bjItC
	9M68gruVH9KzQplUiP4qUPQlErt55XN7j5FtV24Z8cT2boxPDYFcr5Cy89K7Uorf
	Fm5+BgMLL/0Q/YZPJV/0Ntlfiu9FecnFZ6fRBIHbwNM/A0mtf3YVDEgMJN5FsRfA
	zamrPhdH5E/cuRaHJhsdk6z06KcgOhfB3s+/9fqL/Pdwh8YpMQbveFsxR8A/+stv
	rg8435JSEC++VTnNolefaaA0L8qJYlPQtOxU6wHc+bC5xjlsJP8w5gIrhLfn1L9Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc538dna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HBuUt016407;
	Mon, 8 Dec 2025 17:16:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc538dn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8FAwFe008472;
	Mon, 8 Dec 2025 17:16:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmpsqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG7JC19988744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D29320040;
	Mon,  8 Dec 2025 17:16:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACA6120043;
	Mon,  8 Dec 2025 17:16:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:06 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v3 13/17] s390/ptrace: Provide frame_pointer()
Date: Mon,  8 Dec 2025 18:15:55 +0100
Message-ID: <20251208171559.2029709-14-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208171559.2029709-1-jremus@linux.ibm.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfXxyYe6TLlHMtD
 IyKc51LSRHYKvE98XtqTm//bwQ4yUE6zPjS5x6A/FQVh2PgWygGMR6y/oBTv6b/7agm8KOXnhzZ
 QgYyjZQ7+w9oBBc8KtHU1Cy8SemZEF0iqlDhpwv3hmuvVg6MMpay13qmYdx8XYX7phqZ5eBSKnR
 Ra46UQc5zd3MMBppk2mmHcLqBgiTW1OY9l9YjS8tOgYs/o/a4mFPpoZg2b9JzOrMO85M0g93ryp
 X08Wizjnfzx/DaBFBDF+iGX8HVbS60edUYr0clc8uzcrTFcw9wjUO2PZCTZ7VpJtZd4r/bV3zdm
 690co3Pm0V4vOANRE6Qcg5v7VLv01MlVal5fyoGQy3hxagWZwRuvGUyrX5ult3vQ6LENT0cxabY
 TsU4+93eJprDuF/wktUXIIhxtnM2Cg==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693707dc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=SdC2vBNBQt3qShdCGKMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hEKHMt-G9S2mpzJxJy3BZIxxOpAzqiiY
X-Proofpoint-GUID: 2UhiLugWxNJiHhFR2pleLJceGYq_yCOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

On s390 64-bit the s390x ELF ABI [1] designates register 11 as the
"preferred" frame pointer (FP) register in user space.

While at it convert instruction_pointer() and user_stack_pointer()
from macros to inline functions, to align their definition with
x86 and arm64.

Use const qualifier on struct pt_regs pointers to prevent compiler
warnings:

arch/s390/kernel/stacktrace.c: In function ‘arch_stack_walk_user_common’:
arch/s390/kernel/stacktrace.c:114:34: warning: passing argument 1 of
‘instruction_pointer’ discards ‘const’ qualifier from pointer target
type [-Wdiscarded-qualifiers]
...
arch/s390/kernel/stacktrace.c:117:48: warning: passing argument 1 of
‘user_stack_pointer’ discards ‘const’ qualifier from pointer target
type [-Wdiscarded-qualifiers]
...

[1]: s390x ELF ABI, https://github.com/IBM/s390x-abi/releases

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Separate provide frame_pointer() into this new commit.

 arch/s390/include/asm/ptrace.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index dfa770b15fad..455c119167fc 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -212,8 +212,6 @@ void update_cr_regs(struct task_struct *task);
 #define arch_has_block_step()	(1)
 
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
-#define instruction_pointer(regs) ((regs)->psw.addr)
-#define user_stack_pointer(regs)((regs)->gprs[15])
 #define profile_pc(regs) instruction_pointer(regs)
 
 static inline long regs_return_value(struct pt_regs *regs)
@@ -235,6 +233,22 @@ static __always_inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 	return regs->gprs[15];
 }
 
+static __always_inline unsigned long instruction_pointer(const struct pt_regs *regs)
+{
+	return regs->psw.addr;
+}
+
+static __always_inline unsigned long frame_pointer(const struct pt_regs *regs)
+{
+	/* Return ABI-designated "preferred" frame-pointer register value. */
+	return regs->gprs[11];
+}
+
+static __always_inline unsigned long user_stack_pointer(const struct pt_regs *regs)
+{
+	return regs->gprs[15];
+}
+
 static __always_inline unsigned long regs_get_register(struct pt_regs *regs, unsigned int offset)
 {
 	if (offset >= NUM_GPRS)
-- 
2.51.0


