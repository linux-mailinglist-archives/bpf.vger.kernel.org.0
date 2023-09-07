Return-Path: <bpf+bounces-9405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15AF79728B
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E6F280D89
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC16AB9;
	Thu,  7 Sep 2023 13:04:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0263C3;
	Thu,  7 Sep 2023 13:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308BEC32782;
	Thu,  7 Sep 2023 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694091883;
	bh=M+os8xv7Hj/iAyjnuO++hB+bSQmyblwlZDQ7Yls2Ahs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZNi0CGI7mcrZKr1Pt95gkoopqYyoN5AKjnnqFmr6WWuGjm3PI6Kny3XKUW3sXpDOE
	 aDMP+uF7WT5zk/qHn+usi5eSLOCDFH051hOO3Qe5YGqFDRYGTzzpzVnzU2A037+EMZ
	 BRgjfGW2/s5E//wvCRCjlq6lnrqXGjNnksGOojhaGZFMak0yauylbZ4dVJv2nHc9BV
	 3flPaj4kc34AP/GDwl5SQNK6slzJWtjXChgXq+gV0NbRy5+R4goaCDNgDyNQLiYQ+h
	 oXACdXO3RrGpGG3jhmsrtmZv/cnTVEN4yjTcuCufxsGSlV0vRccMSV3xM4QB+x0CRi
	 ttqqISKtcgRXQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6D9FCDC680F; Thu,  7 Sep 2023 15:04:39 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Hsin-Wei Hung <hsinweih@uci.edu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Subject: Re: Possible deadlock in bpf queue map
In-Reply-To: <CAP01T76Ce2KHQqTGsqs5K9RM5qSv07rNxnV+-=q_J25i9NkqxA@mail.gmail.com>
References: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
 <87o7ienuss.fsf@toke.dk>
 <CAP01T76Ce2KHQqTGsqs5K9RM5qSv07rNxnV+-=q_J25i9NkqxA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 07 Sep 2023 15:04:39 +0200
Message-ID: <87fs3qnnh4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Thu, 7 Sept 2023 at 12:26, Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
>>
>> +Arnaldo
>>
>> > Hi,
>> >
>> > Our bpf fuzzer, a customized Syzkaller, triggered a lockdep warning in
>> > the bpf queue map in v5.15. Since queue_stack_maps.c has no major chan=
ges
>> > since v5.15, we think this should still exist in the latest kernel.
>> > The bug can be occasionally triggered, and we suspect one of the
>> > eBPF programs involved to be the following one. We also attached the l=
ockdep
>> > warning at the end.
>> >
>> > #define DEFINE_BPF_MAP_NO_KEY(the_map, TypeOfMap, MapFlags,
>> > TypeOfValue, MaxEntries) \
>> >         struct {                                                      =
  \
>> >             __uint(type, TypeOfMap);                                  =
  \
>> >             __uint(map_flags, (MapFlags));                            =
  \
>> >             __uint(max_entries, (MaxEntries));                        =
  \
>> >             __type(value, TypeOfValue);                               =
  \
>> >         } the_map SEC(".maps");
>> >
>> > DEFINE_BPF_MAP_NO_KEY(map_0, BPF_MAP_TYPE_QUEUE, 0 | BPF_F_WRONLY,
>> > struct_0, 162);
>> > SEC("perf_event")
>> > int func(struct bpf_perf_event_data *ctx) {
>> >         char v0[96] =3D {};
>> >         uint64_t v1 =3D 0;
>> >         v1 =3D bpf_map_pop_elem(&map_0, v0);
>> >         return 163819661;
>> > }
>> >
>> >
>> > The program is attached to the following perf event.
>> >
>> > struct perf_event_attr attr_type_hw =3D {
>> >         .type =3D PERF_TYPE_HARDWARE,
>> >         .config =3D PERF_COUNT_HW_CPU_CYCLES,
>> >         .sample_freq =3D 50,
>> >         .inherit =3D 1,
>> >         .freq =3D 1,
>> > };
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3DWARNING: inconsistent lock state
>> > 5.15.26+ #2 Not tainted
>> > --------------------------------
>> > inconsistent {INITIAL USE} -> {IN-NMI} usage.
>> > syz-executor.5/19749 [HC1[1]:SC0[0]:HE0:SE1] takes:
>> > ffff88804c9fc198 (&qs->lock){..-.}-{2:2}, at: __queue_map_get+0x31/0x2=
50
>> > {INITIAL USE} state was registered at:
>> >   lock_acquire+0x1a3/0x4b0
>> >   _raw_spin_lock_irqsave+0x48/0x60
>> >   __queue_map_get+0x31/0x250
>> >   bpf_prog_577904e86c81dead_func+0x12/0x4b4
>> >   trace_call_bpf+0x262/0x5d0
>> >   perf_trace_run_bpf_submit+0x91/0x1c0
>> >   perf_trace_sched_switch+0x46c/0x700
>> >   __schedule+0x11b5/0x24a0
>> >   schedule+0xd4/0x270
>> >   futex_wait_queue_me+0x25f/0x520
>> >   futex_wait+0x1e0/0x5f0
>> >   do_futex+0x395/0x1890
>> >   __x64_sys_futex+0x1cb/0x480
>> >   do_syscall_64+0x3b/0xc0
>> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> > irq event stamp: 13640
>> > hardirqs last  enabled at (13639): [<ffffffff95eb2bf4>]
>> > _raw_spin_unlock_irq+0x24/0x40
>> > hardirqs last disabled at (13640): [<ffffffff95eb2d4d>]
>> > _raw_spin_lock_irqsave+0x5d/0x60
>> > softirqs last  enabled at (13464): [<ffffffff93e26de5>] __sys_bpf+0x3e=
15/0x4e80
>> > softirqs last disabled at (13462): [<ffffffff93e26da3>] __sys_bpf+0x3d=
d3/0x4e80
>> >
>> > other info that might help us debug this:
>> >  Possible unsafe locking scenario:
>> >
>> >        CPU0
>> >        ----
>> >   lock(&qs->lock);
>> >   <Interrupt>
>> >     lock(&qs->lock);
>>
>> Hmm, so that lock() uses raw_spin_lock_irqsave(), which *should* be
>> disabling interrupts entirely for the critical section. But I guess a
>> Perf hardware event can still trigger? Which seems like it would
>> potentially wreak havoc with lots of things, not just this queue map
>> function?
>>
>> No idea how to protect against this, though. Hoping Arnaldo knows? :)
>>
>
> The locking should probably be protected by a percpu integer counter,
> incremented and decremented before and after the lock is taken,
> respectively. If it is already non-zero, then -EBUSY should be
> returned. It is similar to what htab_lock_bucket protects against in
> hashtab.c.

Ah, neat! Okay, seems straight-forward enough to replicate. Hsin, could
you please check if the patch below gets rid of the splat?

-Toke


diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 8d2ddcb7566b..f96945311eec 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -16,6 +16,7 @@
 struct bpf_queue_stack {
 	struct bpf_map map;
 	raw_spinlock_t lock;
+	int __percpu *map_locked;
 	u32 head, tail;
 	u32 size; /* max_entries + 1 */
=20
@@ -66,6 +67,7 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_at=
tr *attr)
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	struct bpf_queue_stack *qs;
 	u64 size, queue_size;
+	int err =3D -ENOMEM;
=20
 	size =3D (u64) attr->max_entries + 1;
 	queue_size =3D sizeof(*qs) + size * attr->value_size;
@@ -80,7 +82,18 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_a=
ttr *attr)
=20
 	raw_spin_lock_init(&qs->lock);
=20
+	qs->map_locked =3D bpf_map_alloc_percpu(&qs->map,
+					      sizeof(*qs->map_locked),
+					      sizeof(*qs->map_locked),
+					      GFP_USER);
+	if (!qs->map_locked)
+		goto free_map;
+
 	return &qs->map;
+
+free_map:
+	bpf_map_area_free(qs);
+	return ERR_PTR(err);
 }
=20
 /* Called when map->refcnt goes to zero, either from workqueue or from sys=
call */
@@ -88,9 +101,37 @@ static void queue_stack_map_free(struct bpf_map *map)
 {
 	struct bpf_queue_stack *qs =3D bpf_queue_stack(map);
=20
+	free_percpu(qs->map_locked);
 	bpf_map_area_free(qs);
 }
=20
+static inline int queue_stack_map_lock(struct bpf_queue_stack *qs,
+				       unsigned long *pflags)
+{
+	unsigned long flags;
+
+	preempt_disable();
+	if (unlikely(__this_cpu_inc_return(*qs->map_locked) !=3D 1)) {
+		__this_cpu_dec(*qs->map_locked);
+		preempt_enable();
+		return -EBUSY;
+	}
+
+	raw_spin_lock_irqsave(&qs->lock, flags);
+	*pflags =3D flags;
+
+	return 0;
+}
+
+
+static inline void queue_stack_map_unlock(struct bpf_queue_stack *qs,
+					  unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&qs->lock, flags);
+	__this_cpu_dec(*qs->map_locked);
+	preempt_enable();
+}
+
 static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 {
 	struct bpf_queue_stack *qs =3D bpf_queue_stack(map);
@@ -98,7 +139,9 @@ static long __queue_map_get(struct bpf_map *map, void *v=
alue, bool delete)
 	int err =3D 0;
 	void *ptr;
=20
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	err =3D queue_stack_map_lock(qs, &flags);
+	if (err)
+		return err;
=20
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -115,7 +158,7 @@ static long __queue_map_get(struct bpf_map *map, void *=
value, bool delete)
 	}
=20
 out:
-	raw_spin_unlock_irqrestore(&qs->lock, flags);
+	queue_stack_map_unlock(qs, flags);
 	return err;
 }
=20
@@ -128,7 +171,9 @@ static long __stack_map_get(struct bpf_map *map, void *=
value, bool delete)
 	void *ptr;
 	u32 index;
=20
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	err =3D queue_stack_map_lock(qs, &flags);
+	if (err)
+		return err;
=20
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -147,7 +192,7 @@ static long __stack_map_get(struct bpf_map *map, void *=
value, bool delete)
 		qs->head =3D index;
=20
 out:
-	raw_spin_unlock_irqrestore(&qs->lock, flags);
+	queue_stack_map_unlock(qs, flags);
 	return err;
 }
=20
@@ -193,7 +238,9 @@ static long queue_stack_map_push_elem(struct bpf_map *m=
ap, void *value,
 	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
 		return -EINVAL;
=20
-	raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	err =3D queue_stack_map_lock(qs, &irq_flags);
+	if (err)
+		return err;
=20
 	if (queue_stack_map_is_full(qs)) {
 		if (!replace) {
@@ -212,7 +259,7 @@ static long queue_stack_map_push_elem(struct bpf_map *m=
ap, void *value,
 		qs->head =3D 0;
=20
 out:
-	raw_spin_unlock_irqrestore(&qs->lock, irq_flags);
+	queue_stack_map_unlock(qs, irq_flags);
 	return err;
 }
=20

