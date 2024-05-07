Return-Path: <bpf+bounces-28838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7EC8BE53D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5BD1C219DE
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25415ECD8;
	Tue,  7 May 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHIuh0fA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1314EC64;
	Tue,  7 May 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090899; cv=none; b=f7C6g/roPQYbptY0+drRp4InkhRTv9/X7Dj9//6mE3S7MM5w8F+o6sISOmN0jXXUv8gV1e+PlpbVPQP2iADpzppoeRcesrsDYK0zD9TheiZ3aXNnTzzkSWG0cJ//fHR1hVn/85h+3zZnoZVKyNzBVRhX9iPkWCvHoUdbq98xssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090899; c=relaxed/simple;
	bh=fqD5QVAVsVbGxdWnTas/lt8WA9oyYAZWgwmYw1yMGyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d83bSv0HrVHP+BFB/7hYib8951ZrU9AyFjLOX36rFBwaUyosefuHoEMrnj3ejfb64G4mFwMfcIyvif7twmApskG+zQQeFaNLi/qgvtkHKBjs8VTfY2BUPveLXxo84I2g+wAPdMrjfsTkJH/PE0DvjB6mH0IiKf7582/CbivC5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHIuh0fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFEAC3277B;
	Tue,  7 May 2024 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715090898;
	bh=fqD5QVAVsVbGxdWnTas/lt8WA9oyYAZWgwmYw1yMGyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHIuh0fA0u4kVM7kLXd1j7MYcyEPT7VkY9jac9+7hgbk+b675SvcYCNW9xmwRqz/q
	 RAGFqOVwLhko1JFBt8m6S2EGYkk88f8h+3VDhpsK9V+kLQYrJo2XCfe6AmpFFzls7X
	 6sPJCL/3JTpR5xb9N/Ei3IadukfX5hhd7NnoxhfZipsue9xzSEeLTn/f2Kcq4B6R6f
	 Vy6TCMabMPt+X64SZsbQRFv2QY46xQ9YmXN4OYpk7rm1cyXJZowvJHt5nDUrEZwK3c
	 TMEc88Pxp/0gDVKV2/vAj6PUMQJp6oHaMtrzRJzRLY8Xaq7TlsC9lrhzvLLtpSvBrG
	 F24JZRQHY5DSw==
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
Subject: [PATCH v10 01/36] tracing: Add a comment about ftrace_regs definition
Date: Tue,  7 May 2024 23:08:12 +0900
Message-Id: <171509089214.162236.6201493898649663823.stgit@devnote2>
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

To clarify what will be expected on ftrace_regs, add a comment to the
architecture independent definition of the ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Changes in v8:
  - Update that the saved registers depends on the context.
 Changes in v3:
  - Add instruction pointer
 Changes in v2:
  - newly added.
---
 include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d14..b81f1afa82a1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -118,6 +118,32 @@ extern int ftrace_enabled;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
+/**
+ * ftrace_regs - ftrace partial/optimal register set
+ *
+ * ftrace_regs represents a group of registers which is used at the
+ * function entry and exit. There are three types of registers.
+ *
+ * - Registers for passing the parameters to callee, including the stack
+ *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
+ * - Registers for passing the return values to caller.
+ *   (e.g. rax and rdx on x86_64)
+ * - Registers for hooking the function call and return including the
+ *   frame pointer (the frame pointer is architecture/config dependent)
+ *   (e.g. rip, rbp and rsp for x86_64)
+ *
+ * Also, architecture dependent fields can be used for internal process.
+ * (e.g. orig_ax on x86_64)
+ *
+ * On the function entry, those registers will be restored except for
+ * the stack pointer, so that user can change the function parameters
+ * and instruction pointer (e.g. live patching.)
+ * On the function exit, only registers which is used for return values
+ * are restored.
+ *
+ * NOTE: user *must not* access regs directly, only do it via APIs, because
+ * the member can be changed according to the architecture.
+ */
 struct ftrace_regs {
 	struct pt_regs		regs;
 };


