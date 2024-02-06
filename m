Return-Path: <bpf+bounces-21315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3C84B8D7
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D81C22AA6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA7133400;
	Tue,  6 Feb 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnGrcVj0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DB131E49;
	Tue,  6 Feb 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232089; cv=none; b=g7hYzjwqkoXHYsn4oUprwLyaUyTaYaFycPXbVjtFfut64+GUmI2mupq0pYwFaZIdIuqDAtOgoFLDChfpe73xHscBm7dcd1BcVFAiCIlwkxtrINH6I5B/JzQRxuycHjaWShErk3hIxFQoV7qly8Wty2mHMeTTV04iLLhk3XLucIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232089; c=relaxed/simple;
	bh=r8dik4TbVVoqmCktPN5yl355iEZNp0JZ3yNT9goYFEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUMJtGIBB4xgdHW6SOFr0aA0VH/R+oUmBGS3E8DxPq6Iw9hqJXpAFye+2yVzQ/YkL0WhiW9YTnuGxonmIvCq96I2e4J8u0Xid/7ZPCMLkIssyDa41s/ijkhF/AOKmF+E2v+a4TevXxVpz9gsygRdsiIEEBg2zmTCKIrGXnCEVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnGrcVj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2088C433F1;
	Tue,  6 Feb 2024 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232088;
	bh=r8dik4TbVVoqmCktPN5yl355iEZNp0JZ3yNT9goYFEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnGrcVj0e61rmZKiC1vaToP7QwaUys7+8Esyp4/bKbCgiqcxiR8kutJeATmgvu6xD
	 jkFEt8ijXIuQqnFjzEx7cvamSep9Gl6OxK46yw5SnBALwfTTdqGaWdy0z3kjoXidOk
	 Nv5RMoQgbQbJWTKmCTWJ5dKz8aKI2KPKsfcZnva0ggpY72y7POZLC5OsaSbVHRaMQ0
	 8aLfBVe1Q7qV5JzPI2Fzn8SIP8yz38GgUWwFiUxptgs3vepRZA48UXEDFgnrWzFpaQ
	 43VWjPXthrjcU0fxaVYlQdrQL9ve2gSSy4wdjqOOIIZi8S3hWyweRHpfQpftcjwRcM
	 7qe380LmFc7sg==
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
Subject: [PATCH v7 03/36] tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
Date: Wed,  7 Feb 2024 00:08:02 +0900
Message-Id: <170723208269.502590.11563207960186717074.stgit@devnote2>
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
index de891c2c83d4..b43acfc5776c 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -70,7 +70,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 1ebd2ca97f12..ce2b65cd4607 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -69,7 +69,7 @@ ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5a82b08f03cd..01e775c98425 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -88,7 +88,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 897cf02c20b1..cf88cc8cc74d 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -58,7 +58,7 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8b48fc621ea0..39ac1f3e8041 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -184,7 +184,7 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(ftrace_get_regs(fregs))
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(ftrace_get_regs(fregs), ret)


