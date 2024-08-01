Return-Path: <bpf+bounces-36240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA0945315
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 20:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2611C229F1
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649E6149005;
	Thu,  1 Aug 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxpgoM8/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82E144D00;
	Thu,  1 Aug 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538735; cv=none; b=r2LaUXMHnj44UV9atCwEpOK8zL86SBrGkybdtURi4uB0lPeX8NEnqyP8MoZr+NAEyRrB7hhIwR61XZZHdmHMnYcaJBUHqAtzdGm/bdFcO90GhCuqTwUql5T4O+vgkSLrQa6Pm4GOCexaRWroW4ssMGMKboYUWNK8ZIXYBO5f/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538735; c=relaxed/simple;
	bh=baL5DTrz3k9qWK+ddv8Sm+9voZdKymoaKU9wcBBLqrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWZRbz54Amjtwe7QCG/cy2NOg5KRkvOkD6hX6+O37CSvM7i1+70fJApkDNIf/W98oLkYZllsytQgUIVRvBSOjqIHrQlprTVHUlrubvA6JyLIqdiXhQKR6/wLLuM9XMQGqIBSl1EPe0wFfk+E/SA5LN9V8UU9HFSOb7itpgCafLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxpgoM8/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a1d48e0a5fso4336460a12.3;
        Thu, 01 Aug 2024 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722538733; x=1723143533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqStPHF5hjaEiOQKSUNDflKbwgZ9pyTjx0bLk1G+fGU=;
        b=RxpgoM8/F6IE3Tax1Betv+Qz3pI40WGHFbIrHGQWLDwmm9fimkm2TwpBKFtaUCbX25
         AYrGSTI7dXzcnER5o3xAjGir6ESkosYbthm2uPoafEAN+gD+XAvPuDrWPXZXlnjvJNuF
         n4F1rO+PkK/g+9ZzBfM9XDsMu4s0TnVpeRo3WJYHe+UfbQxUTzXBLY/8MgStwvn3e4ZO
         z7uIcj4ZGReHZu0I2ZZqWmcynrnqPm5kWaIueXtTzw/ZDs3or6wcET8nXyBqUlkVnuhg
         CtPmw4yeoITVAtzdC2M/1QQyaLJE+kHZTGg9QZEAm6VguGFXnYCCFSrc9wKlk1hOO0Yb
         sFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722538733; x=1723143533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqStPHF5hjaEiOQKSUNDflKbwgZ9pyTjx0bLk1G+fGU=;
        b=TXOgpD5pcmooKOBgR0oLaXEqrWU9KxPwmzllLQiUZR5kkuVAyg4NSIgT6s4usdqw6H
         NIEfYJDjqCKFQcgpLWxJ1ohkbkuaB/WMwKYlOmB6hOA/H37ZeryLIZRIf0/73L1/U4w2
         +CD7rjOVUXLExhTASn7G1ACbpapiZ57vA60Jw7/dEublgV0BfkdsSyrJX96bjbVI5BhL
         gKXlGxBYCslnb4JbqT39T855AswtgK0pxmDIkEIwpQ2eNm3O0DLT9dULHUSnoUBycMwO
         zLdHyR7nyuDTmKMoKiKdGdXNMW4ROx2vYlep/8G2HDBaMkmiB50L+On/k0RIhECHdQw4
         8dhA==
X-Forwarded-Encrypted: i=1; AJvYcCWTz33tMqH2tE7W21o6JXgfUrV/LbuE7sp4TOawE7oY3Z5gDu44+Tbb2BV9V2f+C87V2XXNJia/K98Daqz7fPkMINO87qaDQuydVBSkQB5FeoJtlAxTAXSmbmV5xnOGJ5Jx7YaqfcOhhdJK5Bcb9DCOslZOab4Q9+7IePsOi5j3yZ8AOEfu
X-Gm-Message-State: AOJu0YyNfS/iULHahgy5CG/Gn7WGRmo+C+DCPSYaknS9VndU3XzT/FQP
	JDBnu94gQdFzgWPHOpJNW+GEIe0AFw0snykr8E6p9urrCeRL9wC+er6FRbd9yBc3MrGeb2JbNiC
	nxU80UnmWLfVmIrFxXRxVnEUsYHY=
X-Google-Smtp-Source: AGHT+IFigbBC5X8IUq4T7wRUsc9iqI3rHAzrMiZJ0QyaasUutRIDTfZcCMU6fGz1CpJRTUDEhekD0BREfg1/P2dCHis=
X-Received: by 2002:a05:6a21:c91:b0:1c4:17e1:14df with SMTP id
 adf61e73a8af0-1c6996288dbmr1086081637.48.1722538732506; Thu, 01 Aug 2024
 11:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801132638.GA8759@redhat.com> <20240801133617.GA39708@noisy.programming.kicks-ass.net>
In-Reply-To: <20240801133617.GA39708@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Aug 2024 11:58:40 -0700
Message-ID: <CAEf4BzY-gNWHhjnSh3myb0sStjm0Qjsu6nhFtXEULLvo_E=i5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ bpf

On Thu, Aug 1, 2024 at 6:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Aug 01, 2024 at 03:26:38PM +0200, Oleg Nesterov wrote:
> > (Andrii, I'll try to look at your new series on Weekend).
>
> OK, I dropped all your previous patches and stuffed these in.
>
> They should all be visible in queue/perf/core, and provided the robot
> doesn't scream, I'll push them into tip/perf/core soonish.

Just FYI, it seems like tip/perf/core is currently broken for uprobes
(and by implication also queue/perf/core). Also torvalds/linux/master
master is broken. See what I'm getting when running BPF selftests
dealing with uprobes. Sometimes I only get that WARNING and nothing
else.

I'm bisecting at the moment with bpf/master being a "good" checkpoint,
will let you know once I bisect.

[   34.343557] ------------[ cut here ]------------
[   34.343906] WARNING: CPU: 3 PID: 2364 at
kernel/trace/trace_uprobe.c:1109 __probe_event_disable+0x26/0x80
[   34.344468] Modules linked in:
[   34.344488] BUG: unable to handle page fault for address: ffffc90001c5be=
a0
[   34.345071] #PF: supervisor read access in kernel mode
[   34.345370] #PF: error_code(0x0000) - not-present page
[   34.345700] PGD 100000067 P4D 100000067 PUD ffff88810d86cd40
[   34.346061] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[   34.346377] CPU: 3 UID: 0 PID: 2364 Comm: test_progs Tainted: G
      OE      6.11.0-rc1-00006-g6763ebdb4983 #115
[   34.347052] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[   34.347392] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04
[   34.348085] RIP: 0010:__wake_up_common+0x3e/0xc0
[   34.348359] Code: 89 d4 55 53 48 89 fb 48 83 ec 08 8b 05 c3 05 a8
02 89 74 24 04 85 c0 75 6d 48 8b 43 48 48 83 c3 48 4f
[   34.349440] RSP: 0018:ffffc900001d0d90 EFLAGS: 00010087
[   34.349796] RAX: ffffc90001c5bea0 RBX: ffff88810138e0e8 RCX: 00000000000=
00001
[   34.350282] RDX: 0000000080010005 RSI: ffffffff8295f82c RDI: ffffc90001c=
5be88
[   34.350768] RBP: ffff88810138e0a0 R08: 0000000000000000 R09: 00000000000=
0438f
[   34.351245] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000000=
00001
[   34.351703] R13: 0000000000000046 R14: 0000000000000000 R15: 00000000000=
00000
[   34.352112] FS:  00007fd71c7b3d00(0000) GS:ffff88881ca00000(0000)
knlGS:0000000000000000
[   34.352574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.352911] CR2: ffffc90001c5bea0 CR3: 000000010b456005 CR4: 00000000003=
70ef0
[   34.353320] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   34.353734] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   34.354144] Call Trace:
[   34.354290]  <IRQ>
[   34.354413]  ? __die+0x1f/0x60
[   34.354601]  ? page_fault_oops+0x14c/0x450
[   34.354848]  ? search_bpf_extables+0xa8/0x150
[   34.355105]  ? fixup_exception+0x22/0x2d0
[   34.355342]  ? exc_page_fault+0x207/0x210
[   34.355579]  ? asm_exc_page_fault+0x22/0x30
[   34.355829]  ? __wake_up_common+0x3e/0xc0
[   34.356065]  __wake_up+0x32/0x60
[   34.356261]  ep_poll_callback+0x13e/0x270
[   34.356502]  __wake_up_common+0x7d/0xc0
[   34.356731]  __wake_up+0x32/0x60
[   34.356961]  irq_work_single+0x67/0x90
[   34.357184]  irq_work_run_list+0x26/0x40
[   34.357442]  update_process_times+0x83/0xa0
[   34.357717]  tick_nohz_handler+0x97/0x140
[   34.357977]  ? __pfx_tick_nohz_handler+0x10/0x10
[   34.358283]  __hrtimer_run_queues+0x19a/0x3b0
[   34.358580]  hrtimer_interrupt+0xfe/0x240
[   34.358864]  __sysvec_apic_timer_interrupt+0x87/0x210
[   34.359189]  sysvec_apic_timer_interrupt+0x98/0xc0
[   34.359487]  </IRQ>
[   34.359614]  <TASK>
[   34.359745]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   34.360042] RIP: 0010:print_modules+0x27/0xd0
[   34.360301] Code: 90 90 90 0f 1f 44 00 00 53 48 c7 c7 63 22 98 82
48 83 ec 18 e8 da 8d fc ff bf 01 00 00 00 e8 80 d1 f1
[   34.361372] RSP: 0018:ffffc90001e5bc58 EFLAGS: 00000297
[   34.361682] RAX: ffffffffa03f0948 RBX: 0000000000000000 RCX: 00000000000=
00000
[   34.362091] RDX: 0000000000000002 RSI: 0000000000000027 RDI: 00000000000=
00001
[   34.362502] RBP: ffffc90001e5bd28 R08: 00000000fffeffff R09: 00000000000=
00001
[   34.362917] R10: 0000000000000000 R11: ffffffff83299920 R12: ffffffff812=
33536
[   34.363325] R13: 0000000000000009 R14: 0000000000000455 R15: ffffffff829=
8f924
[   34.363740]  ? __probe_event_disable+0x26/0x80
[   34.364009]  ? print_modules+0x20/0xd0
[   34.364230]  ? __probe_event_disable+0x26/0x80
[   34.364488]  __warn+0x6f/0x180
[   34.364683]  ? __probe_event_disable+0x26/0x80
[   34.364945]  report_bug+0x18d/0x1c0
[   34.365156]  handle_bug+0x3a/0x70
[   34.365354]  exc_invalid_op+0x13/0x60
[   34.365571]  asm_exc_invalid_op+0x16/0x20
[   34.365838] RIP: 0010:__probe_event_disable+0x26/0x80
[   34.366175] Code: 90 90 90 90 55 48 89 fd 53 48 8b 47 10 8b 90 38
01 00 00 85 d2 75 13 48 8b 88 40 01 00 00 48 8d 90 40
[   34.367340] RSP: 0018:ffffc90001e5bdd0 EFLAGS: 00010287
[   34.367651] RAX: ffff88810d86cc00 RBX: ffff88810d86cce0 RCX: ffff8881075=
c8168
[   34.368067] RDX: ffff88810d86cd40 RSI: 0000000000000003 RDI: ffff88810a5=
e1db0
[   34.368482] RBP: ffff88810a5e1db0 R08: 00000000ffffffff R09: 00000000000=
00000
[   34.368896] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8881075=
c8250
[   34.369310] R13: ffff8881075c82f0 R14: ffffc90001e5bb80 R15: ffff8881075=
c8000
[   34.369775]  trace_uprobe_register+0x1a8/0x300
[   34.370053]  perf_trace_event_unreg.isra.0+0x22/0x80
[   34.370342]  perf_uprobe_destroy+0x3a/0x70
[   34.370582]  _free_event+0x114/0x580
[   34.370806]  perf_event_release_kernel+0x282/0x2c0
[   34.371123]  perf_release+0x11/0x20
[   34.371354]  __fput+0x102/0x2e0
[   34.371561]  task_work_run+0x55/0xa0
[   34.371798]  syscall_exit_to_user_mode+0x1dd/0x1f0
[   34.372104]  do_syscall_64+0x70/0x140
[   34.372337]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   34.372659] RIP: 0033:0x7fd71c986a94
[   34.372901] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84
00 00 00 00 00 90 f3 0f 1e fa 80 3d d5 18 0e 00 00 73
[   34.373987] RSP: 002b:00007ffc09d83118 EFLAGS: 00000202 ORIG_RAX:
0000000000000003
[   34.374426] RAX: 0000000000000000 RBX: 00007ffc09d835e8 RCX: 00007fd71c9=
86a94
[   34.374874] RDX: 000000000000000b RSI: 0000000000002401 RDI: 00000000000=
0000c
[   34.375325] RBP: 00007ffc09d83150 R08: 00000000049d39c7 R09: 00000000000=
00007
[   34.375782] R10: 00000000049d71b0 R11: 0000000000000202 R12: 00000000000=
00000
[   34.376245] R13: 00007ffc09d83608 R14: 00007fd71cae3000 R15: 00000000010=
3cd90
[   34.376661]  </TASK>
[   34.376794] Modules linked in: bpf_testmod(OE) aesni_intel(E)
crypto_simd(E) cryptd(E) kvm_intel(E) i2c_piix4(E) i2c_s)
[   34.377900] CR2: ffffc90001c5bea0
[   34.378097] ---[ end trace 0000000000000000 ]---
[   34.378366] RIP: 0010:__wake_up_common+0x3e/0xc0
[   34.378637] Code: 89 d4 55 53 48 89 fb 48 83 ec 08 8b 05 c3 05 a8
02 89 74 24 04 85 c0 75 6d 48 8b 43 48 48 83 c3 48 4f
[   34.379703] RSP: 0018:ffffc900001d0d90 EFLAGS: 00010087
[   34.380004] RAX: ffffc90001c5bea0 RBX: ffff88810138e0e8 RCX: 00000000000=
00001
[   34.380414] RDX: 0000000080010005 RSI: ffffffff8295f82c RDI: ffffc90001c=
5be88
[   34.380827] RBP: ffff88810138e0a0 R08: 0000000000000000 R09: 00000000000=
0438f
[   34.381284] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000000=
00001
[   34.381736] R13: 0000000000000046 R14: 0000000000000000 R15: 00000000000=
00000
[   34.382198] FS:  00007fd71c7b3d00(0000) GS:ffff88881ca00000(0000)
knlGS:0000000000000000
[   34.382712] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.383082] CR2: ffffc90001c5bea0 CR3: 000000010b456005 CR4: 00000000003=
70ef0
[   34.383540] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   34.383991] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   34.384407] Kernel panic - not syncing: Fatal exception in interrupt
[   35.464708] Shutting down cpus with NMI
[   35.465244] Kernel Offset: disabled
[   35.465474] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

