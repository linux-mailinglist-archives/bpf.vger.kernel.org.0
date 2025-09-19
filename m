Return-Path: <bpf+bounces-68928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB716B8954F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F281C278E0
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3E30DEA3;
	Fri, 19 Sep 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzlEMCBM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0030CB48;
	Fri, 19 Sep 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283062; cv=none; b=Ugm6QqxEDBrABCS2UlDvk9YpvdbeBapXWuHafmyvfFbK/K+75IsurtnDphUtcbqfZuu4pJ6puwu+416ZAl0cgd9fSxcoQY1N4V54WZv6XZTBRMOKX7OzAnti+g1IvdOteeb9JKYIoQ8Dgcy5WqyvWa610sj2dNRrTJ+hRWxotAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283062; c=relaxed/simple;
	bh=Lcy/LWJQGp1/4CfwoBEK/ZhTJbVy7tMzyjNO9hVTaMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kz5E4C0Tgbc97XCD72RfNDhizpGTYwlYqqLj6OB/lDPSs15QC/z72Aqy1GCmAlOrmOEEW82lCX966m73T7ftNG1L6JUwZm6rBq+XAZUuGW2gBAQ69aRd9N4uqH63YsQ32VAv+gGMHP67uLrwJGb+dFe8vFf7TMf7SioSP3+jvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzlEMCBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B10BC4CEF0;
	Fri, 19 Sep 2025 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283062;
	bh=Lcy/LWJQGp1/4CfwoBEK/ZhTJbVy7tMzyjNO9hVTaMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzlEMCBMTdGBAMyDFjAFalB2ZZnO8+6CUxsS5eJYbk7dUBh96KvFwC7fbALMHqdfE
	 erRyehOSNupMvxnpg2zQglmHtRZ29+VerLJQl7RsKLS9XvafqULUPB8vqeFdhytodS
	 PLWwd77MHueYpfG1AC3PbfRy/hC9Pgw6jJ9rVgI1FZKeptKgaeOF82Cm1ybMxhYCEI
	 GXYm3e7st+lVz/3miMX6Zco386UoSRYuL98drNowG34PXORFLF5Zd/oAxqrokYsJiH
	 YdMj4Gu11Ryff8yvgrHhdifJP1i6FuR9mHaMnRiijDhF7Z2Ec6bbO8WfPrCLqQF81T
	 2QlhRhlWazKZA==
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
Subject: [PATCH] tracing: fgraph: Protect return handler from recursion loop
Date: Fri, 19 Sep 2025 20:57:36 +0900
Message-ID: <175828305637.117978.4183947592750468265.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
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
---
 kernel/trace/fgraph.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 1e3b32b1e82c..08dde420635b 100644
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
+	 * This must be succeeded because the entry handler returns before
+	 * modifying the return address if it is nested. Anyway, we need to
+	 * avoid calling user callbacks if it is nested.
+	 */
+	if (WARN_ON_ONCE(bit < 0))
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


