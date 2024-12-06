Return-Path: <bpf+bounces-46337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929279E7C4E
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD95169B02
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCBC212FB3;
	Fri,  6 Dec 2024 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXSPzv9B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F46212FA3
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526865; cv=none; b=sac7ECvCC9OgAqneNCUqHckhTSTKzUUZD1wcr02td/m2INT7YKh6SInVoAnRdkcFmp/GjdlPJFtqi87FTqjDDI1RxlNo5H7DFop5lt9nEYeirXisfJatVSlXkVHeNuVleaAvi+vzIK+ExArHx+ROHxSKnsYqTesNKPCpRbcqWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526865; c=relaxed/simple;
	bh=nr5ePPbtBK2X8uG6dSt4bEjpaGmviojpuJaDVxzFKlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMmjyiZI9DcUUaCfGi3ngPQwHl5lqwj1/H0cr+/Hgx/hfZfTOBx3nKtC8Z+hWw6YDAJCgx6sRx/ql3zfAn0NCAogKMGXqfliZMN2ynBJvgy71SGAgg1ET0Ot6IDcdVYGPI4o8RIxCWSNy9sYc34gBqc/erDcNAFdiEv/NPu0LWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXSPzv9B; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d1228d66a0so637a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 15:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733526862; x=1734131662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT70/4haykowxKJLSO2D1Td5mevQmnkZI/GztOJ/4fM=;
        b=qXSPzv9B5zrGpBSTqmtmnGte35c6q9CyuaibTtCEYOaFYa/GR87w8ATYtLV99CfnFB
         3Vmf+v4yavNa6KSJUHA80T6GQjBVP7Uj/XvkywsjRm8SccMqNJJetZEa/dvXD4t9nV9j
         NMqBWDinBFBMUpwtEgptrCLrXATCmCMtN0iTWcIdx6/vGmJlWjQxLT3T9QoVoAOYsx/D
         GC8XOyLxl2645YXr1bqgwPtaZM/oJdAm982TSN23CM4wj75PgsytIukiY8PUc2vnpgBD
         35goHEcXImdUtzVULOqZRFIi4AJHxQ1ZxnU9e97mqR9FiDE/qSaNV2ZVZw8+mvsk4ExJ
         E+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733526862; x=1734131662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT70/4haykowxKJLSO2D1Td5mevQmnkZI/GztOJ/4fM=;
        b=WV15t8qT6BR4z/TLHyeOIjVQTznM9Uk6Bf3dmYij4LhkwVrTKJhKMyzDRMqaZDSTPk
         OGeNVx9XzHVBfss3ygiWQZFfC0H9YHhSpB9/j3hJRemCP6AAxBmIKnWXw16y+24x2eux
         zeEK0Dix+pCrv0/dG4y+kBqmtI3Z1VoGlIWED+vy/GMzr0ToyExbeqNY3BeJSOrsAvO7
         bwlz37qDb/ngTtoDfP8yByGz3lu9mNMJHGiVKYvc3U629xuUQfsKRWepaJgw3vBWl1uw
         qtLBZcmDMtnFOZB8KV3BJICURaKNS3TYI1WXlrdkYnMFnRbeAVHjIR402Nxhf3vAicsk
         dICQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZm3eDVlJd1AUtBzt4EbJpT60zwNZXxEeB+o4OvC++/nQ9ZJmNlV9+pKO0iyPPXTiL/EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35aCYUXhjAuZup67XnDU/ZN6ywFceB3uT31AdvsvH6qJYzODF
	bNMEjVEk0dXX8btOzyzI3I/wKz6CZvhewWYtRKKdDcBowlrC38ljNjUL83T92sxfDWN8m/Gk4eB
	l3ncE8nhiIhhiuZ9gGvAewTh/Qzcc/cASCEht
X-Gm-Gg: ASbGnctswneMESV15xaz87cPgjbtV2gXwjVy40wkGX8fFksNV1zgX2LxXUaLaSZxiY8
	VcVPgYQpFKxsQjr+lenI4k9xowZZ0TRJowzhMme8F8vSuBk9MZGJB4illvs+mIw8=
X-Google-Smtp-Source: AGHT+IFvqea0ygicIaaMKdKwMVrDYelzBAhoiklcQz+KZTVCeOG7wm/s4JtUPWbUATXoft/BlVZ3YIswZ48TXkXHTeU=
X-Received: by 2002:a05:6402:1346:b0:5d0:b20c:205c with SMTP id
 4fb4d7f45d1cf-5d3dd9dd1a9mr11075a12.5.1733526861427; Fri, 06 Dec 2024
 15:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
 <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
 <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com>
 <CAEf4BzYkGQ0sw9JEeAMLAfcQbzxwg46c487kBD_LcbZSaTKD5Q@mail.gmail.com> <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com>
In-Reply-To: <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Sat, 7 Dec 2024 00:13:45 +0100
Message-ID: <CAG48ez2+3TTbWNNO4aqxFAX8Cd4COaayRxoy1V2xvM9oS2_ygQ@mail.gmail.com>
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

On Fri, Dec 6, 2024 at 11:43=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Fri, Dec 6, 2024 at 11:30=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > >
> > > On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@google.com=
> wrote:
> > > > >
> > > > > Currently, the pointer stored in call->prog_array is loaded in
> > > > > __uprobe_perf_func(), with no RCU annotation and no RCU protectio=
n, so the
> > > > > loaded pointer can immediately be dangling. Later,
> > > > > bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical=
 section,
> > > > > but this is too late. It then uses rcu_dereference_check(), but t=
his use of
> > > > > rcu_dereference_check() does not actually dereference anything.
> > > > >
> > > > > It looks like the intention was to pass a pointer to the member
> > > > > call->prog_array into bpf_prog_run_array_uprobe() and actually de=
reference
> > > > > the pointer in there. Fix the issue by actually doing that.
> > > > >
> > > > > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chainin=
g gps")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > ---
> > > > > To reproduce, in include/linux/bpf.h, patch in a mdelay(10000) di=
rectly
> > > > > before the might_fault() in bpf_prog_run_array_uprobe() and add a=
n
> > > > > include of linux/delay.h.
> > > > >
> > > > > Build this userspace program:
> > > > >
> > > > > ```
> > > > > $ cat dummy.c
> > > > > #include <stdio.h>
> > > > > int main(void) {
> > > > >   printf("hello world\n");
> > > > > }
> > > > > $ gcc -o dummy dummy.c
> > > > > ```
> > > > >
> > > > > Then build this BPF program and load it (change the path to point=
 to
> > > > > the "dummy" binary you built):
> > > > >
> > > > > ```
> > > > > $ cat bpf-uprobe-kern.c
> > > > > #include <linux/bpf.h>
> > > > > #include <bpf/bpf_helpers.h>
> > > > > #include <bpf/bpf_tracing.h>
> > > > > char _license[] SEC("license") =3D "GPL";
> > > > >
> > > > > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > > > > int BPF_UPROBE(main_uprobe) {
> > > > >   bpf_printk("main uprobe triggered\n");
> > > > >   return 0;
> > > > > }
> > > > > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-ker=
n.c
> > > > > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoatt=
ach
> > > > > ```
> > > > >
> > > > > Then run ./dummy in one terminal, and after launching it, run
> > > > > `sudo umount uprobe-test` in another terminal. Once the 10-second
> > > > > mdelay() is over, a use-after-free should occur, which may or may
> > > > > not crash your kernel at the `prog->sleepable` check in
> > > > > bpf_prog_run_array_uprobe() depending on your luck.
> > > > > ---
> > > > > Changes in v2:
> > > > > - remove diff chunk in patch notes that confuses git
> > > > > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-u=
af-v1-1-6869c8a17258@google.com
> > > > > ---
> > > > >  include/linux/bpf.h         | 4 ++--
> > > > >  kernel/trace/trace_uprobe.c | 2 +-
> > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > >
> > > > Looking at how similar in spirit bpf_prog_run_array() is meant to b=
e
> > > > used, it seems like it is the caller's responsibility to
> > > > RCU-dereference array and keep RCU critical section before calling
> > > > into bpf_prog_run_array(). So I wonder if it's best to do this inst=
ead
> > > > (Gmail will butcher the diff, but it's about the idea):
> > >
> > > Yeah, that's the other option I was considering. That would be more
> > > consistent with the existing bpf_prog_run_array(), but has the
> > > downside of unnecessarily pushing responsibility up to the caller...
> > > I'm fine with either.
> >
> > there is really just one caller ("legacy" singular uprobe handler), so
> > I think this should be fine. Unless someone objects I'd keep it
> > consistent with other "prog_array_run" helpers
>
> Ack, I will make it consistent.
>
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index eaee2a819f4c..4b8a9edd3727 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_prog_ar=
ray *array,
> > > >   * rcu-protected dynamically sized maps.
> > > >   */
> > > >  static __always_inline u32
> > > > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array=
_rcu,
> > > > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> > > >                           const void *ctx, bpf_prog_run_fn run_prog=
)
> > > >  {
> > > >         const struct bpf_prog_array_item *item;
> > > >         const struct bpf_prog *prog;
> > > > -       const struct bpf_prog_array *array;
> > > >         struct bpf_run_ctx *old_run_ctx;
> > > >         struct bpf_trace_run_ctx run_ctx;
> > > >         u32 ret =3D 1;
> > > >
> > > >         might_fault();
> > > > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock =
held");
> > > > +
> > > > +       if (unlikely(!array))
> > > > +               goto out;
> > > >
> > > > -       rcu_read_lock_trace();
> > > >         migrate_disable();
> > > >
> > > >         run_ctx.is_uprobe =3D true;
> > > >
> > > > -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_tr=
ace_held());
> > > > -       if (unlikely(!array))
> > > > -               goto out;
> > > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > >         item =3D &array->items[0];
> > > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > > @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
> > > > bpf_prog_array __rcu *array_rcu,
> > > >         bpf_reset_run_ctx(old_run_ctx);
> > > >  out:
> > > >         migrate_enable();
> > > > -       rcu_read_unlock_trace();
> > > >         return ret;
> > > >  }
> > > >
> > > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprob=
e.c
> > > > index fed382b7881b..87a2b8fefa90 100644
> > > > --- a/kernel/trace/trace_uprobe.c
> > > > +++ b/kernel/trace/trace_uprobe.c
> > > > @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct trace_u=
probe *tu,
> > > >         if (bpf_prog_array_valid(call)) {
> > > >                 u32 ret;
> > > >
> > > > +               rcu_read_lock_trace();
> > > >                 ret =3D bpf_prog_run_array_uprobe(call->prog_array,
> > > > regs, bpf_prog_run);
> > >
> > > But then this should be something like this (possibly split across
> > > multiple lines with a helper variable or such):
> > >
> > > ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call->prog_ar=
ray,
> > > rcu_read_lock_trace_held()), regs, bpf_prog_run);
> >
> > Yeah, absolutely, forgot to move the RCU dereference part, good catch!
> > But I wouldn't do the _check() variant here, literally the previous
> > line does rcu_read_trace_lock(), so this check part seems like just
> > unnecessary verboseness, I'd go with a simple rcu_dereference().
>
> rcu_dereference() is not legal there - that asserts that we are in a
> normal RCU read-side critical section, which we are not.
> rcu_dereference_raw() would be, but I think it is nice to document the
> semantics to make it explicit under which lock we're operating.
>
> I'll send a v3 in a bit after testing it.

Actually, now I'm still hitting a page fault with my WIP v3 fix
applied... I'll probably poke at this some more next week.

