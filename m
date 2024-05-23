Return-Path: <bpf+bounces-30389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DF8CD1DE
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 14:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59121C21488
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61916145B10;
	Thu, 23 May 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnRr8CYV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9A78C8B;
	Thu, 23 May 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466328; cv=none; b=TIkO5+BkuhMbqpuqw5QHKAwdmPog5D1Bx+AsGenu/3b+pDCSME04tjonyMwHLdEH4vY8AWLCq+Wvhhle1F2o8Aem8yB7Km1j2RpHkCwW+EQZSb/wSs73WtBWJ6/RM8eRufDZWp//hR5yN+dFOPgWu0tvtKc7lr1Rirzz6i0ON/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466328; c=relaxed/simple;
	bh=4KoU3dGlMUBwKQpM/wFflS8o8Y5T4LKPosEHs5VfAHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBNZ9ys/61YKaSAp7YaFF2qyRvSfUHErBAMGwqCf5+Wd8R99YTc4IeVbe+VQNvKoYfIrtP4p9qIt8bBX3nG7kv7cinzD707ig4z5U6Nq/jEwzTtMy30pEF45en79DX3AzBcQ5vU6PNs77aNeg1Cby7F2NKZ57Oi9MzPAQdKMM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnRr8CYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4249C2BD10;
	Thu, 23 May 2024 12:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716466328;
	bh=4KoU3dGlMUBwKQpM/wFflS8o8Y5T4LKPosEHs5VfAHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnRr8CYV44f39WMANhHkScQLhPYs7u19HAR1c0QdDnYlAwtQGPvms+uT7pIMvkrdR
	 bM682h4iMLw5iynBrP/DMwnq3nO6ECww0kTs0s/tEMgUvqaahOr1zVC09Yw1Y3Vtnr
	 zZzC88RwYBxt9FWU3G13Nxfos5z5tIhaeENcZFEr6YRi1JjZ1QydXBPpnCND8Az6ys
	 3JfaorxY44t5cYyFqH1HWSoz+whl5LOjAbU0mxQKAGqNnW6el75/1ELpZ3HF9nDu2W
	 /OXhVzZU+RKBPDLFP6DMfW8Y1eD4qjrRu0IN68sHejZ55eHzsCTH1MEqjQCtGmj9rq
	 ngNTeT8wVV3fA==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCHv7 bpf-next 1/9] x86/shstk: Make return uprobe work with shadow stack
Date: Thu, 23 May 2024 14:11:41 +0200
Message-ID: <20240523121149.575616-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523121149.575616-1-jolsa@kernel.org>
References: <20240523121149.575616-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the application with enabled shadow stack will crash
if it sets up return uprobe. The reason is the uretprobe kernel
code changes the user space task's stack, but does not update
shadow stack accordingly.

Adding new functions to update values on shadow stack and using
them in uprobe code to keep shadow stack in sync with uretprobe
changes to user stack.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Fixes: 488af8ea7131 ("x86/shstk: Wire in shadow stack interface")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/shstk.h |  2 ++
 arch/x86/kernel/shstk.c      | 11 +++++++++++
 arch/x86/kernel/uprobes.c    |  7 ++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 42fee8959df7..896909f306e3 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -21,6 +21,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clon
 void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
+int shstk_update_last_frame(unsigned long val);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
@@ -31,6 +32,7 @@ static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
 static inline void shstk_free(struct task_struct *p) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
+static inline int shstk_update_last_frame(unsigned long val) { return 0; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 6f1e9883f074..9797d4cdb78a 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -577,3 +577,14 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long arg2)
 		return wrss_control(true);
 	return -EINVAL;
 }
+
+int shstk_update_last_frame(unsigned long val)
+{
+	unsigned long ssp;
+
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	ssp = get_user_shstk_addr();
+	return write_user_shstk_64((u64 __user *)ssp, (u64)val);
+}
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6c07f6daaa22..6402fb3089d2 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1076,8 +1076,13 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 		return orig_ret_vaddr;
 
 	nleft = copy_to_user((void __user *)regs->sp, &trampoline_vaddr, rasize);
-	if (likely(!nleft))
+	if (likely(!nleft)) {
+		if (shstk_update_last_frame(trampoline_vaddr)) {
+			force_sig(SIGSEGV);
+			return -1;
+		}
 		return orig_ret_vaddr;
+	}
 
 	if (nleft != rasize) {
 		pr_err("return address clobbered: pid=%d, %%sp=%#lx, %%ip=%#lx\n",
-- 
2.45.1


