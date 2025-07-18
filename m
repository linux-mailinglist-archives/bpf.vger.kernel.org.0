Return-Path: <bpf+bounces-63747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B8B0A8B6
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 18:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C07A87C3E
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3532E7628;
	Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHrJK+aM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27D2E6D3A;
	Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856980; cv=none; b=dbq/kXEX44z4mmLhFx0HjM60+olsEmG4vk2C0CTaHSAfucP1IfTKIeDlWtjjk2IPMYXwA0wT7OLbgqjQxwJrTSk6I+MyLWn9H3YicI9UvPGo7p1IeJrenNCEgqgq1SaTyA9PrL828FUQ6OzQ4FupSxze4pCms1eO2dLNVxIpCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856980; c=relaxed/simple;
	bh=mI3D1M5ZCCJZqFgS/KQwGydDItxmqMt6XzVMmgcg8Qs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gQVv/J72a+s1Vl5Jv5K+NuwYT8WstkJ54FrKSNE6yLlzhQL6Cc4gqXomYo2DeDh2V8hTGh0BUXEzJCEFL0i0C6rfyht1gsqrFiQf1sVoeGfeBoFMY1mZEA0p+PzGNIqtrmYi8fKYy6sS3/EzWXoPyXmj8MdN4D6+c+Y4WM0l1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHrJK+aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06735C116D0;
	Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856980;
	bh=mI3D1M5ZCCJZqFgS/KQwGydDItxmqMt6XzVMmgcg8Qs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=bHrJK+aMHBWvVtTh8THZE+njuw6VGsCiA1zSnb7U4/l1bGvYvxWnjuprC/LCYCcLj
	 /ZLGjPkO2+5EaFtPfFMNMcDEZVi8IJERtBAjgxn8f7SyeYWbzZL04YhnpJdxaMPT+a
	 jiJYU7yFtcWwl+h73eSMqrsQaXTSJd7L4nAASvFCaM2JEyH1SsCvgHHi3qMS0Q1G+C
	 zy89ifqPj8q7bjgklInZP59WcayHV47csxiTz+SeKZE8bqRH+6ru5w1PGxxHrwXF4l
	 ZDX0XnOGHI3qFTHwL/9QMQ5497MdpA145QYl3Dc52ncD+WLTAxVQ3ZsnkoUu9v0CES
	 +i/cw4r60kM3Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucoB9-00000007JXm-3luk;
	Fri, 18 Jul 2025 12:43:23 -0400
Message-ID: <20250718164323.749229679@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 12:41:23 -0400
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
Subject: [PATCH v14 04/11] perf: Simplify get_perf_callchain() user logic
References: <20250718164119.089692174@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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



