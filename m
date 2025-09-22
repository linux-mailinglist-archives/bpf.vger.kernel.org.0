Return-Path: <bpf+bounces-69176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7606B8F297
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45AA7ABA35
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 06:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB482C375A;
	Mon, 22 Sep 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ckr6p2CK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CF1B7F4;
	Mon, 22 Sep 2025 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522928; cv=none; b=I71wm0g4LdD+8sjK8vchLyUk9Lqchl3XSR1BRItAi/1GOfdh5sWnNNqH3crD/1qPSOnYtVP5PUrzXXeExgOWXbheZ7akNYoGniO026A1YVWLVW3TnehuANKFQ2jqoTsaHwg3A/yNxF8wG9FWzCFOiACFi+TS2xYPGphkv1NzWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522928; c=relaxed/simple;
	bh=6iNnXUFgR3sl8zcQ199P5zaXXcqHUDAKhapPjOH5bEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQcei5q3q6mDMPO/8TRKYQr0v9Vw+W3dlld77B1/31uzVoieej05p9sdA3PTOu31zxYI6VJlb5n5TrflYChpwvxDr+6NIci6A/DtdERRkG7kIOVRTWsQPAgSEIfkxVgj2MJ6PrVCAv9kjyebjvrinL4oO+FEQrW5T3bzwYsyrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ckr6p2CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973B9C4CEF0;
	Mon, 22 Sep 2025 06:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758522928;
	bh=6iNnXUFgR3sl8zcQ199P5zaXXcqHUDAKhapPjOH5bEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ckr6p2CK4i+g3Du7UE5UC6Bp522DAcnqkAaA9tk/ISTq2p+4Bn+dFnEFfa5SAH3nH
	 91DpGhloqlU8OclozUyrkat7c7q7kVehZB5nG++U77a4esPNhGtLsZHvRE8iRh6mJ8
	 R1Whrmlbgk/3evSKJl16BQmFHcPMAiT3zvN62WCtQAn/WokHqIM1Tp1wf4HOwAuIf0
	 oeA7HTMEz9044EaNvVak4SqGEUPuq/o/qgLm6IrSiQKEPDpIUxQUGqk6wqJ6Tt9IQk
	 zvhrWM8QYvpMi7Gg1GQ5v5JYgJ9YwVTrcjevRnSgiLP1U+hBgqJnaaTSkj3dYzDL6G
	 Ufg5iUVnnBfdQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Cc: jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kees@kernel.org,
	samitolvanen@google.com,
	rppt@kernel.org,
	luto@kernel.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: fgraph: Protect return handler from recursion loop
Date: Mon, 22 Sep 2025 15:35:22 +0900
Message-ID: <175852292275.307379.9040117316112640553.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175852291163.307379.14414635977719513326.stgit@devnote2>
References: <175852291163.307379.14414635977719513326.stgit@devnote2>
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

function_graph_enter_regs() prevents itself from recursion by
ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
which is called at the exit, does not prevent such recursion.
Therefore, while it can prevent recursive calls from
fgraph_ops::entryfunc(), it is not able to prevent recursive calls
to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
This can lead an unexpected recursion bug reported by Menglong.

 is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
  -> kprobe_multi_link_exit_handler -> is_endbr.

To fix this issue, acquire ftrace_test_recursion_trylock() in the
__ftrace_return_to_handler() after unwind the shadow stack to mark
this section must prevent recursive call of fgraph inside user-defined
fgraph_ops::retfunc().

This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
fprobe on function-graph tracer"), because before that fgraph was
only used from the function graph tracer. Fprobe allowed user to run
any callbacks from fgraph after that commit.

Reported-by: Menglong Dong <menglong8.dong@gmail.com>
Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 Changes in v2:
  - Do not warn on failing ftrace_test_recursion_trylock() because it
    allows one-level nest.
---
 kernel/trace/fgraph.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 1e3b32b1e82c..484ad7a18463 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	unsigned long bitmap;
 	unsigned long ret;
 	int offset;
+	int bit;
 	int i;
 
 	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
@@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
+	bit = ftrace_test_recursion_trylock(trace.func, ret);
+	/*
+	 * This can fail because ftrace_test_recursion_trylock() allows one nest
+	 * call. If we are already in a nested call, then we don't probe this and
+	 * just return the original return address.
+	 */
+	if (unlikely(bit < 0))
+		goto out;
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
@@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		}
 	}
 
+	ftrace_test_recursion_unlock(bit);
+out:
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of


