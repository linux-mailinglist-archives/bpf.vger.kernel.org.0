Return-Path: <bpf+bounces-61992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045AAF03A8
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908DF1C09F0B
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385428937A;
	Tue,  1 Jul 2025 19:19:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15049289364;
	Tue,  1 Jul 2025 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397555; cv=none; b=fgkxZvHENSnJo49Ga9o5fh+WDnRbSSbAawfDrinQjLuBYPSTpeqTaWWKnuhOCuwv9KVnw24pIi0kKPBBGvyPCNKBVoy5Rmg5vbh1bVry5VAlCggu3iyynzvwWzuuuIlVK9i7ETkZujiR2NikZCr7sacwVFrdhdnXXBn9HhNS2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397555; c=relaxed/simple;
	bh=K+uZHwCq+91vWAJNLDVfH/PBptoSIKJKf4HJIsHzZOQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=p/iBQ4irmkZRXBN0mCmM5qkv4hvmka4kiborpPufttlhjMbli6QUZQa08AF4f7iL9N0FQx6vo0hQvTsRrAn7Ny6G9DfvKVFv5Srs6Ckdea1p6MtPOtZkVeBCllwadQGNnJU9cuXmFnghEjWYAFDpxPUjySqkybVJu4pCUhp7EIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FE2C4CEEB;
	Tue,  1 Jul 2025 19:19:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWfLk-00000007g1i-2CkU;
	Tue, 01 Jul 2025 14:04:56 -0400
Message-ID: <20250701180456.377286744@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Jul 2025 14:04:15 -0400
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 05/11] perf: Skip user unwind if the task is a kernel thread
References: <20250701180410.755491417@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

If the task is not a user thread, there's no user stack to unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v11: https://lore.kernel.org/20250625231622.509379386@goodmis.org

- Added test against PF_USER_WORKER as well as PF_KTHREAD

 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2c524fe4bd19..43d76ed882da 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8166,7 +8166,8 @@ struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
-	bool user   = !event->attr.exclude_callchain_user;
+	bool user   = !event->attr.exclude_callchain_user &&
+		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
-- 
2.47.2



