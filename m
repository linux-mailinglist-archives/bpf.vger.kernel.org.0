Return-Path: <bpf+bounces-60288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F7AD4804
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35843A9407
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164981B3957;
	Wed, 11 Jun 2025 01:36:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495714B08C;
	Wed, 11 Jun 2025 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605808; cv=none; b=flyiGH1TqpCWeBSeGcrBbbrxbFow6IRYJMiYVav5SvSEqscjKhjiIkoY9VoNIbWAHdNY8pEqkfRv/PF6UlRepxYS9e70YiPSavsWnY/kyosJJigE2sggbaPipHTtys5vbON9XvFscMyFQHh9ZQCYrDQP1h0dbr1sr3GrpQUj1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605808; c=relaxed/simple;
	bh=YSYs+sDx3g+kTQq1PzAjoKygSIU4zjvdJ8dLKOQE1cU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ahqlo4GFLUuE3gL05ZczZ/c3blvEV2gw5GQOP3r5DNl9GRXPwhwc1/EOh3LH5/ZFWgrHgHnf0hKvFYRD1hQKg8Kl5Y7f6v3wKF3DLms3WRX/qBxyIX4PBctSN6qcdoZIPAjEFuUZOWcHeFhSTvXwMGMrUTUTwZD14zulNBy9d7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 52805161692;
	Wed, 11 Jun 2025 01:36:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 3F0A618;
	Wed, 11 Jun 2025 01:36:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPAPL-00000000wOS-1Xcc;
	Tue, 10 Jun 2025 21:37:39 -0400
Message-ID: <20250611013739.216620997@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 21:34:26 -0400
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
Subject: [PATCH v9 05/11] perf: Skip user unwind if the task is a kernel thread
References: <20250611013421.040264741@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3F0A618
X-Stat-Signature: csy6igxzswbkkq317o7nhbeghtcm6wsh
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19tJ49e7JeC9vQT3+wKZPvp2LsDnqo26FY=
X-HE-Tag: 1749605767-838807
X-HE-Meta: U2FsdGVkX18PhVAR5ZZnWcviQgadU72Y14tiYqkkaPHxg5uoROdwvSwEjyeRYUotpo0p03yAvxf7khKaQEI0pV8wKajTX/N1C/W08E+vdw+QQSSIfmmITlIfRz1TSGIF/2ZKTiV5NVIfs99AiIRm4cTm204x5nvqdtpMTfzOG85ZQzW6rFN5sjzE99Atse70VSaQ42ggwGpuO7Z3R3A7WOuaFNi09UePQ8nLTXP4Eu4vgFAu36QC3xkw5iHHZ4bcdlXMO8LGWmyMxUGaCKfk1qvADPSp0A0wZWUk+kD2YoowXHtHFGQrbE2tFWaI5BoPfh5N1UcndLoOR7pWjniLuTkluPzBP6GA+q+FHn8NZ2/R30H1WY8iYXRX/lkvB7RbpK7Ldho81ngYaWkdLxym1mi9F+BrSRkwPpkjV/kbB3g=

From: Josh Poimboeuf <jpoimboe@kernel.org>

If the task is not a user thread, there's no user stack to unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 375115492c02..55d5d4ded7ab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8144,7 +8144,8 @@ struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
-	bool user   = !event->attr.exclude_callchain_user;
+	bool user   = !event->attr.exclude_callchain_user &&
+		!(current->flags & PF_KTHREAD);
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
-- 
2.47.2



