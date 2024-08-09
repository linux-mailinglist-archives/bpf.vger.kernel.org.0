Return-Path: <bpf+bounces-36789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E86C94D685
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63311F22B4C
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0999115ADB1;
	Fri,  9 Aug 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqeHxe67"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7913C8F4;
	Fri,  9 Aug 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229002; cv=none; b=iDyGQ71C4AO3e5yVzAjhk3bqywToyu0vDxCLZOKgMrjE4iNrbjf1YGgf9jN1yki/icpvixSMXCB2GDj0mSFf6SqtC97gORFr2Z1u3vyoe13h1FIqmSR2qzKnUyqa+CGI3c2lKVFidaUPbppJMx41QIwI7cQRtZFY1MlC6Oj9pmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229002; c=relaxed/simple;
	bh=H9FXHLpYfMUXWbFJSEQFUoSRkz4T4dpFivSoqqloZSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGoc7NgmGDsIzJ/zBelWiqNYvgtkqwLScZWbqwvMWKbSUIoQOSPuqxP0RtgXDxRKqNfKCVEYpun83WYzpUux1r64Pql+MB0Re9/Dz7D/2BaKIaRtl/9kLehmFFR+1LhpL6+1Ll991I/JASIrUmLmGDjgxGIuz2TuIyMqoBJaMpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqeHxe67; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cf93dc11c6so1901390a91.1;
        Fri, 09 Aug 2024 11:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723229000; x=1723833800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6v/APqpkjljeWsKuKvJifVCNrWaIH3KrJtyq7+urjQ=;
        b=NqeHxe677jNI7V4opI6VRANVY6D0IvCahel1bjW6xBsXvYjgehxvI3iKJ8Z76fgHSG
         TWMFpRBRON+Gpuhuula3YDVjSWeqK9I2LQzNTs7npmNtPAsuRxl1SQ+52SyCMX6LY+i0
         /0NW4Avw48OBrseI6CMvsOAzNfx/BmUrUWUozB96gCC+/DfVy03qkGUeg72hfni2pxGY
         f+4jT8PnMAFrYpEwNVbJZDV7OFLOpAsqCsBf4yMiSI6Kw6lvXZ1HN5qYxR32yLRiS7j3
         YXMzMX6Ew/4LYOQ+oT55ymtgHw419Kkjzu2BPqGKoN73xHrHVNFAqb8AZe8FLjfE+JuX
         5mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229000; x=1723833800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6v/APqpkjljeWsKuKvJifVCNrWaIH3KrJtyq7+urjQ=;
        b=JLxiKdTN4hrihWphyz0di8kN1OHjnV5nK4QChAp2n7goduN1B93w/8vIWdnt6hQJm3
         Et7+nzgAynsVA5BupLW3zqDa0eQ+StiTRJBxl54Bt9IgGu0qkzK65vp037o7hbkTfv8m
         x63Q4juXYCSRLajYbBoIPVoM6KdduO1J2MCavudKyqjC7bKz2dt8PxJmi6TSJ/I2F0KQ
         P7L0Gxt2HgdV8rnVAquhQHohk8BaGKhElMN6yRbOfg1D2Wg3fiEx0LqsnoFotdFyc3zg
         K2HWKvYEtmL8cBQDgs6ExADYydDyRtLYscR7rcVwpHZfJ7EdKnYgXMFeOxozHRHe7aKr
         /1sg==
X-Forwarded-Encrypted: i=1; AJvYcCW7uxkmJVbipgGoycWfeuEpadizNO+MnnmaQ8UqwTUffLs6Wmfi3Aeonwpek2Xt91xlFbRdCJkrH5O8HiXaV62Lq3G2+PAI0iNJhH2s+QpN9FED1Lbp9cpOKqIrcBc6X6x/XUWUpkF7hQSeBY+lxT0eMb7jnOs5YbdcV0fS6s4n43eM9rla
X-Gm-Message-State: AOJu0Ywdjjl9Pd4fMMLl5q/k9OINMeTEprAOwft4VSUTeSkVNJNBeCq0
	Y4DmTeKmRFTrXMFra3U+kOpiRZE+8YKEdhU1J/UUKbGSW5GmZs/hrTxUFGmQ7D1Kznobsfzz7gY
	w54OgyQwVnu0nmj2gXqQ/4F6yC18=
X-Google-Smtp-Source: AGHT+IFbHS8h9BI8SNX7Kxkg+6R8B5ycqFbc+TxbxK49+cr4DQJrVJ7Lw0LCL/3Dtjc2Pzhrf3fSwVd4DMJFNKiXBVA=
X-Received: by 2002:a17:90a:4b87:b0:2c9:6d8:d823 with SMTP id
 98e67ed59e1d1-2d1e7fa91b6mr2955323a91.1.1723229000137; Fri, 09 Aug 2024
 11:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805202803.1813090-1-andrii@kernel.org> <ZrHSts7eySxHs4wh@krava>
 <CAEf4Bzaq86fPVGWtXqvxLtbsk06coGBebnAO5YiuvuUF2v7++w@mail.gmail.com> <20240808064353.7470f6bfab89bd28dbcdebe0@kernel.org>
In-Reply-To: <20240808064353.7470f6bfab89bd28dbcdebe0@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 11:43:07 -0700
Message-ID: <CAEf4BzYeVT_pSaZP6HNVtdH1EpntXLbXB=6TLymnsA9YOjsWhg@mail.gmail.com>
Subject: Re: [PATCH] uprobes: get rid of bogus trace_uprobe hit counter
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	oleg@redhat.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:44=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 6 Aug 2024 10:26:25 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, Aug 6, 2024 at 12:37=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Mon, Aug 05, 2024 at 01:28:03PM -0700, Andrii Nakryiko wrote:
> > > > trace_uprobe->nhit counter is not incremented atomically, so its va=
lue
> > > > is bogus in practice. On the other hand, it's actually a pretty big
> > > > uprobe scalability problem due to heavy cache line bouncing between=
 CPUs
> > > > triggering the same uprobe.
> > >
> > > so you're seeing that in the benchmark, right? I'm curious how bad
> > > the numbers are
> > >
> >
> > Yes. So, once we get rid of all the uprobe/uretprobe/mm locks (ongoing
> > work), this one was the last limiter to linear scalability.
> >
> > With this counter, I was topping out at about 12 mln/s uprobe
> > triggering (I think it was 32 CPUs, but I don't remember exactly now).
> > About 30% of CPU cycles were spent in this increment.
> >
> > But those 30% don't paint the full picture. Once the counter is
> > removed, the same uprobe throughput jumps to 62 mln/s or so. So we
> > definitely have to do something about it.
> >
> > > >
> > > > Drop it and emit obviously unrealistic value in its stead in
> > > > uporbe_profiler seq file.
> > > >
> > > > The alternative would be allocating per-CPU counter, but I'm not su=
re
> > > > it's justified.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/trace/trace_uprobe.c | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprob=
e.c
> > > > index 52e76a73fa7c..5d38207db479 100644
> > > > --- a/kernel/trace/trace_uprobe.c
> > > > +++ b/kernel/trace/trace_uprobe.c
> > > > @@ -62,7 +62,6 @@ struct trace_uprobe {
> > > >       struct uprobe                   *uprobe;
> > > >       unsigned long                   offset;
> > > >       unsigned long                   ref_ctr_offset;
> > > > -     unsigned long                   nhit;
> > > >       struct trace_probe              tp;
> > > >  };
> > > >
> > > > @@ -821,7 +820,7 @@ static int probes_profile_seq_show(struct seq_f=
ile *m, void *v)
> > > >
> > > >       tu =3D to_trace_uprobe(ev);
> > > >       seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
> > > > -                     trace_probe_name(&tu->tp), tu->nhit);
> > > > +                trace_probe_name(&tu->tp), ULONG_MAX);
> > >
> > > seems harsh.. would it be that bad to create per cpu counter for that=
?
> >
> > Well, consider this patch a conversation starter. There are two
> > reasons why I'm removing the counter instead of doing per-CPU one:
> >
> >   - it's less work to send out a patch pointing out the problem (but
> > the solution might change)
> >   - this counter was never correct in the presence of multiple
> > threads, so I'm not sure how useful it is.
> >
> > Yes, I think we can do per-CPU counters, but do we want to pay the
> > memory price? That's what I want to get from Masami, Steven, or Peter
> > (whoever cares enough).
>
> I would like to make it per-cpu counter *and* make it kconfig optional.
> Or just remove with the file (but it changes the user interface without
> option).
>
> For the kprobes, the profile file is useful because it shows "missed"
> counter. This tells user whether your trace data drops some events or not=
.
> But if uprobes profile only shows the number of hit, we can use the
> histogram trigger if needed.
>

I really don't like extra Kconfig options for something like this. So
I'll just go ahead and switch this to per-CPU counters
unconditionally.

For BPF, this is unnecessary memory overhead, but as we shift to
multi-uprobe (which doesn't go through trace_uprobe logic), it
probably isn't a big deal over the longer term.

> Thank you,
>
> >
> > >
> > > jirka
> > >
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -1507,7 +1506,6 @@ static int uprobe_dispatcher(struct uprobe_co=
nsumer *con, struct pt_regs *regs)
> > > >       int ret =3D 0;
> > > >
> > > >       tu =3D container_of(con, struct trace_uprobe, consumer);
> > > > -     tu->nhit++;
> > > >
> > > >       udd.tu =3D tu;
> > > >       udd.bp_addr =3D instruction_pointer(regs);
> > > > --
> > > > 2.43.5
> > > >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

