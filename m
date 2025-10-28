Return-Path: <bpf+bounces-72633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE29C16C0C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 21:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3E01A2830F
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4E2C1587;
	Tue, 28 Oct 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE2v5JRy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65E281376
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682990; cv=none; b=R7XLSfQWWqfWCmgN9XFLon9ewkMUbG/12inud/ONY1Uk4DUpzkBINqcRfTT4raEmPbF7wVOkELs6cCbkHEFX+13ATU2CsWbn8cMGnasQeG6JKhYkVpESj4rYpEKa5d/q3YtK6xgX8ycvIlzWvoa/41XND0PszlOsyGl7aYIbTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682990; c=relaxed/simple;
	bh=6xTgr0EgqQcEGhc22AEUvOCC8fzx4jx00Q9+ncsQVEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrZDZH8ZRklzRJnsKIQLb/Lua6PYunTn+ghjffkHAlNSQss2KT69s7g7hWl04NkFB19C182Ozi2iM+F7oVpOkIyumQMaEar0q8x3PxbKFknSxVf6//ALp+rzaHJ37U+XLmSX5ZRC9dcgHGruSrWcHv8WS4u8sXhqm1DJvbMH+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE2v5JRy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso4943131a12.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682988; x=1762287788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eiU5X0MtLg1AWy8TJMvL0p3KdK19oLqNSiclHjQzS4=;
        b=OE2v5JRy5M27jqDfYDwiVduZezH0pwnsGgzp0Z4iZWTZq0+g5SnQ765FDh4O2gu3dh
         FO/3x1aGm429ToYCdQ11hOHxfzRURwtRBimKYAkIzvM5wzYlrtuoxFsiKT879lZcbXj1
         zIyg4YNyj7X8A9ZC3jNF7RI+y8oemOuWra+gtf3tT+fZBeWZBup91o6vLpOOL+QivYov
         Ks5VX9/VbVQhn4b3qcLgH0WV9rkeoyY04aKWYpA3TK3in0xtFXLpWMI0m1AHpZRp736/
         EYN6Cwq/0f91zNzxghYcp11gFUI2SqM0kh/qkDTkmvsQSAabQ1vmTrcH1ArXs+KPEcaT
         IvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682988; x=1762287788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eiU5X0MtLg1AWy8TJMvL0p3KdK19oLqNSiclHjQzS4=;
        b=l6GaFM02kDqym0/b76SS42teKfx9AxPTBOteZMf27UR7JDcFM33wCa9wY6jETtA0Nl
         PXechHd1Sq4Wnah1xezB2pligK7lNLfxl5f/YKOH3JSY4tFnaEplIFzWNa+sRQ8t4lf7
         EElOwvr1Cxcb0/3UEx0WBAlMNTwsdJZAMlCHf11MZ+Og/ArvRr3vqWWKhB0kWZCeLII4
         qLUXdEjzAXYE4F5eG2u7VuYwy0XhXTPNJAVpl0XhCTcgnaAcOHiB1ioxdkX/j3h4LJtX
         AA8KmWAu3eMc24980Bi4zHHESekJNRKBqr1ZXxdcpOiT4naCxkwraWzr9X/1J90AEarK
         OCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiMJ0rHSnXP7P3h7G9SOwqj9tydQbgZ8An+D4GbVmDHOvj3J2WIgXm5RB8eVwX/xWJLrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFNWl6JmcSqo3YGy6dS+Bu6ZP2SCBPNA493/K7IdRasgF7Ego
	9B9JW2qJ5I3u/y6JUbTElLunhGm5AKMvrGJT1JV5QCRN2lg5nLqVPEPYHT465PJmycnMIesaBIW
	Ds37YPkCZdD6NzWEIPQhegltKEyjCybA=
X-Gm-Gg: ASbGncuGGqyTt+hYRp7Ov+88cgO/a4Son9441//Q8iW8Kg9j/BHCovlqHzEsWVP/+Ms
	o5LYnUItwk+20DjauboYC0wNygL9XLP27sqK6T7+hg8r1MWRE9mEFoPyqCMBWonJPh0PaezHbd9
	hQbwmmQQsZLETS07j0td4EkpzlFyt5tbq3WcJROVe8tBxVnEpp4KPjtu+i5WDUEw4pQR62A3h2P
	L7FOJDW/A2z0SQWGU6/+nrD22R1hI9UvlC4T2hkBv1YTif/DFfIVwN2o5YOI+AZwGwUwZA9xGF9
X-Google-Smtp-Source: AGHT+IEanbLtV+A1uxD07yLCIAzVFpVbUlS7xrnuVYcPA5Fr5hRoHuCsYXkZerVpGBl8B3Cw1K0prKjboLbz9EwjhLA=
X-Received: by 2002:a17:903:32d0:b0:270:e595:a440 with SMTP id
 d9443c01a7336-294deea9fe0mr4170815ad.25.1761682987467; Tue, 28 Oct 2025
 13:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
In-Reply-To: <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 13:22:52 -0700
X-Gm-Features: AWmQ_bmGSoBQBafD4RYC0uD63bU25UDV0ufQgzX3COvu8ZcTnEGFiwaaelmGWas
Message-ID: <CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and
 local storage maps
To: patchwork-bot+netdevbpf@kernel.org
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Sun, 26 Oct 2025 23:39:56 +0800 you wrote:
> > In the discussion thread
> > "[PATCH bpf-next v9 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS fl=
ags for percpu maps"[1],
> > it was pointed out that missing calls to bpf_obj_free_fields() could
> > lead to memory leaks.
> >
> > A selftest was added to confirm that this is indeed a real issue - the
> > refcount of BPF_KPTR_REF field is not decremented when
> > bpf_obj_free_fields() is missing after copy_map_value[,_long]().
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf,v3,1/4] bpf: Free special fields when update [lru_,]percpu_hash =
maps
>     https://git.kernel.org/bpf/bpf-next/c/f6de8d643ff1
>   - [bpf,v3,2/4] bpf: Free special fields when update hash maps with BPF_=
F_LOCK
>     https://git.kernel.org/bpf/bpf-next/c/c7fcb7972196
>   - [bpf,v3,3/4] bpf: Free special fields when update local storage maps
>     (no matching commit)
>   - [bpf,v3,4/4] selftests/bpf: Add tests to verify freeing the special f=
ields when update hash and local storage maps
>     https://git.kernel.org/bpf/bpf-next/c/d5a7e7af14cc
>

Ok, I had to drop this from bpf-next after all. First,
kptr_refcount_leak/cgroup_storage_refcount_leak needs to be adjusted
due to that one line removal in patch 3.

But what's worse, we started getting deadlock warning when running one
of the tests, see [0]:

[  418.260323] bpf_testmod: oh no, recursing into test_1, recursion_misses =
1
  [  424.982201]
  [  424.982207] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [  424.982216] WARNING: inconsistent lock state
  [  424.982219] 6.18.0-rc1-gbb1b9387787c-dirty #1 Tainted: G        W  OE
  [  424.982221] --------------------------------
  [  424.982223] inconsistent {INITIAL USE} -> {IN-NMI} usage.
  [  424.982225] new_name/11207 [HC1[1]:SC0[0]:HE0:SE1] takes:
  [  424.982229] ffffe8ffffd9c000 (&loc_l->lock){....}-{2:2}, at:
bpf_lru_pop_free+0x2c6/0x1a50
  [  424.982244] {INITIAL USE} state was registered at:
  [  424.982246]   lock_acquire+0x154/0x2d0
  [  424.982252]   _raw_spin_lock_irqsave+0x39/0x60
  [  424.982259]   bpf_lru_pop_free+0x2c6/0x1a50
  [  424.982262]   htab_lru_map_update_elem+0x17e/0xa90
  [  424.982266]   bpf_map_update_value+0x5aa/0x1230
  [  424.982272]   __sys_bpf+0x33b4/0x4ef0
  [  424.982275]   __x64_sys_bpf+0x78/0xe0
  [  424.982278]   do_syscall_64+0x6a/0x2f0
  [  424.982282]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [  424.982287] irq event stamp: 236
  [  424.982288] hardirqs last  enabled at (235): [<ffffffff959e4e70>]
do_syscall_64+0x30/0x2f0
  [  424.982292] hardirqs last disabled at (236): [<ffffffff959e65df>]
exc_nmi+0x7f/0x110
  [  424.982296] softirqs last  enabled at (0): [<ffffffff933fe7cf>]
copy_process+0x1c3f/0x6ab0
  [  424.982302] softirqs last disabled at (0): [<0000000000000000>] 0x0
  [  424.982305]
  [  424.982305] other info that might help us debug this:
  [  424.982306]  Possible unsafe locking scenario:
  [  424.982306]
  [  424.982307]        CPU0
  [  424.982308]        ----
  [  424.982309]   lock(&loc_l->lock);
  [  424.982311]   <Interrupt>
  [  424.982312]     lock(&loc_l->lock);
  [  424.982314]
  [  424.982314]  *** DEADLOCK ***
  [  424.982314]
  [  424.982315] no locks held by new_name/11207.
  [  424.982317]
  [  424.982317] stack backtrace:
  [  424.982326] CPU: 1 UID: 0 PID: 11207 Comm: new_name Tainted: G
    W  OE       6.18.0-rc1-gbb1b9387787c-dirty #1 PREEMPT(full)
  [  424.982332] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODU=
LE
  [  424.982334] Hardware name: QEMU Ubuntu 25.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  [  424.982337] Call Trace:
  [  424.982340]  <NMI>
  [  424.982342]  dump_stack_lvl+0x5d/0x80
  [  424.982356]  print_usage_bug.part.0+0x22b/0x2c0
  [  424.982360]  lock_acquire+0x278/0x2d0
  [  424.982364]  ? __irq_work_queue_local+0x133/0x360
  [  424.982371]  ? bpf_lru_pop_free+0x2c6/0x1a50
  [  424.982375]  _raw_spin_lock_irqsave+0x39/0x60
  [  424.982379]  ? bpf_lru_pop_free+0x2c6/0x1a50
  [  424.982382]  bpf_lru_pop_free+0x2c6/0x1a50
  [  424.982387]  ? arch_irq_work_raise+0x3f/0x60
  [  424.982394]  ? __pfx___irq_work_queue_local+0x10/0x10
  [  424.982399]  htab_lru_map_update_elem+0x17e/0xa90
  [  424.982405]  ? __pfx_htab_lru_map_update_elem+0x10/0x10
  [  424.982408]  ? __kasan_check_byte+0x16/0x60
  [  424.982414]  ? __htab_map_lookup_elem+0x95/0x220
  [  424.982420]  bpf_prog_2c77131b3c031599_oncpu_lru_map+0xe4/0x168
  [  424.982423]  __perf_event_overflow+0x8e8/0xea0
  [  424.982430]  ? __pfx___perf_event_overflow+0x10/0x10
  [  424.982436]  handle_pmi_common+0x3fe/0x810
  [  424.982441]  ? __pfx_handle_pmi_common+0x10/0x10
  [  424.982452]  ? __pfx_intel_bts_interrupt+0x10/0x10
  [  424.982458]  intel_pmu_handle_irq+0x1c5/0x5d0
  [  424.982461]  ? lock_acquire+0x1ef/0x2d0
  [  424.982465]  ? nmi_handle.part.0+0x2f/0x380
  [  424.982469]  perf_event_nmi_handler+0x3e/0x70
  [  424.982476]  nmi_handle.part.0+0x13f/0x380
  [  424.982480]  ? trace_rcu_watching+0x105/0x170
  [  424.982486]  default_do_nmi+0x3b/0x110
  [  424.982490]  ? irqentry_nmi_enter+0x6f/0x80
  [  424.982493]  exc_nmi+0xe3/0x110
  [  424.982497]  end_repeat_nmi+0xf/0x53
  [  424.982502] RIP: 0010:fput_close_sync+0x56/0x1a0
  [  424.982509] Code: 48 89 e5 48 c7 04 24 b3 8a b5 41 48 c7 44 24 08
5c a2 3e 96 48 c1 ed 03 48 c7 44 24 10 10 a7 e0 93 42 c7 44 2d 00 f1
f1 f1 f1 <42> c7 44 2d 04 00 f3 f3 f3 65 48 8b 05 91 98 56 04 48 89 44
24 58
  [  424.982513] RSP: 0018:ffffc900099d7e88 EFLAGS: 00000a06
  [  424.982517] RAX: 0000000000000000 RBX: ffff888109fb48c0 RCX:
0000000000000000
  [  424.982520] RDX: 1ffff110099572bb RSI: 0000000000000008 RDI:
ffff888109fb4a20
  [  424.982522] RBP: 1ffff9200133afd1 R08: ffff888109fb48c0 R09:
ffff888109278b40
  [  424.982524] R10: ffff888109fb4920 R11: 0000000000000000 R12:
0000000000000003
  [  424.982526] R13: dffffc0000000000 R14: 0000000000000003 R15:
0000000000000000
  [  424.982532]  ? fput_close_sync+0x56/0x1a0
  [  424.982537]  ? fput_close_sync+0x56/0x1a0
  [  424.982541]  </NMI>
  [  424.982542]  <TASK>
  [  424.982544]  ? __pfx_fput_close_sync+0x10/0x10
  [  424.982548]  ? do_raw_spin_unlock+0x59/0x250
  [  424.982553]  __x64_sys_close+0x7d/0xd0
  [  424.982559]  do_syscall_64+0x6a/0x2f0
  [  424.982563]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [  424.982566] RIP: 0033:0x7faae0f88fe2
  [  424.982569] Code: 08 0f 85 71 3a ff ff 49 89 fb 48 89 f0 48 89 d7
48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24
08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00
00 66
  [  424.982571] RSP: 002b:00007ffe58ee5b08 EFLAGS: 00000246 ORIG_RAX:
0000000000000003
  [  424.982574] RAX: ffffffffffffffda RBX: 00007faae0a6cb00 RCX:
00007faae0f88fe2
  [  424.982577] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000072
  [  424.982579] RBP: 00007ffe58ee5b30 R08: 0000000000000000 R09:
0000000000000000
  [  424.982581] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000008
  [  424.982583] R13: 0000000000000000 R14: 0000556f5e250c90 R15:
00007faae11e9000
  [  424.982588]  </TASK>
  [  424.982606] perf: interrupt took too long (14417 > 12551),
lowering kernel.perf_event_max_sample_rate to 13000

We'll need to figure this out first.

  [0] https://github.com/kernel-patches/bpf/actions/runs/18884827710/job/53=
898669092

> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

