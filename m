Return-Path: <bpf+bounces-76160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 646DCCA8A23
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B6493042BDA
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C8352954;
	Fri,  5 Dec 2025 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mynPCw3r"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37B29B795;
	Fri,  5 Dec 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954945; cv=none; b=QvmKSw2psvjeejLMTjUW04xSaTpz2Bm13c9/HMltJb+iwU4S/aC6ZHJPCFGGcleeSWujLtHgLFBXqHm2pU6ZRozbpJDcrNSm7WEhOpT1PJ9rYhUf1fElSVDsvEaeVevVTnjRlDDEjLgOQ7i6OD85yGMyLVG4Jb3wRQO55fQoKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954945; c=relaxed/simple;
	bh=n8pBlgqOyIzV+gOPeF+y2BL0EDkz49lTTImLBPYuSR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+UAKMpsK+wTEB/Cm60a75RfzeUXx+ae5/64XCPe78yPibe8ZlKsUWqEEIQnGh+0+Jy7SYIz7tqxKE/4ZKtgkMyXaryuZmj5g5f7XMrOPsGpQX26y/g58ZFLAeYbhwdvZptnmFS0Cl7oA9SWrtcXbRMsBFRRM3O5tDSkUSo8WCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mynPCw3r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5GW9h8008240;
	Fri, 5 Dec 2025 17:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PRuUhT
	HO1HY1f+O9bTpuVEIwX5IW29Qy2eK9vjAVf9k=; b=mynPCw3rV79TQSoV6aHi7A
	evAHNMnxD+oTHMB35K4XLLC3laKnTYVnnv4mj/jQNy7Ni8Bw4p2DfFknneZaRt/W
	fjj2fTg0J0t2xP8DCMwQLz7/HtNqfSw1kJmTwfH/0pMWMgFR/9vbZp+kdgnQY7yo
	STLhU8xspbm6xX8gUcw8no5uOcddxwqaJhuwKDR8NpIR1NVXwuXSPIY26qf93JUb
	t8gpUGqEilMI/nq3hm8z9790DcsQvG4uBsR0H6wuck+hQ2B7axpmq/n7oyNkxCL+
	b4t6reY16CxaJMe1GTxHRIX4Or5CB+7eBqAdXyZIjaJyOzmbvqf4tYVWuU3Oj1pw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgq43h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HBWWw012503;
	Fri, 5 Dec 2025 17:14:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgq43d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Ei63e019051;
	Fri, 5 Dec 2025 17:14:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhyeee2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEqOZ47644986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE6720043;
	Fri,  5 Dec 2025 17:14:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC7372004D;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
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
Subject: [RFC PATCH v2 12/15] s390/ptrace: Provide frame_pointer()
Date: Fri,  5 Dec 2025 18:14:43 +0100
Message-ID: <20251205171446.2814872-13-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205171446.2814872-1-jremus@linux.ibm.com>
References: <20251205171446.2814872-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NZbwaSvgZ_Yf3Sh9IhHOqKZ_R7rYODQP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX7Gw6EvKRsBmI
 mSXktRu1YLv1e9ddY4cRmXkAowiRDZQKFNF71hTvpMSPbsBCs6ms9N6aPFxxq7rJeAByjRJa+et
 Nrcq2kPdV608sL/zhOjcJ5IgnJZIj4RGyUD2ls4BjxNAeWC6v0b9KhZMCkX4YjymQRUq78Bkwwr
 /idiA0thq5dBWZ3IcjZDC6dAD3CbVLLBhNw3SeKvl6N7O+p6AG4cqUKS7GQcPohQz10I0BAjSFJ
 GJ36YdvSlSBqg5vMJVTOrCPPfKyoctiRHsz9C5yj/gnySGrJqsL/Qq3CZxxe4NpCkDGu5OFPdmr
 qn1xvdlpMrO9PQGUPVir8HNVhgissLweIZtmoh8PMS6tCw3J34u0yix0SYlEYG53Nc8uQtn13HE
 zHW4wn2FPdojxFib7LXTNAN2UTi82g==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=69331312 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=SdC2vBNBQt3qShdCGKMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4vnQKU2kTDP9Dtedx-plqcAtkB_Vh2yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

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


