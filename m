Return-Path: <bpf+bounces-26774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7758A4FB8
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 14:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0098C284B80
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02D58172E;
	Mon, 15 Apr 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBVvizSB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE280BFE;
	Mon, 15 Apr 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185378; cv=none; b=l7GpKNZFhfAwYH7fXAbWIniMDGUqXG32CocWsAk9ma9a+Cr4ew3WH3R533Hjnt7ozEwhiP+G7FFd8g2NvX6aqU5EHi1mawVP7EC4dru0aghiCCX77GaWcjtonfOn+APLh7KqJgqBjhWprrJCe0h5fAcGo5JP9OwCHVOZW7V7knI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185378; c=relaxed/simple;
	bh=Ky/M8O0rm7AMIWcFwVKGUXTVtEFqfb+EU9Ru8C9PH5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVhD/R+9+rWP76G8irexRZFtfqiNYZI5/sScF8lYaUfZxjLgj4ogqND0FQLYE0zooNwFvdWB3sUbWHknrpyCBqJPGGAzHaxEou5g22kD5yyRTqh4BZh/iqwPqGXZ9DyLR0l2SFvBNdvMzICMs2OnzruTAmVivW4bGi8dx7RvSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBVvizSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003A8C2BD10;
	Mon, 15 Apr 2024 12:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185378;
	bh=Ky/M8O0rm7AMIWcFwVKGUXTVtEFqfb+EU9Ru8C9PH5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBVvizSBUMGrVT8rY3nQdZzju1MrHmb4eevqf16UecUF5/pf1RXMmrdwDkDSTYTUx
	 1qRCVatyb3Hw8Njz1qJZlRQ06Ethvv56chp9wZJRS/YWiy36ozgfA7KSz2AN/ExAp8
	 1TGFQzW5ZjUQ8Bhq5rnxnZkv2mQk86s9csI6XMavAwVYmjCVSDL2lMtHTROfG3uhVR
	 mril2N+slpyyaP5QmPBuEsg0ktfYje3AZs2nC3WvNM/qRxb6VjdXgG+DEQXRidZR/+
	 I/baYICOCSdBogfAvLhFoNx9jJQbd5HlKP6/JtBr3KsMl515cgEiuWgnRMt5+AKXzI
	 2oNb8+i9y3EZg==
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
Subject: [PATCH v9 03/36] x86: tracing: Add ftrace_regs definition in the header
Date: Mon, 15 Apr 2024 21:49:30 +0900
Message-Id: <171318537073.254850.18255104445724151465.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
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

Add ftrace_regs definition for x86_64 in the ftrace header to
clarify what register will be accessible from ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Add rip to be saved.
 Changes in v2:
  - Newly added.
---
 arch/x86/include/asm/ftrace.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index cf88cc8cc74d..c88bf47f46da 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -36,6 +36,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 struct ftrace_regs {
+	/*
+	 * On the x86_64, the ftrace_regs saves;
+	 * rax, rcx, rdx, rdi, rsi, r8, r9, rbp, rip and rsp.
+	 * Also orig_ax is used for passing direct trampoline address.
+	 * x86_32 doesn't support ftrace_regs.
+	 */
 	struct pt_regs		regs;
 };
 


