Return-Path: <bpf+bounces-72320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD1CC0DF6D
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176FE3BC36D
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355B2571D7;
	Mon, 27 Oct 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM28Z82W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4925A2CF;
	Mon, 27 Oct 2025 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570856; cv=none; b=fRvkpKefmXn7MnhxF0g5ODE+e1jwzWw/pYsT0l146/6D52eU+plsZ+kdWkpsGlQl+tAzoe7sD/e76vUQF/V7sC1d4NmiuOSbVS4ubnadxYNXEEeY16/SNQ3sC5dkV0P1L0rgnqkz4B2kSzNrjfK2/6bkZFRVjtrJBMuqDIgvIBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570856; c=relaxed/simple;
	bh=EgQ5UHK3E6tG+rgmnVk3yfEloNDLZP38rFuAbShcLDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eM/6Xz/hofQtA0DGkuCUjlBqtnT3W5Htq5HmQSweyis3HF6uXsQkHkhL+gNtP+8eva7psBUC+jS0ZF+iUb5qGKqQfdLozHNo4b2ECFpeLQgGl3GpWXjakvUSQomDBgomqIwPolhuoM5zeoMfsfAhmrRZus16GmgGDGNUOuNwr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM28Z82W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D89C113D0;
	Mon, 27 Oct 2025 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570856;
	bh=EgQ5UHK3E6tG+rgmnVk3yfEloNDLZP38rFuAbShcLDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aM28Z82WCuUu3yjvrinZAQ5RppNKPpG6/dtHVhCEjeU+I4DpD0P8rY1Zn4qYEYOQU
	 2K1mjm+kNaWswf3RvemgteChFof1eLzkfWOwH6ZHI5LrdpSEDicGAv7T/Jo5NSZqFD
	 ukNM3NPTjGdhDw4p/1qKiGUySBnZ0jMWGIyNZflh/Haydq8NyXy+DGspT+x9iqxRBR
	 53UGcDPZnEbe89cD5DCy1L40M75yBXe1+Q6t8g5qyrqBRo/W0BpQfBm609Rr7Rei2b
	 DoMrojBduZ0/1SGNN41Y0Sh9Kda5RqC/bmA40f1RkClSfwNZoIGn2bTqn9mRPe4jKt
	 QX8fKnp8ovO2g==
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
Subject: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
Date: Mon, 27 Oct 2025 14:13:52 +0100
Message-ID: <20251027131354.1984006-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027131354.1984006-1-jolsa@kernel.org>
References: <20251027131354.1984006-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 83f44ae0f8afcc9da659799db8693f74847e66b3.

When perf_callchain_kernel calls unwind_start with first_frame, AFAICS
we do not skip regs->ip, but it's added as part of the unwind process.
Hence reverting the extra perf_callchain_store for non-hw regs leg.

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


