Return-Path: <bpf+bounces-30256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADAA8CB88A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF6B1C20951
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8747483;
	Wed, 22 May 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofRodtza"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C278BA4D;
	Wed, 22 May 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341938; cv=none; b=EYG1EmnajJhy7/Kc9DKWxhOU4scpipw5+ql1OnECBd5cFapihtZ3oFR0MZCxP/Wa0dXKOsaNdryDovpiHkt4uyQrj94boHm+78Dc9Ziw8UxKLfEn41K5H0LCnAaHsrKar9vOI1kFvvis0Qij8HyzrwCf9QKoDWOC2kWmMlBNjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341938; c=relaxed/simple;
	bh=IcCH6HvV+fA+Q/OECgPQYvioKi/QPVoGcj2BlQkwI7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aexvW7Sjm3nynFRS2puI/mwr+u2RGUICdMZ40WU9ApyVLJPkKed8rjiXmHIBmWu3ZH7Xi5mDIlNbxlInfcun95DReyTqMxl2a5PxX7WRJwGeLI2sLqcyme8ui0SvEx4z49cKrZbbRIVpEgpYZmtP8vFN7eYYTcqBCgHuG4hskww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofRodtza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCECC2BD11;
	Wed, 22 May 2024 01:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716341938;
	bh=IcCH6HvV+fA+Q/OECgPQYvioKi/QPVoGcj2BlQkwI7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofRodtza/FgNXE4xmXfyT4qa1AIfvDq5rkLcxsb9CLEGMEZeFAGHyMnZJSVcW7CBt
	 kV3HYqpoaRNKCppfCGuQIMu3w3ZGKQJQKLhlXROkxNMGdSq7u7MqHgI7oMNSbOotDX
	 IllNutuhJ6T9tPNGWWAMQ+sqL6WYKgqYGlUsCbIpAqxTrmsL1xBQN0UVjjO9LihbfL
	 VPADmJTeiO9kUiL+jiQ/RZgZ0FNnGz+GFu/x1VIMxV/+2KUV1VvQI7ZW4UAueuJPwe
	 tJTSAk5etDMA8kLNtXByBB06FfE6qGrdM2DsgeakG+fyr89Z4c8/C9UtN/SdNJYeYr
	 PI1XH/4MNO/pQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	rihams@fb.com,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 3/4] perf,x86: avoid missing caller address in stack traces captured in uprobe
Date: Tue, 21 May 2024 18:38:44 -0700
Message-ID: <20240522013845.1631305-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522013845.1631305-1-andrii@kernel.org>
References: <20240522013845.1631305-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing user functions with uprobe functionality, it's common to
install the probe (e.g., a BPF program) at the first instruction of the
function. This is often going to be `push %rbp` instruction in function
preamble, which means that within that function frame pointer hasn't
been established yet. This leads to consistently missing an actual
caller of the traced function, because perf_callchain_user() only
records current IP (capturing traced function) and then following frame
pointer chain (which would be caller's frame, containing the address of
caller's caller).

So when we have target_1 -> target_2 -> target_3 call chain and we are
tracing an entry to target_3, captured stack trace will report
target_1 -> target_3 call chain, which is wrong and confusing.

This patch proposes a x86-64-specific heuristic to detect `push %rbp`
instruction being traced. If that's the case, with the assumption that
applicatoin is compiled with frame pointers, this instruction would be
a strong indicator that this is the entry to the function. In that case,
return address is still pointed to by %rsp, so we fetch it and add to
stack trace before proceeding to unwind the rest using frame
pointer-based logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/core.c  | 20 ++++++++++++++++++++
 include/linux/uprobes.h |  2 ++
 kernel/events/uprobes.c |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..82d5570b58ff 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2884,6 +2884,26 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		return;
 
 	pagefault_disable();
+
+#ifdef CONFIG_UPROBES
+	/*
+	 * If we are called from uprobe handler, and we are indeed at the very
+	 * entry to user function (which is normally a `push %rbp` instruction,
+	 * under assumption of application being compiled with frame pointers),
+	 * we should read return address from *regs->sp before proceeding
+	 * to follow frame pointers, otherwise we'll skip immediate caller
+	 * as %rbp is not yet setup.
+	 */
+	if (current->utask) {
+		struct arch_uprobe *auprobe = current->utask->auprobe;
+		u64 ret_addr;
+
+		if (auprobe && auprobe->insn[0] == 0x55 /* push %rbp */ &&
+		    !__get_user(ret_addr, (const u64 __user *)regs->sp))
+			perf_callchain_store(entry, ret_addr);
+	}
+#endif
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0c57eec85339..7b785cd30d86 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -76,6 +76,8 @@ struct uprobe_task {
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
 
+	struct arch_uprobe              *auprobe;
+
 	struct return_instance		*return_instances;
 	unsigned int			depth;
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1c99380dc89d..504693845187 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2072,6 +2072,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
 	down_read(&uprobe->register_rwsem);
+	current->utask->auprobe = &uprobe->arch;
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
 		int rc = 0;
 
@@ -2086,6 +2087,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 
 		remove &= rc;
 	}
+	current->utask->auprobe = NULL;
 
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
-- 
2.43.0


