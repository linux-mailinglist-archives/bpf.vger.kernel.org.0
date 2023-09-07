Return-Path: <bpf+bounces-9404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3B797178
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 12:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE871C20AEE
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C75A568C;
	Thu,  7 Sep 2023 10:26:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98618566C;
	Thu,  7 Sep 2023 10:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CC0C116B5;
	Thu,  7 Sep 2023 10:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694082390;
	bh=Jf43CePeMB/IHVQj7NAnYc9eiEbnhyFThi5aBu2GxZQ=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=K6rspdVed2uda7EyL9F1SENUhK2bvhih44kuOULQ7utH9Q0xtoRZaRNJB9+dyc9Tv
	 ir1ONXzVGRQIsLVL5IYnwQl5zMLhJM5JSlfQgrsNLh6MVQuijX4OFVsBPIqdo40Kj+
	 lP1rY6k9be1J+Da6zT8ovdSy0lJYwKDih4zo6Nhpiz6DRicYkiH3qn1+GgE6hnqfC4
	 qTflWJAms1FgYOMNt06QFGF7u0U1HBU7OwIaRi3wyVuCVuvgwzh9ySMyw+00PZtZ7h
	 2stQaGZK0DeT/sN5d1GfmucfV/D1rMwg3oxM54cr3Y9gsGJCTcqq0zrMTpFMDcBVEH
	 dwAq98SbIfkAg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 47DCBDC67D3; Thu,  7 Sep 2023 12:26:27 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Hsin-Wei Hung <hsinweih@uci.edu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Subject: Re: Possible deadlock in bpf queue map
In-Reply-To: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
References: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 07 Sep 2023 12:26:27 +0200
Message-ID: <87o7ienuss.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+Arnaldo

> Hi,
>
> Our bpf fuzzer, a customized Syzkaller, triggered a lockdep warning in
> the bpf queue map in v5.15. Since queue_stack_maps.c has no major changes
> since v5.15, we think this should still exist in the latest kernel.
> The bug can be occasionally triggered, and we suspect one of the
> eBPF programs involved to be the following one. We also attached the lockdep
> warning at the end.
>
> #define DEFINE_BPF_MAP_NO_KEY(the_map, TypeOfMap, MapFlags,
> TypeOfValue, MaxEntries) \
>         struct {                                                        \
>             __uint(type, TypeOfMap);                                    \
>             __uint(map_flags, (MapFlags));                              \
>             __uint(max_entries, (MaxEntries));                          \
>             __type(value, TypeOfValue);                                 \
>         } the_map SEC(".maps");
>
> DEFINE_BPF_MAP_NO_KEY(map_0, BPF_MAP_TYPE_QUEUE, 0 | BPF_F_WRONLY,
> struct_0, 162);
> SEC("perf_event")
> int func(struct bpf_perf_event_data *ctx) {
>         char v0[96] = {};
>         uint64_t v1 = 0;
>         v1 = bpf_map_pop_elem(&map_0, v0);
>         return 163819661;
> }
>
>
> The program is attached to the following perf event.
>
> struct perf_event_attr attr_type_hw = {
>         .type = PERF_TYPE_HARDWARE,
>         .config = PERF_COUNT_HW_CPU_CYCLES,
>         .sample_freq = 50,
>         .inherit = 1,
>         .freq = 1,
> };
>
> ================================WARNING: inconsistent lock state
> 5.15.26+ #2 Not tainted
> --------------------------------
> inconsistent {INITIAL USE} -> {IN-NMI} usage.
> syz-executor.5/19749 [HC1[1]:SC0[0]:HE0:SE1] takes:
> ffff88804c9fc198 (&qs->lock){..-.}-{2:2}, at: __queue_map_get+0x31/0x250
> {INITIAL USE} state was registered at:
>   lock_acquire+0x1a3/0x4b0
>   _raw_spin_lock_irqsave+0x48/0x60
>   __queue_map_get+0x31/0x250
>   bpf_prog_577904e86c81dead_func+0x12/0x4b4
>   trace_call_bpf+0x262/0x5d0
>   perf_trace_run_bpf_submit+0x91/0x1c0
>   perf_trace_sched_switch+0x46c/0x700
>   __schedule+0x11b5/0x24a0
>   schedule+0xd4/0x270
>   futex_wait_queue_me+0x25f/0x520
>   futex_wait+0x1e0/0x5f0
>   do_futex+0x395/0x1890
>   __x64_sys_futex+0x1cb/0x480
>   do_syscall_64+0x3b/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> irq event stamp: 13640
> hardirqs last  enabled at (13639): [<ffffffff95eb2bf4>]
> _raw_spin_unlock_irq+0x24/0x40
> hardirqs last disabled at (13640): [<ffffffff95eb2d4d>]
> _raw_spin_lock_irqsave+0x5d/0x60
> softirqs last  enabled at (13464): [<ffffffff93e26de5>] __sys_bpf+0x3e15/0x4e80
> softirqs last disabled at (13462): [<ffffffff93e26da3>] __sys_bpf+0x3dd3/0x4e80
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&qs->lock);
>   <Interrupt>
>     lock(&qs->lock);

Hmm, so that lock() uses raw_spin_lock_irqsave(), which *should* be
disabling interrupts entirely for the critical section. But I guess a
Perf hardware event can still trigger? Which seems like it would
potentially wreak havoc with lots of things, not just this queue map
function?

No idea how to protect against this, though. Hoping Arnaldo knows? :)

-Toke

