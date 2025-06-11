Return-Path: <bpf+bounces-60285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50695AD480C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B456D7AC43E
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB211A3175;
	Wed, 11 Jun 2025 01:36:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49C8635E;
	Wed, 11 Jun 2025 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605783; cv=none; b=cQcvnAB7JylaquRfYe9J76NY9tZZKL9r0jsY0oREorsklifSkixLxr61yJStnuVtd/SowLthq/P9LMeG0sGuDsIo1ckn+VjBJdk9Comu6+ISgZ4dxXup1Zrxj6SMAXPh/KgFb5eLzfvnXg5pGhFyD1Mz3iS+qBJi1gVzoK74SrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605783; c=relaxed/simple;
	bh=mggx5smXanCvg7n8gnR/FploZ9NPITBU1NWvDKMpMos=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BTQbkvLO5hDF0DPZcQ15lUbJaLj557QYgBABy/gQ93lLwJThz8HTgv2g19Ua3DyaWCH1ilC/0lCiI6tfCmz9DCBPMJRIDmryR7NR6Cu/QBl4+MapvASehjZB6F3hO2H39bWDCFTgSTbhJkytymm5bOSVMZIOk5WQ7rnutr6QDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 47F6E1D764E;
	Wed, 11 Jun 2025 01:36:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 1B8CD2002A;
	Wed, 11 Jun 2025 01:36:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPAPL-00000000wNy-0p7N;
	Tue, 10 Jun 2025 21:37:39 -0400
Message-ID: <20250611013739.046415687@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 21:34:25 -0400
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
Subject: [PATCH v9 04/11] perf: Simplify get_perf_callchain() user logic
References: <20250611013421.040264741@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 1B8CD2002A
X-Stat-Signature: ybjdc1hmnqose9tanyfu1tspcqp5jcfe
X-Rspamd-Server: rspamout05
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/naCkqlUWovLkIOw4/rWiLyBf+E+e7c9g=
X-HE-Tag: 1749605767-444496
X-HE-Meta: U2FsdGVkX1/9bbzEmRZfW4b9WZwbqe6UQz65eeUDx736KqSy8Cv23q0y1Re8BliL1p38lLiiJOQ6jtOq8J5XY5odUk8cK6Hlncsxbm9GDLwRk2euVPToPA7wYp0bpJlmU3O4MIRd+kkA8cTJy9pKf9eKUD4IHU9K4JD2pK4IDmTYGZ01i33QVtC/X+M5S7R3yF0GQOVQ6UJ3Sg4qHmgLTECUq/bJafV/Lj46TUXkPnxzD43uityjSZt76AezfcTldfA/Go71MRDSwvFeYClJaz3Vbltlhh0HGbo0/5JR9baYr7duazpGg8abmt95LAFvgN6dCIdJaEtj+3m0aI/+MxuP/ZAeHAz5YZEZhRuf+iuzXtz486WlkM948/a5TTiYrmLC9jO1xRsRTHI3sN2+4+oS+m8EINIlelNCMqg6vV0=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
should never be NULL.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index cda145dc11bd..2798c0c9f782 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -247,21 +247,19 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (user) {
 		if (!user_mode(regs)) {
 			if (current->flags & PF_KTHREAD)
-				regs = NULL;
-			else
-				regs = task_pt_regs(current);
+				goto exit_put;
+			regs = task_pt_regs(current);
 		}
 
-		if (regs) {
-			if (add_mark)
-				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+		if (add_mark)
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			start_entry_idx = entry->nr;
-			perf_callchain_user(&ctx, regs);
-			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-		}
+		start_entry_idx = entry->nr;
+		perf_callchain_user(&ctx, regs);
+		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 	}
 
+exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.2



