Return-Path: <bpf+bounces-60647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD6AD99C0
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 04:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EA84A04EA
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 02:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E11714C6;
	Sat, 14 Jun 2025 02:46:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196915383A;
	Sat, 14 Jun 2025 02:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749869174; cv=none; b=RCdU/b41C5/RGOms12i8HtxfyHboX86zA+DqlR7uLYdauxJBhQCBv5PHpTcXqWXX4KRMUwTo970p7kaRmPxhqPjVEhjPqDN7geGNAgw8mh5upijm9jv1TjRj3PoFCz2pxm7OIJ2ibhgvaEQL0GGhgSZi1TcfY0EyTRzi3aPc+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749869174; c=relaxed/simple;
	bh=P431Xsnqui3cxWjbZJTxi5mE9YPKPRSkaYRnObmYMjc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GEWM2orh+k0QBwGk6SWsWgb8K3aJsP7K1LOAPf8ul/Sq4+B7xoWeXiQVCkZb+piu4tPiyKWw9/JDhFggEfef3HnMCRLm0exX8QHhrEhiLINKfCh/eBu5k5cShGGO+rn1eyNL71+6Iz0ORWY9163MV1fNNKNesrJo9CWUDv0gmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 54709C1B24;
	Sat, 14 Jun 2025 02:45:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 41E4D60009;
	Sat, 14 Jun 2025 02:45:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uQGvM-00000002SnR-14KT;
	Fri, 13 Jun 2025 22:47:16 -0400
Message-ID: <20250614024716.103249316@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Jun 2025 22:46:08 -0400
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
Subject: [PATCH v10 03/11] perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL
References: <20250614024605.597728558@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: gh9us45h4e8psc1qttkwxihrnuzj1mpc
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 41E4D60009
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+D2cbZAeherMC4l1RmnvmKaS9U/cP+v2c=
X-HE-Tag: 1749869137-398534
X-HE-Meta: U2FsdGVkX19NR++Z9YvGmoBnfjuP/vP1QemDs+0hRMqCwe9D7IHDkS7uQu8ouLklv69enG7UECykxwrC427JmHa8RXuMZIMVqQY+8bRV55cSxzSfVS4hNQafqyEucQfYvm+Hj/U5fU11guwl+S1K40wMrPIgSptasqOq6HxjZiw/XPnUJ1z8s8IIOhWqO8dSVMs9RCQMTvDl7K74gAVbNz5Qk+Ao7stAR5UbQcCD/NtL+kMmU5WcPv9kaILDfl6O7kl6qbYBu2DeHS/U193/KPeQn6c6q6wodUHFrw6ObPc1iiXAnqqVkqn/BRbA8fDkpFnBOhYIG6adIRUvx7ncLdGXIyDDHxRobo1C2i56FiIJgA0bkPIG9t8ncALqEJMHWb6yDHiYZmDcRir3YBDUqnsgKxgsVKfa/Tf9kM+Qli5NkWzZ5OhTl3kgYVZCAENYGmJ4QB7GwpBtzIjFDhqjrpE4LaMdugpymA6xdRvKPqc=

From: Steven Rostedt <rostedt@goodmis.org>

To determine if a task is a kernel thread or not, it is more reliable to
use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
That is because some kernel tasks (io_uring helpers) may have a mm field.

Link: https://lore.kernel.org/linux-trace-kernel/20250424163607.GE18306@noisy.programming.kicks-ass.net/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 6 +++---
 kernel/events/core.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index cd0e3fc7ed05..42d21761cb4d 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
+			if (current->flags & PF_KTHREAD)
 				regs = NULL;
+			else
+				regs = task_pt_regs(current);
 		}
 
 		if (regs) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d8688668d21a..375115492c02 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8032,7 +8032,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm != NULL) {
+		if (!(current->flags & PF_KTHREAD)) {
 			struct page *p;
 
 			pagefault_disable();
-- 
2.47.2



