Return-Path: <bpf+bounces-38009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45F95DF2E
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 19:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E767B2150D
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E4C46444;
	Sat, 24 Aug 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV45Nob8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A128481B7;
	Sat, 24 Aug 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724520480; cv=none; b=G+aoqGgUe6qYItThzjcTPw/hsgmXo+PuoD/bVj+VaZKUc8YPNVGCpNny6gAdWoQKafMB/ULc2ziRU4y4HsbLwcz2yMMm0BbSJxw0Ik8q8bdaj2THCWl4asszc01t5yuS+HZqhK4puvP10I+XiLs2AT1qjnSNmx4QOj3knI9AQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724520480; c=relaxed/simple;
	bh=z1YdVSKrD34znpQqOu0Lzz19rkv0dORD6XWSixbGLHA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HUu1t+HesVqaYlrV553n7n00qFgp/NXGxE/xOFrTQ5pU/Egavazorq+QuQrmKq5d7n9oGQIuh2IYZJKiu3DO+cpDemE2nfop5wCFtUkb2st1D0RwDksLuWi9wmc2/7rFP8ObRT8JyHuGh8xqQ3W0yakBGkxGoUGp9oHjrH88Nrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV45Nob8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F7EC32781;
	Sat, 24 Aug 2024 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724520480;
	bh=z1YdVSKrD34znpQqOu0Lzz19rkv0dORD6XWSixbGLHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WV45Nob8Nn3JEkB6AzyKgzsEivsoOvZEfsGsjAw4utWvzySIZnx/AAO3hxG5dYIwR
	 6Y5JZnHxXxJ3OMTnuHDsg5rEpGukvZOpQbA+GRFP98YXJKXExqG891V76agH3CJCzc
	 6JS2Dm8xTIygSyGdNzi0b8mKg1bVIvwYkW362SjzCYbPotircYWjERZwk+Gecbry4o
	 +3eS4MnoxlTP/D3I4jkh5TFlTlWiY80Zd5bDuGgKcKQADcw9hoaTFvsa468m12PTgZ
	 liKlFbqrA7AcFb/h0kKimZOO6QMFoevSOqJQsF0TD2h9veOZNp8qBAUNtqJB53roA+
	 keIr80EiQkNtw==
Date: Sun, 25 Aug 2024 02:27:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tianyi Liu <i.pear@outlook.com>
Cc: andrii.nakryiko@gmail.com, ajor@meta.com,
 albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
 flaniel@linux.microsoft.com, jolsa@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
 mathieu.desnoyers@efficios.com, oleg@redhat.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-Id: <20240825022755.a430c0969a1e784adc444a4f@kernel.org>
In-Reply-To: <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
	<ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 13:49:26 +0800
Tianyi Liu <i.pear@outlook.com> wrote:

> Hi Masami and Andrii:
> 
> I would like to share more information and ideas, but I'm possibly wrong.
> 
> > > U(ret)probes are designed to be filterable using the PID, which is the
> > > second parameter in the perf_event_open syscall. Currently, uprobe works
> > > well with the filtering, but uretprobe is not affected by it. This often
> > > leads to users being disturbed by events from uninterested processes while
> > > using uretprobe.
> > >
> > > We found that the filter function was not invoked when uretprobe was
> > > initially implemented, and this has been existing for ten years. We have
> > > tested the patch under our workload, binding eBPF programs to uretprobe
> > > tracepoints, and confirmed that it resolved our problem.
> > 
> > Is this eBPF related problem? It seems only perf record is also affected.
> > Let me try.
> 
> I guess it should be a general issue and is not specific to BPF, because
> the BPF handler is only a event "consumer".
> 
> > 
> > And trace one of them;
> > 
> > $ sudo ~/bin/perf trace record -e probe_malloc:malloc__return  -p 93928
> > 
> 
> A key trigger here is that the two tracer instances (either `bpftrace` or
> `perf record`) must be running *simultaneously*. One of them should use
> PID1 as filter, while the other uses PID2.

Even if I run `perf trace record` simultaneously, it filters the event
correctly. I just ran;

sudo ~/bin/perf trace record -e probe_malloc:malloc__return -p 93927 -o trace1.data -- sleep 50 &
sudo ~/bin/perf trace record -e probe_malloc:malloc__return -p 93928 -o trace2.data -- sleep 50 &

And dump trace1.data and trace2.data by `perf script`.

> 
> I think the reason why only tracing PID1 fails to trigger the bug is that,
> uprobe uses some form of copy-on-write mechanism to create independent
> .text pages for the traced process. For example, if only PID1 is being
> traced, then only the libc.so used by PID1 is patched. Other processes
> will continue to use the unpatched original libc.so, so the event isn't
> triggered. In my reproduction example, the two bpftrace instances must be
> running at the same moment.
> 
> > This is a bit confusing, because even if the kernel-side uretprobe
> > handler doesn't do the filtering by itself, uprobe subsystem shouldn't
> > install breakpoints on processes which don't have uretprobe requested
> > for (unless I'm missing something, of course).
> 
> There're two tracers, one attached to PID1, and the other attached
> to PID2, as described above.

Yeah, but perf works fine. Maybe perf only enables its ring buffer for
the specific process and read from the specific ring buffer (Note, perf
has per-process ring buffer IIRC.) How does the bpftracer implement it?

> 
> > It still needs to be fixed like you do in your patch, though. Even
> > more, we probably need a similar UPROBE_HANDLER_REMOVE handling in
> > handle_uretprobe_chain() to clean up breakpoint for processes which
> > don't have uretprobe attached anymore (but I think that's a separate
> > follow up).
> 
> Agreed, the implementation of uretprobe should be almost the same as
> uprobe, but it seems uretprobe was ignored in previous modifications.

OK, I just have a confirmation from BPF people, because I could not
reproduce the issue with perf tool.

> 
> > $ sudo ~/bin/perf trace record -e probe_malloc:malloc__return  -p 93928
> > ^C[ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.031 MB perf.data (9 samples) ]
> > 
> > And dump the data;
> > 
> > $ sudo ~/bin/perf script
> >       malloc-run   93928 [004] 351736.730649:       raw_syscalls:sys_exit: NR 230 = 0
> >       malloc-run   93928 [004] 351736.730694: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
> >       malloc-run   93928 [004] 351736.730696:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
> >       malloc-run   93928 [004] 351738.730857:       raw_syscalls:sys_exit: NR 230 = 0
> >       malloc-run   93928 [004] 351738.730869: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
> >       malloc-run   93928 [004] 351738.730883:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
> >       malloc-run   93928 [004] 351740.731110:       raw_syscalls:sys_exit: NR 230 = 0
> >       malloc-run   93928 [004] 351740.731125: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
> >       malloc-run   93928 [004] 351740.731127:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
> > 
> > Hmm, it seems to trace one pid data. (without this change)
> > If this changes eBPF behavior, I would like to involve eBPF people to ask
> > this is OK. As far as from the viewpoint of perf tool, current code works.
> 
> I tried this and also couldn't reproduce the bug. Even when running two
> perf instances simultaneously, `perf record` (or perhaps `perf trace` for
> convenience) only outputs events from the corresponding PID as expected.
> I initially suspected that perf might be applying another filter in user
> space, but that doesn't seem to be the case. I'll need to conduct further
> debugging, which might take some time.
> 
> I also tried combining bpftrace with `perf trace`. Specifically, I used
> `perf trace` for PID1 and bpftrace for PID2. `perf trace` still only
> outputs events from PID1, but bpftrace prints events from both PIDs.
> I'm not yet sure why this is happening.

Yeah, if perf only reads the specific process's ring buffer, it should
work without this filter.

Thanks,

> 
> Thanks so much,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

