Return-Path: <bpf+bounces-7698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1677B5B2
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 11:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A0228111F
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36465AD2E;
	Mon, 14 Aug 2023 09:43:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE4A94A
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 09:43:12 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3ACC;
	Mon, 14 Aug 2023 02:42:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso61528721fa.0;
        Mon, 14 Aug 2023 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692006171; x=1692610971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KXeIIn2GLsCrpTgIKxIbO7yVw+s4ZyhwEBpgM51yTA=;
        b=swF/YS7XIvCz1PG4AkrNeRa+bsrNxhNWPuAvrIUxDF94J5taZxs3ERhQh6SQq8nzsX
         2GxkNF1tJjTnRDBWCxzDjNGmX4k/ecNEezN86YecMoWnrWvZF27Zt+Co/XjUTfYk20hE
         O6D90eCkw5rIBsBIPL4/zFS5qp9pOOIfc9Q+aI311hHpnxQOBcnp0SeUUfoGzHmfOdDi
         usiJy7Cu9mtH7VvEn8nPlt81hQsEkDInvNBgXSnpse/HsuPTYSP0Hs9WyBmqEFJBf0XM
         TQPN2Sdkr69RSVXc72lYyeIEzB2J/JTJ9RMOStGRqjviC9TY1Dwzx++V0A7/ljK+gDzP
         L1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692006171; x=1692610971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KXeIIn2GLsCrpTgIKxIbO7yVw+s4ZyhwEBpgM51yTA=;
        b=K3TXWrfdalAcA9r1F8DrxezKyyGoNcsGY6iLMKXo42+4J9ZN6ko2n15dpqA+avwm9u
         u8nE3Fd+Lixo2MKpliIUlLScPRczWycbxnPRC35k1ZjKVQI+T0Skn1Czexsq5UTEz1K+
         mXVtPClKLeDaLWVvQwc22dM4T01q4makA82pf1OE+M4z3BLOdKXyO7Quak3UHiuqhFWt
         fRllNr6lmkv7BOjGzQ/iKyH72R5/umAOWojH8eb+b6bdpaRRh+fq0FnebRWmHQSU1t88
         3H0HJvCZsuSjfr1srPVzAP76R9Th8zSpmKT2JMqEmWjjXJLVFBfy/s81q6O52pFZ9U+o
         tyIg==
X-Gm-Message-State: AOJu0YwyRYMbCYPMPmmtZ1yABHxd2S1guHv2ls1wncTYRYswUyaeUlw2
	gS/bqsdV6Utqx0hgZOb9z7gYrDqrTX73SqttReE=
X-Google-Smtp-Source: AGHT+IE9lzzYaCD4D2c9AitpyXOyXv4IMxxWotRFKFV+My9qMJxDq8bzE448EoEqwTXV+NRSqOqCldu3nKN39qbdhc8=
X-Received: by 2002:a2e:3818:0:b0:2b9:ecab:d921 with SMTP id
 f24-20020a2e3818000000b002b9ecabd921mr6087576lja.18.1692006170540; Mon, 14
 Aug 2023 02:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720154941.1504-1-puranjay12@gmail.com> <87pm3qt2c8.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87pm3qt2c8.fsf@all.your.base.are.belong.to.us>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 14 Aug 2023 11:42:39 +0200
Message-ID: <CANk7y0jFHE7kX4LegSdoRrkLfWLwE0iawsAt6ktCniYCGbLdiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: use BPF prog pack allocator in
 BPF JIT
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	pulehui@huawei.com, conor.dooley@microchip.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bj=C3=B6rn,

On Mon, Aug 14, 2023 at 11:12=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> Puranjay Mohan <puranjay12@gmail.com> writes:
>
> > BPF programs currently consume a page each on RISCV. For systems with m=
any BPF
> > programs, this adds significant pressure to instruction TLB. High iTLB =
pressure
> > usually causes slow down for the whole system.
> >
> > Song Liu introduced the BPF prog pack allocator[1] to mitigate the abov=
e issue.
> > It packs multiple BPF programs into a single huge page. It is currently=
 only
> > enabled for the x86_64 BPF JIT.
> >
> > I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed =
now.
> >
> > This patch series enables the BPF prog pack allocator for the RISCV BPF=
 JIT.
> > This series needs a patch[3] from the ARM64 series to work.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > Performance Analysis of prog pack allocator on RISCV64
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > Test setup:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Host machine: Debian GNU/Linux 11 (bullseye)
> > Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
> > u-boot-qemu Version: 2023.07+dfsg-1
> > opensbi Version: 1.3-1
> >
> > To test the performance of the BPF prog pack allocator on RV, a stresse=
r
> > tool[4] linked below was built. This tool loads 8 BPF programs on the s=
ystem and
> > triggers 5 of them in an infinite loop by doing system calls.
> >
> > The runner script starts 20 instances of the above which loads 8*20=3D1=
60 BPF
> > programs on the system, 5*20=3D100 of which are being constantly trigge=
red.
> > The script is passed a command which would be run in the above environm=
ent.
> >
> > The script was run with following perf command:
> > ./run.sh "perf stat -a \
> >         -e iTLB-load-misses \
> >         -e dTLB-load-misses  \
> >         -e dTLB-store-misses \
> >         -e instructions \
> >         --timeout 60000"
> >
> > The output of the above command is discussed below before and after ena=
bling the
> > BPF prog pack allocator.
> >
> > The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The =
rootfs
> > was created using Bjorn's riscv-cross-builder[5] docker container linke=
d below.
> >
> > Results
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > Before enabling prog pack allocator:
> > ------------------------------------
> >
> > Performance counter stats for 'system wide':
> >
> >            4939048      iTLB-load-misses
> >            5468689      dTLB-load-misses
> >             465234      dTLB-store-misses
> >      1441082097998      instructions
> >
> >       60.045791200 seconds time elapsed
> >
> > After enabling prog pack allocator:
> > -----------------------------------
> >
> > Performance counter stats for 'system wide':
> >
> >            3430035      iTLB-load-misses
> >            5008745      dTLB-load-misses
> >             409944      dTLB-store-misses
> >      1441535637988      instructions
> >
> >       60.046296600 seconds time elapsed
> >
> > Improvements in metrics
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > It was expected that the iTLB-load-misses would decrease as now a singl=
e huge
> > page is used to keep all the BPF programs compared to a single page for=
 each
> > program earlier.
> >
> > --------------------------------------------
> > The improvement in iTLB-load-misses: -30.5 %
> > --------------------------------------------
> >
> > I repeated this expriment more than 100 times in different setups and t=
he
> > improvement was always greater than 30%.
> >
> > This patch series is boot tested on the Starfive VisionFive 2 board[6].
> > The performance analysis was not done on the board because it doesn't
> > expose iTLB-load-misses, etc. The stresser program was run on the board=
 to test
> > the loading and unloading of BPF programs
> >
> > [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org=
/
> > [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gma=
il.com/
> > [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gma=
il.com/
> > [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
> > [5] https://github.com/bjoto/riscv-cross-builder
> > [6] https://www.starfivetech.com/en/site/boards
> >
> > Puranjay Mohan (2):
> >   riscv: Extend patch_text_nosync() for multiple pages
> >   bpf, riscv: use prog pack allocator in the BPF JIT
>
> I get a hang for "test_tag", but it's not directly related to your
> series, but rather "remote fence.i".

I was seeing some stalls like this even without my series but couldn't
debug them at that time.

>
>   | rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>   | rcu:        0-....: (1400 ticks this GP) idle=3Dd5e4/1/0x400000000000=
0000 softirq=3D5542/5542 fqs=3D1862
>   | rcu:        (detected by 1, t=3D5252 jiffies, g=3D10253, q=3D195 ncpu=
s=3D4)
>   | Task dump for CPU 0:
>   | task:kworker/0:5     state:R  running task     stack:0     pid:319   =
ppid:2      flags:0x00000008
>   | Workqueue: events bpf_prog_free_deferred
>   | Call Trace:
>   | [<ffffffff80cbc444>] __schedule+0x2d0/0x940
>   | watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [kworker/0:5:319]
>   | Modules linked in: nls_iso8859_1 drm fuse i2c_core drm_panel_orientat=
ion_quirks backlight dm_mod configfs ip_tables x_tables
>   | CPU: 0 PID: 319 Comm: kworker/0:5 Not tainted 6.5.0-rc5 #1
>   | Hardware name: riscv-virtio,qemu (DT)
>   | Workqueue: events bpf_prog_free_deferred
>   | epc : __sbi_rfence_v02_call.isra.0+0x74/0x11a
>   |  ra : __sbi_rfence_v02+0xda/0x1a4
>   | epc : ffffffff8000ab4c ra : ffffffff8000accc sp : ff20000001c9bbd0
>   |  gp : ffffffff82078c48 tp : ff600000888e6a40 t0 : ff20000001c9bd44
>   |  t1 : 0000000000000000 t2 : 0000000000000040 s0 : ff20000001c9bbf0
>   |  s1 : 0000000000000010 a0 : 0000000000000000 a1 : 0000000000000000
>   |  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
>   |  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000052464e43
>   |  s2 : 000000000000ffff s3 : 00000000ffffffff s4 : ffffffff81667528
>   |  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
>   |  s8 : 0000000000000001 s9 : 0000000000000003 s10: 0000000000000040
>   |  s11: ffffffff8207d240 t3 : 000000000000000f t4 : 000000000000002a
>   |  t5 : ff600000872df140 t6 : ffffffff81e26828
>   | status: 0000000200000120 badaddr: 0000000000000000 cause: 80000000000=
00005
>   | [<ffffffff8000ab4c>] __sbi_rfence_v02_call.isra.0+0x74/0x11a
>   | [<ffffffff8000accc>] __sbi_rfence_v02+0xda/0x1a4
>   | [<ffffffff8000a886>] sbi_remote_fence_i+0x1e/0x26
>   | [<ffffffff8000cee2>] flush_icache_all+0x1a/0x48
>   | [<ffffffff80007736>] patch_text_nosync+0x6c/0x8c
>   | [<ffffffff8000f0f8>] bpf_arch_text_invalidate+0x62/0xac
>   | [<ffffffff8016c538>] bpf_prog_pack_free+0x9c/0x1b2
>   | [<ffffffff8016c84a>] bpf_jit_binary_pack_free+0x20/0x4a
>   | [<ffffffff8000f198>] bpf_jit_free+0x56/0x9e
>   | [<ffffffff8016b43a>] bpf_prog_free_deferred+0x15a/0x182
>   | [<ffffffff800576c4>] process_one_work+0x1b6/0x3d6
>   | [<ffffffff80057d52>] worker_thread+0x84/0x378
>   | [<ffffffff8005fc2c>] kthread+0xe8/0x108
>   | [<ffffffff80003ffa>] ret_from_fork+0xe/0x20
>
> I'm digging into that now, and I would appreciate if you could run the
> test_tag on VF2 or similar (I'm missing that HW).

Sure, I will try to run this on the board.
I will rebase my series(+ the patch from arm64 series) on the latest
bpf-next tree and try to run it.
Let me know if I need to add:
+       select HAVE_EFFICIENT_UNALIGNED_ACCESS if MMU && 64BIT

>
> It seems like we're hitting a bug with this series, so let's try to
> figure out where the problems is, prior merging it.
>
>
> Bj=C3=B6rn


Thanks,
Puranjay

