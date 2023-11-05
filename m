Return-Path: <bpf+bounces-14245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649B7E1469
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC334B20E12
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8791427D;
	Sun,  5 Nov 2023 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DChrFFMp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F9F9DA;
	Sun,  5 Nov 2023 16:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF42EC433C8;
	Sun,  5 Nov 2023 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699200628;
	bh=owfDd6JTzvCM2mjVDdOSlbEmkdB46BrUrZqzXjclNlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DChrFFMpRcrcTwjoa7bf2Wg2cA2IsxnVTfMWzssOMgTHcLuK6LQFafhQxAF1oGC3x
	 rtCQ5U8qMxod4wcKgG4k5iQH2S2Xr0dV98/0HARMoKy6nSJCIJr6joQUN9Rt6jNiZx
	 /0IC6vqqt3CJITKu1ulmp1JhYorPV5a5sq3sotVxBBwUmq3gPmgoVh8pGzoW7mw0Ut
	 HbVWGEvrQ5A1NZbxX50j37FmJ7VacfCPPLZupCoKnU+RLTIvXNbAJjNiMHQhrrxfbK
	 7gY7o7pa+rcUSP0XUiMWxCmwDEnozQ4Zz81wKkPig6V+V1OOY6PYbXANoq6reaS92a
	 RTNrzqpAWJQaw==
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
Subject: [RFC PATCH 19/32] function_graph: Fix to check the return value of ftrace_pop_return_trace()
Date: Mon,  6 Nov 2023 01:10:22 +0900
Message-Id: <169920062203.482486.9590838723080321966.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
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

Fix to check the return value ('ret_stack') of ftrace_pop_return_trace()
instead of passed storage ('ret') because ret_stack becomes NULL in
error case.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 858fb73440ec..e51695441476 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -714,7 +714,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 
 	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 
-	if (unlikely(!ret)) {
+	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
 		/* Might as well panic. What else to do? */


