Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5F3C34F7
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhGJO6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 10:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhGJO6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 10:58:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49E916135D;
        Sat, 10 Jul 2021 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625928950;
        bh=GqW0l+mkoucVPyOJw1b+uyY3Gwoy/RAaHXL0PdUYGns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpqapYBLlQE5IlFLYyjlYNSCCqBBXpUpUOLzC/FixL8KBxsPpcRYfalwdOn1rGV4p
         xekZQ70ImhMTwBcnTmJnlc62GBozhLiUTjHRvebNB6Z7nYp8qqpAtedvO7QuVAkp0d
         1++fQK1wX/2GSqQ02yvfANsbSnMsmhTvxezXMF7YCOOKkY4K8wC5aWoDdlsx2Ii8Nd
         AUo7Pfuehd445UN0dlRsGAEH5NDBJVs33m3OxTmvjtnG89qgOn9aymU8QNlK7EAFnU
         5kpyl3rCN9XmreI7YCjyu6uJIaS/DjQJ9itN7kMd9z+b1naT6gP7LIeC2zRNMzlwQa
         fzXOA8XqFUA5A==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip 3/6] kprobes: Use IS_ENABLED() instead of kprobes_built_in()
Date:   Sat, 10 Jul 2021 23:55:46 +0900
Message-Id: <162592894661.1158485.13236889081287453022.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162592891873.1158485.768824457210707916.stgit@devnote2>
References: <162592891873.1158485.768824457210707916.stgit@devnote2>
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
index 28c04f1f2b73..3d02917c837b 100644
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
 
@@ -414,10 +406,6 @@ int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 			    char *type, char *sym);
 #else /* !CONFIG_KPROBES: */
 
-static inline int kprobes_built_in(void)
-{
-	return 0;
-}
 static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	return 0;
@@ -511,7 +499,7 @@ static inline bool is_kprobe_optinsn_slot(unsigned long addr)
 static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
 					      unsigned int trap)
 {
-	if (!kprobes_built_in())
+	if (!IS_ENABLED(CONFIG_KPROBES))
 		return false;
 	if (user_mode(regs))
 		return false;

