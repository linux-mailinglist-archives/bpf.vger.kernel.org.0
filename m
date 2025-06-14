Return-Path: <bpf+bounces-60665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A60AD9CA2
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60F21899E84
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B612C08C2;
	Sat, 14 Jun 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="rlyMjMmb"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BE24C692;
	Sat, 14 Jun 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749902535; cv=none; b=BBS2NRTiN7cwxbpmLHoxH4WXFTnVaOQFD+F0k+Wxsn0UT1jwu+5psM1Quny0Kcv/6RhcgNplhjRydSw16tyrKYcqb+vqYugDJqVRXop6g3iCKgoqB4BUNyG7f4wzdfd7vs+7cmdL8TSYgVK9ruOGba84zya+w/mJaDWv7g9QGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749902535; c=relaxed/simple;
	bh=1Glgt3EGkRRmQMWUxoYBRNXwV9djNq6fH14C0jgjlPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwycVL8RQdtPjSq0hl+p1nIJ1yTxUuDfrAXP/Gu+jL90EJZ6v+AciP1peEKKUmEA9GDE6dvH1GGrcdIMTBOsNQyR7E9vJyHV4NSH7JQk4sgxF5i7CV++cbzaRh7oCn0C7zp7u/5KxW3Nh9CcQ7O2BZS3amjwREC0PRvkcyzkdWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=rlyMjMmb; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749902516; x=1750507316; i=spasswolf@web.de;
	bh=8qcI4pHlqA1a2vTgEuEfXlGV3W7KGJGYFoAGg7lL6wA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rlyMjMmbGVYK79cTSH5pqBqGGF4WVNYevo25Hrpe2rr6+ti1CEgOrDlr/ylx/kfU
	 El7SHr42M+4rgbLjypuC+U/4aX9l8B2jvpjaOoQVnIUNMC1jh824ieFnldsBtsdS7
	 +YIv33Kt7m8beS6FjWnmX3uPPiptAyejEyQMyd4djKeh5gtwoNxoCVQTrJwI8ASvJ
	 b8drOgBzeFxREEUTSH50Au6aUMp4buQQtt3UCWLanDkqdrm3fl4QFb0Fakg5b1V87
	 WpMPXsJZBom65DE+nPSaFE+sFOKS9isj/+3vmuf/pXF5byrrvITrdstt6oTP723nM
	 uhCAfi9pjYixKS45Rg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrfou-1vBp8p443A-00cFUk; Sat, 14
 Jun 2025 14:01:56 +0200
Message-ID: <aa28ef09763eeefd54d4c26fb01599fd5197b265.camel@web.de>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, spasswolf@web.de, Steven
 Rostedt <rostedt@goodmis.org>
Date: Sat, 14 Jun 2025 14:01:54 +0200
In-Reply-To: <0c0b2385452292d6b1df3066b7223b420066f0a1.camel@web.de>
References: <20250605091904.5853-1-spasswolf@web.de>
					 <20250605084816.3e5d1af1@gandalf.local.home>
					 <20250605125133.RSTingmi@linutronix.de>
			 <0b1f48ba715a16c4d4874ae65bc01914de4d5a90.camel@web.de>
		 <727212f9d3c324787ddd9ede9e2d800a02b629b2.camel@web.de>
	 <0c0b2385452292d6b1df3066b7223b420066f0a1.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EPvv5W64aQeEqCFzHL61RzaKEAMAfiBxPFfpbMoU3Gg0SQWeKNk
 Zp1uuJdi0rU+paS9qkD5qlVuRz8XX+u3kkzavLIhyygnmzgoKOEFtxhRgzKvexJ6SmCjeP/
 69JIHlfO/OkLTCKtzhfPy4zJD++7PZf5bxrGMgvMSwGUnvwmnmLfSgeqaO6T2rLGcKE+Lfr
 Ttk4IvwTxZbx0py5SABAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dqgAzvXKt2I=;aoYqdcvAAcTJUxja+t1a5vuwcNd
 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
 78G/iz91yNxR0P1U

Am Montag, dem 09.06.2025 um 13:37 +0200 schrieb Bert Karwatzki:
> Am Sonntag, dem 08.06.2025 um 17:53 +0200 schrieb Bert Karwatzki:
> > Am Sonntag, dem 08.06.2025 um 10:45 +0200 schrieb Bert Karwatzki:
> > > Am Donnerstag, dem 05.06.2025 um 14:51 +0200 schrieb Sebastian Andrz=
ej Siewior:
> > > > On 2025-06-05 08:48:38 [-0400], Steven Rostedt wrote:
> > > > > On Thu,  5 Jun 2025 11:19:03 +0200
> > > > > Bert Karwatzki <spasswolf@web.de> wrote:
> > > > >=20
> > > > > > This patch seems to create so much output that the orginal err=
or message and
> > > > > > backtrace often get lost, so I needed several runs to get a me=
aningful message
> > > > > > when running
> > > > >=20
> > > > > Are you familiar with preempt count tracing?
> > > >=20
> > > > I have an initial set of patches to tackle this problem, I'm going=
 to
> > > > send them after the merge window.
> > > >=20
> > > > Sebastian
> > >=20
> > > I've found the reason for the "mysterious" increase of preempt_count=
:
> > >=20
> > > [   70.821750] [   T2746] bpf_link_settle calling fd_install() preem=
t_count =3D 0
> > > [   70.821751] [   T2746] preempt_count_add 5898: preempt_count =3D =
0x0 counter =3D 0x1b232c
> > > [   70.821752] [   T2746] preempt_count_add 5900: preempt_count =3D =
0x1 counter =3D 0x1b232d
> > > [   70.821754] [   T2746] preempt_count_sub 5966: preempt_count =3D =
0x1 counter =3D 0x1b232e
> > > [   70.821755] [   T2746] preempt_count_sub 5968: preempt_count =3D =
0x0 counter =3D 0x1b232f
> > > [   70.821761] [   T2746] __bpf_trace_sys_enter 18: preempt_count =
=3D 0x0
> > > [   70.821762] [   T2746] __bpf_trace_sys_enter 18: preempt_count =
=3D 0x1
> > > [   70.821764] [   T2746] __bpf_trace_run: preempt_count =3D 1
> > > [   70.821765] [   T2746] bpf_prog_run: preempt_count =3D 1
> > > [   70.821766] [   T2746] __bpf_prog_run: preempt_count =3D 1
> > >=20
> > > It's caused by this macro from include/trace/bpf_probe.h (with my pr=
_err()):
> > >=20
> > > #define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args) \
> > > static notrace void \
> > > __bpf_trace_##call(void *__data, proto) \
> > > { \
> > >  might_fault(); \
> > >  if (!strcmp(get_current()->comm, "test_progs")) \
> > >  pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt=
_count());\
> > >  preempt_disable_notrace(); \
> > >  if (!strcmp(get_current()->comm, "test_progs")) \
> > >  pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt=
_count());\
> > >  CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(ar=
gs)); \
> > >  preempt_enable_notrace(); \
> > > }
> > >=20
> > > The preempt_{en,dis}able_notrace were introduced in
> > > commit 4aadde89d81f ("tracing/bpf: disable preemption in syscall pro=
be")
> > > This commit is present in v6.14 and v6.15, but the bug already appea=
rs in
> > > v6.12 so in that case preemption is disable somewhere else.=20
> > >=20
> > > Bert Karwatzki
> >=20
> > After reading this=C2=A0
> > https://lore.kernel.org/bpf/CAADnVQJf535hwud5XtQKStOge9=3DpYVYWSiq_8Q2=
YAvN5rba=3D=3DA@mail.gmail.com/
> > I tried using migrate_{en,disable} like this (in v6.15)
> >=20
> > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > index 183fa2aa2935..49257cb90209 100644
> > --- a/include/trace/bpf_probe.h
> > +++ b/include/trace/bpf_probe.h
> > @@ -58,9 +58,9 @@ static notrace void							\
> >  __bpf_trace_##call(void *__data, proto)					\
> >  {									\
> >  	might_fault();							\
> > -	preempt_disable_notrace();					\
> > +	migrate_disable();					\
> >  	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(arg=
s));	\
> > -	preempt_enable_notrace();					\
> > +	migrate_enable();					\
> >  }
> > =20
> >  #undef DECLARE_EVENT_SYSCALL_CLASS
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 187dc37d61d4..ec0326405fc3 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2350,7 +2350,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *lin=
k, u64 *args)
> >  	struct bpf_run_ctx *old_run_ctx;
> >  	struct bpf_trace_run_ctx run_ctx;
> > =20
> > -	cant_sleep();
> > +	cant_migrate();
> >  	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
> >  		bpf_prog_inc_misses_counter(prog);
> >  		goto out;
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tool=
s/testing/selftests/bpf/progs/dynptr_success.c
> > index e1fba28e4a86..7cfb9473a526 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > @@ -7,6 +7,7 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include "bpf_misc.h"
> > +#include "bpf_kfuncs.h"
> >  #include "errno.h"
> > =20
> >  char _license[] SEC("license") =3D "GPL";
> >=20
> >=20
> > This fixes the warnings when running the bpf cgroup examples:
> >=20
> > ./test_progs -a "cgrp_local_storage/cgrp1*"
> >=20
> > but I still get a warning from another example (I don't know which, ye=
t):
> >=20
> > Bert Karwatzki
>=20
> Another of the bpf selftests that gives a warning with PREEMPT_RT=3Dy (f=
or calling spinlock
> with preemption disabled) is
>=20
> $ ./test_progs -a wq
>=20
> giving this warning:
>=20
> [ T3576] BUG: sleeping function called from invalid context at kernel/lo=
cking/spinlock_rt.c:48
> [ T3576] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3576, na=
me: test_progs
> [ T3576] preempt_count: 1, expected: 0
> [ T3576] RCU nest depth: 3, expected: 3
> [ T3576] 6 locks held by test_progs/3576:
> [ T3576]  #0: ffffffffa1131300 (rcu_read_lock){....}-{1:3}, at: bpf_test=
_timer_enter+0x1e/0xc0
> [ T3576]  #1: ffffffffa109acc0 (local_bh){.+.+}-{1:3}, at: __local_bh_di=
sable_ip+0x29/0x1c0
> [ T3576]  #2: ffff997b0e7d78b8 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __=
local_bh_disable_ip+0xc8/0x1c0
> [ T3576]  #3: ffffffffa1131300 (rcu_read_lock){....}-{1:3}, at: rt_spin_=
lock+0xf0/0x190
> [ T3576]  #4: ffffffffa1131300 (rcu_read_lock){....}-{1:3}, at: __local_=
bh_disable_ip+0x29/0x1c0
> [ T3576]  #5: ffff997b0e7f4588 ((&c->lock)){+.+.}-{3:3}, at: ___slab_all=
oc+0x68/0xde0
> [ T3576] irq event stamp: 247437
> [ T3576] hardirqs last  enabled at (247435): [<ffffffffa05b5fa7>] _raw_s=
pin_unlock_irqrestore+0x57/0x80
> [ T3576] hardirqs last disabled at (247437): [<ffffffff9fbbc57b>] __bpf_=
async_init+0xdb/0x310
> [ T3576] softirqs last  enabled at (241464): [<ffffffff9f98a2e1>] __loca=
l_bh_enable_ip+0x111/0x180
> [ T3576] softirqs last disabled at (247436): [<ffffffffa036688c>] bpf_te=
st_run+0x10c/0x350
> [ T3576] CPU: 7 UID: 0 PID: 3576 Comm: test_progs Tainted: G           O=
        6.15.0-bpf-00003-g5197b534e6ad #4 PREEMPT_{RT,(full)}=20
> [ T3576] Tainted: [O]=3DOOT_MODULE
> [ T3576] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EE=
K/MS-158L, BIOS E158LAMS.10F 11/11/2024
> [ T3576] Call Trace:
> [ T3576]  <TASK>
> [ T3576]  dump_stack_lvl+0x6d/0xb0
> [ T3576]  __might_resched.cold+0xe1/0xf3
> [ T3576]  rt_spin_lock+0x5f/0x190
> [ T3576]  ? ___slab_alloc+0x68/0xde0
> [ T3576]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T3576]  ? __lock_acquire+0x45f/0x2a70
> [ T3576]  ___slab_alloc+0x68/0xde0
> [ T3576]  ? bpf_map_kmalloc_node+0x72/0x220
> [ T3576]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T3576]  ? lock_acquire+0xbe/0x2e0
> [ T3576]  ? bpf_map_get_memcg.isra.0+0x182/0x310
> [ T3576]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T3576]  ? find_held_lock+0x2b/0x80
> [ T3576]  ? bpf_map_get_memcg.isra.0+0x8d/0x310
> [ T3576]  ? bpf_map_kmalloc_node+0x72/0x220
> [ T3576]  __kmalloc_node_noprof+0xee/0x490
> [ T3576]  bpf_map_kmalloc_node+0x72/0x220
> [ T3576]  __bpf_async_init+0x107/0x310
> [ T3576]  bpf_prog_aa38f9274c0318a2_test_call_array_sleepable+0xb3/0x10e
> [ T3576]  bpf_test_run+0x1ef/0x350
> [ T3576]  ? bpf_test_run+0x10c/0x350
> [ T3576]  ? migrate_enable+0x115/0x160
> [ T3576]  ? kmem_cache_alloc_noprof+0x210/0x2b0
> [ T3576]  bpf_prog_test_run_skb+0x37b/0x7c0
> [ T3576]  ? fput+0x3f/0x90
> [ T3576]  __sys_bpf+0xd33/0x26d0
> [ T3576]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T3576]  __x64_sys_bpf+0x21/0x30
> [ T3576]  do_syscall_64+0x72/0xfa0
> [ T3576]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ T3576] RIP: 0033:0x7f1c8e2a6779
> [ T3576] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 =
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> =
3d 01 f0 ff ff
> 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
> [ T3576] RSP: 002b:00007fff8ef7b4d8 EFLAGS: 00000202 ORIG_RAX: 000000000=
0000141
> [ T3576] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1c8e2a67=
79
> [ T3576] RDX: 0000000000000050 RSI: 00007fff8ef7b510 RDI: 00000000000000=
0a
> [ T3576] RBP: 00007fff8ef7b4f0 R08: 00000000ffffffff R09: 00007fff8ef7b5=
10
> [ T3576] R10: 0000000000000064 R11: 0000000000000202 R12: 00000000000000=
00
> [ T3576] R13: 00007fff8ef7c038 R14: 00007f1c8e8db000 R15: 000055d507eb38=
90
> [ T3576]  </TASK>
>=20
>=20
> Here the problem is in __bpf_spin_lock() which calls arch_spin_lock()
> with preemption disabled:
>=20
> static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
> {
> 	arch_spinlock_t *l =3D (void *)lock;
> 	union {
> 		__u32 val;
> 		arch_spinlock_t lock;
> 	} u =3D { .lock =3D __ARCH_SPIN_LOCK_UNLOCKED };
>=20
> 	compiletime_assert(u.val =3D=3D 0, "__ARCH_SPIN_LOCK_UNLOCKED not 0");
> 	BUILD_BUG_ON(sizeof(*l) !=3D sizeof(__u32));
> 	BUILD_BUG_ON(sizeof(*lock) !=3D sizeof(__u32));
> 	if (!strcmp(get_current()->comm, "test_progs"))
> 		pr_err("%s: calling preempt_disable()\n", __func__);
> 	preempt_disable();
> 	arch_spin_lock(l);
> }
>=20
> The call to preempt_disable here was introduced in commit
> 5861d1e8dbc4 ("bpf: Allow bpf_spin_{lock,unlock} in sleepable progs").
>=20
>=20
> Bert Karwatzki

As a quick fix of this problem I  moved the __bpf_spin_lock_irqsave() beyo=
nd the
allocation in __bpf_async_init() (can this leak memory?):

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..94fcd8c8661c 100644
=2D-- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1263,19 +1263,16 @@ static int __bpf_async_init(struct bpf_async_kern =
*async, struct bpf_map *map, u
                return -EINVAL;
        }
=20
-       __bpf_spin_lock_irqsave(&async->lock);
        t =3D async->timer;
-       if (t) {
-               ret =3D -EBUSY;
-               goto out;
-       }
+       if (t)
+               return -EBUSY;
=20
        /* allocate hrtimer via map_kmalloc to use memcg accounting */
        cb =3D bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node)=
;
-       if (!cb) {
-               ret =3D -ENOMEM;
-               goto out;
-       }
+       if (!cb)
+               return -ENOMEM;
+
+       __bpf_spin_lock_irqsave(&async->lock);
=20
        switch (type) {
        case BPF_ASYNC_TYPE_TIMER:
@@ -1315,7 +1312,6 @@ static int __bpf_async_init(struct bpf_async_kern *a=
sync, struct bpf_map *map, u
                kfree(cb);
                ret =3D -EPERM;
        }
-out:
        __bpf_spin_unlock_irqrestore(&async->lock);
        return ret;
 }

With this these bpf example programs run without giving a warning in dmesg=
:

./test_progs -a timer -a timer_mim -a free_timer

But running ./test_progs -a timer_lockup gives this error:


[  127.373597] [      C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  127.373598] [      C1] WARNING: possible recursive locking detected
[  127.373601] [      C1] 6.15.0-bpf-00006-g31cf22212ed9 #41 Tainted: G   =
        O      =20
[  127.373602] [      C1] --------------------------------------------
[  127.373603] [      C1] ktimers/1/85 is trying to acquire lock:
[  127.373605] [      C1] ffff98f62e61c1b8 (&base->softirq_expiry_lock){+.=
..}-{3:3}, at: hrtimer_cancel_wait_running+0x4d/0x80
[  127.373614] [      C1]=20
                          but task is already holding lock:
[  127.373615] [      C1] ffff98f62e65c1b8 (&base->softirq_expiry_lock){+.=
..}-{3:3}, at: hrtimer_run_softirq+0x37/0x100
[  127.373621] [      C1]=20
                          other info that might help us debug this:
[  127.373621] [      C1]  Possible unsafe locking scenario:

[  127.373622] [      C1]        CPU0
[  127.373623] [      C1]        ----
[  127.373624] [      C1]   lock(&base->softirq_expiry_lock);
[  127.373626] [      C1]   lock(&base->softirq_expiry_lock);
[  127.373627] [      C1]=20
                           *** DEADLOCK ***

[  127.373628] [      C1]  May be due to missing lock nesting notation

[  127.373629] [      C1] 8 locks held by ktimers/1/85:
[  127.373630] [      C1]  #0: ffffffffa7a9acc0 (local_bh){.+.+}-{1:3}, at=
: __local_bh_disable_ip+0x29/0x1c0
[  127.373636] [      C1]  #1: ffff98f62e6578b8 ((softirq_ctrl.lock)){+.+.=
}-{3:3}, at: __local_bh_disable_ip+0xc8/0x1c0
[  127.373641] [      C1]  #2: ffffffffa7b31300 (rcu_read_lock){....}-{1:3=
}, at: rt_spin_lock+0xf0/0x190
[  127.373648] [      C1]  #3: ffffffffa7b31300 (rcu_read_lock){....}-{1:3=
}, at: __local_bh_disable_ip+0x29/0x1c0
[  127.373653] [      C1]  #4: ffff98f62e65c1b8 (&base->softirq_expiry_loc=
k){+...}-{3:3}, at: hrtimer_run_softirq+0x37/0x100
[  127.373658] [      C1]  #5: ffffffffa7b31300 (rcu_read_lock){....}-{1:3=
}, at: rt_spin_lock+0xf0/0x190
[  127.373663] [      C1]  #6: ffffffffa7b31300 (rcu_read_lock){....}-{1:3=
}, at: bpf_timer_cancel+0x42/0x2e0
[  127.373668] [      C1]  #7: ffffffffa7a9acc0 (local_bh){.+.+}-{1:3}, at=
: __local_bh_disable_ip+0x29/0x1c0
[  127.373673] [      C1]=20
                          stack backtrace:
[  127.373675] [      C1] CPU: 1 UID: 0 PID: 85 Comm: ktimers/1 Tainted: G=
           O        6.15.0-bpf-00006-g31cf22212ed9 #41 PREEMPT_{RT,(full)}=
=20
[  127.373679] [      C1] Tainted: [O]=3DOOT_MODULE
[  127.373680] [      C1] Hardware name: Micro-Star International Co., Ltd=
. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  127.373681] [      C1] Call Trace:
[  127.373683] [      C1]  <TASK>
[  127.373684] [      C1]  dump_stack_lvl+0x6d/0xb0
[  127.373689] [      C1]  print_deadlock_bug.cold+0xbd/0xca
[  127.373693] [      C1]  __lock_acquire+0x1390/0x2a70
[  127.373699] [      C1]  ? __lock_acquire+0x45f/0x2a70
[  127.373703] [      C1]  lock_acquire+0xbe/0x2e0
[  127.373706] [      C1]  ? hrtimer_cancel_wait_running+0x4d/0x80
[  127.373711] [      C1]  ? hrtimer_cancel_wait_running+0x39/0x80
[  127.373714] [      C1]  rt_spin_lock+0x3d/0x190
[  127.373716] [      C1]  ? hrtimer_cancel_wait_running+0x4d/0x80
[  127.373718] [      C1]  ? __local_bh_disable_ip+0x48/0x1c0
[  127.373720] [      C1]  ? __local_bh_disable_ip+0x29/0x1c0
[  127.373722] [      C1]  ? hrtimer_cancel_wait_running+0x39/0x80
[  127.373724] [      C1]  hrtimer_cancel_wait_running+0x4d/0x80
[  127.373727] [      C1]  hrtimer_cancel+0x34/0x50
[  127.373730] [      C1]  bpf_timer_cancel+0x1fd/0x2e0
[  127.373734] [      C1]  bpf_prog_c55f7d3cdccd3222_timer_cb2+0x59/0x6e
[  127.373737] [      C1]  ? 0xffffffffc014d2a4
[  127.373754] [      C1]  bpf_timer_cb+0x74/0x140
[  127.373757] [      C1]  ? __pfx_bpf_timer_cb+0x10/0x10
[  127.373760] [      C1]  __hrtimer_run_queues+0x1b3/0x430
[  127.373763] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  127.373768] [      C1]  hrtimer_run_softirq+0x9d/0x100
[  127.373771] [      C1]  handle_softirqs.isra.0+0xb0/0x3e0
[  127.373775] [      C1]  ? smpboot_thread_fn+0x25/0x2c0
[  127.373779] [      C1]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  127.373782] [      C1]  run_ktimerd+0x40/0xa0
[  127.373784] [      C1]  smpboot_thread_fn+0x143/0x2c0
[  127.373788] [      C1]  kthread+0x11c/0x210
[  127.373791] [      C1]  ? __pfx_kthread+0x10/0x10
[  127.373793] [      C1]  ret_from_fork+0x34/0x50
[  127.373796] [      C1]  ? __pfx_kthread+0x10/0x10
[  127.373799] [      C1]  ret_from_fork_asm+0x1a/0x30
[  127.373806] [      C1]  </TASK>


Bert Karwatzki

