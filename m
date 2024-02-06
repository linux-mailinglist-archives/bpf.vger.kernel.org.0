Return-Path: <bpf+bounces-21316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A2984B8D9
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF5128BA60
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C57133427;
	Tue,  6 Feb 2024 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff66VVui"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7713328A;
	Tue,  6 Feb 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232100; cv=none; b=Z/ITh0bi5My3FiY1F5+0eeSfH8BIH4W/kYSBtodo4d5i7FPQXBD73ou0GiMV1xC16egI6iaR5nX1DGroYNuKkIDDPuZ2E64gXulyY+Z0TYUCUaoEbr0vcrkPIVyDFIhB/s/NgyVXaEz7V9Le4Zdt+TttHMTy4fVRo16oDFZMBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232100; c=relaxed/simple;
	bh=Ky/M8O0rm7AMIWcFwVKGUXTVtEFqfb+EU9Ru8C9PH5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skw6j7IaZJdhbz5Z2xErsIN5bhZ9ir02CTBm1ejHjhvD8raAoafYILKEzonJWy6NIIMxoMnjcrEUalu0zs5DFr0hctLsaXUECtxzylo3kBCxBVb7rbayuWwZp9Ndac7CIRgrNSVvTwUAPRSPxAo/S+pv/T3ZNCg7fDXdPcYMTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff66VVui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D69C433F1;
	Tue,  6 Feb 2024 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232100;
	bh=Ky/M8O0rm7AMIWcFwVKGUXTVtEFqfb+EU9Ru8C9PH5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ff66VVuimpifxG4pLQBtMTYu4BkAfVFZ/lJtfwbhKnPXzCxVyHaXJ2Q1Bl1yXh3Na
	 zSE5JDisQTBaf+0b3qLZwh8p5guOqdB/m/I+W/SoQGwFsEbVrHLLz5qyVQteg5Ufqu
	 qF3yqx/VLNOQGqKDcc5SblSw+571AAP6OTr0FR2sLHDDZk7beK/Q35T48DrBuFRUwC
	 52LKbYvoeJ1fl1sOtl413kETW6trynHTApYMMO+u3ITYbmfrUsUv/UNvVAXClRPmVd
	 wBD/Espx+RxssAyUKAOqeJj1z0Mu1Z1YGldSuar7RL1wShyhL9tQ3bHunRnbvIE0rF
	 nxJo7PbHfPdGw==
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
Subject: [PATCH v7 04/36] x86: tracing: Add ftrace_regs definition in the header
Date: Wed,  7 Feb 2024 00:08:14 +0900
Message-Id: <170723209417.502590.1912889418952674532.stgit@devnote2>
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
 


