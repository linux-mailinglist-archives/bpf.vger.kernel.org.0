Return-Path: <bpf+bounces-60280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19793AD47F8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF387AC938
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5B14B965;
	Wed, 11 Jun 2025 01:36:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03464437A;
	Wed, 11 Jun 2025 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605774; cv=none; b=ezghl+iF/CogfuiX8jMFbHw/8CzvK7+PK1WSo2q+AWNw++Pu3TrWxkIBtCRwTQs0QGZfAKSGeBrVvujk993B3ZitOxAQvUgzHZOOOo7XLF9/oLQD384FMrJXP94S22eNZea0ecm8/etsU8MHP+NE3beh2RZyP7Gd5dRH9O/wNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605774; c=relaxed/simple;
	bh=lt7DBzVZ0SoABgMFm7JNxTEnMkJMIrhCu2w6wwf7hLI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aR6Ig/OTcV8OEfL6CkLLilewra0lxK96x7Q/xLY/bwOiw/wKgxSe2mDH2HQFFkgzJ5XyHnO8eJCfF9i7BksxzUiczbABX0hjfWSZzZqVzE87XlHfVpGI666UJoPNbqBDu6K/G+7ua6lHnsgIlEzr0lCZmrTOS/Jfp+G3RqYTQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 53DBA14154E;
	Wed, 11 Jun 2025 01:36:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id CF9FF20023;
	Wed, 11 Jun 2025 01:36:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPAPK-00000000wMU-2rFw;
	Tue, 10 Jun 2025 21:37:38 -0400
Message-ID: <20250611013738.528515419@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 21:34:22 -0400
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
 Namhyung Kim <Namhyung@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v9 01/11] perf: Remove get_perf_callchain() init_nr argument
References: <20250611013421.040264741@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: CF9FF20023
X-Stat-Signature: 3irfqbs471cmk38s3cmxy36tnf9s6u1q
X-Rspamd-Server: rspamout05
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18b1ZVa4ljVbr39AuwAsl+jaT9u9n23f8g=
X-HE-Tag: 1749605766-280773
X-HE-Meta: U2FsdGVkX19eJOu7kj03TjxozZ70AEvlbOoXBnu8byvNEk6UUuSbwHGMhj1loUZEzxtojYaSN/10qw2shG8pvTOXa/ZqROvSj96+5A92Duxk3M5wL3jiJ165FwphkdLKSSk7MM85D5b+jyLbjwMas3eS3RG/H7OpsKqh/1+qGb3g3+2XW73stj149nYHnyqiXVtHLdsJ5Impo0nacrxQSxKy3m1QwO+FiT+T8MqDYdC7l2ZXdiJmdVjPFdXTIJEfbrjCkdnOp399yxksn5Z2CFsYsfxAQFp6+yzmpYxRZhPVRSiZ8XegIAG64XSX3dRDUEebkqHQZuP40nYhMrSYSq5OnDV5G/jv3iZAQ0sGNBY2455AnSVnIXadcUxznBtxY+enO94piqkMjX7b4kysSYKdSgYqPeLStyhVcz1HMi4=

From: Josh Poimboeuf <jpoimboe@kernel.org>

The 'init_nr' argument has double duty: it's used to initialize both the
number of contexts and the number of stack entries.  That's confusing
and the callers always pass zero anyway.  Hard code the zero.

Acked-by: Namhyung Kim <Namhyung@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/perf_event.h |  2 +-
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 12 ++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 52dc7cfab0e0..75a0413172b1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1681,7 +1681,7 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..ec3a57a5fba1 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,7 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+	trace = get_perf_callchain(regs, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
@@ -451,7 +451,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
 					   crosstask, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 6c83ad674d01..b0f5bd228cd8 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,7 +217,7 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
@@ -228,11 +228,11 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	if (!entry)
 		return NULL;
 
-	ctx.entry     = entry;
-	ctx.max_stack = max_stack;
-	ctx.nr	      = entry->nr = init_nr;
-	ctx.contexts       = 0;
-	ctx.contexts_maxed = false;
+	ctx.entry		= entry;
+	ctx.max_stack		= max_stack;
+	ctx.nr			= entry->nr = 0;
+	ctx.contexts		= 0;
+	ctx.contexts_maxed	= false;
 
 	if (kernel && !user_mode(regs)) {
 		if (add_mark)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f8ce8f..d8688668d21a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8153,7 +8153,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
+	callchain = get_perf_callchain(regs, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
-- 
2.47.2



