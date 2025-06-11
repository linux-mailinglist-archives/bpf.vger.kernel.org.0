Return-Path: <bpf+bounces-60273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1450AD47AF
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA53A9955
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036001A3BD8;
	Wed, 11 Jun 2025 01:03:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC018DF86;
	Wed, 11 Jun 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603790; cv=none; b=L6EVe0Kh771KW9u9uW62zLNqOB2GUCYxXaoMrXwVEJEdJC2j7sk7kXH8MiIinNmvmW09aPIPA7TuWUhvVmpQFIUNmUf/ceogxBltAsCFls5qia5bjkCAT9MKAvKJm2AeTOMzgNbgYu08nGTCPUE1x93C+971JY9fIUUliDdVUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603790; c=relaxed/simple;
	bh=bPBajh8EGf4+bDng5T4QRryXcyGpgQ9DELBqLYicx48=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jyYnHZj/DnL1SP/v1t0gouLFV0fgYpeupc+cOuM6OkGaLu9yha5dOc3wqLgR32+Y838p8ux5KiMmDOB58oYVats86aSIqgxNDi1eLtf9A0t/TTjf/Sn5ZcgRnbz5+THmbHScmvXa7+Ooa+xLbicMD5o/tzI1xCJQttAkr87gYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 314A45F7BD;
	Wed, 11 Jun 2025 01:03:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 2CAEB8000E;
	Wed, 11 Jun 2025 01:02:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tG-00000000vE6-1AAw;
	Tue, 10 Jun 2025 21:04:30 -0400
Message-ID: <20250611010430.123232579@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 14/14] unwind_user/x86: Enable compat mode frame pointer unwinding on x86
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 2CAEB8000E
X-Rspamd-Server: rspamout08
X-Stat-Signature: xtsqf539zgjt8abwi56oeejptekfnsiy
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Z5lvnMFhI3Ba4nW/U9c/pN3/34EKD5Bs=
X-HE-Tag: 1749603778-441344
X-HE-Meta: U2FsdGVkX1/gv6KFmGkvhJ9fjkJYNLktsCGvhOkgNiXiPGe4f3c0Ub8SSRV2pPNu+Nedz1j+af1NzU7fkW5lYvaO4psTf5JaKiCgw73Xe/eGTOeQROKZxuUWVhtpEca0H1ZUyWwfb82W7yljgnugyhDhd7LJ29D+hdr2aFCZIUWguFfGx51GFespPeGGU6nSIqGBmqNMUEv+lSa6kTam9nSvWfxffb1Pt0n6f4iJQGjGZzrvDkR/Tj5ngV7T/GCwJcQzOTZM3VvNrgFAl4rzc5a2yRTyd2bcke+osnGVFpn0p+dgNYad8G5taDkanS+TGw4XQNcgX4Z3T0U1OIQD+kD4+q7qJMtU7lG2eQBRgWPq0HOVQt/IbGYNFJgP7qbRL0gZHodRTqLcBkuxd0CCz3Zb4fU4zpIFbKWLxgMqKYA=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_COMPAT_FP_FRAME to describe how frame pointers are
unwound on x86, and implement the hooks needed to add the segment base
addresses.  Enable HAVE_UNWIND_USER_COMPAT_FP if the system has compat
mode compiled in.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250513223551.966925463@goodmis.org/

- Remove unneeded include of perf_event.h

 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/unwind_user.h       | 49 ++++++++++++++++++++++++
 arch/x86/include/asm/unwind_user_types.h | 17 ++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user_types.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2cdb5cf91541..3f7bdc9e3cec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,6 +302,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_COMPAT_FP	if IA32_EMULATION
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 8597857bf896..43f8554c1d70 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,10 +2,59 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#include <linux/unwind_user_types.h>
+#include <asm/ptrace.h>
+
 #define ARCH_INIT_USER_FP_FRAME							\
 	.cfa_off	= (s32)sizeof(long) *  2,				\
 	.ra_off		= (s32)sizeof(long) * -1,				\
 	.fp_off		= (s32)sizeof(long) * -2,				\
 	.use_fp		= true,
 
+#ifdef CONFIG_IA32_EMULATION
+
+#define ARCH_INIT_USER_COMPAT_FP_FRAME						\
+	.cfa_off	= (s32)sizeof(u32)  *  2,				\
+	.ra_off		= (s32)sizeof(u32)  * -1,				\
+	.fp_off		= (s32)sizeof(u32)  * -2,				\
+	.use_fp		= true,
+
+#define in_compat_mode(regs) !user_64bit_mode(regs)
+
+static inline void arch_unwind_user_init(struct unwind_user_state *state,
+					 struct pt_regs *regs)
+{
+	unsigned long cs_base, ss_base;
+
+	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	scoped_guard(irqsave) {
+		cs_base = segment_base_address(regs->cs);
+		ss_base = segment_base_address(regs->ss);
+	}
+
+	state->arch.cs_base = cs_base;
+	state->arch.ss_base = ss_base;
+
+	state->ip += cs_base;
+	state->sp += ss_base;
+	state->fp += ss_base;
+}
+#define arch_unwind_user_init arch_unwind_user_init
+
+static inline void arch_unwind_user_next(struct unwind_user_state *state)
+{
+	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	state->ip += state->arch.cs_base;
+	state->fp += state->arch.ss_base;
+}
+#define arch_unwind_user_next arch_unwind_user_next
+
+#endif /* CONFIG_IA32_EMULATION */
+
+#include <asm-generic/unwind_user.h>
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/arch/x86/include/asm/unwind_user_types.h b/arch/x86/include/asm/unwind_user_types.h
new file mode 100644
index 000000000000..d7074dc5f0ce
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UNWIND_USER_TYPES_H
+#define _ASM_UNWIND_USER_TYPES_H
+
+#ifdef CONFIG_IA32_EMULATION
+
+struct arch_unwind_user_state {
+	unsigned long ss_base;
+	unsigned long cs_base;
+};
+#define arch_unwind_user_state arch_unwind_user_state
+
+#endif /* CONFIG_IA32_EMULATION */
+
+#include <asm-generic/unwind_user_types.h>
+
+#endif /* _ASM_UNWIND_USER_TYPES_H */
-- 
2.47.2



