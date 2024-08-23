Return-Path: <bpf+bounces-37968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDE95D49C
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46692B21EAE
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904FF190473;
	Fri, 23 Aug 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs6snLh1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178DC18EFDC;
	Fri, 23 Aug 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435084; cv=none; b=H0KaRkvHAqt/T2eZuJ69RIdAVzrokLh/03Hiy9kryhx1P1SERVeiHnftKRJe2fv0Lc2IApJSwgChDkX99JbZBsaRqyigbOIR/mnzDez4Pu+FzA0K9yPiO5tPWBfx3uEy7Hb7qavPA1YMycJM1Wtz1xRWTrZKhk1n4lHr+YaVr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435084; c=relaxed/simple;
	bh=hS8aDAS4ebFyCbHWUnKdeLoA0brh4WMji37bEyfVej8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gIn5xAoGd2WL1JallgaJwWbZYwcCgWoc8A8soU1mirBhl6VRR/koDdPGPFhp23zkwvSFamTXca6JHumYqdJ7p8AXZx0JydcG8wIzmFR4QKT4O8f/5nrHXTB/WVr31SxbCG5Z3S8DI8rTONCLwM2uhxAp7XsWqSFQGmlPbXimRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs6snLh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07F7C4AF0C;
	Fri, 23 Aug 2024 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724435083;
	bh=hS8aDAS4ebFyCbHWUnKdeLoA0brh4WMji37bEyfVej8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zs6snLh1lyKVamMgVu3tcKCFwsfIugJ1LUxKp4tsMQcO/oaq5mWQomrdRn5mbqCLx
	 m6FUGv3VvPDuRoMrP2OnAWPjWfDX3t0nSgew8gm2qDdBYMQisiww2GyVUmWLAePaLd
	 WDyKh/gjPHwcr5eTpxDaljrTQY2bZYS6+6o1dj1ROziI5TVrMIV1THYjgZ5XMXXEjs
	 0G4VBL009t80/5gdaX8Rr44y2OzDPgY3mz1fVo5qUGN8ZA0PS/4PFFQUeRolvl1Y4I
	 9Lc/MwV7HsgCEO2nI2hmcRMkUXJqNq/3g+zy+1721ne3BsHhLGGZf4sUM6AtH+SIg5
	 CU4P1LjXjd9aA==
Date: Sat, 24 Aug 2024 02:44:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tianyi Liu <i.pear@outlook.com>, Oleg Nesterov <oleg@redhat.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 flaniel@linux.microsoft.com, albancrequy@linux.microsoft.com,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-Id: <20240824024439.a37c41bab87dbdf3d0486846@kernel.org>
In-Reply-To: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 21:53:00 +0800
Tianyi Liu <i.pear@outlook.com> wrote:

> U(ret)probes are designed to be filterable using the PID, which is the
> second parameter in the perf_event_open syscall. Currently, uprobe works
> well with the filtering, but uretprobe is not affected by it. This often
> leads to users being disturbed by events from uninterested processes while
> using uretprobe.
> 
> We found that the filter function was not invoked when uretprobe was
> initially implemented, and this has been existing for ten years. We have
> tested the patch under our workload, binding eBPF programs to uretprobe
> tracepoints, and confirmed that it resolved our problem.

Is this eBPF related problem? It seems only perf record is also affected.
Let me try.


> 
> Following are the steps to reproduce the issue:
> 
> Step 1. Compile the following reproducer program:
> ```
> 
> int main() {
>     printf("pid: %d\n", getpid());
>     while (1) {
>         sleep(2);
>         void *ptr = malloc(1024);
>         free(ptr);
>     }
> }
> ```
> We will then use uretprobe to trace the `malloc` function.

OK, and run perf probe to add an event on malloc's return.

$ sudo ~/bin/perf probe -x ./malloc-run --add malloc%return  
Added new event:
  probe_malloc:malloc__return (on malloc%return in /home/mhiramat/ksrc/linux/malloc-run)

You can now use it in all perf tools, such as:

	perf record -e probe_malloc:malloc__return -aR sleep 1

> 
> Step 2. Run two instances of the reproducer program and record their PIDs.

$ ./malloc-run &  ./malloc-run &
[1] 93927
[2] 93928
pid: 93927
pid: 93928

And trace one of them;

$ sudo ~/bin/perf trace record -e probe_malloc:malloc__return  -p 93928
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.031 MB perf.data (9 samples) ]

And dump the data;

$ sudo ~/bin/perf script
      malloc-run   93928 [004] 351736.730649:       raw_syscalls:sys_exit: NR 230 = 0
      malloc-run   93928 [004] 351736.730694: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
      malloc-run   93928 [004] 351736.730696:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
      malloc-run   93928 [004] 351738.730857:       raw_syscalls:sys_exit: NR 230 = 0
      malloc-run   93928 [004] 351738.730869: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
      malloc-run   93928 [004] 351738.730883:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
      malloc-run   93928 [004] 351740.731110:       raw_syscalls:sys_exit: NR 230 = 0
      malloc-run   93928 [004] 351740.731125: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
      malloc-run   93928 [004] 351740.731127:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,

Hmm, it seems to trace one pid data. (without this change)
If this changes eBPF behavior, I would like to involve eBPF people to ask
this is OK. As far as from the viewpoint of perf tool, current code works.

But I agree that current code is a bit strange. Oleg, do you know anything?

Thank you,

> 
> Step 3. Use uretprobe to trace each of the two running reproducers
> separately. We use bpftrace to make it easier to reproduce. Please run two
> instances of bpftrace simultaneously: the first instance filters events
> from PID1, and the second instance filters events from PID2.
> 
> The expected behavior is that each bpftrace instance would only print
> events matching its respective PID filter. However, in practice, both
> bpftrace instances receive events from both processes, the PID filter is
> ineffective at this moment:
> 
> Before:
> ```
> PID1=55256
> bpftrace -p $PID1 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
> Attaching 1 probe...
> time=0 pid=55256
> time=2 pid=55273
> time=2 pid=55256
> time=4 pid=55273
> time=4 pid=55256
> time=6 pid=55273
> time=6 pid=55256
> 
> PID2=55273
> bpftrace -p $PID2 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
> Attaching 1 probe...
> time=0 pid=55273
> time=0 pid=55256
> time=2 pid=55273
> time=2 pid=55256
> time=4 pid=55273
> time=4 pid=55256
> time=6 pid=55273
> time=6 pid=55256
> ```
> 
> After: Both bpftrace instances will show the expected behavior, only
> printing events from the PID specified by their respective filters:
> ```
> PID1=1621
> bpftrace -p $PID1 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
> Attaching 1 probe...
> time=0 pid=1621
> time=2 pid=1621
> time=4 pid=1621
> time=6 pid=1621
> 
> PID2=1633
> bpftrace -p $PID2 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
> Attaching 1 probe...
> time=0 pid=1633
> time=2 pid=1633
> time=4 pid=1633
> time=6 pid=1633
> ```
> 
> Fixes: c1ae5c75e103 ("uprobes/tracing: Introduce is_ret_probe() and uretprobe_dispatcher()")
> Cc: Alban Crequy <albancrequy@linux.microsoft.com>
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> ---
> Changes in v2:
> - Drop cover letter and update commit message.
> - Link to v1: https://lore.kernel.org/linux-trace-kernel/ME0P300MB04166144CDF92A72B9E1BAEA9D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM/
> ---
>  kernel/trace/trace_uprobe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c98e3b3386ba..c7e2a0962928 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1443,6 +1443,9 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
>  				struct pt_regs *regs,
>  				struct uprobe_cpu_buffer **ucbp)
>  {
> +	if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
> +		return;
> +
>  	__uprobe_perf_func(tu, func, regs, ucbp);
>  }
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

