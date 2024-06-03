Return-Path: <bpf+bounces-31247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3898D8982
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1BF1C239E9
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FAB13D2BF;
	Mon,  3 Jun 2024 19:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5113D247;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441633; cv=none; b=ojzmbZXLN/xF8ev5vlN5dycBZoeH00x/1KL6rBWiqswn64w3GxySlLLgFgEeA8mU8zIkAVJWXxBlAcEviJLJFalj3/iaRVzdUsEuN5TF53Cuv+XN7bR0wqF5zH9PPqS5EAMl5OvRPV6NZHx9uDphVypAWgIunZkVzD0EBwXVzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441633; c=relaxed/simple;
	bh=Pm7PSUxREyu8vazVQyA1LZW0yMStfKzkpurO/Q2407g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MnS0hPK+y/fAqJWAY9nm+AU16bRi5VFfQFWy+zbfENnKuTaAc4hQxCXktNu73nrwpVAhb6Un1BD3NtNamozCLqpW3eh8Vs7++c5mKZochKIva3zDxU7gT1aGMpIi2EF1m+sAAeb0HjIQA9PqCxzrQLqogvp0UNs7Kt/iYW/2GLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF147C4AF18;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2e-00000009TxR-384F;
	Mon, 03 Jun 2024 15:08:24 -0400
Message-ID: <20240603190824.604448781@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:27 -0400
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
Subject: [PATCH v3 23/27] function_graph: Use bitmask to loop on fgraph entry
References: <20240603190704.663840775@goodmis.org>
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



