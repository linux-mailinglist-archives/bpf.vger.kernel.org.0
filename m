Return-Path: <bpf+bounces-28265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FD8B7739
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44491B240CA
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E78172BA6;
	Tue, 30 Apr 2024 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCBwz7fg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43516F859;
	Tue, 30 Apr 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483945; cv=none; b=J1A2gU+QnWsbDbt4lDMLxY2OX6zsdbAFKYMSgcylm5iQd1iL+pvYj0XA90yrfvKVm7A9Tyshu4i7yYAQ9f3fWVIV7vKiy3dLaTKI9aH9pfkP6B3CzF3+XEtnuCc50HkgSg877a+zWoDlhhxIUHFfODmnTnc+bcMOLV5hzVeT0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483945; c=relaxed/simple;
	bh=wyDJMUTZPL5uI5tYJ86AduY+B27x3qfkHV/6cDciiq4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hQhsn/x9V6fX4oHz68L2GuvL/R58siSW9cngS/UOfhMD8P4CGZ6KnfDJudh0bPWj60fqcLJkAAuQO9Vr+yFbg/FZ4FHFwR78Hlr99C/+0mncl/HRMTqKkHNZ3Ed7kcOLLu0Kens+gc5AhkPWmb1wd74niDMGP647w+mhahzgil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCBwz7fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE99C2BBFC;
	Tue, 30 Apr 2024 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714483944;
	bh=wyDJMUTZPL5uI5tYJ86AduY+B27x3qfkHV/6cDciiq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YCBwz7fgZUlTOTceFBYnTYX0i6bS/P7GQ5cLE673Eb2pkGj4ohXI7r2sVl2KBYjhp
	 FEHiat2/t9O1FeRhW4UerE83yEyESSEDF3Lddth05v9ssylEA7AxUSMbCffOjhMjXD
	 cCmYL9sl4zZeH/ccosmcVqY/K3J4XdxuEMp8vZSNVgGFZkB2zicb8Lg8lSayUATwp6
	 grqqXiQBIKAES2gFh2xAm+o7e8gsVO1mPWcwNFV23n81w1t2QgngCcEeXO6XbDKRr+
	 uUMalSAo0dk8diyWZxvTE8tJvw5es5o3HKrW97sjUI1s6tg/W8wlspHh2OEFlj6PXJ
	 qHvb4JKeiVy0w==
Date: Tue, 30 Apr 2024 22:32:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240430223217.fd375d57d130a4207be18e94@kernel.org>
In-Reply-To: <CAEf4BzZDqD4fyLpoq9r2M0HnES7aO7YW=ZNH-k8uPJWd_VbAJg@mail.gmail.com>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
	<CAEf4BzYMToveELxsOJ9dXz3H-9omhxRLKgGK-ppYvmK8pgDsfA@mail.gmail.com>
	<20240429225119.410833c12d9f6fbcce0a58db@kernel.org>
	<CAEf4BzZDqD4fyLpoq9r2M0HnES7aO7YW=ZNH-k8uPJWd_VbAJg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__30_Apr_2024_22_32_17_+0900_=oAZJzDQAmDqi/.B"

This is a multi-part message in MIME format.

--Multipart=_Tue__30_Apr_2024_22_32_17_+0900_=oAZJzDQAmDqi/.B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 29 Apr 2024 13:25:04 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Apr 29, 2024 at 6:51 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Andrii,
> >
> > On Thu, 25 Apr 2024 13:31:53 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > Hey Masami,
> > >
> > > I can't really review most of that code as I'm completely unfamiliar
> > > with all those inner workings of fprobe/ftrace/function_graph. I left
> > > a few comments where there were somewhat more obvious BPF-related
> > > pieces.
> > >
> > > But I also did run our BPF benchmarks on probes/for-next as a baseline
> > > and then with your series applied on top. Just to see if there are any
> > > regressions. I think it will be a useful data point for you.
> >
> > Thanks for testing!
> >
> > >
> > > You should be already familiar with the bench tool we have in BPF
> > > selftests (I used it on some other patches for your tree).
> >
> > What patches we need?
> >
> 
> You mean for this `bench` tool? They are part of BPF selftests (under
> tools/testing/selftests/bpf), you can build them by running:
> 
> $ make RELEASE=1 -j$(nproc) bench
> 
> After that you'll get a self-container `bench` binary, which has all
> the self-contained benchmarks.
> 
> You might also find a small script (benchs/run_bench_trigger.sh inside
> BPF selftests directory) helpful, it collects final summary of the
> benchmark run and optionally accepts a specific set of benchmarks. So
> you can use it like this:
> 
> $ benchs/run_bench_trigger.sh kprobe kprobe-multi
> kprobe         :   18.731 ± 0.639M/s
> kprobe-multi   :   23.938 ± 0.612M/s
> 
> By default it will run a wider set of benchmarks (no uprobes, but a
> bunch of extra fentry/fexit tests and stuff like this).

origin:
# benchs/run_bench_trigger.sh 
kretprobe :    1.329 ± 0.007M/s 
kretprobe-multi:    1.341 ± 0.004M/s 
# benchs/run_bench_trigger.sh 
kretprobe :    1.288 ± 0.014M/s 
kretprobe-multi:    1.365 ± 0.002M/s 
# benchs/run_bench_trigger.sh 
kretprobe :    1.329 ± 0.002M/s 
kretprobe-multi:    1.331 ± 0.011M/s 
# benchs/run_bench_trigger.sh 
kretprobe :    1.311 ± 0.003M/s 
kretprobe-multi:    1.318 ± 0.002M/s s

patched: 

# benchs/run_bench_trigger.sh
kretprobe :    1.274 ± 0.003M/s 
kretprobe-multi:    1.397 ± 0.002M/s 
# benchs/run_bench_trigger.sh
kretprobe :    1.307 ± 0.002M/s 
kretprobe-multi:    1.406 ± 0.004M/s 
# benchs/run_bench_trigger.sh
kretprobe :    1.279 ± 0.004M/s 
kretprobe-multi:    1.330 ± 0.014M/s 
# benchs/run_bench_trigger.sh
kretprobe :    1.256 ± 0.010M/s 
kretprobe-multi:    1.412 ± 0.003M/s 

Hmm, in my case, it seems smaller differences (~3%?).
I attached perf report results for those, but I don't see large difference.

> > >
> > > BASELINE
> > > ========
> > > kprobe         :   24.634 ± 0.205M/s
> > > kprobe-multi   :   28.898 ± 0.531M/s
> > > kretprobe      :   10.478 ± 0.015M/s
> > > kretprobe-multi:   11.012 ± 0.063M/s
> > >
> > > THIS PATCH SET ON TOP
> > > =====================
> > > kprobe         :   25.144 ± 0.027M/s (+2%)
> > > kprobe-multi   :   28.909 ± 0.074M/s
> > > kretprobe      :    9.482 ± 0.008M/s (-9.5%)
> > > kretprobe-multi:   13.688 ± 0.027M/s (+24%)
> >
> > This looks good. Kretprobe should also use kretprobe-multi (fprobe)
> > eventually because it should be a single callback version of
> > kretprobe-multi.

I ran another benchmark (prctl loop, attached), the origin kernel result is here;

# sh ./benchmark.sh 
count = 10000000, took 6.748133 sec

And the patched kernel result;

# sh ./benchmark.sh 
count = 10000000, took 6.644095 sec

I confirmed that the parf result has no big difference.

Thank you,


> >
> > >
> > > These numbers are pretty stable and look to be more or less representative.
> > >
> > > As you can see, kprobes got a bit faster, kprobe-multi seems to be
> > > about the same, though.
> > >
> > > Then (I suppose they are "legacy") kretprobes got quite noticeably
> > > slower, almost by 10%. Not sure why, but looks real after re-running
> > > benchmarks a bunch of times and getting stable results.
> >
> > Hmm, kretprobe on x86 should use ftrace + rethook even with my series.
> > So nothing should be changed. Maybe cache access pattern has been
> > changed?
> > I'll check it with tracefs (to remove the effect from bpf related changes)
> >
> > >
> > > On the other hand, multi-kretprobes got significantly faster (+24%!).
> > > Again, I don't know if it is expected or not, but it's a nice
> > > improvement.
> >
> > Thanks!
> >
> > >
> > > If you have any idea why kretprobes would get so much slower, it would
> > > be nice to look into that and see if you can mitigate the regression
> > > somehow. Thanks!
> >
> > OK, let me check it.
> >
> > Thank you!
> >
> > >
> > >
> > > >  51 files changed, 2325 insertions(+), 882 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

--Multipart=_Tue__30_Apr_2024_22_32_17_+0900_=oAZJzDQAmDqi/.B
Content-Type: text/x-csrc;
 name="prctl_loop.c"
Content-Disposition: attachment;
 filename="prctl_loop.c"
Content-Transfer-Encoding: 7bit

#include <sys/prctl.h>
#include <unistd.h>
#include <sys/time.h>
#include <stdio.h>

int main(void)
{
	struct timeval tv1, tv2;
	unsigned long count = 0;

	gettimeofday(&tv1, NULL);
	do {
		prctl(PR_GET_DUMPABLE, 0, 0, 0, 0);
		count++;
	} while (count < 10000000);
	gettimeofday(&tv2, NULL);
	tv2.tv_sec -= tv1.tv_sec;
	if (tv2.tv_usec > tv1.tv_usec) {
		tv2.tv_usec -= tv1.tv_usec;
	} else {
		tv2.tv_usec = tv2.tv_usec + 1000000 - tv1.tv_usec;
		tv2.tv_sec--;
	}
	printf("count = %lu, took %ld.%06ld \n", count, tv2.tv_sec, tv2.tv_usec);
	return 0;
}


--Multipart=_Tue__30_Apr_2024_22_32_17_+0900_=oAZJzDQAmDqi/.B
Content-Type: text/plain;
 name="perf-out-kretprobe-nopatch.txt"
Content-Disposition: attachment;
 filename="perf-out-kretprobe-nopatch.txt"
Content-Transfer-Encoding: 7bit

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 32K of event 'task-clock:ppp'
# Event count (approx.): 8035250000
#
# Children      Self  Command  Shared Object                                      Symbol                                               
# ........  ........  .......  .................................................  .....................................................
#
    99.56%     0.00%  bench    libc.so.6                                          [.] start_thread
            |
            ---start_thread
               |          
               |--97.95%--syscall
               |          |          
               |          |--58.91%--entry_SYSCALL_64_after_hwframe
               |          |          do_syscall_64
               |          |          |          
               |          |          |--19.61%--__x64_sys_getpgid
               |          |          |          |          
               |          |          |          |--11.69%--0xffffffffa02050de
               |          |          |          |          kprobe_ftrace_handler
               |          |          |          |          |          
               |          |          |          |          |--6.26%--pre_handler_kretprobe
               |          |          |          |          |          |          
               |          |          |          |          |          |--3.29%--objpool_pop
               |          |          |          |          |          |          
               |          |          |          |          |           --1.97%--rethook_try_get
               |          |          |          |          |          
               |          |          |          |          |--2.41%--rcu_is_watching
               |          |          |          |          |          
               |          |          |          |           --0.93%--get_kprobe
               |          |          |          |          
               |          |          |           --5.59%--do_getpgid
               |          |          |                     |          
               |          |          |                      --4.85%--find_task_by_vpid
               |          |          |                                |          
               |          |          |                                |--2.01%--idr_find
               |          |          |                                |          
               |          |          |                                 --1.42%--__radix_tree_lookup
               |          |          |          
               |          |          |--14.68%--arch_rethook_trampoline
               |          |          |          |          
               |          |          |           --12.96%--arch_rethook_trampoline_callback
               |          |          |                     |          
               |          |          |                      --12.69%--rethook_trampoline_handler
               |          |          |                                |          
               |          |          |                                |--10.89%--kretprobe_rethook_handler
               |          |          |                                |          |          
               |          |          |                                |           --9.80%--kretprobe_dispatcher
               |          |          |                                |                     |          
               |          |          |                                |                      --6.85%--kretprobe_perf_func
               |          |          |                                |                                |          
               |          |          |                                |                                 --6.57%--trace_call_bpf
               |          |          |                                |                                           |          
               |          |          |                                |                                           |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
               |          |          |                                |                                           |          
               |          |          |                                |                                            --0.67%--migrate_disable
               |          |          |                                |          
               |          |          |                                 --0.88%--objpool_push
               |          |          |          
               |          |           --0.56%--syscall_exit_to_user_mode
               |          |          
               |           --4.50%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
               |          
                --1.50%--syscall@plt

    98.00%    34.25%  bench    libc.so.6                                          [.] syscall
            |          
            |--63.76%--syscall
            |          |          
            |          |--58.97%--entry_SYSCALL_64_after_hwframe
            |          |          do_syscall_64
            |          |          |          
            |          |          |--19.61%--__x64_sys_getpgid
            |          |          |          |          
            |          |          |          |--11.69%--0xffffffffa02050de
            |          |          |          |          kprobe_ftrace_handler
            |          |          |          |          |          
            |          |          |          |          |--6.26%--pre_handler_kretprobe
            |          |          |          |          |          |          
            |          |          |          |          |          |--3.29%--objpool_pop
            |          |          |          |          |          |          
            |          |          |          |          |           --1.97%--rethook_try_get
            |          |          |          |          |          
            |          |          |          |          |--2.41%--rcu_is_watching
            |          |          |          |          |          
            |          |          |          |           --0.93%--get_kprobe
            |          |          |          |          
            |          |          |           --5.59%--do_getpgid
            |          |          |                     |          
            |          |          |                      --4.85%--find_task_by_vpid
            |          |          |                                |          
            |          |          |                                |--2.01%--idr_find
            |          |          |                                |          
            |          |          |                                 --1.42%--__radix_tree_lookup
            |          |          |          
            |          |          |--14.68%--arch_rethook_trampoline
            |          |          |          |          
            |          |          |           --12.96%--arch_rethook_trampoline_callback
            |          |          |                     |          
            |          |          |                      --12.69%--rethook_trampoline_handler
            |          |          |                                |          
            |          |          |                                |--10.89%--kretprobe_rethook_handler
            |          |          |                                |          |          
            |          |          |                                |           --9.80%--kretprobe_dispatcher
            |          |          |                                |                     |          
            |          |          |                                |                      --6.85%--kretprobe_perf_func
            |          |          |                                |                                |          
            |          |          |                                |                                 --6.57%--trace_call_bpf
            |          |          |                                |                                           |          
            |          |          |                                |                                           |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          |          |                                |                                           |          
            |          |          |                                |                                            --0.67%--migrate_disable
            |          |          |                                |          
            |          |          |                                 --0.88%--objpool_push
            |          |          |          
            |          |           --0.56%--syscall_exit_to_user_mode
            |          |          
            |           --4.50%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          
             --34.25%--start_thread
                       syscall

    59.08%     0.00%  bench    [kernel.kallsyms]                                  [k] entry_SYSCALL_64_after_hwframe
            |
            ---entry_SYSCALL_64_after_hwframe
               do_syscall_64
               |          
               |--19.61%--__x64_sys_getpgid
               |          |          
               |          |--11.69%--0xffffffffa02050de
               |          |          kprobe_ftrace_handler
               |          |          |          
               |          |          |--6.26%--pre_handler_kretprobe
               |          |          |          |          
               |          |          |          |--3.29%--objpool_pop
               |          |          |          |          
               |          |          |           --1.97%--rethook_try_get
               |          |          |          
               |          |          |--2.41%--rcu_is_watching
               |          |          |          
               |          |           --0.93%--get_kprobe
               |          |          
               |           --5.59%--do_getpgid
               |                     |          
               |                      --4.85%--find_task_by_vpid
               |                                |          
               |                                |--2.01%--idr_find
               |                                |          
               |                                 --1.42%--__radix_tree_lookup
               |          
               |--14.68%--arch_rethook_trampoline
               |          |          
               |           --12.96%--arch_rethook_trampoline_callback
               |                     |          
               |                      --12.69%--rethook_trampoline_handler
               |                                |          
               |                                |--10.89%--kretprobe_rethook_handler
               |                                |          |          
               |                                |           --9.80%--kretprobe_dispatcher
               |                                |                     |          
               |                                |                      --6.85%--kretprobe_perf_func
               |                                |                                |          
               |                                |                                 --6.57%--trace_call_bpf
               |                                |                                           |          
               |                                |                                           |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
               |                                |                                           |          
               |                                |                                            --0.67%--migrate_disable
               |                                |          
               |                                 --0.88%--objpool_push
               |          
                --0.56%--syscall_exit_to_user_mode

    59.08%    24.07%  bench    [kernel.kallsyms]                                  [k] do_syscall_64
            |          
            |--35.01%--do_syscall_64
            |          |          
            |          |--19.61%--__x64_sys_getpgid
            |          |          |          
            |          |          |--11.69%--0xffffffffa02050de
            |          |          |          kprobe_ftrace_handler
            |          |          |          |          
            |          |          |          |--6.26%--pre_handler_kretprobe
            |          |          |          |          |          
            |          |          |          |          |--3.29%--objpool_pop
            |          |          |          |          |          
            |          |          |          |           --1.97%--rethook_try_get
            |          |          |          |          
            |          |          |          |--2.41%--rcu_is_watching
            |          |          |          |          
            |          |          |           --0.93%--get_kprobe
            |          |          |          
            |          |           --5.59%--do_getpgid
            |          |                     |          
            |          |                      --4.85%--find_task_by_vpid
            |          |                                |          
            |          |                                |--2.01%--idr_find
            |          |                                |          
            |          |                                 --1.42%--__radix_tree_lookup
            |          |          
            |          |--14.68%--arch_rethook_trampoline
            |          |          |          
            |          |           --12.96%--arch_rethook_trampoline_callback
            |          |                     |          
            |          |                      --12.69%--rethook_trampoline_handler
            |          |                                |          
            |          |                                |--10.89%--kretprobe_rethook_handler
            |          |                                |          |          
            |          |                                |           --9.80%--kretprobe_dispatcher
            |          |                                |                     |          
            |          |                                |                      --6.85%--kretprobe_perf_func
            |          |                                |                                |          
            |          |                                |                                 --6.57%--trace_call_bpf
            |          |                                |                                           |          
            |          |                                |                                           |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          |                                |                                           |          
            |          |                                |                                            --0.67%--migrate_disable
            |          |                                |          
            |          |                                 --0.88%--objpool_push
            |          |          
            |           --0.56%--syscall_exit_to_user_mode
            |          
             --24.06%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64

    19.66%     0.21%  bench    [kernel.kallsyms]                                  [k] __x64_sys_getpgid
            |          
             --19.44%--__x64_sys_getpgid
                       |          
                       |--11.74%--0xffffffffa02050de
                       |          kprobe_ftrace_handler
                       |          |          
                       |          |--6.30%--pre_handler_kretprobe
                       |          |          |          
                       |          |          |--3.29%--objpool_pop
                       |          |          |          
                       |          |           --1.97%--rethook_try_get
                       |          |          
                       |          |--2.41%--rcu_is_watching
                       |          |          
                       |           --0.93%--get_kprobe
                       |          
                        --5.59%--do_getpgid
                                  |          
                                   --4.85%--find_task_by_vpid
                                             |          
                                             |--2.01%--idr_find
                                             |          
                                              --1.42%--__radix_tree_lookup

    14.71%     1.75%  bench    [kernel.kallsyms]                                  [k] arch_rethook_trampoline
            |          
            |--12.96%--arch_rethook_trampoline
            |          |          
            |           --12.96%--arch_rethook_trampoline_callback
            |                     |          
            |                      --12.69%--rethook_trampoline_handler
            |                                |          
            |                                |--10.89%--kretprobe_rethook_handler
            |                                |          |          
            |                                |           --9.80%--kretprobe_dispatcher
            |                                |                     |          
            |                                |                      --6.85%--kretprobe_perf_func
            |                                |                                |          
            |                                |                                 --6.57%--trace_call_bpf
            |                                |                                           |          
            |                                |                                           |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |                                |                                           |          
            |                                |                                            --0.67%--migrate_disable
            |                                |          
            |                                 --0.88%--objpool_push
            |          
             --1.75%--start_thread
                       syscall
                       |          
                        --1.71%--entry_SYSCALL_64_after_hwframe
                                  do_syscall_64
                                  arch_rethook_trampoline

    12.96%     0.27%  bench    [kernel.kallsyms]                                  [k] arch_rethook_trampoline_callback
            |          
             --12.69%--arch_rethook_trampoline_callback
                       rethook_trampoline_handler
                       |          
                       |--10.89%--kretprobe_rethook_handler
                       |          |          
                       |           --9.80%--kretprobe_dispatcher
                       |                     |          
                       |                      --6.85%--kretprobe_perf_func
                       |                                |          
                       |                                 --6.57%--trace_call_bpf
                       |                                           |          
                       |                                           |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
                       |                                           |          
                       |                                            --0.67%--migrate_disable
                       |          
                        --0.88%--objpool_push

    12.69%     0.88%  bench    [kernel.kallsyms]                                  [k] rethook_trampoline_handler
            |          
            |--11.81%--rethook_trampoline_handler
            |          |          
            |          |--10.89%--kretprobe_rethook_handler
            |          |          |          
            |          |           --9.80%--kretprobe_dispatcher
            |          |                     |          
            |          |                      --6.85%--kretprobe_perf_func
            |          |                                |          
            |          |                                 --6.57%--trace_call_bpf
            |          |                                           |          
            |          |                                           |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          |                                           |          
            |          |                                            --0.67%--migrate_disable
            |          |          
            |           --0.88%--objpool_push
            |          
             --0.88%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       arch_rethook_trampoline
                       arch_rethook_trampoline_callback
                       rethook_trampoline_handler

    11.74%     2.10%  bench    [kernel.kallsyms]                                  [k] kprobe_ftrace_handler
            |          
            |--9.64%--kprobe_ftrace_handler
            |          |          
            |          |--6.30%--pre_handler_kretprobe
            |          |          |          
            |          |          |--3.29%--objpool_pop
            |          |          |          
            |          |           --1.97%--rethook_try_get
            |          |          
            |          |--2.41%--rcu_is_watching
            |          |          
            |           --0.93%--get_kprobe
            |          
             --2.10%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       0xffffffffa02050de
                       kprobe_ftrace_handler

    11.74%     0.00%  bench    [unknown]                                          [k] 0xffffffffa02050de
            |
            ---0xffffffffa02050de
               kprobe_ftrace_handler
               |          
               |--6.30%--pre_handler_kretprobe
               |          |          
               |          |--3.29%--objpool_pop
               |          |          
               |           --1.97%--rethook_try_get
               |          
               |--2.41%--rcu_is_watching
               |          
                --0.93%--get_kprobe

    10.89%     1.09%  bench    [kernel.kallsyms]                                  [k] kretprobe_rethook_handler
            |          
            |--9.80%--kretprobe_rethook_handler
            |          kretprobe_dispatcher
            |          |          
            |           --6.85%--kretprobe_perf_func
            |                     |          
            |                      --6.57%--trace_call_bpf
            |                                |          
            |                                |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |                                |          
            |                                 --0.67%--migrate_disable
            |          
             --1.09%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       arch_rethook_trampoline
                       arch_rethook_trampoline_callback
                       rethook_trampoline_handler
                       kretprobe_rethook_handler

     9.80%     2.94%  bench    [kernel.kallsyms]                                  [k] kretprobe_dispatcher
            |          
            |--6.86%--kretprobe_dispatcher
            |          |          
            |           --6.85%--kretprobe_perf_func
            |                     |          
            |                      --6.57%--trace_call_bpf
            |                                |          
            |                                |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |                                |          
            |                                 --0.67%--migrate_disable
            |          
             --2.94%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       arch_rethook_trampoline
                       arch_rethook_trampoline_callback
                       rethook_trampoline_handler
                       kretprobe_rethook_handler
                       kretprobe_dispatcher

     6.94%     6.93%  bench    bpf_prog_21856463590f61f1_bench_trigger_kretprobe  [k] bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          
             --6.93%--start_thread
                       syscall
                       |          
                       |--4.49%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
                       |          
                        --2.44%--entry_SYSCALL_64_after_hwframe
                                  do_syscall_64
                                  arch_rethook_trampoline
                                  arch_rethook_trampoline_callback
                                  rethook_trampoline_handler
                                  kretprobe_rethook_handler
                                  kretprobe_dispatcher
                                  kretprobe_perf_func
                                  trace_call_bpf
                                  bpf_prog_21856463590f61f1_bench_trigger_kretprobe

     6.85%     0.28%  bench    [kernel.kallsyms]                                  [k] kretprobe_perf_func
            |          
             --6.57%--kretprobe_perf_func
                       trace_call_bpf
                       |          
                       |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
                       |          
                        --0.67%--migrate_disable

     6.57%     2.91%  bench    [kernel.kallsyms]                                  [k] trace_call_bpf
            |          
            |--3.67%--trace_call_bpf
            |          |          
            |          |--2.44%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          |          
            |           --0.67%--migrate_disable
            |          
             --2.91%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       arch_rethook_trampoline
                       arch_rethook_trampoline_callback
                       rethook_trampoline_handler
                       kretprobe_rethook_handler
                       kretprobe_dispatcher
                       kretprobe_perf_func
                       trace_call_bpf

     6.30%     0.81%  bench    [kernel.kallsyms]                                  [k] pre_handler_kretprobe
            |          
            |--5.49%--pre_handler_kretprobe
            |          |          
            |          |--3.29%--objpool_pop
            |          |          
            |           --1.97%--rethook_try_get
            |          
             --0.81%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       0xffffffffa02050de
                       kprobe_ftrace_handler
                       pre_handler_kretprobe

     5.59%     0.27%  bench    [kernel.kallsyms]                                  [k] do_getpgid
            |          
             --5.32%--do_getpgid
                       |          
                        --4.85%--find_task_by_vpid
                                  |          
                                  |--2.01%--idr_find
                                  |          
                                   --1.42%--__radix_tree_lookup

     4.85%     1.39%  bench    [kernel.kallsyms]                                  [k] find_task_by_vpid
            |          
            |--3.46%--find_task_by_vpid
            |          |          
            |          |--2.01%--idr_find
            |          |          
            |           --1.42%--__radix_tree_lookup
            |          
             --1.39%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       do_getpgid
                       find_task_by_vpid

     3.29%     3.29%  bench    [kernel.kallsyms]                                  [k] objpool_pop
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               0xffffffffa02050de
               kprobe_ftrace_handler
               pre_handler_kretprobe
               objpool_pop

     2.55%     2.55%  bench    [kernel.kallsyms]                                  [k] rcu_is_watching
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               0xffffffffa02050de
               kprobe_ftrace_handler
               |          
                --2.41%--rcu_is_watching

     2.01%     2.01%  bench    [kernel.kallsyms]                                  [k] idr_find
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               do_getpgid
               find_task_by_vpid
               idr_find

     1.97%     1.83%  bench    [kernel.kallsyms]                                  [k] rethook_try_get
            |          
             --1.83%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       0xffffffffa02050de
                       kprobe_ftrace_handler
                       pre_handler_kretprobe
                       rethook_try_get

     1.50%     1.50%  bench    bench                                              [.] syscall@plt
            |
            ---start_thread
               syscall@plt

     1.42%     1.42%  bench    [kernel.kallsyms]                                  [k] __radix_tree_lookup
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               do_getpgid
               find_task_by_vpid
               __radix_tree_lookup

     0.93%     0.93%  bench    [kernel.kallsyms]                                  [k] get_kprobe
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               0xffffffffa02050de
               kprobe_ftrace_handler
               get_kprobe

     0.88%     0.88%  bench    [kernel.kallsyms]                                  [k] objpool_push
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               arch_rethook_trampoline
               arch_rethook_trampoline_callback
               rethook_trampoline_handler
               objpool_push

     0.67%     0.67%  bench    [kernel.kallsyms]                                  [k] migrate_disable
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               arch_rethook_trampoline
               arch_rethook_trampoline_callback
               rethook_trampoline_handler
               kretprobe_rethook_handler
               kretprobe_dispatcher
               kretprobe_perf_func
               trace_call_bpf
               migrate_disable

     0.56%     0.56%  bench    [kernel.kallsyms]                                  [k] syscall_exit_to_user_mode
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               syscall_exit_to_user_mode

     0.45%     0.45%  bench    [kernel.kallsyms]                                  [k] __rcu_read_lock
     0.44%     0.44%  bench    [unknown]                                          [k] 0xffffffffa0205005
     0.39%     0.39%  bench    [kernel.kallsyms]                                  [k] migrate_enable
     0.36%     0.36%  bench    [unknown]                                          [k] 0xffffffffa020515d
     0.30%     0.00%  bench    libc.so.6                                          [.] __libc_start_call_main
     0.30%     0.00%  bench    bench                                              [.] main
     0.30%     0.00%  bench    bench                                              [.] setup_benchmark
     0.30%     0.00%  bench    bench                                              [.] trigger_kretprobe_setup
     0.27%     0.27%  bench    [unknown]                                          [k] 0xffffffffa0205011
     0.27%     0.00%  bench    bench                                              [.] trigger_bench__open_and_load
     0.27%     0.00%  bench    bench                                              [.] bpf_object__load_skeleton
     0.27%     0.00%  bench    bench                                              [.] bpf_object__load
     0.27%     0.00%  bench    bench                                              [.] bpf_object_load
     0.23%     0.15%  bench    [kernel.kallsyms]                                  [k] rethook_hook
     0.22%     0.00%  bench    bench                                              [.] bpf_object__load_vmlinux_btf
     0.22%     0.00%  bench    bench                                              [.] libbpf_find_kernel_btf
     0.22%     0.00%  bench    bench                                              [.] btf__parse
     0.22%     0.00%  bench    bench                                              [.] btf_parse
     0.22%     0.00%  bench    bench                                              [.] btf_parse_raw
     0.21%     0.21%  bench    [kernel.kallsyms]                                  [k] __x86_indirect_thunk_array
     0.20%     0.20%  bench    [unknown]                                          [k] 0xffffffffa0205000
     0.18%     0.18%  bench    [kernel.kallsyms]                                  [k] __rcu_read_unlock
     0.16%     0.16%  bench    [unknown]                                          [k] 0xffffffffa020506c
     0.16%     0.01%  bench    [kernel.kallsyms]                                  [k] do_user_addr_fault
     0.16%     0.00%  bench    [kernel.kallsyms]                                  [k] asm_exc_page_fault
     0.16%     0.00%  bench    [kernel.kallsyms]                                  [k] exc_page_fault
     0.14%     0.00%  bench    [kernel.kallsyms]                                  [k] handle_mm_fault
     0.14%     0.00%  bench    [kernel.kallsyms]                                  [k] __handle_mm_fault
     0.14%     0.00%  bench    [kernel.kallsyms]                                  [k] do_anonymous_page
     0.13%     0.00%  bench    [kernel.kallsyms]                                  [k] vma_alloc_folio
     0.13%     0.02%  bench    libc.so.6                                          [.] __memmove_sse2_unaligned_erms
     0.12%     0.00%  bench    [kernel.kallsyms]                                  [k] alloc_pages_mpol
     0.12%     0.00%  bench    [kernel.kallsyms]                                  [k] __alloc_pages
     0.12%     0.00%  bench    [kernel.kallsyms]                                  [k] get_page_from_freelist
     0.12%     0.12%  bench    [kernel.kallsyms]                                  [k] clear_page_orig
     0.11%     0.11%  bench    bench                                              [.] trigger_producer
     0.10%     0.00%  bench    bench                                              [.] btf_new
     0.08%     0.08%  bench    [kernel.kallsyms]                                  [k] arch_rethook_prepare
     0.07%     0.00%  bench    [unknown]                                          [k] 0000000000000000
     0.07%     0.00%  bench    bench                                              [.] btf_sanity_check
     0.07%     0.07%  bench    [unknown]                                          [k] 0xffffffffa020508e
     0.07%     0.01%  bench    libc.so.6                                          [.] read
     0.06%     0.02%  bench    bench                                              [.] btf_validate_type
     0.05%     0.05%  bench    [unknown]                                          [k] 0xffffffffa02050e6
     0.05%     0.05%  bench    [unknown]                                          [k] 0xffffffffa020507f
     0.05%     0.05%  bench    [unknown]                                          [k] 0xffffffffa0205150
     0.05%     0.00%  bench    [kernel.kallsyms]                                  [k] ksys_read
     0.05%     0.00%  bench    [kernel.kallsyms]                                  [k] vfs_read
     0.05%     0.00%  bench    [kernel.kallsyms]                                  [k] kernfs_file_read_iter
     0.04%     0.04%  bench    [unknown]                                          [k] 0xffffffffa0205016
     0.04%     0.04%  bench    [unknown]                                          [k] 0xffffffffa020513c
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] _copy_to_iter
     0.04%     0.01%  bench    [kernel.kallsyms]                                  [k] rep_movs_alternative
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_modify_all_code
     0.04%     0.04%  bench    [kernel.kallsyms]                                  [k] arch_rethook_fixup_return
     0.04%     0.04%  bench    [unknown]                                          [k] 0xffffffffa02050ad
     0.04%     0.03%  bench    [kernel.kallsyms]                                  [k] radix_tree_lookup
     0.04%     0.04%  bench    [unknown]                                          [k] 0xffffffffa0205116
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] 0xffffffff8108da38
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] do_group_exit
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] do_exit
     0.03%     0.03%  bench    [kernel.kallsyms]                                  [k] __do_softirq
     0.03%     0.03%  bench    [unknown]                                          [k] 0xffffffffa0205020
     0.03%     0.03%  bench    [unknown]                                          [k] 0xffffffffa02050cc
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] asm_sysvec_apic_timer_interrupt
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] sysvec_apic_timer_interrupt
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] irq_exit_rcu
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] task_work_run
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] __fput
     0.03%     0.03%  bench    [unknown]                                          [k] 0xffffffffa020512b
     0.03%     0.00%  bench    bench                                              [.] feat_supported
     0.03%     0.00%  bench    bench                                              [.] sys_bpf_fd
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] __x64_sys_bpf
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] __sys_bpf
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_load
     0.03%     0.00%  bench    bench                                              [.] btf_parse_type_sec
     0.03%     0.03%  bench    [unknown]                                          [k] 0xffffffffa020509e
     0.03%     0.03%  bench    [unknown]                                          [k] 0xffffffffa0205102
     0.02%     0.02%  bench    [unknown]                                          [k] 0xffffffffa020502a
     0.02%     0.02%  bench    [unknown]                                          [k] 0xffffffffa02050bc
     0.02%     0.02%  bench    [kernel.kallsyms]                                  [k] smp_call_function_many_cond
     0.02%     0.00%  bench    bench                                              [.] bpf_program__attach
     0.02%     0.00%  bench    bench                                              [.] attach_kprobe
     0.02%     0.00%  bench    bench                                              [.] bpf_program__attach_kprobe_opts
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __do_sys_perf_event_open
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_event_alloc
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_release
     0.02%     0.01%  bench    bench                                              [.] btf__type_by_id
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_event_release_kernel
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_init_event
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] _free_event
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_try_init_event
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_kprobe_destroy
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_kprobe_event_init
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_kprobe_init
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_trace_event_unreg.isra.0
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_select_runtime
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] disable_trace_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __disable_trace_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_int_jit_compile
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_jit_binary_pack_alloc
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] disable_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __disable_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_pack_alloc
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __disarm_kprobe_ftrace
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] alloc_new_pack
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] unregister_ftrace_function
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_shutdown.part.0
     0.02%     0.01%  bench    [kernel.kallsyms]                                  [k] ftrace_replace_code
     0.02%     0.00%  bench    bench                                              [.] bpf_object__probe_loading
     0.02%     0.00%  bench    bench                                              [.] bump_rlimit_memlock
     0.02%     0.01%  bench    bench                                              [.] btf_validate_id
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_trace_event_init
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_trace_event_reg
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] enable_trace_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] enable_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __arm_kprobe_ftrace
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] register_ftrace_function
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] register_ftrace_function_nolock
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_startup
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] on_each_cpu_cond_mask
     0.02%     0.02%  bench    [kernel.kallsyms]                                  [k] memset_orig
     0.02%     0.00%  bench    bench                                              [.] probe_memcg_account
     0.02%     0.02%  bench    bench                                              [.] btf_type_by_id
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_update_ftrace_func
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] text_poke_bp
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] text_poke_bp_batch
     0.02%     0.02%  bench    [unknown]                                          [k] 0xffffffffa0205004
     0.02%     0.02%  bench    [unknown]                                          [k] 0xffffffffa0205038
     0.02%     0.02%  bench    [unknown]                                          [k] 0xffffffffa0205050
     0.02%     0.00%  bench    bench                                              [.] bpf_object__load_progs
     0.02%     0.00%  bench    bench                                              [.] bpf_object_load_prog
     0.02%     0.00%  bench    bench                                              [.] btf_add_type_idx_entry
     0.01%     0.01%  bench    bench                                              [.] btf_kind
     0.01%     0.01%  bench    [unknown]                                          [k] 0xffffffffa020503b
     0.01%     0.01%  bench    [unknown]                                          [k] 0xffffffffa0205058
     0.01%     0.00%  bench    bench                                              [.] sys_bpf_prog_load
     0.01%     0.00%  bench    bench                                              [.] btf_add_type_offs_mem
     0.01%     0.00%  bench    bench                                              [.] btf_validate_str
     0.01%     0.01%  bench    bench                                              [.] btf_type_size
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] _raw_spin_unlock_irqrestore
     0.01%     0.00%  bench    bench                                              [.] libbpf_prepare_prog_load
     0.01%     0.00%  bench    bench                                              [.] libbpf_find_attach_btf_id
     0.01%     0.00%  bench    bench                                              [.] find_kernel_btf_id
     0.01%     0.00%  bench    bench                                              [.] find_attach_btf_id
     0.01%     0.00%  bench    bench                                              [.] find_btf_by_prefix_kind
     0.01%     0.00%  bench    bench                                              [.] btf__find_by_name_kind
     0.01%     0.00%  bench    bench                                              [.] btf_find_by_name_kind
     0.01%     0.01%  bench    [unknown]                                          [k] 0xffffffffa020502f
     0.01%     0.00%  bench    bench                                              [.] kernel_supports
     0.01%     0.00%  bench    ld-linux-x86-64.so.2                               [.] _dl_map_object
     0.01%     0.00%  bench    ld-linux-x86-64.so.2                               [.] __GI___open64_nocancel
     0.01%     0.00%  bench    libc.so.6                                          [.] __memset_sse2_unaligned_erms
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __x64_sys_openat
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] do_sys_openat2
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] do_filp_open
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] path_openat
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_rpc
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] ftrace_rec_iter_record
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] kmem_cache_alloc
     0.01%     0.01%  bench    [unknown]                                          [k] 0xffffffffa0205025
     0.01%     0.01%  bench    [unknown]                                          [k] 0xffffffffa0205040
     0.01%     0.00%  bench    bench                                              [.] bpf_object__sanitize_maps
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] _raw_spin_lock
     0.01%     0.00%  bench    bench                                              [.] probe_kern_array_mmap
     0.01%     0.00%  bench    bench                                              [.] bpf_map_create
     0.01%     0.00%  bench    bench                                              [.] probe_kern_prog_name
     0.01%     0.01%  bench    bench                                              [.] btf__str_by_offset
     0.01%     0.01%  bench    bench                                              [.] btf_vlen
     0.01%     0.00%  bench    bench                                              [.] bpf_prog_load
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] lock_mm_and_find_vma
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] zap_pte_range
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] set_memory_rox
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] change_page_attr_set_clr
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __change_page_attr_set_clr
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] do_open
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] do_dentry_open
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] v9fs_file_open
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __change_page_attr
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __pte_offset_map_lock
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __vmalloc_node_range
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] unmap_vmas
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __vmalloc_area_node
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] unmap_page_range
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_virtio_request
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] lookup_address_in_pgd
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] vmap_pages_pte_range
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_rec_iter_next
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __alloc_pages_bulk
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] default_send_IPI_allbutself
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_lookup_ip
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] insn_get_prefixes.part.0
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] rmqueue
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] in_lock_functions
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_check_record
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_test_record
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mas_walk
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __mod_memcg_lruvec_state
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] kmem_cache_alloc_lru
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_output_begin
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] iput
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mas_alloc_nodes
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] memcpy_orig
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] tmigr_handle_remote
     0.00%     0.00%  bench    bench                                              [.] bpf_object__relocate
     0.00%     0.00%  bench    bench                                              [.] btf_strs_data
     0.00%     0.00%  bench    bench                                              [.] bpf_program_fixup_func_info
     0.00%     0.00%  bench    bench                                              [.] libbpf_add_mem
     0.00%     0.00%  bench    bench                                              [.] probe_kern_arg_ctx_tag
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] zap_present_ptes
     0.00%     0.00%  bench    [unknown]                                          [k] 0xffffffffa0205089
     0.00%     0.00%  bench    libc.so.6                                          [.] _int_realloc
     0.00%     0.00%  bench    [unknown]                                          [k] 0x31392e3033202820
     0.00%     0.00%  bench    libc.so.6                                          [.] __GI___libc_write
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] create_local_trace_kprobe
     0.00%     0.00%  bench    libc.so.6                                          [.] __munmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] register_kretprobe
     0.00%     0.00%  bench    libc.so.6                                          [.] __brk
     0.00%     0.00%  bench    libc.so.6                                          [.] clone3
     0.00%     0.00%  bench    libc.so.6                                          [.] __strcmp_sse2
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ksys_write
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] register_kprobe
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __x64_sys_munmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_alloc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_release
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] check_kprobe_address_safe
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] exit_mm
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] vfs_write
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __do_sys_brk
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __do_sys_clone3
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __vm_munmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_alloc_no_stats
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_put_deferred
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] cpa_process_alias
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] file_tty_write.constprop.0
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] jump_label_text_reserved
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mmput
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] open_last_lookups
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __vmalloc_node
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] arch_jump_entry_size
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] do_brk_flags
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] do_vmi_align_munmap.constprop.0
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] exit_mmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] idr_alloc_cyclic
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] iterate_tty_write
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] kernel_clone
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] lookup_open.isra.0
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] module_alloc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_event_bpf_event
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] v9fs_dir_release
     0.00%     0.00%  bench    bench                                              [.] collect_measurements
     0.00%     0.00%  bench    libc.so.6                                          [.] __strnlen_ifunc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] copy_process
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] d_alloc_parallel
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] idr_alloc_u32
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] insn_decode
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mas_store_gfp
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] n_tty_write
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_clunk
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_open
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_walk
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_iterate_sb
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] unmap_region
     0.00%     0.00%  bench    [unknown]                                          [.] 0x0000000000000040
     0.00%     0.00%  bench    libc.so.6                                          [.] __mpn_extract_double
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __split_large_page
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] d_alloc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] dput
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] dup_task_struct
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] find_vma
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] idr_get_free
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] insn_get_displacement
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mas_wr_bnode
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_iterate_ctx
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] process_output_block
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] wp_page_copy
     0.00%     0.00%  bench    bench                                              [.] bpf_object__open_skeleton
     0.00%     0.00%  bench    ld-linux-x86-64.so.2                               [.] _dl_sysdep_start
     0.00%     0.00%  bench    libc.so.6                                          [.] __restore_rt
     0.00%     0.00%  bench    [unknown]                                          [.] 0x000055e503ff7c50
     0.00%     0.00%  bench    libc.so.6                                          [.] _IO_file_xsgetn
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __anon_vma_prepare
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __d_alloc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __dentry_kill
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __ftrace_hash_rec_update.part.0
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __lruvec_stat_mod_folio
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] alloc_pages_bulk_array_mempolicy
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] alloc_thread_stack_node
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] btf_vmlinux_read
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] insn_get_modrm
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] lock_vma_under_rcu
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mas_split.isra.0
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mt_find
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_event_bpf_output
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] preempt_count_add
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] prepare_to_wait_event
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] radix_tree_node_alloc.constprop.0
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] smp_call_function
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] uart_write
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] vmap_small_pages_range_noflush
     0.00%     0.00%  bench    bench                                              [.] populate_skeleton_progs
     0.00%     0.00%  bench    bench                                              [.] sigalarm_handler
     0.00%     0.00%  bench    ld-linux-x86-64.so.2                               [.] dl_main
     0.00%     0.00%  bench    libc.so.6                                          [.] __vfprintf_internal


#
# (Tip: Show individual samples with: perf script)
#

--Multipart=_Tue__30_Apr_2024_22_32_17_+0900_=oAZJzDQAmDqi/.B
Content-Type: text/plain;
 name="perf-out-kretprobe-patched.txt"
Content-Disposition: attachment;
 filename="perf-out-kretprobe-patched.txt"
Content-Transfer-Encoding: 7bit

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 32K of event 'task-clock:ppp'
# Event count (approx.): 8042250000
#
# Children      Self  Command  Shared Object                                      Symbol                                               
# ........  ........  .......  .................................................  .....................................................
#
    99.52%     0.00%  bench    libc.so.6                                          [.] start_thread
            |
            ---start_thread
               |          
               |--97.57%--syscall
               |          |          
               |          |--59.31%--entry_SYSCALL_64_after_hwframe
               |          |          do_syscall_64
               |          |          |          
               |          |          |--19.37%--__x64_sys_getpgid
               |          |          |          |          
               |          |          |          |--12.79%--ftrace_trampoline
               |          |          |          |          |          
               |          |          |          |           --10.73%--kprobe_ftrace_handler
               |          |          |          |                     |          
               |          |          |          |                     |--6.03%--pre_handler_kretprobe
               |          |          |          |                     |          |          
               |          |          |          |                     |          |--3.10%--objpool_pop
               |          |          |          |                     |          |          
               |          |          |          |                     |           --1.86%--rethook_try_get
               |          |          |          |                     |          
               |          |          |          |                     |--2.00%--rcu_is_watching
               |          |          |          |                     |          
               |          |          |          |                      --0.50%--get_kprobe
               |          |          |          |          
               |          |          |           --6.29%--do_getpgid
               |          |          |                     |          
               |          |          |                      --5.54%--find_task_by_vpid
               |          |          |                                |          
               |          |          |                                |--2.01%--idr_find
               |          |          |                                |          
               |          |          |                                 --1.52%--__radix_tree_lookup
               |          |          |          
               |          |          |--13.87%--arch_rethook_trampoline
               |          |          |          |          
               |          |          |           --12.14%--arch_rethook_trampoline_callback
               |          |          |                     |          
               |          |          |                      --11.91%--rethook_trampoline_handler
               |          |          |                                |          
               |          |          |                                |--10.24%--kretprobe_rethook_handler
               |          |          |                                |          |          
               |          |          |                                |           --9.28%--kretprobe_dispatcher
               |          |          |                                |                     |          
               |          |          |                                |                      --6.35%--kretprobe_perf_func
               |          |          |                                |                                |          
               |          |          |                                |                                 --5.99%--trace_call_bpf
               |          |          |                                |                                           |          
               |          |          |                                |                                           |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
               |          |          |                                |                                           |          
               |          |          |                                |                                            --0.95%--migrate_disable
               |          |          |                                |          
               |          |          |                                 --0.95%--objpool_push
               |          |          |          
               |          |           --0.53%--syscall_exit_to_user_mode
               |          |          
               |           --4.37%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
               |          
                --1.75%--syscall@plt

    97.63%    33.61%  bench    libc.so.6                                          [.] syscall
            |          
            |--64.02%--syscall
            |          |          
            |          |--59.37%--entry_SYSCALL_64_after_hwframe
            |          |          do_syscall_64
            |          |          |          
            |          |          |--19.37%--__x64_sys_getpgid
            |          |          |          |          
            |          |          |          |--12.79%--ftrace_trampoline
            |          |          |          |          |          
            |          |          |          |           --10.73%--kprobe_ftrace_handler
            |          |          |          |                     |          
            |          |          |          |                     |--6.03%--pre_handler_kretprobe
            |          |          |          |                     |          |          
            |          |          |          |                     |          |--3.10%--objpool_pop
            |          |          |          |                     |          |          
            |          |          |          |                     |           --1.86%--rethook_try_get
            |          |          |          |                     |          
            |          |          |          |                     |--2.00%--rcu_is_watching
            |          |          |          |                     |          
            |          |          |          |                      --0.50%--get_kprobe
            |          |          |          |          
            |          |          |           --6.29%--do_getpgid
            |          |          |                     |          
            |          |          |                      --5.54%--find_task_by_vpid
            |          |          |                                |          
            |          |          |                                |--2.01%--idr_find
            |          |          |                                |          
            |          |          |                                 --1.52%--__radix_tree_lookup
            |          |          |          
            |          |          |--13.87%--arch_rethook_trampoline
            |          |          |          |          
            |          |          |           --12.14%--arch_rethook_trampoline_callback
            |          |          |                     |          
            |          |          |                      --11.91%--rethook_trampoline_handler
            |          |          |                                |          
            |          |          |                                |--10.24%--kretprobe_rethook_handler
            |          |          |                                |          |          
            |          |          |                                |           --9.28%--kretprobe_dispatcher
            |          |          |                                |                     |          
            |          |          |                                |                      --6.35%--kretprobe_perf_func
            |          |          |                                |                                |          
            |          |          |                                |                                 --5.99%--trace_call_bpf
            |          |          |                                |                                           |          
            |          |          |                                |                                           |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          |          |                                |                                           |          
            |          |          |                                |                                            --0.95%--migrate_disable
            |          |          |                                |          
            |          |          |                                 --0.95%--objpool_push
            |          |          |          
            |          |           --0.53%--syscall_exit_to_user_mode
            |          |          
            |           --4.37%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          
             --33.61%--start_thread
                       syscall

    59.54%     0.00%  bench    [kernel.kallsyms]                                  [k] entry_SYSCALL_64_after_hwframe
            |
            ---entry_SYSCALL_64_after_hwframe
               do_syscall_64
               |          
               |--19.37%--__x64_sys_getpgid
               |          |          
               |          |--12.79%--ftrace_trampoline
               |          |          |          
               |          |           --10.73%--kprobe_ftrace_handler
               |          |                     |          
               |          |                     |--6.03%--pre_handler_kretprobe
               |          |                     |          |          
               |          |                     |          |--3.10%--objpool_pop
               |          |                     |          |          
               |          |                     |           --1.86%--rethook_try_get
               |          |                     |          
               |          |                     |--2.00%--rcu_is_watching
               |          |                     |          
               |          |                      --0.50%--get_kprobe
               |          |          
               |           --6.29%--do_getpgid
               |                     |          
               |                      --5.54%--find_task_by_vpid
               |                                |          
               |                                |--2.01%--idr_find
               |                                |          
               |                                 --1.52%--__radix_tree_lookup
               |          
               |--13.87%--arch_rethook_trampoline
               |          |          
               |           --12.14%--arch_rethook_trampoline_callback
               |                     |          
               |                      --11.91%--rethook_trampoline_handler
               |                                |          
               |                                |--10.24%--kretprobe_rethook_handler
               |                                |          |          
               |                                |           --9.28%--kretprobe_dispatcher
               |                                |                     |          
               |                                |                      --6.35%--kretprobe_perf_func
               |                                |                                |          
               |                                |                                 --5.99%--trace_call_bpf
               |                                |                                           |          
               |                                |                                           |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
               |                                |                                           |          
               |                                |                                            --0.95%--migrate_disable
               |                                |          
               |                                 --0.95%--objpool_push
               |          
                --0.53%--syscall_exit_to_user_mode

    59.54%    25.54%  bench    [kernel.kallsyms]                                  [k] do_syscall_64
            |          
            |--34.00%--do_syscall_64
            |          |          
            |          |--19.37%--__x64_sys_getpgid
            |          |          |          
            |          |          |--12.79%--ftrace_trampoline
            |          |          |          |          
            |          |          |           --10.73%--kprobe_ftrace_handler
            |          |          |                     |          
            |          |          |                     |--6.03%--pre_handler_kretprobe
            |          |          |                     |          |          
            |          |          |                     |          |--3.10%--objpool_pop
            |          |          |                     |          |          
            |          |          |                     |           --1.86%--rethook_try_get
            |          |          |                     |          
            |          |          |                     |--2.00%--rcu_is_watching
            |          |          |                     |          
            |          |          |                      --0.50%--get_kprobe
            |          |          |          
            |          |           --6.29%--do_getpgid
            |          |                     |          
            |          |                      --5.54%--find_task_by_vpid
            |          |                                |          
            |          |                                |--2.01%--idr_find
            |          |                                |          
            |          |                                 --1.52%--__radix_tree_lookup
            |          |          
            |          |--13.87%--arch_rethook_trampoline
            |          |          |          
            |          |           --12.14%--arch_rethook_trampoline_callback
            |          |                     |          
            |          |                      --11.91%--rethook_trampoline_handler
            |          |                                |          
            |          |                                |--10.24%--kretprobe_rethook_handler
            |          |                                |          |          
            |          |                                |           --9.28%--kretprobe_dispatcher
            |          |                                |                     |          
            |          |                                |                      --6.35%--kretprobe_perf_func
            |          |                                |                                |          
            |          |                                |                                 --5.99%--trace_call_bpf
            |          |                                |                                           |          
            |          |                                |                                           |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          |                                |                                           |          
            |          |                                |                                            --0.95%--migrate_disable
            |          |                                |          
            |          |                                 --0.95%--objpool_push
            |          |          
            |           --0.53%--syscall_exit_to_user_mode
            |          
             --25.54%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64

    19.40%     0.29%  bench    [kernel.kallsyms]                                  [k] __x64_sys_getpgid
            |          
             --19.11%--__x64_sys_getpgid
                       |          
                       |--12.82%--ftrace_trampoline
                       |          |          
                       |           --10.76%--kprobe_ftrace_handler
                       |                     |          
                       |                     |--6.06%--pre_handler_kretprobe
                       |                     |          |          
                       |                     |          |--3.10%--objpool_pop
                       |                     |          |          
                       |                     |           --1.86%--rethook_try_get
                       |                     |          
                       |                     |--2.00%--rcu_is_watching
                       |                     |          
                       |                      --0.50%--get_kprobe
                       |          
                        --6.29%--do_getpgid
                                  |          
                                   --5.54%--find_task_by_vpid
                                             |          
                                             |--2.01%--idr_find
                                             |          
                                              --1.52%--__radix_tree_lookup

    13.91%     1.77%  bench    [kernel.kallsyms]                                  [k] arch_rethook_trampoline
            |          
            |--12.14%--arch_rethook_trampoline
            |          arch_rethook_trampoline_callback
            |          |          
            |           --11.91%--rethook_trampoline_handler
            |                     |          
            |                     |--10.24%--kretprobe_rethook_handler
            |                     |          |          
            |                     |           --9.28%--kretprobe_dispatcher
            |                     |                     |          
            |                     |                      --6.35%--kretprobe_perf_func
            |                     |                                |          
            |                     |                                 --5.99%--trace_call_bpf
            |                     |                                           |          
            |                     |                                           |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |                     |                                           |          
            |                     |                                            --0.95%--migrate_disable
            |                     |          
            |                      --0.95%--objpool_push
            |          
             --1.77%--start_thread
                       syscall
                       |          
                        --1.73%--entry_SYSCALL_64_after_hwframe
                                  do_syscall_64
                                  arch_rethook_trampoline

    12.82%     2.06%  bench    ftrace_trampoline                                  [k] ftrace_trampoline
            |          
            |--10.76%--ftrace_trampoline
            |          kprobe_ftrace_handler
            |          |          
            |          |--6.06%--pre_handler_kretprobe
            |          |          |          
            |          |          |--3.10%--objpool_pop
            |          |          |          
            |          |           --1.86%--rethook_try_get
            |          |          
            |          |--2.00%--rcu_is_watching
            |          |          
            |           --0.50%--get_kprobe
            |          
             --2.06%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       ftrace_trampoline

    12.14%     0.23%  bench    [kernel.kallsyms]                                  [k] arch_rethook_trampoline_callback
            |          
             --11.91%--arch_rethook_trampoline_callback
                       rethook_trampoline_handler
                       |          
                       |--10.24%--kretprobe_rethook_handler
                       |          |          
                       |           --9.28%--kretprobe_dispatcher
                       |                     |          
                       |                      --6.35%--kretprobe_perf_func
                       |                                |          
                       |                                 --5.99%--trace_call_bpf
                       |                                           |          
                       |                                           |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
                       |                                           |          
                       |                                            --0.95%--migrate_disable
                       |          
                        --0.95%--objpool_push

    11.91%     0.69%  bench    [kernel.kallsyms]                                  [k] rethook_trampoline_handler
            |          
            |--11.22%--rethook_trampoline_handler
            |          |          
            |          |--10.24%--kretprobe_rethook_handler
            |          |          |          
            |          |           --9.28%--kretprobe_dispatcher
            |          |                     |          
            |          |                      --6.35%--kretprobe_perf_func
            |          |                                |          
            |          |                                 --5.99%--trace_call_bpf
            |          |                                           |          
            |          |                                           |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          |                                           |          
            |          |                                            --0.95%--migrate_disable
            |          |          
            |           --0.95%--objpool_push
            |          
             --0.69%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       arch_rethook_trampoline
                       arch_rethook_trampoline_callback
                       rethook_trampoline_handler

    10.76%     2.20%  bench    [kernel.kallsyms]                                  [k] kprobe_ftrace_handler
            |          
            |--8.55%--kprobe_ftrace_handler
            |          |          
            |          |--6.06%--pre_handler_kretprobe
            |          |          |          
            |          |          |--3.10%--objpool_pop
            |          |          |          
            |          |           --1.86%--rethook_try_get
            |          |          
            |          |--2.00%--rcu_is_watching
            |          |          
            |           --0.50%--get_kprobe
            |          
             --2.20%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       ftrace_trampoline
                       kprobe_ftrace_handler

    10.24%     0.96%  bench    [kernel.kallsyms]                                  [k] kretprobe_rethook_handler
            |          
            |--9.28%--kretprobe_rethook_handler
            |          kretprobe_dispatcher
            |          |          
            |           --6.35%--kretprobe_perf_func
            |                     |          
            |                      --5.99%--trace_call_bpf
            |                                |          
            |                                |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |                                |          
            |                                 --0.95%--migrate_disable
            |          
             --0.96%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       arch_rethook_trampoline
                       arch_rethook_trampoline_callback
                       rethook_trampoline_handler
                       kretprobe_rethook_handler

     9.28%     2.85%  bench    [kernel.kallsyms]                                  [k] kretprobe_dispatcher
            |          
            |--6.43%--kretprobe_dispatcher
            |          |          
            |           --6.35%--kretprobe_perf_func
            |                     |          
            |                      --5.99%--trace_call_bpf
            |                                |          
            |                                |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |                                |          
            |                                 --0.95%--migrate_disable
            |          
             --2.85%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       arch_rethook_trampoline
                       arch_rethook_trampoline_callback
                       rethook_trampoline_handler
                       kretprobe_rethook_handler
                       kretprobe_dispatcher

     6.35%     0.36%  bench    [kernel.kallsyms]                                  [k] kretprobe_perf_func
            |          
             --5.99%--kretprobe_perf_func
                       trace_call_bpf
                       |          
                       |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
                       |          
                        --0.95%--migrate_disable

     6.29%     0.27%  bench    [kernel.kallsyms]                                  [k] do_getpgid
            |          
             --6.02%--do_getpgid
                       |          
                        --5.54%--find_task_by_vpid
                                  |          
                                  |--2.01%--idr_find
                                  |          
                                   --1.52%--__radix_tree_lookup

     6.23%     6.23%  bench    bpf_prog_21856463590f61f1_bench_trigger_kretprobe  [k] bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |
            ---start_thread
               syscall
               |          
               |--4.37%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
               |          
                --1.86%--entry_SYSCALL_64_after_hwframe
                          do_syscall_64
                          arch_rethook_trampoline
                          arch_rethook_trampoline_callback
                          rethook_trampoline_handler
                          kretprobe_rethook_handler
                          kretprobe_dispatcher
                          kretprobe_perf_func
                          trace_call_bpf
                          bpf_prog_21856463590f61f1_bench_trigger_kretprobe

     6.06%     0.89%  bench    [kernel.kallsyms]                                  [k] pre_handler_kretprobe
            |          
            |--5.17%--pre_handler_kretprobe
            |          |          
            |          |--3.10%--objpool_pop
            |          |          
            |           --1.86%--rethook_try_get
            |          
             --0.89%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       ftrace_trampoline
                       kprobe_ftrace_handler
                       pre_handler_kretprobe

     5.99%     2.67%  bench    [kernel.kallsyms]                                  [k] trace_call_bpf
            |          
            |--3.32%--trace_call_bpf
            |          |          
            |          |--1.86%--bpf_prog_21856463590f61f1_bench_trigger_kretprobe
            |          |          
            |           --0.95%--migrate_disable
            |          
             --2.67%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       arch_rethook_trampoline
                       arch_rethook_trampoline_callback
                       rethook_trampoline_handler
                       kretprobe_rethook_handler
                       kretprobe_dispatcher
                       kretprobe_perf_func
                       trace_call_bpf

     5.54%     1.97%  bench    [kernel.kallsyms]                                  [k] find_task_by_vpid
            |          
            |--3.57%--find_task_by_vpid
            |          |          
            |          |--2.01%--idr_find
            |          |          
            |           --1.52%--__radix_tree_lookup
            |          
             --1.97%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       do_getpgid
                       find_task_by_vpid

     3.10%     3.10%  bench    [kernel.kallsyms]                                  [k] objpool_pop
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               ftrace_trampoline
               kprobe_ftrace_handler
               pre_handler_kretprobe
               objpool_pop

     2.08%     2.08%  bench    [kernel.kallsyms]                                  [k] rcu_is_watching
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               ftrace_trampoline
               kprobe_ftrace_handler
               |          
                --2.00%--rcu_is_watching

     2.01%     2.01%  bench    [kernel.kallsyms]                                  [k] idr_find
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               do_getpgid
               find_task_by_vpid
               idr_find

     1.86%     1.78%  bench    [kernel.kallsyms]                                  [k] rethook_try_get
            |          
             --1.78%--start_thread
                       syscall
                       entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       __x64_sys_getpgid
                       ftrace_trampoline
                       kprobe_ftrace_handler
                       pre_handler_kretprobe
                       rethook_try_get

     1.75%     1.75%  bench    bench                                              [.] syscall@plt
            |
            ---start_thread
               syscall@plt

     1.52%     1.52%  bench    [kernel.kallsyms]                                  [k] __radix_tree_lookup
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               do_getpgid
               find_task_by_vpid
               __radix_tree_lookup

     0.95%     0.95%  bench    [kernel.kallsyms]                                  [k] objpool_push
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               arch_rethook_trampoline
               arch_rethook_trampoline_callback
               rethook_trampoline_handler
               objpool_push

     0.95%     0.95%  bench    [kernel.kallsyms]                                  [k] migrate_disable
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               arch_rethook_trampoline
               arch_rethook_trampoline_callback
               rethook_trampoline_handler
               kretprobe_rethook_handler
               kretprobe_dispatcher
               kretprobe_perf_func
               trace_call_bpf
               migrate_disable

     0.53%     0.53%  bench    [kernel.kallsyms]                                  [k] syscall_exit_to_user_mode
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               syscall_exit_to_user_mode

     0.50%     0.50%  bench    [kernel.kallsyms]                                  [k] get_kprobe
            |
            ---start_thread
               syscall
               entry_SYSCALL_64_after_hwframe
               do_syscall_64
               __x64_sys_getpgid
               ftrace_trampoline
               kprobe_ftrace_handler
               get_kprobe

     0.44%     0.44%  bench    [kernel.kallsyms]                                  [k] __rcu_read_lock
     0.35%     0.35%  bench    [kernel.kallsyms]                                  [k] migrate_enable
     0.29%     0.29%  bench    [kernel.kallsyms]                                  [k] __x86_indirect_thunk_array
     0.28%     0.00%  bench    libc.so.6                                          [.] __libc_start_call_main
     0.28%     0.00%  bench    bench                                              [.] main
     0.28%     0.00%  bench    bench                                              [.] setup_benchmark
     0.27%     0.00%  bench    bench                                              [.] trigger_kretprobe_setup
     0.25%     0.00%  bench    bench                                              [.] trigger_bench__open_and_load
     0.25%     0.00%  bench    bench                                              [.] bpf_object__load_skeleton
     0.25%     0.00%  bench    bench                                              [.] bpf_object__load
     0.25%     0.00%  bench    bench                                              [.] bpf_object_load
     0.21%     0.21%  bench    [kernel.kallsyms]                                  [k] __rcu_read_unlock
     0.20%     0.14%  bench    [kernel.kallsyms]                                  [k] rethook_hook
     0.20%     0.20%  bench    bench                                              [.] trigger_producer
     0.14%     0.00%  bench    [kernel.kallsyms]                                  [k] asm_exc_page_fault
     0.14%     0.00%  bench    [kernel.kallsyms]                                  [k] exc_page_fault
     0.14%     0.01%  bench    [kernel.kallsyms]                                  [k] do_user_addr_fault
     0.14%     0.00%  bench    bench                                              [.] libbpf_find_kernel_btf
     0.13%     0.00%  bench    bench                                              [.] bpf_object__load_vmlinux_btf
     0.13%     0.00%  bench    bench                                              [.] btf__parse
     0.13%     0.00%  bench    bench                                              [.] btf_parse
     0.13%     0.00%  bench    bench                                              [.] btf_parse_raw
     0.13%     0.00%  bench    [kernel.kallsyms]                                  [k] handle_mm_fault
     0.13%     0.00%  bench    [kernel.kallsyms]                                  [k] __handle_mm_fault
     0.11%     0.00%  bench    bench                                              [.] btf_new
     0.10%     0.00%  bench    [unknown]                                          [k] 0000000000000000
     0.10%     0.00%  bench    [kernel.kallsyms]                                  [k] do_anonymous_page
     0.10%     0.00%  bench    [kernel.kallsyms]                                  [k] get_page_from_freelist
     0.10%     0.00%  bench    libc.so.6                                          [.] read
     0.10%     0.00%  bench    [kernel.kallsyms]                                  [k] ksys_read
     0.10%     0.00%  bench    [kernel.kallsyms]                                  [k] vfs_read
     0.10%     0.00%  bench    [kernel.kallsyms]                                  [k] rep_movs_alternative
     0.10%     0.00%  bench    [kernel.kallsyms]                                  [k] __alloc_pages
     0.09%     0.00%  bench    [kernel.kallsyms]                                  [k] kernfs_file_read_iter
     0.09%     0.00%  bench    [kernel.kallsyms]                                  [k] _copy_to_iter
     0.09%     0.09%  bench    [kernel.kallsyms]                                  [k] clear_page_orig
     0.09%     0.00%  bench    [kernel.kallsyms]                                  [k] alloc_pages_mpol
     0.08%     0.00%  bench    [kernel.kallsyms]                                  [k] vma_alloc_folio
     0.07%     0.00%  bench    bench                                              [.] bpf_object__load_progs
     0.07%     0.00%  bench    bench                                              [.] bpf_object_load_prog
     0.07%     0.01%  bench    bench                                              [.] btf_sanity_check
     0.07%     0.00%  bench    bench                                              [.] libbpf_prepare_prog_load
     0.07%     0.00%  bench    bench                                              [.] libbpf_find_attach_btf_id
     0.07%     0.00%  bench    bench                                              [.] find_kernel_btf_id
     0.07%     0.00%  bench    bench                                              [.] find_attach_btf_id
     0.07%     0.00%  bench    bench                                              [.] find_btf_by_prefix_kind
     0.07%     0.00%  bench    bench                                              [.] btf__find_by_name_kind
     0.07%     0.07%  bench    [kernel.kallsyms]                                  [k] arch_rethook_prepare
     0.06%     0.01%  bench    bench                                              [.] btf_validate_type
     0.06%     0.02%  bench    bench                                              [.] btf_find_by_name_kind
     0.05%     0.05%  bench    [kernel.kallsyms]                                  [k] _raw_spin_unlock_irqrestore
     0.04%     0.00%  bench    libc.so.6                                          [.] __GI___libc_write
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] ksys_write
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] vfs_write
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] file_tty_write.constprop.0
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] iterate_tty_write
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] n_tty_write
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] uart_write
     0.04%     0.00%  bench    [kernel.kallsyms]                                  [k] process_output_block
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] __x64_sys_bpf
     0.03%     0.02%  bench    bench                                              [.] btf__type_by_id
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] __sys_bpf
     0.03%     0.03%  bench    [kernel.kallsyms]                                  [k] arch_rethook_fixup_return
     0.03%     0.00%  bench    bench                                              [.] feat_supported
     0.03%     0.00%  bench    bench                                              [.] sys_bpf_fd
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_load
     0.03%     0.02%  bench    bench                                              [.] btf_parse_type_sec
     0.03%     0.03%  bench    [kernel.kallsyms]                                  [k] radix_tree_lookup
     0.03%     0.00%  bench    bench                                              [.] bpf_program__attach
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] do_pte_missing
     0.03%     0.02%  bench    libc.so.6                                          [.] __memmove_sse2_unaligned_erms
     0.03%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_modify_all_code
     0.02%     0.00%  bench    bench                                              [.] attach_kprobe
     0.02%     0.00%  bench    bench                                              [.] bpf_program__attach_kprobe_opts
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] do_read_fault
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __do_fault
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] 0xffffffff8108dbc8
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __do_sys_perf_event_open
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] do_group_exit
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] do_exit
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_event_alloc
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_replace_code
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_init_event
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __fput
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_try_init_event
     0.02%     0.02%  bench    bench                                              [.] btf_type_by_id
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_kprobe_event_init
     0.02%     0.02%  bench    bench                                              [.] btf_kind
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_kprobe_init
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_select_runtime
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_int_jit_compile
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_jit_binary_pack_alloc
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_pack_alloc
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] filemap_fault
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] alloc_new_pack
     0.02%     0.01%  bench    [kernel.kallsyms]                                  [k] smp_call_function_many_cond
     0.02%     0.00%  bench    bench                                              [.] bpf_object__probe_loading
     0.02%     0.00%  bench    bench                                              [.] sys_bpf_prog_load
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] task_work_run
     0.02%     0.01%  bench    bench                                              [.] btf_validate_str
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_trace_event_init
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_trace_event_reg
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] filemap_read_folio
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] netfs_read_folio
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] netfs_begin_read
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] on_each_cpu_cond_mask
     0.02%     0.00%  bench    bench                                              [.] kernel_supports
     0.02%     0.01%  bench    bench                                              [.] btf__str_by_offset
     0.02%     0.01%  bench    libc.so.6                                          [.] __strcmp_sse2
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_release
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_event_release_kernel
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] _free_event
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_kprobe_destroy
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] enable_trace_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_trace_event_unreg.isra.0
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] disable_trace_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] enable_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __arm_kprobe_ftrace
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __disable_trace_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] disable_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] register_ftrace_function
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __disable_kprobe
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] register_ftrace_function_nolock
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] __disarm_kprobe_ftrace
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_startup
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] unregister_ftrace_function
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_shutdown.part.0
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] v9fs_issue_read
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_read
     0.02%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_read_once
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] memset_orig
     0.01%     0.00%  bench    bench                                              [.] bump_rlimit_memlock
     0.01%     0.00%  bench    bench                                              [.] probe_memcg_account
     0.01%     0.01%  bench    bench                                              [.] btf_vlen
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] set_memory_rox
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] change_page_attr_set_clr
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_zc_rpc.constprop.0
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_virtio_zc_request
     0.01%     0.00%  bench    bench                                              [.] bpf_object__sanitize_maps
     0.01%     0.00%  bench    bench                                              [.] bpf_prog_load
     0.01%     0.00%  bench    bench                                              [.] probe_kern_array_mmap
     0.01%     0.00%  bench    bench                                              [.] bpf_map_create
     0.01%     0.00%  bench    bench                                              [.] probe_kern_prog_name
     0.01%     0.00%  bench    ld-linux-x86-64.so.2                               [.] _dl_map_object
     0.01%     0.00%  bench    bench                                              [.] btf_validate_id
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] default_send_IPI_allbutself
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] ftrace_check_record
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] ftrace_rec_iter_next
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] default_send_IPI_self
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] finish_task_switch.isra.0
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] ftrace_rec_iter_record
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_get_mapped_pages.part.0.constprop.0
     0.01%     0.01%  bench    bench                                              [.] btf_strs_data
     0.01%     0.01%  bench    [kernel.kallsyms]                                  [k] mem_cgroup_commit_charge
     0.01%     0.01%  bench    bench                                              [.] btf_add_type_offs_mem
     0.01%     0.00%  bench    bench                                              [.] btf_type_size
     0.01%     0.00%  bench    [unknown]                                          [k] 0x000055fcb8980c50
     0.01%     0.00%  bench    [unknown]                                          [k] 0x32322e3239312820
     0.01%     0.00%  bench    [unknown]                                          [k] 0x35372e30312d2820
     0.01%     0.00%  bench    [unknown]                                          [k] 0x38392e3820202820
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] zap_pte_range
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_release
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_prog_put_deferred
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_event_bpf_event
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_iterate_sb
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] bpf_check
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] do_vmi_align_munmap.constprop.0
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_event_bpf_output
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] kmalloc_large
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_output_end
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] unmap_region
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] unmap_vmas
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __kmalloc_large_node
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_rpc
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] perf_output_put_handle
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] rmqueue
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] text_poke_bp_batch
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] unmap_page_range
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] cpa_flush
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] do_output_char
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] irq_work_queue
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] schedule
     0.01%     0.01%  bench    libc.so.6                                          [.] _IO_file_xsgetn
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __mem_cgroup_charge
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] __schedule
     0.01%     0.00%  bench    [kernel.kallsyms]                                  [k] arch_irq_work_raise
     0.01%     0.00%  bench    bench                                              [.] btf__name_by_offset
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] allocate_slab
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] _raw_spin_trylock
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] iter_xarray_get_pages
     0.00%     0.00%  bench    [unknown]                                          [k] 0x0000000000000040
     0.00%     0.00%  bench    bench                                              [.] bpf_object__create_maps
     0.00%     0.00%  bench    ld-linux-x86-64.so.2                               [.] _dl_sysdep_start
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] percpu_counter_add_batch
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] within_kprobe_blacklist
     0.00%     0.00%  bench    bench                                              [.] bpf_object__populate_internal_map
     0.00%     0.00%  bench    ld-linux-x86-64.so.2                               [.] dl_main
     0.00%     0.00%  bench    libm.so.6                                          [.] __sqrt
     0.00%     0.00%  bench    bench                                              [.] bpf_map_update_elem
     0.00%     0.00%  bench    bench                                              [.] bpf_object__relocate
     0.00%     0.00%  bench    ld-linux-x86-64.so.2                               [.] _dl_relocate_object
     0.00%     0.00%  bench    [unknown]                                          [k] 0x000000000000003f
     0.00%     0.00%  bench    bench                                              [.] bpf_program_fixup_func_info
     0.00%     0.00%  bench    bench                                              [.] bpf_program__attach_perf_event_opts
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] folio_add_lru
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] iov_iter_advance
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] strncpy_from_user
     0.00%     0.00%  bench    bench                                              [.] probe_kern_arg_ctx_tag
     0.00%     0.00%  bench    ld-linux-x86-64.so.2                               [.] __GI___read_nocancel
     0.00%     0.00%  bench    libc.so.6                                          [.] __close
     0.00%     0.00%  bench    libc.so.6                                          [.] __printf_fp
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] folio_lruvec_lock_irqsave
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mas_walk
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] map_update_elem
     0.00%     0.00%  bench    ld-linux-x86-64.so.2                               [.] __GI___open64_nocancel
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] folio_mark_accessed
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] _copy_from_user
     0.00%     0.00%  bench    ld-linux-x86-64.so.2                               [.] mmap64
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __x64_sys_close
     0.00%     0.00%  bench    libc.so.6                                          [.] _int_realloc
     0.00%     0.00%  bench    [unknown]                                          [k] 0x2020207374696820
     0.00%     0.00%  bench    [unknown]                                          [k] 0x2d6769727427206b
     0.00%     0.00%  bench    [unknown]                                          [k] 0x31342e33312d2820
     0.00%     0.00%  bench    [unknown]                                          [k] 0x31382e3631202820
     0.00%     0.00%  bench    [unknown]                                          [k] 0x33372e34332d2820
     0.00%     0.00%  bench    [unknown]                                          [k] 0x33392e3531202820
     0.00%     0.00%  bench    [unknown]                                          [k] 0x38342e36312d2820
     0.00%     0.00%  bench    [unknown]                                          [k] 0x68636e6562207075
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] xas_find
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __x64_sys_openat
     0.00%     0.00%  bench    bench                                              [.] _start
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] do_sys_openat2
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ksys_mmap_pgoff
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] module_alloc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] netfs_unbuffered_read_iter
     0.00%     0.00%  bench    libc.so.6                                          [.] __munmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __register_ftrace_function
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __vmalloc_node_range
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] do_filp_open
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] netfs_unbuffered_read_iter_locked
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] vm_mmap_pgoff
     0.00%     0.00%  bench    libc.so.6                                          [.] _int_malloc
     0.00%     0.00%  bench    libc.so.6                                          [.] __strlen_sse2
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __change_page_attr_set_clr
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __vmalloc_area_node
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] do_mmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] exit_mm
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_update_trampoline
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] path_openat
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __x64_sys_munmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] arch_ftrace_update_trampoline
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] cpa_process_alias
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] do_open
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mmap_region
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] mmput
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] vmap_small_pages_range_noflush
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __vm_munmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] create_trampoline
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] do_dentry_open
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] exit_mmap
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ftrace_update_ftrace_func
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] vmap_pages_pte_range
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __change_page_attr
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __pte_alloc_kernel
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] create_local_trace_kprobe
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] text_poke_bp
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] v9fs_file_open
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __filemap_get_folio
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __split_large_page
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] _vm_unmap_aliases
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] lru_add_drain
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] netfs_alloc_request
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_client_open
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] register_kretprobe
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] text_poke_finish
     0.00%     0.00%  bench    libc.so.6                                          [.] __GI___printf_fp_l
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __kmalloc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __purge_vmap_area_lazy
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] __rmqueue_pcplist
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] filemap_map_pages
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] lru_add_drain_cpu
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] register_kprobe
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] shmem_fault
     0.00%     0.00%  bench    bench                                              [.] bpf_object__open_skeleton
     0.00%     0.00%  bench    libc.so.6                                          [.] __unregister_atfork
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] ___slab_alloc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] check_kprobe_address_safe
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] folio_batch_move_lru
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] iov_iter_get_pages_alloc2
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] lock_vma_under_rcu
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] netfs_rreq_prepare_read
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] next_uptodate_folio
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] p9_virtio_request
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] pcpu_alloc
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] rmqueue_bulk
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] shmem_get_folio_gfp
     0.00%     0.00%  bench    [kernel.kallsyms]                                  [k] zap_present_ptes
     0.00%     0.00%  bench    bench                                              [.] bpf_object__open_mem
     0.00%     0.00%  bench    bench                                              [.] btf_add_type_idx_entry
     0.00%     0.00%  bench    libc.so.6                                          [.] __vfprintf_internal
     0.00%     0.00%  bench    [unknown]                                          [.] 0xdfac2c2953a319ce


#
# (Tip: To separate samples by time use perf report --sort time,overhead,sym)
#

--Multipart=_Tue__30_Apr_2024_22_32_17_+0900_=oAZJzDQAmDqi/.B--

