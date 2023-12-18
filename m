Return-Path: <bpf+bounces-18181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD6D81700B
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 14:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDFB3B22D9D
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394B3D57D;
	Mon, 18 Dec 2023 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urBgMfpG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676A3D55B;
	Mon, 18 Dec 2023 13:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6EFC433C8;
	Mon, 18 Dec 2023 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702905110;
	bh=HAB8fcsYhkztOqkqxJN8HQ+Use/Y/czjonQXwZoidcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urBgMfpGrY+s01wqgzm2l/QZu9CJ/ZPp3rxkCXKTVFd52xXIG7+i62qvW14PT3XBP
	 lXEstftk0hjItrksB+PXkx9ba+4nDAnPSM7UwLo1Z5SAigtoDZHzAu5VNvzd+w8xcw
	 ikR7Kt3yJZw6rYBnM6W8Pz12Bi4dzXUoJhmBh8czKkDN40JBcq3gBg4uKsrEuQ1GPh
	 DYeIS14AGUoQL9j6H5yBiG6Aj5fJyhZXQwo5PauZBA3tHoO5FztHJWGdwGfB34Qjsc
	 r07GnAxtejzHAtnH8WwF1rAiKxPtvKU6SMmlm7Rn07psCDqr/ao6OeSIAzsms3XXfa
	 t8cnDEc4I+bKg==
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
Subject: [PATCH v5 01/34] tracing: Add a comment about ftrace_regs definition
Date: Mon, 18 Dec 2023 22:11:44 +0900
Message-Id: <170290510399.220107.17645951919819438730.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170290509018.220107.1347127510564358608.stgit@devnote2>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
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
---
 Changes in v3:
  - Add instruction pointer
 Changes in v2:
  - newly added.
---
 include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e8921871ef9a..8b48fc621ea0 100644
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


