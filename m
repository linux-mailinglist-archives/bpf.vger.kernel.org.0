Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA533DA5CA
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbhG2OJn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 10:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238669AbhG2OHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 10:07:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FAB5601FF;
        Thu, 29 Jul 2021 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627567654;
        bh=Z7dFFREwwQHrQdB1bENhzb91hET8Wq84SoeFv9Bi8NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlLH7fhf4N10QMugRETHMQ4BQJsZ/zXh4iqcJ9hvRdc8skzrKtiXRxHsrkDQLZvp3
         Fw8gaczX6UBhqSdx7R9R/Ovb3lUgxmhbAfJL/bU6mv1/gnBjMxQwBM/aNomhjOdgtO
         Z3hiQMygi7y97D3yHjpwNU/2gksVoCWPcg6dXnN2FLQllIgbzDD1MUClK4leTHcbgb
         CO0HdRYtP2UBh453l8xnmCXwQDGzzvfD2qQpZIdeCA9XagTIe9TldDvAaxdymIkE0m
         +9bCJpY0URxgm767PsbWWKSHH4usojCuPn5Mr70VsJF+Me+eyc86lmm1tC30DmH4E4
         Kszns+XRJsRWA==
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
Subject: [PATCH -tip v10 10/16] ia64: Add instruction_pointer_set() API
Date:   Thu, 29 Jul 2021 23:07:29 +0900
Message-Id: <162756764934.301564.7514914520658490663.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162756755600.301564.4957591913842010341.stgit@devnote2>
References: <162756755600.301564.4957591913842010341.stgit@devnote2>
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

