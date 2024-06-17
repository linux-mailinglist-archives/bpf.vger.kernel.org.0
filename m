Return-Path: <bpf+bounces-32253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A8A90A1F7
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 03:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394A21F210F4
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B616132F;
	Mon, 17 Jun 2024 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNDHGKDz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE1160884;
	Mon, 17 Jun 2024 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588887; cv=none; b=c3srDuAcFEwEMS7Qz4S4CIJztz4gLTALqye/bzXANXGBbvQBF0vAafL8CGEU/1FOp+ktMYwwgG6Nu4oDfHZv5NsVmR0agh4lPnGXnBlDwKelxV0to2Fc6ax6ze5dCbJuVhnDB8Za58yZ5U0z3Yi2rtZjAFE9fbjJPddApdJ7ZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588887; c=relaxed/simple;
	bh=v+ndCkQC6hxxweJTYXdlfbViE3auXeHXe5Z/+0ut9Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJx106dQtZzQeZu0Dk5uewpS0hMM3FQJITf2FCYeKj77PjYcvN0v2cXWUo/ArXiocQDU03Xk0HtDPckuRC5V7gJNyInNbAZlJMn754iBruUOszELhKEBmkk3Xe0t9DIBdzk/yx9RdAGNvVOW4XvQV1DTm9fgwRZ+QEx0tkZ1a/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNDHGKDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4E3C2BBFC;
	Mon, 17 Jun 2024 01:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718588887;
	bh=v+ndCkQC6hxxweJTYXdlfbViE3auXeHXe5Z/+0ut9Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNDHGKDzy6rd3s+qEqA0235h9i07HSM9SPUjS6hwOod4+rQdDpudjsziDNqe5nGWR
	 YrF+AmrsG5nE9rnvypi+X6mVqVOMDfehbf2uJOTdUWfgQtaj3GiWSuEvoEYV3u0P1/
	 UCMX1pJEK8w61jwQM/jd08m16X4r8rpZtL4JB2rNWwCvXLHVb8VWeEYrEsP6nXymrI
	 f2kujOX2b+4asY4YPRoFsfaJ+Vkk287lk4UWuqKUDFB4hljVrnO59tFOZAQ94eGBOq
	 FJLtPSpoL3i2Hq/MHSA73MN+mDTNOlwueSBGgZk+eTCjNFIZPvSpA83Cnwg8M0ALqI
	 +LV+d5w35QBjA==
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
Subject: [PATCH v11 08/18] tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
Date: Mon, 17 Jun 2024 10:48:00 +0900
Message-Id: <171858888079.288820.8680496982210564353.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171858878797.288820.237119113242007537.stgit@devnote2>
References: <171858878797.288820.237119113242007537.stgit@devnote2>
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
index fa578748f7d2..8e5da4dfb669 100644
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


