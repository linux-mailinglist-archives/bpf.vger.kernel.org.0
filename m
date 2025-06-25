Return-Path: <bpf+bounces-61614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6DAE9205
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE051C41BD3
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD422F94B3;
	Wed, 25 Jun 2025 23:16:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F126E6EB;
	Wed, 25 Jun 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893365; cv=none; b=SCcNNpkGM3SnSuZT83555V0wq3yZhqAl1Ll58ef/ZpxwvHabOjR7cgdp+IaIxrACjTGR0vTHHjyaXikt3vq/lJnXbZI1IhsfLx+gIEPIbn3E0RjBHSBIyDJDQcWnmza+M2QIiubKa1UadgiGFVhfvAYtcETlt6IJzdkBv+xmbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893365; c=relaxed/simple;
	bh=INPL5mykLyHh9BAddpKD33kEw5Zh1QT3Mw8WI6pEDxg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qjAfdRImFNaDTAE6vn4oufQ/KcdNkE2nBuSEhc65zjgTRwsFGdjHo0H0A3uOMftp63SQrbrrTzm4Q3WBNR8Dj8bM3LBNPhni8M6TEqPd63I8jsSjr8mZ4VlQQRuH/HB8SYtmlJsmrPuxNxk/FPnj11vDPrxSDG7GKTw/HgvE6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 358E91A07B5;
	Wed, 25 Jun 2025 23:16:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id EF9402F;
	Wed, 25 Jun 2025 23:15:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZLq-000000044gG-0dBi;
	Wed, 25 Jun 2025 19:16:22 -0400
Message-ID: <20250625231622.002316317@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 19:15:43 -0400
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
Subject: [PATCH v11 02/11] perf: Have get_perf_callchain() return NULL if crosstask and user are
 set
References: <20250625231541.584226205@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 1p8if5js4t5yq9bh6ff4fygzi1d9fce6
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EF9402F
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188kjvS+mWB42wzpmtmJv3x7MsKmJWWSlM=
X-HE-Tag: 1750893356-313938
X-HE-Meta: U2FsdGVkX1+XcjmPd0s26qAQpGmBVhaaTwi1VuxJiZDIA/sL7vqGO4HeuRzWIYiwKxChyEHXEtJb0RBXsL+aRbsqQmVOVfxEW55N+tyftmGu/yLgmET1TOiW6ggwQGrp2q1IrGUDKvmqAtlyHeqwskqedyo8bsk7opy/ncgWsfcqd6d1br3HPCJyhyF598UkTvZVVZMMRJIDOXDfcJkcwowBf8ggx9IToDBZYmAmzVBmYhcSkS6WlODjBiDHfrUaSvfqQVBEboP/uHN0OtjC4w5ELrqJGIP7w4iIck6S2JO6oerqFatL/fIMqy2mT+WkwIALsU20vZ6vKA1PZddDaIDZPyNen3aJkcj4K1B60knb+PXGyYTPXmwPH/CkeAZfypEwP3zDKpMOXOv2aUZuMxWXGO+jfWRPgZp8av7TlEU=

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_perf_callchain() doesn't support cross-task unwinding for user space
stacks, have it return NULL if both the crosstask and user arguments are
set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b0f5bd228cd8..cd0e3fc7ed05 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	struct perf_callchain_entry_ctx ctx;
 	int rctx, start_entry_idx;
 
+	/* crosstask is not supported for user stacks */
+	if (crosstask && user && !kernel)
+		return NULL;
+
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
 		return NULL;
@@ -240,7 +244,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		perf_callchain_kernel(&ctx, regs);
 	}
 
-	if (user) {
+	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if  (current->mm)
 				regs = task_pt_regs(current);
@@ -249,9 +253,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -261,7 +262,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.2



