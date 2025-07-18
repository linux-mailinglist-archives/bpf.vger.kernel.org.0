Return-Path: <bpf+bounces-63745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180CB0A8AF
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 18:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4425A76CC
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F82E7181;
	Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4mQoCg5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAF2E6124;
	Fri, 18 Jul 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856980; cv=none; b=AUr5vvjDoFzCSb6vvhYbxtDUn19maPQi+ktJe3HFRe0saBHq1AWWqWnBF8Vp74S3rY6vXnojkYWC6dyAR87zPeyfYb1uQLm+UtUtjfk8xZ7Ak0YpMbaaXsn+5msJrgD08L3qOosTpbq3rQvw3cLPHxolxd3YDoCdg2C4+M2F+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856980; c=relaxed/simple;
	bh=INPL5mykLyHh9BAddpKD33kEw5Zh1QT3Mw8WI6pEDxg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pnxD8Sbfy3UkjKj6+BhI7GUW0bMG9uabKiyB+lV8YGsfcpYM5bmwfBjzu4N39Gmx1+S0jm6YLzZxB4wEc/A50bcC56dlMKk4YwyKQnYOOWGPC+Y9oUHVdtlSpBG2jCZTbczoYkRS39WPwmZVZHQVBRyoRLmep86W3gBF00h6bRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4mQoCg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E490C4CEF5;
	Fri, 18 Jul 2025 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856979;
	bh=INPL5mykLyHh9BAddpKD33kEw5Zh1QT3Mw8WI6pEDxg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=e4mQoCg5Tz9JFE4uV4vL2IjU1RigIFqVqZ4sJZO8H6VGogZEzTAIFy5jN65H1XejE
	 oTqrFMqeIxHiuoPGmDVEEsZt8J/W8iFLxLm7FwIQkvSA5UxlhtPrgDRELQJ3UQcUea
	 IDAcD5fyoT9TMo7rLvFdSr3ltWQ9riFoDHaLy6UBrcVGr7zZFK1fk8HrpOmLwH8ljq
	 ijDJTTaZjSl89JddpAnDtIDJOZ1EMVGTFp02XmLG/0RnBM4eQvPC5XKmRFzUXnHI3n
	 uaJhO4pLxQQZvm+KPbf1rNAkr19Ie9jo/dpoC9CQyHjv/5asbqP1NVvTD2w5tCtpTR
	 AS3o6HnJ62jbg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucoB9-00000007JWo-2HKG;
	Fri, 18 Jul 2025 12:43:23 -0400
Message-ID: <20250718164323.399926416@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 12:41:21 -0400
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
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [PATCH v14 02/11] perf: Have get_perf_callchain() return NULL if crosstask and user are
 set
References: <20250718164119.089692174@kernel.org>
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



