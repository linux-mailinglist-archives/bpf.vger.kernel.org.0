Return-Path: <bpf+bounces-14253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C1A7E1479
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 17:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759A11C20A71
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F519154A4;
	Sun,  5 Nov 2023 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOu4qL9y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87060E547;
	Sun,  5 Nov 2023 16:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803E2C433C7;
	Sun,  5 Nov 2023 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699200724;
	bh=vk7wW23Tf7Fx6d6+RxROO/tS9W9QJV09ekq203vNHlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOu4qL9yDmBwLqq8yLMtEshX1dvrrI23mX14nn5KTizYb62gVzWSwPBQ63E/L6wfH
	 T/Mrt6azvN04jRkQrKAmFTJyuTLgLeBCwsDX0p6D/gKAloVK9nqSMQCXIbYZZpPFzL
	 IVKIVLRra1NPM+Wg0wdGufy5qm2m4ml3mlYm4EVNU2+TdgCERNasGRXxOQfxYP7H/b
	 DedDBIQe9cwh9/OvBxcXd/s3MFHFdxTXyLFE2ethoyrcaWcgrJzs6hQloqco4IFMpw
	 MnPo9caW1dbtOi9FHePoVjuUyg2yAyNJveVhceuLRtuqe4aJ5V78xnmvHBhlsyxJAM
	 hgE5NoBXcwIpQ==
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
Subject: [RFC PATCH 27/32] tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
Date: Mon,  6 Nov 2023 01:11:57 +0900
Message-Id: <169920071741.482486.15046208284937337125.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
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
If the architecture defines its own ftrace_regs, this copies partial
registers to pt_regs and returns it. If not, ftrace_regs is the same as
pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes from previous series: NOTHING, just forward ported.
---
 arch/arm64/include/asm/ftrace.h |   11 +++++++++++
 include/linux/ftrace.h          |   17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index ab158196480c..5ad24f315d52 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
 	fregs->pc = fregs->lr;
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
index 894117e909dd..3d0ff6e2c4bf 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -147,6 +147,23 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
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


