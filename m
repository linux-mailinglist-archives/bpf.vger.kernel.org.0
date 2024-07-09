Return-Path: <bpf+bounces-34305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4532F92C5AF
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB06228344F
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A71850A2;
	Tue,  9 Jul 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASHS3xps"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479D14374C;
	Tue,  9 Jul 2024 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561646; cv=none; b=MP6+tdE2ccOXVPBGgyGPdEuzsrUK27ZBJ43XMbBTCbZsoS8YiBGQ0ca1X3qdysxi4wDR7/I6vyFkSLHnuGJsVkB7SfBVfzbNlT/QCTICtMfDp6zispZ4S+n6E7FqxMIIHdIJCEbL4Udp3zyL9pKz4cG8VHa20ypcmqVMd+u/GQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561646; c=relaxed/simple;
	bh=fPatu1Bz2FnijqAMdrl6wmluKGQrJkMKcdMyFzSeEW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbNm8LWuv9NyxytRNL8FDbZ+W4iLo3BqiNh0h0ExRLbbxQE+Q3cPxFH2DnWAYUJhJgKf/hKFHdgY7an1kyqMKADZpeh0Qxvo3wrL/H6ju5Ton1/D/FMwIH9T/1zklxHl7+JB9UOVxacIV3kkdJL+piIJ9uO2jwFomhkYew+yu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASHS3xps; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-701b0b0be38so4356838b3a.0;
        Tue, 09 Jul 2024 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720561644; x=1721166444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr1Aq6g6iHEMO2Vs4dczKy7eaazf0sBRWVh/L0WL6YA=;
        b=ASHS3xpsPS6cIbotL63BvE3G9nu6DhrgPNlVWz7QGfGN0cX5HNEC4vjHq3oB/GIMhb
         QHkXnatlPR/M71L7gMUWJtqFvQm0/vtr5KiOhqpjpuOjSWFg51jUF5OjpxdGvNhatG2x
         u3i6WIzbd5I2lJDOkppNhVOrr6i02X9o+62xVIyAK8UFGqQUwkFUZ3lbTmuLllWqhlkq
         gl1lXeXnWYXdbDusyK86puaD9ZxS01UriDSUc78sydNP7bHX/qL/g2KaLWTz+rHjVlZO
         TWxiCXGtRLFV0VkL9u1jlUXelNR2N0vo2sea4Xpbi2t76qA8wf35SnWMY4IMIvTbTwcp
         9/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720561644; x=1721166444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr1Aq6g6iHEMO2Vs4dczKy7eaazf0sBRWVh/L0WL6YA=;
        b=cSOe6vDWqK5KZCBjlQJUb97e/YtR6tT0Kh3MMOoyx8V0YG4oVMf4x3sFplrfYuARn3
         gSAxvFmORgzztxVa84NJL4cjtHsUsG8Pmlafl4+oXSZsptoLmzFrm/p76BDmQWx0Xe4H
         HPXz8y2Tl/O+SpEOl8gWEkzeRqRcdlUWgKSy65/ima4jr0gIJawG3BdtO+zxHUg8zabb
         lRFhu8ZAL2hL8WEzGItUKDY1o1j10vIUOiCRWrrAnRwEO7L9Rk25zu50oxBw8s2Twd8j
         Ntz5gR3yPSpk3+LCm/0+Hjr2fYK/7iIu0Gg+3SemBEo/VuMP+4ioaNBK3lbh3WwStujn
         LD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNbAbYM0DQthUbeq+ZyqeEXUZC1qJYT11i9Z8fkrFfZicTszufAKyjb9CADbRnYKBQUZpI56UY9P/7LhzgXg8TxET73JYX7PvLQ0/jjMUbhMdcKNRRWsp7dnXI8ofgEros
X-Gm-Message-State: AOJu0YxqgdOpAodvF9aYiGA1TsmcyA9Z8vg2yG9BQ45MMqZPuMPXbG5Q
	9/7dJ+dvh+HgzJ/gBjJK5jAX59DG9Ij0rtLoTCveOTNRIEetRPOJ3tf+JBvRxGEZGRTEcDMHwCp
	ciqU787+vnIp1C2vpn4mjyxxglNLuNLnu
X-Google-Smtp-Source: AGHT+IFe4jvpKKU5USK2eE6dh8waF3zfs852Efj2hcn8/BvvnDxJh7Bw4q8khAPgSjcuLSwiCxSI9W6FlVtC8wmTizM=
X-Received: by 2002:a05:6a00:21cd:b0:70a:f38c:74ba with SMTP id
 d2e1a72fcca58-70b435eaa3fmr4589499b3a.22.1720561643938; Tue, 09 Jul 2024
 14:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708091241.544262971@infradead.org> <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
In-Reply-To: <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 14:47:12 -0700
Message-ID: <CAEf4BzZbjqoNw4jJkO3TOmPJSxyCAze56YeUQULPbK3oLmOvsA@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 3:56=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
> >
> > On Mon, 08 Jul 2024 11:12:41 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > Hi!
> > >
> > > These patches implement the (S)RCU based proposal to optimize uprobes=
.
> > >
> > > On my c^Htrusty old IVB-EP -- where each (of the 40) CPU calls 'func'=
 in a
> > > tight loop:
> > >
> > >   perf probe -x ./uprobes test=3Dfunc
> > >   perf stat -ae probe_uprobe:test  -- sleep 1
> > >
> > >   perf probe -x ./uprobes test=3Dfunc%return
> > >   perf stat -ae probe_uprobe:test__return -- sleep 1
> > >
> > > PRE:
> > >
> > >   4,038,804      probe_uprobe:test
> > >   2,356,275      probe_uprobe:test__return
> > >
> > > POST:
> > >
> > >   7,216,579      probe_uprobe:test
> > >   6,744,786      probe_uprobe:test__return
> > >
> >
> > Good results! So this is another series of Andrii's batch register?
> > (but maybe it becomes simpler)
>
> yes, this would be an alternative to my patches
>
>
> Peter,
>
> I didn't have time to look at the patches just yet, but I managed to
> run a quick benchmark (using bench tool we have as part of BPF
> selftests) to see both single-threaded performance and how the
> performance scales with CPUs (now that we are not bottlenecked on
> register_rwsem). Here are some results:

Running in my local VM with debugging config, I'm getting the
following. Please check if that's something new or it's just another
symptom of the issues that Oleg pointed out already.


[   11.213834] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[   11.214225] WARNING: lock held when returning to user space!
[   11.214603] 6.10.0-rc6-gd3f5cbffe86b #1263 Tainted: G           OE
[   11.215040] ------------------------------------------------
[   11.215426] urandom_read/2412 is leaving the kernel with locks still hel=
d!
[   11.215876] 1 lock held by urandom_read/2412:
[   11.216175]  #0: ffffffff835ce8f0 (uretprobes_srcu){.+.+}-{0:0},
at: srcu_read_lock+0x31/0x3f
[   11.262797] ------------[ cut here ]------------
[   11.263162] refcount_t: underflow; use-after-free.
[   11.263474] WARNING: CPU: 1 PID: 2409 at lib/refcount.c:28
refcount_warn_saturate+0x99/0xda
[   11.263995] Modules linked in: bpf_testmod(OE) aesni_intel(E)
crypto_simd(E) floppy(E) cryptd(E) i2c_piix4(E) crc32c_intel(E)
button(E) i2c_core(E) i6300esb(E) pcspkr(E) serio_raw(E)
[   11.265105] CPU: 1 PID: 2409 Comm: test_progs Tainted: G
OE      6.10.0-rc6-gd3f5cbffe86b #1263
[   11.265740] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   11.266507] RIP: 0010:refcount_warn_saturate+0x99/0xda
[   11.266862] Code: 05 ba 29 1d 02 01 e8 e2 c0 b4 ff 0f 0b c3 80 3d
aa 29 1d 02 00 75 53 48 c7 c7 20 59 50 82 c6 05 9a 29 1d 02 01 e8 c3
c0 b4 ff <0f> 0b c3 80 3d 8a 29 1d 02 00 75 34 a
[   11.268099] RSP: 0018:ffffc90001fbbd60 EFLAGS: 00010282
[   11.268451] RAX: 0000000000000026 RBX: ffff88810f333000 RCX: 00000000000=
00027
[   11.268931] RDX: 0000000000000000 RSI: ffffffff82580a45 RDI: 00000000fff=
fffff
[   11.269417] RBP: ffff888105937818 R08: 0000000000000000 R09: 00000000000=
00000
[   11.269910] R10: 00000000756f6366 R11: 0000000063666572 R12: ffff88810f3=
33030
[   11.270387] R13: ffffc90001fbbb80 R14: ffff888100535190 R15: dead0000000=
00100
[   11.270870] FS:  00007fc938bd2d00(0000) GS:ffff88881f680000(0000)
knlGS:0000000000000000
[   11.271363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.271725] CR2: 000000000073a005 CR3: 00000001127d5004 CR4: 00000000003=
70ef0
[   11.272220] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   11.272693] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   11.273182] Call Trace:
[   11.273370]  <TASK>
[   11.273518]  ? __warn+0x8b/0x14d
[   11.273753]  ? report_bug+0xdb/0x151
[   11.273997]  ? refcount_warn_saturate+0x99/0xda
[   11.274326]  ? handle_bug+0x3c/0x5b
[   11.274564]  ? exc_invalid_op+0x13/0x5c
[   11.274831]  ? asm_exc_invalid_op+0x16/0x20
[   11.275119]  ? refcount_warn_saturate+0x99/0xda
[   11.275428]  uprobe_unregister_nosync+0x61/0x7c
[   11.275768]  __probe_event_disable+0x5d/0x7d
[   11.276069]  probe_event_disable+0x50/0x58
[   11.276350]  trace_uprobe_register+0x4f/0x1a7
[   11.276667]  perf_trace_event_unreg.isra.0+0x1e/0x6b
[   11.277031]  perf_uprobe_destroy+0x26/0x4b
[   11.277312]  _free_event+0x2ad/0x311
[   11.277558]  perf_event_release_kernel+0x210/0x221
[   11.277887]  ? lock_acquire+0x8d/0x266
[   11.278147]  perf_release+0x11/0x14
[   11.278384]  __fput+0x133/0x1fb
[   11.278604]  task_work_run+0x67/0x8b
[   11.278858]  resume_user_mode_work+0x22/0x4a
[   11.279153]  syscall_exit_to_user_mode+0x86/0xdd
[   11.279465]  do_syscall_64+0xa1/0xfb
[   11.279733]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   11.280074] RIP: 0033:0x7fc938da5a94
[   11.280322] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84
00 00 00 00 00 90 f3 0f 1e fa 80 3d d5 18 0e 00 00 74 13 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 44 c3 0f 1f 00 3
[   11.281538] RSP: 002b:00007ffd3553e6a8 EFLAGS: 00000202 ORIG_RAX:
0000000000000003
[   11.282003] RAX: 0000000000000000 RBX: 00007ffd3553eb58 RCX: 00007fc938d=
a5a94
[   11.282498] RDX: 0000000000000011 RSI: 0000000000002401 RDI: 00000000000=
00012
[   11.282981] RBP: 00007ffd3553e6e0 R08: 0000000004a90425 R09: 00000000000=
00007
[   11.283451] R10: 0000000004a95050 R11: 0000000000000202 R12: 00000000000=
00000
[   11.283894] R13: 00007ffd3553eb88 R14: 00007fc938f01000 R15: 0000000000f=
fad90
[   11.284387]  </TASK>
[   11.284540] irq event stamp: 70926
[   11.284779] hardirqs last  enabled at (70925): [<ffffffff81c93d2c>]
_raw_spin_unlock_irqrestore+0x30/0x5f
[   11.285404] hardirqs last disabled at (70926): [<ffffffff81c8e5bd>]
__schedule+0x1ad/0xcab
[   11.285943] softirqs last  enabled at (70898): [<ffffffff811f0992>]
bpf_link_settle+0x2a/0x3b
[   11.286506] softirqs last disabled at (70896): [<ffffffff811f097d>]
bpf_link_settle+0x15/0x3b
[   11.287071] ---[ end trace 0000000000000000 ]---
[   11.400528] ------------[ cut here ]------------
[   11.400877] refcount_t: saturated; leaking memory.
[   11.401214] WARNING: CPU: 2 PID: 2409 at lib/refcount.c:22
refcount_warn_saturate+0x5b/0xda
[   11.401778] Modules linked in: bpf_testmod(OE) aesni_intel(E)
crypto_simd(E) floppy(E) cryptd(E) i2c_piix4(E) crc32c_intel(E)
button(E) i2c_core(E) i6300esb(E) pcspkr(E) serio_raw(E)
[   11.402822] CPU: 2 PID: 2409 Comm: test_progs Tainted: G        W
OE      6.10.0-rc6-gd3f5cbffe86b #1263
[   11.403396] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   11.404091] RIP: 0010:refcount_warn_saturate+0x5b/0xda
[   11.404404] Code: 02 01 e8 24 c1 b4 ff 0f 0b c3 80 3d ee 29 1d 02
00 0f 85 91 00 00 00 48 c7 c7 bd 58 50 82 c6 05 da 29 1d 02 01 e8 01
c1 b4 ff <0f> 0b c3 80 3d ca 29 1d 02 00 75 72 a
[   11.405578] RSP: 0018:ffffc90001fbbca0 EFLAGS: 00010286
[   11.405906] RAX: 0000000000000026 RBX: ffff888103fb9400 RCX: 00000000000=
00027
[   11.406397] RDX: 0000000000000000 RSI: ffffffff82580a45 RDI: 00000000fff=
fffff
[   11.406875] RBP: ffff8881029b3400 R08: 0000000000000000 R09: 00000000000=
00000
[   11.407345] R10: 00000000756f6366 R11: 0000000063666572 R12: ffff8881015=
ab5d8
[   11.407827] R13: ffff888105d9b208 R14: 0000000000078060 R15: 00000000000=
00000
[   11.408311] FS:  00007fc938bd2d00(0000) GS:ffff88881f700000(0000)
knlGS:0000000000000000
[   11.408853] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.409254] CR2: 00007fffffffe080 CR3: 00000001127d5006 CR4: 00000000003=
70ef0
[   11.409688] Call Trace:
[   11.409852]  <TASK>
[   11.409988]  ? __warn+0x8b/0x14d
[   11.410199]  ? report_bug+0xdb/0x151
[   11.410422]  ? refcount_warn_saturate+0x5b/0xda
[   11.410748]  ? handle_bug+0x3c/0x5b
[   11.410987]  ? exc_invalid_op+0x13/0x5c
[   11.411254]  ? asm_exc_invalid_op+0x16/0x20
[   11.411538]  ? refcount_warn_saturate+0x5b/0xda
[   11.411857]  __uprobe_register+0x185/0x2a2
[   11.412140]  ? __uprobe_perf_filter+0x3f/0x3f
[   11.412465]  probe_event_enable+0x265/0x2b8
[   11.412753]  perf_trace_event_init+0x174/0x1fd
[   11.413029]  perf_uprobe_init+0x8f/0xbc
[   11.413268]  perf_uprobe_event_init+0x52/0x64
[   11.413538]  perf_try_init_event+0x5c/0xe7
[   11.413799]  perf_event_alloc+0x4e1/0xaf5
[   11.414047]  ? _raw_spin_unlock+0x29/0x3a
[   11.414299]  ? alloc_fd+0x190/0x1a3
[   11.414520]  __do_sys_perf_event_open+0x28a/0x9c6
[   11.414823]  do_syscall_64+0x85/0xfb
[   11.415047]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   11.415403] RIP: 0033:0x7fc938db573d
[   11.415648] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8
[   11.417177] RSP: 002b:00007ffd3553c328 EFLAGS: 00000286 ORIG_RAX:
000000000000012a
[   11.417724] RAX: ffffffffffffffda RBX: 00007ffd3553eb58 RCX: 00007fc938d=
b573d
[   11.418233] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00007ffd355=
3c3e0
[   11.418726] RBP: 00007ffd3553c480 R08: 0000000000000008 R09: 00000000000=
00000
[   11.419202] R10: 00000000ffffffff R11: 0000000000000286 R12: 00000000000=
00000
[   11.419671] R13: 00007ffd3553eb88 R14: 00007fc938f01000 R15: 0000000000f=
fad90
[   11.420151]  </TASK>
[   11.420291] irq event stamp: 70926
[   11.420502] hardirqs last  enabled at (70925): [<ffffffff81c93d2c>]
_raw_spin_unlock_irqrestore+0x30/0x5f
[   11.421162] hardirqs last disabled at (70926): [<ffffffff81c8e5bd>]
__schedule+0x1ad/0xcab
[   11.421717] softirqs last  enabled at (70898): [<ffffffff811f0992>]
bpf_link_settle+0x2a/0x3b
[   11.422286] softirqs last disabled at (70896): [<ffffffff811f097d>]
bpf_link_settle+0x15/0x3b
[   11.422829] ---[ end trace 0000000000000000 ]---


>
> [root@kerneltest003.10.atn6 ~]# for num_threads in {1..20}; do ./bench \
> -a -d10 -p $num_threads trig-uprobe-nop | grep Summary; done
> Summary: hits    3.278 =C2=B1 0.021M/s (  3.278M/prod)
> Summary: hits    4.364 =C2=B1 0.005M/s (  2.182M/prod)
> Summary: hits    6.517 =C2=B1 0.011M/s (  2.172M/prod)
> Summary: hits    8.203 =C2=B1 0.004M/s (  2.051M/prod)
> Summary: hits    9.520 =C2=B1 0.012M/s (  1.904M/prod)
> Summary: hits    8.316 =C2=B1 0.007M/s (  1.386M/prod)
> Summary: hits    7.893 =C2=B1 0.037M/s (  1.128M/prod)
> Summary: hits    8.490 =C2=B1 0.014M/s (  1.061M/prod)
> Summary: hits    8.022 =C2=B1 0.005M/s (  0.891M/prod)
> Summary: hits    8.471 =C2=B1 0.019M/s (  0.847M/prod)
> Summary: hits    8.156 =C2=B1 0.021M/s (  0.741M/prod)
> ...
>
>
> (numbers in the first column is total throughput, and xxx/prod is
> per-thread throughput). Single-threaded performance (about 3.3 mln/s)
> is on part with what I had with my patches. And clearly it scales
> better with more thread now that register_rwsem is gone, though,
> unfortunately, it doesn't really scale linearly.
>
> Quick profiling for the 8-threaded benchmark shows that we spend >20%
> in mmap_read_lock/mmap_read_unlock in find_active_uprobe. I think
> that's what would prevent uprobes from scaling linearly. If you have
> some good ideas on how to get rid of that, I think it would be
> extremely beneficial. We also spend about 14% of the time in
> srcu_read_lock(). The rest is in interrupt handling overhead, actual
> user-space function overhead, and in uprobe_dispatcher() calls.
>
> Ramping this up to 16 threads shows that mmap_rwsem is getting more
> costly, up to 45% of CPU. SRCU is also growing a bit slower to 19% of
> CPU. Is this expected? (I'm not familiar with the implementation
> details)
>
> P.S. Would you be able to rebase your patches on top of latest
> probes/for-next, which include Jiri's sys_uretprobe changes. Right now
> uretprobe benchmarks are quite unrepresentative because of that.
> Thanks!
>
>
> >
> > Thank you,
> >
> > >
> > > Patches also available here:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf=
/uprobes
> > >
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>

