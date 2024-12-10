Return-Path: <bpf+bounces-46562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859D9EBB27
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C91654F8
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F59222B5B3;
	Tue, 10 Dec 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="QUpCzcnS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102622B59E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863974; cv=none; b=QhOiPwHDXtlO2oYMUHNc8VmbHOr3nfhGHAdp1ascwqlX9Qe2zkK0cO6KWojhfckX36iR4ptXPsS+rqsWSyWRk/wkaJIet3w8kEUDbEIpdo0sQT8omv8nrFgRGozExHUoPMMSYlaeAnPmuRp4jRK4dwZx9R5ly1VfytfEMApfjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863974; c=relaxed/simple;
	bh=kpkjbqJlARrO04dphPLqAKU7+ufGSPBRjXu1+uaGn2c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8yKJ2l7h1BG+xosBjp2RqP44sb6KVyn+T7bhexXt5EFpTnA6t149URtwnmPAOG8JsgvXmc4suIzBf3dL0iMbDS6RNKhY6lqRh7mjYTPwtftqLXb6/7XfBRyvvU08xLj5qYkcbpM/CKKk60yrscTLTHAYIvm4qhA9FUZBquUGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=QUpCzcnS; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1733863963; x=1734123163;
	bh=uOkDX5V/T0NRFu8MciGQMCpgm04Pchfx/yAS6HckKLM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QUpCzcnSLqdx+EVvhIOW3brotXI+6Lv4Fkv0IKAqxXgqJuZ50XaAr3eJrnize7bXl
	 kYM4PC5sBV4gQfmsueRV/8gIWO0mRwoC4BKBuFXwa+sVw+ROqdUxRoGwgbz+ZDbJ6C
	 0QQ2ltCfocq1t2nan/F8F6vF6AJ4P5igjHeF+ejmgG57M/YvDerTD4u+RkS8bnpmJV
	 DsT7IrZwxROVqKlK4OT4BVfb007JWrQmCFADpOJAqKfcMuDe/dRpGoMzVXqBr0sY2A
	 qU+SUtlAYsMA/s8uP+RaHtaQFYZ06XjFxzCo0+SVKhTXuy0Hs3hrXJU31+cW5LH5sJ
	 ku2uA2djvxRNA==
Date: Tue, 10 Dec 2024 20:52:36 +0000
To: David Vernet <void@manifault.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>, tj@kernel.org
Subject: Re: [PATCH] scx: Fix maximal BPF selftest prog
Message-ID: <qC39k3UsonrBYD_SmuxHnZIQLsuuccoCrkiqb_BT7DvH945A1_LZwE4g-5Pu9FcCtqZt4lY1HhIPi0homRuNWxkgo1rgP3bkxa0donw8kV4=@pm.me>
In-Reply-To: <20241209152924.4508-1-void@manifault.com>
References: <20241209152924.4508-1-void@manifault.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 557bd0dd47058b8fe03b7e29dc6177a48d1c871c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 9th, 2024 at 7:29 AM, David Vernet <void@manifault.com>=
 wrote:

>=20
>=20
> maximal.bpf.c is still dispatching to and consuming from SCX_DSQ_GLOBAL.
> Let's have it use its own DSQ to avoid any runtime errors.
>=20
> Signed-off-by: David Vernet void@manifault.com
>=20
> ---
> tools/testing/selftests/sched_ext/maximal.bpf.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

Hi David, thanks for looking into the test failures.

I ran BPF CI on kernel with this change on top of bpf-next (6e8ba494d87d) +=
 tests build fix [1].

I ran the workflow twice. A second run on aarch64 failed:
https://github.com/kernel-patches/vmtest/actions/runs/12263276418/job/34217=
056880

Failed tests are "dsp_local_on" and "exit".

The difference in comparison to a successful run is a deadlock, which
happens on attempt to attach a scheduler, assuming I read the log
correctly. See a paste below.

I'd like to note that the selftests/sched_ext/runner log is very
verbose (~23M), although I can't tell how necessary this is for
debugging.

[1] https://lore.kernel.org/bpf/20241121214014.3346203-1-ihor.solodrai@pm.m=
e/

2024-12-10T20:20:55.6921607Z ##[group]selftests/sched_ext - Executing selft=
ests/sched_ext/runner
2024-12-10T20:20:55.7556144Z=20
2024-12-10T20:20:55.7558626Z =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2024-12-10T20:20:55.7560796Z WARNING: inconsistent lock state
2024-12-10T20:20:55.7564132Z 6.13.0-rc2-gb23d77932777-dirty #1 Not tainted
2024-12-10T20:20:55.7566359Z --------------------------------
2024-12-10T20:20:55.7570239Z inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} =
usage.
2024-12-10T20:20:55.7573094Z runner/96 [HC0[0]:SC0[0]:HE1:SE1] takes:
2024-12-10T20:20:55.7579001Z ffff0000fb5f4858 (&rq->__lock){?.-.}-{2:2}, at=
: raw_spin_rq_lock_nested+0x2c/0x50
2024-12-10T20:20:55.7581586Z {IN-HARDIRQ-W} state was registered at:
2024-12-10T20:20:55.7583722Z   __lock_acquire+0x3c0/0xb18
2024-12-10T20:20:55.7586124Z   lock_acquire.part.0+0xe0/0x250
2024-12-10T20:20:55.7588061Z   lock_acquire+0x88/0x160
2024-12-10T20:20:55.7590605Z   _raw_spin_lock_nested+0x5c/0xb0
2024-12-10T20:20:55.7592640Z   try_to_wake_up+0x244/0x560
2024-12-10T20:20:55.7594719Z   wake_up_process+0x20/0x38
2024-12-10T20:20:55.7596673Z   hrtimer_wakeup+0x28/0x48
2024-12-10T20:20:55.7598757Z   __run_hrtimer+0x32c/0x3a0
2024-12-10T20:20:55.7601330Z   __hrtimer_run_queues+0xb4/0x140
2024-12-10T20:20:55.7603618Z   hrtimer_run_queues+0xe4/0x1d8
2024-12-10T20:20:55.7606009Z   update_process_times+0x3c/0x160
2024-12-10T20:20:55.7607957Z   tick_periodic+0x44/0x140
2024-12-10T20:20:55.7610565Z   tick_handle_periodic+0x34/0xa8
2024-12-10T20:20:55.7613159Z   arch_timer_handler_virt+0x34/0x58
2024-12-10T20:20:55.7615811Z   handle_percpu_devid_irq+0xb0/0x2a0
2024-12-10T20:20:55.7618562Z   generic_handle_domain_irq+0x34/0x58
2024-12-10T20:20:55.7620462Z   gic_handle_irq+0x5c/0xd8
2024-12-10T20:20:55.7622667Z   call_on_irq_stack+0x24/0x58
2024-12-10T20:20:55.7625060Z   do_interrupt_handler+0x88/0x98
2024-12-10T20:20:55.7626970Z   el1_interrupt+0x34/0x50
2024-12-10T20:20:55.7629327Z   el1h_64_irq_handler+0x18/0x28
2024-12-10T20:20:55.7631094Z   el1h_64_irq+0x6c/0x70
2024-12-10T20:20:55.7633416Z   default_idle_call+0xac/0x254
2024-12-10T20:20:55.7635665Z   default_idle_call+0xa8/0x254
2024-12-10T20:20:55.7637184Z   do_idle+0xc4/0x118
2024-12-10T20:20:55.7639486Z   cpu_startup_entry+0x3c/0x50
2024-12-10T20:20:55.7641200Z   rest_init+0x118/0x1a8
2024-12-10T20:20:55.7643382Z   start_kernel+0x59c/0x678
2024-12-10T20:20:55.7645786Z   __primary_switched+0x88/0x98
2024-12-10T20:20:55.7647582Z irq event stamp: 33739
2024-12-10T20:20:55.7653885Z hardirqs last  enabled at (33739): [<ffff80008=
00b699c>] scx_ops_bypass+0x174/0x3b8
2024-12-10T20:20:55.7660311Z hardirqs last disabled at (33738): [<ffff80008=
0d48ad4>] _raw_spin_lock_irqsave+0xb4/0xd8
2024-12-10T20:20:55.7666393Z softirqs last  enabled at (32824): [<ffff80008=
0056a34>] handle_softirqs+0x46c/0x490
2024-12-10T20:20:55.7672087Z softirqs last disabled at (32815): [<ffff80008=
00101bc>] __do_softirq+0x1c/0x28
2024-12-10T20:20:55.7672575Z=20
2024-12-10T20:20:55.7675191Z other info that might help us debug this:
2024-12-10T20:20:55.7678564Z  Possible unsafe locking scenario:
2024-12-10T20:20:55.7678867Z=20
2024-12-10T20:20:55.7680124Z        CPU0
2024-12-10T20:20:55.7680709Z        ----
2024-12-10T20:20:55.7682424Z   lock(&rq->__lock);
2024-12-10T20:20:55.7683722Z   <Interrupt>
2024-12-10T20:20:55.7685546Z     lock(&rq->__lock);
2024-12-10T20:20:55.7685788Z=20
2024-12-10T20:20:55.7687156Z  *** DEADLOCK ***
2024-12-10T20:20:55.7687380Z=20
2024-12-10T20:20:55.7689485Z 3 locks held by runner/96:
2024-12-10T20:20:55.7696730Z  #0: ffff8000821226f8 (update_mutex){+.+.}-{4:=
4}, at: bpf_struct_ops_link_create+0x13c/0x1b0
2024-12-10T20:20:55.7703773Z  #1: ffff80008207e7f0 (scx_ops_enable_mutex){+=
.+.}-{4:4}, at: scx_ops_enable.isra.0+0x88/0xaa8
2024-12-10T20:20:55.7709594Z  #2: ffff80008207e060 (bypass_lock){+.+.}-{2:2=
}, at: scx_ops_bypass+0x50/0x3b8
2024-12-10T20:20:55.7710078Z=20
2024-12-10T20:20:55.7710895Z stack backtrace:
2024-12-10T20:20:55.7717184Z CPU: 1 UID: 0 PID: 96 Comm: runner Not tainted=
 6.13.0-rc2-gb23d77932777-dirty #1
2024-12-10T20:20:55.7719782Z Hardware name: linux,dummy-virt (DT)
2024-12-10T20:20:55.7722429Z Sched_ext: create_dsq (enabling)
2024-12-10T20:20:55.7723286Z Call trace:
2024-12-10T20:20:55.7725440Z  show_stack+0x20/0x38 (C)
2024-12-10T20:20:55.7727531Z  dump_stack_lvl+0xa0/0xf0
2024-12-10T20:20:55.7729283Z  dump_stack+0x18/0x28
2024-12-10T20:20:55.7732218Z  print_usage_bug.part.0+0x270/0x320
2024-12-10T20:20:55.7734277Z  mark_lock_irq+0x3e0/0x538
2024-12-10T20:20:55.7736126Z  mark_lock+0x1c0/0x290
2024-12-10T20:20:55.7738113Z  mark_usage+0x108/0x170
2024-12-10T20:20:55.7740306Z  __lock_acquire+0x3c0/0xb18
2024-12-10T20:20:55.7742923Z  lock_acquire.part.0+0xe0/0x250
2024-12-10T20:20:55.7744782Z  lock_acquire+0x88/0x160
2024-12-10T20:20:55.7747510Z  _raw_spin_lock_nested+0x5c/0xb0
2024-12-10T20:20:55.7750224Z  raw_spin_rq_lock_nested+0x2c/0x50
2024-12-10T20:20:55.7752314Z  scx_ops_bypass+0xfc/0x3b8
2024-12-10T20:20:55.7755093Z  scx_ops_enable.isra.0+0x2c8/0xaa8
2024-12-10T20:20:55.7756819Z  bpf_scx_reg+0x18/0x30
2024-12-10T20:20:55.7760072Z  bpf_struct_ops_link_create+0x154/0x1b0
2024-12-10T20:20:55.7762017Z  link_create+0x14c/0x350
2024-12-10T20:20:55.7763821Z  __sys_bpf+0x3fc/0xb90
2024-12-10T20:20:55.7765976Z  __arm64_sys_bpf+0x2c/0x48
2024-12-10T20:20:55.7768134Z  invoke_syscall+0x50/0x120
2024-12-10T20:20:55.7771191Z  el0_svc_common.constprop.0+0x48/0xf0
2024-12-10T20:20:55.7772796Z  do_el0_svc+0x24/0x38
2024-12-10T20:20:55.7774452Z  el0_svc+0x48/0x110
2024-12-10T20:20:55.7777321Z  el0t_64_sync_handler+0x10c/0x138
2024-12-10T20:20:55.7779253Z  el0t_64_sync+0x198/0x1a0
2024-12-10T20:20:55.7782673Z ------------[ cut here ]------------
2024-12-10T20:20:55.7786247Z raw_local_irq_restore() called with IRQs enabl=
ed
2024-12-10T20:20:55.7792987Z WARNING: CPU: 1 PID: 96 at kernel/locking/irqf=
lag-debug.c:10 warn_bogus_irq_restore+0x30/0x40
2024-12-10T20:20:55.7794104Z Modules linked in:
2024-12-10T20:20:55.7799949Z CPU: 1 UID: 0 PID: 96 Comm: runner Not tainted=
 6.13.0-rc2-gb23d77932777-dirty #1
2024-12-10T20:20:55.7802378Z Hardware name: linux,dummy-virt (DT)
2024-12-10T20:20:55.7804767Z Sched_ext: create_dsq (enabling)
2024-12-10T20:20:55.7809450Z pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DI=
T -SSBS BTYPE=3D--)
2024-12-10T20:20:55.7812011Z pc : warn_bogus_irq_restore+0x30/0x40
2024-12-10T20:20:55.7814814Z lr : warn_bogus_irq_restore+0x30/0x40
2024-12-10T20:20:55.7816303Z sp : ffff800084d53a50
2024-12-10T20:20:55.7821165Z x29: ffff800084d53a50 x28: ffff0000c0960000 x2=
7: ffff80008205d078
2024-12-10T20:20:55.7825770Z x26: ffff800081cf6840 x25: ffff800082059350 x2=
4: ffff800082256958
2024-12-10T20:20:55.7830346Z x23: 0000000000000000 x22: ffff0000fb5f4858 x2=
1: ffff80008207d6b8
2024-12-10T20:20:55.7834929Z x20: 0000000000000001 x19: ffff0000fb5f4840 x1=
8: 00000000fffffffd
2024-12-10T20:20:55.7839534Z x17: 3764333262672d32 x16: 63722d302e33312e x1=
5: ffff800084d52c90
2024-12-10T20:20:55.7844210Z x14: 0000000000000000 x13: 64656c62616e6520 x1=
2: 7351524920687469
2024-12-10T20:20:55.7849054Z x11: 772064656c6c6163 x10: ffff8000820da8b0 x9=
 : ffff800080101b00
2024-12-10T20:20:55.7854102Z x8 : 00000000ffffefff x7 : ffff8000820da8b0 x6=
 : 80000000fffff000
2024-12-10T20:20:55.7858669Z x5 : 000000000000017f x4 : 0000000000000000 x3=
 : 0000000000000000
2024-12-10T20:20:55.7863487Z x2 : 0000000000000000 x1 : 0000000000000000 x0=
 : ffff0000c0960000
2024-12-10T20:20:55.7864284Z Call trace:
2024-12-10T20:20:55.7867341Z  warn_bogus_irq_restore+0x30/0x40 (P)
2024-12-10T20:20:55.7870193Z  warn_bogus_irq_restore+0x30/0x40 (L)
2024-12-10T20:20:55.7872308Z  scx_ops_bypass+0x224/0x3b8
2024-12-10T20:20:55.7875067Z  scx_ops_enable.isra.0+0x2c8/0xaa8
2024-12-10T20:20:55.7876915Z  bpf_scx_reg+0x18/0x30
2024-12-10T20:20:55.7880088Z  bpf_struct_ops_link_create+0x154/0x1b0
2024-12-10T20:20:55.7881875Z  link_create+0x14c/0x350
2024-12-10T20:20:55.7883755Z  __sys_bpf+0x3fc/0xb90
2024-12-10T20:20:55.7885864Z  __arm64_sys_bpf+0x2c/0x48
2024-12-10T20:20:55.7887978Z  invoke_syscall+0x50/0x120
2024-12-10T20:20:55.7890961Z  el0_svc_common.constprop.0+0x48/0xf0
2024-12-10T20:20:55.7892546Z  do_el0_svc+0x24/0x38
2024-12-10T20:20:55.7894224Z  el0_svc+0x48/0x110
2024-12-10T20:20:55.7896940Z  el0t_64_sync_handler+0x10c/0x138
2024-12-10T20:20:55.7898846Z  el0t_64_sync+0x198/0x1a0
2024-12-10T20:20:55.7900627Z irq event stamp: 33739
2024-12-10T20:20:55.7906972Z hardirqs last  enabled at (33739): [<ffff80008=
00b699c>] scx_ops_bypass+0x174/0x3b8
2024-12-10T20:20:55.7913438Z hardirqs last disabled at (33738): [<ffff80008=
0d48ad4>] _raw_spin_lock_irqsave+0xb4/0xd8
2024-12-10T20:20:55.7919488Z softirqs last  enabled at (32824): [<ffff80008=
0056a34>] handle_softirqs+0x46c/0x490
2024-12-10T20:20:55.7925161Z softirqs last disabled at (32815): [<ffff80008=
00101bc>] __do_softirq+0x1c/0x28
2024-12-10T20:20:55.7927698Z ---[ end trace 0000000000000000 ]---
2024-12-10T20:20:55.8646931Z sched_ext: BPF scheduler "create_dsq" enabled
2024-12-10T20:20:55.9047921Z sched_ext: BPF scheduler "create_dsq" disabled=
 (unregistered from user space)
2024-12-10T20:20:55.9647423Z sched_ext: BPF scheduler "enq_last_no_enq_fail=
s" disabled (runtime error)
2024-12-10T20:20:55.9653845Z sched_ext: enq_last_no_enq_fails: SCX_OPS_ENQ_=
LAST requires ops.enqueue() to be implemented
2024-12-10T20:20:55.9656238Z    scx_ops_enable.isra.0+0xa98/0xaa8
2024-12-10T20:20:55.9658038Z    bpf_scx_reg+0x18/0x30
2024-12-10T20:20:55.9661235Z    bpf_struct_ops_link_create+0x154/0x1b0
2024-12-10T20:20:55.9663113Z    link_create+0x14c/0x350
2024-12-10T20:20:55.9664999Z    __sys_bpf+0x3fc/0xb90
2024-12-10T20:20:55.9667216Z    __arm64_sys_bpf+0x2c/0x48
2024-12-10T20:20:55.9669376Z    invoke_syscall+0x50/0x120
2024-12-10T20:20:55.9672393Z    el0_svc_common.constprop.0+0x48/0xf0
2024-12-10T20:20:55.9674125Z    do_el0_svc+0x24/0x38
2024-12-10T20:20:55.9675781Z    el0_svc+0x48/0x110
2024-12-10T20:20:55.9678659Z    el0t_64_sync_handler+0x10c/0x138
2024-12-10T20:20:55.9680560Z    el0t_64_sync+0x198/0x1a0
2024-12-10T20:20:55.9864103Z sched_ext: BPF scheduler "enq_select_cpu_fails=
" enabled
2024-12-10T20:20:56.0347550Z sched_ext: BPF scheduler "enq_select_cpu_fails=
" disabled (runtime error)
2024-12-10T20:20:56.0354154Z sched_ext: enq_select_cpu_fails: kfunc with ma=
sk 0x8 called from an operation only allowing 0x4
2024-12-10T20:20:56.0356414Z    scx_bpf_select_cpu_dfl+0x8c/0x98
2024-12-10T20:20:56.0361395Z    bpf_prog_b68dda6ca71e9089_enq_select_cpu_fa=
ils_enqueue+0x54/0xb0
2024-12-10T20:20:56.0364138Z    bpf__sched_ext_ops_enqueue+0x50/0x74
2024-12-10T20:20:56.0366225Z    do_enqueue_task+0xf8/0x240
2024-12-10T20:20:56.0368567Z    enqueue_task_scx+0x190/0x288
2024-12-10T20:20:56.0370532Z    enqueue_task+0x44/0xe8
2024-12-10T20:20:56.0372845Z    ttwu_do_activate+0x88/0x298
2024-12-10T20:20:56.0375059Z    try_to_wake_up+0x2b8/0x560
2024-12-10T20:20:56.0377269Z    wake_up_process+0x20/0x38
2024-12-10T20:20:56.0379030Z    kick_pool+0xa4/0x190
2024-12-10T20:20:56.0381198Z    __queue_work+0x540/0x600
2024-12-10T20:20:56.0383276Z    queue_work_on+0xb8/0x100
2024-12-10T20:20:56.0385314Z    bpf_prog_free+0x90/0xa8
2024-12-10T20:20:56.0387681Z    __bpf_prog_put_rcu+0x44/0x60
2024-12-10T20:20:56.0389757Z    rcu_do_batch+0x1e8/0xa90
2024-12-10T20:20:56.0391541Z    rcu_core+0x174/0x378
2024-12-10T20:20:56.0393744Z    rcu_core_si+0x18/0x30
2024-12-10T20:20:56.0395820Z    handle_softirqs+0x12c/0x490
2024-12-10T20:20:56.0397644Z    __do_softirq+0x1c/0x28
2024-12-10T20:20:56.0399798Z    ____do_softirq+0x18/0x30
2024-12-10T20:20:56.0402104Z    call_on_irq_stack+0x24/0x58
2024-12-10T20:20:56.0404662Z    do_softirq_own_stack+0x24/0x38
2024-12-10T20:20:56.0406780Z    __irq_exit_rcu+0x140/0x180
2024-12-10T20:20:56.0408766Z    irq_exit_rcu+0x18/0x48
2024-12-10T20:20:56.0410801Z    el1_interrupt+0x38/0x50
2024-12-10T20:20:56.0413210Z    el1h_64_irq_handler+0x18/0x28
2024-12-10T20:20:56.0415052Z    el1h_64_irq+0x6c/0x70
2024-12-10T20:20:56.0417472Z    default_idle_call+0xac/0x254
2024-12-10T20:20:56.0419830Z    default_idle_call+0xa8/0x254
2024-12-10T20:20:56.0421507Z    do_idle+0xc4/0x118
2024-12-10T20:20:56.0423811Z    cpu_startup_entry+0x3c/0x50
2024-12-10T20:20:56.0426578Z    secondary_start_kernel+0xdc/0x108
2024-12-10T20:20:56.0428987Z    __secondary_switched+0xc0/0xc8
2024-12-10T20:20:57.1047514Z sched_ext: BPF scheduler "ddsp_bogus_dsq_fail"=
 enabled
2024-12-10T20:20:57.1647261Z sched_ext: BPF scheduler "ddsp_bogus_dsq_fail"=
 disabled (runtime error)
2024-12-10T20:20:57.1652666Z sched_ext: ddsp_bogus_dsq_fail: non-existent D=
SQ 0xcafef00d for rcu_sched[16]
2024-12-10T20:20:57.1655003Z    find_dsq_for_dispatch+0xf4/0x158
2024-12-10T20:20:57.1657196Z    direct_dispatch+0x58/0x228
2024-12-10T20:20:57.1659464Z    do_enqueue_task+0x17c/0x240
2024-12-10T20:20:57.1661801Z    enqueue_task_scx+0x190/0x288
2024-12-10T20:20:57.1663937Z    enqueue_task+0x44/0xe8
2024-12-10T20:20:57.1666068Z    ttwu_do_activate+0x88/0x298
2024-12-10T20:20:57.1668231Z    try_to_wake_up+0x2b8/0x560
2024-12-10T20:20:57.1670117Z    swake_up_one+0x4c/0x98
2024-12-10T20:20:57.1672701Z    swake_up_one_online+0x54/0xc0
2024-12-10T20:20:57.1674986Z    rcu_gp_kthread_wake+0x68/0x98
2024-12-10T20:20:57.1678136Z    rcu_accelerate_cbs_unlocked+0xf0/0x128
2024-12-10T20:20:57.1679813Z    rcu_core+0x350/0x378
2024-12-10T20:20:57.1681646Z    rcu_core_si+0x18/0x30
2024-12-10T20:20:57.1683953Z    handle_softirqs+0x12c/0x490
2024-12-10T20:20:57.1685841Z    __do_softirq+0x1c/0x28
2024-12-10T20:20:57.1687901Z    ____do_softirq+0x18/0x30
2024-12-10T20:20:57.1690172Z    call_on_irq_stack+0x24/0x58
2024-12-10T20:20:57.1692602Z    do_softirq_own_stack+0x24/0x38
2024-12-10T20:20:57.1694778Z    __irq_exit_rcu+0x140/0x180
2024-12-10T20:20:57.1696640Z    irq_exit_rcu+0x18/0x48
2024-12-10T20:20:57.1698672Z    el1_interrupt+0x38/0x50
2024-12-10T20:20:57.1701082Z    el1h_64_irq_handler+0x18/0x28
2024-12-10T20:20:57.1702858Z    el1h_64_irq+0x6c/0x70
2024-12-10T20:20:57.1705280Z    default_idle_call+0xac/0x254
2024-12-10T20:20:57.1707600Z    default_idle_call+0xa8/0x254
2024-12-10T20:20:57.1709171Z    do_idle+0xc4/0x118
2024-12-10T20:20:57.1711481Z    cpu_startup_entry+0x40/0x50
2024-12-10T20:20:57.1714251Z    secondary_start_kernel+0xdc/0x108
2024-12-10T20:20:57.1716568Z    __secondary_switched+0xc0/0xc8
2024-12-10T20:20:58.2547951Z sched_ext: BPF scheduler "ddsp_vtimelocal_fail=
" enabled
2024-12-10T20:20:58.3147251Z sched_ext: BPF scheduler "ddsp_vtimelocal_fail=
" disabled (runtime error)
2024-12-10T20:20:58.3152469Z sched_ext: ddsp_vtimelocal_fail: cannot use vt=
ime ordering for built-in DSQs
2024-12-10T20:20:58.3154552Z    dispatch_enqueue+0x350/0x360
2024-12-10T20:20:58.3156792Z    direct_dispatch+0x144/0x228
2024-12-10T20:20:58.3159057Z    do_enqueue_task+0x17c/0x240
2024-12-10T20:20:58.3161402Z    enqueue_task_scx+0x190/0x288
2024-12-10T20:20:58.3163484Z    enqueue_task+0x44/0xe8
2024-12-10T20:20:58.3165655Z    ttwu_do_activate+0x88/0x298
2024-12-10T20:20:58.3167841Z    try_to_wake_up+0x2b8/0x560
2024-12-10T20:20:58.3169741Z    swake_up_one+0x4c/0x98
2024-12-10T20:20:58.3172304Z    swake_up_one_online+0x54/0xc0
2024-12-10T20:20:58.3174591Z    rcu_gp_kthread_wake+0x68/0x98
2024-12-10T20:20:58.3177003Z    rcu_report_qs_rsp+0xc0/0x110
2024-12-10T20:20:58.3179438Z    rcu_report_qs_rnp+0x324/0x380
2024-12-10T20:20:58.3181831Z    rcu_report_qs_rdp+0x1ac/0x1c8
2024-12-10T20:20:58.3183880Z    rcu_core+0x264/0x378
2024-12-10T20:20:58.3185468Z    rcu_core_si+0x18/0x30
2024-12-10T20:20:58.3187895Z    handle_softirqs+0x12c/0x490
2024-12-10T20:20:58.3189738Z    __do_softirq+0x1c/0x28
2024-12-10T20:20:58.3191821Z    ____do_softirq+0x18/0x30
2024-12-10T20:20:58.3194130Z    call_on_irq_stack+0x24/0x58
2024-12-10T20:20:58.3196588Z    do_softirq_own_stack+0x24/0x38
2024-12-10T20:20:58.3198745Z    __irq_exit_rcu+0x140/0x180
2024-12-10T20:20:58.3200627Z    irq_exit_rcu+0x18/0x48
2024-12-10T20:20:58.3202698Z    el1_interrupt+0x38/0x50
2024-12-10T20:20:58.3205112Z    el1h_64_irq_handler+0x18/0x28
2024-12-10T20:20:58.3206944Z    el1h_64_irq+0x6c/0x70
2024-12-10T20:20:58.3209342Z    default_idle_call+0xac/0x254
2024-12-10T20:20:58.3211702Z    default_idle_call+0xa8/0x254
2024-12-10T20:20:58.3213312Z    do_idle+0xc4/0x118
2024-12-10T20:20:58.3215643Z    cpu_startup_entry+0x40/0x50
2024-12-10T20:20:58.3218478Z    secondary_start_kernel+0xdc/0x108
2024-12-10T20:20:58.3220846Z    __secondary_switched+0xc0/0xc8
2024-12-10T20:20:59.3646877Z sched_ext: BPF scheduler "dsp_local_on" enable=
d
2024-12-10T20:21:00.3650453Z ERR: dsp_local_on.c:37
2024-12-10T20:21:00.3652199Z Expected skel->data->uei.kind =3D=3D EXIT_KIND=
(SCX_EXIT_ERROR) (0 =3D=3D 1024)
2024-12-10T20:21:00.3873220Z ERR: exit.c:30
2024-12-10T20:21:00.3873570Z Failed to attach scheduler
2024-12-10T20:21:00.4746585Z psci: CPU1 killed (polled 0 ms)
2024-12-10T20:21:00.4946799Z sched_ext: BPF scheduler "dsp_local_on" disabl=
ed (runtime error)
2024-12-10T20:21:00.4953445Z sched_ext: dsp_local_on: SCX_DSQ_LOCAL[_ON] ve=
rdict target cpu 0 not allowed for ksoftirqd/1[23]
2024-12-10T20:21:00.4955934Z    task_can_run_on_remote_rq+0xdc/0x108
2024-12-10T20:21:00.4958580Z    dispatch_to_local_dsq+0x74/0x1d0
2024-12-10T20:21:00.4960911Z    flush_dispatch_buf+0x18c/0x1d8
2024-12-10T20:21:00.4962903Z    balance_one+0x154/0x2f8
2024-12-10T20:21:00.4964749Z    balance_scx+0x58/0x98
2024-12-10T20:21:00.4966663Z    __schedule+0x390/0x838
2024-12-10T20:21:00.4968348Z    schedule+0x54/0x138
2024-12-10T20:21:00.4970453Z    worker_thread+0xec/0x360
2024-12-10T20:21:00.4972076Z    kthread+0x100/0x110
2024-12-10T20:21:00.4974136Z    ret_from_fork+0x10/0x20
2024-12-10T20:21:00.5545933Z sched_ext: BPF scheduler "hotplug_cbs" enabled
2024-12-10T20:21:00.6145106Z Detected PIPT I-cache on CPU1
2024-12-10T20:21:00.6149673Z GICv3: CPU1: found redistributor 1 region 0:0x=
00000000080c0000
2024-12-10T20:21:00.6154461Z CPU1: Booted secondary processor 0x0000000001 =
[0x413fd0c1]
2024-12-10T20:21:00.8046976Z sched_ext: BPF scheduler "hotplug_cbs" disable=
d (unregistered from BPF)
2024-12-10T20:21:00.8047755Z EXIT: unregistered from BPF (hotplug event det=
ected (1 going online))
2024-12-10T20:21:00.9246328Z sched_ext: BPF scheduler "hotplug_cbs" enabled
2024-12-10T20:21:01.0246233Z psci: CPU1 killed (polled 0 ms)
2024-12-10T20:21:01.0946840Z sched_ext: BPF scheduler "hotplug_cbs" disable=
d (unregistered from BPF)
2024-12-10T20:21:01.0947621Z EXIT: unregistered from BPF (hotplug event det=
ected (1 going offline))
2024-12-10T20:21:01.1545076Z Detected PIPT I-cache on CPU1
2024-12-10T20:21:01.1549600Z GICv3: CPU1: found redistributor 1 region 0:0x=
00000000080c0000
2024-12-10T20:21:01.1554406Z CPU1: Booted secondary processor 0x0000000001 =
[0x413fd0c1]
2024-12-10T20:21:01.2245966Z psci: CPU1 killed (polled 0 ms)


>=20
> diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/test=
ing/selftests/sched_ext/maximal.bpf.c
> index 4c005fa71810..430f5e13bf55 100644
> --- a/tools/testing/selftests/sched_ext/maximal.bpf.c
> +++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
> @@ -12,6 +12,8 @@
>=20
> char _license[] SEC("license") =3D "GPL";
>=20
> +#define DSQ_ID 0
> +
> s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cp=
u,
> u64 wake_flags)
> {
> @@ -20,7 +22,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_stru=
ct *p, s32 prev_cpu,
>=20
> void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags=
)
> {
> - scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> + scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
> }
>=20
> void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags=
)
> @@ -28,7 +30,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct=
 *p, u64 deq_flags)
>=20
> void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
> {
> - scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL);
> + scx_bpf_dsq_move_to_local(DSQ_ID);
> }
>=20
> void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flag=
s)
> @@ -123,7 +125,7 @@ void BPF_STRUCT_OPS(maximal_cgroup_set_weight, struct=
 cgroup *cgrp, u32 weight)
>=20
> s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
> {
> - return 0;
> + return scx_bpf_create_dsq(DSQ_ID, -1);
> }
>=20
> void BPF_STRUCT_OPS(maximal_exit, struct scx_exit_info *info)
> --
> 2.46.1

