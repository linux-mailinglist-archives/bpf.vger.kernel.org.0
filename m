Return-Path: <bpf+bounces-60469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C1DAD738B
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4721882874
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32AC1B414E;
	Thu, 12 Jun 2025 14:16:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CC42048;
	Thu, 12 Jun 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737780; cv=none; b=Uj9v6AREAdWHLALE+ZgaWPdqn7PG8oDXk5IRlXsQf8H9thqns1MCQJe6Cxu2FUwoPypiHm+8WwRz55lujsS2qHlljw7wLaeBmxNECMpjcZgoC/64XtP5WStf0UGvK++Yqe+/jsU6zgbBzXerewsx6Aimb2u7cWGnbYY6Uju1no0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737780; c=relaxed/simple;
	bh=qrWplOJ10X4pm1s0y3f27TzILjMBsOKq8Qs8gbRCNso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oEfsNxt9MaE1G7TKAXkdkLbZENmyEzk1cKD6tvOfa4eqws/S2M0wR6CKu1V8hzbVmmBtlp683/EXLSTTLm5cdOCcHhVR49Ycx7o8gEPs1s27udUzlQo9hsx+3OFh7XloG3sdvm8h5kou05/bRLDtd8v6i3oWT2UVZCw73/sTCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 523D181154;
	Thu, 12 Jun 2025 14:16:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 11D9520034;
	Thu, 12 Jun 2025 14:16:13 +0000 (UTC)
Date: Thu, 12 Jun 2025 10:16:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller\"   <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard   Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>"@web.codeaurora.org
Subject: [PATCH] xdp: tracing: Hide some xdp events under CONFIG_BPF_SYSCALL
Message-ID: <20250612101612.3d4509cc@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 11D9520034
X-Rspamd-Server: rspamout08
X-Stat-Signature: 9hqsohk4k1swyaj4fneziy7xjpjeeea7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PXqm3lbcNbcwLPE/xFkUYzq26klDeJnA=
X-HE-Tag: 1749737773-116136
X-HE-Meta: U2FsdGVkX1/tmg2kusMKmWbH1yjUBWpNH4f4UUEmC1N4NlxI7UViqR/toP2SUNhWAharn5P649W28JDDyCeLq7qlCG7XlNQxYd/QGrH16eGCHUihy8alNT19WNh8+YFazlEQ80OnbeatjLvUplnZ/TF0WU95/zNrkftoizE5jU+/XY2k9uFVx7miw7uOdLtF68merSbsWeAbRnkYPrgOE4UQOgPQSbLJaNPjzGwYRvfbHwum6pD/b4Q5x8+GdQsE2jTZr4g2ym9m964e2mSizgO8E2WA+o36FjROQEIS9Phe9xAexS3VwoVleCCMLon7Eq5ReW06OsmxtiN6vGTSPoxy6JD+UvtoUcnFoOVv6LRDgKrJmWejjg8q56V65x4G

From: Steven Rostedt <rostedt@goodmis.org>

The events xdp_cpumap_kthread, xdp_cpumap_enqueue and xdp_devmap_xmit are
only called when CONFIG_BPF_SYSCALL is defined.  As each event can take up
to 5K regardless if they are used or not, it's best not to define them
when they are not used. Add #ifdef around these events when they are not
used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I will be adding code soon that will make unused events cause a waring.

 include/trace/events/xdp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index 0fe0893c2567..18c0ac514fcb 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -168,6 +168,7 @@ DEFINE_EVENT(xdp_redirect_template, xdp_redirect_err,
 #define _trace_xdp_redirect_map_err(dev, xdp, to, map_type, map_id, index, err) \
 	 trace_xdp_redirect_err(dev, xdp, to, err, map_type, map_id, index)
 
+#ifdef CONFIG_BPF_SYSCALL
 TRACE_EVENT(xdp_cpumap_kthread,
 
 	TP_PROTO(int map_id, unsigned int processed,  unsigned int drops,
@@ -281,6 +282,7 @@ TRACE_EVENT(xdp_devmap_xmit,
 		  __entry->sent, __entry->drops,
 		  __entry->err)
 );
+#endif /* CONFIG_BPF_SYSCALL */
 
 /* Expect users already include <net/xdp.h>, but not xdp_priv.h */
 #include <net/xdp_priv.h>
-- 
2.47.2


