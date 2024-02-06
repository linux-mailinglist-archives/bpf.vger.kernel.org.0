Return-Path: <bpf+bounces-21340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2A84B936
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A03290C20
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EED13AA3D;
	Tue,  6 Feb 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCkrcUek"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13432135A46;
	Tue,  6 Feb 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232367; cv=none; b=ASvLUZi2/8qRmYa0B9bTMoed13OIpB6IjJGLl0xALKLMT+EjCyQoddq92wGi3oHNX7LO21kGfFvFPufViagAIIc2kY35hrVHwPRXnoouNeqZHrbvfZQvFhoaI/LvpO4/PbGP+Y/kCcEEXvE7S0FuTJIb4mEG80EzyOdeQs227jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232367; c=relaxed/simple;
	bh=JC1iyaIU7mWHHBTGXNCiN27YHUuUtROsifUJHNlxJlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtaymrTQwyQljcdkOL1+oxplOi1MBhzAHrxNCSUWke+v2HTYhD6fF7vRFPF13kItb8zPLxbpR7H2gepT6O1lbZX4ug46/W+Y2nPtOO/9j6e/ONNNF1apZyUtjzJusWGU42pnLtMjXyHjUcCI+jO61cJ+v1OPKLv2LWUMQgXZ/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCkrcUek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B91FC433F1;
	Tue,  6 Feb 2024 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232366;
	bh=JC1iyaIU7mWHHBTGXNCiN27YHUuUtROsifUJHNlxJlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCkrcUekzwol6q7xY4KN9mdGIpvgQZ345e7elqG4p2/q3c1f678J6xUrOjXl8/cGa
	 0J9eUke7xFc7qnEO+0qOm5U7vUnfjW6Cs+0t1lUeGh+UEKyNjfV7/3XjsMy2tuWkut
	 gjq8bm7XyzBfwfjnOJOwdruv/g+i6gDAZR0YFT04LhhnlmT6LSqdwJkOCH/cu9ctXE
	 209VEndnyrX5qyPrPiZv/S9s7eI9m4yObjI2CwKrSzdoiou1PutWHSpXWu/P6q9fg1
	 8irylQvdCKrlcRr5Yy21UQEjq+6D9j8rV4WLzDUVfLiEdNWcQFhqlsZ9SRlCVWxhNN
	 5oJyhhvkrosvA==
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
Subject: [PATCH v7 28/36] tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
Date: Wed,  7 Feb 2024 00:12:40 +0900
Message-Id: <170723236068.502590.9568421023325291255.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170723204881.502590.11906735097521170661.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
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
index efd5dbf74dd6..31051fa2b4d9 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -143,6 +143,17 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
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
index a72a2eaec576..515ec804d605 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -173,6 +173,23 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
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


