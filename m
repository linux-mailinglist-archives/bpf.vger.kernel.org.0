Return-Path: <bpf+bounces-33749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9698C925802
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200E41F27C12
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE787143743;
	Wed,  3 Jul 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiTlPZmq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F3156F28;
	Wed,  3 Jul 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001451; cv=none; b=UvGGAPvw3+PvMxUiUFl2/eBCOV0qsSV34ua6Baz3ZSBjXilKTT/0bEhbM0DfeeJHOYcfjiHjwqZeMn5WRmm9K9PsyUJG9p8lJr+KH1NoglbZvVLq2CkPr8695N9TMv40srwz2qs561Oy70mbqk6plfb0YXOXmkYfFwcbH+eo9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001451; c=relaxed/simple;
	bh=/VkGokuIcVcQano3dTMPV/ivHT7rHLNTBlAmf8sfb3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJ+c1/9mDHn4YqYXSqDZKk8EeaJ4Q1hpAUyyiZ1PEMSBXxmNKYynpwnFONombC36iWLsvktQQPxwwjKlCI8ly2x9EIKV0TgAFRut+4e4Pjk5Z+h04GOe5UQ8xxnU4zWVbM+j7m198HcZ+s4etNloarXLG9HVAjexj+bc4iOTiB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiTlPZmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3C0C2BD10;
	Wed,  3 Jul 2024 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720001451;
	bh=/VkGokuIcVcQano3dTMPV/ivHT7rHLNTBlAmf8sfb3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiTlPZmqAb9/79POs71CeHpoa3Fh8vgMxP1iRJTFeHwZdaNHoH121/R8Y0eBdWr6d
	 qxOTdp6b50FfxsicVx/+B9iHlFK1tV4MSjnWrol9ixHi3+OcA98tyC8K27wZabMKMq
	 4qO7GOamVsEdCknJOqkJndGJ0dR0vEFlpHd39jXVYcqIf92/M7PWVf9637QWZbbNqf
	 DpCKMexZSZESLZVjif33QDtR9dFov/oJ/pvDwisdJP5wrquF2NCLbh4BoTdj8vLAOK
	 WSVTcTwoPxzqtcHsysoCBsPY3IKWMN2GHKdxHg9fBDs0ctaD7e5eL85OENurFVTcaQ
	 /osx0KTf5Cv2w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v12 09/19] tracing: Add ftrace_fill_perf_regs() for perf event
Date: Wed,  3 Jul 2024 19:10:45 +0900
Message-Id: <172000144512.63468.11067921600751750321.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172000134410.63468.13742222887213469474.stgit@devnote2>
References: <172000134410.63468.13742222887213469474.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add ftrace_fill_perf_regs() which should be compatible with the
perf_fetch_caller_regs(). In other words, the pt_regs returned from the
ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
used for stack tracing.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Changes from previous series: NOTHING, just forward ported.
---
 arch/arm64/include/asm/ftrace.h   |    7 +++++++
 arch/powerpc/include/asm/ftrace.h |    7 +++++++
 arch/s390/include/asm/ftrace.h    |    5 +++++
 arch/x86/include/asm/ftrace.h     |    7 +++++++
 include/linux/ftrace.h            |   31 +++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 5cd587afab6d..14ecb9a418d9 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -143,6 +143,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
+		(_regs)->pc = (fregs)->pc;			\
+		(_regs)->regs[29] = (fregs)->fp;		\
+		(_regs)->sp = (fregs)->sp;			\
+		(_regs)->pstate = PSR_MODE_EL1h;		\
+	} while (0)
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 23d26f3afae4..e6ff6834bf7e 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -42,6 +42,13 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 	return fregs->regs.msr ? &fregs->regs : NULL;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
+		(_regs)->result = 0;				\
+		(_regs)->nip = (fregs)->regs.nip;		\
+		(_regs)->gpr[1] = (fregs)->regs.gpr[1];		\
+		asm volatile("mfmsr %0" : "=r" ((_regs)->msr));	\
+	} while (0)
+
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 9cdd48a46bf7..0d9f6df21f81 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -84,6 +84,11 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
 	return sp[0];	/* return backchain */
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs)	 do {		\
+		(_regs)->psw.addr = (fregs)->regs.psw.addr;		\
+		(_regs)->gprs[15] = (fregs)->regs.gprs[15];		\
+	} while (0)
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 669771ef3b5b..1f4d1f7b19ed 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -46,6 +46,13 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	return &fregs->regs;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {	\
+		(_regs)->ip = (fregs)->regs.ip;		\
+		(_regs)->sp = (fregs)->regs.sp;		\
+		(_regs)->cs = __KERNEL_CS;		\
+		(_regs)->flags = 0;			\
+	} while (0)
+
 #define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
 	do { (fregs)->regs.ip = (_ip); } while (0)
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8e5da4dfb669..d9a3723f987d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -193,6 +193,37 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+
+/*
+ * Please define arch dependent pt_regs which compatible to the
+ * perf_arch_fetch_caller_regs() but based on ftrace_regs.
+ * This requires
+ *   - user_mode(_regs) returns false (always kernel mode).
+ *   - able to use the _regs for stack trace.
+ */
+#ifndef arch_ftrace_fill_perf_regs
+/* As same as perf_arch_fetch_caller_regs(), do nothing by default */
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {} while (0)
+#endif
+
+static __always_inline struct pt_regs *
+ftrace_fill_perf_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	arch_ftrace_fill_perf_regs(fregs, regs);
+	return regs;
+}
+
+#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
+
+static __always_inline struct pt_regs *
+ftrace_fill_perf_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	return &fregs->regs;
+}
+
+#endif
+
 /*
  * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
  * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.


