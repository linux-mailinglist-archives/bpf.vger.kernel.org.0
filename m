Return-Path: <bpf+bounces-9478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A2979818B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 07:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4545E1C20C22
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 05:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F101867;
	Fri,  8 Sep 2023 05:30:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31D185F
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 05:30:20 +0000 (UTC)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B919B5
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 22:30:17 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a7d7283fe5so313190241.0
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 22:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20230601.gappssmtp.com; s=20230601; t=1694151016; x=1694755816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DXXbtOy0gKuK+MB1OMU+XafTuq40YrMtWCJBGOzInM=;
        b=1THCI+uH+qO0IMpxc/rtgnpvMqAKCyA8wJE47WRtSVJ06/oBJzYZemF/bsoG2rsoa+
         fz3OzkMPr77TVc/DqRB0Z5S4NrPXJ09a+cn8SnG7ZFdRWydfp4MgvKJvqFZF186RHWuJ
         Fp9YdNjzwMyXDSHnornju7/CGDj2PdBC2C36LQd4hwaq+dojsPBJvUUVflTqvlbbFjbE
         PoWvtpgnxf7C35J+gZBuIg5jgY9DgR2UbgllQ+X57G4aAxwLG0bbvFBDp09X/DNdilyB
         7MjmpGa8SL30uTbqXlAodKgVnkJCMC1tr/71He0/WaEQz0l0zVOFK/Q48fMJEa7je7l7
         Bwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694151016; x=1694755816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DXXbtOy0gKuK+MB1OMU+XafTuq40YrMtWCJBGOzInM=;
        b=RluKUbNYyIzkUG4RXKzl1qxg3UiCYqQQxIeu4zMga+/s+mHNBQv9AE5hG0TThDHwFH
         oTvZ9vDpaSWmyEygx4H0pcFmNxJ6iVVv7cgv9GTKBs9WfMhGFOgNEz/lCLPXTn22xeRT
         b8W9JyQihYPyp31IXXpNjMnwplaOKluhgstqLjqBTMCqcNZHeyep+eEDomHlDH6KQnXw
         oWb4W1iWg+IYLRwLq8wsGtme2ZI2j1kyqRQAGyU9L5G8kIdVs/k/Hhv06lWCNsv9A/dI
         0+HBT0/tcnauDxZafxNBhUuPErf/Fig+0R8xCs3kzOAXkf5Km4Y7j09ynH15fodgY5E4
         woJQ==
X-Gm-Message-State: AOJu0YyV7uYkR0V1PGHealc/nKFqhiehhzzp/OJPkRrWSBnqt+VjFeL1
	5OVHShjvGAh9Iwr6xHaJQpB8RBvFYVKwt+FYCf22Qg==
X-Google-Smtp-Source: AGHT+IGT08sM2EA22jQQumznZmCT635MMXH9vtlvljD0iSe7dlgoyrBqQyPlJ/Yk/Tth8duq0jXPFcB4LNMPng7+Gj8=
X-Received: by 2002:a67:fe50:0:b0:44d:506c:b9c9 with SMTP id
 m16-20020a67fe50000000b0044d506cb9c9mr1599599vsr.34.1694151016594; Thu, 07
 Sep 2023 22:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
 <87o7ienuss.fsf@toke.dk> <CAP01T76Ce2KHQqTGsqs5K9RM5qSv07rNxnV+-=q_J25i9NkqxA@mail.gmail.com>
 <87fs3qnnh4.fsf@toke.dk> <CAADnVQK-ov_rve4pM7McMDQd5E9U5-JPjT5522BaVWDH-NvM5g@mail.gmail.com>
 <8734zqnf3a.fsf@toke.dk> <CAADnVQLVM0-rerjRj1Jkk1J0d1QG6gN3B_bG-GVT179=hFB+xw@mail.gmail.com>
In-Reply-To: <CAADnVQLVM0-rerjRj1Jkk1J0d1QG6gN3B_bG-GVT179=hFB+xw@mail.gmail.com>
From: Hsin-Wei Hung <hsinweih@uci.edu>
Date: Thu, 7 Sep 2023 22:29:40 -0700
Message-ID: <CABcoxUboyUfgNoX06sRTX+P322kCEYBsdm9_G7Dn+iwL_HY2rw@mail.gmail.com>
Subject: Re: Possible deadlock in bpf queue map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 9:08=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 7, 2023 at 9:05=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@kernel.org> wrote:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> > > On Thu, Sep 7, 2023 at 6:04=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@kernel.org> wrote:
> > >>
> > >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> > >>
> > >> > On Thu, 7 Sept 2023 at 12:26, Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
> > >> >>
> > >> >> +Arnaldo
> > >> >>
> > >> >> > Hi,
> > >> >> >
> > >> >> > Our bpf fuzzer, a customized Syzkaller, triggered a lockdep war=
ning in
> > >> >> > the bpf queue map in v5.15. Since queue_stack_maps.c has no maj=
or changes
> > >> >> > since v5.15, we think this should still exist in the latest ker=
nel.
> > >> >> > The bug can be occasionally triggered, and we suspect one of th=
e
> > >> >> > eBPF programs involved to be the following one. We also attache=
d the lockdep
> > >> >> > warning at the end.
> > >> >> >
> > >> >> > #define DEFINE_BPF_MAP_NO_KEY(the_map, TypeOfMap, MapFlags,
> > >> >> > TypeOfValue, MaxEntries) \
> > >> >> >         struct {                                               =
         \
> > >> >> >             __uint(type, TypeOfMap);                           =
         \
> > >> >> >             __uint(map_flags, (MapFlags));                     =
         \
> > >> >> >             __uint(max_entries, (MaxEntries));                 =
         \
> > >> >> >             __type(value, TypeOfValue);                        =
         \
> > >> >> >         } the_map SEC(".maps");
> > >> >> >
> > >> >> > DEFINE_BPF_MAP_NO_KEY(map_0, BPF_MAP_TYPE_QUEUE, 0 | BPF_F_WRON=
LY,
> > >> >> > struct_0, 162);
> > >> >> > SEC("perf_event")
> > >> >> > int func(struct bpf_perf_event_data *ctx) {
> > >> >> >         char v0[96] =3D {};
> > >> >> >         uint64_t v1 =3D 0;
> > >> >> >         v1 =3D bpf_map_pop_elem(&map_0, v0);
> > >> >> >         return 163819661;
> > >> >> > }
> > >> >> >
> > >> >> >
> > >> >> > The program is attached to the following perf event.
> > >> >> >
> > >> >> > struct perf_event_attr attr_type_hw =3D {
> > >> >> >         .type =3D PERF_TYPE_HARDWARE,
> > >> >> >         .config =3D PERF_COUNT_HW_CPU_CYCLES,
> > >> >> >         .sample_freq =3D 50,
> > >> >> >         .inherit =3D 1,
> > >> >> >         .freq =3D 1,
> > >> >> > };
> > >> >> >
> > >> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DWARNING: inconsistent lock state
> > >> >> > 5.15.26+ #2 Not tainted
> > >> >> > --------------------------------
> > >> >> > inconsistent {INITIAL USE} -> {IN-NMI} usage.
> > >> >> > syz-executor.5/19749 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > >> >> > ffff88804c9fc198 (&qs->lock){..-.}-{2:2}, at: __queue_map_get+0=
x31/0x250
> > >> >> > {INITIAL USE} state was registered at:
> > >> >> >   lock_acquire+0x1a3/0x4b0
> > >> >> >   _raw_spin_lock_irqsave+0x48/0x60
> > >> >> >   __queue_map_get+0x31/0x250
> > >> >> >   bpf_prog_577904e86c81dead_func+0x12/0x4b4
> > >> >> >   trace_call_bpf+0x262/0x5d0
> > >> >> >   perf_trace_run_bpf_submit+0x91/0x1c0
> > >> >> >   perf_trace_sched_switch+0x46c/0x700
> > >> >> >   __schedule+0x11b5/0x24a0
> > >> >> >   schedule+0xd4/0x270
> > >> >> >   futex_wait_queue_me+0x25f/0x520
> > >> >> >   futex_wait+0x1e0/0x5f0
> > >> >> >   do_futex+0x395/0x1890
> > >> >> >   __x64_sys_futex+0x1cb/0x480
> > >> >> >   do_syscall_64+0x3b/0xc0
> > >> >> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >> >> > irq event stamp: 13640
> > >> >> > hardirqs last  enabled at (13639): [<ffffffff95eb2bf4>]
> > >> >> > _raw_spin_unlock_irq+0x24/0x40
> > >> >> > hardirqs last disabled at (13640): [<ffffffff95eb2d4d>]
> > >> >> > _raw_spin_lock_irqsave+0x5d/0x60
> > >> >> > softirqs last  enabled at (13464): [<ffffffff93e26de5>] __sys_b=
pf+0x3e15/0x4e80
> > >> >> > softirqs last disabled at (13462): [<ffffffff93e26da3>] __sys_b=
pf+0x3dd3/0x4e80
> > >> >> >
> > >> >> > other info that might help us debug this:
> > >> >> >  Possible unsafe locking scenario:
> > >> >> >
> > >> >> >        CPU0
> > >> >> >        ----
> > >> >> >   lock(&qs->lock);
> > >> >> >   <Interrupt>
> > >> >> >     lock(&qs->lock);
> > >> >>
> > >> >> Hmm, so that lock() uses raw_spin_lock_irqsave(), which *should* =
be
> > >> >> disabling interrupts entirely for the critical section. But I gue=
ss a
> > >> >> Perf hardware event can still trigger? Which seems like it would
> > >> >> potentially wreak havoc with lots of things, not just this queue =
map
> > >> >> function?
> > >> >>
> > >> >> No idea how to protect against this, though. Hoping Arnaldo knows=
? :)
> > >> >>
> > >> >
> > >> > The locking should probably be protected by a percpu integer count=
er,
> > >> > incremented and decremented before and after the lock is taken,
> > >> > respectively. If it is already non-zero, then -EBUSY should be
> > >> > returned. It is similar to what htab_lock_bucket protects against =
in
> > >> > hashtab.c.
> > >>
> > >> Ah, neat! Okay, seems straight-forward enough to replicate. Hsin, co=
uld
> > >> you please check if the patch below gets rid of the splat?
> > >
> > > Instead of adding all this complexity for the map that is so rarely u=
sed
> > > it's easier to disallow it perf_event prog types.
> > > Or add a single if (in_nmi()) return -EBUSY.
> >
> > Heh, I was actually thinking the "nmi-safe lock" thing might be
> > something that could be neatly encapsulated into the lock library
> > helpers. But OK, so you mean just something like the below, then?
>
> Yep.
> In bpf timers we do:
>         if (in_nmi())
>                 return -EOPNOTSUPP;
> while in ringbuf we have:
>         if (in_nmi()) {
>                 if (!spin_trylock_irqsave(&rb->spinlock, flags))
>                         return NULL;
>         } else {
>                 spin_lock_irqsave(&rb->spinlock, flags);
>         }
>
> I think both options are fine to use with queue/stack map.
> trylock approach is probably less drastic.
>

I tried the trylock approach as shown below. The fuzzer now
no longer triggers the lockdep warning.

-Hsin-Wei

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index f9c734aaa990..ef95b796a0fa 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -103,7 +103,12 @@ static int __queue_map_get(struct bpf_map *map,
void *value, bool delete)
        int err =3D 0;
        void *ptr;

-       raw_spin_lock_irqsave(&qs->lock, flags);
+       if (in_nmi()) {
+               if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+                       return -EBUSY;
+       } else {
+               raw_spin_lock_irqsave(&qs->lock, flags);
+       }

        if (queue_stack_map_is_empty(qs)) {
                memset(value, 0, qs->map.value_size);
@@ -133,7 +138,12 @@ static int __stack_map_get(struct bpf_map *map,
void *value, bool delete)
        void *ptr;
        u32 index;

-       raw_spin_lock_irqsave(&qs->lock, flags);
+       if (in_nmi()) {
+               if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+                       return -EBUSY;
+       } else {
+               raw_spin_lock_irqsave(&qs->lock, flags);
+       }

        if (queue_stack_map_is_empty(qs)) {
                memset(value, 0, qs->map.value_size);
@@ -198,7 +208,12 @@ static int queue_stack_map_push_elem(struct
bpf_map *map, void *value,
        if (flags & BPF_NOEXIST || flags > BPF_EXIST)
                return -EINVAL;

-       raw_spin_lock_irqsave(&qs->lock, irq_flags);
+       if (in_nmi()) {
+               if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
+                       return -EBUSY;
+       } else {
+               raw_spin_lock_irqsave(&qs->lock, irq_flags);
+       }

        if (queue_stack_map_is_full(qs)) {
                if (!replace) {




> > I'll send a proper patch for that later if no one objects (or beats me
> > to it) :)
> >
> > -Toke
> >
> > diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_map=
s.c
> > index 8d2ddcb7566b..138525424745 100644
> > --- a/kernel/bpf/queue_stack_maps.c
> > +++ b/kernel/bpf/queue_stack_maps.c
> > @@ -98,6 +98,9 @@ static long __queue_map_get(struct bpf_map *map, void=
 *value, bool delete)
> >         int err =3D 0;
> >         void *ptr;
> >
> > +       if (in_nmi())
> > +               return -EBUSY;
> > +
> >         raw_spin_lock_irqsave(&qs->lock, flags);
> >
> >         if (queue_stack_map_is_empty(qs)) {
> > @@ -128,6 +131,9 @@ static long __stack_map_get(struct bpf_map *map, vo=
id *value, bool delete)
> >         void *ptr;
> >         u32 index;
> >
> > +       if (in_nmi())
> > +               return -EBUSY;
> > +
> >         raw_spin_lock_irqsave(&qs->lock, flags);
> >
> >         if (queue_stack_map_is_empty(qs)) {
> > @@ -193,6 +199,9 @@ static long queue_stack_map_push_elem(struct bpf_ma=
p *map, void *value,
> >         if (flags & BPF_NOEXIST || flags > BPF_EXIST)
> >                 return -EINVAL;
> >
> > +       if (in_nmi())
> > +               return -EBUSY;
> > +
> >         raw_spin_lock_irqsave(&qs->lock, irq_flags);
> >
> >         if (queue_stack_map_is_full(qs)) {

