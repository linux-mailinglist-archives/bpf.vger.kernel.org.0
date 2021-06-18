Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1C3AC49B
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhFRHIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 03:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232903AbhFRHIk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 03:08:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49A716100A;
        Fri, 18 Jun 2021 07:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623999991;
        bh=eXubxiP2sfbDRxWXxCS2276qipPi7ZT+e19fUSeI+18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlnpvzazRx6/xgsOWH3bNTfdA1pMop85FvoSqQnj+Fp/vKYT5ilFtgZAewFyEXxFM
         OFFznFI8IB6puBfHQiQwLWZ2ELiuV2h0+6HoE15CRc285qS7LVELIQjiB6pe4zgsBO
         l5thuKQKw5EvNhzTp8+61gZgeXm8fAkH9XnPsr87rDfVzKZthUmjDBCaNDs9/3z9pg
         cghwFbOVOHd4iR7gNBpaYTj/IrNTYJek2aIxz/3gdILhz5SLRumOnnO6JkzRtOV9eC
         tIJcQArwuHRKBgS51J1Gu9meChjHys9Vj6kizJhq2m6WQ7MGo/h2ABzgvqwnNJe90h
         4/G531QSMcatw==
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
Subject: [PATCH -tip v8 07/13] ia64: Add instruction_pointer_set() API
Date:   Fri, 18 Jun 2021 16:06:27 +0900
Message-Id: <162399998747.506599.1115560529431673586.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162399992186.506599.8457763707951687195.stgit@devnote2>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
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
  Changes in v4:
   - Make the API macro for avoiding a build error.
---
 arch/ia64/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index 08179135905c..a024afbc70e5 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -51,6 +51,11 @@
  * the canonical representation by adding to instruction pointer.
  */
 # define instruction_pointer(regs) ((regs)->cr_iip + ia64_psr(regs)->ri)
+# define instruction_pointer_set(regs, val)	\
+  ({						\
+	ia64_psr(regs)->ri = (val & 0xf);	\
+	regs->cr_iip = (val & ~0xfULL);		\
+  })
 
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {

