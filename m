Return-Path: <bpf+bounces-28840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99698BE544
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168841C23A05
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30ED15F41A;
	Tue,  7 May 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8fa7Bpi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C815E7E4;
	Tue,  7 May 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090922; cv=none; b=YwU17p4YSbMwZtO5jJk5u50cDrlsdf1kqhPrqF9rCpm+uKHKVbY0HIN+i9ae/VmjYa8I8b9KfpigQF4+6lma/6aq+fb/V35HAgQ4ZMOOrbZinoRv+9jhmNkmhHS6EXQTVbVow3MkAInOyqsm0PXO0YqpXM0jYbeg3vrs1fKrYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090922; c=relaxed/simple;
	bh=Ky/M8O0rm7AMIWcFwVKGUXTVtEFqfb+EU9Ru8C9PH5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/gZWeF2RU/Qht2fqKGmlFc5lGKbJUJYKbgvyjfuhDb/pK2g5lWqrmesLl3TtGTn9VkA4CB21Zv3giBfvBinuhr0U+6OygwyMh4b/53qNeMsOVdQRW5NLX1QZLi+andvlNO8HcFWHqLNdeM6kFeTgfhqwuzoKf24NyDTOzOz2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8fa7Bpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC44AC2BBFC;
	Tue,  7 May 2024 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715090921;
	bh=Ky/M8O0rm7AMIWcFwVKGUXTVtEFqfb+EU9Ru8C9PH5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8fa7Bpi8DFcRIYppDjwBdtP3uubc/ubqGgttVwMlr0tesTk4xAWTIP7llsMiu39f
	 X1bxjEkVdKBEIydeNPtztv9Bk1fxvSF01hlphsOnIHzI3KuK6unuw3yMlhmrqmtAd1
	 Jx/zVRQqR5qeg3aJDgmSgND+CdVUocjQxzjDJS3P3xAxN758ycI4Ws46oN0Y3GeQkI
	 DX9Tsh/VpH3HhoJC9oAn1uvSxDGA21znK8NVfVekWpmK1CvJtyB+KOkZ5/AneWfI/U
	 plydzSjAN8f+6DI30K2P9dbJQau/OFTPpuo3c8ph/1eGHZ4Fjyc+0ZuX/cDxSOCpWK
	 yOIh278bExT5A==
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
Subject: [PATCH v10 03/36] x86: tracing: Add ftrace_regs definition in the header
Date: Tue,  7 May 2024 23:08:35 +0900
Message-Id: <171509091569.162236.17928081833857878443.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171509088006.162236.7227326999861366050.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
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
 


