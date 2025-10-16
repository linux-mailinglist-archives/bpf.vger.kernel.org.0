Return-Path: <bpf+bounces-71152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE79DBE5681
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D6C3AF728
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363DA2DF140;
	Thu, 16 Oct 2025 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9CSxRii"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F923EA83
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646560; cv=none; b=R5LB0rhQmVzS5KitbJOUoICX62HVuG8woQUke0X7Lh8E+H4COS1Sfftf0JRfJocmhvP47mc4U5XH9fr7nDWSpiZ2utaPZlWXEziUVdebhD8yQZk+cMpIoD2XEru76fCmZhKz77MBFKjR9IZ7fsk2XM9IUYlvodp7jBCKZLTHr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646560; c=relaxed/simple;
	bh=mPGjZnD1twLZO/cRS5qHgtOzOOdPYV6UXTATrwIDySk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq58yHqO8cwWi+pEwVcn7yd8rMXt9tAUq9dFAqniHERfhezPIIEzwhZEfl1VaKbkP5JRmLS7T1GGNf2jNjx1g6mJ2z0k5YBFdTzskACtQ3FN65gIg2yXaWWt/Z9JBACpqXCEjv066EqNU/r3AvGpwwitcTClmXLnEJtqtQlnNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9CSxRii; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so1156963a91.2
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646558; x=1761251358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqkKd9Y6Y8t8gDHuxwsk0E07aUgrF9snt32HDA1x9pw=;
        b=T9CSxRiiPXVoUsXh0HWdFC++SgAbReY3n2M2Csb7k6p7BdWTI/Ch+DLqCjItvXjR/s
         Vxh2GnwDghCMRqWY5iABJ94R+U8yKHXhXbBydx7Lj1Nap1bEyLMOcwU2ph+AfbxvfNgL
         03mHdVVz+WzCLVoZ/xbmZNTi3U1hLK6tzt6YWJRyCaPvQRGrzPIU1ku/KIkdyHk76t4m
         yvSZFjHFiZHRDZoIvfvvrLs4GAri7DPTcvAFhyXmchinrxMtIAaN9jkgRXY6Z5vBWyOa
         mhlfAo9P0odqniSP0koZTHcsJeF+NoKB31xfovJou3Fdu+BKrmeXeqci1HyhYllLTdew
         Z/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646558; x=1761251358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqkKd9Y6Y8t8gDHuxwsk0E07aUgrF9snt32HDA1x9pw=;
        b=Ly5IsDT2W3cYm1/M1A4T66c0yxnfwznj86pEhnLUpTzuFmhnPCQICZQMOIEFCERkMT
         C6IKCK0J1//PJeFoyLQh6LzEuOMiurdsr92k7EFc1lZSgTby4J0t4ItrjKV1W6a5MHVF
         Dn09vmPAQDnPMUHr9MEPe3RPpXtw9b41T9pYoO8e3Wiwqok2Vmea/59EDLFlewKHkMPh
         5XIKRE5Rr5TelHwXGbfwTsPjPVdKetObU3rZ7mzKIpVrD6O7tQKDBdG6WJU6dsuHka+K
         448LNQ2Ka8xkz0yuNO0H6KUUBPgJ1H27GofvGezYDZA8J4DRfYrQsRaUZ3t4zjRI3FPR
         YLTw==
X-Forwarded-Encrypted: i=1; AJvYcCVKZMk5+xRvzIr8JUTwEBWxgSPulvGqK/EdyCY6kWikE4jyNW8qo9mcMxv0CnZyox79lDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrK9j3r05/f633vKPXO/6sUXjs16csvOt3JR79UghkbReZg5Hu
	uuK1EYUtI0crtz4SwsaQPhoEq2M9pvBU85qeRCEUG5DKt59Ngdu/R72hC4u8g/aMscIqdk0cUMp
	D+9WjoptVwRxnq0xNx2xv9sn8ONN1NTg=
X-Gm-Gg: ASbGnctQMi5D7XdJ1Hp+B8t3JarVISzvk6fmF4nuU3RhNOHA6z9PQkDjw7V8ozmK2Dw
	ekGNkm4nVDpyh076mKWdLbRJ316DrXkFWIBo7vIBwRf7ET5OgGUOupe9OlnQVDwYzdN58crV90i
	2diVx1nHdVPp9s9vSciPhm0R0hZQfMpUp2SPsiEIc8BgvIbCq34UveOv0L52VopAitS7D4/uUnn
	F5udOfy1VH1qI9wpm/M6UhVwTmL39rZReDiNXM7B+azthedX8ywdZxU98/WqA2JJ+mXwYsMvMn4
X-Google-Smtp-Source: AGHT+IEFXwrjBULRHKx2kO2737Dq18dP7A07CCW3SWyUQRT57PfU2m99DIy+r4cBeP3KTbmUuW0GJJo6VWJrCUAmBnY=
X-Received: by 2002:a17:90b:3e86:b0:32e:528c:60ee with SMTP id
 98e67ed59e1d1-33bcf8e618amr1243883a91.24.1760646558175; Thu, 16 Oct 2025
 13:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <20251015161155.120148-12-mykyta.yatsenko5@gmail.com> <188b00961e374aeec9b1aac53cb25416e502ef67.camel@gmail.com>
In-Reply-To: <188b00961e374aeec9b1aac53cb25416e502ef67.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 13:29:02 -0700
X-Gm-Features: AS18NWD1qY1SSS-TiRqMnzJxIDyYpwH3pzcSylMRyYk764fciVekoWqjF1c5C4Q
Message-ID: <CAEf4BzYoA_T2zM7+ED88PMe2VNpybrduFObUB83QegGewB2O5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/11] selftests/bpf: add file dynptr tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Introducing selftests for validating file-backed dynptr works as
> > expected.
> >  * validate implementation supports dynptr slice and read operations
> >  * validate destructors should be paired with initializers
> >  * validate sleepable progs can page in.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
>
> I get the following error report when running this test on top of [1].
>
> [1] 48a97ffc6c82 ("bpf: Consistently use bpf_rcu_lock_held() everywhere")
>
> ---
>
> [   11.790725] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   11.790999] WARNING: possible recursive locking detected
> [   11.791195] 6.17.0-gbfd75250bee0 #1 Tainted: G           OE
> [   11.791418] --------------------------------------------
> [   11.791446] test_progs/153 is trying to acquire lock:
> [   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: __might=
_fault (mm/memory.c:7081 (discriminator 4))
> [   11.791446]
> [   11.791446] but task is already holding lock:
> [   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bpf_fin=
d_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_lock.h:4=
1 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bpf/tas=
k_iter.c:751)
> [   11.791446]
> [   11.791446] other info that might help us debug this:
> [   11.791446]  Possible unsafe locking scenario:
> [   11.791446]
> [   11.791446]        CPU0
> [   11.791446]        ----
> [   11.791446]   lock(&mm->mmap_lock);
> [   11.791446]   lock(&mm->mmap_lock);
> [   11.791446]
> [   11.791446]  *** DEADLOCK ***
> [   11.791446]
> [   11.791446]  May be due to missing lock nesting notation
> [   11.791446]
> [   11.791446] 2 locks held by test_progs/153:
> [   11.791446]  #0: ffffffff85a73be0 (rcu_read_lock_trace){....}-{0:0}, a=
t: bpf_task_work_callback (./include/linux/rcupdate.h:331 (discriminator 1)=
 ./include/linux/rcupdate_trace.h:58 (discriminator 1) ./include/linux/rcup=
date_trace.h:102 (discriminator 1) kernel/bpf/helpers.c:4101 (discriminator=
 1))
> [   11.791446]  #1: ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bp=
f_find_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_loc=
k.h:41 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bp=
f/task_iter.c:751)
> [   11.791446]
> [   11.791446] stack backtrace:
> [   11.791446] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> [   11.791446] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-4.el9 04/01/2014
> [   11.791446] Call Trace:
> [   11.791446]  <TASK>
> [   11.791446]  dump_stack_lvl (lib/dump_stack.c:122)
> [   11.791446]  print_deadlock_bug.cold (kernel/locking/lockdep.c:3044)
> [   11.791446]  __lock_acquire (kernel/locking/lockdep.c:3897 kernel/lock=
ing/lockdep.c:5237)
> [   11.791446]  ? __pfx___up_read (kernel/locking/rwsem.c:1350)
> [   11.791446]  lock_acquire (kernel/locking/lockdep.c:470 kernel/locking=
/lockdep.c:5870 kernel/locking/lockdep.c:5825)
> [   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
> [   11.791446]  ? __pfx___might_resched (kernel/sched/core.c:8880)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  __might_fault (mm/memory.c:7081 (discriminator 7))

cc'ing some mm folks for help

Is it a lockdep implementation detail that __might_fault is taking
mmap_lock, or __might_fault is asserting that when fault is allowed,
something (presumably kernel's page fault handler) might take
mmap_lock? It's not clear to me.

bpf_find_vma() clearly is holding mmap_lock, so if that's unsafe, we'd
have to make sure that bpf_find_vma() cannot be called in a sleepable
BPF program.



> [   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
> [   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
> [   11.791446]  _copy_from_user (./include/linux/instrumented.h:129 ./inc=
lude/linux/uaccess.h:177 lib/usercopy.c:18)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  bpf_copy_from_user (kernel/bpf/helpers.c:664 (discriminat=
or 1) kernel/bpf/helpers.c:659 (discriminator 1))
> [   11.791446]  bpf_prog_1791842c6dbe7a9d_validate_file_read+0xeb/0x1c3
> [   11.791446]  ? 0xffffffffc000098c
> [   11.791446]  bpf_find_vma (kernel/bpf/task_iter.c:780 kernel/bpf/task_=
iter.c:751)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  bpf_prog_b8b63503b43f929b_task_work_callback+0x3b/0x43
> [   11.791446]  bpf_task_work_callback (./include/linux/sched.h:2353 ./in=
clude/linux/sched.h:2417 kernel/bpf/helpers.c:4118)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? __pfx_bpf_task_work_callback (kernel/bpf/helpers.c:4094=
)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? lock_release (kernel/locking/lockdep.c:470 (discriminat=
or 6) kernel/locking/lockdep.c:5891 (discriminator 6) kernel/locking/lockde=
p.c:5875 (discriminator 6))
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  task_work_run (kernel/task_work.c:229)
> [   11.791446]  ? __pfx_task_work_run (kernel/task_work.c:195)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? __irq_work_queue_local (kernel/irq_work.c:89)
> [   11.791446]  ? __pfx___irq_work_queue_local (kernel/irq_work.c:89)
> [   11.791446]  get_signal (kernel/signal.c:2807)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? irq_work_queue (kernel/irq_work.c:125 (discriminator 3)=
 kernel/irq_work.c:116 (discriminator 3))
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? bpf_task_work_schedule.isra.0 (kernel/bpf/helpers.c:426=
4)
> [   11.791446]  ? 0xffffffffc000071c
> [   11.791446]  ? __pfx_bpf_task_work_schedule.isra.0 (kernel/bpf/helpers=
.c:4229)
> [   11.791446]  ? __pfx_get_signal (kernel/signal.c:2800)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? __lock_acquire (kernel/locking/lockdep.c:4674 (discrimi=
nator 1) kernel/locking/lockdep.c:5191 (discriminator 1))
> [   11.791446]  arch_do_signal_or_restart (./arch/x86/include/asm/current=
.h:23 arch/x86/kernel/signal.c:258 arch/x86/kernel/signal.c:339)
> [   11.791446]  ? __pfx_arch_do_signal_or_restart (arch/x86/kernel/signal=
.c:334)
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discrimi=
nator 1))
> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   11.791446]  ? lock_release (kernel/locking/lockdep.c:470 (discriminat=
or 6) kernel/locking/lockdep.c:5891 (discriminator 6) kernel/locking/lockde=
p.c:5875 (discriminator 6))
> [   11.791446]  exit_to_user_mode_loop (kernel/entry/common.c:42)
> [   11.791446]  do_syscall_64 (./include/linux/irq-entry-common.h:225 ./i=
nclude/linux/entry-common.h:175 ./include/linux/entry-common.h:210 arch/x86=
/entry/syscall_64.c:100)
> [   11.791446]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S=
:130)
> [   11.791446] RIP: 0033:0x7fc6d58da89b
> [   11.791446] Code: 0f 1e fa b9 01 00 00 00 e9 b2 fc ff ff 66 90 f3 0f 1=
e fa 31 c9 e9 a5 fc ff ff 0f 1f 44 00 00 f3 0f 1e fa b8 27 00 00 00 0f 05 <=
c3> 0f 1f 40 00 f3 0f 1e fa b8 6e 00 00 00 0f 05 c3 0f 1f 40 00 f3
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 1e fa                nop    %edx
>    3:   b9 01 00 00 00          mov    $0x1,%ecx
>    8:   e9 b2 fc ff ff          jmp    0xfffffffffffffcbf
>    d:   66 90                   xchg   %ax,%ax
>    f:   f3 0f 1e fa             endbr64
>   13:   31 c9                   xor    %ecx,%ecx
>   15:   e9 a5 fc ff ff          jmp    0xfffffffffffffcbf
>   1a:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   1f:   f3 0f 1e fa             endbr64
>   23:   b8 27 00 00 00          mov    $0x27,%eax
>   28:   0f 05                   syscall
>   2a:*  c3                      ret             <-- trapping instruction
>   2b:   0f 1f 40 00             nopl   0x0(%rax)
>   2f:   f3 0f 1e fa             endbr64
>   33:   b8 6e 00 00 00          mov    $0x6e,%eax
>   38:   0f 05                   syscall
>   3a:   c3                      ret
>   3b:   0f 1f 40 00             nopl   0x0(%rax)
>   3f:   f3                      repz
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   c3                      ret
>    1:   0f 1f 40 00             nopl   0x0(%rax)
>    5:   f3 0f 1e fa             endbr64
>    9:   b8 6e 00 00 00          mov    $0x6e,%eax
>    e:   0f 05                   syscall
>   10:   c3                      ret
>   11:   0f 1f 40 00             nopl   0x0(%rax)
>   15:   f3                      repz
> [   11.791446] RSP: 002b:00007fffab903ff8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000027
> [   11.791446] RAX: 0000000000000099 RBX: 00007fc6d60b7000 RCX: 00007fc6d=
58da89b
> [   11.791446] RDX: 000000000000005f RSI: 00000000013d1c62 RDI: 00007fffa=
b903aa0
> [   11.791446] RBP: 00007fffab9042a0 R08: 0000000000000000 R09: 00007fffa=
b903ed7
> [   11.791446] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffa=
b9044f8
> [   11.791446] R13: 00000000007c2531 R14: 000000000334fd10 R15: 00007fc6d=
60f6000
> [   11.791446]  </TASK>
> #115/1   file_reader/on_getpid_expect_fault:OK
> #115/2   file_reader/on_getpid_validate_file_read:OK
> #115     file_reader:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> Powering off.
> [   11.946617] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [   11.948196] sd 0:0:0:0: [sda] Stopping disk

