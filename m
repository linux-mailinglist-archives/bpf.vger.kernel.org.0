Return-Path: <bpf+bounces-38561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172BA966617
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B0C28281B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F041B1D7C;
	Fri, 30 Aug 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwXJqnDp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826A1B5ED6;
	Fri, 30 Aug 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033087; cv=none; b=E1h/hFbEtJbcQscrWayXzBoGM0hFU6K+bKwSLixaH8df3LmP0vLKZXaPEQHsamx0NBcXu6wk/62Qa9Y6/8pC9sEVZ6e7rOlS/Weu68glYNVM5IDHIE79ei0L2p7oziURb+xsnKN0xLC6GcdJD8ycwTY3meJ/RZcYuXztlVH5Pgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033087; c=relaxed/simple;
	bh=xAioSBDKFkFJYFGiE/9X5In06ymYVEpnW7BVX8AjVNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5dyXx6dXVQMLrZm+6/Y+8Ymcc037A2YdE2NRBei1m/Xf/1bnuwRM5bYRNF5BXZWZtmKqRHz8TXXUw6OqBz9bAkYmuRnAX0tQsSP3rAlQvSKCnKNPnfVH8VwAt+rC7r0kadhi4wq0fzztMEjOv7bDm73x/tMsznVj+8zpd6vUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwXJqnDp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3dacaccfaso1329750a91.0;
        Fri, 30 Aug 2024 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725033085; x=1725637885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBJRhd+VANLoHVBvpomYfQjFBa3qlIC8N1wh5qWHTzo=;
        b=PwXJqnDp6u1/MzHxisTXk1GkTkimEElGRtZdM3zUe87xFQxBrfwn9TjqCVTtsnzKDj
         +bgmpIJyUUqFoAs5poVk0QUxGVBCSawxmynWoc+P7YnEQpk7cl0bGrj2aeTyalwesUEQ
         SJAMJN+Auz5C4hvUPTuyL5s1MW9mckvMJhMy3Pvp30SVzxf2SOB+MQpjXIUUfEkHC048
         vkuJwuvG3DSWdrP2ronskENjzf92tfZZdNuw2ROBrxSkzYfs7oRisFBb4UqFEX2pebuB
         I8KyJBnvU5COe9pilRaQ3EeYh4SQFXj1hjVFa9TrpfdKhlKrR50EyhqdcqFYrBaoghiN
         /ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033085; x=1725637885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBJRhd+VANLoHVBvpomYfQjFBa3qlIC8N1wh5qWHTzo=;
        b=jSvLRvKc0fD2gPVj9zX0o2JrQhbiieE2NJS2at8V6giVEpqH7PybePN633jpPDniaY
         QRDCmnYJFzYtilyPvaxffXqXmGS0J09hz7LKE2gr6rGIeBqzjJwA/0YBMKqcTFlqvZPE
         0v4wJWih52yDFM88fy5qPqh2tLuuO597zzBGnexDqzu3VCNfYIAzJEtLeZ0tS5DZH5p2
         5AHoa6nffQ1GemvLfGmxlcBzaJRdXx+3fVW28HySmsIXZXOe0JBdl80szaZLW7bBrVD8
         louerouMQFYM6iVBgfEbNPLHStM4klkNhCpKBdkYlGZFihPFX0N5fwlVdP78DphrTBZj
         hlqw==
X-Forwarded-Encrypted: i=1; AJvYcCVfH4XpmMC4xQCGQvesuXQ8yW5nNjUE1uffSPQdgCL1oPREiD7qWrD3LDHcV5zrhgM0kWR8XI9mW9uUS92vxKpYaoU8@vger.kernel.org, AJvYcCXz5Wfgd6rGlu4Rm27kUXC6K5/96AtGUblVjpXz4jwabyKV12NVD9V3OBkwWI9kO8Q02sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZnzyo/n7OPQzVeLZOoC6UdegOfqq8PpeOEigsqF9QHZ3Z4b4
	prgNtlDzvkvfH0LSInF9U018UaiI0dHasDBw5z37ULnAAIAAiPJklEcyosraXuAJHm83V6hSuxQ
	Qt0V308/+h9Vc4Zy6KxGlOfriyEs=
X-Google-Smtp-Source: AGHT+IF+XGRJ0p/KIRbjfp6ASdfmBhco1nJqHK0e48ekp81nExo82zUuM7HK/JAta/eCvm2KG7HxuFT1i3o/P8xayhY=
X-Received: by 2002:a17:90a:9314:b0:2c9:61ad:dcd9 with SMTP id
 98e67ed59e1d1-2d8564cb26fmr7027715a91.27.1725033085027; Fri, 30 Aug 2024
 08:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240830101209.GA24733@redhat.com> <ZtHKTtn7sqaLeVxV@krava>
In-Reply-To: <ZtHKTtn7sqaLeVxV@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 08:51:12 -0700
Message-ID: <CAEf4BzZPGxuV38Kz3R387tANP3tLF7j9GLRd6tOYtaEWT9uqCw@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Tianyi Liu <i.pear@outlook.com>, 
	Jordan Rome <linux@jordanrome.com>, ajor@meta.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	flaniel@linux.microsoft.com, albancrequy@linux.microsoft.com, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 6:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Aug 30, 2024 at 12:12:09PM +0200, Oleg Nesterov wrote:
> > The whole discussion was very confusing (yes, I too contributed to the
> > confusion ;), let me try to summarise.
> >
> > > U(ret)probes are designed to be filterable using the PID, which is th=
e
> > > second parameter in the perf_event_open syscall. Currently, uprobe wo=
rks
> > > well with the filtering, but uretprobe is not affected by it.
> >
> > And this is correct. But the CONFIG_BPF_EVENTS code in __uprobe_perf_fu=
nc()
> > misunderstands the purpose of uprobe_perf_filter().
> >
> > Lets forget about BPF for the moment. It is not that uprobe_perf_filter=
()
> > does the filtering by the PID, it doesn't. We can simply kill this func=
tion
> > and perf will work correctly. The perf layer in __uprobe_perf_func() do=
es
> > the filtering when perf_event->hw.target !=3D NULL.
> >
> > So why does uprobe_perf_filter() call uprobe_perf_filter()? Not to avoi=
d
> > the __uprobe_perf_func() call (as the BPF code assumes), but to trigger
> > unapply_uprobe() in handler_chain().
> >
> > Suppose you do, say,
> >
> >       $ perf probe -x /path/to/libc some_hot_function
> > or
> >       $ perf probe -x /path/to/libc some_hot_function%return
> > then
> >       $perf record -e ... -p 1
> >
> > to trace the usage of some_hot_function() in the init process. Everythi=
ng
> > will work just fine if we kill uprobe_perf_filter()->uprobe_perf_filter=
().
> >
> > But. If INIT forks a child C, dup_mm() will copy int3 installed by perf=
.
> > So the child C will hit this breakpoint and cal handle_swbp/etc for no
> > reason every time it calls some_hot_function(), not good.
> >
> > That is why uprobe_perf_func() calls uprobe_perf_filter() which returns
> > UPROBE_HANDLER_REMOVE when C hits the breakpoint. handler_chain() will
> > call unapply_uprobe() which will remove this breakpoint from C->mm.
>
> thanks for the info, I wasn't aware this was the intention
>
> uprobe_multi does not have perf event mechanism/check, so it's using
> the filter function to do the process filtering.. which is not working
> properly as you pointed out earlier

So this part I don't completely get. I get that using task->mm
comparison is wrong due to CLONE_VM, but why same_thread_group() check
is wrong? I.e., why task->signal comparison is wrong?

Sorry, I tried to follow the thread, but there were a lot of emails
with a bunch of confusion, so I'm not sure I got all the details.

>
> >
> > > We found that the filter function was not invoked when uretprobe was
> > > initially implemented, and this has been existing for ten years.
> >
> > See above, this is correct.
> >
> > Note also that if you only use perf-probe + perf-record, no matter how
> > many instances, you can even add BUG_ON(!uprobe_perf_filter(...)) into
> > uretprobe_perf_func(). IIRC, perf doesn't use create_local_trace_uprobe=
().
> >
> > -----------------------------------------------------------------------=
----
> > Now lets return to BPF and this particular problem. I won't really argu=
e
> > with this patch, but
> >
> >       - Please change the subject and update the changelog,
> >         "Fixes: c1ae5c75e103" and the whole reasoning is misleading
> >         and wrong, IMO.
> >
> >       - This patch won't fix all problems because uprobe_perf_filter()
> >         filters by mm, not by pid. The changelog/patch assumes that it
> >         is a "PID filter", but it is not.
> >
> >         See https://lore.kernel.org/linux-trace-kernel/20240825224018.G=
D3906@redhat.com/
> >         If the traced process does clone(CLONE_VM), bpftrace will hit t=
he
> >         similar problem, with uprobe or uretprobe.
> >
> >       - So I still think that the "right" fix should change the
> >         bpf_prog_run_array_uprobe() paths somehow, but I know nothing
> >         about bpf.
>
> to follow the perf event filter properly, bpf_prog_run_array_uprobe shoul=
d
> be called in perf_tp_event after the perf_tp_event_match call, but that's
> already under preempt_disable, so that's why it's called before that
>
> jirka

