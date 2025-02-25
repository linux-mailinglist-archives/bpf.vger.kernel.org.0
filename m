Return-Path: <bpf+bounces-52584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5821EA45016
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA9519C43FD
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DD4215F65;
	Tue, 25 Feb 2025 22:26:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E5214803;
	Tue, 25 Feb 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522374; cv=none; b=Ju+yCuVXI99nJesJcbnISHkaSBRlZGtvNvov3/xDiX0ZL7tWwZhPDVlU104nhdmjSmoQPrk1xQY0uMrxn1mW1uEK4fuu2yoz6JH5AoJ3BmTY7YiopAeslwP5O7LH28t2FZ5Lq6v6d5NUMms1XfHrn/ab8E13zaK8nUC9PXtI4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522374; c=relaxed/simple;
	bh=hWweZgKdfZikXRAiePO+25+q5jfijM1HiOLlPaRwrjg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=TO5AYx3jKzEOasYT+L8KwXYhsNMuQR7Ab7mb6KUa2+03jmY8DLzdxzZMjS0vVFcLqDS8lCrWoI20WCs3gLpMNyeo03gEqPQp8GksRcCzj9d80uhtYkEHHv9gmKkAmd+/k3bWG67rGW34Vc968Z/TWtqC9a6hlIiRwamabOadjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39890C4CEDD;
	Tue, 25 Feb 2025 22:26:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tn3O9-00000009CIB-2Clv;
	Tue, 25 Feb 2025 17:26:53 -0500
Message-ID: <20250225222601.423129938@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 17:26:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
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
 Zheng Yejian <zhengyejian@huaweicloud.com>,
 bpf@vger.kernel.org
Subject: [PATCH v3 0/4] ftrace: Add function arguments to function tracers
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
 include/linux/ftrace_regs.h          |   5 ++
 kernel/trace/Kconfig                 |  12 +++
 kernel/trace/trace.c                 |  12 ++-
 kernel/trace/trace.h                 |   4 +-
 kernel/trace/trace_entries.h         |  12 +--
 kernel/trace/trace_functions.c       |  46 ++++++++--
 kernel/trace/trace_functions_graph.c | 170 ++++++++++++++++++++++++++++-------
 kernel/trace/trace_irqsoff.c         |   4 +-
 kernel/trace/trace_output.c          | 103 ++++++++++++++++++++-
 kernel/trace/trace_output.h          |   9 ++
 kernel/trace/trace_sched_wakeup.c    |   4 +-
 11 files changed, 328 insertions(+), 53 deletions(-)

