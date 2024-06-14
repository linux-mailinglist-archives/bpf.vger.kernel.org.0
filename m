Return-Path: <bpf+bounces-32160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB8090836B
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 07:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A097B2272A
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3F1482F5;
	Fri, 14 Jun 2024 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="yhAq3+Bi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F68147C90
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344497; cv=none; b=W0MBuk0wJ7zwZ1PuHrY/bq8YcYgArs+dmCX866XaEdQmPWBnyuw/7++oCAqCC+5Fzdf8heg3hoMRVfLQDf2bykduGkHJemrtL178W2CU+otBja3W9ZQ4fegOAN2XKNIzcocwYD5weuMm93MEIbsTFJ2qh+WaA+NuLG9dTIS4XCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344497; c=relaxed/simple;
	bh=RI/pXkGKtaFwUeyLZk9cz0L9EVjjznZ0E/lWyaaKc20=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=pdSmgZ/lEion7fqDhFDdC1OxMC1+Rogp9GMg7Zuq2eWWixMLoHcJ3uINaNL+ai4oi6+HGtltsN5PXzJqo4oHxmk9U1CrTGHAMxH7Qmu/OTBTfUMX87sLRPqGjPruZS7bBUPJmXMfD+7aMLWgLSG5KB+vfE5ZYu/5hYifxxrIP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=yhAq3+Bi; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1718344487; x=1718603687;
	bh=LAwh+I2iZlrBQrEul9x/4MqULkQ0HJaUR7ILwH7PT+0=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=yhAq3+Bi6fW107LggUepLdGKJ+e/CVn3VRdGRvZFTBEmQdzW9YQAn65loR7IxRzXT
	 1v+RMx3itcVkaqsVU04UBbk79KPLCNVNlUE89+l2ydBpXHSzdsqu952+5pB0dgO8Ht
	 BYVTQhcq8DMOFEnWMzR0fqtr+PFIL4UQFuYl2jbDTUZIr9I4ce1QS838jdkL0E4O46
	 VE+bh/AHXX0Bf+qPrEUMEl6rKXrUYaBkMpFbZWglFx2XbaNs20w/8E+jtFVsFF/DvZ
	 +3XVezfYHA8Lzmi5m8c+p9/T8LHMidErDRrZHZG7Ch/w8FJ27/LzRqiK87vaA4Ur5k
	 m3kSwrc/6IzAw==
Date: Fri, 14 Jun 2024 05:54:42 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: Zac Ecob <zacecob@protonmail.com>
Subject: rcu_preempt detected stalls related to ebpf
Message-ID: <eHjqF1DbM2cbq_nXVoanIt042aeSlLwf3xBQ-LTesttfagbXyJfsxMa1zyHU6ngtUYRD4-nfM3sAmyRbPiSN7o4_sWtRy8zodlI7K2UmyTg=@protonmail.com>
Feedback-ID: 29112261:user:proton
X-Pm-Message-ID: b87214a12080365dd574a7f1e50670f0099a8d48
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_l5spU0ArODDJkB6IIQetIcvPWB4Tp0dHQE6DLk2VKZQ"

This is a multi-part message in MIME format.

--b1_l5spU0ArODDJkB6IIQetIcvPWB4Tp0dHQE6DLk2VKZQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I am receiving an error from the RCU stall detector when using ebpf.=20

I have managed to reproduce it on the 6.9.4 kernel (running inside qemu_sys=
tem_x86-64), using the files attached.

The exact output is:

[   21.742355] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   21.742643] rcu: =09(detected by 0, t=3D21002 jiffies, g=3D-1039, q=3D8 =
ncpus=3D1)
[   21.742899] rcu: All QSes seen, last rcu_preempt kthread activity 21002 =
(4294688977-4294667975), jiffies_till_next_fqs=3D3, root ->qsmask 0x0
[   21.743358] rcu: rcu_preempt kthread starved for 21002 jiffies! g-1039 f=
0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
[   21.743738] rcu: =09Unless rcu_preempt kthread gets sufficient CPU time,=
 OOM is now expected behavior.
[   21.744074] rcu: RCU grace-period kthread stack dump:
[   21.744263] task:rcu_preempt     state:R  running task     stack:15544 p=
id:15    tgid:15    ppid:2      flags:0x00004000
[   21.744677] Call Trace:
[   21.744778]  <TASK>
[   21.744866]  __schedule+0x309/0x890
[   21.745018]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   21.745194]  schedule+0x2b/0xe0
[   21.745323]  schedule_timeout+0x86/0x160
[   21.745466]  ? __pfx_process_timeout+0x10/0x10
[   21.745626]  rcu_gp_fqs_loop+0x113/0x670
[   21.745767]  rcu_gp_kthread+0x19b/0x240
[   21.745904]  kthread+0xd2/0x100
[   21.746019]  ? __pfx_kthread+0x10/0x10
[   21.746153]  ret_from_fork+0x2f/0x50
[   21.746283]  ? __pfx_kthread+0x10/0x10
[   21.746416]  ret_from_fork_asm+0x1a/0x30
[   21.746559]  </TASK>
[   21.746640] rcu: Stack dump where RCU GP kthread last ran:
[   21.746833] CPU: 0 PID: 56 Comm: exploit Not tainted 6.9.4 #1
[   21.747035] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.14.0-2 04/01/2014
[   21.747335] RIP: 0010:___bpf_prog_run+0x29/0x20a0
[   21.747524] Code: 90 41 55 41 54 45 31 e4 55 48 89 fd 53 48 89 f3 0f b6 =
33 40 0f b6 d6 89 f0 48 8b 14 d5 00 7f 41 a0 e9 eb e9 da 00 f3 0f 1e fa <f3=
> 0f 1e fa 8b 53 04 83 fa 51 0f 84 07 1f 00 00 0f 8f 62 16 00 00
[   21.748243] RSP: 0018:ffff9252801bfa68 EFLAGS: 00000213
[   21.748450] RAX: 00000000000000c3 RBX: ffff9252800350b0 RCX: 00000000fff=
fff8d
[   21.748732] RDX: ffffffff9edd48d9 RSI: 00000000000000c3 RDI: ffff9252801=
bfa90
[   21.749012] RBP: ffff9252801bfa90 R08: ffff8dc381261e00 R09: ffff8dc3812=
61e00
[   21.749292] R10: ffff8dc381bbe000 R11: ffff8dc3811f0000 R12: 00000000000=
00000
[   21.749572] R13: 0000000000000001 R14: ffff8dc381bbe400 R15: 00000000000=
00001
[   21.749854] FS:  00007fb818a03680(0000) GS:ffff8dc3fd800000(0000) knlGS:=
0000000000000000
[   21.750170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.750397] CR2: 0000564d89dca2a8 CR3: 0000000001bbc000 CR4: 00000000000=
006f0
[   21.750678] Call Trace:
[   21.750779]  <IRQ>
[   21.750864]  ? rcu_check_gp_kthread_starvation+0x108/0x1a0
[   21.751082]  ? rcu_sched_clock_irq+0xc47/0xf50
[   21.751260]  ? timekeeping_update+0xab/0x280
[   21.751433]  ? timekeeping_advance+0x372/0x590
[   21.751612]  ? update_process_times+0x68/0xa0
[   21.751786]  ? tick_nohz_handler+0x110/0x190
[   21.751958]  ? __pfx_tick_nohz_handler+0x10/0x10
[   21.752143]  ? __hrtimer_run_queues+0x10d/0x2a0
[   21.752324]  ? hrtimer_interrupt+0xfe/0x240
[   21.752491]  ? __sysvec_apic_timer_interrupt+0x53/0x140
[   21.752702]  ? sysvec_apic_timer_interrupt+0x6b/0x80
[   21.752901]  </IRQ>
[   21.752989]  <TASK>
[   21.753077]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   21.753287]  ? ___bpf_prog_run+0x29/0x20a0
[   21.753451]  ? ___bpf_prog_run+0x29/0x20a0
[   21.753614]  ? ___bpf_prog_run+0x29/0x20a0
[   21.753778]  __bpf_prog_run448+0x46/0x70
[   21.753936]  ? place_entity+0x14/0xf0
[   21.754085]  ? __alloc_pages+0x1bb/0x1020
[   21.754247]  ? kmem_cache_alloc_node+0x45/0x260
[   21.754429]  ? wakeup_preempt+0x5c/0x70
[   21.754583]  ? kmalloc_reserve+0x89/0xe0
[   21.754741]  ? kmalloc_reserve+0x89/0xe0
[   21.754898]  ? __alloc_skb+0xd7/0x1a0
[   21.755046]  ? security_sock_rcv_skb+0x29/0x40
[   21.755225]  sk_filter_trim_cap+0xaf/0x200
[   21.755389]  ? skb_copy_datagram_from_iter+0x59/0x1e0
[   21.755590]  unix_dgram_sendmsg+0x392/0xba0
[   21.755759]  ? remove_wait_queue+0x11/0x50
[   21.755923]  sock_write_iter+0x18f/0x1a0
[   21.756081]  vfs_write+0x37e/0x430
[   21.756222]  ksys_write+0xaa/0xe0
[   21.756354]  do_syscall_64+0xa8/0x1b0
[   21.756502]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   21.756706] RIP: 0033:0x7fb81891c4e0
[   21.756851] Code: 69 0d 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e =
0f 1f 84 00 00 00 00 00 80 3d 89 ee 0d 00 00 74 17 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[   21.757571] RSP: 002b:00007ffd045da728 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[   21.757867] RAX: ffffffffffffffda RBX: 00007ffd045da978 RCX: 00007fb8189=
1c4e0
[   21.758147] RDX: 0000000000000001 RSI: 00007ffd045da73f RDI: 00000000000=
00005
[   21.758427] RBP: 00007ffd045da860 R08: 000000000000ee08 R09: 00000000000=
00001
[   21.758706] R10: 00007fb818828278 R11: 0000000000000202 R12: 00000000000=
00000
[   21.758986] R13: 00007ffd045da988 R14: 00007fb818a3c000 R15: 0000564d751=
88dd8
[   21.759266]  </TASK>


Apologies if this is not a relevant bug that needs fixing, and any mistakes=
 in etiquette. Please let me know any additional information needed.

Thanks
--b1_l5spU0ArODDJkB6IIQetIcvPWB4Tp0dHQE6DLk2VKZQ
Content-Type: application/x-xz; name=repro.tar.xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=repro.tar.xz

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

--b1_l5spU0ArODDJkB6IIQetIcvPWB4Tp0dHQE6DLk2VKZQ--


