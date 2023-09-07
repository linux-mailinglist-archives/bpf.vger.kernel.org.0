Return-Path: <bpf+bounces-9418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B84379764D
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055762818C8
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BC7134AD;
	Thu,  7 Sep 2023 16:05:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F228E7;
	Thu,  7 Sep 2023 16:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6C6C4339A;
	Thu,  7 Sep 2023 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694102748;
	bh=SETT7D9Th+Jmeeyrb8PHMHUPrAPO4I03JKooKx3IGLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hCwjAgHBzZGgtUsCJOQlz9rSflUuq4ESDb4TQsx9InqZBSUwb3AmlsNyN4hVSDqT3
	 9Rg330ymDc127ePJ7cQoGr6f3pLH8ZQkXlMpsvDJ2hp7SZKa1Xgx+uCUVHYKs9b7DR
	 Ua+VjPChRSJ7wANDTZzON/yNG3isfWZQNfci7YlNTTxUdwH08Ibo4s29k+yOAxy9te
	 LX99eL2i6bGSq0IsmDUVLIPhxxBd+Tb/vqyTNy1QoTmKjJMmh3e/947uiRX/zHzicV
	 PmTwwO8gxmD3EdI2zI+LYSvwJIAW6BpFitoPpw8NA6bRS+Zt0CihKesj7LlZyf3Oyn
	 xHkDy/Fy+B6pg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2EB88DC684E; Thu,  7 Sep 2023 18:05:45 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Hsin-Wei Hung
 <hsinweih@uci.edu>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Network Development <netdev@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Possible deadlock in bpf queue map
In-Reply-To: <CAADnVQK-ov_rve4pM7McMDQd5E9U5-JPjT5522BaVWDH-NvM5g@mail.gmail.com>
References: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
 <87o7ienuss.fsf@toke.dk>
 <CAP01T76Ce2KHQqTGsqs5K9RM5qSv07rNxnV+-=q_J25i9NkqxA@mail.gmail.com>
 <87fs3qnnh4.fsf@toke.dk>
 <CAADnVQK-ov_rve4pM7McMDQd5E9U5-JPjT5522BaVWDH-NvM5g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 07 Sep 2023 18:05:45 +0200
Message-ID: <8734zqnf3a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Sep 7, 2023 at 6:04=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@kernel.org> wrote:
>>
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> > On Thu, 7 Sept 2023 at 12:26, Toke H=C3=B8iland-J=C3=B8rgensen <toke@k=
ernel.org> wrote:
>> >>
>> >> +Arnaldo
>> >>
>> >> > Hi,
>> >> >
>> >> > Our bpf fuzzer, a customized Syzkaller, triggered a lockdep warning=
 in
>> >> > the bpf queue map in v5.15. Since queue_stack_maps.c has no major c=
hanges
>> >> > since v5.15, we think this should still exist in the latest kernel.
>> >> > The bug can be occasionally triggered, and we suspect one of the
>> >> > eBPF programs involved to be the following one. We also attached th=
e lockdep
>> >> > warning at the end.
>> >> >
>> >> > #define DEFINE_BPF_MAP_NO_KEY(the_map, TypeOfMap, MapFlags,
>> >> > TypeOfValue, MaxEntries) \
>> >> >         struct {                                                   =
     \
>> >> >             __uint(type, TypeOfMap);                               =
     \
>> >> >             __uint(map_flags, (MapFlags));                         =
     \
>> >> >             __uint(max_entries, (MaxEntries));                     =
     \
>> >> >             __type(value, TypeOfValue);                            =
     \
>> >> >         } the_map SEC(".maps");
>> >> >
>> >> > DEFINE_BPF_MAP_NO_KEY(map_0, BPF_MAP_TYPE_QUEUE, 0 | BPF_F_WRONLY,
>> >> > struct_0, 162);
>> >> > SEC("perf_event")
>> >> > int func(struct bpf_perf_event_data *ctx) {
>> >> >         char v0[96] =3D {};
>> >> >         uint64_t v1 =3D 0;
>> >> >         v1 =3D bpf_map_pop_elem(&map_0, v0);
>> >> >         return 163819661;
>> >> > }
>> >> >
>> >> >
>> >> > The program is attached to the following perf event.
>> >> >
>> >> > struct perf_event_attr attr_type_hw =3D {
>> >> >         .type =3D PERF_TYPE_HARDWARE,
>> >> >         .config =3D PERF_COUNT_HW_CPU_CYCLES,
>> >> >         .sample_freq =3D 50,
>> >> >         .inherit =3D 1,
>> >> >         .freq =3D 1,
>> >> > };
>> >> >
>> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DWARNING: inconsistent lock state
>> >> > 5.15.26+ #2 Not tainted
>> >> > --------------------------------
>> >> > inconsistent {INITIAL USE} -> {IN-NMI} usage.
>> >> > syz-executor.5/19749 [HC1[1]:SC0[0]:HE0:SE1] takes:
>> >> > ffff88804c9fc198 (&qs->lock){..-.}-{2:2}, at: __queue_map_get+0x31/=
0x250
>> >> > {INITIAL USE} state was registered at:
>> >> >   lock_acquire+0x1a3/0x4b0
>> >> >   _raw_spin_lock_irqsave+0x48/0x60
>> >> >   __queue_map_get+0x31/0x250
>> >> >   bpf_prog_577904e86c81dead_func+0x12/0x4b4
>> >> >   trace_call_bpf+0x262/0x5d0
>> >> >   perf_trace_run_bpf_submit+0x91/0x1c0
>> >> >   perf_trace_sched_switch+0x46c/0x700
>> >> >   __schedule+0x11b5/0x24a0
>> >> >   schedule+0xd4/0x270
>> >> >   futex_wait_queue_me+0x25f/0x520
>> >> >   futex_wait+0x1e0/0x5f0
>> >> >   do_futex+0x395/0x1890
>> >> >   __x64_sys_futex+0x1cb/0x480
>> >> >   do_syscall_64+0x3b/0xc0
>> >> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> >> > irq event stamp: 13640
>> >> > hardirqs last  enabled at (13639): [<ffffffff95eb2bf4>]
>> >> > _raw_spin_unlock_irq+0x24/0x40
>> >> > hardirqs last disabled at (13640): [<ffffffff95eb2d4d>]
>> >> > _raw_spin_lock_irqsave+0x5d/0x60
>> >> > softirqs last  enabled at (13464): [<ffffffff93e26de5>] __sys_bpf+0=
x3e15/0x4e80
>> >> > softirqs last disabled at (13462): [<ffffffff93e26da3>] __sys_bpf+0=
x3dd3/0x4e80
>> >> >
>> >> > other info that might help us debug this:
>> >> >  Possible unsafe locking scenario:
>> >> >
>> >> >        CPU0
>> >> >        ----
>> >> >   lock(&qs->lock);
>> >> >   <Interrupt>
>> >> >     lock(&qs->lock);
>> >>
>> >> Hmm, so that lock() uses raw_spin_lock_irqsave(), which *should* be
>> >> disabling interrupts entirely for the critical section. But I guess a
>> >> Perf hardware event can still trigger? Which seems like it would
>> >> potentially wreak havoc with lots of things, not just this queue map
>> >> function?
>> >>
>> >> No idea how to protect against this, though. Hoping Arnaldo knows? :)
>> >>
>> >
>> > The locking should probably be protected by a percpu integer counter,
>> > incremented and decremented before and after the lock is taken,
>> > respectively. If it is already non-zero, then -EBUSY should be
>> > returned. It is similar to what htab_lock_bucket protects against in
>> > hashtab.c.
>>
>> Ah, neat! Okay, seems straight-forward enough to replicate. Hsin, could
>> you please check if the patch below gets rid of the splat?
>
> Instead of adding all this complexity for the map that is so rarely used
> it's easier to disallow it perf_event prog types.
> Or add a single if (in_nmi()) return -EBUSY.

Heh, I was actually thinking the "nmi-safe lock" thing might be
something that could be neatly encapsulated into the lock library
helpers. But OK, so you mean just something like the below, then?

I'll send a proper patch for that later if no one objects (or beats me
to it) :)

-Toke

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 8d2ddcb7566b..138525424745 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -98,6 +98,9 @@ static long __queue_map_get(struct bpf_map *map, void *va=
lue, bool delete)
        int err =3D 0;
        void *ptr;
=20
+       if (in_nmi())
+               return -EBUSY;
+
        raw_spin_lock_irqsave(&qs->lock, flags);
=20
        if (queue_stack_map_is_empty(qs)) {
@@ -128,6 +131,9 @@ static long __stack_map_get(struct bpf_map *map, void *=
value, bool delete)
        void *ptr;
        u32 index;
=20
+       if (in_nmi())
+               return -EBUSY;
+
        raw_spin_lock_irqsave(&qs->lock, flags);
=20
        if (queue_stack_map_is_empty(qs)) {
@@ -193,6 +199,9 @@ static long queue_stack_map_push_elem(struct bpf_map *m=
ap, void *value,
        if (flags & BPF_NOEXIST || flags > BPF_EXIST)
                return -EINVAL;
=20
+       if (in_nmi())
+               return -EBUSY;
+
        raw_spin_lock_irqsave(&qs->lock, irq_flags);
=20
        if (queue_stack_map_is_full(qs)) {

