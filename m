Return-Path: <bpf+bounces-46429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA09EA218
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A109928490B
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B82B19E97A;
	Mon,  9 Dec 2024 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chAiGUEF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00615B122;
	Mon,  9 Dec 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784356; cv=none; b=f/0IU6gKx8im67vL1SE/HnK85MYZ657b54OGaoeRtet4faM3fXyDBrt2Jtp0P1OgrFFEptPD1GAOI3chxau3ATRErbQ+XfcJpZMP444vHtQBauprUYUCodhZCMZbrEinLPJoMHCOmHds6iO8Tcvgr+qv5+o/f5uUSG/jIXD/XK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784356; c=relaxed/simple;
	bh=NLP5VOtSFdiHXmiElJyaX2KUAl2oXVMH5AemMiNPEgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ht1gjbwkx4VLZLsBma9jevUhf92J8yRTYnkPx90C24hEXa8FhxoRrKCdT+id/F8YT0LPZrcbY152vEaA7Llpfpp3O5nqy2mZ7I7qfSEoD6TDrga/qEjj7+6j0iheBkuD1/2TILBpdeMg78iCypW3jLwN+MOMNMqPonE6438c6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chAiGUEF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163b0c09afso18427525ad.0;
        Mon, 09 Dec 2024 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733784354; x=1734389154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJHVqDkHi4E1/pJGHTygt9PcEAk4UE2nomAXM0pjfwU=;
        b=chAiGUEFYV5kQffdyzJRTw1RuDMF5HaTLdkxkdA+rLQpAlIqwwSPRoegVPPdZrxLvd
         OCQwu39eNETvzCKaRCx7Hbw2EO8GaXNCm7b7EgPC2JvcL1k8qCENu2Qr3CANJ+heJmI7
         S4pGPEhfd8Z3C5y7w5DV2wp+JWzWK77Ywz8QUmgnRZUWoTUQCv53XFAyu4EtihgJrK3p
         rIx86ZD6uj2Ba1zdBUcRUsuzsmGogHRzL6dheibU71VnnofXFubhj5GNrmmlSn5f1JnL
         8cszXvDfuZPq8Oy/RIClMsXDAKqBdkytvfSqCtqx47oes+sn5CQhilaqHVHPfUIFLzDF
         GWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733784354; x=1734389154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJHVqDkHi4E1/pJGHTygt9PcEAk4UE2nomAXM0pjfwU=;
        b=Q4wj0j6nonYNQpMwBFTdutwdBKjVl+H+q1sRWabI+k6MHzTrnSUGmUZ32oqPGG2Sxh
         6VG0TqUsTBeseRSPFtM/ou8NkGGbpQYKvw/dh0aestgb4eoehOhN9tkQHPlHIeo0/dvL
         Xucl6p1XyKpO0uJUHwiZT8fw5PaNmzoHMu4ucjYRfszR7V2XKpz2o0ouFDsIE2cDoJfD
         jvHPsTwWpolOJqrWxSgKMvGPuPmdYjg17yP7nM7578yfgnjHjZoycXz0fZd5n6M6cXl9
         +t3x8cTpjvMAwwlFhSyeiooVlywjywPyOvB3vHImXYvFV/scMfe54/vnaljLarvhSaen
         DOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRxkHngXD75txh0gG7VvAk4PKSUsmHbMqYETGfK3jVVajJe+A9xlJeub7q5TNQcPfcrpH49CI+@vger.kernel.org, AJvYcCVU6lePHrg3skcaN/Ox7n13w0hlToARVxh+NU1LRWidipj2ENG67xLmwLWnDYOE6rPipKOSRVwn7AA6kTvO@vger.kernel.org, AJvYcCWDTdseoKNaDHVkFvGuYiqB3xHzOUG+A4at3OtBWVE56CDyblQV8Xoo04qB0+wsJ8imU+Q=@vger.kernel.org, AJvYcCWFTSfG/9FhVoimiOJQSjBkOlM1NK5BQ6KwQc3O6yLPsrGxGobf/rfWDg68Fc1+douuqqColvloxF4p/lkZjo7wGd7y@vger.kernel.org
X-Gm-Message-State: AOJu0Ywki2I0/NtQHk2ujqbBZUf+BU9/x3776owEaGB699PJwUHQtkO3
	UtGn89TOfruzCUwnKAAq+Y84kg/Ow9sdQnCrtpqdsSpLCHYptyyDEoaNaQZfxp6VBvE/OGBkPau
	Sxh4PQqHGgTkx3UFDOfK2QE6VGxM=
X-Gm-Gg: ASbGncvH8iotvyzJVjF+XgTNcbrLKhDmTdWsFWTztHbGR7x17AOIR2pAJ+hgx+TlL35
	NcyWU+V4HbYHXwUJvjVTSjTBPoPCWZn36iwl+jFV4Zg23hHHbjbM=
X-Google-Smtp-Source: AGHT+IHT3HS2Xag5qa8MimQxz3G7wvVeXrp5ucuGDfMhjIWKcW3B9m0UqqF1HChvZf8KU3zZvoSSthNBIX16JTiukY8=
X-Received: by 2002:a17:903:1787:b0:211:e812:3948 with SMTP id
 d9443c01a7336-2161393ebe6mr220620435ad.0.1733784354088; Mon, 09 Dec 2024
 14:45:54 -0800 (PST)
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
 <CAG48ez2+3TTbWNNO4aqxFAX8Cd4COaayRxoy1V2xvM9oS2_ygQ@mail.gmail.com>
 <CAEf4BzbhDkFq9DB2VKxsHmffynQBvbD_RVKTUm3zCqvO_e1dug@mail.gmail.com>
 <CAG48ez2LW9zyiptNq8jApD3zeS05wvNPs-jj2zOeaCDQbZnD4g@mail.gmail.com> <CAEf4BzbVqfWZUJUkUwJvfaGViwiP8cnVAYAWX67LP-ejPvmAPA@mail.gmail.com>
In-Reply-To: <CAEf4BzbVqfWZUJUkUwJvfaGViwiP8cnVAYAWX67LP-ejPvmAPA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Dec 2024 14:45:41 -0800
Message-ID: <CAEf4BzbzXT6e-dKtxr6SDzekXC+Zu45uX10dL+DuTA8Xn=cgjw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:14=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 9, 2024 at 10:22=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Sat, Dec 7, 2024 at 12:15=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Fri, Dec 6, 2024 at 3:14=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > > > On Fri, Dec 6, 2024 at 11:43=E2=80=AFPM Jann Horn <jannh@google.com=
> wrote:
> > > > > On Fri, Dec 6, 2024 at 11:30=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Jann Horn <jannh@google.=
com> wrote:
> > > > > > >
> > > > > > > On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@go=
ogle.com> wrote:
> > > > > > > > >
> > > > > > > > > Currently, the pointer stored in call->prog_array is load=
ed in
> > > > > > > > > __uprobe_perf_func(), with no RCU annotation and no RCU p=
rotection, so the
> > > > > > > > > loaded pointer can immediately be dangling. Later,
> > > > > > > > > bpf_prog_run_array_uprobe() starts a RCU-trace read-side =
critical section,
> > > > > > > > > but this is too late. It then uses rcu_dereference_check(=
), but this use of
> > > > > > > > > rcu_dereference_check() does not actually dereference any=
thing.
> > > > > > > > >
> > > > > > > > > It looks like the intention was to pass a pointer to the =
member
> > > > > > > > > call->prog_array into bpf_prog_run_array_uprobe() and act=
ually dereference
> > > > > > > > > the pointer in there. Fix the issue by actually doing tha=
t.
> > > > > > > > >
> > > > > > > > > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by=
 chaining gps")
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > > > > > ---
> > > > > > > > > To reproduce, in include/linux/bpf.h, patch in a mdelay(1=
0000) directly
> > > > > > > > > before the might_fault() in bpf_prog_run_array_uprobe() a=
nd add an
> > > > > > > > > include of linux/delay.h.
> > > > > > > > >
> > > > > > > > > Build this userspace program:
> > > > > > > > >
> > > > > > > > > ```
> > > > > > > > > $ cat dummy.c
> > > > > > > > > #include <stdio.h>
> > > > > > > > > int main(void) {
> > > > > > > > >   printf("hello world\n");
> > > > > > > > > }
> > > > > > > > > $ gcc -o dummy dummy.c
> > > > > > > > > ```
> > > > > > > > >
> > > > > > > > > Then build this BPF program and load it (change the path =
to point to
> > > > > > > > > the "dummy" binary you built):
> > > > > > > > >
> > > > > > > > > ```
> > > > > > > > > $ cat bpf-uprobe-kern.c
> > > > > > > > > #include <linux/bpf.h>
> > > > > > > > > #include <bpf/bpf_helpers.h>
> > > > > > > > > #include <bpf/bpf_tracing.h>
> > > > > > > > > char _license[] SEC("license") =3D "GPL";
> > > > > > > > >
> > > > > > > > > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > > > > > > > > int BPF_UPROBE(main_uprobe) {
> > > > > > > > >   bpf_printk("main uprobe triggered\n");
> > > > > > > > >   return 0;
> > > > > > > > > }
> > > > > > > > > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-up=
robe-kern.c
> > > > > > > > > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test=
 autoattach
> > > > > > > > > ```
> > > > > > > > >
> > > > > > > > > Then run ./dummy in one terminal, and after launching it,=
 run
> > > > > > > > > `sudo umount uprobe-test` in another terminal. Once the 1=
0-second
> > > > > > > > > mdelay() is over, a use-after-free should occur, which ma=
y or may
> > > > > > > > > not crash your kernel at the `prog->sleepable` check in
> > > > > > > > > bpf_prog_run_array_uprobe() depending on your luck.
> > > > > > > > > ---
> > > > > > > > > Changes in v2:
> > > > > > > > > - remove diff chunk in patch notes that confuses git
> > > > > > > > > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-=
uprobe-uaf-v1-1-6869c8a17258@google.com
> > > > > > > > > ---
> > > > > > > > >  include/linux/bpf.h         | 4 ++--
> > > > > > > > >  kernel/trace/trace_uprobe.c | 2 +-
> > > > > > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > >
> > > > > > > > Looking at how similar in spirit bpf_prog_run_array() is me=
ant to be
> > > > > > > > used, it seems like it is the caller's responsibility to
> > > > > > > > RCU-dereference array and keep RCU critical section before =
calling
> > > > > > > > into bpf_prog_run_array(). So I wonder if it's best to do t=
his instead
> > > > > > > > (Gmail will butcher the diff, but it's about the idea):
> > > > > > >
> > > > > > > Yeah, that's the other option I was considering. That would b=
e more
> > > > > > > consistent with the existing bpf_prog_run_array(), but has th=
e
> > > > > > > downside of unnecessarily pushing responsibility up to the ca=
ller...
> > > > > > > I'm fine with either.
> > > > > >
> > > > > > there is really just one caller ("legacy" singular uprobe handl=
er), so
> > > > > > I think this should be fine. Unless someone objects I'd keep it
> > > > > > consistent with other "prog_array_run" helpers
> > > > >
> > > > > Ack, I will make it consistent.
> > > > >
> > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > > index eaee2a819f4c..4b8a9edd3727 100644
> > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf=
_prog_array *array,
> > > > > > > >   * rcu-protected dynamically sized maps.
> > > > > > > >   */
> > > > > > > >  static __always_inline u32
> > > > > > > > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rc=
u *array_rcu,
> > > > > > > > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *arr=
ay,
> > > > > > > >                           const void *ctx, bpf_prog_run_fn =
run_prog)
> > > > > > > >  {
> > > > > > > >         const struct bpf_prog_array_item *item;
> > > > > > > >         const struct bpf_prog *prog;
> > > > > > > > -       const struct bpf_prog_array *array;
> > > > > > > >         struct bpf_run_ctx *old_run_ctx;
> > > > > > > >         struct bpf_trace_run_ctx run_ctx;
> > > > > > > >         u32 ret =3D 1;
> > > > > > > >
> > > > > > > >         might_fault();
> > > > > > > > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no r=
cu lock held");
> > > > > > > > +
> > > > > > > > +       if (unlikely(!array))
> > > > > > > > +               goto out;
> > > > > > > >
> > > > > > > > -       rcu_read_lock_trace();
> > > > > > > >         migrate_disable();
> > > > > > > >
> > > > > > > >         run_ctx.is_uprobe =3D true;
> > > > > > > >
> > > > > > > > -       array =3D rcu_dereference_check(array_rcu, rcu_read=
_lock_trace_held());
> > > > > > > > -       if (unlikely(!array))
> > > > > > > > -               goto out;
> > > > > > > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > > > > > >         item =3D &array->items[0];
> > > > > > > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > > > > > > @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struc=
t
> > > > > > > > bpf_prog_array __rcu *array_rcu,
> > > > > > > >         bpf_reset_run_ctx(old_run_ctx);
> > > > > > > >  out:
> > > > > > > >         migrate_enable();
> > > > > > > > -       rcu_read_unlock_trace();
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/tra=
ce_uprobe.c
> > > > > > > > index fed382b7881b..87a2b8fefa90 100644
> > > > > > > > --- a/kernel/trace/trace_uprobe.c
> > > > > > > > +++ b/kernel/trace/trace_uprobe.c
> > > > > > > > @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct=
 trace_uprobe *tu,
> > > > > > > >         if (bpf_prog_array_valid(call)) {
> > > > > > > >                 u32 ret;
> > > > > > > >
> > > > > > > > +               rcu_read_lock_trace();
> > > > > > > >                 ret =3D bpf_prog_run_array_uprobe(call->pro=
g_array,
> > > > > > > > regs, bpf_prog_run);
> > > > > > >
> > > > > > > But then this should be something like this (possibly split a=
cross
> > > > > > > multiple lines with a helper variable or such):
> > > > > > >
> > > > > > > ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call-=
>prog_array,
> > > > > > > rcu_read_lock_trace_held()), regs, bpf_prog_run);
> > > > > >
> > > > > > Yeah, absolutely, forgot to move the RCU dereference part, good=
 catch!
> > > > > > But I wouldn't do the _check() variant here, literally the prev=
ious
> > > > > > line does rcu_read_trace_lock(), so this check part seems like =
just
> > > > > > unnecessary verboseness, I'd go with a simple rcu_dereference()=
.
> > > > >
> > > > > rcu_dereference() is not legal there - that asserts that we are i=
n a
> > > > > normal RCU read-side critical section, which we are not.
> > > > > rcu_dereference_raw() would be, but I think it is nice to documen=
t the
> > > > > semantics to make it explicit under which lock we're operating.
> > >
> > > sure, I don't mind
> > >
> > > > >
> > > > > I'll send a v3 in a bit after testing it.
> > > >
> > > > Actually, now I'm still hitting a page fault with my WIP v3 fix
> > > > applied... I'll probably poke at this some more next week.
> > >
> > > OK, that's interesting, keep us posted!
> >
> > If I replace the "uprobe/" in my reproducer with "uprobe.s/", the
> > reproducer stops crashing even on bpf/master without this fix -
> > because it happens that handle_swbp() is already holding a
> > rcu_read_lock_trace() lock way up the stack. So I think this fix
> > should still be applied, but it probably doesn't need to go into
> > stable unless there is another path to the buggy code that doesn't
> > come from handle_swbp(). I guess I probably should resend my patch
> > with an updated commit message pointing out this caveat?
> >
> > The problem I'm actually hitting seems to be a use-after-free of a
> > "struct bpf_prog" because of mismatching RCU flavors. Uprobes always
> > use bpf_prog_run_array_uprobe() under tasks-trace-RCU protection. But
> > it is possible to attach a non-sleepable BPF program to a uprobe, and
> > non-sleepable BPF programs are freed via normal RCU (see
> > __bpf_prog_put_noref()). And that is what happens with the reproducer
> > from my initial post
> > (https://lore.kernel.org/all/20241206-bpf-fix-uprobe-uaf-v1-1-6869c8a17=
258@google.com/)
> > - I can see that __bpf_prog_put_noref runs with prog->sleepable=3D=3D0.
> >
> > So I think that while I am delaying execution in
> > bpf_prog_run_array_uprobe(), perf_event_detach_bpf_prog() NULLs out
> > the event->tp_event->prog_array pointer and does
> > bpf_prog_array_free_sleepable() followed by bpf_prog_put(), and then
> > the BPF program can be freed since the reader doesn't hold an RCU read
> > lock. This seems a bit annoying to fix - there could legitimately be
> > several versions of the bpf_prog_array that are still used by
> > tasks-trace-RCU readers, so I think we can't just NULL out the array
> > entry and use RCU for the bpf_prog_array access on the reader side. I
> > guess we could add another flag on BPF programs that answers "should
> > this program be freed via tasks-trace-RCU" (separately from whether
> > the program is sleepable)?
>
> Yes, we shouldn't NULL anything out.
>
> This is the same issue we've been solving recently for sleepable
> tracepoints, see [0] and other patches in the same patch set. We
> solved it for sleepable (aka "faultable") tracepoints, but uprobes
> have the same problem where the attachment point is sleepable by
> nature (and thus protected by RCU Tasks Trace), but BPF program itself
> is non-sleepable (and thus we only wait for synchronize_rcu() before
> freeing), which causes a disconnect.
>
> We can easily fix this for BPF link-based uprobes, but legacy uprobes
> can be directly attached to perf event, so that's a bit more
> cumbersome. Let me think what should be the best way to handle this.
>
> Meanwhile, I agree, please send your original fix (with changes we
> discussed), it's good to have them, even if they don't fix your
> original issue. I'll CC you on fixes once I have them.

Ok, weeding through the perf/uprobe plumbing for BPF, I think we avoid
this problem with uprobe BPF link because uprobe_unregister_sync()
waits for RCU Tasks Trace GP, and so once we finish uprobe
unregistration, we have a guarantee that there is no more uprobe that
might dereference our BPF program. (I might have thought about this
problem when fixing BPF link for sleepable tracepoints, but I missed
the legacy perf_event attach/detach case).

With legacy perf event perf_event_detach_bpf_prog() we don't do any of
that, we just NULL out pointer and do bpf_prog_put(), not caring
whether this is uprobe, kprobe, or tracepoint...

So one way to solve this is to either teach
perf_event_detach_bpf_prog() to delay bpf_prog_put() until after RCU
Tasks Trace GP (which is what we do with bpf_prog_array, but not the
program itself), or add prog->aux->sleepable_hook flag in addition to
prog->aux->sleepable, and then inside bpf_prog_put() check
(prog->aux->sleepable || prog->aux->sleepable_hook) and do RCU Tasks
Trace delay (in addition to normal call_rcu()).

Third alternative would be to have something like
bpf_prog_put_sleepable() (just like we have
bpf_prog_array_free_sleepable()), where this would do additional
call_rcu_tasks_trace() even if BPF program itself isn't sleepable.

Alexei, Daniel, any thoughts or preferences?

>
>   [0] https://lore.kernel.org/all/20241101181754.782341-1-andrii@kernel.o=
rg/

