Return-Path: <bpf+bounces-78624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4069D157B7
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48DF53009D4C
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5B30F93C;
	Mon, 12 Jan 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhG0UbKG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E43343D98;
	Mon, 12 Jan 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768254604; cv=none; b=DiOUpk5W+Fi6GteseKokwuDtBhRJLbKxMkkuix25MfHRY9hLU0Gxf1c4c7plpQab4XxinyLWfFWYxbD3j2eJ36t4qSghsGN052P/kr3fdZm8gPeicmiFuHisImQsnoSC6ocY9bxKX436TJTE/IhqFFsgJaV/FUnK5C3xAO/VBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768254604; c=relaxed/simple;
	bh=rLRQOyFl9Yn18caqSzq5/I+q5RjZWL9oVFwB5wHytXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc/3Lktr4vPva3oDBuLjDD2rZCfR4c6u5Htxlnrw+NX1DJy1qsmWJAj4D+TtGqK2LizXzahGxoNsCdBjuK59KqyFh3QlzIFS/sxGtVaQ3hr0YQzNdpInc0ArDqePue16sUn53hBILBNBoMSFOwZ8JwQriJPoKfu62aA8khSIS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhG0UbKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C8FC116D0;
	Mon, 12 Jan 2026 21:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768254604;
	bh=rLRQOyFl9Yn18caqSzq5/I+q5RjZWL9oVFwB5wHytXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhG0UbKGSC8tmIMX49HXN3E03lqj1gCyV2/8O5FyTEzgfatUrQEoizabSw41HEpqt
	 XT7NQMKju6hJJaaUZWRayK21zQel8n3RKHJOKiVbhgAgeMneCSbMKMzK/WIx2LU8TS
	 NVepglQYdSatxxERX6dNF3lZWwWaXUrbPi68NaghbXeGExqNJNEv+UF5FxfbsYaxle
	 zB/PBdZNdJRMno8Noq3wxTR1Hbpe4pwbpLmU686f5KSXLD2YjGaaohyHmYD5VnMbNW
	 +v5Bvcjb0zW5/LSupxV96C6NR/8x3zSFt5o/5/5JndJsfMu8kiQlDLa9m7csru/QKc
	 ZjlpT2tEuc4Lw==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 1/4] x86/fgraph: Fix return_to_handler regs.rsp value
Date: Mon, 12 Jan 2026 22:49:37 +0100
Message-ID: <20260112214940.1222115-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112214940.1222115-1-jolsa@kernel.org>
References: <20260112214940.1222115-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous change (Fixes commit) messed up the rsp register value,
which is wrong because it's already adjusted with FRAME_SIZE, we need
the original value (after UNWIND_HINT_FUNC hint).

Fixes: 20a0bc10272f ("x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/ftrace_64.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index a132608265f6..613be81b6e88 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -368,13 +368,15 @@ SYM_CODE_START(return_to_handler)
 	subq $8, %rsp
 	UNWIND_HINT_FUNC
 
+	movq %rsp, %rdi
+
 	/* Save ftrace_regs for function exit context  */
 	subq $(FRAME_SIZE), %rsp
 
 	movq %rax, RAX(%rsp)
 	movq %rdx, RDX(%rsp)
 	movq %rbp, RBP(%rsp)
-	movq %rsp, RSP(%rsp)
+	movq %rdi, RSP(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
-- 
2.52.0


