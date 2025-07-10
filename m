Return-Path: <bpf+bounces-62941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E15B008EE
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B4A188D9E2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFBF2F1996;
	Thu, 10 Jul 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sWICare4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06292F0C62;
	Thu, 10 Jul 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165357; cv=none; b=VY+Xbid3+Fofil+Wt96I8KYSq+mjTmH0fIXAJxIRasPWf+Tx5mqeCxUYZjyYNq+swyY5xinJbZM9vJVjRcOV+03LXulRTLxFy5xErFiAChl8gEj0c399/4baf7iOwiuc6gKhkTkJlThS7e5IGX/S8Lk6SAfcBTKcLHZONIenA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165357; c=relaxed/simple;
	bh=tCCMdkDak8azEkCoj0uFghu2c8I0OJT7NBUep4hLlwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8WOqoRFIo4x7H/HFDGT/rY2S2hwSyxfr0xabU6wmPuYYwIbPuOrvfeVDOnRWlhyGTrHyAxVdBjkSDU0QyAtgTxBmkdxMLCkGb8IjdAnBbV1K7zRZ9j8Wv9XMeuWKY6nfUZuxx9Ip3FZsthTpSZ3bSV/79gmpViMt1ZnHHoK7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sWICare4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADjWJR010569;
	Thu, 10 Jul 2025 16:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PB0WTAltW+KHElMPJ
	xVOA/EfdsSdDGp+uN+1+3ZTOrs=; b=sWICare4JL42xnPgo16mE5QLDKq4lJPRG
	kTUZMGBbOuekVKul3NEmWZXaE0Y9Oy//h0HzxwWNxBq/E0HmhpTixXAUjq3ummV5
	ye6ylTyzPLShOEeqpNHPct7nSW45s6irSpqIwP+osEIDTZ27/Sa9P6hnmmGavgwY
	0141JDNlj8WoauOOCkbkmGd7XBcEKc7W1rgDlO6h3c3WXQjAMQiI4kJx/LPeFAwq
	mIUyNIl+RBUCVy0VneWMDW294cUnhGtCTS8EoSHQkd5tfhW1bPO+U7ZMafRN+FJd
	DBeEmmCNSKKStS0TEBvgE4oNBB7KDBGiwP8AIjk/j69cTdpSXZhow==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb26atf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADeR2d021561;
	Thu, 10 Jul 2025 16:35:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectxrn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZRAu35062184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EEAF20040;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C804620043;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 10/16] s390/ptrace: Enable HAVE_USER_RA_REG
Date: Thu, 10 Jul 2025 18:35:16 +0200
Message-ID: <20250710163522.3195293-11-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250710163522.3195293-1-jremus@linux.ibm.com>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX5SP91U9/IjWP STby5G9VsC4J3JET7d6kaMfjtFmt1bJ1vLqcbh5bM+oNfv4ADYxJQyqPRwIVDWB7YmjxNyzbxUj qJuO+dPbN0s37LjSD7BAzmwuc9suo68tildYiFjBUgxIB7p08DBpEKD0jIK67knTbn0Ok/FzXsi
 jAnXF/kPmMJOMqwlKJ3nKIC9wm5N0IpSng7y86IBGwEOYffuMyF2c8fJOJYZVTRM9vxGetZXfjn AY62jUxO5cj3oavEahGs9Nflz3rmbLhQieI2FIyNR8+ZspixfN5FFGvAjbGT1ulFbv2mpCeVKM2 oAgg5cyx3gUACM9Z6B+Dwcw/xU21rjdqFXtH3Ko7cjMGjLvk09NjsY7ykuF/zSibKhi/M35tr1A
 OHQrY1CBG5Gji3s2Uf0QAj0DbcqAUDQdcTqelCPgw+iSobidD6bziUlJ11QZhd4GwHJzsWwe
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686febd3 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=pHnkZ9Rrd0NqFIkZcxAA:9
X-Proofpoint-ORIG-GUID: 9XpdvCNjV8cvLI7n4flAvGPCGeyCQTkG
X-Proofpoint-GUID: 9XpdvCNjV8cvLI7n4flAvGPCGeyCQTkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=7
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=531 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Provide user_return_address().  Additionally provide frame_pointer().

On s390 register 11 is the preferred frame pointer (FP) register
and register 14 is the return address (RA) register in user space.

While at it convert instruction_pointer() and user_stack_pointer()
from macros to inline functions, to align their definition with
x86-64 and AArch64.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/Kconfig              |  1 +
 arch/s390/include/asm/ptrace.h | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0c16dc443e2f..f4ea52c1f0ba 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -239,6 +239,7 @@ config S390
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_USER_RA_REG
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select HOTPLUG_SMT
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 0905fa99a31e..71d81280e5eb 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -212,8 +212,6 @@ void update_cr_regs(struct task_struct *task);
 #define arch_has_block_step()	(1)
 
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
-#define instruction_pointer(regs) ((regs)->psw.addr)
-#define user_stack_pointer(regs)((regs)->gprs[15])
 #define profile_pc(regs) instruction_pointer(regs)
 
 static inline long regs_return_value(struct pt_regs *regs)
@@ -230,11 +228,32 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 int regs_query_register_offset(const char *name);
 const char *regs_query_register_name(unsigned int offset);
 
-static __always_inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+static __always_inline unsigned long kernel_stack_pointer(const struct pt_regs *regs)
 {
 	return regs->gprs[15];
 }
 
+static __always_inline unsigned long instruction_pointer(const struct pt_regs *regs)
+{
+	return regs->psw.addr;
+}
+
+static __always_inline unsigned long frame_pointer(const struct pt_regs *regs)
+{
+	return regs->gprs[11];
+}
+
+static __always_inline unsigned long user_stack_pointer(const struct pt_regs *regs)
+{
+	return regs->gprs[15];
+}
+
+static __always_inline unsigned long user_return_address(const struct pt_regs *regs)
+{
+	return regs->gprs[14];
+}
+#define user_return_address user_return_address
+
 static __always_inline unsigned long regs_get_register(struct pt_regs *regs, unsigned int offset)
 {
 	if (offset >= NUM_GPRS)
-- 
2.48.1


