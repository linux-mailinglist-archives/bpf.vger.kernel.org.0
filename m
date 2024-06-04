Return-Path: <bpf+bounces-31371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C057F8FBC6A
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 21:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755252868E0
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE114AD30;
	Tue,  4 Jun 2024 19:18:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C50801;
	Tue,  4 Jun 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528703; cv=none; b=kJc+3aa5Ps+Y1gfOl93ukpICF1rE4w1eKwr1nYkVtyxc9R/OQaoxK3fDwL3xVceGFdpq647Uz9srn+2k3KcKns7Ie+IYXQZptb13ASUdylCD+bSX9MHkVL0i0zy7hENFRzmAT/Oh8fHLJ19woyNdyA+IdXzjgM6NdBw9fqWjGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528703; c=relaxed/simple;
	bh=XngVXlaW0L7tH68pFG/Glx9+GjRa4NOjVuZqlf21XUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K98cPWovZ5nlECNzbEWVG4K065bGigu00ad355kdmYuSAi6ISc6/EYxDq88UaStKqGVIyopSX+1FakYldh0NeXHSs1tCyrUsMPuA67rahs8I64BCV3urionkPCZggjZtecpjJh9JRzPy59kOYpH19le4GSNGjpvt3hIdb8dpeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F561C2BBFC;
	Tue,  4 Jun 2024 19:18:21 +0000 (UTC)
Date: Tue, 4 Jun 2024 15:18:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 00/27] function_graph: Allow multiple users for
 function graph tracing
Message-ID: <20240604151821.5694e908@gandalf.local.home>
In-Reply-To: <20240604145742.5703d074@gandalf.local.home>
References: <20240603190704.663840775@goodmis.org>
	<20240604081850.59267aa9@rorschach.local.home>
	<Zl8oWNhkEPleJ3B_@J2N7QTR9R3>
	<20240604123124.456d19cf@gandalf.local.home>
	<Zl9JFnzKGuUM10X2@J2N7QTR9R3>
	<20240604145742.5703d074@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 14:57:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Bah, I just ran the test.d/ftrace/func-filter-pid.tc and it fails too. This
> did pass my other tests that do run ftracetests. Hmm, I just ran it on my
> test box that does the tests and it passes there. I wonder if there's some
> config option that makes it fail :-/
> 
> Well, now that I see it fail, I can investigate.

Ah, figured it out. The updated pid test isn't working. This explains why
my test machine didn't fail, as it doesn't have the updated ftracetests.

The problem was that I never set the funcgraph-proc option, even though I
saved it :-p

That is, it shows:

> 	+ cat trace
> 	# tracer: function_graph
> 	#
> 	# CPU  DURATION                  FUNCTION CALLS
> 	# |     |   |                     |   |   |   |
> 	 3) ! 143.685 us  |  kernel_clone();
> 	 3) ! 127.055 us  |  kernel_clone();
> 	 1) ! 127.170 us  |  kernel_clone();
> 	 3) ! 126.840 us  |  kernel_clone();

But when you do: echo 1 > options/funcgraph-proc

You get:

# cat trace
# tracer: function_graph
#
# CPU  TASK/PID         DURATION                  FUNCTION CALLS
# |     |    |           |   |                     |   |   |   |
 4)    bash-939    | # 1070.009 us |  kernel_clone();
 4)    bash-939    | # 1116.903 us |  kernel_clone();
 5)    bash-939    | ! 976.133 us  |  kernel_clone();
 5)    bash-939    | ! 954.012 us  |  kernel_clone();
 5)    bash-939    | ! 905.825 us  |  kernel_clone();
 5)    bash-939    | # 1130.922 us |  kernel_clone();
 7)    bash-939    | # 1097.648 us |  kernel_clone();
 0)    bash-939    | # 1008.000 us |  kernel_clone();
 3)    bash-939    | # 1023.391 us |  kernel_clone();
 4)    bash-939    | # 1033.008 us |  kernel_clone();
 4)    bash-939    | ! 949.072 us  |  kernel_clone();
 4)    bash-939    | # 1027.990 us |  kernel_clone();
 4)    bash-939    | ! 954.678 us  |  kernel_clone();
 4)    bash-939    | ! 996.557 us  |  kernel_clone();

Without that option, function graph does no show what process is being
recorded (except at sched switch)

Can you add this patch to the test and see if it works again?

-- Steve

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index c6fc9d31a496..8dcce001881d 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -8,6 +8,7 @@
 # Also test it on an instance directory
 
 do_function_fork=1
+do_funcgraph_proc=1
 
 if [ ! -f options/function-fork ]; then
     do_function_fork=0
@@ -28,6 +29,7 @@ fi
 
 if [ $do_funcgraph_proc -eq 1 ]; then
     orig_value2=`cat options/funcgraph-proc`
+    echo 1 > options/funcgraph-proc
 fi
 
 do_reset() {

