Return-Path: <bpf+bounces-73502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DC7C331CC
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 22:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A8618C07F4
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 21:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D21346793;
	Tue,  4 Nov 2025 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9JgtrzE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA12FC00C;
	Tue,  4 Nov 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293266; cv=none; b=aGoUSJKUZQ3fDa58bthu4ijv6wVCBYof4W14n2qenfmMDeWcGpJ8SGDGxSIF3NihSJM2dc40IZaQr/GQruIlEzaZeXFgI7+T68GoxLhtnRALacEUzAbxaERYP81LnreCzGJFVKc25eA9/Y4FPMBR/d4Fum8rPw3z0Bek1tv0L4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293266; c=relaxed/simple;
	bh=fFeQAzKrGGk4SEJFLZjM88TjWXOyURXV4b9kBZawNCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0v1xBB1sndl8bBL4bUDa+kZVA3hX6FlMMa6xa57KvWAloSS+YRUdK3mJI6wYiOGZI90otkvmYAqWwpkVX8sREPbPh1Zg7bZd3I4glA5m/ULSZ57qOHK6JITB8Lj0lsMPYiaxur9Nyyc7DryBJJik6fs8Idzh3EwkQQFnKh6pBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9JgtrzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835A9C4CEF7;
	Tue,  4 Nov 2025 21:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762293265;
	bh=fFeQAzKrGGk4SEJFLZjM88TjWXOyURXV4b9kBZawNCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9JgtrzEAn+3zRF2U5ItnuDcg+lhDqNASi21Iz7nePbvejMcccSlHKncwtyIjJ8tQ
	 LpW4r0BexRodQoMRdWIlTIDtFDwZoFmcBrCVIyY556uIqmV9ka1tKGo0E5EQ9zCYiS
	 5EVw3yY8xbiBdjxgAZ6ByDZ6CVK8+UmUc3mOcK6ZoMVuy3YR9qZD+dpaVBAsbA0/nL
	 YlkMjBIjilsELZc1wfQ49nses5I7DVytfhtAx3tip2I1p+FGmc7JmH8GGiGONpJRjD
	 7sW+vGEGyqxWgvzO4PqSGgc0rMrbj9knuXxTmzkyq0//iE332x+E+0l0hipTzm2+DZ
	 DojeOJ6fncyxA==
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
Subject: [PATCHv3 1/4] Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
Date: Tue,  4 Nov 2025 22:54:02 +0100
Message-ID: <20251104215405.168643-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104215405.168643-1-jolsa@kernel.org>
References: <20251104215405.168643-1-jolsa@kernel.org>
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


