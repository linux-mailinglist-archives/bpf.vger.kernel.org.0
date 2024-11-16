Return-Path: <bpf+bounces-45008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47D9CFC70
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 04:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04A31F242B8
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 03:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59A77102;
	Sat, 16 Nov 2024 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWHgb1sT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2E63D
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731726371; cv=none; b=Vz4TF2Qf7OmwcRxoShySqT9Bxjt/aIBL5e3qDKOUIegqalWEX4G5EXEifE1Gl9o69QQzMSFWGBywe37q9v/tLso51bIAFc2k4KhZ7r4I3A02TAabRKunioH5Wf42f20M9ORInVzLSrIrMa9iT/3Kwc/Yusabaq/bsq3aPAR5d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731726371; c=relaxed/simple;
	bh=w9Gv9mnXraMHRStd9vX40luvfcuU6jdf6FAtA3LWqIc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GeK4qv+JjcvUt9TFPk7cwjSRE61d1nIsEfSJo3jgw63iI7gHxdyfT6nOS9gTvQmOXFl/nqmBf/hpyG+clOUJnFtiihzc3wixjfnbDdDvgsGZ6V+Z1IQx7wCsLAAOunJAbIENH0xrWMrVJw/7nfDDWsOQZw86SsvTgmkFFynDSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWHgb1sT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so231612a12.1
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 19:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731726369; x=1732331169; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX4U10JtWDaj7CGzm3mNsauuOv0xsYjY6t8w/3QLCUs=;
        b=mWHgb1sT/owxdINPiEmlXoi6P4s7FC7/FjJtsYzCLlCMM5kfm+4z8Iv0b78VdlXIIG
         wrzFA1HgDP5VNZywPnQPzTzcN5oKydqxkXJlxJqP7ZJCHL5kXG6j4Z1Pg+Nr+XYCFO75
         FXTQidsOPlxl6QEF8mHPsyEWd+A4t/pX1oArMgF+1ljRSb38pIshpd4jmSj9xdx3ZAEy
         YoUf1R+ghqW8wRJxsPozcRz6MLifbBVrqhKlaghTgb6J1tcm7986KDB22ftH8vL6/Ld4
         RnNKsFscl1wLbUL4PFfo5ixoiX4LNslXKziyBlELg05jgcocogtvuWM1+8VmjpWE7X/D
         Hu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731726369; x=1732331169;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EX4U10JtWDaj7CGzm3mNsauuOv0xsYjY6t8w/3QLCUs=;
        b=OXbD6jiiRYgDkj+/evSMAJAthU9KzZ6Om6TbFr9pz0bXEKNH4sxPH6m3jlISTfgZoi
         MlTHPdLK1xptQ+LL+loEbEE9fjE4iTWF2qoerJy5HKJGDdPv8DEm+0D/2xZfdFAtrCAE
         llmdPFM4UnNGRxIj5VBpcaOtRCXSXQMLTNYAHZccOXWe5hoOF/UJZhSS0X5CpGw5+HVs
         ShOW1XOpbkV1cEpE6egmoqKAbO4cWs1Kuceb40gSJ5W+yWhEzUZfYgPhta4KR+YqGBhS
         lSrBYYSFq1AEHOnT4XEnasExvzpDTNQkjcHE54STFXUm929AM+JryrSgN49ArqApnRnU
         zFJw==
X-Forwarded-Encrypted: i=1; AJvYcCX/1IdZ1GWCHxVnGU3imoGU3iy3PKiG74JguOYqfFw89Klsmr950TgvwLuAKrxqX4hLvcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPv9emPwVbFqxGcJuO/T35F0y7Jad0yvX9oPuQQGeMLjkXgr+
	8ra71muD5gOgwXjamiWjzc2YluuUggWTe7Fk3u1eNCIziXGWk4vU
X-Google-Smtp-Source: AGHT+IHc78c3DCJrZAfGgl3c/6zhthSj99tXVR3KvOR8GLFtBjUMuBF0ghYgKpTIwokp9n9uCQTlag==
X-Received: by 2002:a17:902:f78b:b0:20c:e262:2568 with SMTP id d9443c01a7336-211d0d6f72fmr73097715ad.5.1731726368562;
        Fri, 15 Nov 2024 19:06:08 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34714sm18806095ad.127.2024.11.15.19.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 19:06:08 -0800 (PST)
Message-ID: <7b957bf7ab4b64a06526c533d82bcc3f982353a1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Add fd_array_cnt attribute for
 BPF_PROG_LOAD
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org
Date: Fri, 15 Nov 2024 19:06:03 -0800
In-Reply-To: <20241115004607.3144806-1-aspsk@isovalent.com>
References: <20241115004607.3144806-1-aspsk@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-15 at 00:46 +0000, Anton Protopopov wrote:
> Add a new attribute to the bpf(BPF_PROG_LOAD) system call. If this
> new attribute is non-zero, then the fd_array is considered to be a
> continuous array of the fd_array_cnt length and to contain only
> proper map file descriptors, or btf file descriptors, or zeroes.
>=20
> This change allows maps, which aren't referenced directly by a BPF
> program, to be bound to the program _and_ also to be present during
> the program verification (so BPF_PROG_BIND_MAP is not enough for this
> use case).
>=20
> The primary reason for this change is that it is a prerequisite for
> adding "instruction set" maps, which are both non-referenced by the
> program and must be present during the program verification.
>=20
> The first three commits add the new functionality, the fourth adds
> corresponding self-tests, and the last one is a small additional fix.

When I apply this series on top of [1] (there is a small merge conflict),
I get an error message from KASAN, the message is at the end of this email.
Probably triggered by processing of preloaded BPF programs.
Also added a few nits for individual patches.

[1] fab974e64874 ("libbpf: Fix memory leak in bpf_program__attach_uprobe_mu=
lti")

---

[    1.107455] ------------[ cut here ]------------
[    1.107545] Trying to vfree() nonexistent vm area (000000003f161725)
[    1.107640] WARNING: CPU: 6 PID: 1 at mm/vmalloc.c:3345 vfree (mm/vmallo=
c.c:3345 (discriminator 1) mm/vmalloc.c:3326 (discriminator 1))=20
[    1.107731] Modules linked in:
[    1.107922] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.3-2.fc40 04/01/2014
[    1.108057] RIP: 0010:vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmal=
loc.c:3326 (discriminator 1))=20
[ 1.108123] Code: ea 03 42 80 3c 22 00 0f 85 2d 04 00 00 48 8b 38 48 85 ff =
0f 85 76 ff ff ff 0f 0b 4c 89 e6 48 c7 c7 60 47 94 83 e8 5e b2 83 ff <0f> 0=
b 48 83 c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f e9 34 f8 dd 01 89
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	ea                   	(bad)
   1:	03 42 80             	add    -0x80(%rdx),%eax
   4:	3c 22                	cmp    $0x22,%al
   6:	00 0f                	add    %cl,(%rdi)
   8:	85 2d 04 00 00 48    	test   %ebp,0x48000004(%rip)        # 0x4800001=
2
   e:	8b 38                	mov    (%rax),%edi
  10:	48 85 ff             	test   %rdi,%rdi
  13:	0f 85 76 ff ff ff    	jne    0xffffffffffffff8f
  19:	0f 0b                	ud2
  1b:	4c 89 e6             	mov    %r12,%rsi
  1e:	48 c7 c7 60 47 94 83 	mov    $0xffffffff83944760,%rdi
  25:	e8 5e b2 83 ff       	call   0xffffffffff83b288
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 83 c4 60          	add    $0x60,%rsp
  30:	5b                   	pop    %rbx
  31:	5d                   	pop    %rbp
  32:	41 5c                	pop    %r12
  34:	41 5d                	pop    %r13
  36:	41 5e                	pop    %r14
  38:	41 5f                	pop    %r15
  3a:	e9 34 f8 dd 01       	jmp    0x1ddf873
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	48 83 c4 60          	add    $0x60,%rsp
   6:	5b                   	pop    %rbx
   7:	5d                   	pop    %rbp
   8:	41 5c                	pop    %r12
   a:	41 5d                	pop    %r13
   c:	41 5e                	pop    %r14
   e:	41 5f                	pop    %r15
  10:	e9 34 f8 dd 01       	jmp    0x1ddf849
  15:	89                   	.byte 0x89
[    1.108379] RSP: 0018:ffff88810034f368 EFLAGS: 00010296
[    1.108459] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[    1.108576] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000000=
00001
[    1.108682] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff08=
dfaa4
[    1.108791] R10: 0000000000000003 R11: ffffffff8475a8f0 R12: ffffc900001=
d6000
[    1.108896] R13: ffff888104e5064c R14: ffffc900001d49c0 R15: 00000000000=
00005
[    1.108999] FS:  0000000000000000(0000) GS:ffff88815b300000(0000) knlGS:=
0000000000000000
[    1.109104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.109234] CR2: 0000000000000000 CR3: 0000000004698000 CR4: 00000000007=
50ef0
[    1.109352] PKRU: 55555554
[    1.109397] Call Trace:
[    1.109442]  <TASK>
[    1.109489] ? __warn.cold (kernel/panic.c:748)=20
[    1.109564] ? vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmalloc.c:33=
26 (discriminator 1))=20
[    1.109623] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
[    1.109710] ? handle_bug (arch/x86/kernel/traps.c:285)=20
[    1.109775] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator=
 1))=20
[    1.109838] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)=
=20
[    1.109914] ? vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmalloc.c:33=
26 (discriminator 1))=20
[    1.109982] ? vfree (mm/vmalloc.c:3345 (discriminator 1) mm/vmalloc.c:33=
26 (discriminator 1))=20
[    1.110047] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.110128] ? kfree (mm/slub.c:4579 (discriminator 3) mm/slub.c:4727 (di=
scriminator 3))=20
[    1.110191] ? bpf_check (kernel/bpf/verifier.c:22799 (discriminator 1))=
=20
[    1.110252] ? bpf_check (kernel/bpf/verifier.c:22859)=20
[    1.110317] bpf_check (kernel/bpf/verifier.c:22861)=20
[    1.110382] ? kasan_save_stack (mm/kasan/common.c:49)=20
[    1.110443] ? kasan_save_track (mm/kasan/common.c:60 (discriminator 1) m=
m/kasan/common.c:69 (discriminator 1))=20
[    1.110515] ? __pfx_bpf_check (kernel/bpf/verifier.c:22606)=20
[    1.110612] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.110690] ? kasan_save_track (mm/kasan/common.c:60 (discriminator 1) m=
m/kasan/common.c:69 (discriminator 1))=20
[    1.110746] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.110820] ? __kasan_kmalloc (mm/kasan/common.c:377 mm/kasan/common.c:3=
94)=20
[    1.110885] ? bpf_prog_load (kernel/bpf/syscall.c:2947)=20
[    1.110942] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.111015] bpf_prog_load (kernel/bpf/syscall.c:2947)=20
[    1.111073] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.111163] ? __pfx_bpf_prog_load (kernel/bpf/syscall.c:2735)=20
[    1.111240] ? lock_acquire (kernel/locking/lockdep.c:5798)=20
[    1.111315] ? __pfx_bpf_check_uarg_tail_zero (kernel/bpf/syscall.c:87)=
=20
[    1.111401] __sys_bpf (kernel/bpf/syscall.c:5759)=20
[    1.111464] ? __pfx___sys_bpf (kernel/bpf/syscall.c:5721)=20
[    1.111522] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.111610] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.111690] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.111766] ? kern_sys_bpf (kernel/bpf/syscall.c:5909)=20
[    1.111837] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.111912] ? skel_map_update_elem.constprop.0 (./tools/lib/bpf/skel_int=
ernal.h:239)=20
[    1.111989] ? __pfx_skel_map_update_elem.constprop.0 (./tools/lib/bpf/sk=
el_internal.h:239)=20
[    1.112089] kern_sys_bpf (kernel/bpf/syscall.c:5909)=20
[    1.112156] ? __pfx_kern_sys_bpf (kernel/bpf/syscall.c:5909)=20
[    1.112226] bpf_load_and_run.constprop.0 (./tools/lib/bpf/skel_internal.=
h:342)=20
[    1.112303] ? __pfx_bpf_load_and_run.constprop.0 (./tools/lib/bpf/skel_i=
nternal.h:309)=20
[    1.112402] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.112480] ? kasan_save_track (mm/kasan/common.c:60 (discriminator 1) m=
m/kasan/common.c:69 (discriminator 1))=20
[    1.112550] load (kernel/bpf/preload/bpf_preload_kern.c:46 kernel/bpf/pr=
eload/bpf_preload_kern.c:78)=20
[    1.112614] ? __pfx_load (kernel/bpf/preload/bpf_preload_kern.c:75)=20
[    1.112673] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)=20
[    1.112750] ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_=
smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3)=
)=20
[    1.112837] ? __pfx_crypto_kfunc_init (kernel/bpf/crypto.c:374)=20
[    1.112920] ? __pfx_load (kernel/bpf/preload/bpf_preload_kern.c:75)=20
[    1.112981] do_one_initcall (init/main.c:1269)=20
[    1.113045] ? __pfx_do_one_initcall (init/main.c:1260)=20
[    1.113131] ? __kmalloc_noprof (./include/trace/events/kmem.h:54 (discri=
minator 2) mm/slub.c:4265 (discriminator 2) mm/slub.c:4276 (discriminator 2=
))=20
[    1.113191] ? kernel_init_freeable (init/main.c:1341 init/main.c:1366 in=
it/main.c:1580)=20
[    1.113277] kernel_init_freeable (init/main.c:1330 (discriminator 3) ini=
t/main.c:1347 (discriminator 3) init/main.c:1366 (discriminator 3) init/mai=
n.c:1580 (discriminator 3))=20
[    1.113359] ? __pfx_kernel_init (init/main.c:1461)=20
[    1.113426] kernel_init (init/main.c:1471)=20
[    1.113486] ? __pfx_kernel_init (init/main.c:1461)=20
[    1.113554] ret_from_fork (arch/x86/kernel/process.c:147)=20
[    1.113616] ? __pfx_kernel_init (init/main.c:1461)=20
[    1.113677] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)=20
[    1.113752]  </TASK>
[    1.113796] irq event stamp: 168993
[    1.113857] hardirqs last enabled at (169001): __up_console_sem (./arch/=
x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:97 ./arch/x=
86/include/asm/irqflags.h:155 kernel/printk/printk.c:344)=20
[    1.113992] hardirqs last disabled at (169008): __up_console_sem (kernel=
/printk/printk.c:342 (discriminator 3))=20
[    1.114128] softirqs last enabled at (168746): irq_exit_rcu (kernel/soft=
irq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:649)=
=20
[    1.114264] softirqs last disabled at (168741): irq_exit_rcu (kernel/sof=
tirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:649)=
=20
[    1.114399] ---[ end trace 0000000000000000 ]---



