Return-Path: <bpf+bounces-30572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC458CED9B
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 04:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CA32826E5
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 02:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211080BE3;
	Sat, 25 May 2024 02:36:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2C42AAE;
	Sat, 25 May 2024 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604616; cv=none; b=kaSM7gZYXAfoPsRto17tzxlP4i3vam/IqGHVCfxmCLBGTHnFJqdo35wBzFM+fSvxPLKUdbvyKOYQBnjPmo/nROgvluoqCREDM+PXOkf7RHjiuAdCTNPoSWekfF3CPZFWzd7bg/US90HGCY4VmMsmIZUNtG1BBpaqsFLsb2gVtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604616; c=relaxed/simple;
	bh=8c3eUfuTpuKiHlzEemN4Bi/eGFOd/Gj+lm0eh9S4nRQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sJf8xJ4tERb6GKQUP4m56+8E0Pvr/4dCEmYPpJfRMK/VWnAqreucwVPL9/QN233rT74WkS+nn3uWzaiHQNjNO70mNwH5T1jbouBTkJKj6/FCbhTcyw6t/PJZuEgVux7Ysb4IfRXZwsZAQhiYpJehqz+TAjhws6Ir+MszHUFW3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94BCC2BBFC;
	Sat, 25 May 2024 02:36:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAhI0-00000007DR5-1YQz;
	Fri, 24 May 2024 22:37:44 -0400
Message-ID: <20240525023744.231570357@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 May 2024 22:37:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
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
Subject: [PATCH 19/20] function_graph: Use for_each_set_bit() in
 __ftrace_return_to_handler()
References: <20240525023652.903909489@goodmis.org>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4d503b3e45ad..5e8e13ffcfb6 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -827,11 +827,10 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
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



