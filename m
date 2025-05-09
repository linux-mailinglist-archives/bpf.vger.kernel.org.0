Return-Path: <bpf+bounces-57887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEDAB1AF5
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FD7502901
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65582356B9;
	Fri,  9 May 2025 16:51:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC42417F0;
	Fri,  9 May 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809501; cv=none; b=Tj4CaviKEcS+j016s6zHgScbBfNSqHMjVc5qOS3acHVVtPpeEylaEg4MvQG0iJJxtKP/opXwRLGCxxgmysNRHFM+9Ig55vogaMIsoxYX4Q9A8zlWpwLS/QYX+xlsYPpM/FJmX+ZB+4rKRjGp957TlBR51o9zPaQLHIj+9VI7rrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809501; c=relaxed/simple;
	bh=HGrKuS39xLJq83enXt1f+CmV81NnDU+NNzgmZrHZ28Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b1yLZrLXND8D1fJguabzokXmVrXq9ka/p2ND23lHCPqk49P3hZuW7L+4lGm4jhWuRqKOccMJAVhAnZ+0wNloWDbx7ykGZUUIwbjngnwJWuf4L3/CvejaStWpalXWFtEWE7tAP8p27weikDTVzBeWaO8FmRRFC0upFj3rPK4gvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B3DC4CEF1;
	Fri,  9 May 2025 16:51:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uDQx2-00000002gLE-1ttz;
	Fri, 09 May 2025 12:51:56 -0400
Message-ID: <20250509165156.309890035@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 09 May 2025 12:45:40 -0400
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
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v8 16/18] perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL
References: <20250509164524.448387100@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

To determine if a task is a kernel thread or not, it is more reliable to
use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
That is because some kernel tasks (io_uring helpers) may have a mm field.

Link: https://lore.kernel.org/linux-trace-kernel/20250424163607.GE18306@noisy.programming.kicks-ass.net/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 6 +++---
 kernel/events/core.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index abf258913ab6..cda145dc11bd 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
+			if (current->flags & PF_KTHREAD)
 				regs = NULL;
+			else
+				regs = task_pt_regs(current);
 		}
 
 		if (regs) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0bac8cae08a8..7c7d5a27c568 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7989,7 +7989,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm != NULL) {
+		if (!(current->flags & PF_KTHREAD)) {
 			struct page *p;
 
 			pagefault_disable();
-- 
2.47.2



