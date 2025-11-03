Return-Path: <bpf+bounces-73387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C658C2E37F
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 23:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD36F3BE0E3
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18BC2D47E6;
	Mon,  3 Nov 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQj4Qddp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558A35979;
	Mon,  3 Nov 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207785; cv=none; b=f3byQ7yV+3o1CEj04tOToeHZtuMS3plvGCDO9lF5qksI9yqJgWA1a/jWihVPs4lOPlGnuNvl0y6lhmbGz/W2zWZVLtDlgxjLaZL0wFkuTkqUsUB7f37CEJfSE2yhdqxNEy06dTME5K6y1jvqxk1+Xn91h1nTv6vHC3hLCd/ugdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207785; c=relaxed/simple;
	bh=fFeQAzKrGGk4SEJFLZjM88TjWXOyURXV4b9kBZawNCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvmCzQHQBjLEdKLZnsAGj/xVhfSEIsg8OmxsQ5HbksINkbCRIsjJM7EK3FmqKGbghTI2PKBuVDPxsW2c9BgVnmmaI/PtI0zZg1FHwJ9Welb0yqrafJOhTeVJtdsypGYfpLGulX5fF3Hrc7LNavOOoDKn7EwqDO1rS6FOPsA1ODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQj4Qddp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09328C4CEE7;
	Mon,  3 Nov 2025 22:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762207784;
	bh=fFeQAzKrGGk4SEJFLZjM88TjWXOyURXV4b9kBZawNCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQj4QddpsHEoGsbZkwSiYLD2aw9wO1GOy1FIQEg5QWXGqR0rgK+U2wXd3mVDZLf/n
	 V7tiOcdKJut45DARIfbdN9lji60EuGyKBKpXA8GHt9/mJHC8zV+Fb0/bdwssQsl0b6
	 6Bir9Ww2xyBu7RxtmzkWkx6i+Plj9OeaKT5YcODiwlEzk4tKLBSrPxDHdixz3YjH9e
	 +qEqjmtlhKkGzHXZzye+0LOjY5KHKfyoEGvFZS3enIMCw4c8P+6RhdtVKNsuiBkDoq
	 KMNjuM2MGeUFTyhjpNw4AwxMKfi8IjyJ6yJLn2NrE7vBg2eLxkJ9JEugz0duw0vBUB
	 qupj91mL4UESQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv2 1/4] Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
Date: Mon,  3 Nov 2025 23:09:21 +0100
Message-ID: <20251103220924.36371-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103220924.36371-1-jolsa@kernel.org>
References: <20251103220924.36371-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 83f44ae0f8afcc9da659799db8693f74847e66b3.

Currently we store initial stacktrace entry twice for non-HW ot_regs, which
means callers that fail perf_hw_regs(regs) condition in perf_callchain_kernel.

It's easy to reproduce this bpftrace:

  # bpftrace -e 'tracepoint:sched:sched_process_exec { print(kstack()); }'
  Attaching 1 probe...

        bprm_execve+1767
        bprm_execve+1767
        do_execveat_common.isra.0+425
        __x64_sys_execve+56
        do_syscall_64+133
        entry_SYSCALL_64_after_hwframe+118

When perf_callchain_kernel calls unwind_start with first_frame, AFAICS
we do not skip regs->ip, but it's added as part of the unwind process.
Hence reverting the extra perf_callchain_store for non-hw regs leg.

I was not able to bisect this, so I'm not really sure why this was needed
in v5.2 and why it's not working anymore, but I could see double entries
as far as v5.10.

I did the test for both ORC and framepointer unwind with and without the
this fix and except for the initial entry the stacktraces are the same.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 745caa6c15a3..fa6c47b50989 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2789,13 +2789,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 		return;
 	}
 
-	if (perf_callchain_store(entry, regs->ip))
-		return;
-
-	if (perf_hw_regs(regs))
+	if (perf_hw_regs(regs)) {
+		if (perf_callchain_store(entry, regs->ip))
+			return;
 		unwind_start(&state, current, regs, NULL);
-	else
+	} else {
 		unwind_start(&state, current, NULL, (void *)regs->sp);
+	}
 
 	for (; !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
-- 
2.51.0


