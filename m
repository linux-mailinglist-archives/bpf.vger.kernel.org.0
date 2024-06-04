Return-Path: <bpf+bounces-31331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24AE8FB5F3
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7878D1F26160
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19014A4F3;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCA114A0BC;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512138; cv=none; b=a++cNANo7jwR6/f0aZJEhRG3VSbOwTKv3UydF7FEolpN5UAEe/rxnPPgS/0Y3YMb3x55UMZdsQ6mPb0+MLwKXMuxcrxKMHUpconJ+O71vWYtMTYMcE9+bz8Np5f7h4hwfabIu1l5bKqMy9UWIgWPzk+yaD/pckvFf1bIo5B3pnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512138; c=relaxed/simple;
	bh=Pyur7WLvWYb5zL5/rTJ/K0q1Rf4L3oxuDRz/ogVLsII=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BhtPzj7URHlmLOEh+kdePJ8OdOASvWZJcv6fUS+tOjGUwkggrqTeAIaJ0DYQr9svtgiYVx+u3PAMn7/p1YWgXEX9jeNJnORIa7L4NS3L4hFDYOPTnh5JY/4QFZeQMVIuxRJ7A8qZOq6VII9c0D0kuNU9Q//HWpbM96/X9DwKsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09D0C4AF11;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMf-00000000Z4V-3QXO;
	Tue, 04 Jun 2024 10:42:17 -0400
Message-ID: <20240604144217.676052910@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:26 -0400
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
Subject: [for-next][PATCH 23/27] function_graph: Use bitmask to loop on fgraph entry
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Instead of looping through all the elements of fgraph_array[] to see if
there's an gops attached to one and then calling its gops->func(). Create
a fgraph_array_bitmask that sets bits when an index in the array is
reserved (via the simple lru algorithm). Then only the bits set in this
bitmask needs to be looked at where only elements in the array that have
ops registered need to be looked at.

Note, we do not care about races. If a bit is set before the gops is
assigned, it only wastes time looking at the element and ignoring it (as
it did before this bitmask is added).

Link: https://lore.kernel.org/linux-trace-kernel/20240603190824.604448781@goodmis.org

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
 kernel/trace/fgraph.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0827b67f746d..4d566a0a741d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -172,6 +172,7 @@ DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+static unsigned long fgraph_array_bitmask;
 
 /* LRU index table for fgraph_array */
 static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
@@ -196,6 +197,8 @@ static int fgraph_lru_release_index(int idx)
 
 	fgraph_lru_table[fgraph_lru_last] = idx;
 	fgraph_lru_last = (fgraph_lru_last + 1) % FGRAPH_ARRAY_SIZE;
+
+	clear_bit(idx, &fgraph_array_bitmask);
 	return 0;
 }
 
@@ -210,6 +213,8 @@ static int fgraph_lru_alloc_index(void)
 
 	fgraph_lru_table[fgraph_lru_next] = -1;
 	fgraph_lru_next = (fgraph_lru_next + 1) % FGRAPH_ARRAY_SIZE;
+
+	set_bit(idx, &fgraph_array_bitmask);
 	return idx;
 }
 
@@ -631,7 +636,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (offset < 0)
 		goto out;
 
-	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+	for_each_set_bit(i, &fgraph_array_bitmask,
+			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
 		struct fgraph_ops *gops = fgraph_array[i];
 		int save_curr_ret_stack;
 
-- 
2.43.0



