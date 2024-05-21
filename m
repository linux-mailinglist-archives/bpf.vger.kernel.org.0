Return-Path: <bpf+bounces-30102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A56F8CAC7C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8031C218BC
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E0273174;
	Tue, 21 May 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfP4+Oh7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE696BFDC;
	Tue, 21 May 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288525; cv=none; b=oqbXWtEnGGTdjA/CdkrIymMuK7R7syCcCpmDHQ7u1xhNuvJYZCWm/N6486PdLCjbS2AEcEiqR0UYV4GZh88J1cob2L/XUMbIf1yGc3/5zP7YwoCHgm+jeECm180z5vXRJgCTuxFPk1eWBQ91Z0EDDY5Vj58SM42b8VYB92fm0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288525; c=relaxed/simple;
	bh=Z8DXNDPnmFnRTeFkXHNzbgWi0PNawYnnzOuslkQUpZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa6y6sJXkqLUnNVFWZ4nwOjU5fNRaF7XivL2m0btHyjaUKadtG8Z0bVmVFxvE7eS+7/6TABBqUM7B9wxKn1d7Iu/ZTBTu4G7QGKzvu4SwYhuY/VZuGbY9B+LKj94UGeNb73T/gdbFGZuHoMo4rN4UIna2H4Mq3RE66h+l72aFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfP4+Oh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D191C2BD11;
	Tue, 21 May 2024 10:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716288525;
	bh=Z8DXNDPnmFnRTeFkXHNzbgWi0PNawYnnzOuslkQUpZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfP4+Oh7+GXfzLtJc1453I2ZgPPd2dt7EQilKIhug2ROnj/ux1URKK+GIinbYKVCC
	 E+979p5uS2BS0DITqJk1NE5KO1dv0oY0wqR3VOKiuEJiZYyUKIXV9n5xLcIFjypnso
	 nSeCdsa5A+H5S03zMTf0Dh9ScLbCv/0TlzEjQLN7V9jA/OjBHB/HVzKD3AfBjSSY1S
	 Aw8CQR4PRjMDAzYmAs61o6bLipJpHxFwVA5eUqfqnr678k+SBTe+LCKE7tJUZR20gW
	 XqQZ8/phLvB95M1VG4limxenOZvrMz5KYKyXdbnfkCH8rtR3PUQkhaBhERC89l3Pgm
	 tSSIRITrhoALw==
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
Subject: [PATCHv6 bpf-next 1/9] x86/shstk: Make return uprobe work with shadow stack
Date: Tue, 21 May 2024 12:48:17 +0200
Message-ID: <20240521104825.1060966-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521104825.1060966-1-jolsa@kernel.org>
References: <20240521104825.1060966-1-jolsa@kernel.org>
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

Fixes: 8b1c23543436 ("x86/shstk: Add return uprobe support")
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
2.45.0


