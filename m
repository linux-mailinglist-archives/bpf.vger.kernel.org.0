Return-Path: <bpf+bounces-35782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB8393DC77
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391F6281420
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884E1D52B;
	Sat, 27 Jul 2024 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq1goRu4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2764D1B86FB;
	Sat, 27 Jul 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039549; cv=none; b=e1ATNFYrIKPgAfcoVXeS0VXbMRWjXWuuaafJc8q0aW6Hox+o6qJQ9Q0jI6lF7jZfbI7o8Ri7vTQVzXy/vpAjV45LEoVJYJO1DNtr5WbFfai7Sdt54PBhnuLl/SB1YEWjokVEqU2qX8l82OxKxTNQvUuqB1UC2GwxoMEejo0d3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039549; c=relaxed/simple;
	bh=GFYPnVrHhM4OE1bqfq/dj68i9/fH6/O7bh/VoqOSex0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bon+oZ/w3UBXAdrxu/jhEy4ZD6r5ndlVQBS3nWIzmPDaW3e6/w6geOIGZmABfht0YXgcCmTpXSUqX+jRuRvZvVHWEB3wRk/dk+y2LeQGwSJbNRsc/rKkgI/RZcF9E+bdXHGW5Ct+k1rk3RI90oZo1taVD8jr/3tadsZQvWASAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq1goRu4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso1085854a12.0;
        Fri, 26 Jul 2024 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722039547; x=1722644347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj2Wf3OXxK6U9MMCooZ9IWZGWY2QYi3PDZPz4u+vRRk=;
        b=Zq1goRu4ruPDRMFg80dQfj8BMTwJ3kpMit8LeMpWdiTvWBx4BM5S8Oo1fkQX1f3Bnb
         oM+eEM3B24/sIHoEWJOCWGFibHXPcZxIqpNVZuNQlWcw7ThtcJx+Ah5erPUda/y9HkVJ
         g+P58HwPTOyQ/bhm3ish8juIRI+seBntwiNqh0/51sP7dQPR0F562YyS2ky0E0HASWVu
         D7G75DzZUjMDWfeMf4lsmiboj4Nkj0p3CfFLqgadV1zlmfUKmvlwcCchrqtOmHX6nDB6
         kEhn7Z3AHPSbNL+A2trHqWjWbFdydso0cswtBldSg824SA7ZbN9VRKDnWe3XVEy3eJp5
         Tbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722039547; x=1722644347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj2Wf3OXxK6U9MMCooZ9IWZGWY2QYi3PDZPz4u+vRRk=;
        b=sUqQbVyj2bR7U8uHdzG8Kqv5C7a4NVJJIzrB0C5XQ5UZsoifjj9N+t2LJLABBbtX4T
         PFxb3DxFJUJClQ1E0s8EtrYthy1LvxFIhlyaijfGjAWzeYpqEKYr20xwTxGauNopCyM2
         pfFhGjHOUUTME0IX7qBTBbJF+paFYyN9LVvSwiuzv3Uf5Gdo3qRV+jI43QvX/XlWaGu0
         S0Nab3pKOkYwcAp1P06jaXcm1LCv0oxUFJGZi/YXFfqvXL9eANIpdCu1vAxP5NnyQZgM
         Sg1ouHTPDmh9/EoopaVGJT3DWNld+7z/pWrcN+BN7ahQaVAE+J6gxm55Sz9QJIhGVDAP
         OIDg==
X-Forwarded-Encrypted: i=1; AJvYcCUlhoRDBhCQDBt3tREnvOIF7r9EPgDo2wPS1OXauRUe79dswlK6mvAWhQZ2PLeUn4/feLlInDxvoQ0U6MUOxNUhHiQhSMT/ek28k5dMMOBorqNi5x0X2OUhg+yGGkbOFlJ46/x+Zr0lB4/yHu16+u/i5Dvh5x8qQLbzBxuPn+VZOyvYucVo
X-Gm-Message-State: AOJu0Yzp7GZWsi7PSL1td8G5oYzNRpuvFyNosiUAmD3M51MRC+xm0EYv
	InH+jRSQis5HASvRCVbTVtR3mYu9aZWhmTwkDgwA2JCKDjbYC1ATWNtq+A5CarJkk0JB42Hvhyo
	OaiWyI2ZrhDmhB2KGMKenY5onKb4=
X-Google-Smtp-Source: AGHT+IEV7Mbh4aorcuTx4/RHf/YKpTU2QZixYJ2cXsHqbPl7rre/DLSNQkdBESs/5wXd4zKEcps2V8Fm3JiZOe1NoGY=
X-Received: by 2002:a05:6a20:748c:b0:1bd:260e:be97 with SMTP id
 adf61e73a8af0-1c4a14fa4ffmr1358896637.53.1722039546587; Fri, 26 Jul 2024
 17:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>
 <20240715144536.GI14400@noisy.programming.kicks-ass.net> <CAEf4BzZuR883FEuKAXp3DY1iJcL+ST8eNq5ioq8oRpDyg0w8Kw@mail.gmail.com>
 <CAEf4BzY-r2EcQEVxA=kDUvx-wX3t0hsG+66=iKTS5ZaAJF4zjw@mail.gmail.com> <CAEf4BzZC4grdZGJR0GUUtShZ7vz4pDPq9mQjHwBpqcnwF-LhrA@mail.gmail.com>
In-Reply-To: <CAEf4BzZC4grdZGJR0GUUtShZ7vz4pDPq9mQjHwBpqcnwF-LhrA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 17:18:54 -0700
Message-ID: <CAEf4Bzbc_tZnjiEmP84zyCsHQkCyhP=MqjZPS81iwLZgxvq=LA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: oleg@redhat.com, mingo@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 11:42=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 15, 2024 at 11:10=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jul 15, 2024 at 10:10=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Jul 15, 2024 at 7:45=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > >
> > > > On Thu, Jul 11, 2024 at 09:57:44PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > > But then I also ran it on Linux built from perf/uprobes branch (t=
hese
> > > > > patches), and after a few seconds I see that there is no more
> > > > > attachment/detachment happening. Eventually I got splats, which y=
ou
> > > > > can see in [1]. I used `sudo ./uprobe-stress -a10 -t5 -m5 -f3` co=
mmand
> > > > > to run it inside my QEMU image.
> > > >
> > > > So them git voodoo incantations did work and I got it built. I'm ru=
nning
> > > > that exact same line above (minus the sudo, because test box only h=
as a
> > > > root account I think) on real hardware.
> > > >
> > > > I'm now ~100 periods in and wondering what 'eventually' means...
> > >
> > > So I was running in a qemu set up with 16 cores on top of bare metal'=
s
> > > 80 core CPU (Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz). I just tried
> > > it again, and I can reproduce it within first few periods:
> > >
> > > WORKING HARD!..
> > >
> > > PERIOD #1 STATS:
> > > FUNC CALLS               919632
> > > UPROBE HITS              706351
> > > URETPROBE HITS           641679
> > > ATTACHED LINKS              951
> > > ATTACHED UPROBES           2421
> > > ATTACHED URETPROBES        2343
> > > MMAP CALLS                33533
> > > FORKS CALLS                 241
> > >
> > > PERIOD #2 STATS:
> > > FUNC CALLS                11444
> > > UPROBE HITS               14320
> > > URETPROBE HITS             9896
> > > ATTACHED LINKS               26
> > > ATTACHED UPROBES             75
> > > ATTACHED URETPROBES          61
> > > MMAP CALLS                39093
> > > FORKS CALLS                  14
> > >
> > > PERIOD #3 STATS:
> > > FUNC CALLS                  230
> > > UPROBE HITS                 152
> > > URETPROBE HITS              145
> > > ATTACHED LINKS                2
> > > ATTACHED UPROBES              2
> > > ATTACHED URETPROBES           2
> > > MMAP CALLS                39121
> > > FORKS CALLS                   0
> > >
> > > PERIOD #4 STATS:
> > > FUNC CALLS                    0
> > > UPROBE HITS                   0
> > > URETPROBE HITS                0
> > > ATTACHED LINKS                0
> > > ATTACHED UPROBES              0
> > > ATTACHED URETPROBES           0
> > > MMAP CALLS                39010
> > > FORKS CALLS                   0
> > >
> > > You can see in the second period all the numbers drop and by period #=
4
> > > (which is about 20 seconds in) anything but mmap()ing stops. When I
> > > said "eventually" I meant about a minute tops, however long it takes
> > > to do soft lockup detection, 23 seconds this time.
> > >
> > > So it should be very fast.
> > >
> > > Note that I'm running with debug kernel configuration (see [0] for
> > > full kernel config), here are debug-related settings, in case that
> > > makes a difference:
> > >
> > > $ cat ~/linux-build/default/.config | rg -i debug | rg -v '^#'
> > > CONFIG_X86_DEBUGCTLMSR=3Dy
> > > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> > > CONFIG_BLK_DEBUG_FS=3Dy
> > > CONFIG_PNP_DEBUG_MESSAGES=3Dy
> > > CONFIG_AIC7XXX_DEBUG_MASK=3D0
> > > CONFIG_AIC79XX_DEBUG_MASK=3D0
> > > CONFIG_SCSI_MVSAS_DEBUG=3Dy
> > > CONFIG_DM_DEBUG=3Dy
> > > CONFIG_MLX4_DEBUG=3Dy
> > > CONFIG_USB_SERIAL_DEBUG=3Dm
> > > CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
> > > CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> > > CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=3Dy
> > > CONFIG_CIFS_DEBUG=3Dy
> > > CONFIG_DLM_DEBUG=3Dy
> > > CONFIG_DEBUG_BUGVERBOSE=3Dy
> > > CONFIG_DEBUG_KERNEL=3Dy
> > > CONFIG_DEBUG_INFO=3Dy
> > > CONFIG_DEBUG_INFO_DWARF4=3Dy
> > > CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> > > CONFIG_DEBUG_INFO_BTF=3Dy
> > > CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> > > CONFIG_DEBUG_FS=3Dy
> > > CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> > > CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> > > CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> > > CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> > > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> > > CONFIG_SCHED_DEBUG=3Dy
> > > CONFIG_DEBUG_PREEMPT=3Dy
> > > CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> > > CONFIG_DEBUG_RT_MUTEXES=3Dy
> > > CONFIG_DEBUG_SPINLOCK=3Dy
> > > CONFIG_DEBUG_MUTEXES=3Dy
> > > CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> > > CONFIG_DEBUG_RWSEMS=3Dy
> > > CONFIG_DEBUG_LOCK_ALLOC=3Dy
> > > CONFIG_DEBUG_LOCKDEP=3Dy
> > > CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> > > CONFIG_DEBUG_IRQFLAGS=3Dy
> > > CONFIG_X86_DEBUG_FPU=3Dy
> > > CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> > >
> > >   [0] https://gist.github.com/anakryiko/97a023a95b30fb0fe607ff743433e=
64b
> > >
> > > >
> > > > Also, this is a 2 socket, 10 core per socket, 2 threads per core
> > > > ivybridge thing, are those parameters sufficient?
> > >
> > > Should be, I guess? It might be VM vs bare metal differences, though.
> > > I'll try to run this on bare metal with more production-like kernel
> > > configuration to see if I can still trigger this. Will let you know
> > > the results when I get them.
> >
> > Ok, so I ran it on bare metal host with production config. I didn't
> > really bother to specify parameters (so just one thread for
> > everything, the default):
> >
> > # ./uprobe-stress
> > WORKING HARD!..
> >
> > PERIOD #1 STATS:
> > FUNC CALLS              2959843
> > UPROBE HITS             1001312
> > URETPROBE HITS                0
> > ATTACHED LINKS                6
> > ATTACHED UPROBES             28
> > ATTACHED URETPROBES           0
> > MMAP CALLS                 8143
> > FORKS CALLS                 301
> >
> > PERIOD #2 STATS:
> > FUNC CALLS                    0
> > UPROBE HITS              822826
> > URETPROBE HITS                0
> > ATTACHED LINKS                0
> > ATTACHED UPROBES              0
> > ATTACHED URETPROBES           0
> > MMAP CALLS                 8006
> > FORKS CALLS                 270
> >
> > PERIOD #3 STATS:
> > FUNC CALLS                    0
> > UPROBE HITS              889534
> > URETPROBE HITS                0
> > ATTACHED LINKS                0
> > ATTACHED UPROBES              0
> > ATTACHED URETPROBES           0
> > MMAP CALLS                 8004
> > FORKS CALLS                 288
> >
> > PERIOD #4 STATS:
> > FUNC CALLS                    0
> > UPROBE HITS              886506
> > URETPROBE HITS                0
> > ATTACHED LINKS                0
> > ATTACHED UPROBES              0
> > ATTACHED URETPROBES           0
> > MMAP CALLS                 8120
> > FORKS CALLS                 285
> >
> > PERIOD #5 STATS:
> > FUNC CALLS                    0
> > UPROBE HITS              804556
> > URETPROBE HITS                0
> > ATTACHED LINKS                0
> > ATTACHED UPROBES              0
> > ATTACHED URETPROBES           0
> > MMAP CALLS                 7131
> > FORKS CALLS                 263
> > ^C
> > EXITING...
> >
> > Message from syslogd@kerneltest003.10.atn6.facebook.com at Jul 15 11:06=
:33 ...
> >  kernel:[ 2194.334618] watchdog: BUG: soft lockup - CPU#71 stuck for
> > 48s! [uprobe-stress:69900]
> >
> > It was weird on the very first period (no uretprobes, small amount of
> > attachments). And sure enough (gmail will reformat below in the
> > garbage, so [0] has the splat with the original formatting).
> >
> >   [0] https://gist.github.com/anakryiko/3e3ddcccc5ea3ca70ce90b5491485fd=
c
> >
> > I also keep getting:
> >
> > Message from syslogd@kerneltest003.10.atn6.facebook.com at Jul 15 11:09=
:41 ...
> >  kernel:[ 2382.334088] watchdog: BUG: soft lockup - CPU#71 stuck for
> > 223s! [uprobe-stress:69900]
> >
> > so it's not just a temporary slowdown
> >
> >
> > [ 2166.893057] rcu: INFO: rcu_sched self-detected stall on CPU
> > [ 2166.904199] rcu:     71-....: (20999 ticks this GP)
> > idle=3D2c84/1/0x4000000000000000 softirq=3D30158/30158 fqs=3D8110
> > [ 2166.923810] rcu:              hardirqs   softirqs   csw/system
> > [ 2166.934939] rcu:      number:        0        183            0
> > [ 2166.946064] rcu:     cputime:       60          0        10438
> > =3D=3D> 10549(ms)
> > [ 2166.959969] rcu:     (t=3D21065 jiffies g=3D369217 q=3D207850 ncpus=
=3D80)
> > [ 2166.971619] CPU: 71 PID: 69900 Comm: uprobe-stress Tainted: G S
> >      E      6.10.0-rc7-00071-g9423ae8ef6ff #62
> > [ 2166.992275] Hardware name: Quanta Tioga Pass Single Side
> > 01-0032211004/Tioga Pass Single Side, BIOS F08_3A24 05/13/2020
> > [ 2167.013804] RIP: 0010:uprobe_notify_resume+0x622/0xe20
> > [ 2167.024064] Code: 8d 9d c0 00 00 00 48 89 df 4c 89 e6 e8 d7 f9 ff
> > ff 84 c0 0f 85 c6 06 00 00 48 89 5c 24 20 41 8b 6d 58 40 f6 c5 01 74
> > 23 f3 90 <eb> f2 83 7c 24 18 00 48 8b 44 24 10 0f 8e 71 01 00 00 bf 05
> > 00 00
> > [ 2167.061543] RSP: 0000:ffffc9004a49fe78 EFLAGS: 00000202
> > [ 2167.071973] RAX: 0000000000000000 RBX: ffff88a11d307fc0 RCX: ffff88a=
120752c40
> > [ 2167.086223] RDX: 00000000000042ec RSI: ffffc9004a49ff58 RDI: ffff88a=
11d307fc0
> > [ 2167.100472] RBP: 0000000000000003 R08: ffff88a12516e500 R09: ffff88a=
12516f208
> > [ 2167.114717] R10: 00000000004042ec R11: 000000000000000f R12: ffffc90=
04a49ff58
> > [ 2167.128967] R13: ffff88a11d307f00 R14: 00000000004042ec R15: ffff88a=
09042e000
> > [ 2167.143213] FS:  00007fd252000640(0000) GS:ffff88bfffbc0000(0000)
> > knlGS:0000000000000000
> > [ 2167.159368] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 2167.170843] CR2: 00007fd244000b60 CR3: 000000209090b001 CR4: 0000000=
0007706f0
> > [ 2167.185091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 2167.199340] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 2167.213586] PKRU: 55555554
> > [ 2167.218994] Call Trace:
> > [ 2167.223883]  <IRQ>
> > [ 2167.227905]  ? rcu_dump_cpu_stacks+0x77/0xd0
> > [ 2167.236433]  ? print_cpu_stall+0x150/0x2a0
> > [ 2167.244615]  ? rcu_sched_clock_irq+0x319/0x490
> > [ 2167.253487]  ? update_process_times+0x71/0xa0
> > [ 2167.262191]  ? tick_nohz_handler+0xc0/0x100
> > [ 2167.270544]  ? tick_setup_sched_timer+0x170/0x170
> > [ 2167.279937]  ? __hrtimer_run_queues+0xe3/0x250
> > [ 2167.288815]  ? hrtimer_interrupt+0xf0/0x390
> > [ 2167.297168]  ? __sysvec_apic_timer_interrupt+0x47/0x110
> > [ 2167.307602]  ? sysvec_apic_timer_interrupt+0x68/0x80
> > [ 2167.317519]  </IRQ>
> > [ 2167.321710]  <TASK>
> > [ 2167.325905]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [ 2167.336517]  ? uprobe_notify_resume+0x622/0xe20
> > [ 2167.345565]  ? uprobe_notify_resume+0x609/0xe20
> > [ 2167.354612]  ? __se_sys_futex+0xf3/0x180
> > [ 2167.362445]  ? arch_uprobe_exception_notify+0x29/0x40
> > [ 2167.372533]  ? notify_die+0x51/0xb0
> > [ 2167.379503]  irqentry_exit_to_user_mode+0x7f/0xd0
> > [ 2167.388896]  asm_exc_int3+0x35/0x40
> > [ 2167.395862] RIP: 0033:0x4042ec
> > [ 2167.401966] Code: fc 8b 45 fc 89 c7 e8 6f 07 00 00 83 c0 01 c9 c3
> > cc 48 89 e5 48 83 ec 10 89 7d fc 8b 45 fc 89 c7 e8 55 07 00 00 83 c0
> > 01 c9 c3 <cc> 48 89 e5 48 83 ec 10 89 7d fc 8b 45 fc 89 c7 e8 3b 07 00
> > 00 83
> > [ 2167.439439] RSP: 002b:00007fd251fff8a8 EFLAGS: 00000206
> > [ 2167.449874] RAX: 00000000004042ec RBX: 00007fd252000640 RCX: 0000000=
00000001c
> > [ 2167.464122] RDX: 0000000000000033 RSI: 0000000000000064 RDI: 0000000=
000000033
> > [ 2167.478368] RBP: 00007fd251fff8d0 R08: 00007fd2523fa234 R09: 00007fd=
2523fa280
> > [ 2167.492617] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd=
252000640
> > [ 2167.506866] R13: 0000000000000016 R14: 00007fd252289930 R15: 0000000=
000000000
> > [ 2167.521117]  </TASK>
>
> Peter,
>
> Did you manage to reproduce this?

Ping.

