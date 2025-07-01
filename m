Return-Path: <bpf+bounces-61966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A1FAF026E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8404867D6
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A2228312E;
	Tue,  1 Jul 2025 18:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E927FD62;
	Tue,  1 Jul 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393065; cv=none; b=oyRMFbeMPYEBkCOgXwj0BTpgRqWMvSuvgMRx5jQSPHSYISOrrwrGLUwy1LS/2i9atmmY1DKDDSeZuITLnOaWcIMVS/sLUBJN6drtID72a+sN5i+gw2NUYZVCw01i9fJkwL/UmUXu5yP3cVKGuXA+4SG4eS+29/6Ua/bJOFo62as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393065; c=relaxed/simple;
	bh=nuAkCPXrkAMipqh+INMZEGvjPsxbevVY5SLiOS8YuA4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ekpJaBfvjil/Tjd29GNGQFYfdxE93jPkfcgafQEKPYFbzB1M2A1Yxn0SoXbR0Kv/qZpUV87ijYZPq+wL8QYaFI28tdswMvIvg2RInacpiLhCaZ8T38mJGm7KaeRNZtCLUAK/TAVqVVy8KnzTW9IDWafgDuLJKF5FkDRDouTUDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id ED024160607;
	Tue,  1 Jul 2025 18:04:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id BB7B11B;
	Tue,  1 Jul 2025 18:04:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWfLk-00000007g0k-0lrR;
	Tue, 01 Jul 2025 14:04:56 -0400
Message-ID: <20250701180456.042282570@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Jul 2025 14:04:13 -0400
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
Subject: [PATCH v12 03/11] perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of
 current->mm == NULL
References: <20250701180410.755491417@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: bk8f7yxnpt8j774if75zxffur31cscx1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BB7B11B
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18HFOMwrhxelB/a3hYoLuUib7pdmcv9yIw=
X-HE-Tag: 1751393057-642338
X-HE-Meta: U2FsdGVkX19L6iz7EjeKouppemnzNLApJKCiaF1TtaSkp4600dE/VCZpcSH56EAvH+MvxP7vFhs+ObbqYOJps3NVyxveCDm+i20q/DDENaqARxUVU2f1/LcVTC4BYYwDqTwTkB+rVFSnp7ODtXCAk0FxvAIU3tD4oH98yeYgArRmZafSp/XvhWB2uWRAL091PQsBX1YwUpyjC7tuaq35Bq6ZMITKO3MJldv3+4NtT1NSwUDMVRPrud2wW8wJtdRv/EWQ7QjzyjWoF6w+SC5Q3NyHP3ArzYSqMMrZKCddaK1MnKNLpgZS2/4u5bJExlW3D4/PAYgc7rrOD6Wv0jSdn2jtEy8645E/M86/Qc3Yym8dmPrE5cG+sq+63kIOTfBnQ5KAyZlqcqFomlmTpGQLE/f/Wn1fAZicbOMM6ycGYXPONJJEb45s2wr3NubzIUn7l4iYnfvww+cqrr8vN6WPZA4vKa4AWkQhfCGYkutwuyM=

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
index f2f7cff826e0..2c524fe4bd19 100644
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



