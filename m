Return-Path: <bpf+bounces-61968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE20AF0274
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777FE1C07D88
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B59283FDD;
	Tue,  1 Jul 2025 18:04:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC8280A5A;
	Tue,  1 Jul 2025 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393066; cv=none; b=Lm6EKY4mCxgIPOuHpaSiuMZp4B+EKk5rXHfdVyks6Tlg0JVorr65/aHMelDYGnsm8K+c59UtDwWPtpMENWMT/u3G/kOKMVAUZ9jg6hu0zixO/WNDdqBu5ybqnbT4niFJZ1+XBsFb2/KPv4nz4iye1j2d5CjYVMythJGeT3fYPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393066; c=relaxed/simple;
	bh=mI3D1M5ZCCJZqFgS/KQwGydDItxmqMt6XzVMmgcg8Qs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a6P4Vj7VeA/lZIlf32SqGsQQIXIStf//h7oW5MxLaNQeNKu7rHaZKSR56FAHsgXdS/rOCZtLt7tl3z31g/EYkJ77kj1VZXwz9bdbmkTZ8VSYvPKwCYubJTPC1NDUfQYU/qW9shHHPnL8DH4CDUkzQEnOLt5kBdEDl0MRUBjD9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 46A5559C82;
	Tue,  1 Jul 2025 18:04:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 0085B6000C;
	Tue,  1 Jul 2025 18:04:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWfLk-00000007g1E-1V1U;
	Tue, 01 Jul 2025 14:04:56 -0400
Message-ID: <20250701180456.205906248@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Jul 2025 14:04:14 -0400
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
Subject: [PATCH v12 04/11] perf: Simplify get_perf_callchain() user logic
References: <20250701180410.755491417@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: t5fqgjm9q49b1sw8r96no1o3aycbj5pi
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 0085B6000C
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3mQwCmeiCx7nu9OHuA/+n7V/6878IeLk=
X-HE-Tag: 1751393057-123726
X-HE-Meta: U2FsdGVkX1/L3NpAw46B5U3x74Ewj9jHnthSc4A8D1Ripv3a25REzPdcw1bdzWbN4/h2s2PFeehXYna36Wav0QjAOs3UgHu/BkK+ii8B8e57BjvWUhE/nQ/ZqodS3jdAK1Exiqdm7VxGPuVDyP2oIoFAacs+0xzFOcHRmvI/G2W7FN5INjaffrQ4lTAp/5iIOlhet8XWYrXM1fzj42eTg1byXaDRoCQdTnoBZ+zJ0arXHHZZYzFTVrPHowh0OdclEpzTwmnNoJdB85JG8AA27T2PJJ7W/4sLOjx+8Wv70ZgD2xaNyWeKmSMuOZbSe9lC8WtrWXfuL3vaN4O/UPyOi5ybA5Zos8wWAYfd3V+UNdHEJjN8noQwQaMTi87ALz8mcwsHAIVAtVb2vMv9SLe8diGgM2OEVYT3g2kne7WlP9w=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
should never be NULL.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 5982d18f169b..808c0d7a31fa 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -247,21 +247,19 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				regs = NULL;
-			else
-				regs = task_pt_regs(current);
+				goto exit_put;
+			regs = task_pt_regs(current);
 		}
 
-		if (regs) {
-			if (add_mark)
-				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+		if (add_mark)
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			start_entry_idx = entry->nr;
-			perf_callchain_user(&ctx, regs);
-			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-		}
+		start_entry_idx = entry->nr;
+		perf_callchain_user(&ctx, regs);
+		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 	}
 
+exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.2



