Return-Path: <bpf+bounces-60015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC2AD131F
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494687A20C0
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957ED194137;
	Sun,  8 Jun 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="U89m3wNL"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555034C9D;
	Sun,  8 Jun 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398027; cv=none; b=aLZnflUqyF1SeH08OCF8IJhNfaAS8jJVbXKuRU1kfpOPu4HUnX06xgPOUlvs1dk+hYXBy9rKdiwEUSjRkknCBFUZiFekOX4ejUwY4Lj+RKReobNUBjZ4aq5vdusmS6wdFa5Ui5ojjDaPXJkPj1e4F7vEwNbDm1XddtIhkCqC71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398027; c=relaxed/simple;
	bh=n/pRS8TC0DhYOpQkk+ckni+vx3w+9lx1cmNbt4ePB+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=elZiueiuUiBlz0A+0UnY/7HLVdxuXm2B03ayR7g3YzXTaBA3NSTTZC7TKLAFX2/Gmj2S68M7hUES3i7PHynQFw8ho0QEy2Dhyf7X4bSORas9PIAOK1nRXPvcOO9tJ0G+koj1JlyErd5hPaYowXtQmFaxl2Ym3DcF8K/2Q+j4as4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=U89m3wNL; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749397992; x=1750002792; i=spasswolf@web.de;
	bh=PnHniw1I6lBBQY7VbSfM4GmT9OXA2J4T8IFN/uKRYDU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U89m3wNL1s4Xj/UCxuOFbJ7hmEqIMBozqc9vhj0qeyWHZDLyWqIBawdm4SLb4HpP
	 Pvjv4y7CMXwHllxzv/o6s8a6igNC2D1wzRRMctRDaq/W7ylJtbtb3lz3A8uDFLvD/
	 YjyQR15K7/jXglB2sWCT1GkMTU8SXmVf7G4S3SMK6IVoXNpw/yLigG6QG+nCDWZMZ
	 oLK3J0m28+WlLzZxkTk6vFoj2SdTBOTXfl/9aEvXhuHRGYcmckj+tMcAgKcUk3eF/
	 aUCM6pGkUF0VzY4kJldHZSgnjld+4YpVbHkoGm5i5OgjYNinJfsF3Q5pHGlczN20S
	 InxD6ns9HhuPm+o6qQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDe2F-1uWEwh2g2J-00GEqT; Sun, 08
 Jun 2025 17:53:12 +0200
Message-ID: <727212f9d3c324787ddd9ede9e2d800a02b629b2.camel@web.de>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, spasswolf@web.de
Date: Sun, 08 Jun 2025 17:53:10 +0200
In-Reply-To: <0b1f48ba715a16c4d4874ae65bc01914de4d5a90.camel@web.de>
References: <20250605091904.5853-1-spasswolf@web.de>
			 <20250605084816.3e5d1af1@gandalf.local.home>
			 <20250605125133.RSTingmi@linutronix.de>
	 <0b1f48ba715a16c4d4874ae65bc01914de4d5a90.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kiswLnRj5CoWTFnpEPm3rm6NLB5FuHqQxT331vr2xKRlOow2vlR
 KVZDVH7L+9mptZQ5KKndTsFvClLQMNzD8/YR6UW0ekuoWWS8j6kXQIz0Li7zDwb4STYocco
 jdoWqv5YvNEszgkWajsQW6kXC48Q64qdUIvhLP7RLcr4i+Ss9JBoilOI0ntEcO8Wc1cy0YF
 nT7yF8OsSbpALL5LypNhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1aA72nA/ChA=;Shet2+Ozwo5ECxV4dwhkCwAuWC/
 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
 qmYu1W8d9O1NV/qF

Am Sonntag, dem 08.06.2025 um 10:45 +0200 schrieb Bert Karwatzki:
> Am Donnerstag, dem 05.06.2025 um 14:51 +0200 schrieb Sebastian Andrzej S=
iewior:
> > On 2025-06-05 08:48:38 [-0400], Steven Rostedt wrote:
> > > On Thu,  5 Jun 2025 11:19:03 +0200
> > > Bert Karwatzki <spasswolf@web.de> wrote:
> > >=20
> > > > This patch seems to create so much output that the orginal error m=
essage and
> > > > backtrace often get lost, so I needed several runs to get a meanin=
gful message
> > > > when running
> > >=20
> > > Are you familiar with preempt count tracing?
> >=20
> > I have an initial set of patches to tackle this problem, I'm going to
> > send them after the merge window.
> >=20
> > Sebastian
>=20
> I've found the reason for the "mysterious" increase of preempt_count:
>=20
> [   70.821750] [   T2746] bpf_link_settle calling fd_install() preemt_co=
unt =3D 0
> [   70.821751] [   T2746] preempt_count_add 5898: preempt_count =3D 0x0 =
counter =3D 0x1b232c
> [   70.821752] [   T2746] preempt_count_add 5900: preempt_count =3D 0x1 =
counter =3D 0x1b232d
> [   70.821754] [   T2746] preempt_count_sub 5966: preempt_count =3D 0x1 =
counter =3D 0x1b232e
> [   70.821755] [   T2746] preempt_count_sub 5968: preempt_count =3D 0x0 =
counter =3D 0x1b232f
> [   70.821761] [   T2746] __bpf_trace_sys_enter 18: preempt_count =3D 0x=
0
> [   70.821762] [   T2746] __bpf_trace_sys_enter 18: preempt_count =3D 0x=
1
> [   70.821764] [   T2746] __bpf_trace_run: preempt_count =3D 1
> [   70.821765] [   T2746] bpf_prog_run: preempt_count =3D 1
> [   70.821766] [   T2746] __bpf_prog_run: preempt_count =3D 1
>=20
> It's caused by this macro from include/trace/bpf_probe.h (with my pr_err=
()):
>=20
> #define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args) \
> static notrace void \
> __bpf_trace_##call(void *__data, proto) \
> { \
>  might_fault(); \
>  if (!strcmp(get_current()->comm, "test_progs")) \
>  pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_cou=
nt());\
>  preempt_disable_notrace(); \
>  if (!strcmp(get_current()->comm, "test_progs")) \
>  pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_cou=
nt());\
>  CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args))=
; \
>  preempt_enable_notrace(); \
> }
>=20
> The preempt_{en,dis}able_notrace were introduced in
> commit 4aadde89d81f ("tracing/bpf: disable preemption in syscall probe")
> This commit is present in v6.14 and v6.15, but the bug already appears i=
n
> v6.12 so in that case preemption is disable somewhere else.=20
>=20
> Bert Karwatzki

After reading this=C2=A0
https://lore.kernel.org/bpf/CAADnVQJf535hwud5XtQKStOge9=3DpYVYWSiq_8Q2YAvN=
5rba=3D=3DA@mail.gmail.com/
I tried using migrate_{en,disable} like this (in v6.15)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 183fa2aa2935..49257cb90209 100644
=2D-- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -58,9 +58,9 @@ static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	might_fault();							\
-	preempt_disable_notrace();					\
+	migrate_disable();					\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));=
	\
-	preempt_enable_notrace();					\
+	migrate_enable();					\
 }
=20
 #undef DECLARE_EVENT_SYSCALL_CLASS
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 187dc37d61d4..ec0326405fc3 100644
=2D-- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2350,7 +2350,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u=
64 *args)
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
=20
-	cant_sleep();
+	cant_migrate();
 	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/te=
sting/selftests/bpf/progs/dynptr_success.c
index e1fba28e4a86..7cfb9473a526 100644
=2D-- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -7,6 +7,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 #include "errno.h"
=20
 char _license[] SEC("license") =3D "GPL";


This fixes the warnings when running the bpf cgroup examples:

./test_progs -a "cgrp_local_storage/cgrp1*"

but I still get a warning from another example (I don't know which, yet):
[ T4696] BUG: sleeping function called from invalid context at kernel/lock=
ing/spinlock_rt.c:48
[ T4696] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 4696, name=
: test_progs
[ T4696] preempt_count: 1, expected: 0
[ T4696] RCU nest depth: 0, expected: 0
[ T4696] 2 locks held by test_progs/4696:
[ T4696]  #0: ffffffff91d30860 (rcu_read_lock_trace){....}-{0:0}, at: bpf_=
prog_test_run_syscall+0xbb/0x250
[ T4696]  #1: ffff9ca88e6741c8 ((&c->lock)){+.+.}-{3:3}, at: ___slab_alloc=
+0x68/0xde0
[ T4696] irq event stamp: 100
[ T4696] hardirqs last  enabled at (99): [<ffffffff91199098>] do_syscall_6=
4+0x38/0xfa0
[ T4696] hardirqs last disabled at (100): [<ffffffff907bc57b>] __bpf_async=
_init+0xdb/0x310
[ T4696] softirqs last  enabled at (0): [<ffffffff9057b694>] copy_process+=
0xc84/0x3840
[ T4696] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ T4696] CPU: 1 UID: 0 PID: 4696 Comm: test_progs Tainted: G           O  =
      6.15.0-bpf-00003-g5197b534e6ad #4 PREEMPT_{RT,(full)}=20
[ T4696] Tainted: [O]=3DOOT_MODULE
[ T4696] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-158L, BIOS E158LAMS.10F 11/11/2024
[ T4696] Call Trace:
[ T4696]  <TASK>
[ T4696]  dump_stack_lvl+0x6d/0xb0
[ T4696]  __might_resched.cold+0xe1/0xf3
[ T4696]  rt_spin_lock+0x5f/0x190
[ T4696]  ? ___slab_alloc+0x68/0xde0
[ T4696]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4696]  ___slab_alloc+0x68/0xde0
[ T4696]  ? find_held_lock+0x2b/0x80
[ T4696]  ? try_to_wake_up+0x47b/0xbb0
[ T4696]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4696]  ? bpf_map_kmalloc_node+0x72/0x220
[ T4696]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4696]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ T4696]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4696]  ? try_to_wake_up+0x47b/0xbb0
[ T4696]  ? bpf_map_kmalloc_node+0x72/0x220
[ T4696]  __kmalloc_node_noprof+0xee/0x490
[ T4696]  bpf_map_kmalloc_node+0x72/0x220
[ T4696]  __bpf_async_init+0x107/0x310
[ T4696]  bpf_timer_init+0x33/0x40
[ T4696]  bpf_prog_7e15f1bc7d1d26d0_start_cb+0x5d/0x91
[ T4696]  bpf_prog_d85f43676fabf521_start_timer+0x65/0x8a
[ T4696]  bpf_prog_test_run_syscall+0x103/0x250
[ T4696]  ? fput+0x3f/0x90
[ T4696]  __sys_bpf+0xd33/0x26d0
[ T4696]  __x64_sys_bpf+0x21/0x30
[ T4696]  do_syscall_64+0x72/0xfa0
[ T4696]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T4696] RIP: 0033:0x7f6e173fa779
[ T4696] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d=
 01 f0 ff ff
73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T4696] RSP: 002b:00007f6e0f95a878 EFLAGS: 00000202 ORIG_RAX: 00000000000=
00141
[ T4696] RAX: ffffffffffffffda RBX: 00007f6e0f95bcdc RCX: 00007f6e173fa779
[ T4696] RDX: 0000000000000050 RSI: 00007f6e0f95a8b0 RDI: 000000000000000a
[ T4696] RBP: 00007f6e0f95a890 R08: 0000000000000003 R09: 00007f6e0f95a8b0
[ T4696] R10: 00007ffcf6d23f80 R11: 0000000000000202 R12: 0000000000000020
[ T4696] R13: 000000000000005f R14: 00007ffcf6d23d70 R15: 00007f6e0f15b000
[ T4696]  </TASK>

Soon after that (1-2 min) while still running the bpf test_progs I got a k=
ernel panic
(flashing capslock and lockup) and needed to reboot.

Bert Karwatzki

