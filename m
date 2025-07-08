Return-Path: <bpf+bounces-62608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB838AFC050
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE3D1710C8
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F8621E08A;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSy4BAUM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5320459A;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940050; cv=none; b=PdkRP8Y3uTYKrz0S7nYTL8RqO9LdfbzCQolk9fXC8hxWGbEnY813TYg4I5DqLQssZw9D3F3LKlRJE3EaKxrTnXLUSukTDPQQuSq6byE7Ymwz5w0RrcDA/oyjk72pE2hD5th8UClUrm4ZoplvwZPtJGwb3kysXWhzOe5CXGo/R9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940050; c=relaxed/simple;
	bh=/LTAfcjza1uzXV2X9tyx4ljH3sU7KdDveD6pJLOcz4A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HD5jo3o5VLPa3TqomVn0Fq8aHLO+ZySkCOYKeqscE2pfpwdL/L1jdSqiuWhV4/Mz8LG5T6tYMtKx+v6HIEWTA9jXRGRX21CkTTZ3jvLRoMljDAEgZY6HG0M+UeB1Bmi4B+f5IDiOT5FREuINTtUOVeXIzTVUTVOuXr/HZoXmDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSy4BAUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474F3C116C6;
	Tue,  8 Jul 2025 02:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940050;
	bh=/LTAfcjza1uzXV2X9tyx4ljH3sU7KdDveD6pJLOcz4A=;
	h=Date:From:To:Cc:Subject:References:From;
	b=aSy4BAUMiwQlbOp+VaYaAAFHGxpqrBKS4n3MbAnmj8eOgHX7T7RVCVn0PbQ1DDQrL
	 jjC0La1OJmS/3n8xsUIwErT0To7LD0ZEI7FhBklVoAenDqwNJtcKQC8XlyHMO192SA
	 gu07I2wRKzvl6KBthnnmts5YmA0obN/QKzypUszpvqWoDiU9hCY47ubNFxMxQ3g7E+
	 ivwTW5DpVbyvkl/QmDRlclrrzYEnUe43qhCThLujYnlAvZnWtNN/vdz4i/0DfE5aYz
	 AvBJOzE4sBwEzeJKRNXL0glc/lzPgtTtpjTq3vR6tfCH/esckX4FPxy7JS+uEHAuaC
	 1hkxCF8IRehGQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxda-00000000D59-2M7c;
	Mon, 07 Jul 2025 22:00:50 -0400
Message-ID: <20250708020050.410920799@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:00:06 -0400
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
Subject: [PATCH v13 03/11] perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of
 current->mm == NULL
References: <20250708020003.565862284@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

To determine if a task is a kernel thread or not, it is more reliable to
use (current->flags & (PF_KTHREAD|PF_USER_WORKERi)) than to rely on
current->mm being NULL.  That is because some kernel tasks (io_uring
helpers) may have a mm field.

Link: https://lore.kernel.org/linux-trace-kernel/20250424163607.GE18306@noisy.programming.kicks-ass.net/
Link: https://lore.kernel.org/all/20250624130744.602c5b5f@batman.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v11: https://lore.kernel.org/20250625231622.172100822@goodmis.org

- Also check against PF_USER_WORKER as io workers do not have PF_KTHREAD
  set.

 kernel/events/callchain.c | 6 +++---
 kernel/events/core.c      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index cd0e3fc7ed05..5982d18f169b 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
+			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
 				regs = NULL;
+			else
+				regs = task_pt_regs(current);
 		}
 
 		if (regs) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b2a53cabcb17..cf35dc707ad5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7414,7 +7414,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (!(current->flags & PF_KTHREAD)) {
+	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -8054,7 +8054,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm != NULL) {
+		if (!(current->flags & PF_KTHREAD)) {
 			struct page *p;
 
 			pagefault_disable();
-- 
2.47.2



