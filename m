Return-Path: <bpf+bounces-60648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E07AD99C3
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 04:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D298C4A0536
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 02:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66818C02E;
	Sat, 14 Jun 2025 02:46:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171D15746F;
	Sat, 14 Jun 2025 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749869180; cv=none; b=arsWsu1cSAPFd0vtccLNCtZNRo0FilCxIPVYhq1HF1OPQrW+ae1FgnmfuTSuc0iNeaHKnNeoiSLPvS23ZqdGVupQ8d35SCy+7fW7Qv3aMbWtSvwPDZV8NHWwLMAwatsbSElpLoZAV0NNA2wvEut1PjwSoHCXPS+9srsulgyVcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749869180; c=relaxed/simple;
	bh=YSYs+sDx3g+kTQq1PzAjoKygSIU4zjvdJ8dLKOQE1cU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=erj5KxcqF9kuEFpjju6if/AL9LlV8uncVJteXNCwW4m0vdGypdpmjk1bPZcc79gHDvicDfTpPp8M/UfOpJGXegdtGHpAGQ6zsOEY2dGGC0YrJX4GaQvDQARmvCwCjbFzRuHPhuU6CnZ5L1SFQSpxXCB+sEer5fkbyAJJYZlZRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 81B5F1A1B9B;
	Sat, 14 Jun 2025 02:45:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 654EE60011;
	Sat, 14 Jun 2025 02:45:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uQGvM-00000002SoQ-2WSo;
	Fri, 13 Jun 2025 22:47:16 -0400
Message-ID: <20250614024716.450609897@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Jun 2025 22:46:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 05/11] perf: Skip user unwind if the task is a kernel thread
References: <20250614024605.597728558@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 654EE60011
X-Stat-Signature: ymshrhe4p451jtxna5jhw8pgussssgoz
X-Rspamd-Server: rspamout07
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1967b6nyc8/EOFw7hQgGJZVARwzCsgK7LM=
X-HE-Tag: 1749869137-688853
X-HE-Meta: U2FsdGVkX19fz9QUkDzMZOy0Bu2GIX9DdjtB4jGskhgYGaSoVJsS+GrcdFeYkbljg8o2PwJoxjm6/K7r/bcZdn9i22emJycUbdAbPJ5tmmHfFUQgEPNTu8awP4Y9W1ufaYrS2Aftru6Df8oRLZN/B7HTmfOQd+9UqRH01yML7t/dxg1w9J0WOL7Yt030AoRTQrMzx4AFLyKbJoaPouAkE7FDlULjLi7CgyfAeS4UI1H3BK+XD/+Wm2K8hIFFzNR4gqTqEkhkUr5NIFS2QkarxYa4tgEHNy1zGwEtxjQpLaUAVmhdm87wJfDUPRcfoctmL1Nd/enfQjnn4lfnymdR/hUpDIbgL1QzbAlohW5Pv9gAf8fxxXIOOkSmq4vK/m1lx/y7i3BcMNX501PdCDWc3hMMyGmANjBxwJgClg0gCdI=

From: Josh Poimboeuf <jpoimboe@kernel.org>

If the task is not a user thread, there's no user stack to unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 375115492c02..55d5d4ded7ab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8144,7 +8144,8 @@ struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
-	bool user   = !event->attr.exclude_callchain_user;
+	bool user   = !event->attr.exclude_callchain_user &&
+		!(current->flags & PF_KTHREAD);
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
-- 
2.47.2



