Return-Path: <bpf+bounces-37452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F44955C85
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 14:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12EC282E79
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0617B3E1;
	Sun, 18 Aug 2024 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lo56PSwf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF996286A3;
	Sun, 18 Aug 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985372; cv=none; b=OmqDMC5VnmsnY7Ics7NaQRJT4V6sSugYDsQ92N2F9ZTGL9jBDjDGcJX8cc5kS87oiRv/l50IsY34Xq+IT0uFkrLJvwsF0E0TYjQ9t112zRlCmvHqVmaelAIdTfEPpaaxU5037HlTFmSJbgkfn89B/XjVbATR/uoUAS/FNyjwCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985372; c=relaxed/simple;
	bh=2nS91zR8hxxQeiinpz+7gmkG9syMWEtzVe1ks6gghSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqHFVyYRTswJxkogBTqDnONLJCCF9QnkGgsDvKXhaywtICWFjwPIeq0kr3x6cTK14dLmKgZ1vFCrnWA2Mzfnz3oy7poWOXZ6WnMBwr2gN0rh6AldN5fY0LDftOAiIKhe6Dvd4gtVUEgpE+60kejUhMVW22jiQ7O9ktIz7wkeMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lo56PSwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF24AC32786;
	Sun, 18 Aug 2024 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723985371;
	bh=2nS91zR8hxxQeiinpz+7gmkG9syMWEtzVe1ks6gghSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lo56PSwfDuCeNnXgEGCwIu1ng9XjCOFvkeUikWRb+RMIlCITCaYtJyY9Oe0XUKwae
	 nuH64gK/CYAVD5mLQGovyoU+NwX5YP5XY3eIAPDnIbwec1On8fOxgbj7c3tQUSKB9p
	 VU6LccLsrpA8c8HkIfxRMCpynfBL7sR4OuNi2xanPbMGBTFAIon+WqIHjS3gJ7MhZY
	 l2g1O5UPMcobkrsfWQwjadkXDyTVFnHriovs/7NvwCcAZwA8AI0kpQcHjIw0MHMjWQ
	 rfb5izxFzUxTMDQIvp3uOEQVeHRWusSPk5Oyt7ZPNf7pOCyU9cbnhMWLIhSf6tKTYH
	 gekvW2ZQvJwTA==
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
Subject: [PATCH v13 09/20] tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
Date: Sun, 18 Aug 2024 21:49:26 +0900
Message-Id: <172398536684.293426.13143495645771534794.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172398527264.293426.2050093948411376857.stgit@devnote2>
References: <172398527264.293426.2050093948411376857.stgit@devnote2>
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

Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
This is for the eBPF which needs this to keep the same pt_regs interface
to access registers.
Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
used by kprobe_multi eBPF event), this will be used.

If the architecture defines its own ftrace_regs, this copies partial
registers to pt_regs and returns it. If not, ftrace_regs is the same as
pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes in v8:
  - Add the reason why this required in changelog.
 Changes from previous series: NOTHING, just forward ported.
---
 arch/arm64/include/asm/ftrace.h |   11 +++++++++++
 include/linux/ftrace.h          |   17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index dffaab3dd1f1..5cd587afab6d 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -132,6 +132,17 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
 	return fregs->fp;
 }
 
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
+	regs->sp = fregs->sp;
+	regs->pc = fregs->pc;
+	regs->regs[29] = fregs->fp;
+	regs->regs[30] = fregs->lr;
+	return regs;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a1b2ef492c7f..bd9a26bdf660 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -176,6 +176,23 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
 	return arch_ftrace_get_regs(fregs);
 }
 
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
+	defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
+
+static __always_inline struct pt_regs *
+ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	/*
+	 * If CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y, ftrace_regs memory
+	 * layout is the same as pt_regs. So always returns that address.
+	 * Since arch_ftrace_get_regs() will check some members and may return
+	 * NULL, we can not use it.
+	 */
+	return &fregs->regs;
+}
+
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
+
 /*
  * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
  * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.


