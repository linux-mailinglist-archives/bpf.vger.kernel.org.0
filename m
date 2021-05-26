Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735463911DC
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhEZIE6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhEZIE4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 04:04:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9286A613B4;
        Wed, 26 May 2021 08:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622016205;
        bh=eXubxiP2sfbDRxWXxCS2276qipPi7ZT+e19fUSeI+18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5+2YpNmlahnB9R6m+bJpzlYWgb9pI1aEDaazkf/ybA3v/F8WI3CW3hmaV/rPQbye
         3W5opqFPKNOJvcqzHtaKQs9LWgBtWWB8g+ITBLX2RVMKf5/unwjApC0STvVCLsmnD3
         +0piPvSOXfMYCMzkMedfB+yOaspR+X2XrSYcay8pS6LMJevthgmwyq71jCrJdP0gxB
         VFYf+MR63kCSYraVxdfo2hF59QtOTILQ0BBwVElBI167nkj0Cjr9ESFiU7rv1FE1oz
         vnJvFqEhOU+HTyweqSTt787EmwfSMuzL1BaD/b1rdbpfZIcBif3EivCepmfx9HxzRp
         fYXw5X7hgTgeg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v6 07/13] ia64: Add instruction_pointer_set() API
Date:   Wed, 26 May 2021 17:03:20 +0900
Message-Id: <162201620051.278331.3631153829513157789.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162201612941.278331.5293566981784464165.stgit@devnote2>
References: <162201612941.278331.5293566981784464165.stgit@devnote2>
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

