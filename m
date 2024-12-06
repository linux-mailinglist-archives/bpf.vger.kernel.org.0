Return-Path: <bpf+bounces-46333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4209E7BD1
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0B01887BC6
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 22:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9461F543E;
	Fri,  6 Dec 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab/7eHE9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9F22C6D9;
	Fri,  6 Dec 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524238; cv=none; b=Dqa2igtjZA68ijd5Mrm3+Nm9MeOxalyLxlOS+72BwRYJrG0xZElIzoLekyiVUxWNOglEDDHMMA/5zYJZJQOqgnwReadRhaE6UGZcEZvHxybhCDRuS2lW7dTv3cIn9pDLf6IxfS5sZNiwgqu9homRSsMFGTrUUnPLgdQYBSjya5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524238; c=relaxed/simple;
	bh=M9oXkYncjye5rqyZTh6Fj1B9bteBE/P+h1Y/jrE/iKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJaWyPZpfigXI5o6UND3yQ6cxsVnaGkwqqctI3ZNWAtR9hIBhE6hGcbL9rBqs+ARJG+HLRQqMdA1rMQuJyzwjHTC990D/PEFRsyFpxwfwS/rmGRqN/CjLNEo5PnY8r2+9MBo0OQY0ycQV4cGn3IeVuhw6M4vLu0nerwwZlSDvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab/7eHE9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e9ff7a778cso3042291a91.1;
        Fri, 06 Dec 2024 14:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733524236; x=1734129036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd7p5nCc9B3SIz2MhjIlf+HXUuYkWnzYDNg0nc2RF0U=;
        b=Ab/7eHE9ecVZofY9EHcPwt0pSw4SdZuuGpYYEM8r8VFj+lRw/ZaX/B7q6GkTXg2ifO
         ZgYyHJjkDONPSMbL/h9d0nQBscX1cKfaW8uUWp/mgrsegamNpcBgqzijGNm5ew9o9B4Q
         +VIdwS8cVzHi1s59FUjTJQ0NHPoVcRtNgbku20ysmfNlLlCpEv6eqoB4Q7kjti/Mn2QA
         +4LT7h3u4Vv5Dp0yeMz9JwGYuvraxpNZrJAYl9Z9lgSu88CEHZONJJfhNX/qYrVLbAeS
         uFpdk1EvhfiNRprq9rW7uAdEC4odDcfEF/GmFogmz52FnN9E8BRiScDHkjQqWwLZlCJp
         0tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733524236; x=1734129036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd7p5nCc9B3SIz2MhjIlf+HXUuYkWnzYDNg0nc2RF0U=;
        b=TL6MHpwoEsHA5mt5Myc/zFIwLHnpOMtuf5aP+zUb8G2Iyp3KWUKrIkpdAY9TrfU120
         0N32nji2RWTJS5jj6OUSaQvMYR/5X0pxcu8bA/ETLsOhO50uPUAVi412Zfd7vxjcF/D9
         47dkAu8CR9lmYuJeK7Os6YPxgt1SmohUqofzrIC/TD/viF/H81ZR5GsTKWAgRNVEl3XG
         +rgjIuObIbgk6mzPhOxWq9A48lG849atydVhvWAIkRlSeyJiau0TVXJ8r3FMcy4wv1Bo
         DoIAnAt5KxGvBgoVZv5MEmmxcGHk23ciWCqlX/KSdiWLLx2o4xVada3jxzuH0ItRE/mS
         2GvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9LPFr/Oj1L9D5nqwckBZH0eyClf3a0Kc7HK7C0f3BG3/AOUCkiIXJcK6+dcKXc+XRSqwMb4i8b4EOti2R@vger.kernel.org, AJvYcCVMz4lsR5ZNjODdlXL9CJfukA23RNxLyuW2WJVd1uhpD+P/ldKQHqBp0S7uyE3s5dsbHGU=@vger.kernel.org, AJvYcCVY1ccxDs4f6W4PnDuUMrRIkqt/B9pO1yVkaEk+JPXspvOIpd/qRuu1xJ9QogqByWlCqjS10/chv4FjLFCKskNGoTPi@vger.kernel.org, AJvYcCXZzMyvhPeAzhco5gPYzFvtCRnAzd7zkrppDEHnFM+sHEblXPg8SJQWnT9p18HvA2yz74Wbku/R@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsdK9nn8dVAgSXJKbH2AKkXx9BC76BMmgOjZoVrsolHbRZBs0
	AAvgmAbIU5cbQhQ9Fw9inQiurQcwmY34kZ+xkFpkgH7sRYbgWbsVQtziy22v3V8MBZO3Hby5x+X
	OvHi2Im6T15AkLnJmzK1JFZppPrk=
X-Gm-Gg: ASbGncsiPrLM9gVLknzcb47h5ZfYZMElaf8ZvRtfkcZTbLCGUnRiOs9f85bY841Ksyk
	eqM3bwsAMpnzupRw4MZc6A+rpyDuvIcmNdF8AtWx3wBIJrzA=
X-Google-Smtp-Source: AGHT+IHuFiWE8Z1e33Jfgv2XwP/oL9fWbs1UT7k34APrZVI8qwR088/WkGYlYsnOv1I2m923Z82u0H6SbdNKwpYHh/w=
X-Received: by 2002:a17:90b:3a86:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-2ef68e13ed3mr7811076a91.14.1733524236218; Fri, 06 Dec 2024
 14:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
 <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com> <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com>
In-Reply-To: <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 14:30:24 -0800
Message-ID: <CAEf4BzYkGQ0sw9JEeAMLAfcQbzxwg46c487kBD_LcbZSaTKD5Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Jann Horn <jannh@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > Currently, the pointer stored in call->prog_array is loaded in
> > > __uprobe_perf_func(), with no RCU annotation and no RCU protection, s=
o the
> > > loaded pointer can immediately be dangling. Later,
> > > bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical sec=
tion,
> > > but this is too late. It then uses rcu_dereference_check(), but this =
use of
> > > rcu_dereference_check() does not actually dereference anything.
> > >
> > > It looks like the intention was to pass a pointer to the member
> > > call->prog_array into bpf_prog_run_array_uprobe() and actually derefe=
rence
> > > the pointer in there. Fix the issue by actually doing that.
> > >
> > > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gp=
s")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > To reproduce, in include/linux/bpf.h, patch in a mdelay(10000) direct=
ly
> > > before the might_fault() in bpf_prog_run_array_uprobe() and add an
> > > include of linux/delay.h.
> > >
> > > Build this userspace program:
> > >
> > > ```
> > > $ cat dummy.c
> > > #include <stdio.h>
> > > int main(void) {
> > >   printf("hello world\n");
> > > }
> > > $ gcc -o dummy dummy.c
> > > ```
> > >
> > > Then build this BPF program and load it (change the path to point to
> > > the "dummy" binary you built):
> > >
> > > ```
> > > $ cat bpf-uprobe-kern.c
> > > #include <linux/bpf.h>
> > > #include <bpf/bpf_helpers.h>
> > > #include <bpf/bpf_tracing.h>
> > > char _license[] SEC("license") =3D "GPL";
> > >
> > > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > > int BPF_UPROBE(main_uprobe) {
> > >   bpf_printk("main uprobe triggered\n");
> > >   return 0;
> > > }
> > > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-kern.c
> > > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoattach
> > > ```
> > >
> > > Then run ./dummy in one terminal, and after launching it, run
> > > `sudo umount uprobe-test` in another terminal. Once the 10-second
> > > mdelay() is over, a use-after-free should occur, which may or may
> > > not crash your kernel at the `prog->sleepable` check in
> > > bpf_prog_run_array_uprobe() depending on your luck.
> > > ---
> > > Changes in v2:
> > > - remove diff chunk in patch notes that confuses git
> > > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v=
1-1-6869c8a17258@google.com
> > > ---
> > >  include/linux/bpf.h         | 4 ++--
> > >  kernel/trace/trace_uprobe.c | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> >
> > Looking at how similar in spirit bpf_prog_run_array() is meant to be
> > used, it seems like it is the caller's responsibility to
> > RCU-dereference array and keep RCU critical section before calling
> > into bpf_prog_run_array(). So I wonder if it's best to do this instead
> > (Gmail will butcher the diff, but it's about the idea):
>
> Yeah, that's the other option I was considering. That would be more
> consistent with the existing bpf_prog_run_array(), but has the
> downside of unnecessarily pushing responsibility up to the caller...
> I'm fine with either.

there is really just one caller ("legacy" singular uprobe handler), so
I think this should be fine. Unless someone objects I'd keep it
consistent with other "prog_array_run" helpers

>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index eaee2a819f4c..4b8a9edd3727 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_prog_array =
*array,
> >   * rcu-protected dynamically sized maps.
> >   */
> >  static __always_inline u32
> > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu=
,
> > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> >                           const void *ctx, bpf_prog_run_fn run_prog)
> >  {
> >         const struct bpf_prog_array_item *item;
> >         const struct bpf_prog *prog;
> > -       const struct bpf_prog_array *array;
> >         struct bpf_run_ctx *old_run_ctx;
> >         struct bpf_trace_run_ctx run_ctx;
> >         u32 ret =3D 1;
> >
> >         might_fault();
> > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held=
");
> > +
> > +       if (unlikely(!array))
> > +               goto out;
> >
> > -       rcu_read_lock_trace();
> >         migrate_disable();
> >
> >         run_ctx.is_uprobe =3D true;
> >
> > -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_=
held());
> > -       if (unlikely(!array))
> > -               goto out;
> >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> >         item =3D &array->items[0];
> >         while ((prog =3D READ_ONCE(item->prog))) {
> > @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
> > bpf_prog_array __rcu *array_rcu,
> >         bpf_reset_run_ctx(old_run_ctx);
> >  out:
> >         migrate_enable();
> > -       rcu_read_unlock_trace();
> >         return ret;
> >  }
> >
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index fed382b7881b..87a2b8fefa90 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct trace_uprob=
e *tu,
> >         if (bpf_prog_array_valid(call)) {
> >                 u32 ret;
> >
> > +               rcu_read_lock_trace();
> >                 ret =3D bpf_prog_run_array_uprobe(call->prog_array,
> > regs, bpf_prog_run);
>
> But then this should be something like this (possibly split across
> multiple lines with a helper variable or such):
>
> ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call->prog_array,
> rcu_read_lock_trace_held()), regs, bpf_prog_run);

Yeah, absolutely, forgot to move the RCU dereference part, good catch!
But I wouldn't do the _check() variant here, literally the previous
line does rcu_read_trace_lock(), so this check part seems like just
unnecessary verboseness, I'd go with a simple rcu_dereference().

>
> > +               rcu_read_unlock_trace();
> >                 if (!ret)
> >                         return;
> >         }
> >
> >

