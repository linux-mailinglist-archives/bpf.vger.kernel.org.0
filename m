Return-Path: <bpf+bounces-37980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF895D5D9
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 21:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292A01C21695
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E281191F7E;
	Fri, 23 Aug 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jemkqWt6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE6757F3;
	Fri, 23 Aug 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440062; cv=none; b=LRfgp6ebZq/OSy9+pDFtQEq2nDoyzN27p/V07mUNVH2IxJPnD3rmPVdyZPL+mM1zau8qQiqCNkXoYttEU+1SiR3DW9GjTWHAeOPL+2J7AqZUx8QqWIwWjrvvfiCT9znakWlJ9IiOpSoCsja1flokzw4xqWJ1qQF2JL3t3FSeElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440062; c=relaxed/simple;
	bh=gy1JqCdO9NsNhfA5CSwY0h/e3UihTKEI7euKjG5EYoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqR0pZvUZkEuExlVuJ7XIEgckZ6OACMWtdxVOXuX+aGJDMjv+0JcpSFToWVTpgKUz45Org6aD2xW0zhRRP1+7lCKmw6LzydKiQdf7TigMfC8KE8exFihk1edvDlFgpPAMxRDJjTenMQzuIccNpmIUT8BGj/RxUb/oFoqp03EVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jemkqWt6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8682bb5e79so326516766b.2;
        Fri, 23 Aug 2024 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724440059; x=1725044859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhnphg55IC3kyMZ/36YrfXynFLN+Id40TwnrR1ftgjk=;
        b=jemkqWt6qrfian8mmG+Vgo9bOBl5wPgnrC3Z7UmKTiHnc3gl2SCaGjPekVlY/PD2St
         DtPp6shIUyKsCTJ1HjFTUHiUFw5aKMXE8vjKEUF0tVw5kahYoXc59plhu70iYVOvqrM2
         dCFNrl+4IWdcJBAauPC3nI7w0Mf3tVzKvWTNuzCBWAet/sgZXTbw6Iby9kLAe8/4fQ4z
         AFr8z1hPOpKFr+VNeobqbGVKpDUwoHsfUJ3Pa1d+Zdqkg2YXNjk0rqN0F0EnCQpSDByG
         Vpv2Rw4QbJtR7zmHV4riyxl/L9oU1xrLqIWXJedsyz0JRId4eCr3KdM4ny/duVMeYc3Q
         Bmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724440059; x=1725044859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhnphg55IC3kyMZ/36YrfXynFLN+Id40TwnrR1ftgjk=;
        b=MUVlSZZIVbA0b3Xos3l4UeUJ6OENtIP6cHXTEftj21VEDn8QO2aDl5wox7xTirEOFM
         IJQue3dnkJrSazU6HL22Ojb4SHIijnRm+gtu6zi/j5eFYkssOiC/ZMzH9Aib3RC/3Pkp
         5ZABDFmfnPSH1F9XdtREqh34c7C3FcYmYTOChakmfecmLWKea2MOhwCR/Oa8tuo2mIQw
         /Mh9AjCY2Em8N/6cmcXa7QVgOUJFXKPijtgrFnP72VBjEYLxVq6OHSE0qctcrL5W5+BT
         47SoWbbDZuzVKML98B8i951LAkhjujMdbe2CQcgWqf476C83FVGVt9YwBoqV/ai3TjAd
         9PyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZU7cyFbuL6zn1E9MyI1vFrOl+w1j24ITiKcUOuGXfacqflrR/dvLzBOfik6zRkcKeeLs=@vger.kernel.org, AJvYcCXbqTqhKeIYL+P480wBMbkaUzn+sRsj934c55C4oA6fORxF6awyisEjZ+yNBm2P2xqbyYLoqNc1sxeF/qoUoMMS/NHq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8feh5an0bxyy20lsQHHkGDEtVtFxAjcXpnyUb6apnqu+CvF6
	2bU067iwCkQFipyXlzOWc0tLWmqktdYvOff1/MeZQp4EVUDv38Gv08KFEMrAmoHvU5LoL9z2Wvi
	hDAGLtt/pJZfUFT2Uqt2qTNLWd5s=
X-Google-Smtp-Source: AGHT+IEviS6CpJ6oGt7ot2JA73XxZUeBGeyPR+dHU287w5yRbGkn10Ndhlbu9Xk+tuhJFf8IFdinSTCZ8dKcSpnXIOs=
X-Received: by 2002:a17:907:96ab:b0:a7a:af5d:f312 with SMTP id
 a640c23a62f3a-a86a54b9e3amr210382266b.46.1724440058747; Fri, 23 Aug 2024
 12:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240824024439.a37c41bab87dbdf3d0486846@kernel.org>
In-Reply-To: <20240824024439.a37c41bab87dbdf3d0486846@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Aug 2024 12:07:24 -0700
Message-ID: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
To: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Jordan Rome <linux@jordanrome.com>, ajor@meta.com
Cc: Tianyi Liu <i.pear@outlook.com>, Oleg Nesterov <oleg@redhat.com>, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, flaniel@linux.microsoft.com, 
	albancrequy@linux.microsoft.com, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

adding Jiri and bpftrace folks


On Fri, Aug 23, 2024 at 10:44=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Fri, 23 Aug 2024 21:53:00 +0800
> Tianyi Liu <i.pear@outlook.com> wrote:
>
> > U(ret)probes are designed to be filterable using the PID, which is the
> > second parameter in the perf_event_open syscall. Currently, uprobe work=
s
> > well with the filtering, but uretprobe is not affected by it. This ofte=
n
> > leads to users being disturbed by events from uninterested processes wh=
ile
> > using uretprobe.
> >
> > We found that the filter function was not invoked when uretprobe was
> > initially implemented, and this has been existing for ten years. We hav=
e
> > tested the patch under our workload, binding eBPF programs to uretprobe
> > tracepoints, and confirmed that it resolved our problem.
>
> Is this eBPF related problem? It seems only perf record is also affected.
> Let me try.
>
>
> >
> > Following are the steps to reproduce the issue:
> >
> > Step 1. Compile the following reproducer program:
> > ```
> >
> > int main() {
> >     printf("pid: %d\n", getpid());
> >     while (1) {
> >         sleep(2);
> >         void *ptr =3D malloc(1024);
> >         free(ptr);
> >     }
> > }
> > ```
> > We will then use uretprobe to trace the `malloc` function.
>
> OK, and run perf probe to add an event on malloc's return.
>
> $ sudo ~/bin/perf probe -x ./malloc-run --add malloc%return
> Added new event:
>   probe_malloc:malloc__return (on malloc%return in /home/mhiramat/ksrc/li=
nux/malloc-run)
>
> You can now use it in all perf tools, such as:
>
>         perf record -e probe_malloc:malloc__return -aR sleep 1
>
> >
> > Step 2. Run two instances of the reproducer program and record their PI=
Ds.
>
> $ ./malloc-run &  ./malloc-run &
> [1] 93927
> [2] 93928
> pid: 93927
> pid: 93928
>
> And trace one of them;
>
> $ sudo ~/bin/perf trace record -e probe_malloc:malloc__return  -p 93928
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.031 MB perf.data (9 samples) ]
>
> And dump the data;
>
> $ sudo ~/bin/perf script
>       malloc-run   93928 [004] 351736.730649:       raw_syscalls:sys_exit=
: NR 230 =3D 0
>       malloc-run   93928 [004] 351736.730694: probe_malloc:malloc__return=
: (561cfdeb30c0 <- 561cfdeb3204)
>       malloc-run   93928 [004] 351736.730696:      raw_syscalls:sys_enter=
: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
>       malloc-run   93928 [004] 351738.730857:       raw_syscalls:sys_exit=
: NR 230 =3D 0
>       malloc-run   93928 [004] 351738.730869: probe_malloc:malloc__return=
: (561cfdeb30c0 <- 561cfdeb3204)
>       malloc-run   93928 [004] 351738.730883:      raw_syscalls:sys_enter=
: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
>       malloc-run   93928 [004] 351740.731110:       raw_syscalls:sys_exit=
: NR 230 =3D 0
>       malloc-run   93928 [004] 351740.731125: probe_malloc:malloc__return=
: (561cfdeb30c0 <- 561cfdeb3204)
>       malloc-run   93928 [004] 351740.731127:      raw_syscalls:sys_enter=
: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
>
> Hmm, it seems to trace one pid data. (without this change)
> If this changes eBPF behavior, I would like to involve eBPF people to ask
> this is OK. As far as from the viewpoint of perf tool, current code works=
.
>
> But I agree that current code is a bit strange. Oleg, do you know anythin=
g?
>
> Thank you,
>
> >
> > Step 3. Use uretprobe to trace each of the two running reproducers
> > separately. We use bpftrace to make it easier to reproduce. Please run =
two
> > instances of bpftrace simultaneously: the first instance filters events
> > from PID1, and the second instance filters events from PID2.
> >
> > The expected behavior is that each bpftrace instance would only print
> > events matching its respective PID filter. However, in practice, both
> > bpftrace instances receive events from both processes, the PID filter i=
s
> > ineffective at this moment:
> >
> > Before:
> > ```
> > PID1=3D55256
> > bpftrace -p $PID1 -e 'uretprobe:libc:malloc { printf("time=3D%llu pid=
=3D%d\n", elapsed / 1000000000, pid); }'
> > Attaching 1 probe...
> > time=3D0 pid=3D55256
> > time=3D2 pid=3D55273
> > time=3D2 pid=3D55256
> > time=3D4 pid=3D55273
> > time=3D4 pid=3D55256
> > time=3D6 pid=3D55273
> > time=3D6 pid=3D55256
> >
> > PID2=3D55273
> > bpftrace -p $PID2 -e 'uretprobe:libc:malloc { printf("time=3D%llu pid=
=3D%d\n", elapsed / 1000000000, pid); }'
> > Attaching 1 probe...
> > time=3D0 pid=3D55273
> > time=3D0 pid=3D55256
> > time=3D2 pid=3D55273
> > time=3D2 pid=3D55256
> > time=3D4 pid=3D55273
> > time=3D4 pid=3D55256
> > time=3D6 pid=3D55273
> > time=3D6 pid=3D55256
> > ```

This is a bit confusing, because even if the kernel-side uretprobe
handler doesn't do the filtering by itself, uprobe subsystem shouldn't
install breakpoints on processes which don't have uretprobe requested
for (unless I'm missing something, of course).

It still needs to be fixed like you do in your patch, though. Even
more, we probably need a similar UPROBE_HANDLER_REMOVE handling in
handle_uretprobe_chain() to clean up breakpoint for processes which
don't have uretprobe attached anymore (but I think that's a separate
follow up).

Anyways, I think fixing this won't affect BPF in the sense that this
is clearly a bug and shouldn't happen. Furthermore, in
multi-uprobe/multi-uretprobe implementation we already filter this out
correctly, so I don't think anyone does (neither should) rely on this
buggy behavior.

> >
> > After: Both bpftrace instances will show the expected behavior, only
> > printing events from the PID specified by their respective filters:
> > ```
> > PID1=3D1621
> > bpftrace -p $PID1 -e 'uretprobe:libc:malloc { printf("time=3D%llu pid=
=3D%d\n", elapsed / 1000000000, pid); }'
> > Attaching 1 probe...
> > time=3D0 pid=3D1621
> > time=3D2 pid=3D1621
> > time=3D4 pid=3D1621
> > time=3D6 pid=3D1621
> >
> > PID2=3D1633
> > bpftrace -p $PID2 -e 'uretprobe:libc:malloc { printf("time=3D%llu pid=
=3D%d\n", elapsed / 1000000000, pid); }'
> > Attaching 1 probe...
> > time=3D0 pid=3D1633
> > time=3D2 pid=3D1633
> > time=3D4 pid=3D1633
> > time=3D6 pid=3D1633
> > ```
> >
> > Fixes: c1ae5c75e103 ("uprobes/tracing: Introduce is_ret_probe() and ure=
tprobe_dispatcher()")
> > Cc: Alban Crequy <albancrequy@linux.microsoft.com>
> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> > ---
> > Changes in v2:
> > - Drop cover letter and update commit message.
> > - Link to v1: https://lore.kernel.org/linux-trace-kernel/ME0P300MB04166=
144CDF92A72B9E1BAEA9D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM/
> > ---
> >  kernel/trace/trace_uprobe.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index c98e3b3386ba..c7e2a0962928 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -1443,6 +1443,9 @@ static void uretprobe_perf_func(struct trace_upro=
be *tu, unsigned long func,
> >                               struct pt_regs *regs,
> >                               struct uprobe_cpu_buffer **ucbp)
> >  {
> > +     if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
> > +             return;
> > +
> >       __uprobe_perf_func(tu, func, regs, ucbp);
> >  }
> >
> > --
> > 2.34.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

