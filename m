Return-Path: <bpf+bounces-26777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B838A4FE4
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 14:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3902839AB
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EB585939;
	Mon, 15 Apr 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSS8f0tm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBB85299;
	Mon, 15 Apr 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185402; cv=none; b=rX95gj9BJfdMhIXRU5/wognf5OhuRCxVkbpOnKPNWx7+1V+nEvL5NSq/cbEASjNmifSBSelG1TlLqEBLCfPs3E8glCJbAw1DIm3rbMLIUrmJewBoOqDQCadDWus5lBb2nbs0BjbdjFYPv9IwMRLLvMtgiim8cL+dDqgtHphVIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185402; c=relaxed/simple;
	bh=v6a8A4n/NQNVvl6IUBlyb4ncY6wKsPnocwxI4QmL7G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTDZQvubJ6O3igXywurnt12LZiqgqOtiIANsM1z0o+mX/4GDPNmh5EINspQvHLwZreYKp0lxU7DO92qsHPB41OgHf51O73XdC8Xf05z6eo+XqfZoViWosJxE0DQLiVS6IXc5gUIo5O//eZuDhMWEFQWpC64qc+I9Wyi4CfB4fJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSS8f0tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7837C113CC;
	Mon, 15 Apr 2024 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185402;
	bh=v6a8A4n/NQNVvl6IUBlyb4ncY6wKsPnocwxI4QmL7G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSS8f0tmbEjB0HOjLht2e8wfg1cZRfKaMcSV9fYdVyQ+xIzbz0p454mUqlXhC4o8h
	 bByVOLS+5HhVbnVNHIS5z5QClB05E7YXYmC6sia/AmRpCXpovgmWUZZb/PToWVdPS+
	 QC4ssQXovpmYjEGFT4AisJWZPpPE2QVVH5k4jYN8MUtsmm4NG3ZMs7z6DzZ4Ve8Y9b
	 o+FYUI5hlZeAGIjL8uR6AR5TZQRAJZUU42Sl9k+Mj0jatq3Gdy9d059nQzysRGR0ij
	 A74jXL3wU5OPidiEqn2TjYWeCOwGV04GM1bcfHK7ofAhBl2Le23TYGcU8Manj1Szyt
	 m9rc0VCZavMMw==
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
Subject: [PATCH v9 05/36] fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
Date: Mon, 15 Apr 2024 21:49:55 +0900
Message-Id: <171318539550.254850.4289354595322910591.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Instead of using "ALIGN()", use BUILD_BUG_ON() as the structures should
always be divisible by sizeof(long).

Link: http://lkml.kernel.org/r/20190524111144.GI2589@hirez.programming.kicks-ass.net

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Use DIV_ROUND_UP() to calculate FGRAPH_RET_INDEX
---
 kernel/trace/fgraph.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 30edeb6d4aa9..6f8d36370994 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -26,10 +26,9 @@
 #endif
 
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
-#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
+#define FGRAPH_RET_INDEX DIV_ROUND_UP(FGRAPH_RET_SIZE, sizeof(long))
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
-#define SHADOW_STACK_INDEX			\
-	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
+#define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
 #define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
 
@@ -91,6 +90,8 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
+	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
+
 	/*
 	 * We must make sure the ret_stack is tested before we read
 	 * anything else.
@@ -325,6 +326,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
 	int index = task->curr_ret_stack;
 
+	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
+
 	index -= FGRAPH_RET_INDEX * (idx + 1);
 	if (index < 0)
 		return NULL;


