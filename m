Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF853C3CF5
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhGKNi4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233055AbhGKNi4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:38:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CB2061249;
        Sun, 11 Jul 2021 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010569;
        bh=Z7dFFREwwQHrQdB1bENhzb91hET8Wq84SoeFv9Bi8NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSEKtdieBWFes4GWZQkUJBrvXIRTV9a++XI8nkyanmm1ow2shMgnb/G792JXQSaxN
         K8H7ByBUyBx+fFbSzEsLq5XUemDtJMJBUzCVd4eNSLFfNfC2DEPvKFBKClSip8bV8f
         +HvEb0huVWTb4Sy0AMyUn13VF9JPvtlTlNRyiwlUQuaCGlwUhYZoznqlHIvtS1PP0f
         3IdLq+n08rbP4FFE30fb2j8d5K8KpE3oY/Cq2d828A/dBG7dMEitp9L5hMCzIMO4ba
         OKFNAN4NvE3fB8VaK01jG8aJm7GP7o1yoz0QYh5HEGIpheW+0jZe8bCiDenoe4AmMa
         vNuz08soF2UQA==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v9 08/14] ia64: Add instruction_pointer_set() API
Date:   Sun, 11 Jul 2021 22:36:05 +0900
Message-Id: <162601056517.1318837.12417186157614320062.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162601048053.1318837.1550594515476777588.stgit@devnote2>
References: <162601048053.1318837.1550594515476777588.stgit@devnote2>
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
  Changes in v9:
   - Fix "space at the start of a line" checkpatch warnings.
  Changes in v4:
   - Make the API macro for avoiding a build error.
---
 arch/ia64/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index 08179135905c..8a2d0f72b324 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -51,6 +51,11 @@
  * the canonical representation by adding to instruction pointer.
  */
 # define instruction_pointer(regs) ((regs)->cr_iip + ia64_psr(regs)->ri)
+# define instruction_pointer_set(regs, val)	\
+({						\
+	ia64_psr(regs)->ri = (val & 0xf);	\
+	regs->cr_iip = (val & ~0xfULL);		\
+})
 
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {

