Return-Path: <bpf+bounces-45051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB39D061C
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 22:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0095B21A52
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77891DDA18;
	Sun, 17 Nov 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="U9rnhchm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57D1DD894
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878379; cv=none; b=j0s/giXPogtFliuC14lwPsrojV7RbrV3r0JVjpC5vGqf1SX7TY8gWozngy92gZuPZkl0kAhxuqFxgQF3vQobo+O/LE1oO5i99kzGCOirZaGXMQh7qyTaGxlvD5/D4N9oQEJt6qiyiUc6s3vFpJqN+iC02bLmhR9Re60FhH5dlGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878379; c=relaxed/simple;
	bh=1Xvofvs3N2NBebTf1uGuIc7/aVwOAx+QuWm4VpQp0bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmIWYK0wbvUiKndxKKztdj3YOiw73I8FbiVMvmBGl9C/qppgY2qHJ1QMUeVyf3Gn82BIEvDMv2RPV5QgVlvsxia54kzQZZLqtSdr2BNRxQyIRDu1JyMBbkTn8r1WRWbrPwdM76SinMcKA1e8rZlcA9FArJKXhzrJor8+qoKWzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=U9rnhchm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so419448766b.2
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 13:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1731878374; x=1732483174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xooW+8vtBLAi8luZk3q75FiW0rAHCS8ziUjmgyQ594E=;
        b=U9rnhchmia8j/zipcRJ0TbhNpFzTmdZRMYAmEskgT3DqUCTQaYYyGI5FPy7OeE3rCH
         D4QSoXNnW+Luu60JWbT1romJp/7VdZPRKb1mXalpu5WsIs6ZxR0V92+lfV4a1xsOmbjN
         lH9rD/8inbv9G3WIuLAvzimJyHALZGxlAMcpDosB9GmZm8Z9RDBy0Jnbd5VIjwnw8XoM
         IzUsvdPtreQ/TyAvR7fxWLQCXmOMstnFrFB6IhOj1YPm5C/xdxR51dBWLo6Y9ho+sU2S
         NNRyyvG68iDJxYFCfef2JvpKas6vHWaUYljcoVCtbVkLRy8c63QdXoWcoWgToYiR+uYT
         O65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731878374; x=1732483174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xooW+8vtBLAi8luZk3q75FiW0rAHCS8ziUjmgyQ594E=;
        b=hDMfQf3DHKl/t1kihg8dJAlbgrJ4LtiznnmfU6/uXS5SsYiNgmcwEGOGi8eOg/Wjhe
         4j2EyF6yJPiR0pwI3X8tH5LeJFt4iLDSmGJm46o1mv5HW0gpmeNsjnCVz8enRXzq/nq6
         dlgUyWRqUfzxSBxgGTU4dEDBQdqArpxLShX/nwcKmyU2t4KkdWDP2aGuEruRGmBhbjgK
         01uE+lc0jWdAEbh/GI8OmpH1J356GCsUH2arkVpCg2DUpEUHm2VWIr3lvbej3If6xKKw
         0BET1HO1N+W6Uucj7l5NR8VtddRJ2xsOIye2b2bUsQ1sqHBTAS7LLro5+qoUjSQRfw7A
         bK9Q==
X-Gm-Message-State: AOJu0YxVnyOtbg0brXZO6y2dnebSyQlo6/ewQs0sgASg1OXSMjgsLFIt
	XE13aGKyPynOHEf9Y3FJ4hlrRHE9Qmigla4T7tl9bYhs0XXKvd+l1GJ1zc/a5dJPFAMBj1aESXs
	i
X-Google-Smtp-Source: AGHT+IE/XDn8+NoMYfdupm/t97hCtyxHu03JmcxB+k4TWUEzxMNXecSiOgAsBIily7PugVFiprkUWg==
X-Received: by 2002:a17:906:db09:b0:a9e:670e:38bc with SMTP id a640c23a62f3a-aa4833ec1cfmr763251566b.3.1731878374283;
        Sun, 17 Nov 2024 13:19:34 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffba13sm452494866b.95.2024.11.17.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:19:33 -0800 (PST)
Date: Sun, 17 Nov 2024 21:22:31 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/5] Add fd_array_cnt attribute for BPF_PROG_LOAD
Message-ID: <ZzpelyMaubxXqttM@eis>
References: <20241115004607.3144806-1-aspsk@isovalent.com>
 <7b957bf7ab4b64a06526c533d82bcc3f982353a1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b957bf7ab4b64a06526c533d82bcc3f982353a1.camel@gmail.com>

On 24/11/15 07:06PM, Eduard Zingerman wrote:
> On Fri, 2024-11-15 at 00:46 +0000, Anton Protopopov wrote:
> > Add a new attribute to the bpf(BPF_PROG_LOAD) system call. If this
> > new attribute is non-zero, then the fd_array is considered to be a
> > continuous array of the fd_array_cnt length and to contain only
> > proper map file descriptors, or btf file descriptors, or zeroes.
> > 
> > This change allows maps, which aren't referenced directly by a BPF
> > program, to be bound to the program _and_ also to be present during
> > the program verification (so BPF_PROG_BIND_MAP is not enough for this
> > use case).
> > 
> > The primary reason for this change is that it is a prerequisite for
> > adding "instruction set" maps, which are both non-referenced by the
> > program and must be present during the program verification.
> > 
> > The first three commits add the new functionality, the fourth adds
> > corresponding self-tests, and the last one is a small additional fix.
> 
> When I apply this series on top of [1] (there is a small merge conflict),
> I get an error message from KASAN, the message is at the end of this email.
> Probably triggered by processing of preloaded BPF programs.

Thanks for pointing to this warning. Unluckily, I can't reproduce it locally,
and neither I have a conflict (I've rebased my branch on top of the current
master, which contains [1]). Could you please tell me which environment you
were using to trigger it? Is this BPF CI?

> Also added a few nits for individual patches.

Thanks for looking! I will reply there.

> [1] fab974e64874 ("libbpf: Fix memory leak in bpf_program__attach_uprobe_multi")
> 
> ---
> 
> [    1.107455] ------------[ cut here ]------------
> [    1.107545] Trying to vfree() nonexistent vm area (000000003f161725)
> [    1.107640] WARNING: CPU: 6 PID: 1 at mm/vmalloc.c:3345 vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmalloc.c:3326 (discriminator 1)) 
> [    1.107731] Modules linked in:
> [    1.107922] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> [    1.108057] RIP: 0010:vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmalloc.c:3326 (discriminator 1)) 
> [ 1.108123] Code: ea 03 42 80 3c 22 00 0f 85 2d 04 00 00 48 8b 38 48 85 ff 0f 85 76 ff ff ff 0f 0b 4c 89 e6 48 c7 c7 60 47 94 83 e8 5e b2 83 ff <0f> 0b 48 83 c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f e9 34 f8 dd 01 89
> All code
> ========
>    0:	ea                   	(bad)
>    1:	03 42 80             	add    -0x80(%rdx),%eax
>    4:	3c 22                	cmp    $0x22,%al
>    6:	00 0f                	add    %cl,(%rdi)
>    8:	85 2d 04 00 00 48    	test   %ebp,0x48000004(%rip)        # 0x48000012
>    e:	8b 38                	mov    (%rax),%edi
>   10:	48 85 ff             	test   %rdi,%rdi
>   13:	0f 85 76 ff ff ff    	jne    0xffffffffffffff8f
>   19:	0f 0b                	ud2
>   1b:	4c 89 e6             	mov    %r12,%rsi
>   1e:	48 c7 c7 60 47 94 83 	mov    $0xffffffff83944760,%rdi
>   25:	e8 5e b2 83 ff       	call   0xffffffffff83b288
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	48 83 c4 60          	add    $0x60,%rsp
>   30:	5b                   	pop    %rbx
>   31:	5d                   	pop    %rbp
>   32:	41 5c                	pop    %r12
>   34:	41 5d                	pop    %r13
>   36:	41 5e                	pop    %r14
>   38:	41 5f                	pop    %r15
>   3a:	e9 34 f8 dd 01       	jmp    0x1ddf873
>   3f:	89                   	.byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	48 83 c4 60          	add    $0x60,%rsp
>    6:	5b                   	pop    %rbx
>    7:	5d                   	pop    %rbp
>    8:	41 5c                	pop    %r12
>    a:	41 5d                	pop    %r13
>    c:	41 5e                	pop    %r14
>    e:	41 5f                	pop    %r15
>   10:	e9 34 f8 dd 01       	jmp    0x1ddf849
>   15:	89                   	.byte 0x89
> [    1.108379] RSP: 0018:ffff88810034f368 EFLAGS: 00010296
> [    1.108459] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [    1.108576] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
> [    1.108682] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff08dfaa4
> [    1.108791] R10: 0000000000000003 R11: ffffffff8475a8f0 R12: ffffc900001d6000
> [    1.108896] R13: ffff888104e5064c R14: ffffc900001d49c0 R15: 0000000000000005
> [    1.108999] FS:  0000000000000000(0000) GS:ffff88815b300000(0000) knlGS:0000000000000000
> [    1.109104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.109234] CR2: 0000000000000000 CR3: 0000000004698000 CR4: 0000000000750ef0
> [    1.109352] PKRU: 55555554
> [    1.109397] Call Trace:
> [    1.109442]  <TASK>
> [    1.109489] ? __warn.cold (kernel/panic.c:748) 
> [    1.109564] ? vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmalloc.c:3326 (discriminator 1)) 
> [    1.109623] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
> [    1.109710] ? handle_bug (arch/x86/kernel/traps.c:285) 
> [    1.109775] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
> [    1.109838] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621) 
> [    1.109914] ? vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmalloc.c:3326 (discriminator 1)) 
> [    1.109982] ? vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmalloc.c:3326 (discriminator 1)) 
> [    1.110047] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.110128] ? kfree (mm/slub.c:4579 (discriminator 3) mm/slub.c:4727 (discriminator 3)) 
> [    1.110191] ? bpf_check (kernel/bpf/verifier.c:22799 (discriminator 1)) 
> [    1.110252] ? bpf_check (kernel/bpf/verifier.c:22859) 
> [    1.110317] bpf_check (kernel/bpf/verifier.c:22861) 
> [    1.110382] ? kasan_save_stack (mm/kasan/common.c:49) 
> [    1.110443] ? kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1)) 
> [    1.110515] ? __pfx_bpf_check (kernel/bpf/verifier.c:22606) 
> [    1.110612] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.110690] ? kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1)) 
> [    1.110746] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.110820] ? __kasan_kmalloc (mm/kasan/common.c:377 mm/kasan/common.c:394) 
> [    1.110885] ? bpf_prog_load (kernel/bpf/syscall.c:2947) 
> [    1.110942] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.111015] bpf_prog_load (kernel/bpf/syscall.c:2947) 
> [    1.111073] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.111163] ? __pfx_bpf_prog_load (kernel/bpf/syscall.c:2735) 
> [    1.111240] ? lock_acquire (kernel/locking/lockdep.c:5798) 
> [    1.111315] ? __pfx_bpf_check_uarg_tail_zero (kernel/bpf/syscall.c:87) 
> [    1.111401] __sys_bpf (kernel/bpf/syscall.c:5759) 
> [    1.111464] ? __pfx___sys_bpf (kernel/bpf/syscall.c:5721) 
> [    1.111522] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.111610] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.111690] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.111766] ? kern_sys_bpf (kernel/bpf/syscall.c:5909) 
> [    1.111837] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.111912] ? skel_map_update_elem.constprop.0 (./tools/lib/bpf/skel_internal.h:239) 
> [    1.111989] ? __pfx_skel_map_update_elem.constprop.0 (./tools/lib/bpf/skel_internal.h:239) 
> [    1.112089] kern_sys_bpf (kernel/bpf/syscall.c:5909) 
> [    1.112156] ? __pfx_kern_sys_bpf (kernel/bpf/syscall.c:5909) 
> [    1.112226] bpf_load_and_run.constprop.0 (./tools/lib/bpf/skel_internal.h:342) 
> [    1.112303] ? __pfx_bpf_load_and_run.constprop.0 (./tools/lib/bpf/skel_internal.h:309) 
> [    1.112402] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.112480] ? kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1)) 
> [    1.112550] load (kernel/bpf/preload/bpf_preload_kern.c:46 kernel/bpf/preload/bpf_preload_kern.c:78) 
> [    1.112614] ? __pfx_load (kernel/bpf/preload/bpf_preload_kern.c:75) 
> [    1.112673] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
> [    1.112750] ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3)) 
> [    1.112837] ? __pfx_crypto_kfunc_init (kernel/bpf/crypto.c:374) 
> [    1.112920] ? __pfx_load (kernel/bpf/preload/bpf_preload_kern.c:75) 
> [    1.112981] do_one_initcall (init/main.c:1269) 
> [    1.113045] ? __pfx_do_one_initcall (init/main.c:1260) 
> [    1.113131] ? __kmalloc_noprof (./include/trace/events/kmem.h:54 (discriminator 2) mm/slub.c:4265 (discriminator 2) mm/slub.c:4276 (discriminator 2)) 
> [    1.113191] ? kernel_init_freeable (init/main.c:1341 init/main.c:1366 init/main.c:1580) 
> [    1.113277] kernel_init_freeable (init/main.c:1330 (discriminator 3) init/main.c:1347 (discriminator 3) init/main.c:1366 (discriminator 3) init/main.c:1580 (discriminator 3)) 
> [    1.113359] ? __pfx_kernel_init (init/main.c:1461) 
> [    1.113426] kernel_init (init/main.c:1471) 
> [    1.113486] ? __pfx_kernel_init (init/main.c:1461) 
> [    1.113554] ret_from_fork (arch/x86/kernel/process.c:147) 
> [    1.113616] ? __pfx_kernel_init (init/main.c:1461) 
> [    1.113677] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [    1.113752]  </TASK>
> [    1.113796] irq event stamp: 168993
> [    1.113857] hardirqs last enabled at (169001): __up_console_sem (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 ./arch/x86/include/asm/irqflags.h:155 kernel/printk/printk.c:344) 
> [    1.113992] hardirqs last disabled at (169008): __up_console_sem (kernel/printk/printk.c:342 (discriminator 3)) 
> [    1.114128] softirqs last enabled at (168746): irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:649) 
> [    1.114264] softirqs last disabled at (168741): irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:649) 
> [    1.114399] ---[ end trace 0000000000000000 ]---
> 
> 

