Return-Path: <bpf+bounces-60282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C4AD4800
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2037A6C49
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36549188587;
	Wed, 11 Jun 2025 01:36:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70714A4DF;
	Wed, 11 Jun 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605776; cv=none; b=bKCTzrOF6enTnKqj6s/krzHOkBHxBPt485NNC0s6/RXHYfxGhPksLSgo84sjeg2LzCHFx1U6xqFseu5Hs0DjQorQxXRIvIUbztEj7s+NgdN0r86pv2trjOBuDwKHI5OlG9BH4IG+g45bAgYXB7Qs8HWYt9giE+5xWkUPrG6RgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605776; c=relaxed/simple;
	bh=Afq9c+LZDEcxKxQklFJWpidk1WuTg4q1GZpkp8qg2dI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BlcyO0FqRuFMCJXkXY3h7IMeH3Tu7diL7IhgR36PZcYU/AUU8N7NjDfPGDnxnUp/cDKhi+ZmMqkifwCbmHqPmNwYXQRCtBEBfbrp4icSXUiX3GhFU0q04Z4Io394vbHxIAXZOd+eTOCRETN5V9dT/jWRiyFerCUhSB1zTteMeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id EBA691D14F0;
	Wed, 11 Jun 2025 01:36:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id D101D2002B;
	Wed, 11 Jun 2025 01:36:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPAPL-00000000wNT-06tj;
	Tue, 10 Jun 2025 21:37:39 -0400
Message-ID: <20250611013738.873755285@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 21:34:24 -0400
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
Subject: [PATCH v9 03/11] perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL
References: <20250611013421.040264741@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: D101D2002B
X-Rspamd-Server: rspamout08
X-Stat-Signature: eoxmtm6kuw1k7hbwt6rqcoc8hq6bdzwn
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+lbtAa6HT/mr8WjfWpq2zFTUdqmeUO2FI=
X-HE-Tag: 1749605766-583811
X-HE-Meta: U2FsdGVkX1//GvV0vjtYlpGMLc+68D6SRqkZ29zEjoAKJSTaQ06JC29Q8WD7ObNDZg/FKvnkEaMoKsHu17DgKb3SpKd1xHayUirE2uWCf1oxejSH62NF///9D21H/wEJbT3LkYqNV9E0t5L8aLUiw/5k8uOGGh6UwhrWrN2wQbNSRRRDR9iblw0z7Y0DvWsYQ1ilvGzhJ9QxhlAQ5yaMoZyisY12nu6BlTNc5tXWTJ2u7ur2ApSDE4ds2BObp7IxFEjXxg3gb8f1Uct2k3rEYi4VxstojU0W3ilFMnuErE39oynzkghJ698jIJU8gwwvWY8tgnlkk12BGXxNCeaaxdtSAPyTx2Fu1AdO1eCCcMSEQ2tJEpw+CsWVpaRoL42vAuM4l1Jzina3lOgPPSH8iWPM0kAjrs5zzD41XCdl3SxbLC7V9uuVKlUpMu3ZBARzJdP8VYPooCpcW93AUpN3FCkXfqgFP/VK2tsT6pSM2ZI=

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
index d8688668d21a..375115492c02 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8032,7 +8032,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm != NULL) {
+		if (!(current->flags & PF_KTHREAD)) {
 			struct page *p;
 
 			pagefault_disable();
-- 
2.47.2



