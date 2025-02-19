Return-Path: <bpf+bounces-51959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DADA3C371
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBF5167089
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3C61F63D5;
	Wed, 19 Feb 2025 15:18:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA61F4E49;
	Wed, 19 Feb 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978320; cv=none; b=GGzeLpbnaVDX41YIo7h1zWuzA0X2cYMw5BUvSbGcY0KDyHnb/XpbQAAT5fuzowv0/aZEdJXsM+yPlHn8NbSXCCBtCDfHg3kqUrQLFNKXgwjsKVbWzwBp5/u27JsNEUypayHwi7YkGYaLDhCh2Sl1w55frGEdZMtra+Gku+IFdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978320; c=relaxed/simple;
	bh=CZN+DJTU1FP5EcK//guKvM3/YUOswzvJeNjDI5X9fvA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MVu8Ck+j1ZBjijhxfpoe/j1l8f9HoBS/vrq/6xCqrVMYkrbJVvNyAPZFM+VcbSefnjv1sLK3Qm82J/z+fF3/S6WLde5SDkFkxyI5BEA7jrTWERi68uXmvzorx9LlsrsckBYXCbXQ3uXCnxPQwj4fMcv6WrEBAuRhhMfglyGwjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305E7C4CED6;
	Wed, 19 Feb 2025 15:18:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tklqq-00000004bal-3KTN;
	Wed, 19 Feb 2025 10:19:04 -0500
Message-ID: <20250219151904.644627561@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 19 Feb 2025 10:18:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 bpf <bpf@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [for-next][PATCH 5/6] ftrace: Update the mcount_loc check of skipped entries
References: <20250219151815.734900568@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Now that weak functions turn into skipped entries, update the check to
make sure the amount that was allocated would fit both the entries that
were allocated as well as those that were skipped.

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin  Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250218200023.055162048@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e3f89924f603..e657013424aa 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7111,7 +7111,28 @@ static int ftrace_process_locs(struct module *mod,
 
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
-		WARN_ON(!skipped);
+		unsigned long pg_remaining, remaining = 0;
+		unsigned long skip;
+
+		/* Count the number of entries unused and compare it to skipped. */
+		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
+
+		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
+
+			skip = skipped - pg_remaining;
+
+			for (pg = pg_unuse; pg; pg = pg->next)
+				remaining += 1 << pg->order;
+
+			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
+
+			/*
+			 * Check to see if the number of pages remaining would
+			 * just fit the number of entries skipped.
+			 */
+			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
+			     remaining, skipped);
+		}
 		/* Need to synchronize with ftrace_location_range() */
 		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
-- 
2.47.2



