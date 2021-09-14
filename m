Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0840B1AA
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhINOnu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233765AbhINOnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5730560F11;
        Tue, 14 Sep 2021 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630506;
        bh=KEe5WdEyJHtzuPMGzpiocUmfrX3xOnunn5dZvpKwBh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0O7KnjhENSKmymiA5AxlQMCLHYg2ceHsvASG+IFQBPitXqJgEtKcmTy+nr49fhnL
         g0s7MfkeO3HE80yGuVRkDI+kGC14tnhxbdCtYGY1O8bB+i50VEjZhyNX6H7bTFHA3S
         NpqCCWHm6vPzLRiCAUjJMS1ni9RPTH7Cbgk0/FbXrOi4nsdZJgrst5f1lKNe5+kZeG
         MQns1JpgsOL9GS2uWv+7CL93cE9g0RoXWQea906+LQNpn1PyXs82dfxB0mWJqcA0zw
         WDDlXpN44zB5wg19AUokdc3xyqoZVlhiJUYbMkBpRolTbOkCeDB0XSFsBUAPSxLU3Y
         /ht2po03iTdCQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 20/27] ARC: Add instruction_pointer_set() API
Date:   Tue, 14 Sep 2021 23:41:41 +0900
Message-Id: <163163050148.489837.15187799269793560256.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
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

