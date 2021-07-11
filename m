Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5D3C3B0A
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhGKHhc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 03:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhGKHhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 03:37:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4290D61353;
        Sun, 11 Jul 2021 07:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625988886;
        bh=GqW0l+mkoucVPyOJw1b+uyY3Gwoy/RAaHXL0PdUYGns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvxgDLmrkpQoYsioxwrVHVzTKVDvJLu7A2QuAxq3nJ5fy5e71W4ZEw3zEqwzEtcNe
         FpyUVPcugcLpHZRQdKF+WevF22hwtJHsRhL1r+HQMAx3huYU9BBer1FE8xohAMro/A
         wjDebFF7oV+1JqKVpvJ4yjPifDSBXcDAD1dVyANG9fxopQ0r9F/r4xRNaPQt07stte
         POg0MgoY4DeUaHwVAu1CJtPXuMz6GOn+1pZXCn7y4coj0jto5GZ5EYy6zsNrCeCEEf
         ybkm3KdAai57qBL3BFx5vfSyZfRMSgBfPiJRG5D69sfpwK65aeM7r4F3KWYEOINJSs
         m2AgawjZ6B3BA==
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
Subject: [PATCH -tip v2 3/6] kprobes: Use IS_ENABLED() instead of kprobes_built_in()
Date:   Sun, 11 Jul 2021 16:34:26 +0900
Message-Id: <162598886597.1222130.9754098713625837824.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162598881438.1222130.11530594038964049135.stgit@devnote2>
References: <162598881438.1222130.11530594038964049135.stgit@devnote2>
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

