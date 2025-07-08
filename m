Return-Path: <bpf+bounces-62606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256AEAFC04D
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C836425D54
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0999621A95D;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovrY99xf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E651B4236;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940050; cv=none; b=jqwnugx9+FntTiKcOsP8uWxLEaMuL9lbYntgQrvKTLhnAszBIvRmVjHvuzvIlIA6mwNcLtjVD5AmABeICkxYhUfgzz+6YS53CQvTmyWWun0FpIoCXMQQ7jjI8BbJAnRw9kFvhTtKcBC2DpSXrdAgJDbxpaklXMq1MLFcFtiEcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940050; c=relaxed/simple;
	bh=INPL5mykLyHh9BAddpKD33kEw5Zh1QT3Mw8WI6pEDxg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FlKt0t2M1e5JiZb2uIpjZRjF5sNp+mbGHuQmywtAu3zoUfoR4TdtSrH2zAuDNpCIpYv7Q5DY8niBUl7z0eq0Y0DpWLEIONrTPjB6DSRcZTrEC6ZCkwIwGt4mg/qWJBl41Am0KuDv1rmhuYaFtMhrFGoSZvJlc86NtNgJfWuHDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovrY99xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A19C4CEF9;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940050;
	bh=INPL5mykLyHh9BAddpKD33kEw5Zh1QT3Mw8WI6pEDxg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ovrY99xf5+Rsg5hBjuGcwEIV/8oDBHoP3w1dzN2UbMYZ9FINtDDfuuCH5cLc/RVA9
	 JjadMSbV8AMwflyzeALiiayXUwIwCN4lfQ6LUfJ55IjPmow9oSOvyhSNHSKNYr2C7N
	 Zu3Xhw5hvJ6j9lKJ/e6Yizu3YmB2JNApUZ1M7kgZgzI+BLvtyI+IFt1jLJ/c16yTCE
	 wgqS/uEhyGlWVmJKHBWKRIa6cm3Hl8Vtn0SZ0leavt+4k2qOrBTeJzL/jCSqdcH57n
	 l4fpcElLPDIbuPp6wvl+MOzzS7sQFQ67tOp/TlTcK3JY+XlDaGlrnwlhWXhrp0oH7E
	 V2S4fLfpmRkWQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxda-00000000D4f-1dTx;
	Mon, 07 Jul 2025 22:00:50 -0400
Message-ID: <20250708020050.244992222@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:00:05 -0400
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
Subject: [PATCH v13 02/11] perf: Have get_perf_callchain() return NULL if crosstask and user are
 set
References: <20250708020003.565862284@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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



