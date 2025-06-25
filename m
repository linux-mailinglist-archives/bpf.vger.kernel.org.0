Return-Path: <bpf+bounces-61621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B7AE9212
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BBF1895124
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF932FCE3F;
	Wed, 25 Jun 2025 23:16:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F62F5487;
	Wed, 25 Jun 2025 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893366; cv=none; b=TofZJ2RQfXuwKx5YbfBs9CvwmWUFalvBpmzqiJV6Xsv1Iy4hIl1FKqHVY3R82hkt8rdYGMrK0psXqJiLLhf9vXAawzN8UBP+Va6cbfNIKscPKuUkE4sWqP6txLGPTaManygBE6doNcdYY1zExVNmMiD0pxisxincgWYKo6tVRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893366; c=relaxed/simple;
	bh=drCltSOBO4qBH4U6qNMyzlad2FUcdSN/k1Ro7pr12Kk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gTmgmHo8vy5xoCA/E9n9SwaswupXzWbSDLH0xoJDF8NMebv1ADCyDPII1xc53ch800SVsLT7Jo1oCPA3hv+wZOooSa21XvyYzBAVdIK1Ody95Riz8Dn++wt27nFxdUuahaXgUG8WhnyTUvI2s5bcO5XxJ3jr77YoTYDDAixCQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B329C104633;
	Wed, 25 Jun 2025 23:16:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 3B94420027;
	Wed, 25 Jun 2025 23:15:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZLq-000000044hG-238r;
	Wed, 25 Jun 2025 19:16:22 -0400
Message-ID: <20250625231622.343362222@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 19:15:45 -0400
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
Subject: [PATCH v11 04/11] perf: Simplify get_perf_callchain() user logic
References: <20250625231541.584226205@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: ioxfkgkp4u84fkdqoq9aoibaoc1yxohx
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3B94420027
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+v6bVNBV1nT+MLEwJsv+erXAHuk0xxCWQ=
X-HE-Tag: 1750893357-52064
X-HE-Meta: U2FsdGVkX186/+oEjQVcyu3zxfgne3HlGeoaQPIRxXQM3YDaIHbhKHMas4dh6qbGQxxZRDJA+AEokzov/LeSc3vGKVFyZiNb97Q7YdNHABVOsfPqejDLaYojWEKHKH7jIcEnvWdhjO0Tz4oxkxS7Y0gcvLwzG+W+6hWjhK+XE+lz9lAaYg+Ne2eFqR4VUzrUYbNz0t0/MT/lhOk+bMTV6RHdtrogfePOIerem5LEszbxKfFChmGqebSqjtmJTlezT2G/MxfA3QYiAIKKtjIoHBByRfqpcG6GB4PuEVZYQwlfnw1Bqm3PblAvnf3pzrG3WMWR8G5ufQ89vOlseLdqulHXjK3Rx/a5p8dil4SZwcWYKDpLyHp/0ZBH5h76d3AYEaS9G0Kk1bSzk9zPZBv7TkaabT5y9dB5MOwF/I63xDQ=

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



