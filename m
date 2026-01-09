Return-Path: <bpf+bounces-78290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C96C6D08440
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 10:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B91B9302E16A
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E3735295B;
	Fri,  9 Jan 2026 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCBq9faD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402F332EB8;
	Fri,  9 Jan 2026 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951308; cv=none; b=SSnfxaiW/9tE39JyoMyZg1+sDFhZnvpcSfPGGIDNkb7ZFCLo1cD/JKIg5/4/KtT/1YZIbI+fzMxJDIBzZ79j9HpX+uBHV6rQQvqGTtTdKDuuX+p5BvHCnb6LeEfRIcrWY36byvQGkVXwwWwu6Q1Za5L1jEkJvtVgDlPHFYEE/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951308; c=relaxed/simple;
	bh=pPkYhOhuvx7Qqn/awx2pSNRq1M/gtoJcWz56iO/SzvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3+5kIxiVTm6+KD5xY1R8eJydWhAnOHS9I0yVclhg5082UGdTzvJk+XcFkJxMT52I8o47jiUAzbI+kNcPo40dKGzX4jg0p+XRapwUmGGOkyAOpwxbcPZplqhHqxEoN7IG88qYtdMJCZkIxBqmp+E8Ist5tE6jjUlN5adeqG7wHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCBq9faD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F4AC4CEF1;
	Fri,  9 Jan 2026 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767951307;
	bh=pPkYhOhuvx7Qqn/awx2pSNRq1M/gtoJcWz56iO/SzvY=;
	h=From:To:Cc:Subject:Date:From;
	b=DCBq9faDNPiKa+ckMvzFykF7/66rf1wwwECMIdXx5M48fvxUJULot7JPelGaj2FI/
	 snrf8X0KA67Ua1AuU/v2CAjYSv0Vuag/UJR3X9pB1rxb0af0EQ8HmyB5lDO0ihJH1X
	 qzXTG0jsmv1cP4AXrMmNHN6tmMWY5ZkApDNEaRAfOOK8tim6R5ooLvi6aYz03z0SSu
	 EGYI0RhsRIMT0W4Iz6MYhx6tBr/TkSjPixe0Zm2eExIsq9zt7z4WS6OSLXO5rTt9Jd
	 LT8tDThV6Dkv9MC0vW7hCimYJ2KIxzpSuomjB7HfpsaL6E9yMFPAKaKI5lMr0BGklJ
	 IKKxLOCO4CFVg==
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
Subject: [PATCHv2 bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after bpf_prog_run
Date: Fri,  9 Jan 2026 10:34:53 +0100
Message-ID: <20260109093454.389295-1-jolsa@kernel.org>
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

Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
- moved ftrace_partial_regs_update to generic code [Will]

 include/linux/ftrace_regs.h | 25 +++++++++++++++++++++++++
 kernel/trace/bpf_trace.c    |  1 +
 2 files changed, 26 insertions(+)

diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index 15627ceea9bc..f9a7c009cdae 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -33,6 +33,31 @@ struct ftrace_regs;
 #define ftrace_regs_get_frame_pointer(fregs) \
 	frame_pointer(&arch_ftrace_regs(fregs)->regs)
 
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs) { }
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
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
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


