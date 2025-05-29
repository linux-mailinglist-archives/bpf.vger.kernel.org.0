Return-Path: <bpf+bounces-59324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14781AC82F1
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 22:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079181BC4A5B
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0A292908;
	Thu, 29 May 2025 20:04:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AFE4C92;
	Thu, 29 May 2025 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549090; cv=none; b=tkEDGJsjm7pvUe/wxfjVWginB6yyVkef9XlwTDTU2WMH9iDKuwtAJdzEyTfMLPWWb9MWJw0sjROtzI184I0g0/YVMMJR3+2Y4wPNvAcdfrfLQe/JshfTw/c/ed0NaPVpFyHsct7l5Ty0Y1LO1me+U712kUsWcaOahGB/4Il6LFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549090; c=relaxed/simple;
	bh=MuS1id6dU73nm3BtKcly2PUJ4ElkKCQ/hx04pqK9rs0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hhYb6X1el/WpIxX67AWjGj9KR3ffnAMvRnu7S2LcJrukg9gvSwZ2WCpcZwbjkQh2VWlNdLMNUoDnUTI9CcJ/+7x25GlJ5Ip13VwbVFSf0HNwJYr/0Y4NNp0u30pO2aMg+jnF9Nda1GsPB88PsYEyXcWF2aBZ+lGww34/m5OQXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A6C4CEE7;
	Thu, 29 May 2025 20:04:48 +0000 (UTC)
Date: Thu, 29 May 2025 16:05:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 bpf@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] xdp: Remove unused mem_return_failed event
Message-ID: <20250529160550.1f888b15@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The change to allow page_poll to handle its own page destruction instead
of relying on XDP removed the trace_mem_return_failed() tracepoint caller,
but did not remove the mem_return_failed trace event. As trace events take
up memory when they are created regardless of if they are used or not,
having this unused event around wastes around 5K of memory.

Remove the unused event.

Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/

Fixes: c3f812cea0d7 ("page_pool: do not release pool until inflight == 0.")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/xdp.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index a7e5452b5d21..d3ef86c97ae3 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -379,32 +379,6 @@ TRACE_EVENT(mem_connect,
 	)
 );
 
-TRACE_EVENT(mem_return_failed,
-
-	TP_PROTO(const struct xdp_mem_info *mem,
-		 const struct page *page),
-
-	TP_ARGS(mem, page),
-
-	TP_STRUCT__entry(
-		__field(const struct page *,	page)
-		__field(u32,		mem_id)
-		__field(u32,		mem_type)
-	),
-
-	TP_fast_assign(
-		__entry->page		= page;
-		__entry->mem_id		= mem->id;
-		__entry->mem_type	= mem->type;
-	),
-
-	TP_printk("mem_id=%d mem_type=%s page=%p",
-		  __entry->mem_id,
-		  __print_symbolic(__entry->mem_type, __MEM_TYPE_SYM_TAB),
-		  __entry->page
-	)
-);
-
 TRACE_EVENT(bpf_xdp_link_attach_failed,
 
 	TP_PROTO(const char *msg),
-- 
2.47.2


