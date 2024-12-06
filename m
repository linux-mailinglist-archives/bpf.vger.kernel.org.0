Return-Path: <bpf+bounces-46338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B29E7C53
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD0C16A00E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACC212FA7;
	Fri,  6 Dec 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbWCjxFC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E45D22C6CD;
	Fri,  6 Dec 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526949; cv=none; b=rKkx77LjYrzbf5OUrfTpzdi8Z83ctNWPoR7scUpZc9F7X5Mao80vTqHSSY3wWOCEYjvqIqKlkx8TnrNqsnxdHezoNk3V1uOR3OkWmg/aBS19aAYncRmCQfr+YBNzagvvJHHt9JDzzpXp8+ZPPhUr16Nful2M1n9+caPEzt4TaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526949; c=relaxed/simple;
	bh=9F/F4giPpP32A6A7C04HQNAFQyYWRCkBKV9sbUu8lvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWQJuksR1re2xacNZnIJmFDtqfjBymI6XfLKYHnBSOvFeHDSXSd4akXJYsv5zWo8xL/sJD5+QXAVebXl88jJY6GkqpzdwHC8vjD3vHJ4obZO4hEbIZmNAYx9dyy5iEkipwQsKrah7H4Om23A0ydEHeJMVdN60eLy967sq5JI9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbWCjxFC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so777040a91.2;
        Fri, 06 Dec 2024 15:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733526947; x=1734131747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no0juUaCcALGUIqEv5DeGtCGbkiGhdc8yZUM3kdyKWE=;
        b=KbWCjxFCUmmXebmzDel3g9AKg5V9Cb/9501vY/hJ4Z3WcyUCvVDP8Awj2Xxu+cSlyx
         jXbutWFoScUQ0N/3AMor4VIvnsIhY9H30vmwOjsHjBNQ7eJszn1p6RYIxNxt36EfP0PF
         jHWe5FC7HTXAadN0IHvcflKyEEtjE9DcVCdrxo6P/fO2xke9yZoYQYNUJ8FNVKayiSu8
         T2fvrnEGUAxzE0VNjDTDdgp+qtFUQZq8Gj2r2m0DlerpELC8cLG0EFLFMAlGEvhuKoOX
         W1XwRwq+7/W66XT8Z8yEgSGFxuMeAWTuWXyqxHn0qs2CK7qkUe9CZkyOg/O2e/KOOFep
         OdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733526947; x=1734131747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no0juUaCcALGUIqEv5DeGtCGbkiGhdc8yZUM3kdyKWE=;
        b=Z2rTCYcm7BdkTESV87nrQ2j1I3ATIbGZsvp8jHjj+T6XWyuPlLJ05WEzgrormsAfDT
         IZ/Ps4jCLISWSwsZ3vdSHsB48Bkr4J/72oE8ktI/0N8zh4U2zr6HtlETA9/OAdNqXl7T
         jusYf8VlPeoe6c0MV9OON80AFdoo0SbUvmK1mUApzWIYmnRwGlhHQ1w035ze781ob5UZ
         KcpdXlmMY7K8Q2CHqKONYlPmILMJscNsIb3p8uE9KhTj/HaVSwdfxa7Y4yKJ8FF6wL3J
         zaGzOjr4BTm53agMIZDb58Ijhxq0hSMNDTVDhYcHnHrQ1JaokyS1kHEGobUEnLt2HRRn
         l+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUWOrirYprLykKmBWYlST1ZjfEte4NM00Td94a8BoS70yxBwdYbJQrXHniWWAqz0xMT79E=@vger.kernel.org, AJvYcCWxbLvp+3Vo6KU8z7lQQN/N4qQALrfzlZBNjFd2+uZMIzXJSyvO5OwLJPzd1dUQJWqak+uHheKo@vger.kernel.org, AJvYcCXfakCtKdTxk2B5lb3QOOL9pJ+nauKyzr9m+koHIKqzdToLFN+hzcfl/vdKDkmKt/SezUyCom9f1ILwWe++@vger.kernel.org, AJvYcCXn9EriNyR43NbdI7KrxHKaqNAZKUNqYU5SqkDoT+N0tPpQopyxmQAlOQszlhBh3wDX2mzGJdGhM6E2m2f1nWFO/Nnk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Wdb/RxGvJLUDZBpMdhb1MjquGaHqbRfNr3mRaspFLU9xawRI
	32EsNvGadHFf7XSA/tJO8HlZOeHWz81LookhibsGqX4g8zsTbPM3PRJCUeE2VZcTEcOIAXplNpi
	Mh0luJJskHe3t5GENqsvoflbyHaI=
X-Gm-Gg: ASbGncv5iCVNaVlGDUkobE0pnjwx6X+xCsPy/AahbzdsyChsue//UBF/9ESfRZg7mji
	qpPcX0oGjQ9bY5yIGN0SmDw9E6UeBSzg/1JBueZoKN6H40dY=
X-Google-Smtp-Source: AGHT+IHaVRP4A0F8o2pG6f+77//trBtX2VvbMDQFUG59vltVgyGY7gieh5pJ0J45NZI241N9YVcWSSJcD/7/v7Yld4M=
X-Received: by 2002:a17:90b:2e0c:b0:2ee:5111:a54b with SMTP id
 98e67ed59e1d1-2ef6aaf3360mr6469939a91.31.1733526946096; Fri, 06 Dec 2024
 15:15:46 -0800 (PST)
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
 <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com> <CAG48ez2+3TTbWNNO4aqxFAX8Cd4COaayRxoy1V2xvM9oS2_ygQ@mail.gmail.com>
In-Reply-To: <CAG48ez2+3TTbWNNO4aqxFAX8Cd4COaayRxoy1V2xvM9oS2_ygQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 15:15:34 -0800
Message-ID: <CAEf4BzbhDkFq9DB2VKxsHmffynQBvbD_RVKTUm3zCqvO_e1dug@mail.gmail.com>
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

On Fri, Dec 6, 2024 at 3:14=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Dec 6, 2024 at 11:43=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Fri, Dec 6, 2024 at 11:30=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > > >
> > > > On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@google.c=
om> wrote:
> > > > > >
> > > > > > Currently, the pointer stored in call->prog_array is loaded in
> > > > > > __uprobe_perf_func(), with no RCU annotation and no RCU protect=
ion, so the
> > > > > > loaded pointer can immediately be dangling. Later,
> > > > > > bpf_prog_run_array_uprobe() starts a RCU-trace read-side critic=
al section,
> > > > > > but this is too late. It then uses rcu_dereference_check(), but=
 this use of
> > > > > > rcu_dereference_check() does not actually dereference anything.
> > > > > >
> > > > > > It looks like the intention was to pass a pointer to the member
> > > > > > call->prog_array into bpf_prog_run_array_uprobe() and actually =
dereference
> > > > > > the pointer in there. Fix the issue by actually doing that.
> > > > > >
> > > > > > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chain=
ing gps")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > > ---
> > > > > > To reproduce, in include/linux/bpf.h, patch in a mdelay(10000) =
directly
> > > > > > before the might_fault() in bpf_prog_run_array_uprobe() and add=
 an
> > > > > > include of linux/delay.h.
> > > > > >
> > > > > > Build this userspace program:
> > > > > >
> > > > > > ```
> > > > > > $ cat dummy.c
> > > > > > #include <stdio.h>
> > > > > > int main(void) {
> > > > > >   printf("hello world\n");
> > > > > > }
> > > > > > $ gcc -o dummy dummy.c
> > > > > > ```
> > > > > >
> > > > > > Then build this BPF program and load it (change the path to poi=
nt to
> > > > > > the "dummy" binary you built):
> > > > > >
> > > > > > ```
> > > > > > $ cat bpf-uprobe-kern.c
> > > > > > #include <linux/bpf.h>
> > > > > > #include <bpf/bpf_helpers.h>
> > > > > > #include <bpf/bpf_tracing.h>
> > > > > > char _license[] SEC("license") =3D "GPL";
> > > > > >
> > > > > > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > > > > > int BPF_UPROBE(main_uprobe) {
> > > > > >   bpf_printk("main uprobe triggered\n");
> > > > > >   return 0;
> > > > > > }
> > > > > > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-k=
ern.c
> > > > > > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoa=
ttach
> > > > > > ```
> > > > > >
> > > > > > Then run ./dummy in one terminal, and after launching it, run
> > > > > > `sudo umount uprobe-test` in another terminal. Once the 10-seco=
nd
> > > > > > mdelay() is over, a use-after-free should occur, which may or m=
ay
> > > > > > not crash your kernel at the `prog->sleepable` check in
> > > > > > bpf_prog_run_array_uprobe() depending on your luck.
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - remove diff chunk in patch notes that confuses git
> > > > > > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe=
-uaf-v1-1-6869c8a17258@google.com
> > > > > > ---
> > > > > >  include/linux/bpf.h         | 4 ++--
> > > > > >  kernel/trace/trace_uprobe.c | 2 +-
> > > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > >
> > > > > Looking at how similar in spirit bpf_prog_run_array() is meant to=
 be
> > > > > used, it seems like it is the caller's responsibility to
> > > > > RCU-dereference array and keep RCU critical section before callin=
g
> > > > > into bpf_prog_run_array(). So I wonder if it's best to do this in=
stead
> > > > > (Gmail will butcher the diff, but it's about the idea):
> > > >
> > > > Yeah, that's the other option I was considering. That would be more
> > > > consistent with the existing bpf_prog_run_array(), but has the
> > > > downside of unnecessarily pushing responsibility up to the caller..=
.
> > > > I'm fine with either.
> > >
> > > there is really just one caller ("legacy" singular uprobe handler), s=
o
> > > I think this should be fine. Unless someone objects I'd keep it
> > > consistent with other "prog_array_run" helpers
> >
> > Ack, I will make it consistent.
> >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index eaee2a819f4c..4b8a9edd3727 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_prog_=
array *array,
> > > > >   * rcu-protected dynamically sized maps.
> > > > >   */
> > > > >  static __always_inline u32
> > > > > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *arr=
ay_rcu,
> > > > > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> > > > >                           const void *ctx, bpf_prog_run_fn run_pr=
og)
> > > > >  {
> > > > >         const struct bpf_prog_array_item *item;
> > > > >         const struct bpf_prog *prog;
> > > > > -       const struct bpf_prog_array *array;
> > > > >         struct bpf_run_ctx *old_run_ctx;
> > > > >         struct bpf_trace_run_ctx run_ctx;
> > > > >         u32 ret =3D 1;
> > > > >
> > > > >         might_fault();
> > > > > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu loc=
k held");
> > > > > +
> > > > > +       if (unlikely(!array))
> > > > > +               goto out;
> > > > >
> > > > > -       rcu_read_lock_trace();
> > > > >         migrate_disable();
> > > > >
> > > > >         run_ctx.is_uprobe =3D true;
> > > > >
> > > > > -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_=
trace_held());
> > > > > -       if (unlikely(!array))
> > > > > -               goto out;
> > > > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > > >         item =3D &array->items[0];
> > > > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > > > @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
> > > > > bpf_prog_array __rcu *array_rcu,
> > > > >         bpf_reset_run_ctx(old_run_ctx);
> > > > >  out:
> > > > >         migrate_enable();
> > > > > -       rcu_read_unlock_trace();
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_upr=
obe.c
> > > > > index fed382b7881b..87a2b8fefa90 100644
> > > > > --- a/kernel/trace/trace_uprobe.c
> > > > > +++ b/kernel/trace/trace_uprobe.c
> > > > > @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct trace=
_uprobe *tu,
> > > > >         if (bpf_prog_array_valid(call)) {
> > > > >                 u32 ret;
> > > > >
> > > > > +               rcu_read_lock_trace();
> > > > >                 ret =3D bpf_prog_run_array_uprobe(call->prog_arra=
y,
> > > > > regs, bpf_prog_run);
> > > >
> > > > But then this should be something like this (possibly split across
> > > > multiple lines with a helper variable or such):
> > > >
> > > > ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call->prog_=
array,
> > > > rcu_read_lock_trace_held()), regs, bpf_prog_run);
> > >
> > > Yeah, absolutely, forgot to move the RCU dereference part, good catch=
!
> > > But I wouldn't do the _check() variant here, literally the previous
> > > line does rcu_read_trace_lock(), so this check part seems like just
> > > unnecessary verboseness, I'd go with a simple rcu_dereference().
> >
> > rcu_dereference() is not legal there - that asserts that we are in a
> > normal RCU read-side critical section, which we are not.
> > rcu_dereference_raw() would be, but I think it is nice to document the
> > semantics to make it explicit under which lock we're operating.

sure, I don't mind

> >
> > I'll send a v3 in a bit after testing it.
>
> Actually, now I'm still hitting a page fault with my WIP v3 fix
> applied... I'll probably poke at this some more next week.

OK, that's interesting, keep us posted!

