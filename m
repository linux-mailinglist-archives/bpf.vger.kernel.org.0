Return-Path: <bpf+bounces-52789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF8A48857
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E8A1886225
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5326B2CF;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D91D4335;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682659; cv=none; b=T1T3LOvp/qCM6bVRG9DuxJwwucosp0Vw4rxx2NecUdsJwUxlh18NE6/hb9bZ7Wkl5dJvoI1XJz7PCnPXMGOVJJ+GjgjVu4KAhge9vRrRcJkYI4na2KfbUo0yr3/XidTHoFA2d1OF3W99HzHhfCk0xnRHG/X0LO1kbzNItriVWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682659; c=relaxed/simple;
	bh=m+2s+O4tHRelC89taiEqdahnzEKvH/ygc+ZUyR8XqpI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=PWrqG5B7LqmJpnlIv31uKzi1MNLJwLYLXXFT8pajYZVZGUEbMgGr6npiyzE2Nv2VnbVl1NocrhtLCOKB17j/MW1S9f0AfwId8yuxHiDNx9VEGo1jaQbBo2DzocatkWizE5tQVTZwj51eCmu9YxmAn1JHSmD+buOudxYCMQihBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3597C4CEDD;
	Thu, 27 Feb 2025 18:57:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tnj5S-00000009nQY-2Z1Q;
	Thu, 27 Feb 2025 13:58:22 -0500
Message-ID: <20250227185804.639525399@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 27 Feb 2025 13:58:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 Donglin Peng <dolinux.peng@gmail.com>,
 Zheng Yejian <zhengyejian@huaweicloud.com>
Subject: [PATCH v4 0/4] ftrace: Add function arguments to function tracers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


These patches add support for printing function arguments in ftrace.

Example usage:

function tracer:

 ~# cd /sys/kernel/tracing/
 ~# echo icmp_rcv >set_ftrace_filter
 ~# echo function >current_tracer
 ~# echo 1 >options/func-args
 ~# ping -c 10 127.0.0.1
[..]
 ~# cat trace
[..]
            ping-1277    [030] ..s1.    39.120939: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    39.120946: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    40.179724: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    40.179730: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    41.219700: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    41.219706: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    42.259717: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    42.259725: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    43.299735: icmp_rcv(skb=0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    43.299742: icmp_rcv(skb=0xa0ecac00) <-ip_protocol_deliver_rcu

function graph:

 ~# cd /sys/kernel/tracing
 ~# echo icmp_rcv >set_graph_function
 ~# echo function_graph >current_tracer
 ~# echo 1 >options/funcgraph-args

 ~# ping -c 1 127.0.0.1

 ~# cat trace

 30)               |  icmp_rcv(skb=0xa0ecab00) {
 30)               |    __skb_checksum_complete(skb=0xa0ecab00) {
 30)               |      skb_checksum(skb=0xa0ecab00, offset=0, len=64, csum=0) {
 30)               |        __skb_checksum(skb=0xa0ecab00, offset=0, len=64, csum=0, ops=0x232e0327a88) {
 30)   0.418 us    |          csum_partial(buff=0xa0d20924, len=64, sum=0)
 30)   0.985 us    |        }
 30)   1.463 us    |      }
 30)   2.039 us    |    }
[..]

This was last posted by Sven Schnelle here:

  https://lore.kernel.org/all/20240904065908.1009086-1-svens@linux.ibm.com/

As Sven hasn't worked on it since, I decided to continue to push it
through. I'm keeping Sven as original author and added myself as
"Co-developed-by".

Changes since v3: https://lore.kernel.org/linux-trace-kernel/20250225222601.423129938@goodmis.org/

- kernel test robot flagged that this broke builds of archictecuters
  that do not support function args access.
  This was due to missing #ifdefs around calls of functions those archs
  do not implement.

- For archs that do not support function graph tracer, the irqsoff trace
  uses trace_function, but that now has a new parameter.

- Here's the diff between v3 and this series:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 86d828b9dc7c..cb13c88abfd6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2895,10 +2895,12 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
 	entry->ip			= ip;
 	entry->parent_ip		= parent_ip;
 
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	if (fregs) {
 		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
 			entry->args[i] = ftrace_regs_get_argument(fregs, i);
 	}
+#endif
 
 	if (static_branch_unlikely(&trace_function_exports_enabled))
 		ftrace_exports(event, TRACE_EXPORT_FUNCTION);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 472ec5d623db..32da87f45010 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -21,6 +21,7 @@
 #include <linux/workqueue.h>
 #include <linux/ctype.h>
 #include <linux/once_lite.h>
+#include <linux/ftrace_regs.h>
 
 #include "pid_list.h"
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 49fcf665cb58..71b2fb068b6b 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -132,10 +132,12 @@ static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
 	entry = ring_buffer_event_data(event);
 	entry->graph_ent = *trace;
 
+#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	if (fregs) {
 		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
 			entry->args[i] = ftrace_regs_get_argument(fregs, i);
 	}
+#endif
 
 	trace_buffer_unlock_commit_nostack(buffer, event);
 
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 0ce00fe66d0c..c8bfa7310a91 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -299,7 +299,13 @@ __trace_function(struct trace_array *tr,
 }
 
 #else
-#define __trace_function trace_function
+static inline void
+__trace_function(struct trace_array *tr,
+		 unsigned long ip, unsigned long parent_ip,
+		 unsigned int trace_ctx)
+{
+	return trace_function(tr, ip, parent_ip, trace_ctx, NULL);
+}
 
 static enum print_line_t irqsoff_print_line(struct trace_iterator *iter)
 {

Changes since v2: https://lore.kernel.org/linux-trace-kernel/20241223201347.609298489@goodmis.org/

- Removed unneeded headers

- Put back removed '\n' that was accidentally erased.

- Do not use bpf_get_btf_vmlinux() to get btf element as
  btf_find_func_proto() will handle that.

- Fixed how structures are printed

Changes since Sven's work:

- Made the kconfig option unconditional if all the dependencies are set.

- Not save ftrace_regs in the ring buffer, as that is an abstract
  descriptor defined by the architectures and should remain opaque from
  generic code. Instead, the args are read at the time they are recorded
  (with the ftrace_regs passed to the callback function), and saved into
  the ring buffer. Then the print function only takes an array of elements.

  This could allow archs to retrieve arguments that are on the stack where
  as, post processing ftrace_regs could cause undesirable results.

- Made the function and function graph entry events dynamically sized
  to allow the arguments to be appended to the event in the ring buffer.
  The print function only looks to see if the event saved in the ring
  buffer is big enough to hold all the arguments defined by the new
  FTRACE_REGS_MAX_ARGS macro and if so, it will assume there are arguments
  there and print them. This also means user space will not break on
  reading these events as arguments will simply be ignored.

- The printing of the arguments has some more data when things are not
  processed by BPF. Any unsupported argument will have the type printed
  out in the ring buffer. 

- Also removed the spaces around the '=' as that's more in line to how
  trace events show their fields.

- One new patch I added to convert function graph tracing over to using
  args as soon as the user sets the option even if function graph tracing
  is enabled. Function tracer did this already by default.



Steven Rostedt (1):
      ftrace: Have funcgraph-args take affect during tracing

Sven Schnelle (3):
      ftrace: Add print_function_args()
      ftrace: Add support for function argument to graph tracer
      ftrace: Add arguments to function tracer

----
 include/linux/ftrace_regs.h          |   5 +
 kernel/trace/Kconfig                 |  12 +++
 kernel/trace/trace.c                 |  14 ++-
 kernel/trace/trace.h                 |   5 +-
 kernel/trace/trace_entries.h         |  12 ++-
 kernel/trace/trace_functions.c       |  46 +++++++++-
 kernel/trace/trace_functions_graph.c | 172 ++++++++++++++++++++++++++++-------
 kernel/trace/trace_irqsoff.c         |  12 ++-
 kernel/trace/trace_output.c          | 103 ++++++++++++++++++++-
 kernel/trace/trace_output.h          |   9 ++
 kernel/trace/trace_sched_wakeup.c    |   4 +-
 11 files changed, 340 insertions(+), 54 deletions(-)

