Return-Path: <bpf+bounces-32246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1390A1E8
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 03:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A6E1F21D52
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 01:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8015B98F;
	Mon, 17 Jun 2024 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsHUoEri"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E115B143;
	Mon, 17 Jun 2024 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588806; cv=none; b=NEZ44qZ5rWxJxUgxo6JAAHkPMjtPgARiOeTfs1TxoF0X+Kw0z2UfSYohP39xY7iETw5FLtu7LWsszLxMOpu2maOkKuPO6e0OyOmiBjiJ1EGIGUeGXKnjGZXBUnh2d8zQqjrUFrIoIU9KapMe/Ma5nEuiyOysjIMAI0PBLdmgBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588806; c=relaxed/simple;
	bh=a7Acn7TQ4Iwo2VD7UsmloW71L1XLgtVJhdhvEmYlufU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nj9HEwdCY3H+rxyegiYSmhu5fGBb0mTwaNU+SLURDzCZLmRLto475VTi6HcWH8NnKu6lxFNGr2d6ZcAqNqQOGJ+aFALYnIPtyNYV5H3GGddMraKde/UlfIGY09mg8ZURjHTifDY+FahUCvRzVaTjcnqM5PvB3LCIBXjtrCWdFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsHUoEri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6C9C2BBFC;
	Mon, 17 Jun 2024 01:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718588806;
	bh=a7Acn7TQ4Iwo2VD7UsmloW71L1XLgtVJhdhvEmYlufU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsHUoEriOORs5MyU3JbWHr45SjDb6AdlA5ZlGlHf0qZJLqpNkBDJzOA7ZIE/SKAqN
	 LvC7B3laNmTs10QoESD4ologfxr6+wdzRTmyH+89fRL85IW/4e+3HsuE6ks0gk/bNu
	 0jDoD78qq+1RrqcMDyBCc1yEL4cD5+Eo7rpc97i0Bfxtfpbtr15N6jrPPvFfwXWM2Q
	 GWzD7IQjHqhvY5m11viKuCMsZS8x+yKjqh7U0Gg4NqpZZqBcpJK2QijdAfeQNqZuTl
	 yaeBXDzCTvc8hUk+ZPoc5GWr/0pstarLk6O6e4V9+FXSfDNfwszwmGOWRQ5h2ZKfZv
	 Yn4Irjd9pe/AQ==
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
Subject: [PATCH v11 01/18] tracing: Add a comment about ftrace_regs definition
Date: Mon, 17 Jun 2024 10:46:40 +0900
Message-Id: <171858879989.288820.8579896574302291995.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171858878797.288820.237119113242007537.stgit@devnote2>
References: <171858878797.288820.237119113242007537.stgit@devnote2>
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


