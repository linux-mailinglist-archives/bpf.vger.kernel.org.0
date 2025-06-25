Return-Path: <bpf+bounces-61616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451CAE920D
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC098173CB4
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FBA2FA656;
	Wed, 25 Jun 2025 23:16:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067162F3C07;
	Wed, 25 Jun 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893365; cv=none; b=sI5HKXzGhjgl/Ua1sBeWks08Yuqmpj1cpNN3bE+1Bnz75TJBaWsbTAJnKBmiQ1pzeceBIYtuJLZowUkr/5N4sAWx1xg2HrmNATL9aOF4hYQOYs60GijYfU8rJva4HulzCV/q9sxlnn3Px0F13NVQbhsAo/e2WWLun4IE2ZiX6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893365; c=relaxed/simple;
	bh=c7XmsSRbXS+wdlNfX+ILlqyx+XTp7g6I18Re8KvRp3k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=I3BtrWx8ue1QqlNSbt0rmiZjefGm54kb2y41KHak1oNhIzzczPTQn1/3rMxMbg9VXr1ZAe5RKxXLRLgDZCyc7cvtNMm2kkoLWyMVrXYZzsrYgy7dW/4NGuisw9ISyhcS0Yvlqt++YQGB5TZU4VgC7ZqFiJWjVDILnv6NCR3bws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8653154F51;
	Wed, 25 Jun 2025 23:16:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 550D130;
	Wed, 25 Jun 2025 23:15:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZLq-000000044hk-2kfx;
	Wed, 25 Jun 2025 19:16:22 -0400
Message-ID: <20250625231622.509379386@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 19:15:46 -0400
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
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 05/11] perf: Skip user unwind if the task is a kernel thread
References: <20250625231541.584226205@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 3ds84qnymoopxajjbic9e76mxzqfbb4j
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 550D130
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xANTxVWHo7orD3GNRhF/thAcdperY2as=
X-HE-Tag: 1750893357-121383
X-HE-Meta: U2FsdGVkX1+ljfSTKiZ9A/3J61yduk6c+/qDmguQXo60UEZjY9V1claOk+AMbZF2O0x/5sP8cbPPBxfQKvAAGZtWP0ftCmItMdLWhp/dQuzMKWhZcPXRNmMSIDn6PyDVf+wJ/Qfz2ylWD2we1LNA2uy2LDLxMI5hlqbXoq15TwyJzZTuDm5kkw811z19AEByp7VVPHyiBMvX0yoFT8PT3wrcsLlMlRxw9qoLoxwivOXVmwj2RpYY6MV+agxdm/z4veWc5imJ6TgaTyzPLJMWwfuRbtBxWFWKDw3BacumMBMB4D+Bp81TW8VECgrucmF6tDDY/GJUfjYvcjj2ddPIyezbu9aU/g3c5EXI4zIsHAN9J3ZeADB6on2cfdzex3pNLU4HUHZXZg1NvznRl2i6hxlzjKG3Du0r5vTf5p9m6Ok=

From: Josh Poimboeuf <jpoimboe@kernel.org>

If the task is not a user thread, there's no user stack to unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ae371007a2a6..02ff31af3d8b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8166,7 +8166,8 @@ struct perf_callchain_entry *
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



