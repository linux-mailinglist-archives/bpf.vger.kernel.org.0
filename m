Return-Path: <bpf+bounces-35114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5C937CB7
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D221C20BCD
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2D147C9E;
	Fri, 19 Jul 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P73MwVLD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FE14600C;
	Fri, 19 Jul 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414554; cv=none; b=DhB4h2V9C3Zqm7L1BouxCvuBFBoC8GqA+yTzLHwdyuW472UrE1eTgJ3Au+QOzRaCvK6hdH7HSPiT/994uwOdi+oLoRX/1gtrfMvv8PYjsgjhFfbyL4yWX1tWk0PHtvzW9f9euIy08VRzSdK8rmZcF8vAbk7Z2dUDDfT72Oojlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414554; c=relaxed/simple;
	bh=m/ac+9Yw82y4ztiI1mncP1Av5KAITHkdCydy+oBkt00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K86NN/XPO1sZE+fLmma+/Ml4mvjS0MljK/NWnsLYzLLC3Z82P74v5t4QJEo8Ws4/AVEGoL3Y+6X3pFxH3XuXpViKCn1wa6jFSGUuDjdnj+4629CyoYvoG9mmjf5+2DRVPgQU4ZWqUWb9vpaLQkjX5NtJOSoe6TlK7bRR5KL/Bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P73MwVLD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70b2a0542c2so1058920b3a.3;
        Fri, 19 Jul 2024 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721414552; x=1722019352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acMMqOosx8z5hC0y3ouFWfqvDio5p/n891XwmKrMAUI=;
        b=P73MwVLDuEANHIdX7Ol13aGyo2UOejvkb0XeogWfYVNK83oOMcmXMM581T9M7qvikV
         im8xIIfWQ3Vj3SHDVXfOl0Rz+1VLsSxGpf7LoDAyo0atSNG1BvKsbWjMJUwXoZdIzppJ
         bhqCzFrO6Zwp8BHwSYOffHStqm8aMMpUbizNEjchfqlnGGXKoaVGuZCUugIcIRTi+aN+
         MZNghWpUzc8wuMCaQOu7mEitAQm+1suG0X4n1zM6jj3Dkzu1eJNAbdGrKJSsj94QnNZ9
         4PIiJMIIy4BZ4nuj1bsKC1IZeyI7ZhlO/pU0PQBdUID29WL+spdosVObOX2QezHTCi22
         +HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414552; x=1722019352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acMMqOosx8z5hC0y3ouFWfqvDio5p/n891XwmKrMAUI=;
        b=PC0uGOYTL8cuLH9VSKnVr4gQ8lAko7X2foTu3W7uTDlb/khSQNxXrOM8vyFqA2ii+1
         PZRUGCOSarGt2DrlYatvHSPnBxj5qCWm3A6kQfJtvM6ejjMzltZYvgL6fbh6SrPLkWE2
         Ulw2UzeScBa35ZUScCplnJuUGZzpz3zBZ76B5oNbZI8DLrhP2osITf6Mems0zFohe0Pg
         lwvc8xudPlfHnFUjhIHAQZZzpNUIei7K2iEZi5T7Gbdz1siq0xBCnwwZZ6KN6DLNzlmk
         NO/jdPQrWJH0+g1W00JroNHmGIuxC1BkGhu59/GxEyyDcAmc2+zl4MdNLKB9lVVfaTLy
         AonA==
X-Forwarded-Encrypted: i=1; AJvYcCWfBoPN47JQrk1elok7FCWv2JgEe5DRCnPykzeeQJhfKpslVvA/GXLefnUbHZ5UqSD8gUa0x30Ldcb9mHpycw1t9lMmBE1Z3gEgWKQI4GBDse/JCUXyR/QiXbVjmh4ZCXcKu3FOtjVJ4EJ5JEQNZfT99hdmJ+dOCq3r8v9FfRvvRoBbVoxp
X-Gm-Message-State: AOJu0YyW5Y3wSkVYil3xBwNH+byiqpY+/FiZaRPKoG/CqRdQdyOo5Ye2
	q2cLFDv9wvfQd1JEub7rkztcZpRq30YaFHsB7ztSxgMP1e8/CTF9KJMRX0++cB//akud9WqcbNn
	E7/TB4t+yUmoAvx1RJBK7mF9zF1Q=
X-Google-Smtp-Source: AGHT+IFX4LDh1YKjGyp1JmaUu94rHq5Jedi8kdtFhHGXRXyw+jZaIrro6zflseIaASG6AayUAE4nhLfF4CuGbSlj6mA=
X-Received: by 2002:a05:6a00:b96:b0:70a:efd7:ad9b with SMTP id
 d2e1a72fcca58-70d084f3693mr1357835b3a.17.1721414552202; Fri, 19 Jul 2024
 11:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>
 <20240715144536.GI14400@noisy.programming.kicks-ass.net> <CAEf4BzZuR883FEuKAXp3DY1iJcL+ST8eNq5ioq8oRpDyg0w8Kw@mail.gmail.com>
 <CAEf4BzY-r2EcQEVxA=kDUvx-wX3t0hsG+66=iKTS5ZaAJF4zjw@mail.gmail.com>
In-Reply-To: <CAEf4BzY-r2EcQEVxA=kDUvx-wX3t0hsG+66=iKTS5ZaAJF4zjw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 11:42:20 -0700
Message-ID: <CAEf4BzZC4grdZGJR0GUUtShZ7vz4pDPq9mQjHwBpqcnwF-LhrA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: oleg@redhat.com, mingo@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 11:10=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 15, 2024 at 10:10=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jul 15, 2024 at 7:45=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Thu, Jul 11, 2024 at 09:57:44PM -0700, Andrii Nakryiko wrote:
> > >
> > > > But then I also ran it on Linux built from perf/uprobes branch (the=
se
> > > > patches), and after a few seconds I see that there is no more
> > > > attachment/detachment happening. Eventually I got splats, which you
> > > > can see in [1]. I used `sudo ./uprobe-stress -a10 -t5 -m5 -f3` comm=
and
> > > > to run it inside my QEMU image.
> > >
> > > So them git voodoo incantations did work and I got it built. I'm runn=
ing
> > > that exact same line above (minus the sudo, because test box only has=
 a
> > > root account I think) on real hardware.
> > >
> > > I'm now ~100 periods in and wondering what 'eventually' means...
> >
> > So I was running in a qemu set up with 16 cores on top of bare metal's
> > 80 core CPU (Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz). I just tried
> > it again, and I can reproduce it within first few periods:
> >
> > WORKING HARD!..
> >
> > PERIOD #1 STATS:
> > FUNC CALLS               919632
> > UPROBE HITS              706351
> > URETPROBE HITS           641679
> > ATTACHED LINKS              951
> > ATTACHED UPROBES           2421
> > ATTACHED URETPROBES        2343
> > MMAP CALLS                33533
> > FORKS CALLS                 241
> >
> > PERIOD #2 STATS:
> > FUNC CALLS                11444
> > UPROBE HITS               14320
> > URETPROBE HITS             9896
> > ATTACHED LINKS               26
> > ATTACHED UPROBES             75
> > ATTACHED URETPROBES          61
> > MMAP CALLS                39093
> > FORKS CALLS                  14
> >
> > PERIOD #3 STATS:
> > FUNC CALLS                  230
> > UPROBE HITS                 152
> > URETPROBE HITS              145
> > ATTACHED LINKS                2
> > ATTACHED UPROBES              2
> > ATTACHED URETPROBES           2
> > MMAP CALLS                39121
> > FORKS CALLS                   0
> >
> > PERIOD #4 STATS:
> > FUNC CALLS                    0
> > UPROBE HITS                   0
> > URETPROBE HITS                0
> > ATTACHED LINKS                0
> > ATTACHED UPROBES              0
> > ATTACHED URETPROBES           0
> > MMAP CALLS                39010
> > FORKS CALLS                   0
> >
> > You can see in the second period all the numbers drop and by period #4
> > (which is about 20 seconds in) anything but mmap()ing stops. When I
> > said "eventually" I meant about a minute tops, however long it takes
> > to do soft lockup detection, 23 seconds this time.
> >
> > So it should be very fast.
> >
> > Note that I'm running with debug kernel configuration (see [0] for
> > full kernel config), here are debug-related settings, in case that
> > makes a difference:
> >
> > $ cat ~/linux-build/default/.config | rg -i debug | rg -v '^#'
> > CONFIG_X86_DEBUGCTLMSR=3Dy
> > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> > CONFIG_BLK_DEBUG_FS=3Dy
> > CONFIG_PNP_DEBUG_MESSAGES=3Dy
> > CONFIG_AIC7XXX_DEBUG_MASK=3D0
> > CONFIG_AIC79XX_DEBUG_MASK=3D0
> > CONFIG_SCSI_MVSAS_DEBUG=3Dy
> > CONFIG_DM_DEBUG=3Dy
> > CONFIG_MLX4_DEBUG=3Dy
> > CONFIG_USB_SERIAL_DEBUG=3Dm
> > CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
> > CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> > CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=3Dy
> > CONFIG_CIFS_DEBUG=3Dy
> > CONFIG_DLM_DEBUG=3Dy
> > CONFIG_DEBUG_BUGVERBOSE=3Dy
> > CONFIG_DEBUG_KERNEL=3Dy
> > CONFIG_DEBUG_INFO=3Dy
> > CONFIG_DEBUG_INFO_DWARF4=3Dy
> > CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> > CONFIG_DEBUG_INFO_BTF=3Dy
> > CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> > CONFIG_DEBUG_FS=3Dy
> > CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> > CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> > CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> > CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> > CONFIG_SCHED_DEBUG=3Dy
> > CONFIG_DEBUG_PREEMPT=3Dy
> > CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> > CONFIG_DEBUG_RT_MUTEXES=3Dy
> > CONFIG_DEBUG_SPINLOCK=3Dy
> > CONFIG_DEBUG_MUTEXES=3Dy
> > CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> > CONFIG_DEBUG_RWSEMS=3Dy
> > CONFIG_DEBUG_LOCK_ALLOC=3Dy
> > CONFIG_DEBUG_LOCKDEP=3Dy
> > CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> > CONFIG_DEBUG_IRQFLAGS=3Dy
> > CONFIG_X86_DEBUG_FPU=3Dy
> > CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> >
> >   [0] https://gist.github.com/anakryiko/97a023a95b30fb0fe607ff743433e64=
b
> >
> > >
> > > Also, this is a 2 socket, 10 core per socket, 2 threads per core
> > > ivybridge thing, are those parameters sufficient?
> >
> > Should be, I guess? It might be VM vs bare metal differences, though.
> > I'll try to run this on bare metal with more production-like kernel
> > configuration to see if I can still trigger this. Will let you know
> > the results when I get them.
>
> Ok, so I ran it on bare metal host with production config. I didn't
> really bother to specify parameters (so just one thread for
> everything, the default):
>
> # ./uprobe-stress
> WORKING HARD!..
>
> PERIOD #1 STATS:
> FUNC CALLS              2959843
> UPROBE HITS             1001312
> URETPROBE HITS                0
> ATTACHED LINKS                6
> ATTACHED UPROBES             28
> ATTACHED URETPROBES           0
> MMAP CALLS                 8143
> FORKS CALLS                 301
>
> PERIOD #2 STATS:
> FUNC CALLS                    0
> UPROBE HITS              822826
> URETPROBE HITS                0
> ATTACHED LINKS                0
> ATTACHED UPROBES              0
> ATTACHED URETPROBES           0
> MMAP CALLS                 8006
> FORKS CALLS                 270
>
> PERIOD #3 STATS:
> FUNC CALLS                    0
> UPROBE HITS              889534
> URETPROBE HITS                0
> ATTACHED LINKS                0
> ATTACHED UPROBES              0
> ATTACHED URETPROBES           0
> MMAP CALLS                 8004
> FORKS CALLS                 288
>
> PERIOD #4 STATS:
> FUNC CALLS                    0
> UPROBE HITS              886506
> URETPROBE HITS                0
> ATTACHED LINKS                0
> ATTACHED UPROBES              0
> ATTACHED URETPROBES           0
> MMAP CALLS                 8120
> FORKS CALLS                 285
>
> PERIOD #5 STATS:
> FUNC CALLS                    0
> UPROBE HITS              804556
> URETPROBE HITS                0
> ATTACHED LINKS                0
> ATTACHED UPROBES              0
> ATTACHED URETPROBES           0
> MMAP CALLS                 7131
> FORKS CALLS                 263
> ^C
> EXITING...
>
> Message from syslogd@kerneltest003.10.atn6.facebook.com at Jul 15 11:06:3=
3 ...
>  kernel:[ 2194.334618] watchdog: BUG: soft lockup - CPU#71 stuck for
> 48s! [uprobe-stress:69900]
>
> It was weird on the very first period (no uretprobes, small amount of
> attachments). And sure enough (gmail will reformat below in the
> garbage, so [0] has the splat with the original formatting).
>
>   [0] https://gist.github.com/anakryiko/3e3ddcccc5ea3ca70ce90b5491485fdc
>
> I also keep getting:
>
> Message from syslogd@kerneltest003.10.atn6.facebook.com at Jul 15 11:09:4=
1 ...
>  kernel:[ 2382.334088] watchdog: BUG: soft lockup - CPU#71 stuck for
> 223s! [uprobe-stress:69900]
>
> so it's not just a temporary slowdown
>
>
> [ 2166.893057] rcu: INFO: rcu_sched self-detected stall on CPU
> [ 2166.904199] rcu:     71-....: (20999 ticks this GP)
> idle=3D2c84/1/0x4000000000000000 softirq=3D30158/30158 fqs=3D8110
> [ 2166.923810] rcu:              hardirqs   softirqs   csw/system
> [ 2166.934939] rcu:      number:        0        183            0
> [ 2166.946064] rcu:     cputime:       60          0        10438
> =3D=3D> 10549(ms)
> [ 2166.959969] rcu:     (t=3D21065 jiffies g=3D369217 q=3D207850 ncpus=3D=
80)
> [ 2166.971619] CPU: 71 PID: 69900 Comm: uprobe-stress Tainted: G S
>      E      6.10.0-rc7-00071-g9423ae8ef6ff #62
> [ 2166.992275] Hardware name: Quanta Tioga Pass Single Side
> 01-0032211004/Tioga Pass Single Side, BIOS F08_3A24 05/13/2020
> [ 2167.013804] RIP: 0010:uprobe_notify_resume+0x622/0xe20
> [ 2167.024064] Code: 8d 9d c0 00 00 00 48 89 df 4c 89 e6 e8 d7 f9 ff
> ff 84 c0 0f 85 c6 06 00 00 48 89 5c 24 20 41 8b 6d 58 40 f6 c5 01 74
> 23 f3 90 <eb> f2 83 7c 24 18 00 48 8b 44 24 10 0f 8e 71 01 00 00 bf 05
> 00 00
> [ 2167.061543] RSP: 0000:ffffc9004a49fe78 EFLAGS: 00000202
> [ 2167.071973] RAX: 0000000000000000 RBX: ffff88a11d307fc0 RCX: ffff88a12=
0752c40
> [ 2167.086223] RDX: 00000000000042ec RSI: ffffc9004a49ff58 RDI: ffff88a11=
d307fc0
> [ 2167.100472] RBP: 0000000000000003 R08: ffff88a12516e500 R09: ffff88a12=
516f208
> [ 2167.114717] R10: 00000000004042ec R11: 000000000000000f R12: ffffc9004=
a49ff58
> [ 2167.128967] R13: ffff88a11d307f00 R14: 00000000004042ec R15: ffff88a09=
042e000
> [ 2167.143213] FS:  00007fd252000640(0000) GS:ffff88bfffbc0000(0000)
> knlGS:0000000000000000
> [ 2167.159368] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2167.170843] CR2: 00007fd244000b60 CR3: 000000209090b001 CR4: 000000000=
07706f0
> [ 2167.185091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 2167.199340] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 2167.213586] PKRU: 55555554
> [ 2167.218994] Call Trace:
> [ 2167.223883]  <IRQ>
> [ 2167.227905]  ? rcu_dump_cpu_stacks+0x77/0xd0
> [ 2167.236433]  ? print_cpu_stall+0x150/0x2a0
> [ 2167.244615]  ? rcu_sched_clock_irq+0x319/0x490
> [ 2167.253487]  ? update_process_times+0x71/0xa0
> [ 2167.262191]  ? tick_nohz_handler+0xc0/0x100
> [ 2167.270544]  ? tick_setup_sched_timer+0x170/0x170
> [ 2167.279937]  ? __hrtimer_run_queues+0xe3/0x250
> [ 2167.288815]  ? hrtimer_interrupt+0xf0/0x390
> [ 2167.297168]  ? __sysvec_apic_timer_interrupt+0x47/0x110
> [ 2167.307602]  ? sysvec_apic_timer_interrupt+0x68/0x80
> [ 2167.317519]  </IRQ>
> [ 2167.321710]  <TASK>
> [ 2167.325905]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [ 2167.336517]  ? uprobe_notify_resume+0x622/0xe20
> [ 2167.345565]  ? uprobe_notify_resume+0x609/0xe20
> [ 2167.354612]  ? __se_sys_futex+0xf3/0x180
> [ 2167.362445]  ? arch_uprobe_exception_notify+0x29/0x40
> [ 2167.372533]  ? notify_die+0x51/0xb0
> [ 2167.379503]  irqentry_exit_to_user_mode+0x7f/0xd0
> [ 2167.388896]  asm_exc_int3+0x35/0x40
> [ 2167.395862] RIP: 0033:0x4042ec
> [ 2167.401966] Code: fc 8b 45 fc 89 c7 e8 6f 07 00 00 83 c0 01 c9 c3
> cc 48 89 e5 48 83 ec 10 89 7d fc 8b 45 fc 89 c7 e8 55 07 00 00 83 c0
> 01 c9 c3 <cc> 48 89 e5 48 83 ec 10 89 7d fc 8b 45 fc 89 c7 e8 3b 07 00
> 00 83
> [ 2167.439439] RSP: 002b:00007fd251fff8a8 EFLAGS: 00000206
> [ 2167.449874] RAX: 00000000004042ec RBX: 00007fd252000640 RCX: 000000000=
000001c
> [ 2167.464122] RDX: 0000000000000033 RSI: 0000000000000064 RDI: 000000000=
0000033
> [ 2167.478368] RBP: 00007fd251fff8d0 R08: 00007fd2523fa234 R09: 00007fd25=
23fa280
> [ 2167.492617] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd25=
2000640
> [ 2167.506866] R13: 0000000000000016 R14: 00007fd252289930 R15: 000000000=
0000000
> [ 2167.521117]  </TASK>

Peter,

Did you manage to reproduce this?

