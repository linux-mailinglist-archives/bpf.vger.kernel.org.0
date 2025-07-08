Return-Path: <bpf+bounces-62610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7083AFC055
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A34172F7A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB3B223DE7;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6tplq2U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA54214A94;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940050; cv=none; b=M3w0zf4PjfZnpSwZ036anxUMr/kFxs53TDhxrON56+tf5AxUE2U5PCfbmfaOgB/FSEqQlX39J4Vds/gYhj66hSs7nrBrXijvaEJivg1xxR7VVWezS8OrEYGr7Aww5LVzQY37tvmf3JGNeRIMjqCspeprdu3Oopy3Ss3GmVIVZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940050; c=relaxed/simple;
	bh=mI3D1M5ZCCJZqFgS/KQwGydDItxmqMt6XzVMmgcg8Qs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YifBzLWLljO5jvPAs5PpoAE0wQBoFnJFzUN8hCQTCgEUtz/ymIQcHGR+BY+0tNZ4+K0oD6szOBAN2BepCXS6bifMxe8GLHwnRA3lkWCLhzen2TpflOIBML/B0VYMM9VANnjZYd5OiyyE+ufGoV1A4oXeCBuZaUkF3XgGgb0xCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6tplq2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FA6C4CEF6;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940050;
	bh=mI3D1M5ZCCJZqFgS/KQwGydDItxmqMt6XzVMmgcg8Qs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=C6tplq2U5kkKv9ogIRuQJzouarUUYG3mTTwf6aCFKm/cSQdXLyx5ZjATHTubL9oBS
	 WB8woCLn5rdzKJwPOUZGxUwjbf5iZnI8jsw8imh3tsjN5bSty1MCCYWxNEHWWNOFYc
	 qBYbkvlPkxNr7LYHi/pHqTts7isQJu2x1tU9HKIFqPBeB8kwbdKru9pzempYQZqJQ/
	 l8OJndA8eeuWuNtrKTt/Uemck0sfz3y3W8b6orCJom8eThm/+klm/bOjMi/ABj0NBy
	 mrpl2CHteKet5/lSRVkAJdT777bsT26FCn7CI3lHvEZD6pQh01kUkj3f/cnA2wyV2L
	 ty8GKntwnsUOw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxda-00000000D5d-35OC;
	Mon, 07 Jul 2025 22:00:50 -0400
Message-ID: <20250708020050.582912128@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:00:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v13 04/11] perf: Simplify get_perf_callchain() user logic
References: <20250708020003.565862284@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
index 5982d18f169b..808c0d7a31fa 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -247,21 +247,19 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
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



