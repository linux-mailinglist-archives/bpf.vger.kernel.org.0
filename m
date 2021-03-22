Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29BB3439B9
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 07:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVGll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 02:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhCVGlN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 02:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C330461937;
        Mon, 22 Mar 2021 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616395273;
        bh=iAB/GP1lxiYjZ/XD65VZRhooNarxkQDlN/p7JzDFc8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzLZ7MOHPezHy+ign+CyXUrY7FX1xV92LBqGaofg2iT5ZfQny+0RqKxcJbd1cWfdV
         vGDvNL4eljzsJDBhxmBjpfXfXLoGbCbf3pQ6aCiKQbQPx9JuAohSuC6nQ5/0H9TnLT
         XmjjDXzPgdrTwQ5zQXZ5WhDcyJmoZ475SVd9R0h+HyPcY/7Rhc3IOa6ACHE0jJnmWB
         l72pXl+HnMtG6FtrWf9H9NSLyS2LImVpLYT16qhVapdvmYbexgMfO2mtSe47HDyITO
         DKXShEziv9+ygoefObMdRDsN+kb2o1BWX5yWWntCnu9Hx2mSBYDz7qZ+in/FKWwNaL
         nzSFy0WW3Qa/w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: [PATCH -tip v4 07/12] ia64: Add instruction_pointer_set() API
Date:   Mon, 22 Mar 2021 15:41:07 +0900
Message-Id: <161639526755.895304.15567889273226397549.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161639518354.895304.15627519393073806809.stgit@devnote2>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
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
index b3aa46090101..4c2f838b2e77 100644
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

