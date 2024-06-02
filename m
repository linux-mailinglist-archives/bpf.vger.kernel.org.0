Return-Path: <bpf+bounces-31132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDB88D7362
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F95C1F21F49
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7640848;
	Sun,  2 Jun 2024 03:37:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D483BBF4;
	Sun,  2 Jun 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299447; cv=none; b=j7rtz/Qwi9HFEMt2zLMIJa5ag0tgojVwopBZrmcRK0xNE65HqdF5YrgOqMuZFs1mubkJ4HP4AqAjeN7EOMW/JK1SL6zDPLG05+PrwtSnPPVFGT1vn2R7nmPaIyRY6yBWKDMWc0PM7rKx521uaEwShz5Qv4/XTCHFKFA9fNlWNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299447; c=relaxed/simple;
	bh=zNX+8r8t+PUCLhsB1Ks9Ro5ISDleDaihMu+uhUeTdwc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=n17Hnf240/8Vfh2m6XxamP9cv0sCEG82Iht1KgohfzpJ2KCwqIT2QJLY7bzppiN+wcvYZhHN/ULBNORYGzAdJmSoNQliDWYR5mW59d4EEluBGJvgUI+c1c4bFLxwZTCw9e+v2VaF90KzDCeI2J5PJHTy1uRAB3tmcioT/yS1feE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5DAC4AF08;
	Sun,  2 Jun 2024 03:37:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3G-000000094UR-46LC;
	Sat, 01 Jun 2024 23:38:34 -0400
Message-ID: <20240602033834.833336234@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:38:07 -0400
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
Subject: [PATCH v2 23/27] function_graph: Use bitmask to loop on fgraph entry
References: <20240602033744.563858532@goodmis.org>
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



