Return-Path: <bpf+bounces-37445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A98955C77
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 14:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC49C1F215CE
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F36EB7C;
	Sun, 18 Aug 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt8niV1M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7245007;
	Sun, 18 Aug 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985298; cv=none; b=U8M9Ra7Av9fq0ZCp2mHXHitigL9pG3uocsNpbQcvT8aOE6vH565WzRlf8SVO7pvklvlmUkLmijj1dfY15Op0//S/lD2iOdd21ZBJZMx7Ekwpx9yYvthBrDlx7q59ltKbtxQ8JOSs0E2q++V5dUBMD0nGqCFs8k65ZKfoeZ4b3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985298; c=relaxed/simple;
	bh=HBF37qGIbrXS0H0xvvsgNI+vHWU7X+x5Df0aUuh2/Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rw8sfqhnAKZ2msRl1PmJ3hNwUYFpiW5M17zHGFWQZeh41bx+lXn1WFeFNeU+7Fje3koFCqZkVjCrwP8ukOGGY4OS+M3QjEXbYSG5ayoUVlu7ZsijtiL9Wd4pnupYc2inAcFC2gPAR+ca+y4Nf+/ZymCQPkA7Aukiu0DUvIRANHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt8niV1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C923C32786;
	Sun, 18 Aug 2024 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723985297;
	bh=HBF37qGIbrXS0H0xvvsgNI+vHWU7X+x5Df0aUuh2/Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gt8niV1MBYVjnHGTViNIabeqNBYgeJVT/93zZdZpE4YNZ7Bql08Gx/Bl5P8wTAx9C
	 /w1W/t5n2UChA7KYDofmrBlV1ALCSCInObAHW6CD3hVs1GbNiNW66753cfNDR0nqOy
	 okSb8wJ3PAxHVi6EwjUdH3J/ga6WYkCArTgnREBxtvzT23nQhu/npiapIjExpLk/vM
	 nYI5nyxyQGtAQ1nQ313TjSRiRJuKQZlUGlSNW0V47+rt8C4QPyMC5zpc/DqWaDbn/p
	 cCKvyZXUoaI1igGhnbsL1Eq9oB0lXS1LLqGrW42m4hYObrC+1T2DDR8VB2ZOCjA1zu
	 sjfbjKzsQdSmw==
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
Subject: [PATCH v13 02/20] tracing: Add a comment about ftrace_regs definition
Date: Sun, 18 Aug 2024 21:48:13 +0900
Message-Id: <172398529329.293426.13822586805973198417.stgit@devnote2>
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

To clarify what will be expected on ftrace_regs, add a comment to the
architecture independent definition of the ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Changes in v8:
  - Update that the saved registers depends on the context.
 Changes in v3:
  - Add instruction pointer
 Changes in v2:
  - newly added.
---
 include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fd5e84d0ec47..42106b3de396 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -117,6 +117,32 @@ extern int ftrace_enabled;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+/**
+ * ftrace_regs - ftrace partial/optimal register set
+ *
+ * ftrace_regs represents a group of registers which is used at the
+ * function entry and exit. There are three types of registers.
+ *
+ * - Registers for passing the parameters to callee, including the stack
+ *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
+ * - Registers for passing the return values to caller.
+ *   (e.g. rax and rdx on x86_64)
+ * - Registers for hooking the function call and return including the
+ *   frame pointer (the frame pointer is architecture/config dependent)
+ *   (e.g. rip, rbp and rsp for x86_64)
+ *
+ * Also, architecture dependent fields can be used for internal process.
+ * (e.g. orig_ax on x86_64)
+ *
+ * On the function entry, those registers will be restored except for
+ * the stack pointer, so that user can change the function parameters
+ * and instruction pointer (e.g. live patching.)
+ * On the function exit, only registers which is used for return values
+ * are restored.
+ *
+ * NOTE: user *must not* access regs directly, only do it via APIs, because
+ * the member can be changed according to the architecture.
+ */
 struct ftrace_regs {
 	struct pt_regs		regs;
 };


