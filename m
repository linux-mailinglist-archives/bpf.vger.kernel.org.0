Return-Path: <bpf+bounces-78549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27349D127B7
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 13:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71DE930A50CA
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333433E34C;
	Mon, 12 Jan 2026 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCoYWzDb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324ED15665C;
	Mon, 12 Jan 2026 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219931; cv=none; b=cSB9JekCXk7IUxAW0HAAzII1uIwgXG5FNYtpbvMlVucTOHexcGgs/LKyqZHqCFf2OdjdEUn2cG9iT4B73QFjeyKbMg6KcPqHqRbuOIcdcDcHZATvpBYRjd9iOzq6V8z0nI5fwRBmGpTnccSmpzRv/oKt+7M0MaK+h0o+OQKdggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219931; c=relaxed/simple;
	bh=n+svx5fkeE5YImMc49W7xxRF+Ubqh9i7V5UVorUcq94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXht9Kc88hWcuplik5UyEpt5aD4F/5/IhaDMRBeWw5f1pUvcNvuLMn9u8fEggtM7U1wHlsnquZjmQtvCCkp3w1vQ0pp2W7+eo1jkSKp5lZDLJUQ3qiafsR7JBQOpBcZuNTFdH46ovL61fVgmJVe4mThKwcEjL0L9gSG9o4mOcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCoYWzDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B428C16AAE;
	Mon, 12 Jan 2026 12:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768219930;
	bh=n+svx5fkeE5YImMc49W7xxRF+Ubqh9i7V5UVorUcq94=;
	h=From:To:Cc:Subject:Date:From;
	b=DCoYWzDbQQzHfOsVALDJjNFMowUJNh7cvrpEsY0T9IpSPIfHsFho8xvAiLZ9uRiT/
	 UJlAvjbepq7i4omK1vVk5jfn2m52M3fi0MgOY+7ViRz3edRwnX+sta1ja5/Z/PYSv4
	 PqfXZhDz5unC5AyZCGlZfQopW/qcG6wMhQ7LQC0Sq4wgzljF37WtjxIJpktRIRKK3h
	 o5ChMZGCdQPqK7S6RBYkx2SJogqNJcPNFf0+ji0BQehLIuxHjoEOBRxn1m0m3+n+sN
	 fto4I1Q1xJDehojU8Jo6r3LbJgEYnmuCD8rVtv14TdlaJoBm1kEawKulzTuPvQ3Mcz
	 DYz1jXU9w0ehg==
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
Subject: [PATCHv3 bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after bpf_prog_run
Date: Mon, 12 Jan 2026 13:11:56 +0100
Message-ID: <20260112121157.854473-1-jolsa@kernel.org>
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Will Deacon <will@kernel.org>
Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v3 changes:
- drop const from fregs argument [ci]
- added acks

 include/linux/ftrace_regs.h | 25 +++++++++++++++++++++++++
 kernel/trace/bpf_trace.c    |  1 +
 2 files changed, 26 insertions(+)

diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index 15627ceea9bc..386fa48c4a95 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -33,6 +33,31 @@ struct ftrace_regs;
 #define ftrace_regs_get_frame_pointer(fregs) \
 	frame_pointer(&arch_ftrace_regs(fregs)->regs)
 
+static __always_inline void
+ftrace_partial_regs_update(struct ftrace_regs *fregs, struct pt_regs *regs) { }
+
+#else
+
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
+ftrace_partial_regs_update(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
+	ftrace_regs_set_return_value(fregs, regs_return_value(regs));
+}
+
 #endif /* HAVE_ARCH_FTRACE_REGS */
 
 /* This can be overridden by the architectures */
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


