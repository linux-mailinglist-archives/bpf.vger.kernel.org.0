Return-Path: <bpf+bounces-63748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC4B0A8B9
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83885C0AA8
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F32E7BAB;
	Fri, 18 Jul 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSV60Ani"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8C2E7197;
	Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856980; cv=none; b=nu+NeczR1Vjd/5Ziu986rVpfXfYByKqIczi6LZBZbM4+hStK5ewb+LMNwu4HoaHCjxDepirKK3T+xidJgNCBvUSatNyHEBezhDTkGE6PIM9lftcaMlFqPwj+g37QbfzaiskWJ+2EZFE/yg4XFvU5X3uhb4IKvMM/dmKbDSfZD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856980; c=relaxed/simple;
	bh=PrLV5/6t/jDNDZv13dJ+tk4FMXWbDNxrkHMrhIU764A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RO/iC9LGvPlArsPbmeIYnnl5eo9R9qse3T+Gq3NMNCsgizZdhxmVAEZ155BEOAB/towDI9xVioQmblJpMkfqsO0eXb0Ub2IZIlh81xPzb5uplEaeVPdmlVSmmVLGeVs3sH2VIjZN3qzztFhNEUAVxQGwD6ZvsJX5UJf8QM64ki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSV60Ani; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59305C4CEFE;
	Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856980;
	bh=PrLV5/6t/jDNDZv13dJ+tk4FMXWbDNxrkHMrhIU764A=;
	h=Date:From:To:Cc:Subject:References:From;
	b=TSV60Ani3MuKOzsA0ZrC05OJmgx3B+VpNfAUYCfhwT2YZ4q4C4oR6Ql7bL0nGxS47
	 AO1iLuFT51LYwUsrwBjj3G0e/k4oo61b3w4ZWluEJ36kVTs6yyhce9LrYhI+TgHa7D
	 VaFL4XD9YyMiQ6T5SRYq3Wj/aUOLWKIXABGzJBh387N2vRSIsjC/c5DVjSwo6Cb+zd
	 a+UYO9/GeuPcV+daYGTCsnibfIB/MWF2NhQMJjI+oDkBTsewGpdjVKK7X5iDCT+vJl
	 eLHPy3iX3ZIyc5AsJDF0UnOw7HCOjHh+X6XyMj5hUINmbktHaCfmRgZQMGKz0OnRk7
	 /eGc61OOCxN/g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucoBA-00000007JYH-0HOh;
	Fri, 18 Jul 2025 12:43:24 -0400
Message-ID: <20250718164323.918565553@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 12:41:24 -0400
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
Subject: [PATCH v14 05/11] perf: Skip user unwind if the task is a kernel thread
References: <20250718164119.089692174@kernel.org>
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
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1fa554e2666d..bd0a33f389d2 100644
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



