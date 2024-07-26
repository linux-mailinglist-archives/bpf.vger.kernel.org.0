Return-Path: <bpf+bounces-35752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D61E93D8C6
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD76B221E6
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDD47A7C;
	Fri, 26 Jul 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="nAi6UCn5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66503BBC1
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020121; cv=none; b=CJc0dGQLBwqdS5dPQiKOISbjW4gRk0eOhd0uQPTUhGDaltrbdWNHOA2lNbT4o0UDizRO3Fqzp0x/cMro3fnIETdtE8NuAesNRrQi6VPqmsJSXj5W12N4k3gA9DopPiSvkjJBSlEimwiR2sPEysmTKM1FsWMfvPfn2/cJFpZu8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020121; c=relaxed/simple;
	bh=PkDlnlTjP9ZY7CTo3m7TSlcBpCk3/CS2nzBKOTCHUMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugpXkZqQcGUCvhs9QBZpbcyqWKDmWXWtBqE4a4cSuCzZE2GfAVXdqc7Q3biamPo5+OlxTu32SwyQv2Oeyg8PJSQu1iWNEwFyxH6wlXUjxDs5oykt0/J4WMbZYjvZlpkKHajpoBXGw0NWIi+qlyheMomkQc6D0j8buTsim7ks/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=nAi6UCn5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52fc14d6689so1746867e87.1
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1722020117; x=1722624917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaoQ14BAYtRfKBRkzdghDhSJThYDtXOdrUMLT9Mwibs=;
        b=nAi6UCn5dKCCqdPCJVZgqFZgJ4mOhhdcuSXFtDa1lQDlvo4H1GGsl3k74IO571JKCf
         euL2B+vEq7u5JU286MLkokQ/WuyvC9p9+zCug0ROl6SljBIBg6W97pTkKQnfWWXM2G7S
         1pSAdLAyMudm+woa/GEf3R/DwbMryweVW4n8HqbcDrISnb3Bf9z+wWGrAKdi+mAbC/rj
         loVXPb+rrIyqSkfCuEAml6fCb2GGmivuz65PMyZ0WJ08JqtFgNahw9wzWtubME7x8heL
         ya16YWV1BScXXe+s1S8DnkdQEs/aUxN6Mj8vDosQ1aqIlWVn7xJB5Gd1C+DxFuVuQAHe
         Vzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722020118; x=1722624918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaoQ14BAYtRfKBRkzdghDhSJThYDtXOdrUMLT9Mwibs=;
        b=Im6bvrx2WOd8BNC6iGVe/hcG3Gpt50Lb3QEGQppFpFOEimrrxWQhuaMqnO1n3Md//l
         70mVbnAckB1kMWMCZvm4Nst0KTJYhR6Bgk5uu8bEGISYZxyU7CQyy3rdm2v+cl94jIR1
         qFSyZL/ap/4QsyJASeu3htSOMmcVQgGlVepQBW9/ni+uWlSYJ9JKqzK8APgyWwjr2V7f
         NWo5xgXcTEP1+7kj7mZWHHIzACrlSthl1vzCx+7hMzszwO5+N2jMeGtPKwyaw8lh5IVU
         AE167NQPeFU5VRZnlXBMiBntF/ldwgFGX456drkKiHDQNHjbxyADGpjwZtShA8JROueI
         WxWw==
X-Forwarded-Encrypted: i=1; AJvYcCXJXaBUcWHNtGuAKELFGKFWqFl9WQfBxdHy9eDBlv8iYv8PHdcJ9ldXS5dQcs+A4VPBDdGdIPG8vyYj4C/ly+qmmjUZ
X-Gm-Message-State: AOJu0YwIdaDhLwF31Y9/1IBBwl+19RE1GQKLeS8OjKU2feqlYaaQ8aIt
	ANEvhDY3qwMUZhEj0ahIe+4Jxe+pkotqJQfKIHMfDaL87MsjX5oQVV2cPcORAg4QQmAeW7MbyaW
	T6lOHeIHfYYNrz84gWVLPUA6SMFQv6gUp6EAKsg==
X-Google-Smtp-Source: AGHT+IFWKh3Ud1K+JbfBmSqIvQ8gvHKKJ+cyAzo/S4t2D+KZUL7oT5ch+r0a1iYdGoPymmekXSVfzhVLCG/Frovz5+g=
X-Received: by 2002:ac2:5923:0:b0:52c:a0b8:4dc0 with SMTP id
 2adb3069b0e04-5309b27b0bdmr468497e87.28.1722020117480; Fri, 26 Jul 2024
 11:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2YS1P09GWT6kQ@mail.gmail.com>
 <CAADnVQJad1uWLh7uN47qYv9eBQZgo_PMP8s30Ae49dsqtGU40w@mail.gmail.com>
In-Reply-To: <CAADnVQJad1uWLh7uN47qYv9eBQZgo_PMP8s30Ae49dsqtGU40w@mail.gmail.com>
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 26 Jul 2024 11:55:06 -0700
Message-ID: <CAPPBnEYUcNJLYyXVk3hyk+_oO8LTD8nxA=riX4am0WLoL62yEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/bpf_lru_list: make bpf_percpu_lru_pop_free
 safe in NMI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Hsin-Wei Hung <hsinweih@uci.edu>, Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is the lockdep splat:
[ 1051.101034] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1051.101037] WARNING: inconsistent lock state
[ 1051.101040] 6.7.0-dirty #14 Not tainted
[ 1051.101048] --------------------------------
[ 1051.101051] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[ 1051.101056] lru_percpu_perf/1263 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 1051.101071] ffffe8fffc22cdd8 (&l->lock){....}-{2:2}, at:
bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101129] {INITIAL USE} state was registered at:
[ 1051.101134]   lock_acquire+0x193/0x4c0
[ 1051.101153]   _raw_spin_lock_irqsave+0x3f/0x90
[ 1051.101167]   bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101179]   __htab_lru_percpu_map_update_elem+0x177/0xa20
[ 1051.101197]   bpf_prog_47d4157ca618f90f_lru_tp+0x61/0x8a
[ 1051.101215]   trace_call_bpf+0x273/0x920
[ 1051.101229]   perf_trace_run_bpf_submit+0x8f/0x1c0
[ 1051.101243]   perf_trace_sched_switch+0x5c9/0x9c0
[ 1051.101255]   __traceiter_sched_switch+0x6f/0xc0
[ 1051.101268]   __schedule+0xae0/0x2ae0
[ 1051.101282]   schedule+0xe6/0x270
[ 1051.101295]   exit_to_user_mode_prepare+0x97/0x190
[ 1051.101314]   irqentry_exit_to_user_mode+0xa/0x30
[ 1051.101331]   asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1051.101344] irq event stamp: 39528
[ 1051.101348] hardirqs last  enabled at (39527): [<ffffffff8480144a>]
asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1051.101365] hardirqs last disabled at (39528): [<ffffffff8478ca89>]
exc_nmi+0x159/0x200
[ 1051.101380] softirqs last  enabled at (39526): [<ffffffff847b5541>]
__do_softirq+0x4e1/0x73e
[ 1051.101399] softirqs last disabled at (39519): [<ffffffff811ab473>]
irq_exit_rcu+0x93/0xc0
[ 1051.101415]
[ 1051.101415] other info that might help us debug this:
[ 1051.101418]  Possible unsafe locking scenario:
[ 1051.101418]
[ 1051.101420]        CPU0
[ 1051.101422]        ----
[ 1051.101424]   lock(&l->lock);
[ 1051.101430]   <Interrupt>
[ 1051.101432]     lock(&l->lock);
[ 1051.101438]
[ 1051.101438]  *** DEADLOCK ***
[ 1051.101438]
[ 1051.101440] no locks held by lru_percpu_perf/1263.
[ 1051.101446]
[ 1051.101446] stack backtrace:
[ 1051.101452] CPU: 1 PID: 1263 Comm: lru_percpu_perf Not tainted
6.7.0-dirty #14
[ 1051.101466] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[ 1051.101474] Call Trace:
[ 1051.101482]  <TASK>
[ 1051.101488]  dump_stack_lvl+0x91/0xf0
[ 1051.101514]  lock_acquire+0x35b/0x4c0
[ 1051.101534]  ? __pfx_lock_acquire+0x10/0x10
[ 1051.101553]  ? bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101568]  ? trace_event_raw_event_bpf_trace_printk+0x14a/0x210
[ 1051.101584]  ? __pfx_trace_event_raw_event_bpf_trace_printk+0x10/0x10
[ 1051.101599]  ? bstr_printf+0x348/0xf40
[ 1051.101621]  _raw_spin_lock_irqsave+0x3f/0x90
[ 1051.101636]  ? bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101650]  bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101666]  ? trace_bpf_trace_printk+0x11d/0x140
[ 1051.101679]  ? bpf_bprintf_cleanup+0x66/0xd0
[ 1051.101693]  ? htab_map_hash+0x18e/0x880
[ 1051.101709]  __htab_lru_percpu_map_update_elem+0x177/0xa20
[ 1051.101734]  bpf_prog_af2271334a1c4e36_lru_percpu_perf+0x5d/0x61
[ 1051.101750]  bpf_overflow_handler+0x184/0x4a0
[ 1051.101765]  ? __pfx_bpf_overflow_handler+0x10/0x10
[ 1051.101786]  __perf_event_overflow+0x4c2/0x9e0
[ 1051.101806]  handle_pmi_common+0x4d7/0x800
[ 1051.101823]  ? __lock_acquire+0x150a/0x3b10
[ 1051.101845]  ? __pfx_handle_pmi_common+0x10/0x10
[ 1051.101867]  ? hlock_class+0x4e/0x140
[ 1051.101881]  ? lock_release+0x587/0xaa0
[ 1051.101901]  ? __pfx_lock_release+0x10/0x10
[ 1051.101920]  ? lock_is_held_type+0xa1/0x120
[ 1051.101939]  ? rcu_gpnum_ovf+0x12d/0x180
[ 1051.101958]  ? lockdep_hardirqs_on_prepare+0x12d/0x400
[ 1051.101980]  ? look_up_lock_class+0x56/0x140
[ 1051.101998]  ? lock_acquire+0x272/0x4c0
[ 1051.102016]  ? intel_bts_interrupt+0x115/0x3e0
[ 1051.102036]  intel_pmu_handle_irq+0x246/0xd90
[ 1051.102058]  perf_event_nmi_handler+0x4c/0x70
[ 1051.102073]  nmi_handle+0x1a6/0x520
[ 1051.102096]  default_do_nmi+0x64/0x1c0
[ 1051.102112]  exc_nmi+0x187/0x200
[ 1051.102126]  asm_exc_nmi+0xb6/0xff
[ 1051.102139] RIP: 0033:0x555fd93d960b
[ 1051.102150] Code: ff ff ff ff 48 8b 05 54 9a 04 00 48 89 c1 ba 2f
00 00 00 be 01 00 00 00 48 8d 05 f8 1b 03 00 48 89 c7 e8 d8 f6 ff ff
eb 10 90 <0f> b6 05 37 9a 04 00 83 f0 01 84 c0 75 f2 90 48 83 bd 08 fe
ff ff
[ 1051.102162] RSP: 002b:00007ffe81a6f6e0 EFLAGS: 00000202
[ 1051.102178] RAX: 0000000000000001 RBX: 0000555fdac9eee8 RCX: 00000000000=
00000
[ 1051.102187] RDX: 0000000555fdac9e RSI: 0000555fdac9d010 RDI: 00000000000=
00007
[ 1051.102196] RBP: 00007ffe81a6f910 R08: 0000555fdac9ee10 R09: 00000004dac=
9d2e0
[ 1051.102204] R10: 0000000000000000 R11: 08e02bbb6d91ca99 R12: 00007ffe81a=
6fa28
[ 1051.102213] R13: 0000555fd93d9084 R14: 0000555fd94209d8 R15: 00007fad2f4=
8a040
[ 1051.102231]  </TASK>

The initial bug report with a POC to trigger the lockdep warning is
available here:
https://lore.kernel.org/bpf/CAPPBnEYv7kmVnFurrtgBzTzcpA8MiGFdWVSfD-ZAx2SK_6=
67XQ@mail.gmail.com/

The static analysis tool we are developing has reported three similar
locking issues of raw_spin_lock_irqsave that can be taken in NMI
context in bpf_lru_list.c. They are in the functions
bpf_common_lru_pop_free, bpf_percpu_lru_push_free, and
bpf_common_lru_push_free. htab_lock_bucket does not help to protect
these functions because they are called either before the bucket lock
in htab_lock_bucket is taken, or after it is released.

Additionally, it seems like htab_lock_bucket may return EBUSY to
prevent multiple processes on the same CPU from accessing the same
hash bucket. Isn't that similar to what this patch would do? In this
case, __htab_lru_percpu_map_update_elem will return early with ENOMEM.

On Mon, Jul 22, 2024 at 5:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 17, 2024 at 6:44=E2=80=AFPM Priya Bala Govindasamy <pgovind2@=
uci.edu> wrote:
> >
> > bpf_percpu_lru_pop_free uses raw_spin_lock_irqsave. This function is
> > used by htab_percpu_lru_map_update_elem() which can be called from an
> > NMI. A deadlock can happen if a bpf program holding the lock is
> > interrupted by the same program in NMI. Use raw_spin_trylock_irqsave if
> > in NMI.
>
> And there is a htab_lock_bucket() protection and bpf prog
> recursion protection logic that should prevent such deadlock.
>
> Pls share the splat if this deadlock is real.
>
> > -       raw_spin_lock_irqsave(&l->lock, flags);
> > +       if (in_nmi()) {
> > +               if (!raw_spin_trylock_irqsave(&l->lock, flags))
> > +                       return NULL;
> > +       } else {
> > +               raw_spin_lock_irqsave(&l->lock, flags);
> > +       }
>
> We cannot do this, since it will make map behavior 'random'.
> There are lots of other raw_spin_lock_irqsave() in that file.
> Somehow they're not deadlocking?
>
> pw-bot: cr

