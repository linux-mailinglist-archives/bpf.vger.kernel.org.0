Return-Path: <bpf+bounces-33741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BF9257F2
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A092928C853
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896241428EA;
	Wed,  3 Jul 2024 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr8Q1sxN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957E49644;
	Wed,  3 Jul 2024 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001362; cv=none; b=Pw9tzlR+dIZVY2dCFnEz4r00IdGlru+bzbhF9OztjhlPO49XqXorOqtEmFP7S/ooWSBVJor6CqdScnvakEgthlP3DZF31jgQNEW0wxwLacU0oJ/UkAa0G7FhNTCXWE74V/lwr0BX0995+LnwClU/NGPI6H+M9EbTI7vuO0DX4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001362; c=relaxed/simple;
	bh=a7Acn7TQ4Iwo2VD7UsmloW71L1XLgtVJhdhvEmYlufU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US+E5j7yK94nmHc8Hu0CIK7/UAqE/a+LEjj/sCQxKAu/1s6XQUl5+1ZNxi3veKDU9knDQ9GPORZMab2tJlbtbQoRooXLjL7A3ISqEuK2Ibss/YpwPYdNfpYoquDddMSUHfU0pLTx/hZoFHqxbyx9Q0bQfC8+GfX+IMnlUiScBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr8Q1sxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1685DC32781;
	Wed,  3 Jul 2024 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720001361;
	bh=a7Acn7TQ4Iwo2VD7UsmloW71L1XLgtVJhdhvEmYlufU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jr8Q1sxNUJQR8z5Y1nzBCeW2miFbwXswRtm3UOJc3HHLKBLCUsFSgI5+EOEwxcUMx
	 DbKQvwlKC2sOQyxg7uU96OZHHAqLY1Bevv1V6/eZ19GbKtObj72i3w4oPJkjkNBR0k
	 NWlvE5cCQq1lYzioJQBz/gZh5+dUx1DEXugWdA/3vV9x0IHLS/4hPtDv/GKFc+GDr1
	 +ZLP2U99VgQTiz1Uoowdvm4SkWO7znkIaDOPrnElnZjwbYVzEle89xOVd0Ppgh63MS
	 Ivn0Nh+L1fHGqcz70Vu3Wc4zg3AWjelOIV0f8ERMH7CGP/JKg4ronMzNel1YB/O6gJ
	 IRlwRP5PVqVuA==
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
Subject: [PATCH v12 01/19] tracing: Add a comment about ftrace_regs definition
Date: Wed,  3 Jul 2024 19:09:15 +0900
Message-Id: <172000135567.63468.17510903929427881497.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172000134410.63468.13742222887213469474.stgit@devnote2>
References: <172000134410.63468.13742222887213469474.stgit@devnote2>
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
index 845c2ab0bc1c..3c8a19ea8f45 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -117,6 +117,32 @@ extern int ftrace_enabled;
 
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


