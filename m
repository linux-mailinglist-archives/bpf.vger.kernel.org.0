Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB76C341CC9
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 13:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCSMXW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 08:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhCSMXG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 08:23:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BCC664F65;
        Fri, 19 Mar 2021 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616156586;
        bh=l1g8PZb9w6cDVZuCPqZ5YvMo82/g26s+RTh8ZpDtrXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZd1USBQeRDVGrzqTlRWFu1Q3EG5KSu9zyZMyJ2JWjh/NC2AzspiISOyseVrSjWaW
         WpgzfBdQluWMtWxDnEAmS4cCcZyknxiD+J+8n0euCahvgSu1N2W/lMT2l9KKP8vVdO
         ljlWWd0fiZgjtoBrywzLnpmL9j4kN6cHgb/Wv4KK1UJUCgDnMiuCMCF1ikJFmkVSEE
         zVJlzZ8B3wcPRa2FePhmrRAjsAv1eFIFgQysmdrn1hFiqPHbPUIU1cogR7UH6/sdvB
         yFL5pknnqeiLdT5uayOCE//c4NqmL0317ggdDhxz9mQALGYsOc33081MmxfpqfxgWf
         A+Jjzw+9AIiWQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH -tip v3 07/11] ia64: Add instruction_pointer_set() API
Date:   Fri, 19 Mar 2021 21:23:01 +0900
Message-Id: <161615658087.306069.12036720803234007510.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161615650355.306069.17260992641363840330.stgit@devnote2>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add instruction_pointer_set() API for ia64.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/ia64/include/asm/ptrace.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index b3aa46090101..e382f1a6bff3 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -45,6 +45,7 @@
 #include <asm/current.h>
 #include <asm/page.h>
 
+# define ia64_psr(regs)			((struct ia64_psr *) &(regs)->cr_ipsr)
 /*
  * We use the ia64_psr(regs)->ri to determine which of the three
  * instructions in bundle (16 bytes) took the sample. Generate
@@ -71,6 +72,12 @@ static inline long regs_return_value(struct pt_regs *regs)
 		return -regs->r8;
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs, unsigned long val)
+{
+	ia64_psr(regs)->ri = (val & 0xf);
+	regs->cr_iip = (val & ~0xfULL);
+}
+
 /* Conserve space in histogram by encoding slot bits in address
  * bits 2 and 3 rather than bits 0 and 1.
  */
@@ -87,7 +94,6 @@ static inline long regs_return_value(struct pt_regs *regs)
 
   /* given a pointer to a task_struct, return the user's pt_regs */
 # define task_pt_regs(t)		(((struct pt_regs *) ((char *) (t) + IA64_STK_OFFSET)) - 1)
-# define ia64_psr(regs)			((struct ia64_psr *) &(regs)->cr_ipsr)
 # define user_mode(regs)		(((struct ia64_psr *) &(regs)->cr_ipsr)->cpl != 0)
 # define user_stack(task,regs)	((long) regs - (long) task == IA64_STK_OFFSET - sizeof(*regs))
 # define fsys_mode(task,regs)					\

