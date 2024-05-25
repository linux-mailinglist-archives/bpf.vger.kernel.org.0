Return-Path: <bpf+bounces-30573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43B8CED9C
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 04:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC741C21472
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 02:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872838405C;
	Sat, 25 May 2024 02:36:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA59482E2;
	Sat, 25 May 2024 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604616; cv=none; b=qBwhvJGJ7TGH9jgb6/G5n9eVS9AY0AzcWV59e2W0FNJaL1NBRLs1T3bxsuphfg09nG5Bf1j5w/FXr48fzjlAghhHaonFi3JkDccFbRpgFQ/bR7SiM7kg5nRY0xDcXuZvvFAl28EdyDXlZkChAqEeD03ICdruJB+bkBLP8Dt+yeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604616; c=relaxed/simple;
	bh=SzvcQSHtCTZDrarq3GkKkV913OM7ddRg0/jQltGll9I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VWjBX8PPcSGIAri4hciUhf0rsEwV9lJ7WdEf2WGCJbTRKcx1pW71mG2K7c7u3geRRn81yk3wx1mLPOt/l7R2WMSTamdzyIM64lLu5y+9kdJmD8eItmXfrAN6y+610vn8xEp5soo7mHe2zv9gypKJZU9yPeEqLDqIaJkbOxDw5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CE2C4AF68;
	Sat, 25 May 2024 02:36:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAhI0-00000007DRZ-2DBo;
	Fri, 24 May 2024 22:37:44 -0400
Message-ID: <20240525023744.390040466@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 May 2024 22:37:12 -0400
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
Subject: [PATCH 20/20] function_graph: Use bitmask to loop on fgraph entry
References: <20240525023652.903909489@goodmis.org>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 5e8e13ffcfb6..1aae521e5997 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -173,6 +173,7 @@ DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+static unsigned long fgraph_array_bitmask;
 
 /* LRU index table for fgraph_array */
 static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
@@ -197,6 +198,8 @@ static int fgraph_lru_release_index(int idx)
 
 	fgraph_lru_table[fgraph_lru_last] = idx;
 	fgraph_lru_last = (fgraph_lru_last + 1) % FGRAPH_ARRAY_SIZE;
+
+	clear_bit(idx, &fgraph_array_bitmask);
 	return 0;
 }
 
@@ -211,6 +214,8 @@ static int fgraph_lru_alloc_index(void)
 
 	fgraph_lru_table[fgraph_lru_next] = -1;
 	fgraph_lru_next = (fgraph_lru_next + 1) % FGRAPH_ARRAY_SIZE;
+
+	set_bit(idx, &fgraph_array_bitmask);
 	return idx;
 }
 
@@ -632,7 +637,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (offset < 0)
 		goto out;
 
-	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+	for_each_set_bit(i, &fgraph_array_bitmask,
+			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
 		struct fgraph_ops *gops = fgraph_array[i];
 		int save_curr_ret_stack;
 
-- 
2.43.0



