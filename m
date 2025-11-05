Return-Path: <bpf+bounces-73624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79613C35BCC
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 13:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E06B189B59A
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE33164B0;
	Wed,  5 Nov 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh8V1Jzx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93D309EFA;
	Wed,  5 Nov 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347577; cv=none; b=dPaS4OsYQLVoXpKAxJWyaNxN173fxJvV4C4NTeuBIWCMRn4YuNlgMcnYHBWyldKquNB+uXbiz+d6OdlrXqFvIx/dkGst+zgZZjo9bHZzYWWSsG86kred0lJJKhSi4xAQdI8uH/aiMSCTX7etOHABdAp97joDqU/vGOEfhuAo4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347577; c=relaxed/simple;
	bh=jpnJ48qhdCzZWVaUVk/6Kd9usKKrMZGpmnLRffFITaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyE6UACT20t9FxCAiNKoy/hyvD2O6vzd4rOLjOWrZnn0LMkFN+a8cbk+mISl5rFvLy98wti4PjXffi3Q+veod04jSeJQO7Vb2Nmlblho8RJbaYcJGQwAcSNXdTVXdrmbnhlymPiRdQrIr3ImJdWnbSPCdcLxUkkhugT1vJJuhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh8V1Jzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96201C4CEFB;
	Wed,  5 Nov 2025 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762347576;
	bh=jpnJ48qhdCzZWVaUVk/6Kd9usKKrMZGpmnLRffFITaM=;
	h=From:To:Cc:Subject:Date:From;
	b=dh8V1JzxYunjByCIMP+bNdUc23uJ97cuIrGZSn9GTuEHit1ac7nDZMSTF0o7nLDyT
	 zi5k+dp6JSjiZ5z/Fym3Abmcx/xTrMR5h+ztIPXGpdwWS8Ni5/KhQ7Q1mZkjn0xdQN
	 VMn7yqnBYIJXnN7jIyE+fq1hx/tSADE9h7nAbMBgyknti7l7ST/JaQHsvIu8eEQ1aV
	 FUhy1bnP11BOdizIZWdnrXJ+WHWjqtjw7CaOZ9p1y7SyJtlfMU6dpG/WzLRGBSIu6v
	 BN3ge8M+q5I/7QempGWXqY1/qAwkRpWkkp72J8Axv1SRI/0IT0jQ6CDTQTb5Gkvbkl
	 YflHEy4uz4Sww==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after bpf_prog_run
Date: Wed,  5 Nov 2025 13:59:23 +0100
Message-ID: <20251105125924.365205-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
Mahe reported issue with bpf_override_return helper not working
when executed from kprobe.multi bpf program on arm.

The problem seems to be that on arm we use alternate storage for
pt_regs object that is passed to bpf_prog_run and if any register
is changed (which is the case of bpf_override_return) it's not
propagated back to actual pt_regs object.

The change below seems to fix the issue, but I have no idea if
that's proper fix for arm, thoughts?

I'm attaching selftest to actually test bpf_override_return helper
functionality, because currently we only test that we are able to
attach a program with it, but not the override itself.

thanks,
jirka


---
 arch/arm64/include/asm/ftrace.h | 11 +++++++++++
 include/linux/ftrace.h          |  3 +++
 kernel/trace/bpf_trace.c        |  1 +
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index ba7cf7fec5e9..ad6cf587885c 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -157,6 +157,17 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+static __always_inline void
+ftrace_partial_regs_fix(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
+
+	if (afregs->pc != regs->pc) {
+		afregs->pc = regs->pc;
+		afregs->regs[0] = regs->regs[0];
+	}
+}
+
 #define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
 		(_regs)->pc = arch_ftrace_regs(fregs)->pc;			\
 		(_regs)->regs[29] = arch_ftrace_regs(fregs)->fp;		\
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7ded7df6e9b5..4cb1315522bb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -205,6 +205,9 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 	return &arch_ftrace_regs(fregs)->regs;
 }
 
+static __always_inline void
+ftrace_partial_regs_fix(struct ftrace_regs *fregs, struct pt_regs *regs) { }
+
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a795f7afbf3d..7b5768ced9b3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2564,6 +2564,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
+	ftrace_partial_regs_fix(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	rcu_read_unlock();
 
  out:
-- 
2.51.1


