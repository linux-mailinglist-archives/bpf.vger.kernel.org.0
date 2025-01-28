Return-Path: <bpf+bounces-49969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11033A20D0A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 16:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0833616235B
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC501D5CFF;
	Tue, 28 Jan 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of6z6BSZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0451A9B3C;
	Tue, 28 Jan 2025 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078184; cv=none; b=igjjJDMG28JNEjR0wonxqTdvS2kgYcEnHF1zKhrc+rXIGTziCSYZKiPr/znMS69H25NdkkOSaJub4ZHwAz72IuJGVr2AAEKSE62jgkxhE8nwjvb4KQCCfWUtglVcQtwutFLzrQK4wtc3K7VDnh9lzDTxo36K79jyJdIzYGe6pfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078184; c=relaxed/simple;
	bh=E/5O05Bc7J6h133K9M/P8YXXz8k0LwjfSLaX2RCm+V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISbmOfO9/Q0SC8TJf+oImmpKRhOEbOTi4IgTxY0NQ4nxet50T0p5xvXPj2Cyh2R6mCdaVLHX+Zy7LrrvGi/Y0j8WFeH/RqMAMU2QLZdxJWsdOiY/OyFMBK8EmIpXYItEtTL0hZ7AX5Qx016veDYFP8lylw/0dWLTR2ytncJaKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of6z6BSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A26C4CEDF;
	Tue, 28 Jan 2025 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078183;
	bh=E/5O05Bc7J6h133K9M/P8YXXz8k0LwjfSLaX2RCm+V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=of6z6BSZ+dT83xgkWUvnDzqC30ynuE9dlkPtB9DN9TI4kaH5xqBmpcL9RgkI8o9TA
	 LKnaeAFl2dj/klNRplxgq1yV7RYLaRT9Uy2+xD8ZaiM2TWHKpKeppaH1rQA+kssE/h
	 8kUpDW9xsgbr+2EdWYhVWZPspzqP9LzXegNKTdvP9yssYv7RSVkBXMAv88HhNh4qxN
	 tXG8ftNHMN55G+IhXC6f08B0GGdjqx/s8oXm+uDUsP6AGhApxJglVE90Fz+r6pHCl1
	 EnU41PEUgeLl1xLl0FRefif5WyKpQqg1kAUArGZGuaLhix1yDFx8qIYP2oNQOPO+cm
	 EQk9JUPOMfIBw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: [PATCH 1/2] s390: fgraph: Fix to remove ftrace_test_recursion_trylock()
Date: Wed, 29 Jan 2025 00:29:37 +0900
Message-ID: <173807817692.1854334.2985776940754607459.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173807816551.1854334.146350914633413330.stgit@devnote2>
References: <173807816551.1854334.146350914633413330.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to remove ftrace_test_recursion_trylock() from ftrace_graph_func()
because commit d576aec24df9 ("fgraph: Get ftrace recursion lock in
function_graph_enter") has been moved it to function_graph_enter_regs()
already.

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Closes: https://lore.kernel.org/all/Z5O0shrdgeExZ2kF@krava/
Fixes: d576aec24df9 ("fgraph: Get ftrace recursion lock in function_graph_enter")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/s390/kernel/ftrace.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index c0b2c97efefb..63ba6306632e 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -266,18 +266,13 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	unsigned long *parent = &arch_ftrace_regs(fregs)->regs.gprs[14];
-	int bit;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		return;
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
-	bit = ftrace_test_recursion_trylock(ip, *parent);
-	if (bit < 0)
-		return;
 	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
 		*parent = (unsigned long)&return_to_handler;
-	ftrace_test_recursion_unlock(bit);
 }
 
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */


