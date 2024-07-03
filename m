Return-Path: <bpf+bounces-33737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35C9255F3
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1B21F22A1D
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633DA13B5B6;
	Wed,  3 Jul 2024 08:54:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81413B584;
	Wed,  3 Jul 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996865; cv=none; b=PufuwjkgxfGT97r6R6U6WqFBastNbBfrDZRzL/w9Wq0Mg6J8eXDq9si7Sb7HIhpRkqUNInsQ9Ztc0Rw4igZ9wzlSiyYrZYBJB7smeqd2i95w5iuKoOf5jVf2VUx/kA0gcDe42KxgYnxKBFoUIYGek6Ii7va0ozcKTI7xlubzsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996865; c=relaxed/simple;
	bh=woE19g9vPhpqXW1hrwIwclZfrMDdDIgvIF9jxblDFw8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=G+us8vYemZdNHZO44ntLSfCrXvRn8qzCHTDdIP8Hf1UYVrNJTv/rg7UHMrLnavmZNtkQ+JbXZpd80C4vRgz+PcIz2F7NyG1VHLGqdStbqO5zCpbuw22YpjZNGDEkVx9deKZY8ZbB1MjedvyPUws0yuHIaiV9ftjwbAkFAu0w108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WDYPJ0CYkz1T4w3;
	Wed,  3 Jul 2024 16:49:40 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 370901402CE;
	Wed,  3 Jul 2024 16:54:13 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 3 Jul 2024 16:54:12 +0800
Message-ID: <f04da18d-bded-fb21-301d-1a6dd6b3b6c7@huawei.com>
Date: Wed, 3 Jul 2024 16:54:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
From: "Liao, Chang" <liaochang1@huawei.com>
To: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <nathan@kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
 <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
 <20240620083602.GB30070@redhat.com> <ZnPxFbUJVUQd80hs@krava>
 <11ae956a-9d0c-ca80-c3a7-a16b2c53e737@huawei.com>
In-Reply-To: <11ae956a-9d0c-ca80-c3a7-a16b2c53e737@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Hi Jiri and Oleg,

在 2024/6/20 19:27, Liao, Chang 写道:
> 
> 
> 在 2024/6/20 17:06, Jiri Olsa 写道:
>> On Thu, Jun 20, 2024 at 10:36:02AM +0200, Oleg Nesterov wrote:
>>> On 06/20, Liao, Chang wrote:
>>>>
>>>> However, when i asm porting uretprobe trampoline to arm64
>>>> to explore its benefits on that architecture, i discovered the problem that
>>>> single slot is not large enought for trampoline code.
>>
>> ah ok, makes sense now.. x86_64 has the slot big enough for the trampoline,
>> but arm64 does not
>>
>>>
>>> Ah, but then I'd suggest to make the changelog more clear. It looks as
>>> if the problem was introduced by the patch from Jiri. Note that we was
>>> confused as well ;)
>>>
>>> And,
>>>
>>> 	+	/* Reserve enough slots for the uretprobe trampoline */
>>> 	+	for (slot_nr = 0;
>>> 	+	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
>>> 	+	     slot_nr++)
>>>
>>> this doesn't look right. Just suppose that insns_size = UPROBE_XOL_SLOT_BYTES + 1.
>>> I'd suggest DIV_ROUND_UP(insns_size, UPROBE_XOL_SLOT_BYTES).
>>>
>>> And perhaps it would be better to send this change along with
>>> uretprobe_trampoline_for_arm64 ?
>>
>> +1, also I'm curious what's the gain on arm64?
> 
> I am currently finalizing the uretprobe trampoline and syscall implementation on arm64.
> While i have addressed most of issues, there are stiil a few bugs that reguire more effort.
> Once these are fixed, i will use Redis to evaluate the performance gains on arm64. In the
> next revision, i will submit a patchset that includes all relevant code changs, testcases
> and benchmark data, which will allows a comprehensive review and dicussion.

This is an update on the development of uretprobe syscall for ARM64 architecture.

I've recently completed a basic implementation of the uretprobe syscall and trampoline
code for ARM64, with the uprobe syscall selftest passed. This allow me to revisit the
performance benchmark using uretprobe. With running Redis benchmark a Kunpeng server,
I observed a slight performance gain with the uretprobe syscall on ARM64. The performance
test spawned a Redis-server and Redis-benchmark on seperate cores within the same NUMA
node. The Redis-server handled each SET and GET request from Redis-benchmark which triggered
three uretprobe events with attached bpftrace program that increments the counter.
Here is the benchmark result:

On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Cores @ 2.4GHz :

-------------------------------------------------------------------------------
Test case       |  No uretprobe |  uretprobe(breakpoint) |  uretprobe (syscall)
===============================================================================
Redis SET (RPS) |  47025        |  40619   -13.6%        |  40670   -13.5%
-------------------------------------------------------------------------------
Redis GET (RPS) |  46715        |  41426   -11.3%        |  41274   -11.6%
-------------------------------------------------------------------------------

The detailed test scripts and bpf program are available upon any request.

Additionally, I've attempted to optimize the implementation of the uretprobe syscall and
trampoline, but the cause of the lower than expected performance gain compared to x86
remains unclear. Further investigation is necessary to identify potentail bottlenecks or
inefficiencies specific to ARM64. It is grateful for any insights or suggestions the
community might have on the potential reasons for the performance difference between
ARM64 and X86. The patch for the uretprobe syscall is attached below for reference.

---------------------------%<----------------------------
diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
index 8e4be92e25b1..059f38c0857f 100644
--- a/arch/arm64/kernel/probes/Makefile
+++ b/arch/arm64/kernel/probes/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
 				   kprobes_trampoline.o		\
 				   simulate-insn.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
+				   uprobes_trampoline.o		\
 				   simulate-insn.o
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..632f97afd50f 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -5,12 +5,69 @@
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
+#include <linux/syscalls.h>
 #include <asm/cacheflush.h>

 #include "decode-insn.h"

 #define UPROBE_INV_FAULT_CODE	UINT_MAX

+extern char uretprobe_trampoline[] __read_mostly;
+extern char uretprobe_trampoline_end[] __read_mostly;
+extern char uretprobe_trampoline_svc[] __read_mostly;
+
+void *arch_uprobe_trampoline(unsigned long *psize)
+{
+	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	struct pt_regs *regs = task_pt_regs(current);
+
+	if (!compat_user_mode(regs)) {
+		*psize = uretprobe_trampoline_end - uretprobe_trampoline;
+		return uretprobe_trampoline;
+	}
+
+	*psize = UPROBE_SWBP_INSN_SIZE;
+	return &insn;
+}
+
+static unsigned long syscall_at_uprobe_trampoline(void)
+{
+	unsigned long tramp = uprobe_get_trampoline_vaddr();
+
+	return tramp + (uretprobe_trampoline_svc - uretprobe_trampoline);
+}
+
+SYSCALL_DEFINE0(uretprobe)
+{
+	int err;
+	struct pt_regs *regs = task_pt_regs(current);
+
+	if (compat_user_mode(regs))
+		goto sigill;
+
+	/* ensure uretprobe syscall invoked from uretprobe trampoline */
+	if ((regs->pc - AARCH64_INSN_SIZE) != syscall_at_uprobe_trampoline())
+		goto sigill;
+
+	/* restore the clobbered context used to invoke uretprobe syscall */
+	err = copy_from_user(&regs->regs[8], (void __user *)(regs->sp - 8),
+			     sizeof(regs->regs[8]));
+	if (err)
+		goto sigill;
+
+	uprobe_handle_trampoline(regs);
+
+	/* restore the real LR before return to the caller. */
+	regs->regs[30] = regs->pc;
+
+	/* use the real return value */
+	return regs->regs[0];
+
+sigill:
+	force_sig(SIGILL);
+	return -1;
+}
+
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		void *src, unsigned long len)
 {
diff --git a/arch/arm64/kernel/probes/uprobes_trampoline.S b/arch/arm64/kernel/probes/uprobes_trampoline.S
new file mode 100644
index 000000000000..670d4d9e97ec
--- /dev/null
+++ b/arch/arm64/kernel/probes/uprobes_trampoline.S
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * trampoline entry and return code for uretprobes.
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm-bug.h>
+#include <asm/assembler.h>
+#include <asm/unistd.h>
+
+	.text
+
+SYM_CODE_START(uretprobe_trampoline)
+	str x8, [sp, #-8]
+	mov x8, #__NR_uretprobe
+
+SYM_CODE_START(uretprobe_trampoline_svc)
+	svc #0x000
+
+SYM_CODE_START(uretprobe_trampoline_end)
+	nop
--------------------------->%----------------------------

Thanks.

> 
>>
>> thanks,
>> jirka
> 

-- 
BR
Liao, Chang

