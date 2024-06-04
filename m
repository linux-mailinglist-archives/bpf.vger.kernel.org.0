Return-Path: <bpf+bounces-31330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1C68FB5F8
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE34B2B0EA
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EA514A4D8;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71F14A096;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512138; cv=none; b=Eptt4UD/3JD0af5pIbHEcpraagddzwbwfunwR26yWATB3jhCH/6qtGFJQ5c68KmS+OGk2aFKjogvtYyeLvhuvnDG+7eXBUnynISIXfObUty9pDNB6mnIb3H5F7uXW7wJRYJkTOeDMU9pMGavh/j0urRDXnoC2nle17v3dg/GlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512138; c=relaxed/simple;
	bh=tawZq6mZMuTEGrptN7vmtsKrb6RsFVEDkjhbdYbPgqc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QwFdypVtfESp1t5ZRjPQcA3rMaAHt4YFYfNHTIqhygeKECd17aU4GvogqpZjHdjgS52HPUBLhLZkDy+XZMflr6alg45NoTG+NtX1W21rEWI2r/Jxwe0YULd1USWMvLkIrokqoLv4tC4gE2RnA8dm+9LeycUvDwy+aHE16oh8L1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A14C2BBFC;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMf-00000000Z3z-2kN0;
	Tue, 04 Jun 2024 10:42:17 -0400
Message-ID: <20240604144217.514766673@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: [for-next][PATCH 22/27] function_graph: Use for_each_set_bit() in
 __ftrace_return_to_handler()
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Instead of iterating through the entire fgraph_array[] and seeing if one
of the bitmap bits are set to know to call the array's retfunc() function,
use for_each_set_bit() on the bitmap itself. This will only iterate for
the number of set bits.

Link: https://lore.kernel.org/linux-trace-kernel/20240603190824.447448026@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index f207b7ae5f46..0827b67f746d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -783,11 +783,10 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 #endif
 
 	bitmap = get_bitmap_bits(current, offset);
-	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+
+	for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
 		struct fgraph_ops *gops = fgraph_array[i];
 
-		if (!(bitmap & BIT(i)))
-			continue;
 		if (gops == &fgraph_stub)
 			continue;
 
-- 
2.43.0



