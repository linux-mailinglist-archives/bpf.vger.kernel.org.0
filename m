Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5633D91F3
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 17:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhG1P37 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 11:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237306AbhG1P3x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 11:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 378FA61019;
        Wed, 28 Jul 2021 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627486191;
        bh=pS3y9et2p/dkxzeM2EJ7grzyp84IGtDqnN8Te94o73g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnYxgjZBEhqzsuwpYqW035JJJ4p5bYz5iRDnToc+4JAD7ut/9z01AB+X4Qtsv33pR
         THSI7lphOAWJ49HsFHbQmqPjyT0ohWXeUjgVp+yto9IXQfpXE1O14ZQW4MUL3Axki7
         riPD3WeGwf2IhD44exMLHSJ5tI9yvppsrZcHmiHqWils+eVwMljQVDByJi/5JtAQVa
         PEka+v9XJYXZmA8zEDur1v7ERnHsI1cRhskvoPaqV5KVXYJBqC0EX4/7hzgU34aLV8
         rIa5ZsF6Ei02iJ4nE0FilWUJJxCi1Ya7hCpqn7DNTZMuDy3TL4L7oP2HDfMDc/Kavl
         Zy9Q6/4lmyaKQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH -tip v3 3/6] kprobes: Use IS_ENABLED() instead of kprobes_built_in()
Date:   Thu, 29 Jul 2021 00:29:47 +0900
Message-Id: <162748618765.59465.7592282417881431316.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162748615977.59465.13262421617578791515.stgit@devnote2>
References: <162748615977.59465.13262421617578791515.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use IS_ENABLED(CONFIG_KPROBES) instead of kprobes_built_in().
This inline function is introduced only for avoiding #ifdef.
But since now we have IS_ENABLED(), it is no longer needed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 756d3d23ce37..9c28fbb18e74 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -180,14 +180,6 @@ struct kprobe_blacklist_entry {
 DECLARE_PER_CPU(struct kprobe *, current_kprobe);
 DECLARE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
-/*
- * For #ifdef avoidance:
- */
-static inline int kprobes_built_in(void)
-{
-	return 1;
-}
-
 extern void kprobe_busy_begin(void);
 extern void kprobe_busy_end(void);
 
@@ -417,10 +409,6 @@ int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 			    char *type, char *sym);
 #else /* !CONFIG_KPROBES: */
 
-static inline int kprobes_built_in(void)
-{
-	return 0;
-}
 static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	return 0;
@@ -514,7 +502,7 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
 					      unsigned int trap)
 {
-	if (!kprobes_built_in())
+	if (!IS_ENABLED(CONFIG_KPROBES))
 		return false;
 	if (user_mode(regs))
 		return false;

