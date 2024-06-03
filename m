Return-Path: <bpf+bounces-31244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8128D897E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254A01F25842
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E613D2A3;
	Mon,  3 Jun 2024 19:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD113CFA4;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441633; cv=none; b=o7WLjfFgrQcRri8qtdR72REC1jvooz3z+9zzw6H8GhY+XvUO3FR2nn0Xc5icV26IjVaVyqpEmd1ZOGhR/rbQ9IcNnl85GyWvVR4naUQjcORrdczB2IZkKI//VBX2B8RCwwmiEcg1OQ/RU7MiahARPtZcg6WI944Xx1eNMKLZNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441633; c=relaxed/simple;
	bh=HaOqVX9Zfq8EcxlqcgeTv6riQSn0DAcVMNqbadp2eeM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rKg9hctxxEGKAmGRDo0lGA3owFq4gikhwiEJ1eB0EuCJvsLi3+nnRJxJfHkbPd2kkEi8TIv4ZjgnS8Z3iPvHWX/sVydy864XjjhQ7SDNIRA+7ECjZHUZRvzni+ivAfuhdNSwgqvTnwnZy5GdsJ6+LaB4SSV5NOHxPgrE4IgT5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5B8C4AF0D;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2e-00000009Twx-2Rbe;
	Mon, 03 Jun 2024 15:08:24 -0400
Message-ID: <20240603190824.447448026@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:26 -0400
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
Subject: [PATCH v3 22/27] function_graph: Use for_each_set_bit() in
 __ftrace_return_to_handler()
References: <20240603190704.663840775@goodmis.org>
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



