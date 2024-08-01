Return-Path: <bpf+bounces-36241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB26945409
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 23:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A151F23B14
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 21:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C407414B091;
	Thu,  1 Aug 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCrf6xm4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B394914A603;
	Thu,  1 Aug 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546836; cv=none; b=mb1IMtz6NUTOWzq/blmDoHSnzqzt0U9iu7UDOkMOrHJ+X2OifkB5ZikfOfAMmP32C3BUWISwCNPuITsHVSQeFR4DVQleSTJeVZ6MXYzljvGIPyxsYycgjyNlkpRF+q7xk7Uu1DttLec3BT0RMOqv95qjNxeRz1SqgjNrbPMuzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546836; c=relaxed/simple;
	bh=DU4RlKQkBK6OQX6TRaBp/+ocs+y3ZIFHyTGCwCzzGC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jasEXfn2vzzJWLYNL14kVEvsctE0/AeAA+8Jn1F/FhvuJtN55N4KidEUGtnhllaa9w5pIdR74jVc2r7JYxfe4Di4mL8oEwZtwnWyBvy0G+XzAgHJczqHURJis2pO1PUsFz+m/kCnhTsbO/6xh2FG+nxFR3t3Wczd7s3EdDt4rrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCrf6xm4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so5554247a91.2;
        Thu, 01 Aug 2024 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722546834; x=1723151634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2mzL6HgEu+8ELSXHD2xoHdbGg0mSkcoMMIaZ6h5ag0=;
        b=dCrf6xm4C/cxiDskijYro8a9uiI9SIPVKr3lqDh5mV79QIBMK6R/PdNyXo/LmSBqTu
         gZq5ZxBZBNlXXmit4U1lO4Ti0/mcG5BRqE/M+COcbgjwAHiw1jDbLpn5pK2pQGRQrvC8
         XhbCMC+dk7UoZFPRNYbjlrDmOzillzt7JEJmtpimCo/Gr8vUgBpGPYJT0UWVityF2As+
         ivhpRpYm4sotcpRfSytY6EkcRKyH8Kbomn+spl0RQXi9Y1Snak9PYyb8cvb07e1bThf+
         LqltxbzVrixP7WqoBfDcuaVd3rUjG5+wgICjdVX5jMtzAPnej70IV2LJu1QLAeiptV4L
         4Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722546834; x=1723151634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2mzL6HgEu+8ELSXHD2xoHdbGg0mSkcoMMIaZ6h5ag0=;
        b=ScSc2YvwkTN5OqeRQgsWxwspwTtNJ5vArpAGSMR+aBA8zKJIR9weDgE3pmxjBrSaPF
         6RPYbQ3Z8RtYFmNJMKYNA6y4IqCfpYLg3ithvO4DNNXv8xGsFixxl3OTh8BvuQLCVF9Z
         bxGaA54pifdK4iCTX+fQLN0PLlNV2mVF4nnaLIUlZhglGUOYKQAJ9O7mUTCerzfz98eI
         IWwXCOrucN//qtpDNaMVnKWIjZlMSxgIwnM/dCOzypkMl0fPd/u+03+TlQTJyhLE5YjR
         ek7BeVOtJVJNkqHHURTYFzw+Z/9fhKDocvJsG100xVr7x4WkI7Xg8MhGtUN6c/VWg7PT
         Lqiw==
X-Forwarded-Encrypted: i=1; AJvYcCWKouuT56v7g3ePl1oWnCAmzPTO66BpT/y1rE/73O7e4G542UU1p1aw07CcgcJ5I7yi4ZRLvNW2ULBdDQk26HEgbk5qG1Q4gPTadEP4vTigqkO46uKvLwOL3p4t/MJJgGS5cG+1W8dmv5ucQwTpjbqOXzIduT5lepAjBvo/lXi3l7YpVFET
X-Gm-Message-State: AOJu0YwlXx418gNanKDVDOV8QosmnRZsSfyFz6fRiGnqPujDC/id07cb
	6l8NQv0G0Jh0SI/o1+NpRSdU7cjiJd9Wvvj0N1dppRLMselgYOnTGxbq7GNXKwH1JHFN1xzmCkq
	ZtXbVcdyyUp8kdAbs83TCR2eWYZGY9edo
X-Google-Smtp-Source: AGHT+IFr4/jV0QX4K5If4N7cVI/WgYk2+b6bfi1jd90SZZOhttRjDaZZxjB2U3QEXMkHoVymR3Rg7oYmOrypgd3wdc0=
X-Received: by 2002:a17:90b:3848:b0:2c9:75a4:cc71 with SMTP id
 98e67ed59e1d1-2cff952088emr1790013a91.32.1722546833663; Thu, 01 Aug 2024
 14:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801132638.GA8759@redhat.com> <20240801133617.GA39708@noisy.programming.kicks-ass.net>
 <CAEf4BzY-gNWHhjnSh3myb0sStjm0Qjsu6nhFtXEULLvo_E=i5w@mail.gmail.com>
In-Reply-To: <CAEf4BzY-gNWHhjnSh3myb0sStjm0Qjsu6nhFtXEULLvo_E=i5w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Aug 2024 14:13:41 -0700
Message-ID: <CAEf4BzY9diEi2_tHsLxB4Yk-ZAWHT=XJNmagjQtOXc7qShqgrA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
To: Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:58=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> + bpf
>
> On Thu, Aug 1, 2024 at 6:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Thu, Aug 01, 2024 at 03:26:38PM +0200, Oleg Nesterov wrote:
> > > (Andrii, I'll try to look at your new series on Weekend).
> >
> > OK, I dropped all your previous patches and stuffed these in.
> >
> > They should all be visible in queue/perf/core, and provided the robot
> > doesn't scream, I'll push them into tip/perf/core soonish.
>
> Just FYI, it seems like tip/perf/core is currently broken for uprobes
> (and by implication also queue/perf/core). Also torvalds/linux/master
> master is broken. See what I'm getting when running BPF selftests
> dealing with uprobes. Sometimes I only get that WARNING and nothing
> else.
>
> I'm bisecting at the moment with bpf/master being a "good" checkpoint,
> will let you know once I bisect.

Ok, this bisected to:

675ad74989c2 ("perf/core: Add aux_pause, aux_resume, aux_start_paused")

Reverting all (applied to tip/perf/core) four patches from that series:

6763ebdb4983 (tip/perf/core) perf/x86/intel: Do not enable large PEBS
for events with aux actions or aux sampling
6a45d8847597 perf/x86/intel/pt: Add support for pause / resume
675ad74989c2 perf/core: Add aux_pause, aux_resume, aux_start_paused
d92792a4b26e perf/x86/intel/pt: Fix sampling synchronization

... makes everything work again. I'll leave it up to you and Adrian to
figure this out.

>
> [   34.343557] ------------[ cut here ]------------
> [   34.343906] WARNING: CPU: 3 PID: 2364 at
> kernel/trace/trace_uprobe.c:1109 __probe_event_disable+0x26/0x80
> [   34.344468] Modules linked in:
> [   34.344488] BUG: unable to handle page fault for address: ffffc90001c5=
bea0
> [   34.345071] #PF: supervisor read access in kernel mode
> [   34.345370] #PF: error_code(0x0000) - not-present page
> [   34.345700] PGD 100000067 P4D 100000067 PUD ffff88810d86cd40
> [   34.346061] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   34.346377] CPU: 3 UID: 0 PID: 2364 Comm: test_progs Tainted: G
>       OE      6.11.0-rc1-00006-g6763ebdb4983 #115
> [   34.347052] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> [   34.347392] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04
> [   34.348085] RIP: 0010:__wake_up_common+0x3e/0xc0
> [   34.348359] Code: 89 d4 55 53 48 89 fb 48 83 ec 08 8b 05 c3 05 a8
> 02 89 74 24 04 85 c0 75 6d 48 8b 43 48 48 83 c3 48 4f
> [   34.349440] RSP: 0018:ffffc900001d0d90 EFLAGS: 00010087
> [   34.349796] RAX: ffffc90001c5bea0 RBX: ffff88810138e0e8 RCX: 000000000=
0000001
> [   34.350282] RDX: 0000000080010005 RSI: ffffffff8295f82c RDI: ffffc9000=
1c5be88
> [   34.350768] RBP: ffff88810138e0a0 R08: 0000000000000000 R09: 000000000=
000438f
> [   34.351245] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000=
0000001
> [   34.351703] R13: 0000000000000046 R14: 0000000000000000 R15: 000000000=
0000000
> [   34.352112] FS:  00007fd71c7b3d00(0000) GS:ffff88881ca00000(0000)
> knlGS:0000000000000000
> [   34.352574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   34.352911] CR2: ffffc90001c5bea0 CR3: 000000010b456005 CR4: 000000000=
0370ef0
> [   34.353320] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   34.353734] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   34.354144] Call Trace:
> [   34.354290]  <IRQ>
> [   34.354413]  ? __die+0x1f/0x60
> [   34.354601]  ? page_fault_oops+0x14c/0x450
> [   34.354848]  ? search_bpf_extables+0xa8/0x150
> [   34.355105]  ? fixup_exception+0x22/0x2d0
> [   34.355342]  ? exc_page_fault+0x207/0x210
> [   34.355579]  ? asm_exc_page_fault+0x22/0x30
> [   34.355829]  ? __wake_up_common+0x3e/0xc0
> [   34.356065]  __wake_up+0x32/0x60
> [   34.356261]  ep_poll_callback+0x13e/0x270
> [   34.356502]  __wake_up_common+0x7d/0xc0
> [   34.356731]  __wake_up+0x32/0x60
> [   34.356961]  irq_work_single+0x67/0x90
> [   34.357184]  irq_work_run_list+0x26/0x40
> [   34.357442]  update_process_times+0x83/0xa0
> [   34.357717]  tick_nohz_handler+0x97/0x140
> [   34.357977]  ? __pfx_tick_nohz_handler+0x10/0x10
> [   34.358283]  __hrtimer_run_queues+0x19a/0x3b0
> [   34.358580]  hrtimer_interrupt+0xfe/0x240
> [   34.358864]  __sysvec_apic_timer_interrupt+0x87/0x210
> [   34.359189]  sysvec_apic_timer_interrupt+0x98/0xc0
> [   34.359487]  </IRQ>
> [   34.359614]  <TASK>
> [   34.359745]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> [   34.360042] RIP: 0010:print_modules+0x27/0xd0
> [   34.360301] Code: 90 90 90 0f 1f 44 00 00 53 48 c7 c7 63 22 98 82
> 48 83 ec 18 e8 da 8d fc ff bf 01 00 00 00 e8 80 d1 f1
> [   34.361372] RSP: 0018:ffffc90001e5bc58 EFLAGS: 00000297
> [   34.361682] RAX: ffffffffa03f0948 RBX: 0000000000000000 RCX: 000000000=
0000000
> [   34.362091] RDX: 0000000000000002 RSI: 0000000000000027 RDI: 000000000=
0000001
> [   34.362502] RBP: ffffc90001e5bd28 R08: 00000000fffeffff R09: 000000000=
0000001
> [   34.362917] R10: 0000000000000000 R11: ffffffff83299920 R12: ffffffff8=
1233536
> [   34.363325] R13: 0000000000000009 R14: 0000000000000455 R15: ffffffff8=
298f924
> [   34.363740]  ? __probe_event_disable+0x26/0x80
> [   34.364009]  ? print_modules+0x20/0xd0
> [   34.364230]  ? __probe_event_disable+0x26/0x80
> [   34.364488]  __warn+0x6f/0x180
> [   34.364683]  ? __probe_event_disable+0x26/0x80
> [   34.364945]  report_bug+0x18d/0x1c0
> [   34.365156]  handle_bug+0x3a/0x70
> [   34.365354]  exc_invalid_op+0x13/0x60
> [   34.365571]  asm_exc_invalid_op+0x16/0x20
> [   34.365838] RIP: 0010:__probe_event_disable+0x26/0x80
> [   34.366175] Code: 90 90 90 90 55 48 89 fd 53 48 8b 47 10 8b 90 38
> 01 00 00 85 d2 75 13 48 8b 88 40 01 00 00 48 8d 90 40
> [   34.367340] RSP: 0018:ffffc90001e5bdd0 EFLAGS: 00010287
> [   34.367651] RAX: ffff88810d86cc00 RBX: ffff88810d86cce0 RCX: ffff88810=
75c8168
> [   34.368067] RDX: ffff88810d86cd40 RSI: 0000000000000003 RDI: ffff88810=
a5e1db0
> [   34.368482] RBP: ffff88810a5e1db0 R08: 00000000ffffffff R09: 000000000=
0000000
> [   34.368896] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810=
75c8250
> [   34.369310] R13: ffff8881075c82f0 R14: ffffc90001e5bb80 R15: ffff88810=
75c8000
> [   34.369775]  trace_uprobe_register+0x1a8/0x300
> [   34.370053]  perf_trace_event_unreg.isra.0+0x22/0x80
> [   34.370342]  perf_uprobe_destroy+0x3a/0x70
> [   34.370582]  _free_event+0x114/0x580
> [   34.370806]  perf_event_release_kernel+0x282/0x2c0
> [   34.371123]  perf_release+0x11/0x20
> [   34.371354]  __fput+0x102/0x2e0
> [   34.371561]  task_work_run+0x55/0xa0
> [   34.371798]  syscall_exit_to_user_mode+0x1dd/0x1f0
> [   34.372104]  do_syscall_64+0x70/0x140
> [   34.372337]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   34.372659] RIP: 0033:0x7fd71c986a94
> [   34.372901] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84
> 00 00 00 00 00 90 f3 0f 1e fa 80 3d d5 18 0e 00 00 73
> [   34.373987] RSP: 002b:00007ffc09d83118 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000003
> [   34.374426] RAX: 0000000000000000 RBX: 00007ffc09d835e8 RCX: 00007fd71=
c986a94
> [   34.374874] RDX: 000000000000000b RSI: 0000000000002401 RDI: 000000000=
000000c
> [   34.375325] RBP: 00007ffc09d83150 R08: 00000000049d39c7 R09: 000000000=
0000007
> [   34.375782] R10: 00000000049d71b0 R11: 0000000000000202 R12: 000000000=
0000000
> [   34.376245] R13: 00007ffc09d83608 R14: 00007fd71cae3000 R15: 000000000=
103cd90
> [   34.376661]  </TASK>
> [   34.376794] Modules linked in: bpf_testmod(OE) aesni_intel(E)
> crypto_simd(E) cryptd(E) kvm_intel(E) i2c_piix4(E) i2c_s)
> [   34.377900] CR2: ffffc90001c5bea0
> [   34.378097] ---[ end trace 0000000000000000 ]---
> [   34.378366] RIP: 0010:__wake_up_common+0x3e/0xc0
> [   34.378637] Code: 89 d4 55 53 48 89 fb 48 83 ec 08 8b 05 c3 05 a8
> 02 89 74 24 04 85 c0 75 6d 48 8b 43 48 48 83 c3 48 4f
> [   34.379703] RSP: 0018:ffffc900001d0d90 EFLAGS: 00010087
> [   34.380004] RAX: ffffc90001c5bea0 RBX: ffff88810138e0e8 RCX: 000000000=
0000001
> [   34.380414] RDX: 0000000080010005 RSI: ffffffff8295f82c RDI: ffffc9000=
1c5be88
> [   34.380827] RBP: ffff88810138e0a0 R08: 0000000000000000 R09: 000000000=
000438f
> [   34.381284] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000=
0000001
> [   34.381736] R13: 0000000000000046 R14: 0000000000000000 R15: 000000000=
0000000
> [   34.382198] FS:  00007fd71c7b3d00(0000) GS:ffff88881ca00000(0000)
> knlGS:0000000000000000
> [   34.382712] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   34.383082] CR2: ffffc90001c5bea0 CR3: 000000010b456005 CR4: 000000000=
0370ef0
> [   34.383540] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   34.383991] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   34.384407] Kernel panic - not syncing: Fatal exception in interrupt
> [   35.464708] Shutting down cpus with NMI
> [   35.465244] Kernel Offset: disabled
> [   35.465474] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---

