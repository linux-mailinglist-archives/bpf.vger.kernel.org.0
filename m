Return-Path: <bpf+bounces-7699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B569677B5F4
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47867280E78
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C310FAD47;
	Mon, 14 Aug 2023 10:06:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE55AD26
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46B3C433CA;
	Mon, 14 Aug 2023 10:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692007616;
	bh=sN0iD6JNy5wZ570D2k8jyG1PR68JPva0DnKLTcI1C7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D3Dg80dtZZTq9erXMoT+6YtBIN3BZ57BZY6bA8WegqWx9oifPcLDD+AOSeBQICEB1
	 GuU1c+Edch0xl6HpVgqdKeFstHV68hvocCYdc/1IXZZKbqv6wT6HqEwToMLego7jYh
	 aiar1N0lxiNLkst7pDOhChM7PuPZCB1lOnbTav/b33UOeAvRBvEu+zEIbpswz0VQ53
	 KF7n6zKUsABYsll+o3nDrjaok1jBT7PQOwyrPVv/jW37gwn/2izByzAz5V+IDlG49A
	 arLYTX6ltPZCeyFPjNCGgwLjMW+FI9/OGJnd9nnTfHpjcngNikoTPKiBf6L8+34NyW
	 u5SACaaaPUMuw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 pulehui@huawei.com, conor.dooley@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: use BPF prog pack allocator in
 BPF JIT
In-Reply-To: <CANk7y0jFHE7kX4LegSdoRrkLfWLwE0iawsAt6ktCniYCGbLdiQ@mail.gmail.com>
References: <20230720154941.1504-1-puranjay12@gmail.com>
 <87pm3qt2c8.fsf@all.your.base.are.belong.to.us>
 <CANk7y0jFHE7kX4LegSdoRrkLfWLwE0iawsAt6ktCniYCGbLdiQ@mail.gmail.com>
Date: Mon, 14 Aug 2023 12:06:53 +0200
Message-ID: <871qg6gcoy.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

>> I get a hang for "test_tag", but it's not directly related to your
>> series, but rather "remote fence.i".
>
> I was seeing some stalls like this even without my series but couldn't
> debug them at that time.

Yeah, I think it's not related to your series -- it's just a good
reproducer. ;-)

>>
>>   | rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>   | rcu:        0-....: (1400 ticks this GP) idle=3Dd5e4/1/0x40000000000=
00000 softirq=3D5542/5542 fqs=3D1862
>>   | rcu:        (detected by 1, t=3D5252 jiffies, g=3D10253, q=3D195 ncp=
us=3D4)
>>   | Task dump for CPU 0:
>>   | task:kworker/0:5     state:R  running task     stack:0     pid:319  =
 ppid:2      flags:0x00000008
>>   | Workqueue: events bpf_prog_free_deferred
>>   | Call Trace:
>>   | [<ffffffff80cbc444>] __schedule+0x2d0/0x940
>>   | watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [kworker/0:5:319]
>>   | Modules linked in: nls_iso8859_1 drm fuse i2c_core drm_panel_orienta=
tion_quirks backlight dm_mod configfs ip_tables x_tables
>>   | CPU: 0 PID: 319 Comm: kworker/0:5 Not tainted 6.5.0-rc5 #1
>>   | Hardware name: riscv-virtio,qemu (DT)
>>   | Workqueue: events bpf_prog_free_deferred
>>   | epc : __sbi_rfence_v02_call.isra.0+0x74/0x11a
>>   |  ra : __sbi_rfence_v02+0xda/0x1a4
>>   | epc : ffffffff8000ab4c ra : ffffffff8000accc sp : ff20000001c9bbd0
>>   |  gp : ffffffff82078c48 tp : ff600000888e6a40 t0 : ff20000001c9bd44
>>   |  t1 : 0000000000000000 t2 : 0000000000000040 s0 : ff20000001c9bbf0
>>   |  s1 : 0000000000000010 a0 : 0000000000000000 a1 : 0000000000000000
>>   |  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
>>   |  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000052464e43
>>   |  s2 : 000000000000ffff s3 : 00000000ffffffff s4 : ffffffff81667528
>>   |  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
>>   |  s8 : 0000000000000001 s9 : 0000000000000003 s10: 0000000000000040
>>   |  s11: ffffffff8207d240 t3 : 000000000000000f t4 : 000000000000002a
>>   |  t5 : ff600000872df140 t6 : ffffffff81e26828
>>   | status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000=
000005
>>   | [<ffffffff8000ab4c>] __sbi_rfence_v02_call.isra.0+0x74/0x11a
>>   | [<ffffffff8000accc>] __sbi_rfence_v02+0xda/0x1a4
>>   | [<ffffffff8000a886>] sbi_remote_fence_i+0x1e/0x26
>>   | [<ffffffff8000cee2>] flush_icache_all+0x1a/0x48
>>   | [<ffffffff80007736>] patch_text_nosync+0x6c/0x8c
>>   | [<ffffffff8000f0f8>] bpf_arch_text_invalidate+0x62/0xac
>>   | [<ffffffff8016c538>] bpf_prog_pack_free+0x9c/0x1b2
>>   | [<ffffffff8016c84a>] bpf_jit_binary_pack_free+0x20/0x4a
>>   | [<ffffffff8000f198>] bpf_jit_free+0x56/0x9e
>>   | [<ffffffff8016b43a>] bpf_prog_free_deferred+0x15a/0x182
>>   | [<ffffffff800576c4>] process_one_work+0x1b6/0x3d6
>>   | [<ffffffff80057d52>] worker_thread+0x84/0x378
>>   | [<ffffffff8005fc2c>] kthread+0xe8/0x108
>>   | [<ffffffff80003ffa>] ret_from_fork+0xe/0x20
>>
>> I'm digging into that now, and I would appreciate if you could run the
>> test_tag on VF2 or similar (I'm missing that HW).
>
> Sure, I will try to run this on the board.
> I will rebase my series(+ the patch from arm64 series) on the latest
> bpf-next tree and try to run it.

Thank you!

> Let me know if I need to add:
> +       select HAVE_EFFICIENT_UNALIGNED_ACCESS if MMU && 64BIT

I usually run with that *on*, for better coverage.=20


Bj=C3=B6rn

