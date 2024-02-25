Return-Path: <bpf+bounces-22656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB2862AFE
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35AA1C20AB6
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101A14290;
	Sun, 25 Feb 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF7Fcv6G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A4125C1;
	Sun, 25 Feb 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874142; cv=none; b=OnYkCx+keY4NbqRSCu18JEtjqQGkctgeiSkQta5WH1z2AQBCAMo2wJNVMPcCagLpYDyR/EfR/9N6PQENZzijxXpz9N/faLKnu/GF+FQjzjeklVP1yoTVMYzzWk6hzk3fiXiKsgGCW37wZNWJs2DlFV3AtFlsErsmvCXiM+48CFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874142; c=relaxed/simple;
	bh=Ky/M8O0rm7AMIWcFwVKGUXTVtEFqfb+EU9Ru8C9PH5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YILBoB4mWCkFXY7IvmIXXuHW4C41r0z0x8k7K9JN/50QXvPZ+71JuTrQy1OwLkuXct/8EkgXKIYLpcI85S0YZGFie3hGu/rNee3lDUe+M9gC2uIMUlUXWFvjjzi+g5e9pC7EdVI4ViVxwMqDR49CwGhkARAtys+OpcJCHf30muo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF7Fcv6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50304C433C7;
	Sun, 25 Feb 2024 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874142;
	bh=Ky/M8O0rm7AMIWcFwVKGUXTVtEFqfb+EU9Ru8C9PH5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jF7Fcv6G9W2IrXgKAhiYtOiW+5ZqB3//sKd6o5EWirPLh5pfm4ioRvvnOLWc0FZB6
	 Rtx0yb2fvCwDpqbIUb/3h5lP6iuWyvPSuTHyzEE7+MmEwmA2Tuld53DXVclis3quPE
	 GBouLw1KuA7bl/YSH5+jzAOaETgTacBwLou1/eEgSkduIXLF4t1YfHHGmIgTEZUozX
	 GjjMq2HVgggFPloaTU7SqIXxYDpiAoKnE6UJ33Fnocc5zt2Yo2w4jbVfqYzfhKr7ID
	 9Kg15C7LyxWTZTjsGH5/ogHafBvBswCDAQyUfpjktgTLNeLMDUDzOK0CH/2OQEx714
	 W1y8iECtrZ69w==
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
Subject: [PATCH v8 03/35] x86: tracing: Add ftrace_regs definition in the header
Date: Mon, 26 Feb 2024 00:15:36 +0900
Message-Id: <170887413645.564249.15526252585297594575.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170887410337.564249.6360118840946697039.stgit@devnote2>
References: <170887410337.564249.6360118840946697039.stgit@devnote2>
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
 


