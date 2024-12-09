Return-Path: <bpf+bounces-46419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB109E9DFC
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 19:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3FA282352
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB73175D34;
	Mon,  9 Dec 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u84lBngR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A54146A63
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768545; cv=none; b=jeYmFOAkHuFZj3KgsyozNhurFvhoOc+HEeNSbZZZVTxwfe1eZI81Wh/SNWAoi7mid7/4fjamaWkk4/pNYdMkhRQ550wvvLMI5E8QYo5QAr26jqlHF/x8XcpNv8iMFApo1U/FGP7b9wO8zlgqhSDkOc7mDYyGRtnjGEMo4XKyL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768545; c=relaxed/simple;
	bh=obrA7lID1gFWYDKJMm2TeVpt8h7Ddp8SM5ETW0ucnNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+NyD0zVHHhdcdraOx3xNuNjvfnqcJpEI+SImJA/Q4EZtA2QagpvWKQBgDCmnawp4tqboOLAHrRqMC6rAOXLIrCA+/2TRuyZOv7UWwe2wNANdmK3u8DA4GIapcifvrAQ2kHnj6dgVRAuOOwXCpVq8RP4UCjczZUVji+CnU+T9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u84lBngR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so12830a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 10:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733768541; x=1734373341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tUQKE2UAVAgxJSPVinR+cC1NkFiAgMKLM+zQJilRu8=;
        b=u84lBngRDXgDXtGBtkPLmJZamJaSbox/jnObkvjKb1ROS75WJXSuCkbkYHrFwGmym3
         3S1hGym1u44XSA72QRFNHocaC6f/+IR1EziwJ52hw6giefX3NpZf/V07LaSTDSE8l2bM
         5CQmAU8xvy6Y0PRGTUOgYufTgRcu9EFSzm+LTTOlx1otmtAe1b0UEerJr+23TlS5CDAe
         VjwcrUhvupY9GYbFWcoCLgeNA03ZbHA3pJ3zu/LGIYGvAlE7eCB7zhHaI2OjU2COC2b0
         ghxRNx2k1xnIcV4H2cz0GOjzCfpA8KeH1tmIKdrr7Qi5bhCYrOOdHKlAuv+bKxMtJqtk
         kQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733768541; x=1734373341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tUQKE2UAVAgxJSPVinR+cC1NkFiAgMKLM+zQJilRu8=;
        b=g64t8vi92u0dlI+M/qfPsjlOoHtkSk47RJr8HJe8dr9cstJUn8QwUlsdZkYZ8U7bvV
         fV3dzS3S7LWmgHmIBqp8lYkgEX1W/HO4+Tu0qYF+v/NOiS60rLfyUaVvjr/fsvftoHOa
         5Ah9oqKBi9VEUHm5rysctEE5OruefPkc+0ViBvqLtvu5jhh+kpvIJZLkGbpqLzR4HgXu
         udCbAwCX5SEERYH2KdaDGc2dhxQgJBWRUiyeAZHxZNxOyMB41PEaSK+KifccaPk25/px
         0huOgodvv0wVERRRwWjOgB28S8UzCbTLgt+L1hVlMCOyu3ZmMblJc7bWYAZLiBDRERuj
         l3SA==
X-Forwarded-Encrypted: i=1; AJvYcCVb706WTwDXEHkfmaU0ahs5QfqKqeWGF9zjxQR79b80Nf4/KA1slfkAyMFatSeGnF+e2ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmpBWpz2LKlr3Tu0r3wXMfmzFrVv6w1Pqgap8Sc7kn/DNzMTG
	4iFe5QfYp64YeChA5wdWOZQfCHXVPuWCVorSOBTxeCpNXoPmG+Lr5uRWmLhQUczMtayxYwkWtuR
	vAK/idGTVgOX0tzbmepMk2CE+Yi6PJGmI7OX2
X-Gm-Gg: ASbGncuZXSfralKB5eQeM0CS1s0LqIr/FNEBqbiRC8aDE2c551mcsTtxeragw0w7b4v
	Ztjhdeku6z8ggj+XgI7M5D1hmIvuIvv3NATyIqCS569T3+RUnKirKrjTQokU=
X-Google-Smtp-Source: AGHT+IGmPKN0EpLP38yrJia+weZldXt3F33PYP8oxMA6FR4C09SQ3gxfPRS4f6CLIqzIE+ydJh1lCkLqvNmJfG/o4BE=
X-Received: by 2002:aa7:d905:0:b0:5d0:dfe4:488a with SMTP id
 4fb4d7f45d1cf-5d3dabe79bemr172129a12.2.1733768541030; Mon, 09 Dec 2024
 10:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
 <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
 <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com>
 <CAEf4BzYkGQ0sw9JEeAMLAfcQbzxwg46c487kBD_LcbZSaTKD5Q@mail.gmail.com>
 <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com>
 <CAG48ez2+3TTbWNNO4aqxFAX8Cd4COaayRxoy1V2xvM9oS2_ygQ@mail.gmail.com> <CAEf4BzbhDkFq9DB2VKxsHmffynQBvbD_RVKTUm3zCqvO_e1dug@mail.gmail.com>
In-Reply-To: <CAEf4BzbhDkFq9DB2VKxsHmffynQBvbD_RVKTUm3zCqvO_e1dug@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Dec 2024 19:21:45 +0100
Message-ID: <CAG48ez2LW9zyiptNq8jApD3zeS05wvNPs-jj2zOeaCDQbZnD4g@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Sat, Dec 7, 2024 at 12:15=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Fri, Dec 6, 2024 at 3:14=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> > On Fri, Dec 6, 2024 at 11:43=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > > On Fri, Dec 6, 2024 at 11:30=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Jann Horn <jannh@google.com>=
 wrote:
> > > > >
> > > > > On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@google=
.com> wrote:
> > > > > > >
> > > > > > > Currently, the pointer stored in call->prog_array is loaded i=
n
> > > > > > > __uprobe_perf_func(), with no RCU annotation and no RCU prote=
ction, so the
> > > > > > > loaded pointer can immediately be dangling. Later,
> > > > > > > bpf_prog_run_array_uprobe() starts a RCU-trace read-side crit=
ical section,
> > > > > > > but this is too late. It then uses rcu_dereference_check(), b=
ut this use of
> > > > > > > rcu_dereference_check() does not actually dereference anythin=
g.
> > > > > > >
> > > > > > > It looks like the intention was to pass a pointer to the memb=
er
> > > > > > > call->prog_array into bpf_prog_run_array_uprobe() and actuall=
y dereference
> > > > > > > the pointer in there. Fix the issue by actually doing that.
> > > > > > >
> > > > > > > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by cha=
ining gps")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > > > ---
> > > > > > > To reproduce, in include/linux/bpf.h, patch in a mdelay(10000=
) directly
> > > > > > > before the might_fault() in bpf_prog_run_array_uprobe() and a=
dd an
> > > > > > > include of linux/delay.h.
> > > > > > >
> > > > > > > Build this userspace program:
> > > > > > >
> > > > > > > ```
> > > > > > > $ cat dummy.c
> > > > > > > #include <stdio.h>
> > > > > > > int main(void) {
> > > > > > >   printf("hello world\n");
> > > > > > > }
> > > > > > > $ gcc -o dummy dummy.c
> > > > > > > ```
> > > > > > >
> > > > > > > Then build this BPF program and load it (change the path to p=
oint to
> > > > > > > the "dummy" binary you built):
> > > > > > >
> > > > > > > ```
> > > > > > > $ cat bpf-uprobe-kern.c
> > > > > > > #include <linux/bpf.h>
> > > > > > > #include <bpf/bpf_helpers.h>
> > > > > > > #include <bpf/bpf_tracing.h>
> > > > > > > char _license[] SEC("license") =3D "GPL";
> > > > > > >
> > > > > > > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > > > > > > int BPF_UPROBE(main_uprobe) {
> > > > > > >   bpf_printk("main uprobe triggered\n");
> > > > > > >   return 0;
> > > > > > > }
> > > > > > > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe=
-kern.c
> > > > > > > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test aut=
oattach
> > > > > > > ```
> > > > > > >
> > > > > > > Then run ./dummy in one terminal, and after launching it, run
> > > > > > > `sudo umount uprobe-test` in another terminal. Once the 10-se=
cond
> > > > > > > mdelay() is over, a use-after-free should occur, which may or=
 may
> > > > > > > not crash your kernel at the `prog->sleepable` check in
> > > > > > > bpf_prog_run_array_uprobe() depending on your luck.
> > > > > > > ---
> > > > > > > Changes in v2:
> > > > > > > - remove diff chunk in patch notes that confuses git
> > > > > > > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-upro=
be-uaf-v1-1-6869c8a17258@google.com
> > > > > > > ---
> > > > > > >  include/linux/bpf.h         | 4 ++--
> > > > > > >  kernel/trace/trace_uprobe.c | 2 +-
> > > > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > >
> > > > > > Looking at how similar in spirit bpf_prog_run_array() is meant =
to be
> > > > > > used, it seems like it is the caller's responsibility to
> > > > > > RCU-dereference array and keep RCU critical section before call=
ing
> > > > > > into bpf_prog_run_array(). So I wonder if it's best to do this =
instead
> > > > > > (Gmail will butcher the diff, but it's about the idea):
> > > > >
> > > > > Yeah, that's the other option I was considering. That would be mo=
re
> > > > > consistent with the existing bpf_prog_run_array(), but has the
> > > > > downside of unnecessarily pushing responsibility up to the caller=
...
> > > > > I'm fine with either.
> > > >
> > > > there is really just one caller ("legacy" singular uprobe handler),=
 so
> > > > I think this should be fine. Unless someone objects I'd keep it
> > > > consistent with other "prog_array_run" helpers
> > >
> > > Ack, I will make it consistent.
> > >
> > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > index eaee2a819f4c..4b8a9edd3727 100644
> > > > > > --- a/include/linux/bpf.h
> > > > > > +++ b/include/linux/bpf.h
> > > > > > @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_pro=
g_array *array,
> > > > > >   * rcu-protected dynamically sized maps.
> > > > > >   */
> > > > > >  static __always_inline u32
> > > > > > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *a=
rray_rcu,
> > > > > > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> > > > > >                           const void *ctx, bpf_prog_run_fn run_=
prog)
> > > > > >  {
> > > > > >         const struct bpf_prog_array_item *item;
> > > > > >         const struct bpf_prog *prog;
> > > > > > -       const struct bpf_prog_array *array;
> > > > > >         struct bpf_run_ctx *old_run_ctx;
> > > > > >         struct bpf_trace_run_ctx run_ctx;
> > > > > >         u32 ret =3D 1;
> > > > > >
> > > > > >         might_fault();
> > > > > > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu l=
ock held");
> > > > > > +
> > > > > > +       if (unlikely(!array))
> > > > > > +               goto out;
> > > > > >
> > > > > > -       rcu_read_lock_trace();
> > > > > >         migrate_disable();
> > > > > >
> > > > > >         run_ctx.is_uprobe =3D true;
> > > > > >
> > > > > > -       array =3D rcu_dereference_check(array_rcu, rcu_read_loc=
k_trace_held());
> > > > > > -       if (unlikely(!array))
> > > > > > -               goto out;
> > > > > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > > > >         item =3D &array->items[0];
> > > > > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > > > > @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
> > > > > > bpf_prog_array __rcu *array_rcu,
> > > > > >         bpf_reset_run_ctx(old_run_ctx);
> > > > > >  out:
> > > > > >         migrate_enable();
> > > > > > -       rcu_read_unlock_trace();
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_u=
probe.c
> > > > > > index fed382b7881b..87a2b8fefa90 100644
> > > > > > --- a/kernel/trace/trace_uprobe.c
> > > > > > +++ b/kernel/trace/trace_uprobe.c
> > > > > > @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct tra=
ce_uprobe *tu,
> > > > > >         if (bpf_prog_array_valid(call)) {
> > > > > >                 u32 ret;
> > > > > >
> > > > > > +               rcu_read_lock_trace();
> > > > > >                 ret =3D bpf_prog_run_array_uprobe(call->prog_ar=
ray,
> > > > > > regs, bpf_prog_run);
> > > > >
> > > > > But then this should be something like this (possibly split acros=
s
> > > > > multiple lines with a helper variable or such):
> > > > >
> > > > > ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call->pro=
g_array,
> > > > > rcu_read_lock_trace_held()), regs, bpf_prog_run);
> > > >
> > > > Yeah, absolutely, forgot to move the RCU dereference part, good cat=
ch!
> > > > But I wouldn't do the _check() variant here, literally the previous
> > > > line does rcu_read_trace_lock(), so this check part seems like just
> > > > unnecessary verboseness, I'd go with a simple rcu_dereference().
> > >
> > > rcu_dereference() is not legal there - that asserts that we are in a
> > > normal RCU read-side critical section, which we are not.
> > > rcu_dereference_raw() would be, but I think it is nice to document th=
e
> > > semantics to make it explicit under which lock we're operating.
>
> sure, I don't mind
>
> > >
> > > I'll send a v3 in a bit after testing it.
> >
> > Actually, now I'm still hitting a page fault with my WIP v3 fix
> > applied... I'll probably poke at this some more next week.
>
> OK, that's interesting, keep us posted!

If I replace the "uprobe/" in my reproducer with "uprobe.s/", the
reproducer stops crashing even on bpf/master without this fix -
because it happens that handle_swbp() is already holding a
rcu_read_lock_trace() lock way up the stack. So I think this fix
should still be applied, but it probably doesn't need to go into
stable unless there is another path to the buggy code that doesn't
come from handle_swbp(). I guess I probably should resend my patch
with an updated commit message pointing out this caveat?

The problem I'm actually hitting seems to be a use-after-free of a
"struct bpf_prog" because of mismatching RCU flavors. Uprobes always
use bpf_prog_run_array_uprobe() under tasks-trace-RCU protection. But
it is possible to attach a non-sleepable BPF program to a uprobe, and
non-sleepable BPF programs are freed via normal RCU (see
__bpf_prog_put_noref()). And that is what happens with the reproducer
from my initial post
(https://lore.kernel.org/all/20241206-bpf-fix-uprobe-uaf-v1-1-6869c8a17258@=
google.com/)
- I can see that __bpf_prog_put_noref runs with prog->sleepable=3D=3D0.

So I think that while I am delaying execution in
bpf_prog_run_array_uprobe(), perf_event_detach_bpf_prog() NULLs out
the event->tp_event->prog_array pointer and does
bpf_prog_array_free_sleepable() followed by bpf_prog_put(), and then
the BPF program can be freed since the reader doesn't hold an RCU read
lock. This seems a bit annoying to fix - there could legitimately be
several versions of the bpf_prog_array that are still used by
tasks-trace-RCU readers, so I think we can't just NULL out the array
entry and use RCU for the bpf_prog_array access on the reader side. I
guess we could add another flag on BPF programs that answers "should
this program be freed via tasks-trace-RCU" (separately from whether
the program is sleepable)?

