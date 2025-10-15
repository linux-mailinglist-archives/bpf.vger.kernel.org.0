Return-Path: <bpf+bounces-71057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B16CBE0E29
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 23:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAD7D4F3244
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899CE3043C4;
	Wed, 15 Oct 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKWFwRMn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6729D279
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565468; cv=none; b=EkN/4h5qxL2SUBMtf0/upymPivWRUdJCBP8sBlt4XfhB9xqSWSzA1JMyCdnLA2dm3h/VQ8VMcmdX8xN+ty6pO8pt5RNaSf8vwUH9wo6gFwuaRmD4PXHuaRoheQp291Q25CXuWbShDeYdB/SS0xxG4dlZI2Nn8pSLAWZDiBkqIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565468; c=relaxed/simple;
	bh=ZQI0P+0YDRqe4RlDQBBFf67oUBHIcT+ucIOG/Kalk4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ksxw9S8Mg7xpPrZDGXSfSXIitrtHqtSb2MYROGzZyy5n1rg4vXtll2D9B3vLEDM7ufeo4oJEqlpU9trixZaekGi1IlHKSUXd4b1Ni1C1GyrRxjvawVd7AGJqBAQZGZavZOmWZIwS0PG9RBKdTV+nklFg/o4DElcG4fXlnp/WUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKWFwRMn; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62e7221351so13413a12.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760565465; x=1761170265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MlvFAZtb5n/E0RuT2T/1CdWmrd4pMonoJGGd6OS3TS8=;
        b=QKWFwRMnRXko2EHT3XSl+Sz2tDIQUKhKy9pBzFtjcRATVB1Nvj6Dni1+QH1ShMk2sg
         +EypIunwQv1F80LcyfI1tqzXbRMR0wBx94ARcqOJAWS/GYaF15AkbMPplMFc4l3V3Oq4
         7O3Jlee/wgD/tphABufWucdbOr+oM1JU+ZGyuLm1K6SpJyFni9SOlE4pIjhQdx3WVVo2
         PvVFX3jx07yErIcHJO2aeozueJCYSR5A/+zpvE300vmNndP/4Nhe/HF2ljeNuv1HYSH1
         guVvZbdKDOEFWDd7WUWR+NbZomcQ1ll3nURqI6fLtn5VdFpm9ScxuU9V/65hdpiomROd
         VbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565465; x=1761170265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlvFAZtb5n/E0RuT2T/1CdWmrd4pMonoJGGd6OS3TS8=;
        b=EDbv6dzzeH4Rm2a/aNvmBZDVeCeqkKC5dtrJhWAuooZFDCSJdApoJE8B6oSPvlpiHO
         iWiptdc3M/Aj7BLAfDo+apb6IoAbZ+AZEdxlrUnWYZ8wxi+dPNOHjsYVuwkwC1PUQP+d
         kh9rbBKnCbMxA73V4bPAih15XyvWlXpkc3hqSbgLR+DZH4yWskQqJO2ZyHpmmtpfgrPu
         HdEDPJvYF2wgn8kAQzdcsFnBB+cemN6HVWmRnJjJiR7UN6iNmAISxO3JRGUfvndUCN8b
         4Z9oP8ZMtz/TMd+OkpaHUurHMNi2XuHLiuXPiR4INPcpvqDrr5GH50uIoglhmjc2xmvO
         +Xhw==
X-Forwarded-Encrypted: i=1; AJvYcCXeZ3yAOgoZV7FRaxfaLw8T+mdAg4dQpVA2Cywk/iJPPPnEB6A0rYsCaLRPRR+VfpfwFyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3YYgTwNauhQAl2RMcuoCj/rIXhOuRuw7BMinjNUavZRgxY0PO
	1vbub23DaZiztOR0mvOwU/X24QY9bZBhQR3rc+JF1OctbOCpcYK8tRda
X-Gm-Gg: ASbGncv0d8Wv7z8C6wPpVpa54Ps4mInTv//MKMlG4SMvtOqwUp4QE2yDM/GQqgRNRwF
	+kIj5hnxj9AzuKM+igqDuCzRyNqGq6B40rG28D4SAejynM7Uu5vXXMBZ7mVW/nSq7hzFL9u3MVp
	ewbIW3MMo3He3n4ep7cixaMIzbwugdMCEaRng0FRL4/yiD33IB2VB41oLly5k/Fqzq3u5FBCN8o
	Yf5RCJiLX955l7EqJVsFrh+mAmCp7O9PSky6rfjqNkwKxUQxKcJDAY7XSq1wwGiEmm+EXZiwTIH
	LeIqZU4hZEgKRzJ4on6UW3uDjevFeI9GOsOTpbT8WSLXPr4cZsO9s41vRcUGsD+/34rCW7D5RX1
	mYs5sZ4HR/Vugr/aeufaurYqbBxsnrBqGtZxajE/Jrp8vqns68DyB1s7fKtvAe8UcvK5LCEGuLw
	==
X-Google-Smtp-Source: AGHT+IENIAnSB8LE0S2yVNYa3fNmDfilG2DLirajJ9gUfYMkQMYpXShoGEY5Ry0uaDfOKXLMJyO2lQ==
X-Received: by 2002:a05:6a20:12d2:b0:2b7:949d:63e1 with SMTP id adf61e73a8af0-32da83db661mr40271375637.32.1760565465455;
        Wed, 15 Oct 2025 14:57:45 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-799283c1a15sm484527b3a.0.2025.10.15.14.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:57:45 -0700 (PDT)
Message-ID: <188b00961e374aeec9b1aac53cb25416e502ef67.camel@gmail.com>
Subject: Re: [RFC PATCH v2 11/11] selftests/bpf: add file dynptr tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 14:57:42 -0700
In-Reply-To: <20251015161155.120148-12-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-12-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing selftests for validating file-backed dynptr works as
> expected.
>  * validate implementation supports dynptr slice and read operations
>  * validate destructors should be paired with initializers
>  * validate sleepable progs can page in.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

I get the following error report when running this test on top of [1].

[1] 48a97ffc6c82 ("bpf: Consistently use bpf_rcu_lock_held() everywhere")

---

[   11.790725] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   11.790999] WARNING: possible recursive locking detected
[   11.791195] 6.17.0-gbfd75250bee0 #1 Tainted: G           OE     =20
[   11.791418] --------------------------------------------
[   11.791446] test_progs/153 is trying to acquire lock:
[   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: __might_f=
ault (mm/memory.c:7081 (discriminator 4))
[   11.791446]=20
[   11.791446] but task is already holding lock:
[   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bpf_find_=
vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_lock.h:41 =
./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bpf/task_=
iter.c:751)
[   11.791446]=20
[   11.791446] other info that might help us debug this:
[   11.791446]  Possible unsafe locking scenario:
[   11.791446]=20
[   11.791446]        CPU0
[   11.791446]        ----
[   11.791446]   lock(&mm->mmap_lock);
[   11.791446]   lock(&mm->mmap_lock);
[   11.791446]=20
[   11.791446]  *** DEADLOCK ***
[   11.791446]=20
[   11.791446]  May be due to missing lock nesting notation
[   11.791446]=20
[   11.791446] 2 locks held by test_progs/153:
[   11.791446]  #0: ffffffff85a73be0 (rcu_read_lock_trace){....}-{0:0}, at:=
 bpf_task_work_callback (./include/linux/rcupdate.h:331 (discriminator 1) .=
/include/linux/rcupdate_trace.h:58 (discriminator 1) ./include/linux/rcupda=
te_trace.h:102 (discriminator 1) kernel/bpf/helpers.c:4101 (discriminator 1=
))
[   11.791446]  #1: ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bpf_=
find_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_lock.=
h:41 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bpf/=
task_iter.c:751)
[   11.791446]=20
[   11.791446] stack backtrace:
[   11.791446] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[   11.791446] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.3-4.el9 04/01/2014
[   11.791446] Call Trace:
[   11.791446]  <TASK>
[   11.791446]  dump_stack_lvl (lib/dump_stack.c:122)
[   11.791446]  print_deadlock_bug.cold (kernel/locking/lockdep.c:3044)
[   11.791446]  __lock_acquire (kernel/locking/lockdep.c:3897 kernel/lockin=
g/lockdep.c:5237)
[   11.791446]  ? __pfx___up_read (kernel/locking/rwsem.c:1350)
[   11.791446]  lock_acquire (kernel/locking/lockdep.c:470 kernel/locking/l=
ockdep.c:5870 kernel/locking/lockdep.c:5825)
[   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
[   11.791446]  ? __pfx___might_resched (kernel/sched/core.c:8880)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  __might_fault (mm/memory.c:7081 (discriminator 7))
[   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
[   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
[   11.791446]  _copy_from_user (./include/linux/instrumented.h:129 ./inclu=
de/linux/uaccess.h:177 lib/usercopy.c:18)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  bpf_copy_from_user (kernel/bpf/helpers.c:664 (discriminator=
 1) kernel/bpf/helpers.c:659 (discriminator 1))
[   11.791446]  bpf_prog_1791842c6dbe7a9d_validate_file_read+0xeb/0x1c3
[   11.791446]  ? 0xffffffffc000098c
[   11.791446]  bpf_find_vma (kernel/bpf/task_iter.c:780 kernel/bpf/task_it=
er.c:751)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  bpf_prog_b8b63503b43f929b_task_work_callback+0x3b/0x43
[   11.791446]  bpf_task_work_callback (./include/linux/sched.h:2353 ./incl=
ude/linux/sched.h:2417 kernel/bpf/helpers.c:4118)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? __pfx_bpf_task_work_callback (kernel/bpf/helpers.c:4094)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator=
 6) kernel/locking/lockdep.c:5891 (discriminator 6) kernel/locking/lockdep.=
c:5875 (discriminator 6))
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  task_work_run (kernel/task_work.c:229)
[   11.791446]  ? __pfx_task_work_run (kernel/task_work.c:195)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? __irq_work_queue_local (kernel/irq_work.c:89)
[   11.791446]  ? __pfx___irq_work_queue_local (kernel/irq_work.c:89)
[   11.791446]  get_signal (kernel/signal.c:2807)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? irq_work_queue (kernel/irq_work.c:125 (discriminator 3) k=
ernel/irq_work.c:116 (discriminator 3))
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? bpf_task_work_schedule.isra.0 (kernel/bpf/helpers.c:4264)
[   11.791446]  ? 0xffffffffc000071c
[   11.791446]  ? __pfx_bpf_task_work_schedule.isra.0 (kernel/bpf/helpers.c=
:4229)
[   11.791446]  ? __pfx_get_signal (kernel/signal.c:2800)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? __lock_acquire (kernel/locking/lockdep.c:4674 (discrimina=
tor 1) kernel/locking/lockdep.c:5191 (discriminator 1))
[   11.791446]  arch_do_signal_or_restart (./arch/x86/include/asm/current.h=
:23 arch/x86/kernel/signal.c:258 arch/x86/kernel/signal.c:339)
[   11.791446]  ? __pfx_arch_do_signal_or_restart (arch/x86/kernel/signal.c=
:334)
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discrimina=
tor 1))
[   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[   11.791446]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator=
 6) kernel/locking/lockdep.c:5891 (discriminator 6) kernel/locking/lockdep.=
c:5875 (discriminator 6))
[   11.791446]  exit_to_user_mode_loop (kernel/entry/common.c:42)
[   11.791446]  do_syscall_64 (./include/linux/irq-entry-common.h:225 ./inc=
lude/linux/entry-common.h:175 ./include/linux/entry-common.h:210 arch/x86/e=
ntry/syscall_64.c:100)
[   11.791446]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:1=
30)
[   11.791446] RIP: 0033:0x7fc6d58da89b
[   11.791446] Code: 0f 1e fa b9 01 00 00 00 e9 b2 fc ff ff 66 90 f3 0f 1e =
fa 31 c9 e9 a5 fc ff ff 0f 1f 44 00 00 f3 0f 1e fa b8 27 00 00 00 0f 05 <c3=
> 0f 1f 40 00 f3 0f 1e fa b8 6e 00 00 00 0f 05 c3 0f 1f 40 00 f3
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 1e fa             	nop    %edx
   3:	b9 01 00 00 00       	mov    $0x1,%ecx
   8:	e9 b2 fc ff ff       	jmp    0xfffffffffffffcbf
   d:	66 90                	xchg   %ax,%ax
   f:	f3 0f 1e fa          	endbr64
  13:	31 c9                	xor    %ecx,%ecx
  15:	e9 a5 fc ff ff       	jmp    0xfffffffffffffcbf
  1a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1f:	f3 0f 1e fa          	endbr64
  23:	b8 27 00 00 00       	mov    $0x27,%eax
  28:	0f 05                	syscall
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	0f 1f 40 00          	nopl   0x0(%rax)
  2f:	f3 0f 1e fa          	endbr64
  33:	b8 6e 00 00 00       	mov    $0x6e,%eax
  38:	0f 05                	syscall
  3a:	c3                   	ret
  3b:	0f 1f 40 00          	nopl   0x0(%rax)
  3f:	f3                   	repz

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c3                   	ret
   1:	0f 1f 40 00          	nopl   0x0(%rax)
   5:	f3 0f 1e fa          	endbr64
   9:	b8 6e 00 00 00       	mov    $0x6e,%eax
   e:	0f 05                	syscall
  10:	c3                   	ret
  11:	0f 1f 40 00          	nopl   0x0(%rax)
  15:	f3                   	repz
[   11.791446] RSP: 002b:00007fffab903ff8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000027
[   11.791446] RAX: 0000000000000099 RBX: 00007fc6d60b7000 RCX: 00007fc6d58=
da89b
[   11.791446] RDX: 000000000000005f RSI: 00000000013d1c62 RDI: 00007fffab9=
03aa0
[   11.791446] RBP: 00007fffab9042a0 R08: 0000000000000000 R09: 00007fffab9=
03ed7
[   11.791446] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffab9=
044f8
[   11.791446] R13: 00000000007c2531 R14: 000000000334fd10 R15: 00007fc6d60=
f6000
[   11.791446]  </TASK>
#115/1   file_reader/on_getpid_expect_fault:OK
#115/2   file_reader/on_getpid_validate_file_read:OK
#115     file_reader:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
Powering off.
[   11.946617] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   11.948196] sd 0:0:0:0: [sda] Stopping disk

