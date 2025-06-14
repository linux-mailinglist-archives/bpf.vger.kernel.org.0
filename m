Return-Path: <bpf+bounces-60650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987E7AD99C6
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 04:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751934A18BB
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 02:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAA19CC27;
	Sat, 14 Jun 2025 02:46:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7361B19CC37;
	Sat, 14 Jun 2025 02:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749869187; cv=none; b=RAjOIFQ+hxDoSu+jvqPPTAa/x5jsdVp2Kz2XfoXT9GSlAQgkxVGWf61qoKIcZXtMtoeaL9iqb4C7bxOybjN0lgGQjewOghny/vQ6Eatltw9WkVZb2NBe5+0gmXhIQ1cXBCbl5BqaSya0jIlDlFBKpPJCquNNkvkahp3keZpHDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749869187; c=relaxed/simple;
	bh=drCltSOBO4qBH4U6qNMyzlad2FUcdSN/k1Ro7pr12Kk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FPvjbBpSNT9PcO0LIDIdSsEs2Bb905BQIRMyrdaxDw1Nfe9cqeq7K1CjGizgoyahhLsZ42oEMx01lt+k3uaZLknnvDKSSmTQiJ4gwAWALWMKGTm49cXKZpYrK1+CT1Oqmhd+LOkOpQ8WmRjstJUz2574h99KeAzib1zAoI6RgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 5C93981AF6;
	Sat, 14 Jun 2025 02:45:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 504401A;
	Sat, 14 Jun 2025 02:45:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uQGvM-00000002Snv-1nhI;
	Fri, 13 Jun 2025 22:47:16 -0400
Message-ID: <20250614024716.276531218@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Jun 2025 22:46:09 -0400
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
Subject: [PATCH v10 04/11] perf: Simplify get_perf_callchain() user logic
References: <20250614024605.597728558@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 504401A
X-Stat-Signature: bd9rq7gdccu5mpxo8cztwunacwmkjzsc
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+1VLZiuymOkoCxFkPRvKezoXm2tsMEHWk=
X-HE-Tag: 1749869137-35291
X-HE-Meta: U2FsdGVkX1/BldJ2gYVmlAYikMMZk6ca3adsVzzg66LYuuddbsfSDMA2Pi3Dy5V81nmiObqEvtZmWfjF1NyguNL2JJmD8Hw0wqlVl2ojrNN3bWTPgzmTDsQgXOv4dWxUUPKMTtFI3DBS9exhl1uPtHC68vvQzvbRyDwQJG6WZGkbyBTN63ELG3vm3Ie9MFxPjH0fVRit4RSbyAFs0Tjm+bkanHeY68eapd9xgtcdPJFA/Y2VHQBBtdEwlHluGTUR8yW6GaN+7uPabD4ktQ8T40oVjZ5QDA9VCi1IKTeRmUob8xy4IjW4rMMDxiCloe2oIJupzFb3758IHzZhQ8keAIYouhffIlp6UKvZUInAzfCYTX4ZqkDjR/ugLVQUgS9nYD2+py5W7lsxKBqt4JU/nBx9fxOdol2viGGLha54es4=

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
index 42d21761cb4d..16eb68f31810 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -247,21 +247,19 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (user && !crosstask) {
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



