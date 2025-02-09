Return-Path: <bpf+bounces-50907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A163EA2E10F
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 23:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F13A59F5
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668951EDA1B;
	Sun,  9 Feb 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHK27Lw9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05311DFE29;
	Sun,  9 Feb 2025 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138722; cv=none; b=MzHO4GPIK0SsEkAxf/RgeIFtr9SThMEOIovbdDMLsFaDrJLDgmZj4mXrTpn09NVb4yQYLBaECPaUmfS831q1JsrukXY5+xuYFmKSd8vGIZdp7GahZ6AKypqTuAeNG/DdmUW49XA5mwr/OPKI6AdcvS5rBPNUJPe9Hk8U6AuEtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138722; c=relaxed/simple;
	bh=zbruKfVxkpPFukeUIwoXti6I5aN9agltekSwmA2xsSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3DhJu5X7geW6kz6bQhJDL7stI8GWvTMsXOMHRsyqSvHjKL7GDhFWU6qk8yigLUfZDRpkUoFC0YKWT+ZfMPhxcXkHhytUW71lC3lHB2RhGy4EVZvVCWuETxiGBa4u2Y5J9T1f2qO9oVLVxPnJZm0gIeIPU0Yh1bBuJC1mC3ErOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHK27Lw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31B5C4CEDD;
	Sun,  9 Feb 2025 22:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739138722;
	bh=zbruKfVxkpPFukeUIwoXti6I5aN9agltekSwmA2xsSc=;
	h=From:To:Cc:Subject:Date:From;
	b=oHK27Lw9zlYvKr1w6qwJGgyLCaQhaU7cckjDRv0sqKfcb1GVT3ZONdV5DIiNr1E0Q
	 HTBbCbuyh65ISkXNrfIQr+M1iMmFtvNOHTHi3ocuT2p2Ekan8+qYC81MiOB1e1K13+
	 TY/UdRpHugPfiT2P4KMTBlDZWaQ0hB2IfJRfk2FhQ1IBpArRXBxUpqM/E9cDJutOdR
	 L6cj5maCuSZcOotv99TQnZUADaoPo+Mi0QKQQtJaX4figKna9vRoctgqI9B4U8yLrs
	 S19F5jVoA24ROqrntsEWL4hpDczi4AAtErJgRva5jsMwQOtSERFji9MQY9Ngla821A
	 tM35F+Egkb+4g==
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
Subject: [PATCH bpf-next] uprobes: Harden uretprobe syscall trampoline check
Date: Sun,  9 Feb 2025 23:05:15 +0100
Message-ID: <20250209220515.2554058-1-jolsa@kernel.org>
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
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..109d6641a1b3 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -357,19 +357,23 @@ void *arch_uprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
-static unsigned long trampoline_check_ip(void)
+static unsigned long trampoline_check_ip(unsigned long tramp)
 {
-	unsigned long tramp = uprobe_get_trampoline_vaddr();
-
 	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
 }
 
 SYSCALL_DEFINE0(uretprobe)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long err, ip, sp, r11_cx_ax[3];
+	unsigned long err, ip, sp, r11_cx_ax[3], tramp;
+
+	/* If there's no trampoline, we are called from wrong place. */
+	tramp = uprobe_get_trampoline_vaddr();
+	if (tramp == -1)
+		goto sigill;
 
-	if (regs->ip != trampoline_check_ip())
+	/* Make sure the ip matches the only allowed sys_uretprobe caller. */
+	if (regs->ip != trampoline_check_ip(tramp))
 		goto sigill;
 
 	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
-- 
2.48.1


