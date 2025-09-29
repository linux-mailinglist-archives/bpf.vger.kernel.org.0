Return-Path: <bpf+bounces-69945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B7BA93D6
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF873189EF19
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9394430505D;
	Mon, 29 Sep 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTOoWGtf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED124414;
	Mon, 29 Sep 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150331; cv=none; b=mm7t1ldmkqAs5Pe/y0F0buv5ulK4dglVAI0foyDSqhwH592xWG5vEJR/JoTOvfhinfZaOd3WW6zBbJ771cl2m2yz6QuTof1HFRhVGwWtCOXlpYElyiuqsadIAYIwPH2S0JaxHQzdDX8pHM+KLv6BSCwz1dm5qRuX8ghZ3VVwh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150331; c=relaxed/simple;
	bh=0Y61i2/JPEtUs4NHRT+GM+hnsD0LgG6qA2wjrd3lTdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oV67qlxnRvtUY7Oom2E2wOIzKKtUwT2UUp5V4Vhi+YCzM2GnM3+/0LSymsXSegrp/t8w2Ytzjd51Vw2xOFnaO7wAuwsl8xQbjszXjjz4xIi84Y414CzFg6/F31Vz7HQJJcH1iXPYCWcRtx0ZyT/2XRvh/v1T1q0eSPlZKRSxhno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTOoWGtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A9DC4CEF4;
	Mon, 29 Sep 2025 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759150330;
	bh=0Y61i2/JPEtUs4NHRT+GM+hnsD0LgG6qA2wjrd3lTdw=;
	h=From:To:Cc:Subject:Date:From;
	b=TTOoWGtfLzIViMofMiKTOBaMYo4vdcZ5Le555tRYfUJIvy3nO0AVatNIdB6y1Iann
	 g5MtWX3R3zKGVxDoC2nwwIoP3pIAwS+pHjFYSPuvNUU8nDQLcoHo3Kjpf3+I0gZ81+
	 Qp73BRJ0aZU7++a0xKDGRleaTIW+g+Kb2ZoaBA6ucxqYmayiHiwsq+n+dbWY0lbFUA
	 h8Wx0GQR5hwhs1v481AgY2dhAm2J/03ybrjt6QnwjL700H0Mg7rdbKDcnVDjeoTvSA
	 uU4b770Xoxi6I4LBRAjYdnSu2G/lkRTwrBgZi+JRR9p26wc9ay+uh+bjeZXrJ3DefR
	 GWoJ7chLnMBCw==
From: Jiri Olsa <jolsa@kernel.org>
To: Song Liu <songliubraving@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yonghong Song <yhs@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [RFC] Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
Date: Mon, 29 Sep 2025 14:51:58 +0200
Message-ID: <20250929125158.2488188-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 83f44ae0f8afcc9da659799db8693f74847e66b3.

hi,
non hw events store first stack trace entry twice:

        bpf_prog_2beb79c650d605dd_rawtracepoint_sched_process_exec_1+324
        bpf_prog_2beb79c650d605dd_rawtracepoint_sched_process_exec_1+324
        bpf_trace_run3+138
        bprm_execve+1191
        do_execveat_common.isra.0+404
        __x64_sys_execve+56
        do_syscall_64+130
        entry_SYSCALL_64_after_hwframe+118

I traced it to [1] from 2019, which stores regs->ip implicitly to fix
raw tracepoints stacktrace. Revert does not seem to break raw tp
stacktrace for me. Song, any idea? I know it's long time ;-)

thanks,
jirka


[1] 83f44ae0f8af ("perf/x86: Always store regs->ip in perf_callchain_kernel()")
---
 arch/x86/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26dfbd9..38f7102e2dac 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2787,13 +2787,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
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


