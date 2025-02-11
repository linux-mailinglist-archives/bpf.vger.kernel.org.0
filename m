Return-Path: <bpf+bounces-51136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F40A309B7
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A2E188B850
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35C1FECA7;
	Tue, 11 Feb 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkhO3twI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649D1F4E38;
	Tue, 11 Feb 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272566; cv=none; b=OIRmM78zzCYtMeLupdtXxKwtejNAOdfAfkpkvCVKSj9QZIGL7h2msVVDIW9P/C2PB5l91WtHSp8GmxaNqBuzCsYi9k6F7bBSYcug7yKejaWE3tSH10Ujbu173LqtG7h7L9mRQhtM6EeoFeN/bv+kW6F6OfMiwXJumgA9zqHoGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272566; c=relaxed/simple;
	bh=9ZbJmMaSmPWAbfa1NYstLThBZ/6nU/1AYKOuhITOhfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liz6VGFGDe8EZFgdnPSd6iv1/54kJfhSgKAlXElyC9s8NWm9fFtunNDHyBmFriyTlKaff0ccWinQdu5knrWBpv/5eZIWPTUyh4BbfNqV/FMvoMT4YQOIO5nRNfORtFnSU4OeCbujGAsrINbsby2vpt4GdZe0NkFqKL8k233+Cms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkhO3twI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F052C4CEE4;
	Tue, 11 Feb 2025 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739272565;
	bh=9ZbJmMaSmPWAbfa1NYstLThBZ/6nU/1AYKOuhITOhfY=;
	h=From:To:Cc:Subject:Date:From;
	b=DkhO3twIQ5FjUExRyGH0tjaE6f2pFWEtJXwTpz2M7/z7hufEaDy42nvA2Z1zuRjkL
	 pgvz8za8qNP1ymdwmseJjw5CBHq0NUN1CWGH8yD/7HLeTCquFjc+sF3/9orMjYBAfC
	 yyxvh38Tw5kvbErh62JqQaceUgI9tWvAjYZYnpOnNnN7chOog4IcGEnXOp4aVKothu
	 8zxrHBlCQw6Yj1bBi9zBjVI1b3749WnsD4bakKgnUIrFZEBDYjKeZYX4V0e4CFY8e0
	 N1ptcvTUi5NhAvem2gOrKx4fD8xAX+rXXQEe83wexeXqehOGvnjUtpZWnDp8wJPwCV
	 CNkdghXxsahhg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCHv2 perf/core] uprobes: Harden uretprobe syscall trampoline check
Date: Tue, 11 Feb 2025 12:15:59 +0100
Message-ID: <20250211111559.2984778-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jann reported [1] possible issue when trampoline_check_ip returns
address near the bottom of the address space that is allowed to
call into the syscall if uretprobes are not set up.

Though the mmap minimum address restrictions will typically prevent
creating mappings there, let's make sure uretprobe syscall checks
for that.

[1] https://lore.kernel.org/bpf/202502081235.5A6F352985@keescook/T/#m9d416df341b8fbc11737dacbcd29f0054413cbbf
Cc: Kees Cook <kees@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>
Cc: stable@vger.kernel.org
Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
- adding UPROBE_NO_TRAMPOLINE_VADDR macro (Andrii)
- rebased on top of perf/core

 arch/x86/kernel/uprobes.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..e8d3c59aa9f7 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -357,19 +357,25 @@ void *arch_uprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
-static unsigned long trampoline_check_ip(void)
+static unsigned long trampoline_check_ip(unsigned long tramp)
 {
-	unsigned long tramp = uprobe_get_trampoline_vaddr();
-
 	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
 }
 
+#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)
+
 SYSCALL_DEFINE0(uretprobe)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long err, ip, sp, r11_cx_ax[3];
+	unsigned long err, ip, sp, r11_cx_ax[3], tramp;
+
+	/* If there's no trampoline, we are called from wrong place. */
+	tramp = uprobe_get_trampoline_vaddr();
+	if (tramp == UPROBE_NO_TRAMPOLINE_VADDR)
+		goto sigill;
 
-	if (regs->ip != trampoline_check_ip())
+	/* Make sure the ip matches the only allowed sys_uretprobe caller. */
+	if (regs->ip != trampoline_check_ip(tramp))
 		goto sigill;
 
 	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
-- 
2.48.1


