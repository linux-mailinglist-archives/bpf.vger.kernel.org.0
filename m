Return-Path: <bpf+bounces-78071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5871CFCE49
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 10:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6564D30A6E9B
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B37E2F619A;
	Wed,  7 Jan 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxstRZ3I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250D2C21C5;
	Wed,  7 Jan 2026 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778388; cv=none; b=OPA9rrtPz1ZI07KkQnjmgX5VffGIKXyZWxWmL35Zp8xAtqFb17PO6iwe9hzFnYFQlPuImRnINJPPIRQ6kXaIjACpkMfBOSVK4HgwDpJNaEhjEt/iyu/IJojrfupU2R37wzZ/cY4GVSJKcaF5Qha3gnvkkRLQXa0EmqRFaQYEncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778388; c=relaxed/simple;
	bh=TfF9D+qVcE7KhaMOBidzdDMgqFFU7TjF55XdJnpwhf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdOjjZfu4hOP8m0wXVWxLgHDsIQZsApzIl7P4g1COGMGJh2IlR5c4atqRHh25I/ifiB7sv4xq76OgenJP1P8OImyQ/t7gjFioa6UoC6eXS1pgykz+zoElx74rEcwrq7BTUwMoOJ5ow7AmetRVRqHITSl6z9SkS8pC3lRb8QMZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxstRZ3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A78CC4CEF7;
	Wed,  7 Jan 2026 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767778387;
	bh=TfF9D+qVcE7KhaMOBidzdDMgqFFU7TjF55XdJnpwhf8=;
	h=From:To:Cc:Subject:Date:From;
	b=bxstRZ3Il9zbuuPo0RG4B3t8wRaJuvxfx7zTBsu65mtjykufDJkOt5WQ8CBclNpOs
	 F2tiQGKzIiV+E//pB6s3VN1zaZTJcYv5lDCFpdEZqXQpcIs9NNauJag3cNmFQ3ooJD
	 SPfAbuvp01uz6kkguS+su5gKY/P6+Fa/a3bt/WEDpDsNSTzxuTPzyxw58MBF6nCYtf
	 rtaLg2jn1LLVr1PwMY4/gJbTluRCJ+WG2iUn0Zo/O5jPNuwgFFbL0BE7bZlaEHSY+I
	 S/dUzNlLv56NI9vITzLPZ3SBG4rSOmepFrM6i6zZTW0wbneFh6uwnqa6XdboLOGHEQ
	 WtGFdHRK+F9OA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>
Cc: Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after bpf_prog_run
Date: Wed,  7 Jan 2026 10:32:55 +0100
Message-ID: <20260107093256.54616-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mahe reported issue with bpf_override_return helper not working when
executed from kprobe.multi bpf program on arm.

The problem is that on arm we use alternate storage for pt_regs object
that is passed to bpf_prog_run and if any register is changed (which
is the case of bpf_override_return) it's not propagated back to actual
pt_regs object.

Fixing this by introducing and calling ftrace_partial_regs_update function
to propagate the values of changed registers (ip and stack).

Fixes: b9b55c8912ce ("tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs")
Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v1 changes:
 - used ftrace_partial_regs_update with comments from Steven

 arch/arm64/include/asm/ftrace.h | 24 ++++++++++++++++++++++++
 include/linux/ftrace.h          |  3 +++
 kernel/trace/bpf_trace.c        |  1 +
 3 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1621c84f44b3..177c7bbf3b84 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -157,6 +157,30 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+/*
+ * ftrace_partial_regs_update - update the original ftrace_regs from regs
+ * @fregs: The ftrace_regs to update from @regs
+ * @regs: The partial regs from ftrace_partial_regs() that was updated
+ *
+ * Some architectures have the partial regs living in the ftrace_regs
+ * structure, whereas other architectures need to make a different copy
+ * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
+ * if the code using @regs updates a field (like the instruction pointer or
+ * stack pointer) it may need to propagate that change to the original @fregs
+ * it retrieved the partial @regs from. Use this function to guarantee that
+ * update happens.
+ */
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
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
index 770f0dc993cc..ae22559b4099 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -213,6 +213,9 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+static __always_inline void
+ftrace_partial_regs_update(struct ftrace_regs *fregs, struct pt_regs *regs) { }
+
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..3a17f79b20c2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2564,6 +2564,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
+	ftrace_partial_regs_update(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	rcu_read_unlock();
 
  out:
-- 
2.52.0


