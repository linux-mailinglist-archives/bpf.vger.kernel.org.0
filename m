Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C9341CC6
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhCSMXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 08:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhCSMW4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 08:22:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B1B464F6E;
        Fri, 19 Mar 2021 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616156575;
        bh=KEe5WdEyJHtzuPMGzpiocUmfrX3xOnunn5dZvpKwBh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQwuK7XodwAna+Q6RlxmMUWFGOK5ajES/260IfJAiNcptiryhGhAC5RgbXgo6b8PK
         LuBWiqA9+NUAajTfPMJFNGXN5HzsfTjW4rAxgVQD842rLLxhRslaZqt9R94atO/YZd
         cYGiJW8GlxV3q7uKBq0oYJNWiRlUM2GDlPYo5T2Iacx6Ii8V+ELwmqsLY4oN9MS25G
         TB5IUlowKhxtthtTG+ry9qLmEqUv9ItL6KirBQWYxZubesNB8e+MlLwxkbyOzY51fZ
         /STsQKUSit4M9awIhXwrElqqo/EQaAGY8dPUA4Z+SCVpzAdF1AudGL2cxpiyBmkyel
         /feVumaEud33w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH -tip v3 06/11] ARC: Add instruction_pointer_set() API
Date:   Fri, 19 Mar 2021 21:22:49 +0900
Message-Id: <161615656974.306069.13884955082773738658.stgit@devnote2>
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

Add instruction_pointer_set() API for arc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arc/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 4c3c9be5bd16..cca8d6583e31 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -149,6 +149,11 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return (long)regs->r0;
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PTRACE_H */

