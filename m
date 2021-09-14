Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E269040B17B
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhINOlx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234927AbhINOlH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B98760698;
        Tue, 14 Sep 2021 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630390;
        bh=pS3y9et2p/dkxzeM2EJ7grzyp84IGtDqnN8Te94o73g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYrtxnC20Z1mfmqeKqSo1Mn0bb8n+QNBwUs3gIwa8zE3TZa0pSNBxYKbQXw8p6jDQ
         T5bRhqdqXlkRUg8of6b7T1mFrNPLs8FK8Wlo/B3nU0Jno1WDwfdW3WO+PBuvNAomis
         vIqdaysjdhSIWzLjE9VMfQz9ILxg/WzjPIdgEKprOBlg3D//Lsos9kOAj6/Lp/NyqL
         KtukThkqtrVDKb2QcOIokQO5SR8h6nTyx0ZhNdSJYjkdGTYfay7xbbia0ej1mXynwE
         bC8xuTPBu7LUr9FcRMeNwWrBa77EllwvvW1ObaXvkTITv9oYGvpy7i7tHL8CmMdCjW
         jO5A4mEoGsGBw==
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
Subject: [PATCH -tip v11 08/27] kprobes: Use IS_ENABLED() instead of kprobes_built_in()
Date:   Tue, 14 Sep 2021 23:39:46 +0900
Message-Id: <163163038581.489837.2805250706507372658.stgit@devnote2>
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

