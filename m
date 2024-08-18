Return-Path: <bpf+bounces-37446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E0955C79
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3011C20E08
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B24965C;
	Sun, 18 Aug 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfxJxmHu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CC31A60;
	Sun, 18 Aug 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985309; cv=none; b=J4tNqpJ4JswP5DQIKQqqiHm4lkfIxsbho5JYO95odRst3V81kp+UgASIzIPofAVkmhSrSQx3dGgEDdCsKoKXQRREhwVx8gxnGlg6nZVsh/PGdqbHry95vRqWBVJ1CreSZCcUGaP1aFrDNX+Hz7KOPeM+qxmBc9cmbzyQIyQ5/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985309; c=relaxed/simple;
	bh=9FGuGUEgN1v7d3WCMclkG2gc4vxIJtbk9GAKnVYDbN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QI20FJ4n2y/MSPMpfC+CqD3pYGZEoFdQGggx2HGhJr5UG9X/gA7ZlPTTQYbVMHYjeTAN0Ikvb2xQG+OtL3mU3enxVmD/mwEgVllBKN+KlsQHeNjWVAVxwxI4a5b3nZhp0oqGRuvvmhrSODCOFUBqXOk07UoShInS94kohW3ygd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfxJxmHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F889C32786;
	Sun, 18 Aug 2024 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723985308;
	bh=9FGuGUEgN1v7d3WCMclkG2gc4vxIJtbk9GAKnVYDbN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfxJxmHuGQ2r+YlJ5xjEGtKdRQgiuybLyx57XGK1Trwh1JmpJ4SKDGWuSSu09npdV
	 d/6Wk/n+5mDRffKTA2wHwXYEEeenmni5phYsZQMMsCERATr5kCEKtiyqn6W8rr8EHK
	 08pA/SR//zZL0Gn4ymlUaxtROSafWfpQIrW3Xd8fTLYozKmVmQPmdBCe+lbqa1mpDm
	 ZwbgkplBZ1XQfk+oqeia2nH0WX+NuhykVNX2hm1ulpkD5jHSxbcqB4Scp1uDhSsOcC
	 bkyhg4Vp5df97DZlCrGO7k8om0jUG84fH5WfsvksuW1OlJ7pWB90wJYhQngBxP6YBt
	 xJFIKIxGh3/RA==
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
Subject: [PATCH v13 03/20] tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
Date: Sun, 18 Aug 2024 21:48:23 +0900
Message-Id: <172398530330.293426.2781164098098962102.stgit@devnote2>
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

Rename ftrace_regs_return_value to ftrace_regs_get_return_value as same as
other ftrace_regs_get/set_* APIs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Changes in v6:
  - Moved to top of the series.
 Changes in v3:
  - Newly added.
---
 arch/loongarch/include/asm/ftrace.h |    2 +-
 arch/powerpc/include/asm/ftrace.h   |    2 +-
 arch/s390/include/asm/ftrace.h      |    2 +-
 arch/x86/include/asm/ftrace.h       |    2 +-
 include/linux/ftrace.h              |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index c0a682808e07..6f8517d59954 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -69,7 +69,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 559560286e6d..23d26f3afae4 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -59,7 +59,7 @@ ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index fbadca645af7..de76c21eb4a3 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -83,7 +83,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 0152a81d9b4a..78f6a200e15b 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -56,7 +56,7 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 42106b3de396..f84fb9635fb0 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -183,7 +183,7 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(ftrace_get_regs(fregs))
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(ftrace_get_regs(fregs), ret)


